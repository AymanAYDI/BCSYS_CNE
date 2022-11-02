page 50118 "LOC Purchase Return Order"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // 
    // //FE005 SEBC 08/01/2007 Add field
    //                         50021 Buy-from Fax No.
    // 
    // 
    // ------------------------------------------------------------------------

    Caption = 'Purchase Return Order';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval';
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
                    ToolTip = 'Specifies the number of the purchase document. The field is only visible if you have not set up a number series for the type of purchase document, or if the Manual Nos. field is selected for the number series.';
                    Visible = DocNoVisible;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                          CurrPage.UPDATE;
                    end;
                }
                field("Buy-from Vendor Name";"Buy-from Vendor Name")
                {
                    Caption = 'Vendor';
                    Importance = Promoted;
                    QuickEntry = false;
                    ToolTip = 'Specifies the name of the vendor who sends the items. The field is filled automatically when you fill the Buy-from Vendor No. field.';

                    trigger OnValidate()
                    begin
                        IF GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
                          IF "Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
                            SETRANGE("Buy-from Vendor No.");

                        CurrPage.UPDATE;
                    end;
                }
                group("Buy-from")
                {
                    Caption = 'Buy-from';
                    field("Buy-from Address";"Buy-from Address")
                    {
                        Caption = 'Address';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the address of the vendor who ships the items.';
                    }
                    field("Buy-from Address 2";"Buy-from Address 2")
                    {
                        Caption = 'Address 2';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field("Buy-from Post Code";"Buy-from Post Code")
                    {
                        Caption = 'Post Code';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Buy-from City";"Buy-from City")
                    {
                        Caption = 'City';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the city of the vendor who ships the items.';
                    }
                    field("Buy-from Contact No.";"Buy-from Contact No.")
                    {
                        Caption = 'Contact No.';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the number of your contact at the vendor.';
                    }
                }
                field(ID;ID)
                {
                }
                field("Buy-from Fax No.";"Buy-from Fax No.")
                {
                }
                field("Buy-from Contact";"Buy-from Contact")
                {
                    Caption = 'Contact';
                    QuickEntry = false;
                    ToolTip = 'Specifies the name of the person to contact about shipment of the item from this vendor.';
                }
                field("Document Date";"Document Date")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies the date on which the vendor created the purchase document.';
                }
                field("Posting Date";"Posting Date")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies the date when the posting of the purchase document will be recorded.';
                }
                field("No. of Archived Versions";"No. of Archived Versions")
                {
                    QuickEntry = false;
                }
                field("Order Date";"Order Date")
                {
                    Importance = Promoted;
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
                    ToolTip = 'Specifies the order address code linked to the relevant vendor''s order address.';
                }
                field("Purchaser Code";"Purchaser Code")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';

                    trigger OnValidate()
                    begin
                        PurchaserCodeOnAfterValidate;
                    end;
                }
                field("Campaign No.";"Campaign No.")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies the campaign number the document is linked to.';
                }
                field("Responsibility Center";"Responsibility Center")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.';
                }
                field("Assigned User ID";"Assigned User ID")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field("Job Queue Status";"Job Queue Status")
                {
                    Importance = Additional;
                    QuickEntry = false;
                    Visible = JobQueueUsed;
                }
                field(Status;Status)
                {
                    Importance = Promoted;
                    QuickEntry = false;
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
                }
                field("Return Order Type";"Return Order Type")
                {

                    trigger OnValidate()
                    begin
                        IF "Return Order Type" = "Return Order Type"::SAV THEN
                          BooGReminderDateVisible := TRUE
                        ELSE
                          BooGReminderDateVisible := FALSE
                    end;
                }
                field("Reminder Date";"Reminder Date")
                {
                    Editable = BooGReminderDateVisible;
                }
            }
            part(PurchLines;6641)
            {
                SubPageLink = Document No.=FIELD(No.);
                UpdatePropagation = Both;
            }
            group("Invoice Details")
            {
                Caption = 'Invoice Details';
                field("Currency Code";"Currency Code")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the currency code for amounts on the purchase lines.';

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
                        CurrPage.SAVERECORD;
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0,Rec);
                    end;
                }
                field("Expected Receipt Date";"Expected Receipt Date")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the date you expect to receive the items on the purchase document.';
                }
                field("Prices Including VAT";"Prices Including VAT")
                {
                    ToolTip = 'Specifies whether the unit price on the line should be displayed including or excluding VAT.';

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("VAT Bus. Posting Group";"VAT Bus. Posting Group")
                {
                    ToolTip = 'Specifies the vendor''s VAT specification to link transactions made for this vendor with the appropriate general ledger account according to the VAT posting setup.';
                }
                field("Transaction Type";"Transaction Type")
                {
                    ToolTip = 'Specifies the number for the transaction type, for the purpose of reporting to INTRASTAT.';
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the dimension value code associated with the purchase header.';

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the dimension value code associated with the purchase header.';

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Location Code";"Location Code")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
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
            }
            group("Shipping and Payment")
            {
                Caption = 'Shipping and Payment';
                group("Ship-to")
                {
                    Caption = 'Ship-to';
                    field("Ship-to Name";"Ship-to Name")
                    {
                        Caption = 'Name';
                        Importance = Additional;
                        ToolTip = 'Specifies the name of the company at the address to which you want the items in the purchase order to be shipped.';
                    }
                    field("Ship-to Address";"Ship-to Address")
                    {
                        Caption = 'Address';
                        Importance = Additional;
                        ToolTip = 'Specifies the address that you want the items in the purchase order to be shipped to.';
                    }
                    field("Ship-to Address 2";"Ship-to Address 2")
                    {
                        Caption = 'Address 2';
                        Importance = Additional;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field("Ship-to Post Code";"Ship-to Post Code")
                    {
                        Caption = 'Post Code';
                        Importance = Additional;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Ship-to City";"Ship-to City")
                    {
                        Caption = 'City';
                        Importance = Additional;
                        ToolTip = 'Specifies the city the items in the purchase order will be shipped to.';
                    }
                    field("Ship-to Contact";"Ship-to Contact")
                    {
                        Caption = 'Contact';
                        Importance = Additional;
                        ToolTip = 'Specifies the name of a contact person for the address where the items in the purchase order should be shipped.';
                    }
                }
                group("Pay-to")
                {
                    Caption = 'Pay-to';
                    field("Pay-to Name";"Pay-to Name")
                    {
                        Caption = 'Name';
                        Importance = Promoted;
                        ToolTip = 'Specifies the name of the vendor sending the invoice.';
                    }
                    field("Pay-to Address";"Pay-to Address")
                    {
                        Caption = 'Address';
                        Importance = Additional;
                        ToolTip = 'Specifies the address of the vendor sending the invoice.';
                    }
                    field("Pay-to Address 2";"Pay-to Address 2")
                    {
                        Caption = 'Address 2';
                        Importance = Additional;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field("Pay-to Post Code";"Pay-to Post Code")
                    {
                        Caption = 'Post Code';
                        Importance = Additional;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Pay-to City";"Pay-to City")
                    {
                        Caption = 'City';
                        Importance = Additional;
                        ToolTip = 'Specifies the city of the vendor sending the invoice.';
                    }
                    field("Pay-to Contact No.";"Pay-to Contact No.")
                    {
                        Caption = 'Contact No.';
                        Importance = Additional;
                        ToolTip = 'Specifies the number of the contact who sends the invoice.';
                    }
                    field("Pay-to Contact";"Pay-to Contact")
                    {
                        Caption = 'Contact';
                        Importance = Additional;
                        ToolTip = 'Specifies the name of the person to contact about an invoice from this vendor.';
                    }
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Transaction Specification";"Transaction Specification")
                {
                    ToolTip = 'Specifies a code for the purchase header''s transaction specification here.';
                }
                field("Transport Method";"Transport Method")
                {
                    ToolTip = 'Specifies the code for the transport method to be used with this purchase header.';
                }
                field("Entry Point";"Entry Point")
                {
                    ToolTip = 'Specifies the code of the port of entry where the items pass into your country/region.';
                }
                field(Area;Area)
                {
                    ToolTip = 'Specifies the code for the area of the vendor''s address.';
                }
            }
        }
        area(factboxes)
        {
            part(;9103)
            {
                SubPageLink = Table ID=CONST(38),
                              Document Type=FIELD(Document Type),
                              Document No.=FIELD(No.);
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(ApprovalFactBox;9092)
            {
                Visible = false;
            }
            part(;9093)
            {
                SubPageLink = No.=FIELD(Buy-from Vendor No.);
            }
            part(;9094)
            {
                SubPageLink = No.=FIELD(Pay-to Vendor No.);
                Visible = false;
            }
            part(;9095)
            {
                SubPageLink = No.=FIELD(Buy-from Vendor No.);
            }
            part(;9096)
            {
                SubPageLink = No.=FIELD(Pay-to Vendor No.);
                Visible = false;
            }
            part(;9100)
            {
                Provider = PurchLines;
                SubPageLink = Document Type=FIELD(Document Type),
                              Document No.=FIELD(Document No.),
                              Line No.=FIELD(Line No.);
                Visible = false;
            }
            part(WorkflowStatus;1528)
            {
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(;Links)
            {
                Visible = false;
            }
            systempart(;Notes)
            {
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
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

                    trigger OnAction()
                    begin
                        OpenPurchaseOrderStatistics;
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(Vendor)
                {
                    Caption = 'Vendor';
                    Image = Vendor;
                    RunObject = Page 26;
                                    RunPageLink = No.=FIELD(Buy-from Vendor No.);
                    ShortCutKey = 'Shift+F7';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData 348=R;
                    Caption = 'Dimensions';
                    Enabled = "No." <> '';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Approvals)
                {
                    AccessByPermission = TableData 454=R;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

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
                                    RunPageLink = Document Type=FIELD(Document Type),
                                  No.=FIELD(No.),
                                  Document Line No.=CONST(0);
                    ToolTip = 'View or add notes about the purchase return order.';
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
                                    RunPageLink = Source Type=CONST(39),
                                  Source Subtype=FIELD(Document Type),
                                  Source No.=FIELD(No.);
                    RunPageView = SORTING(Source Type,Source Subtype,Source No.,Source Line No.);
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page 5774;
                                    RunPageLink = Source Document=CONST(Purchase Return Order),
                                  Source No.=FIELD(No.);
                    RunPageView = SORTING(Source Document,Source No.,Location Code);
                }
            }
        }
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "1535";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "1535";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID);
                    end;
                }
                action(Delegate)
                {
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "1535";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID);
                    end;
                }
                action(Comment)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'View or add comments.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "1535";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    L_PurchaseHeader: Record "38";
                begin
                    //>>BCSYS
                    // OLD DocPrint.PrintPurchHeader(Rec)
                    IF "Return Order Type" = "Return Order Type"::Location THEN
                      DocPrint.PrintPurchHeader(Rec)
                    ELSE BEGIN
                      L_PurchaseHeader.RESET;
                      L_PurchaseHeader.SETRANGE("Document Type","Document Type");
                      L_PurchaseHeader.SETRANGE("No.","No.");
                      REPORT.RUNMODAL(50061,TRUE,FALSE,L_PurchaseHeader);
                    END;
                    //<<BCSYS
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
                action(Reopen)
                {
                    Caption = 'Re&open';
                    Enabled = Status <> Status::Open;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed';

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
                    ToolTip = 'Calculate the invoice discount for the entire purchase invoice.';

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
                        IF GET("Document Type","No.") THEN;
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
                        ApprovalsMgmt: Codeunit "1535";
                    begin
                        IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
                          ICInOutMgt.SendPurchDoc(Rec,FALSE);
                    end;
                }
                separator()
                {
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = Approval;
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Send an approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "1535";
                    begin
                        IF ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) THEN
                          ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "1535";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
                separator()
                {
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
                action(Post)
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
                action(Preview)
                {
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction()
                    var
                        PurchPostYesNo: Codeunit "91";
                    begin
                        PurchPostYesNo.Preview(Rec);
                    end;
                }
                action(TestReport)
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(PostAndPrint)
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
                action(PostBatch)
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
                action(RemoveFromJobQueue)
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

    trigger OnAfterGetCurrRecord()
    begin
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(RECORDID);
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(ConfirmDeletion);
    end;

    trigger OnInit()
    var
        PurchasesPayablesSetup: Record "312";
    begin
        JobQueueUsed := PurchasesPayablesSetup.JobQueueActive;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Responsibility Center" := UserMgt.GetPurchasesFilter;
        IF (NOT DocNoVisible) AND ("No." = '') THEN
          SetBuyFromVendorFromFilter;

        //BCSYS 020321
        "Return Order Type" := "Return Order Type"::Location;
        //FIN BCSYS 020321
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
          FILTERGROUP(0);
        END;

        SetDocNoVisible;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF NOT DocumentIsPosted THEN
          EXIT(ConfirmCloseUnposted);
    end;

    var
        CopyPurchDoc: Report "492";
                          MoveNegPurchLines: Report "6698";
                          DocPrint: Codeunit "229";
                          ReportPrint: Codeunit "228";
                          UserMgt: Codeunit "5700";
                          ArchiveManagement: Codeunit "5063";
                          PurchCalcDiscByType: Codeunit "66";
                          ChangeExchangeRate: Page "511";
    [InDataSet]

    JobQueueVisible: Boolean;
        [InDataSet]
        JobQueueUsed: Boolean;
        DocNoVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        ShowWorkflowStatus: Boolean;
        CanCancelApprovalForRecord: Boolean;
        DocumentIsPosted: Boolean;
        OpenPostedPurchaseReturnOrderQst: Label 'The return order has been posted and moved to the Posted Purchase Credit Memos window.\\Do you want to open the posted credit memo?';
        "-BCSYS-": Integer;
        BooGReminderDateVisible: Boolean;

    local procedure Post(PostingCodeunitID: Integer)
    var
        PurchaseHeader: Record "38";
        InstructionMgt: Codeunit "1330";
    begin
        SendToPosting(PostingCodeunitID);

        DocumentIsPosted := NOT PurchaseHeader.GET("Document Type","No.");

        IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
          CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);

        IF PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" THEN
          EXIT;

        IF InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) THEN
          ShowPostedConfirmationMessage;
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
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

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "1535";
    begin
        JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);

        //>>BCSYS
        IF "Return Order Type" = "Return Order Type"::SAV THEN
          BooGReminderDateVisible := TRUE;
        //<<BCSYS
    end;

    local procedure ShowPostedConfirmationMessage()
    var
        ReturnOrderPurchaseHeader: Record "38";
        PurchCrMemoHdr: Record "124";
        InstructionMgt: Codeunit "1330";
    begin
        IF NOT ReturnOrderPurchaseHeader.GET("Document Type","No.") THEN BEGIN
          PurchCrMemoHdr.SETRANGE("No.","Last Posting No.");
          IF PurchCrMemoHdr.FINDFIRST THEN
            IF InstructionMgt.ShowConfirm(OpenPostedPurchaseReturnOrderQst,InstructionMgt.ShowPostedConfirmationMessageCode) THEN
              PAGE.RUN(PAGE::"Posted Purchase Credit Memo",PurchCrMemoHdr);
        END;
    end;
}
