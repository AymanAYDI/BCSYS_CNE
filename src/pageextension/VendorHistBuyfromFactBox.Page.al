page 9095 "Vendor Hist. Buy-from FactBox"
{
    Caption = 'Buy-from Vendor History';
    PageType = CardPart;
    SourceTable = Table23;

    layout
    {
        area(content)
        {
            field("No."; "No.")
            {
                Caption = 'Vendor No.';

                trigger OnDrillDown()
                begin
                    ShowDetails;
                end;
            }
            field(NoOfQuotes; NoOfQuotes)
            {
                Caption = 'Quotes';
                DrillDown = true;
                Editable = true;

                trigger OnDrillDown()
                var
                    PurchHdr: Record "38";
                    PurchaseQuotes: Page "9306";
                begin
                    PurchHdr.SETRANGE("Buy-from Vendor No.", "No.");
                    PurchaseQuotes.SETTABLEVIEW(PurchHdr);
                    PurchaseQuotes.RUN;
                end;
            }
            field(NoOfBlanketOrders; NoOfBlanketOrders)
            {
                Caption = 'Blanket Orders';
                DrillDown = true;
                Editable = true;

                trigger OnDrillDown()
                var
                    PurchHdr: Record "38";
                begin
                    PurchHdr.SETRANGE("Buy-from Vendor No.", "No.");
                    PAGE.RUN(PAGE::"Blanket Purchase Orders", PurchHdr);
                end;
            }
            field(NoOfOrders; NoOfOrders)
            {
                Caption = 'Orders';
                DrillDown = true;
                Editable = true;

                trigger OnDrillDown()
                var
                    PurchHdr: Record "38";
                    PurchaseOrderList: Page "9307";
                begin
                    PurchHdr.SETRANGE("Buy-from Vendor No.", "No.");
                    PurchaseOrderList.SETTABLEVIEW(PurchHdr);
                    PurchaseOrderList.RUN;
                end;
            }
            field(NoOfInvoices; NoOfInvoices)
            {
                Caption = 'Invoices';
                DrillDown = true;
                Editable = true;

                trigger OnDrillDown()
                var
                    PurchHdr: Record "38";
                    PurchaseInvoices: Page "9308";
                begin
                    PurchHdr.SETRANGE("Buy-from Vendor No.", "No.");
                    PurchaseInvoices.SETTABLEVIEW(PurchHdr);
                    PurchaseInvoices.RUN;
                end;
            }
            field(NoOfReturnOrders; NoOfReturnOrders)
            {
                Caption = 'Return Orders';
                DrillDown = true;
                Editable = true;

                trigger OnDrillDown()
                var
                    PurchHdr: Record "38";
                    PurchaseReturnOrderList: Page "9311";
                begin
                    PurchHdr.SETRANGE("Buy-from Vendor No.", "No.");
                    PurchaseReturnOrderList.SETTABLEVIEW(PurchHdr);
                    PurchaseReturnOrderList.RUN;
                end;
            }
            field(NoOfCreditMemos; NoOfCreditMemos)
            {
                Caption = 'Credit Memos';
                DrillDown = true;
                Editable = true;

                trigger OnDrillDown()
                var
                    PurchHdr: Record "38";
                    PurchaseCreditMemos: Page "9309";
                begin
                    PurchHdr.SETRANGE("Buy-from Vendor No.", "No.");
                    PurchaseCreditMemos.SETTABLEVIEW(PurchHdr);
                    PurchaseCreditMemos.RUN;
                end;
            }
            field(NoOfPostedReturnShipments; NoOfPostedReturnShipments)
            {
                Caption = 'Pstd. Return Shipments';
                DrillDown = true;
                Editable = true;

                trigger OnDrillDown()
                var
                    PurchReturnShptList: Page "6652";
                    PurchReturnShptHdr: Record "6650";
                begin
                    PurchReturnShptHdr.SETRANGE("Buy-from Vendor No.", "No.");
                    PurchReturnShptList.SETTABLEVIEW(PurchReturnShptHdr);
                    PurchReturnShptList.RUN;
                end;
            }
            field(NoOfPostedReceipts; NoOfPostedReceipts)
            {
                Caption = 'Pstd. Receipts';
                DrillDown = true;
                Editable = true;

                trigger OnDrillDown()
                var
                    PurchReceiptList: Page "145";
                    PurchReceiptHdr: Record "120";
                begin
                    PurchReceiptHdr.SETRANGE("Buy-from Vendor No.", "No.");
                    PurchReceiptList.SETTABLEVIEW(PurchReceiptHdr);
                    PurchReceiptList.RUN;
                end;
            }
            field(NoOfPostedInvoices; NoOfPostedInvoices)
            {
                Caption = 'Pstd. Invoices';
                DrillDown = true;
                Editable = true;

                trigger OnDrillDown()
                var
                    PurchInvList: Page "146";
                    PurchInvHdr: Record "122";
                begin
                    PurchInvHdr.SETRANGE("Buy-from Vendor No.", "No.");
                    PurchInvList.SETTABLEVIEW(PurchInvHdr);
                    PurchInvList.RUN;
                end;
            }
            field(NoOfPostedCreditMemos; NoOfPostedCreditMemos)
            {
                Caption = 'Pstd. Credit Memos';
                DrillDown = true;
                Editable = true;

                trigger OnDrillDown()
                var
                    PurchCrMemoList: Page "147";
                    PurchCrMemoHdr: Record "124";
                begin
                    PurchCrMemoHdr.SETRANGE("Buy-from Vendor No.", "No.");
                    PurchCrMemoList.SETTABLEVIEW(PurchCrMemoHdr);
                    PurchCrMemoList.RUN;
                end;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CalcNoOfBuyRecords;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        NoOfQuotes := 0;
        NoOfBlanketOrders := 0;
        NoOfOrders := 0;
        NoOfInvoices := 0;
        NoOfReturnOrders := 0;
        NoOfCreditMemos := 0;
        NoOfPostedReturnShipments := 0;
        NoOfPostedReceipts := 0;
        NoOfPostedInvoices := 0;
        NoOfPostedCreditMemos := 0;

        EXIT(FIND(Which));
    end;

    trigger OnOpenPage()
    begin
        CalcNoOfBuyRecords;
    end;

    var
        NoOfQuotes: Integer;
        NoOfBlanketOrders: Integer;
        NoOfOrders: Integer;
        NoOfInvoices: Integer;
        NoOfReturnOrders: Integer;
        NoOfCreditMemos: Integer;
        NoOfPostedReturnShipments: Integer;
        NoOfPostedReceipts: Integer;
        NoOfPostedInvoices: Integer;
        NoOfPostedCreditMemos: Integer;
        UserMgt: Codeunit "5700";

    [Scope('Internal')]
    procedure ShowDetails()
    begin
        PAGE.RUN(PAGE::"Vendor Card", Rec);
    end;

    [Scope('Internal')]
    procedure CalcNoOfBuyRecords()
    var
        PurchHeader: Record "38";
        PurchReturnShptHeader: Record "6650";
        PurchInvHeader: Record "122";
        PurchCrMemoHeader: Record "124";
        PurchReceiptHeader: Record "120";
    begin
        PurchHeader.RESET;
        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Quote);
        PurchHeader.SETRANGE("Buy-from Vendor No.", "No.");
        //Début Modif JX-XAD du 11/06/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        PurchHeader.FILTERGROUP(2);
        PurchHeader.SETFILTER("Assigned User ID", UserMgt.jx_GetPurchasesFilter);
        PurchHeader.FILTERGROUP(0);
        //Fin Modif JX-XAD du 11/06/2008

        NoOfQuotes := PurchHeader.COUNT;

        PurchHeader.RESET;
        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::"Blanket Order");
        PurchHeader.SETRANGE("Buy-from Vendor No.", "No.");
        //Début Modif JX-XAD du 11/06/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        PurchHeader.FILTERGROUP(2);
        PurchHeader.SETFILTER("Assigned User ID", UserMgt.jx_GetPurchasesFilter);
        PurchHeader.FILTERGROUP(0);
        //Fin Modif JX-XAD du 11/06/2008
        NoOfBlanketOrders := PurchHeader.COUNT;

        PurchHeader.RESET;
        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Order);
        PurchHeader.SETRANGE("Buy-from Vendor No.", "No.");
        //Début Modif JX-XAD du 11/06/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        PurchHeader.FILTERGROUP(2);
        PurchHeader.SETFILTER("Assigned User ID", UserMgt.jx_GetPurchasesFilter);
        PurchHeader.FILTERGROUP(0);
        //Fin Modif JX-XAD du 11/06/2008
        NoOfOrders := PurchHeader.COUNT;

        PurchHeader.RESET;
        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::"Return Order");
        PurchHeader.SETRANGE("Buy-from Vendor No.", "No.");
        //Début Modif JX-XAD du 11/06/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        PurchHeader.FILTERGROUP(2);
        PurchHeader.SETFILTER("Assigned User ID", UserMgt.jx_GetPurchasesFilter);
        PurchHeader.FILTERGROUP(0);
        //Fin Modif JX-XAD du 11/06/2008
        NoOfReturnOrders := PurchHeader.COUNT;

        PurchHeader.RESET;
        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Invoice);
        PurchHeader.SETRANGE("Buy-from Vendor No.", "No.");
        //Début Modif JX-XAD du 11/06/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        PurchHeader.FILTERGROUP(2);
        PurchHeader.SETFILTER("Assigned User ID", UserMgt.jx_GetPurchasesFilter);
        PurchHeader.FILTERGROUP(0);
        //Fin Modif JX-XAD du 11/06/2008
        NoOfInvoices := PurchHeader.COUNT;

        PurchHeader.RESET;
        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::"Credit Memo");
        PurchHeader.SETRANGE("Buy-from Vendor No.", "No.");
        //Début Modif JX-XAD du 11/06/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        PurchHeader.FILTERGROUP(2);
        PurchHeader.SETFILTER("Assigned User ID", UserMgt.jx_GetPurchasesFilter);
        PurchHeader.FILTERGROUP(0);
        //Fin Modif JX-XAD du 11/06/2008
        NoOfCreditMemos := PurchHeader.COUNT;

        PurchReturnShptHeader.RESET;
        PurchReturnShptHeader.SETRANGE("Buy-from Vendor No.", "No.");
        //Début Modif JX-XAD du 05/08/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        PurchReturnShptHeader.FILTERGROUP(2);
        PurchReturnShptHeader.SETFILTER("User ID", UserMgt.jx_GetPurchasesFilter);
        PurchReturnShptHeader.FILTERGROUP(0);
        //Fin Modif JX-XAD du 05/08/2008
        NoOfPostedReturnShipments := PurchReturnShptHeader.COUNT;

        PurchInvHeader.RESET;
        PurchInvHeader.SETRANGE("Buy-from Vendor No.", "No.");
        //Début Modif JX-XAD du 05/08/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        PurchInvHeader.FILTERGROUP(2);
        PurchInvHeader.SETFILTER("User ID", UserMgt.jx_GetPurchasesFilter);
        PurchInvHeader.FILTERGROUP(0);
        //Fin Modif JX-XAD du 05/08/2008
        NoOfPostedInvoices := PurchInvHeader.COUNT;

        PurchCrMemoHeader.RESET;
        PurchCrMemoHeader.SETRANGE("Buy-from Vendor No.", "No.");
        //Début Modif JX-XAD du 05/08/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        PurchCrMemoHeader.FILTERGROUP(2);
        PurchCrMemoHeader.SETFILTER("User ID", UserMgt.jx_GetPurchasesFilter);
        PurchCrMemoHeader.FILTERGROUP(0);
        //Fin Modif JX-XAD du 05/08/2008
        NoOfPostedCreditMemos := PurchCrMemoHeader.COUNT;

        PurchReceiptHeader.RESET;
        PurchReceiptHeader.SETRANGE("Buy-from Vendor No.", "No.");
        //Début Modif JX-XAD du 05/08/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        PurchReceiptHeader.FILTERGROUP(2);
        PurchReceiptHeader.SETFILTER("User ID", UserMgt.jx_GetPurchasesFilter);
        PurchReceiptHeader.FILTERGROUP(0);
        //Fin Modif JX-XAD du 05/08/2008
        NoOfPostedReceipts := PurchReceiptHeader.COUNT;
    end;
}

