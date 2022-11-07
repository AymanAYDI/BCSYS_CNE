codeunit 50022 "Creat Auto Cde Achat"
{
    // //>> CNEIC : 06/2015 : Création des commandes d'achat suivant les commandes ventes.

    TableNo = 36;

    trigger OnRun()
    begin
        RecGInfoSoc.FINDFIRST;
        IF RecGInfoSoc."Branch Company" = FALSE THEN EXIT;

        IF GUIALLOWED THEN
            DialogG.OPEN(Text0001);

        // Il ne faut qu'un seul partenaire IC.
        RecGPartnerIC.RESET;
        IF RecGPartnerIC.COUNT <> 1 THEN BEGIN
            ERROR(Text0002);
        END;

        RecGPartnerIC.FINDFIRST;

        // Recherche du fournisseur pour ce partenaire IC.
        RecGVendor.RESET;
        RecGVendor.SETRANGE("IC Partner Code", RecGPartnerIC.Code);
        RecGVendor.FINDFIRST;


        RESET;
        SETFILTER("Purchase No. Order Lien", '= %1', '');
        SETRANGE(Status, Status::Released);
        SETRANGE("Document Type", "Document Type"::Order);

        // 1 commande vente = 1 commande d'achat
        IF FIND('-') THEN
            REPEAT

                // Création de l'entête de commande Achat
                RecGPurchaseHeader.INIT;
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

                RecGPurchaseHeader."Sales No. Order Lien" := "No.";
                RecGPurchaseHeader.MODIFY;

                IntGNextLineNo := 10000;


                IF GUIALLOWED THEN BEGIN
                    DialogG.UPDATE(1, RecGVendor."No.");
                    DialogG.UPDATE(2, "Sell-to Customer No.");
                END;

                // Recherche des lignes de la commande de vente.
                RecGSalesLines.RESET;
                RecGSalesLines.SETRANGE("Document Type", "Document Type");
                RecGSalesLines.SETRANGE("Document No.", "No.");
                RecGSalesLines.SETFILTER("Outstanding Quantity", '<>0');
                RecGSalesLines.SETRANGE(Type, RecGSalesLines.Type::Item);
                RecGSalesLines.SETFILTER("No.", '<>%1', '');

                IF RecGSalesLines.FIND('-') THEN
                    REPEAT
                        RecGPurchaseLine.INIT;
                        RecGPurchaseLine."Document Type" := RecGPurchaseLine."Document Type"::Order;
                        RecGPurchaseLine."Document No." := RecGPurchaseHeader."No.";
                        RecGPurchaseLine."Line No." := IntGNextLineNo;
                        RecGPurchaseLine.Type := RecGPurchaseLine.Type::Item;
                        RecGPurchaseLine.VALIDATE("No.", RecGSalesLines."No.");
                        RecGPurchaseLine.VALIDATE(Quantity, RecGSalesLines.Quantity);
                        RecGPurchaseLine.Description := RecGSalesLines.Description;
                        RecGPurchaseLine."Description 2" := RecGSalesLines."Description 2";

                        //Lien avec la ligne de la commande de vente
                        RecGPurchaseLine."Sales No. Order Lien" := RecGSalesLines."Document No.";
                        RecGPurchaseLine."Sales No. Line Lien" := RecGSalesLines."Line No.";
                        RecGPurchaseLine.VALIDATE(RecGPurchaseLine."Direct Unit Cost", RecGSalesLines."Purchase cost");

                        RecGPurchaseLine.INSERT;

                        IntGNextLineNo := IntGNextLineNo + 10000;

                        //Lien avec la ligne de la commande d'achat
                        RecGSalesLines."Purchase No. Order Lien" := RecGPurchaseLine."Document No.";
                        RecGSalesLines."Purchase No. Line Lien" := RecGPurchaseLine."Line No.";
                        RecGSalesLines.MODIFY;

                    UNTIL RecGSalesLines.NEXT <= 0;

                //Lien avec la commande d'achat
                RecGSalesHeader2.GET("Document Type", "No.");
                RecGSalesHeader2."Purchase No. Order Lien" := RecGPurchaseHeader."No.";
                RecGSalesHeader2.MODIFY;

                // Commande Achat lancée
                CuGReleasePurchDoc.PerformManualRelease(RecGPurchaseHeader);

                // Envoi de la commande achat dans la boite d'envoie
                //MIG 2017 >>
                //IF CuGApprovalMgt.PrePostApprovalCheck(RecGSalesHeader,RecGPurchaseHeader) THEN*
                IF CuGApprovalMgt.PrePostApprovalCheckSales(RecGSalesHeader) THEN
                    IF CuGApprovalMgt.PrePostApprovalCheckPurch(RecGPurchaseHeader) THEN
                        //MIG 2017 <<

                        CuGICInOutboxMgt.SendPurchDoc(RecGPurchaseHeader, FALSE);

            UNTIL NEXT <= 0;

        IF GUIALLOWED THEN
            DialogG.CLOSE;
    end;

    var
        RecGPartnerIC: Record "413";
        RecGVendor: Record "23";
        RecGSalesLines: Record "37";
        RecGSalesHeader2: Record "36";
        RecGPurchaseHeader: Record "38";
        RecGPurchaseLine: Record "39";
        RecGInfoSoc: Record "79";
        IntGNextLineNo: Integer;
        DialogG: Dialog;
        Text0001: Label 'Création Commandes Achats : #1##################/#2##################';
        Text0002: Label 'Unable only one partner IC';
        CuGICInOutboxMgt: Codeunit "427";
        RecGSalesHeader: Record "36";
        CuGApprovalMgt: Codeunit "1535";
        CuGReleasePurchDoc: Codeunit "415";
}

