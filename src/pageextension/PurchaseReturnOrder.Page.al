page 6640 "Purchase Return Order"
{
    // Modif JX-XAD du 11/06/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)

    Caption = 'Purchase Return Order';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = Table38;
    SourceTableView = WHERE (Document Type=FILTER(Return Order));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No.";"No.")
                {
                    Importance = Promoted;
                    Visible = DocNoVisible;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                          CurrPage.UPDATE;
                    end;
                }
                field("Buy-from Vendor No.";"Buy-from Vendor No.")
                {
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate;
                    end;
                }
                field("Buy-from Contact No.";"Buy-from Contact No.")
                {
                    QuickEntry = false;
                }
                field("Buy-from Vendor Name";"Buy-from Vendor Name")
                {
                    QuickEntry = false;
                }
                field("Buy-from Address";"Buy-from Address")
                {
                    QuickEntry = false;
                }
                field("Buy-from Address 2";"Buy-from Address 2")
                {
                    QuickEntry = false;
                }
                field("Buy-from Post Code";"Buy-from Post Code")
                {
                    QuickEntry = false;
                }
                field("Buy-from City";"Buy-from City")
                {
                    QuickEntry = false;
                }
                field("Buy-from Contact";"Buy-from Contact")
                {
                    QuickEntry = false;
                }
                field("No. of Archived Versions";"No. of Archived Versions")
                {
                    QuickEntry = false;
                }
                field("Posting Date";"Posting Date")
                {
                    QuickEntry = false;
                }
                field("Order Date";"Order Date")
                {
                    Importance = Promoted;
                    QuickEntry = false;
                }
                field("Document Date";"Document Date")
                {
                    QuickEntry = false;
                }
                field("Vendor Authorization No.";"Vendor Authorization No.")
                {
                    Importance = Promoted;
                }
                field("Vendor Cr. Memo No.";"Vendor Cr. Memo No.")
                {
                    Importance = Promoted;
                }
                field("Order Address Code";"Order Address Code")
                {
                    QuickEntry = false;
                }
                field("Purchaser Code";"Purchaser Code")
                {
                    QuickEntry = false;

                    trigger OnValidate()
                    begin
                        PurchaserCodeOnAfterValidate;
                    end;
                }
                field("Campaign No.";"Campaign No.")
                {
                    QuickEntry = false;
                }
                field("Responsibility Center";"Responsibility Center")
                {
                    QuickEntry = false;
                }
                field("Assigned User ID";"Assigned User ID")
                {
                    QuickEntry = false;
                }
                field("Job Queue Status";"Job Queue Status")
                {
                    Importance = Additional;
                    QuickEntry = false;
                }
                field(Status;Status)
                {
                    Importance = Promoted;
                    QuickEntry = false;
                }
            }
            part(PurchLines;6641)
            {
                SubPageLink = Document No.=FIELD(No.);
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Pay-to Vendor No.";"Pay-to Vendor No.")
                {
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        PaytoVendorNoOnAfterValidate;
                    end;
                }
                field("Pay-to Contact No.";"Pay-to Contact No.")
                {
                }
                field("Pay-to Name";"Pay-to Name")
                {
                }
                field("Pay-to Address";"Pay-to Address")
                {
                }
                field("Pay-to Address 2";"Pay-to Address 2")
                {
                }
                field("Pay-to Post Code";"Pay-to Post Code")
                {
                }
                field("Pay-to City";"Pay-to City")
                {
                }
                field("Pay-to Contact";"Pay-to Contact")
                {
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Applies-to Doc. Type";"Applies-to Doc. Type")
                {
                    Importance = Promoted;
                }
                field("Applies-to Doc. No.";"Applies-to Doc. No.")
                {
                    Importance = Promoted;
                }
                field("Applies-to ID";"Applies-to ID")
                {
                }
                field("Prices Including VAT";"Prices Including VAT")
                {

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("VAT Bus. Posting Group";"VAT Bus. Posting Group")
                {
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name";"Ship-to Name")
                {
                }
                field("Ship-to Address";"Ship-to Address")
                {
                }
                field("Ship-to Address 2";"Ship-to Address 2")
                {
                }
                field("Ship-to Post Code";"Ship-to Post Code")
                {
                }
                field("Ship-to City";"Ship-to City")
                {
                }
                field("Ship-to Contact";"Ship-to Contact")
                {
                }
                field("Location Code";"Location Code")
                {
                    Importance = Promoted;
                }
                field("Expected Receipt Date";"Expected Receipt Date")
                {
                    Importance = Promoted;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code";"Currency Code")
                {
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        IF "Posting Date" <> 0D THEN
                          ChangeExchangeRate.SetParameter("Currency Code","Currency Factor","Posting Date")
                        ELSE
                          ChangeExchangeRate.SetParameter("Currency Code","Currency Factor",WORKDATE);
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                          VALIDATE("Currency Factor",ChangeExchangeRate.GetParameter);
                          CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0,Rec);
                    end;
                }
                field("Transaction Type";"Transaction Type")
                {
                }
                field("Transaction Specification";"Transaction Specification")
                {
                }
                field("Transport Method";"Transport Method")
                {
                }
                field("Entry Point";"Entry Point")
                {
                }
                field(Area;Area)
                {
                }
            }
        }
        area(factboxes)
        {
            part(;9092)
            {
                SubPageLink = Table ID=CONST(38),Document Type=FIELD(Document Type),Document No.=FIELD(No.),Status=CONST(Open);
                Visible = false;
            }
            part(;9093)
            {
                SubPageLink = No.=FIELD(Buy-from Vendor No.);
                Visible = true;
            }
            part(;9094)
            {
                SubPageLink = No.=FIELD(Pay-to Vendor No.);
                Visible = false;
            }
            part(;9095)
            {
                SubPageLink = No.=FIELD(Buy-from Vendor No.);
                Visible = true;
            }
            part(;9096)
            {
                SubPageLink = No.=FIELD(Pay-to Vendor No.);
                Visible = false;
            }
            part(;9100)
            {
                Provider = PurchLines;
                SubPageLink = Document Type=FIELD(Document Type),Document No.=FIELD(Document No.),Line No.=FIELD(Line No.);
                Visible = false;
            }
            systempart(;Links)
            {
                Visible = false;
            }
            systempart(;Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Return Order")
            {
                Caption = '&Return Order';
                Image = Return;
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        CalcInvDiscForHeader;
                        COMMIT;
                        PAGE.RUNMODAL(PAGE::"Purchase Order Statistics",Rec);
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(Vendor)
                {
                    Caption = 'Vendor';
                    Image = Vendor;
                    RunObject = Page 27;
                                    RunPageLink = No.=FIELD(Buy-from Vendor No.);
                    ShortCutKey = 'Shift+F7';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData 348=R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "658";
                    begin
                        ApprovalEntries.Setfilters(DATABASE::"Purchase Header","Document Type","No.");
                        ApprovalEntries.RUN;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 66;
                                    RunPageLink = Document Type=FIELD(Document Type),No.=FIELD(No.),Document Line No.=CONST(0);
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action("Return Shipments")
                {
                    Caption = 'Return Shipments';
                    Image = Shipment;
                    RunObject = Page 6652;
                                    RunPageLink = Return Order No.=FIELD(No.);
                    RunPageView = SORTING(Return Order No.);
                }
                action("Cred&it Memos")
                {
                    Caption = 'Cred&it Memos';
                    Image = CreditMemo;
                    RunObject = Page 147;
                                    RunPageLink = Return Order No.=FIELD(No.);
                    RunPageView = SORTING(Return Order No.);
                }
                separator()
                {
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Whse. Shipment Lines")
                {
                    Caption = 'Whse. Shipment Lines';
                    Image = ShipmentLines;
                    RunObject = Page 7341;
                                    RunPageLink = Source Type=CONST(39),Source Subtype=FIELD(Document Type),Source No.=FIELD(No.);
                    RunPageView = SORTING(Source Type,Source Subtype,Source No.,Source Line No.);
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page 5774;
                                    RunPageLink = Source Document=CONST(Purchase Return Order),Source No.=FIELD(No.);
                    RunPageView = SORTING(Source Document,Source No.,Location Code);
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    DocPrint.PrintPurchHeader(Rec);
                end;
            }
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "415";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "415";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator()
                {
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(GetPostedDocumentLinesToReverse)
                {
                    Caption = 'Get Posted Doc&ument Lines to Reverse';
                    Ellipsis = true;
                    Image = ReverseLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        GetPstdDocLinesToRevere;
                    end;
                }
                action("Apply Entries")
                {
                    Caption = 'Apply Entries';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+F11';

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Purchase Header Apply",Rec);
                    end;
                }
                separator()
                {
                }
                action(CalculateInvoiceDiscount)
                {
                    AccessByPermission = TableData 24=R;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                separator()
                {
                }
                action(CopyDocument)
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL;
                        CLEAR(CopyPurchDoc);
                    end;
                }
                action("Move Negative Lines")
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RUNMODAL;
                        MoveNegPurchLines.ShowDocument;
                    end;
                }
                action("Archive Document")
                {
                    Caption = 'Archive Document';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Send IC Return Order")
                {
                    AccessByPermission = TableData 410=R;
                    Caption = 'Send IC Return Order';
                    Image = IntercompanyOrder;

                    trigger OnAction()
                    var
                        ICInOutMgt: Codeunit "427";
                        SalesHeader: Record "36";
                        ApprovalMgt: Codeunit "439";
                    begin
                        IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                          ICInOutMgt.SendPurchDoc(Rec,FALSE);
                    end;
                }
                separator()
                {
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                Image = Approval;
                group(Approval)
                {
                    Caption = 'Approval';
                    Image = Approval;
                    action("Send A&pproval Request")
                    {
                        Caption = 'Send A&pproval Request';
                        Image = SendApprovalRequest;

                        trigger OnAction()
                        var
                            ApprovalMgt: Codeunit "439";
                        begin
                            IF ApprovalMgt.SendPurchaseApprovalRequest(Rec) THEN;
                        end;
                    }
                    action("Cancel Approval Re&quest")
                    {
                        Caption = 'Cancel Approval Re&quest';
                        Image = Cancel;

                        trigger OnAction()
                        var
                            ApprovalMgt: Codeunit "439";
                        begin
                            IF ApprovalMgt.CancelPurchaseApprovalRequest(Rec,TRUE,TRUE) THEN;
                        end;
                    }
                    separator()
                    {
                    }
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create &Whse. Shipment")
                {
                    AccessByPermission = TableData 7320=R;
                    Caption = 'Create &Whse. Shipment';
                    Image = NewShipment;

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit "5752";
                    begin
                        GetSourceDocOutbound.CreateFromPurchaseReturnOrder(Rec);
                    end;
                }
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData 7342=R;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;

                    trigger OnAction()
                    begin
                        CreateInvtPutAwayPick;
                    end;
                }
                separator()
                {
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                }
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purch. Ret. Orders",TRUE,TRUE,Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Remove From Job Queue")
                {
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        CancelBackgroundPosting;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(ConfirmDeletion);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Responsibility Center" := UserMgt.GetPurchasesFilter;
    end;

    trigger OnOpenPage()
    var
        UserSetup: Record "91";
        CodeService: Code[20];
        UserList: Text[200];
    begin
        IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
          FILTERGROUP(0);
        END;

        //Début Modif JX-XAD du 11/06/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        FILTERGROUP(2);
        SETFILTER("Assigned User ID",UserMgt.jx_GetPurchasesFilter);
        FILTERGROUP(0);
        //Fin Modif JX-XAD du 11/06/2008

        SetDocNoVisible;
    end;

    var
        ChangeExchangeRate: Page "511";
                                CopyPurchDoc: Report "492";
                                MoveNegPurchLines: Report "6698";
                                DocPrint: Codeunit "229";
                                ReportPrint: Codeunit "228";
                                UserMgt: Codeunit "5700";
                                ArchiveManagement: Codeunit "5063";
                                PurchCalcDiscByType: Codeunit "66";
    [InDataSet]

    JobQueueVisible: Boolean;
    DocNoVisible: Boolean;

local procedure Post(PostingCodeunitID: Integer)
    begin
        SendToPosting(PostingCodeunitID);
        IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
          CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        IF GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
          IF "Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
            SETRANGE("Buy-from Vendor No.");
        CurrPage.UPDATE;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit "1400";
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::"Return Order","No.");
    end;
}

