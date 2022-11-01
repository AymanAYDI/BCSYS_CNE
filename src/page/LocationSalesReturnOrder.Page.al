page 50117 "Location Sales Return Order"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //EMAIL SOBH NSC1.01 [005] Envoi document  dans bouton imprimer
    // //FE005 SEBC 08/01/2007 Add field
    //                         50061 Fax No.
    // //>>CNE1.00
    // FEP-ADVE-200706_18_A.001:MA 14/11/2007 : gestion des appeles d'offres clients
    //     - Add field "Affair No."
    // ------------------------------------------------------------------------
    // +----------------------------------------------------------------------+
    // |BC6                                                                   |
    // |http://www.BCSYS.fr                                                   |
    // +----------------------------------------------------------------------+
    // BC6 01102020
    //   - Add Code "OnNewRecord"
    // +----------------------------------------------------------------------+

    Caption = 'Sales Return Order';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval';
    RefreshOnActivate = true;
    SourceTable = Table36;
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
                    Importance = Additional;
                    ToolTip = 'Specifies the number of the sales document. The field can be filled automatically or manually and can be set up to be invisible.';
                    Visible = DocNoVisible;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                          CurrPage.UPDATE;
                    end;
                }
                field("Sell-to Customer Name";"Sell-to Customer Name")
                {
                    Caption = 'Customer';
                    Importance = Promoted;
                    QuickEntry = false;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the name of the customer who will receive the products and be billed by default.';

                    trigger OnValidate()
                    begin
                        IF GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." THEN
                          IF "Sell-to Customer No." <> xRec."Sell-to Customer No." THEN
                            SETRANGE("Sell-to Customer No.");

                        CurrPage.UPDATE;
                    end;
                }
                group("Sell-to")
                {
                    Caption = 'Sell-to';
                    field("Sell-to Address";"Sell-to Address")
                    {
                        Caption = 'Address';
                        Importance = Additional;
                        ToolTip = 'Specifies the address where the customer is located.';
                    }
                    field("Sell-to Address 2";"Sell-to Address 2")
                    {
                        Caption = 'Address 2';
                        Importance = Additional;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field("Sell-to Post Code";"Sell-to Post Code")
                    {
                        Caption = 'Post Code';
                        Importance = Additional;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Sell-to City";"Sell-to City")
                    {
                        Caption = 'City';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the city where the customer is located.';
                    }
                    field("Sell-to Contact No.";"Sell-to Contact No.")
                    {
                        Caption = 'Contact No.';
                        Importance = Additional;
                        ToolTip = 'Specifies the number of the contact that the sales document will be sent to.';

                        trigger OnValidate()
                        begin
                            IF GETFILTER("Sell-to Contact No.") = xRec."Sell-to Contact No." THEN
                              IF "Sell-to Contact No." <> xRec."Sell-to Contact No." THEN
                                SETRANGE("Sell-to Contact No.");
                        end;
                    }
                }
                field(ID;ID)
                {
                }
                field("Sell-to Fax No.";"Sell-to Fax No.")
                {
                }
                field("Affair No.";"Affair No.")
                {
                }
                field("Sell-to Contact";"Sell-to Contact")
                {
                    Caption = 'Contact';
                    ToolTip = 'Specifies the name of the person to contact at the customer.';
                }
                field("Document Date";"Document Date")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies the date on which you created the sales document.';
                }
                field("Posting Date";"Posting Date")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies the date when the posting of the sales document will be recorded.';
                }
                field("Order Date";"Order Date")
                {
                    Importance = Promoted;
                    QuickEntry = false;
                    ToolTip = 'Specifies the date on which the exchange rate applies to prices listed in a foreign currency on the sales order.';
                }
                field("External Document No.";"External Document No.")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the number that the customer uses in their own system to refer to this sales document.';
                }
                field("No. of Archived Versions";"No. of Archived Versions")
                {
                    ToolTip = 'Specifies the number of archived versions for this sales document.';
                }
                field("Salesperson Code";"Salesperson Code")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies the name of the salesperson who is assigned to the customer.';

                    trigger OnValidate()
                    begin
                        SalespersonCodeOnAfterValidate;
                    end;
                }
                field("Campaign No.";"Campaign No.")
                {
                    ToolTip = 'Specifies the number of the campaign that the document is linked to.';
                }
                field("Responsibility Center";"Responsibility Center")
                {
                    ToolTip = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.';
                }
                field("Assigned User ID";"Assigned User ID")
                {
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field("Job Queue Status";"Job Queue Status")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the status of a job queue entry or task that handles the posting of sales orders.';
                    Visible = JobQueueUsed;
                }
                field("Return Order Type";"Return Order Type")
                {
                }
                field(Status;Status)
                {
                    Importance = Promoted;
                    QuickEntry = false;
                    ToolTip = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.';
                }
            }
            part(SalesLines;6631)
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
                    ToolTip = 'Specifies the currency of amounts on the sales document.';

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
                        SalesCalcDiscByType.ApplyDefaultInvoiceDiscount(0,Rec);
                    end;
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
                    ToolTip = 'Specifies the customer''s VAT specification to link transactions made for this customer to.';
                }
                field("Transaction Type";"Transaction Type")
                {
                    ToolTip = 'Specifies the type of transaction that the sales document represents, for the purpose of reporting to INTRASTAT.';
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the dimension value code associated with the sales header.';

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the dimension value code associated with the sales header.';

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Shipment Date";"Shipment Date")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the date you expect to ship items on the sales document.';
                }
                field("Applies-to Doc. Type";"Applies-to Doc. Type")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                }
                field("Applies-to Doc. No.";"Applies-to Doc. No.")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the number of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                }
                field("Applies-to ID";"Applies-to ID")
                {
                    ToolTip = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.';
                }
            }
            group("Shipping and Billing")
            {
                Caption = 'Shipping and Billing';
                group("Shipment Method")
                {
                    Caption = 'Shipment Method';
                    field("Shipping Agent Code";"Shipping Agent Code")
                    {
                        Caption = 'Agent';
                        Importance = Additional;
                        ToolTip = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.';
                    }
                    field("Shipping Agent Service Code";"Shipping Agent Service Code")
                    {
                        Caption = 'Agent Service';
                        Importance = Additional;
                        ToolTip = 'Specifies which shipping agent service is used to transport the items on the sales document to the customer.';
                    }
                    field("Package Tracking No.";"Package Tracking No.")
                    {
                        Importance = Additional;
                        ToolTip = 'Specifies the shipping agent''s package number.';
                    }
                }
                group("Ship-to")
                {
                    Caption = 'Ship-to';
                    field("Location Code";"Location Code")
                    {
                        Caption = 'Location';
                        Importance = Promoted;
                        ToolTip = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.';
                    }
                    field("Ship-to Name";"Ship-to Name")
                    {
                        Caption = 'Name';
                        ToolTip = 'Specifies the name that products on the sales document will be shipped to.';
                    }
                    field("Ship-to Address";"Ship-to Address")
                    {
                        Caption = 'Address';
                        ToolTip = 'Specifies the address that products on the sales document will be shipped to.';
                    }
                    field("Ship-to Address 2";"Ship-to Address 2")
                    {
                        Caption = 'Address 2';
                        ToolTip = 'Specifies additional address information.';
                    }
                    field("Ship-to Post Code";"Ship-to Post Code")
                    {
                        Caption = 'Post Code';
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Ship-to City";"Ship-to City")
                    {
                        Caption = 'City';
                        ToolTip = 'Specifies the city that products on the sales document will be shipped to.';
                    }
                    field("Ship-to Contact";"Ship-to Contact")
                    {
                        Caption = 'Contact';
                        ToolTip = 'Specifies the name of the contact person at the address that products on the sales document will be shipped to.';
                    }
                }
                group("Bill-to")
                {
                    Caption = 'Bill-to';
                    field("Bill-to Name";"Bill-to Name")
                    {
                        Caption = 'Name';
                        Importance = Promoted;
                        ToolTip = 'Specifies the customer to whom you will send the sales invoice, when different from the customer that you are selling to.';
                    }
                    field("Bill-to Address";"Bill-to Address")
                    {
                        Caption = 'Address';
                        Importance = Additional;
                        ToolTip = 'Specifies the address of the customer that you will send the invoice to.';
                    }
                    field("Bill-to Address 2";"Bill-to Address 2")
                    {
                        Caption = 'Address 2';
                        Importance = Additional;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field("Bill-to Post Code";"Bill-to Post Code")
                    {
                        Caption = 'Post Code';
                        Importance = Additional;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Bill-to City";"Bill-to City")
                    {
                        Caption = 'City';
                        Importance = Additional;
                        ToolTip = 'Specifies the city you will send the invoice to.';
                    }
                    field("Bill-to Contact No.";"Bill-to Contact No.")
                    {
                        Caption = 'Contact No.';
                        Importance = Additional;
                        ToolTip = 'Specifies the number of the contact the invoice will be sent to.';
                    }
                    field("Bill-to Contact";"Bill-to Contact")
                    {
                        Caption = 'Contact';
                        ToolTip = 'Specifies the name of the person you should contact at the customer who you are sending the invoice to.';
                    }
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("EU 3-Party Trade";"EU 3-Party Trade")
                {
                    ToolTip = 'Specifies whether the sales document is part of a three-party trade.';
                }
                field("Transaction Specification";"Transaction Specification")
                {
                    ToolTip = 'Specifies a code for the sales document''s transaction specification, for the purpose of reporting to INTRASTAT.';
                }
                field("Transport Method";"Transport Method")
                {
                    ToolTip = 'Specifies the transport method, for the purpose of reporting to INTRASTAT.';
                }
                field("Exit Point";"Exit Point")
                {
                    ToolTip = 'Specifies the point of exit through which you ship the items out of your country/region, for reporting to Intrastat.';
                }
                field(Area;Area)
                {
                    ToolTip = 'Specifies the area of the customer''s address, for the purpose of reporting to INTRASTAT.';
                }
            }
        }
        area(factboxes)
        {
            part(;9103)
            {
                SubPageLink = Table ID=CONST(36),
                              Document Type=FIELD(Document Type),
                              Document No.=FIELD(No.);
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(;9080)
            {
                SubPageLink = No.=FIELD(Sell-to Customer No.);
            }
            part(;9081)
            {
                SubPageLink = No.=FIELD(Sell-to Customer No.);
                Visible = false;
            }
            part(;9082)
            {
                SubPageLink = No.=FIELD(Bill-to Customer No.);
                Visible = false;
            }
            part(;9084)
            {
                SubPageLink = No.=FIELD(Sell-to Customer No.);
            }
            part(;9087)
            {
                Provider = SalesLines;
                SubPageLink = Document Type=FIELD(Document Type),
                              Document No.=FIELD(Document No.),
                              Line No.=FIELD(Line No.);
                Visible = false;
            }
            part(ApprovalFactBox;9092)
            {
                Visible = false;
            }
            part(;9108)
            {
                Provider = SalesLines;
                SubPageLink = No.=FIELD(No.);
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
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

                    trigger OnAction()
                    var
                        Handled: Boolean;
                    begin
                        OnBeforeStatisticsAction(Rec,Handled);
                        IF NOT Handled THEN BEGIN
                          OpenSalesOrderStatistics;
                          SalesCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                        END
                    end;
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page 21;
                                    RunPageLink = No.=FIELD(Sell-to Customer No.);
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the customer on the sales document.';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData 348=R;
                    Caption = 'Dimensions';
                    Enabled = "No." <> '';
                    Image = Dimensions;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
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
                        ApprovalEntries.Setfilters(DATABASE::"Sales Header","Document Type","No.");
                        ApprovalEntries.RUN;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page 67;
                                    RunPageLink = Document Type=CONST(Return Order),
                                  No.=FIELD(No.),
                                  Document Line No.=CONST(0);
                    ToolTip = 'View or add notes about the sales return order.';
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action("Return Receipts")
                {
                    Caption = 'Return Receipts';
                    Image = ReturnReceipt;
                    RunObject = Page 6662;
                                    RunPageLink = Return Order No.=FIELD(No.);
                    RunPageView = SORTING(Return Order No.);
                }
                action("Cred&it Memos")
                {
                    Caption = 'Cred&it Memos';
                    Image = CreditMemo;
                    RunObject = Page 144;
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
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page 5774;
                                    RunPageLink = Source Document=CONST(Sales Return Order),
                                  Source No.=FIELD(No.);
                    RunPageView = SORTING(Source Document,Source No.,Location Code);
                }
                action("Whse. Receipt Lines")
                {
                    Caption = 'Whse. Receipt Lines';
                    Image = ReceiptLines;
                    RunObject = Page 7342;
                                    RunPageLink = Source Type=CONST(37),
                                  Source Subtype=FIELD(Document Type),
                                  Source No.=FIELD(No.);
                    RunPageView = SORTING(Source Type,Source Subtype,Source No.,Source Line No.);
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
                    L_SalesHeader: Record "36";
                begin
                    //>>MIGRATION NAV 2013

                    //EMAIL SOBH NSC1.01 [005] Envoi document
                    //STD DocPrint.PrintSalesHeader(Rec);
                    //>>BCSYS 05072020
                    IF "Return Order Type" = "Return Order Type"::Location THEN BEGIN
                    //>>BCSYS 05072020
                      CASE STRMENU (STR3+','+STR4+','+STR5) OF
                           1:DocPrint.PrintSalesHeader(Rec);
                           2:EnvoiMail;
                      END;
                    //Fin EMAIL SOBH NSC1.01 [005] Envoi document
                    //<<MIGRATION NAV 2013
                    END ELSE
                      CASE STRMENU (STR3+','+STR4) OF
                           1:
                             BEGIN
                               TESTFIELD(Status,Status::Released);
                               L_SalesHeader.RESET;
                               L_SalesHeader.SETRANGE("Document Type","Document Type");
                               L_SalesHeader.SETRANGE("No.","No.");
                               REPORT.RUNMODAL(50060,TRUE,FALSE,L_SalesHeader);
                             END;
                           2:
                             BEGIN
                               TESTFIELD(Status,Status::Released);
                               EnvoiMail;
                             END;

                      END;
                end;
            }
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "414";
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);

                        //>>BCSYS
                        FctSendNotification
                        //<<BCSYS
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Re&open';
                    Enabled = Status <> Status::Open;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "414";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
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
                action(CalculateInvoiceDiscount)
                {
                    AccessByPermission = TableData 19=R;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ToolTip = 'Calculate the invoice discount that applies to the sales order.';

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                        SalesCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                separator()
                {
                }
                action("Apply Entries")
                {
                    Caption = 'Apply Entries';
                    Ellipsis = true;
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+F11';
                    ToolTip = 'Select one or more ledger entries that you want to apply this record to so that the related posted documents are closed as paid or refunded.';

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Sales Header Apply",Rec);
                    end;
                }
                action("Create Return-Related &Documents")
                {
                    Caption = 'Create Return-Related &Documents';
                    Ellipsis = true;
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CLEAR(CreateRetRelDocs);
                        CreateRetRelDocs.SetSalesHeader(Rec);
                        CreateRetRelDocs.RUNMODAL;
                        CreateRetRelDocs.ShowDocuments;
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
                    ToolTip = 'Copy document lines and header information from another sales document to this document. You can copy a posted sales invoice into a new sales invoice to quickly create a similar document.';

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL;
                        CLEAR(CopySalesDoc);
                        IF GET("Document Type","No.") THEN;
                    end;
                }
                action(MoveNegativeLines)
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RUNMODAL;
                        MoveNegSalesLines.ShowDocument;
                    end;
                }
                action(GetPostedDocumentLinesToReverse)
                {
                    Caption = 'Get Posted Doc&ument Lines to Reverse';
                    Ellipsis = true;
                    Image = ReverseLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Copy one or more posted sales document lines in order to reverse the original order.';

                    trigger OnAction()
                    begin
                        GetPstdDocLinesToRevere;
                    end;
                }
                action("Archive Document")
                {
                    Caption = 'Archive Document';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchiveSalesDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Send IC Return Order Cnfmn.")
                {
                    AccessByPermission = TableData 410=R;
                    Caption = 'Send IC Return Order Cnfmn.';
                    Image = IntercompanyOrder;

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit "427";
                        ApprovalsMgmt: Codeunit "1535";
                    begin
                        IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
                          ICInOutboxMgt.SendSalesDoc(Rec,FALSE);
                    end;
                }
                separator()
                {
                }
                action(DisplayRelatedDocuments)
                {
                    Caption = 'Affichage documents associés';
                    Image = CopyDocument;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;

                    trigger OnAction()
                    var
                        L_ReturnOrderMgt: Codeunit "50052";
                    begin
                        L_ReturnOrderMgt.DisableRelatedDocuments("No.");
                        CurrPage.UPDATE;
                    end;
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                separator()
                {
                }
                action("Create &Whse. Receipt")
                {
                    AccessByPermission = TableData 7316=R;
                    Caption = 'Create &Whse. Receipt';
                    Image = NewReceipt;

                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit "5751";
                    begin
                        GetSourceDocInbound.CreateFromSalesReturnOrder(Rec);
                    end;
                }
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData 7340=R;
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
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Sales-Post (Yes/No)");
                    end;
                }
                action("Preview Posting")
                {
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction()
                    begin
                        ShowPreview;
                    end;
                }
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
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
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Sales-Post + Print");
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Return Orders",TRUE,TRUE,Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Remove From Job Queue")
                {
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    ToolTip = 'Remove the scheduled processing of this record from the job queue.';
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        CancelBackgroundPosting;
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
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
                        IF ApprovalsMgmt.CheckSalesApprovalPossible(Rec) THEN
                          ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
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
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
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
        SalesReceivablesSetup: Record "311";
    begin
        JobQueueUsed := SalesReceivablesSetup.JobQueueActive;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF DocNoVisible THEN
          CheckCreditMaxBeforeInsert;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Responsibility Center" := UserMgt.GetSalesFilter;
        IF (NOT DocNoVisible) AND ("No." = '') THEN
          SetSellToCustomerFromFilter;

        //>>BC6 01102020
        "Return Order Type" := "Return Order Type"::Location;
        //<<BC6 01102020
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetSalesFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
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
        CopySalesDoc: Report "292";
                          MoveNegSalesLines: Report "6699";
                          CreateRetRelDocs: Report "6697";
                          ReportPrint: Codeunit "228";
                          DocPrint: Codeunit "229";
                          UserMgt: Codeunit "5700";
                          ArchiveManagement: Codeunit "5063";
                          SalesCalcDiscByType: Codeunit "56";
                          ChangeExchangeRate: Page "511";
    [InDataSet]

    JobQueueVisible: Boolean;
    "--NSC1.01--": Integer;
    cust: Record "18";
    nameF: Text[250];
    Mail: Codeunit "397";
    "Sales & Receivables Setup": Record "311";
    Excel: Boolean;
    HistMail: Record "99003";
    "--MIGNAV2013--": ;
    Text001: ;
    Text004: ;
    STR3: Label 'Print Document';
    STR4: Label 'Envoyer par Mail';
    STR5: Label 'Envoyer par Fax';
    SalesSetup: Record "311";
        [InDataSet]
        JobQueueUsed: Boolean;
        DocNoVisible: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        CanCancelApprovalForRecord: Boolean;
        DocumentIsPosted: Boolean;
        OpenPostedSalesReturnOrderQst: Label 'The return order has been posted and moved to the Posted Sales Credit Memos window.\\Do you want to open the posted credit memo?';
        "--BCSYS--": ;
        CstNewReturnOrder: Label 'Nouveau retour SAV';

    local procedure Post(PostingCodeunitID: Integer)
    var
        SalesHeader: Record "36";
        InstructionMgt: Codeunit "1330";
    begin
        SendToPosting(PostingCodeunitID);

        DocumentIsPosted := NOT SalesHeader.GET("Document Type","No.");

        IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
          CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);

        IF PostingCodeunitID <> CODEUNIT::"Sales-Post (Yes/No)" THEN
          EXIT;

        IF InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) THEN
          ShowPostedConfirmationMessage;
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
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
        DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::"Return Order","No.");
    end;

    [Scope('Internal')]
    procedure ShowPreview()
    var
        SalesPostYesNo: Codeunit "81";
    begin
        SalesPostYesNo.Preview(Rec);
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "1535";
    begin
        JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
    end;

    local procedure ShowPostedConfirmationMessage()
    var
        ReturnOrderSalesHeader: Record "36";
        SalesCrMemoHeader: Record "114";
        InstructionMgt: Codeunit "1330";
    begin
        IF NOT ReturnOrderSalesHeader.GET("Document Type","No.") THEN BEGIN
          SalesCrMemoHeader.SETRANGE("No.","Last Posting No.");
          IF SalesCrMemoHeader.FINDFIRST THEN
            IF InstructionMgt.ShowConfirm(OpenPostedSalesReturnOrderQst,InstructionMgt.ShowPostedConfirmationMessageCode) THEN
              PAGE.RUN(PAGE::"Posted Sales Credit Memo",SalesCrMemoHeader);
        END;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeStatisticsAction(var SalesHeader: Record "36";var Handled: Boolean)
    begin
    end;

    [Scope('Internal')]
    procedure "--Functions_NSC1.01--"()
    begin
    end;

    [Scope('Internal')]
    procedure EnvoiMail()
    begin
        //>>MIGRATION NAV 2013
        //EMAIL NSC00.01 SBH [005] Envoi document
        cust.SETRANGE(cust."No.","Sell-to Customer No.");
        IF cust.FIND('-') THEN
        cust.TESTFIELD("E-Mail");
          OpenFile;
          IF nameF<>'' THEN BEGIN
            //MIG 2017 >>
            //Mail.NewMessage(cust."E-Mail",'',CurrPage.CAPTION+' '+"No.",'',nameF,FALSE);
            Mail.NewMessage(cust."E-Mail",'','',CurrPage.CAPTION+' '+"No.",'',nameF,FALSE);
            //MIG 2017 <<
            ERASE(nameF);
          END ELSE BEGIN
            ERASE(SalesSetup.Repertoire +'Envoi'+'\'+CurrPage.CAPTION) ;
            ERROR(Text001);
          END;
        HistMail."No.":=cust."No.";
        HistMail.Nom  :=cust.Name;
        HistMail."E-Mail":=  cust."E-Mail";
        HistMail."Date d'envoi":=TODAY;
        HistMail."Document envoyé":=CurrPage.CAPTION+' '+"No.";
        HistMail.INSERT(TRUE);
        //Fin EMAIL NSC00.01 SBH [005] Envoi document
        //<<MIGRATION NAV 2013
    end;

    [Scope('Internal')]
    procedure OpenFile()
    begin
        //>>MIGRATION NAV 2013
        /*//EMAIL NSC00.01 SBH [005] Envoi document
        FileDialog.DialogTitle('Envoi'+' 'CurrPage.CAPTION);
        FileDialog.Filter := Text004;
        SalesSetup.GET;
        FileDialog.FileName := '';
        FileDialog.InitDir(SalesSetup.Repertoire);
        FileDialog.Flags := 4096 + 2048; // vérification de l'existence du fichier, code qui suit inutile.
        FileDialog.ShowOpen;
        nameF:=FileDialog.FileName;
        IF nameF='' THEN
          BEGIN
            Excel := FALSE;
            EXIT;
          END;
        //Fin EMAIL NSC00.01 SBH [005] Envoi document
        */
        //<<MIGRATION NAV 2013

    end;

    [Scope('Internal')]
    procedure OpenFile1(WindowTitle: Text[50];DefaultFileName: Text[250];DefaultFileType: Option " ",Text,Excel,Word,Custom;FilterString: Text[250];"Action": Option Open,Save): Text[260]
    begin
    end;

    local procedure "---BCSYS---"()
    begin
    end;

    local procedure FctSendNotification()
    var
        L_UserSetup: Record "91";
        NotificationEntry: Record "1511";
        notification: Notification;
    begin
        L_UserSetup.RESET;
        L_UserSetup.SETRANGE("SAV Admin",TRUE);
        IF L_UserSetup.FINDFIRST THEN
          REPEAT
            NotificationEntry.CreateNew(
              NotificationEntry.Type::"New Record",L_UserSetup."User ID",
              Rec,6630,'');
          UNTIL L_UserSetup.NEXT = 0;
    end;
}

