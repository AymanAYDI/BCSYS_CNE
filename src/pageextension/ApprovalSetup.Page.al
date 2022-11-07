page 656 "Approval Setup"
{
    // // modif JX-LAB du 21/04/09
    // // ajout du champ 50000 approuvés et de la gestion de modèle e-mail approuvé

    Caption = 'Approval Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Table452;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Due Date Formula"; "Due Date Formula")
                {
                }
                field("Approval Administrator"; "Approval Administrator")
                {
                }
                field("Request Rejection Comment"; "Request Rejection Comment")
                {
                }
            }
            group(Notification)
            {
                Caption = 'Notification';
                group("Notify User about:")
                {
                    Caption = 'Notify User about:';
                    field(Approved; Approved)
                    {
                    }
                    field(Approvals; Approvals)
                    {
                    }
                    field(Cancellations; Cancellations)
                    {
                    }
                    field(Rejections; Rejections)
                    {
                    }
                    field(Delegations; Delegations)
                    {
                    }
                }
                group("Overdue Approvals")
                {
                    Caption = 'Overdue Approvals';
                    field("Last Run Date"; "Last Run Date")
                    {
                        Editable = false;
                    }
                }
            }
            group(Forms)
            {
                Caption = 'Forms';
                field("Sales Quote"; "Sales Quote")
                {
                    LookupPageID = Objects;
                }
                field("Sales Order"; "Sales Order")
                {
                    LookupPageID = Objects;
                }
                field("Sales Invoice"; "Sales Invoice")
                {
                    LookupPageID = Objects;
                }
                field("Sales Credit Memo"; "Sales Credit Memo")
                {
                    LookupPageID = Objects;
                }
                field("Sales Blanket Order"; "Sales Blanket Order")
                {
                    LookupPageID = Objects;
                }
                field("Sales Return Order"; "Sales Return Order")
                {
                    LookupPageID = Objects;
                }
                field("Purchases Quote"; "Purchases Quote")
                {
                    LookupPageID = Objects;
                }
                field("Purchases Order"; "Purchases Order")
                {
                    LookupPageID = Objects;
                }
                field("Purchases Invoice"; "Purchases Invoice")
                {
                    LookupPageID = Objects;
                }
                field("Purchases Credit Memo"; "Purchases Credit Memo")
                {
                    LookupPageID = Objects;
                }
                field("Purchases Blanket Order"; "Purchases Blanket Order")
                {
                    LookupPageID = Objects;
                }
                field("Purchases Return Order"; "Purchases Return Order")
                {
                    LookupPageID = Objects;
                }
            }
            group("Approved Mails")
            {
                Caption = 'Approved Mails';
                field("Sales Quote Yes/No"; "Sales Quote Yes/No")
                {
                }
                field("Sales Order Yes/No"; "Sales Order Yes/No")
                {
                }
                field("Sales Invoice Yes/No"; "Sales Invoice Yes/No")
                {
                }
                field("Sales Credit Memo Yes/No"; "Sales Credit Memo Yes/No")
                {
                }
                field("Sales Blanket Order Yes/No"; "Sales Blanket Order Yes/No")
                {
                }
                field("Sales Return Order Yes/No"; "Sales Return Order Yes/No")
                {
                }
                field("Purchases Quote Yes/No"; "Purchases Quote Yes/No")
                {
                }
                field("Purchases Order Yes/No"; "Purchases Order Yes/No")
                {
                }
                field("Purchases Invoice Yes/No"; "Purchases Invoice Yes/No")
                {
                }
                field("Purchases Credit Memo Yes/No"; "Purchases Credit Memo Yes/No")
                {
                }
                field("Purchases Blanket Order Yes/No"; "Purchases Blanket Order Yes/No")
                {
                }
                field("Purchases Return Order Yes/No"; "Purchases Return Order Yes/No")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(; Links)
            {
                Visible = false;
            }
            systempart(; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Mail Templates")
            {
                Caption = '&Mail Templates';
                Image = Template;
                group("Approval Mail Template")
                {
                    Caption = 'Approval Mail Template';
                    Image = Template;
                    action(Import)
                    {
                        Caption = 'Import';
                        Ellipsis = true;
                        Image = Import;

                        trigger OnAction()
                        begin
                            CALCFIELDS("Approval Template");
                            IF "Approval Template".HASVALUE THEN
                                AppTemplateExists := TRUE;

                            IF FileMgt.BLOBImport(TempBlob, '*.HTM') = '' THEN
                                EXIT;

                            "Approval Template" := TempBlob.Blob;

                            IF AppTemplateExists THEN
                                IF NOT CONFIRM(Text002, FALSE, FIELDCAPTION("Approval Template")) THEN
                                    EXIT;

                            CurrPage.SAVERECORD;
                        end;
                    }
                    action("E&xport")
                    {
                        Caption = 'E&xport';
                        Ellipsis = true;
                        Image = Export;

                        trigger OnAction()
                        begin
                            CALCFIELDS("Approval Template");
                            IF "Approval Template".HASVALUE THEN BEGIN
                                TempBlob.Blob := "Approval Template";
                                FileMgt.BLOBExport(TempBlob, '*.HTM', TRUE);
                            END;
                        end;
                    }
                    action(Delete)
                    {
                        Caption = 'Delete';
                        Ellipsis = true;
                        Image = Delete;

                        trigger OnAction()
                        begin
                            CALCFIELDS("Approval Template");
                            IF "Approval Template".HASVALUE THEN
                                IF CONFIRM(Text003, FALSE, FIELDCAPTION("Approval Template")) THEN BEGIN
                                    CLEAR("Approval Template");
                                    CurrPage.SAVERECORD;
                                END;
                        end;
                    }
                }
                group("Overdue Mail Template")
                {
                    Caption = 'Overdue Mail Template';
                    Image = Overdue;
                    action(Import)
                    {
                        Caption = 'Import';
                        Ellipsis = true;
                        Image = Import;

                        trigger OnAction()
                        begin
                            CALCFIELDS("Overdue Template");
                            OverdueTemplateExists := "Overdue Template".HASVALUE;

                            IF FileMgt.BLOBImport(TempBlob, '*.HTM') = '' THEN
                                EXIT;

                            "Overdue Template" := TempBlob.Blob;

                            IF OverdueTemplateExists THEN
                                IF NOT CONFIRM(Text002, FALSE, FIELDCAPTION("Overdue Template")) THEN
                                    EXIT;

                            CurrPage.SAVERECORD;
                        end;
                    }
                    action("E&xport")
                    {
                        Caption = 'E&xport';
                        Ellipsis = true;
                        Image = Export;

                        trigger OnAction()
                        begin
                            CALCFIELDS("Overdue Template");
                            IF "Overdue Template".HASVALUE THEN BEGIN
                                TempBlob.Blob := "Overdue Template";
                                FileMgt.BLOBExport(TempBlob, '*.HTM', TRUE);
                            END;
                        end;
                    }
                    action(Delete)
                    {
                        Caption = 'Delete';
                        Ellipsis = true;
                        Image = Delete;

                        trigger OnAction()
                        begin
                            CALCFIELDS("Overdue Template");
                            IF "Overdue Template".HASVALUE THEN
                                IF CONFIRM(Text003, FALSE, FIELDCAPTION("Overdue Template")) THEN BEGIN
                                    CLEAR("Overdue Template");
                                    CurrPage.SAVERECORD;
                                END;
                        end;
                    }
                }
                group("Modèle e-mail approuvé")
                {
                    Caption = 'Modèle e-mail approuvé';
                    action(Import)
                    {
                        Caption = 'Import';
                        Ellipsis = true;

                        trigger OnAction()
                        begin
                            CALCFIELDS("Approved Template");
                            IF "Approved Template".HASVALUE THEN
                                AppTemplateExists := TRUE;

                            IF FileMgt.BLOBImport(TempBlob, '*.HTM') = '' THEN
                                EXIT;

                            "Approved Template" := TempBlob.Blob;

                            IF AppTemplateExists THEN
                                IF NOT CONFIRM(Text002, FALSE, FIELDCAPTION("Approved Template")) THEN
                                    EXIT;

                            CurrPage.SAVERECORD;
                        end;
                    }
                    action(Export)
                    {
                        Caption = 'Export';
                        Ellipsis = true;

                        trigger OnAction()
                        begin
                            CALCFIELDS("Approved Template");
                            IF "Approved Template".HASVALUE THEN BEGIN
                                TempBlob.Blob := "Approved Template";
                                FileMgt.BLOBExport(TempBlob, '*.HTM', TRUE);
                            END;
                        end;
                    }
                    action(Delete)
                    {
                        Caption = 'Delete';
                        Ellipsis = true;

                        trigger OnAction()
                        begin
                            CALCFIELDS("Approved Template");
                            IF "Approved Template".HASVALUE THEN
                                IF CONFIRM(Text003, FALSE, FIELDCAPTION("Approved Template")) THEN BEGIN
                                    CLEAR("Approved Template");
                                    CurrPage.SAVERECORD;
                                END;
                        end;
                    }
                }
            }
            group("&Overdue")
            {
                Caption = '&Overdue';
                Image = Overdue;
                action("Send Overdue Mails")
                {
                    Caption = 'Send Overdue Mails';
                    Image = OverdueMail;

                    trigger OnAction()
                    begin
                        IF CONFIRM(STRSUBSTNO(Text004, TODAY), TRUE) THEN BEGIN
                            ApprMgtNotification.LaunchCheck(TODAY);
                            "Last Run Date" := TODAY;
                            "Last Run Time" := TIME;
                            MODIFY;
                            CurrPage.UPDATE;
                        END;
                    end;
                }
                action("Overdue Log Entries")
                {
                    Caption = 'Overdue Log Entries';
                    Image = OverdueEntries;
                    RunObject = Page 666;
                }
            }
        }
        area(processing)
        {
            action("&User Setup")
            {
                Caption = '&User Setup';
                Image = UserSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 663;
            }
            action(NotificationMailSetup)
            {
                Caption = '&Notification Email Setup';
                Image = MailSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 409;
            }
        }
    }

    trigger OnOpenPage()
    begin
        RESET;
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;
    end;

    var
        TempBlob: Record "99008535";
        ApprMgtNotification: Codeunit "440";
        FileMgt: Codeunit "419";
        OverdueTemplateExists: Boolean;
        Text002: Label 'Do you want to replace the existing %1?';
        Text003: Label 'Do you want to delete the template %1?';
        AppTemplateExists: Boolean;
        Text004: Label 'Do you want to run the overdue check by the %1?';
        ApprovedTemplateExits: Boolean;
}

