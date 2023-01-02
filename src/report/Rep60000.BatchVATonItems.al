report 60000 "BC6_Batch VAT on Items"
{
    Caption = 'TPL TVA sur articles';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(DataItem1100267000; Item)
        {
            RequestFilterFields = "No.";
            dataitem(DataItem1100267001; "Sales Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.")
                                    WHERE("Document Type" = CONST(Order));

                trigger OnAfterGetRecord()
                begin
                    IF ("VAT Prod. Posting Group" = 'TVA19,6') AND ("Quantity Shipped" = 0) THEN BEGIN
                        SuspendStatusCheck(TRUE);
                        VALIDATE("VAT Prod. Posting Group", 'TVA20');
                        MODIFY();
                        SuspendStatusCheck(FALSE);
                    END;
                end;
            }
            dataitem(DataItem1100267002; "Purchase Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.")
                                    WHERE("Document Type" = CONST(Order));

                trigger OnAfterGetRecord()
                begin
                    IF ("VAT Prod. Posting Group" = 'TVA19,6') AND ("Quantity Received" = 0) THEN BEGIN
                        SuspendStatusCheck(TRUE);
                        VALIDATE("VAT Prod. Posting Group", 'TVA20');
                        MODIFY();
                        SuspendStatusCheck(FALSE);
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF "VAT Prod. Posting Group" = 'TVA19,6' THEN BEGIN
                    DlgGWin.UPDATE(1, "No.");
                    VALIDATE("VAT Prod. Posting Group", 'TVA20');
                    MODIFY();
                END;
            end;

            trigger OnPostDataItem()
            begin
                DlgGWin.CLOSE();
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE(Blocked, FALSE);

                DlgGWin.OPEN(CstG001);
            end;
        }
    }
    var
        DlgGWin: Dialog;
        CstG001: Label 'Traitement de l''article : #1##############';
}

