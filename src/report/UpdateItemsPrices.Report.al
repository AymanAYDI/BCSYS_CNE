report 50053 "Update Items Prices"
{
    // 
    // //>> CNE4.03 Calc. Price Include VAT

    Caption = 'Mise à jour prix public TTC';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1100267000; Table27)
        {
            RequestFilterFields = "No.", Description, "Description 2", "Print Unit Price Includes VAT";

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

