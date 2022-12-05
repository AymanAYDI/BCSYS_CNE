report 60000 "Batch VAT on Items"
{
    Caption = 'TPL TVA sur articles';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1100267000; Table27)
        {
            RequestFilterFields = "No.";
            dataitem(DataItem1100267001; Table37)
            {
                DataItemLink = No.=FIELD(No.);
                DataItemTableView = SORTING (Document Type, No.)
                                    WHERE (Document Type=CONST(Order));

                trigger OnAfterGetRecord()
                begin
                    IF ("VAT Prod. Posting Group" = 'TVA19,6') AND ("Quantity Shipped" = 0) THEN BEGIN
                        SuspendStatusCheck(TRUE);
                        VALIDATE("VAT Prod. Posting Group", 'TVA20');
                        MODIFY;
                        SuspendStatusCheck(FALSE);
                    END;
                end;
            }
            dataitem(DataItem1100267002; Table39)
            {
                DataItemLink = No.=FIELD(No.);
                DataItemTableView = SORTING (Document Type, No.)
                                    WHERE (Document Type=CONST(Order));

                trigger OnAfterGetRecord()
                begin
                    IF ("VAT Prod. Posting Group" = 'TVA19,6') AND ("Quantity Received" = 0) THEN BEGIN
                        SuspendStatusCheck(TRUE);
                        VALIDATE("VAT Prod. Posting Group", 'TVA20');
                        MODIFY;
                        SuspendStatusCheck(FALSE);
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF "VAT Prod. Posting Group" = 'TVA19,6' THEN BEGIN
                    DlgGWin.UPDATE(1, "No.");
                    VALIDATE("VAT Prod. Posting Group", 'TVA20');
                    MODIFY;
                END;
            end;

            trigger OnPostDataItem()
            begin
                DlgGWin.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE(Blocked, FALSE);

                DlgGWin.OPEN(CstG001);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        DlgGWin: Dialog;
        CstG001: Label 'Traitement de l''article : #1##############';
}

