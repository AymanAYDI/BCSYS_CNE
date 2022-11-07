codeunit 50059 "Delete Order Documents"
{
    // MGTS10.038 :  25.08.2022  Create codeunit


    trigger OnRun()
    begin
    end;

    var
        ConfirmationMsg: Label 'Are you sure you want to delete the sales order: %1 ?';
        FinishMsg: Label 'Treatment finished !';
        ProgressMsg: Label 'Delete in progress...';
        Window: Dialog;
        StopDeleteErr: Label 'Cannot delete order %1.';

    [Scope('Internal')]
    procedure DeleteOrdersDocuments(SalesOrderHeader: Record "36")
    var
        SalesOrderLine: Record "37";
        TempPurchOrderHeader: Record "38" temporary;
        PurchaseHeader: Record "38";
    begin
        IF NOT CONFIRM(ConfirmationMsg, FALSE, SalesOrderHeader."No.") THEN
            EXIT;

        Window.OPEN(ProgressMsg);

        //Récupérer l'ensemble des commandes d'achat liées à la commande de vente
        SalesOrderLine.SETRANGE("Document Type", SalesOrderHeader."Document Type");
        SalesOrderLine.SETRANGE("Document No.", SalesOrderHeader."No.");
        SalesOrderLine.SETFILTER("Special Order Purchase No.", '<>''''');
        IF NOT SalesOrderLine.ISEMPTY THEN BEGIN
            SalesOrderLine.FINDSET;
            REPEAT
                TempPurchOrderHeader.RESET;
                TempPurchOrderHeader.SETRANGE("Document Type", TempPurchOrderHeader."Document Type"::Order);
                TempPurchOrderHeader.SETRANGE("No.", SalesOrderLine."Special Order Purchase No.");
                IF NOT TempPurchOrderHeader.FINDFIRST THEN BEGIN
                    TempPurchOrderHeader."Document Type" := TempPurchOrderHeader."Document Type"::Order;
                    TempPurchOrderHeader."No." := SalesOrderLine."Special Order Purchase No.";
                    TempPurchOrderHeader.INSERT;
                END;
            UNTIL SalesOrderLine.NEXT = 0;
        END;

        //Suppression de la commande de vente
        IF NOT DeleteSalesOrder(SalesOrderHeader) THEN
            ERROR(StopDeleteErr, SalesOrderHeader."No.");

        //Suppression des commandes d'achat
        TempPurchOrderHeader.RESET;
        IF NOT TempPurchOrderHeader.ISEMPTY THEN
            TempPurchOrderHeader.FINDSET;
        REPEAT
            IF PurchaseHeader.GET(TempPurchOrderHeader."Document Type", TempPurchOrderHeader."No.") THEN
                IF NOT DeletePurchaseOrder(PurchaseHeader) THEN
                    ERROR(StopDeleteErr, PurchaseHeader."No.");
        UNTIL TempPurchOrderHeader.NEXT = 0;

        Window.CLOSE;
        MESSAGE(FinishMsg);
    end;

    local procedure DeleteSalesOrder(var SalesOrderHeader: Record "36"): Boolean
    var
        SalesOrderLine: Record "37";
        SalesShptHeader: Record "110";
        SalesInvHeader: Record "112";
        SalesCrMemoHeader: Record "114";
        ReturnRcptHeader: Record "6660";
        PrepmtSalesInvHeader: Record "112";
        PrepmtSalesCrMemoHeader: Record "114";
        SalesCommentLine: Record "44";
        ItemChargeAssgntSales: Record "5809";
        WhseRequest: Record "5765";
        AllLinesDeleted: Boolean;
        SalesSetup: Record "311";
        ArchiveManagement: Codeunit "5063";
        ATOLink: Record "904";
        ReserveSalesLine: Codeunit "99000832";
        ApprovalsMgmt: Codeunit "1535";
        PostSalesDelete: Codeunit "363";
    begin
        WITH SalesOrderHeader DO BEGIN
            AllLinesDeleted := TRUE;
            ItemChargeAssgntSales.RESET;
            ItemChargeAssgntSales.SETRANGE("Document Type", "Document Type");
            ItemChargeAssgntSales.SETRANGE("Document No.", "No.");
            SalesOrderLine.RESET;
            SalesOrderLine.SETRANGE("Document Type", "Document Type");
            SalesOrderLine.SETRANGE("Document No.", "No.");
            SalesOrderLine.SETFILTER("Quantity Invoiced", '<>0');
            IF SalesOrderLine.FINDFIRST THEN BEGIN
                SalesOrderLine.SETRANGE("Quantity Invoiced");
                //SalesOrderLine.SETFILTER("Outstanding Quantity",'<>0');
                //IF NOT SalesOrderLine.FINDFIRST THEN BEGIN
                //  SalesOrderLine.SETRANGE("Outstanding Quantity");
                SalesOrderLine.SETFILTER("Qty. Shipped Not Invoiced", '<>0');
                IF NOT SalesOrderLine.FINDFIRST THEN BEGIN
                    SalesOrderLine.LOCKTABLE;
                    IF NOT SalesOrderLine.FINDFIRST THEN BEGIN
                        SalesOrderLine.SETRANGE("Qty. Shipped Not Invoiced");

                        SalesSetup.GET;
                        IF SalesSetup."Arch. Orders and Ret. Orders" THEN
                            ArchiveManagement.ArchSalesDocumentNoConfirm(SalesOrderHeader);

                        IF SalesOrderLine.FIND('-') THEN
                            REPEAT
                                SalesOrderLine.CALCFIELDS("Qty. Assigned");
                                IF (SalesOrderLine."Qty. Assigned" = SalesOrderLine."Quantity Invoiced") OR
                                   (SalesOrderLine.Type <> SalesOrderLine.Type::"Charge (Item)")
                                THEN BEGIN
                                    IF SalesOrderLine.Type = SalesOrderLine.Type::"Charge (Item)" THEN BEGIN
                                        ItemChargeAssgntSales.SETRANGE("Document Line No.", SalesOrderLine."Line No.");
                                        ItemChargeAssgntSales.DELETEALL;
                                    END;
                                    IF SalesOrderLine.Type = SalesOrderLine.Type::Item THEN
                                        ATOLink.DeleteAsmFromSalesLine(SalesOrderLine);
                                    IF SalesOrderLine.HASLINKS THEN
                                        SalesOrderLine.DELETELINKS;
                                    SalesOrderLine.DELETE;
                                END ELSE
                                    AllLinesDeleted := FALSE;
                            UNTIL SalesOrderLine.NEXT = 0;

                        IF AllLinesDeleted THEN BEGIN
                            PostSalesDelete.DeleteHeader(
                              SalesOrderHeader, SalesShptHeader, SalesInvHeader, SalesCrMemoHeader, ReturnRcptHeader,
                              PrepmtSalesInvHeader, PrepmtSalesCrMemoHeader);

                            ReserveSalesLine.DeleteInvoiceSpecFromHeader(SalesOrderHeader);

                            SalesCommentLine.SETRANGE("Document Type", "Document Type");
                            SalesCommentLine.SETRANGE("No.", "No.");
                            SalesCommentLine.DELETEALL;

                            WhseRequest.SETRANGE("Source Type", DATABASE::"Sales Line");
                            WhseRequest.SETRANGE("Source Subtype", "Document Type");
                            WhseRequest.SETRANGE("Source No.", "No.");
                            IF NOT WhseRequest.ISEMPTY THEN
                                WhseRequest.DELETEALL(TRUE);

                            ApprovalsMgmt.DeleteApprovalEntries(RECORDID);

                            IF HASLINKS THEN
                                DELETELINKS;
                            DELETE;
                            EXIT(TRUE);
                        END;
                    END;
                    //END;
                END;
            END;
        END;
    end;

    local procedure DeletePurchaseOrder(var PurchOrderHeader: Record "38"): Boolean
    var
        PurchLine: Record "39";
        PurchRcptHeader: Record "120";
        PurchInvHeader: Record "122";
        PurchCrMemoHeader: Record "124";
        ReturnShptHeader: Record "6650";
        PrepmtPurchInvHeader: Record "122";
        PrepmtPurchCrMemoHeader: Record "124";
        PurchCommentLine: Record "43";
        ItemChargeAssgntPurch: Record "5805";
        WhseRequest: Record "5765";
        AllLinesDeleted: Boolean;
        PurchSetup: Record "312";
        ArchiveManagement: Codeunit "5063";
        ReservePurchLine: Codeunit "99000834";
        ApprovalsMgmt: Codeunit "1535";
        PostPurchDelete: Codeunit "364";
    begin
        WITH PurchOrderHeader DO BEGIN
            AllLinesDeleted := TRUE;
            ItemChargeAssgntPurch.RESET;
            ItemChargeAssgntPurch.SETRANGE("Document Type", "Document Type");
            ItemChargeAssgntPurch.SETRANGE("Document No.", "No.");
            PurchLine.RESET;
            PurchLine.SETRANGE("Document Type", "Document Type");
            PurchLine.SETRANGE("Document No.", "No.");
            PurchLine.SETFILTER("Quantity Invoiced", '<>0');
            IF PurchLine.FIND('-') THEN BEGIN
                PurchLine.SETRANGE("Quantity Invoiced");
                //PurchLine.SETFILTER("Outstanding Quantity",'<>0');
                //IF NOT PurchLine.FIND('-') THEN BEGIN
                //  PurchLine.SETRANGE("Outstanding Quantity");
                PurchLine.SETFILTER("Qty. Rcd. Not Invoiced", '<>0');
                IF NOT PurchLine.FIND('-') THEN BEGIN
                    PurchLine.LOCKTABLE;
                    IF NOT PurchLine.FIND('-') THEN BEGIN
                        PurchLine.SETRANGE("Qty. Rcd. Not Invoiced");

                        PurchSetup.GET;
                        IF PurchSetup."Arch. Orders and Ret. Orders" THEN
                            ArchiveManagement.ArchPurchDocumentNoConfirm(PurchOrderHeader);

                        IF PurchLine.FIND('-') THEN
                            REPEAT
                                PurchLine.CALCFIELDS("Qty. Assigned");
                                IF (PurchLine."Qty. Assigned" = PurchLine."Quantity Invoiced") OR
                                   (PurchLine.Type <> PurchLine.Type::"Charge (Item)")
                                THEN BEGIN
                                    IF PurchLine.Type = PurchLine.Type::"Charge (Item)" THEN BEGIN
                                        ItemChargeAssgntPurch.SETRANGE("Document Line No.", PurchLine."Line No.");
                                        ItemChargeAssgntPurch.DELETEALL;
                                    END;
                                    IF PurchLine.HASLINKS THEN
                                        PurchLine.DELETELINKS;

                                    PurchLine.DELETE;
                                END ELSE
                                    AllLinesDeleted := FALSE;
                            UNTIL PurchLine.NEXT = 0;

                        IF AllLinesDeleted THEN BEGIN
                            PostPurchDelete.DeleteHeader(
                              PurchOrderHeader, PurchRcptHeader, PurchInvHeader, PurchCrMemoHeader,
                              ReturnShptHeader, PrepmtPurchInvHeader, PrepmtPurchCrMemoHeader);

                            ReservePurchLine.DeleteInvoiceSpecFromHeader(PurchOrderHeader);

                            PurchCommentLine.SETRANGE("Document Type", "Document Type");
                            PurchCommentLine.SETRANGE("No.", "No.");
                            PurchCommentLine.DELETEALL;

                            WhseRequest.SETRANGE("Source Type", DATABASE::"Purchase Line");
                            WhseRequest.SETRANGE("Source Subtype", "Document Type");
                            WhseRequest.SETRANGE("Source No.", "No.");
                            IF NOT WhseRequest.ISEMPTY THEN
                                WhseRequest.DELETEALL(TRUE);

                            ApprovalsMgmt.DeleteApprovalEntries(RECORDID);

                            IF HASLINKS THEN
                                DELETELINKS;

                            DELETE;
                            EXIT(TRUE);
                        END;
                    END;
                END;
                //END;
            END;
        END;
    end;
}

