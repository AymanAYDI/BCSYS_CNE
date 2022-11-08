codeunit 50022 "BC6_Creat Auto Cde Achat"
{
    TableNo = "Sales Header";

    trigger OnRun()
    begin
        RecGInfoSoc.FINDFIRST();
        IF RecGInfoSoc."BC6_Branch Company" = FALSE THEN EXIT;

        IF GUIALLOWED THEN
            DialogG.OPEN(Text0001);

        RecGPartnerIC.RESET();
        IF RecGPartnerIC.COUNT <> 1 THEN
            ERROR(Text0002);


        RecGPartnerIC.FINDFIRST();

        RecGVendor.RESET();
        RecGVendor.SETRANGE("IC Partner Code", RecGPartnerIC.Code);
        RecGVendor.FINDFIRST();


        RESET();
        SETFILTER("BC6_Purchase No. Order Lien", '= %1', '');
        SETRANGE(Status, Status::Released);
        SETRANGE("Document Type", "Document Type"::Order);

        IF FIND('-') THEN
            REPEAT

                RecGPurchaseHeader.INIT();
                RecGPurchaseHeader."Document Type" := RecGPurchaseHeader."Document Type"::Order;
                RecGPurchaseHeader."No." := '';
                RecGPurchaseHeader.INSERT(TRUE);

                RecGPurchaseHeader.VALIDATE("Posting Date", TODAY);
                RecGPurchaseHeader.VALIDATE("Buy-from Vendor No.", RecGVendor."No.");
                RecGPurchaseHeader.VALIDATE("Sell-to Customer No.", "Sell-to Customer No.");
                RecGPurchaseHeader.VALIDATE("Requested Receipt Date", "Requested Delivery Date");
                //>>PDW : le 13/07/2015 : prise en compte de la réf client.
                //RecGPurchaseHeader.VALIDATE("Your Reference","No.");
                RecGPurchaseHeader.VALIDATE("Your Reference", "Your Reference");
                //<<PDW : le 13/07/2015

                // Reprise de l'adresse de livraison
                RecGPurchaseHeader."Ship-to Name" := "Ship-to Name";
                RecGPurchaseHeader."Ship-to Name 2" := "Ship-to Name 2";
                RecGPurchaseHeader."Ship-to Address" := "Ship-to Address";
                RecGPurchaseHeader."Ship-to Address 2" := "Ship-to Address 2";
                RecGPurchaseHeader."Ship-to City" := "Ship-to City";
                RecGPurchaseHeader."Ship-to Contact" := "Ship-to Contact";
                RecGPurchaseHeader."Ship-to Post Code" := "Ship-to Post Code";
                RecGPurchaseHeader."Ship-to County" := "Ship-to County";
                RecGPurchaseHeader."Ship-to Country/Region Code" := "Ship-to Country/Region Code";

                RecGPurchaseHeader."BC6_Sales No. Order Lien" := "No.";
                RecGPurchaseHeader.MODIFY();

                IntGNextLineNo := 10000;


                IF GUIALLOWED THEN BEGIN
                    DialogG.UPDATE(1, RecGVendor."No.");
                    DialogG.UPDATE(2, "Sell-to Customer No.");
                END;

                RecGSalesLines.RESET();
                RecGSalesLines.SETRANGE("Document Type", "Document Type");
                RecGSalesLines.SETRANGE("Document No.", "No.");
                RecGSalesLines.SETFILTER("Outstanding Quantity", '<>0');
                RecGSalesLines.SETRANGE(Type, RecGSalesLines.Type::Item);
                RecGSalesLines.SETFILTER("No.", '<>%1', '');

                IF RecGSalesLines.FIND('-') THEN
                    REPEAT
                        RecGPurchaseLine.INIT();
                        RecGPurchaseLine."Document Type" := RecGPurchaseLine."Document Type"::Order;
                        RecGPurchaseLine."Document No." := RecGPurchaseHeader."No.";
                        RecGPurchaseLine."Line No." := IntGNextLineNo;
                        RecGPurchaseLine.Type := RecGPurchaseLine.Type::Item;
                        RecGPurchaseLine.VALIDATE("No.", RecGSalesLines."No.");
                        RecGPurchaseLine.VALIDATE(Quantity, RecGSalesLines.Quantity);
                        RecGPurchaseLine.Description := RecGSalesLines.Description;
                        RecGPurchaseLine."Description 2" := RecGSalesLines."Description 2";
                        RecGPurchaseLine."BC6_Sales No. Order Lien" := RecGSalesLines."Document No.";
                        RecGPurchaseLine."BC6_Sales No. Line Lien" := RecGSalesLines."Line No.";
                        RecGPurchaseLine.VALIDATE(RecGPurchaseLine."Direct Unit Cost", RecGSalesLines."BC6_Purchase cost");

                        RecGPurchaseLine.INSERT();

                        IntGNextLineNo := IntGNextLineNo + 10000;

                        RecGSalesLines."BC6_Purchase No. Order Lien" := RecGPurchaseLine."Document No.";
                        RecGSalesLines."BC6_Purchase No. Line Lien" := RecGPurchaseLine."Line No.";
                        RecGSalesLines.MODIFY();

                    UNTIL RecGSalesLines.NEXT() <= 0;

                RecGSalesHeader2.GET("Document Type", "No.");
                RecGSalesHeader2."BC6_Purchase No. Order Lien" := RecGPurchaseHeader."No.";
                RecGSalesHeader2.MODIFY();

                CuGReleasePurchDoc.PerformManualRelease(RecGPurchaseHeader);
                IF CuGApprovalMgt.PrePostApprovalCheckSales(RecGSalesHeader) THEN
                    IF CuGApprovalMgt.PrePostApprovalCheckPurch(RecGPurchaseHeader) THEN
                        CuGICInOutboxMgt.SendPurchDoc(RecGPurchaseHeader, FALSE);

            UNTIL NEXT() <= 0;

        IF GUIALLOWED THEN
            DialogG.CLOSE();
    end;

    var
        RecGPartnerIC: Record "IC Partner";
        RecGVendor: Record Vendor;
        RecGSalesLines: Record "Sales Line";
        RecGSalesHeader2: Record "Sales Header";
        RecGPurchaseHeader: Record "Purchase Header";
        RecGPurchaseLine: Record "Purchase Line";
        RecGInfoSoc: Record "Company Information";
        IntGNextLineNo: Integer;
        DialogG: Dialog;
        Text0001: Label 'Création Commandes Achats : #1##################/#2##################';
        Text0002: Label 'Unable only one partner IC';
        CuGICInOutboxMgt: Codeunit ICInboxOutboxMgt;
        RecGSalesHeader: Record "Sales Header";
        CuGApprovalMgt: Codeunit "Approvals Mgmt.";
        CuGReleasePurchDoc: Codeunit "Release Purchase Document";
}

