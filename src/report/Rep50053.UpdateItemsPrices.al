report 50053 "BC6_Update Items Prices"
{

    Caption = 'Mise à jour prix public TTC';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", Description, "Description 2", "BC6_Print Unit Price Incl. VAT";

            trigger OnAfterGetRecord()
            begin
                // Item Unit Price
                VALIDATE("Unit Price");
                MODIFY(FALSE);
                Counter += 1;
            end;

            trigger OnPostDataItem()
            begin
                IF Counter > 0 THEN
                    MESSAGE(Text1100267003, Counter);
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN(Text001);
                Counter := 0;
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
        Window: Dialog;
        Text001: Label 'Mise à jour prix public TTC';
        Counter: Integer;
        Text1100267003: Label '%1 article(s) traité(s)';
}

