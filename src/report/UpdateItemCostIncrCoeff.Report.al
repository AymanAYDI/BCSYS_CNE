report 50099 "Update Item Cost Incr. Coeff."
{
    Caption = 'Update Item Cost Incr. Coeff.';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table27)
        {
            RequestFilterFields = "No.", "Item Category Code", "Product Group Code";

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, ROUND((i / Item.COUNT) * 10000, 1));
                Window.UPDATE(2, STRSUBSTNO('%1 / %2', i, Item.COUNT));

                Item."Cost Increase Coeff %" := NewCoeff;
                Item.MODIFY;

                i += 1;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NewCoeff; NewCoeff)
                    {
                        Caption = 'New Coefficient (%)';
                        MaxValue = 100;
                        MinValue = 0;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        i := 0;
    end;

    trigger OnPostReport()
    begin
        Window.CLOSE;
        MESSAGE(MsgCompleted);
    end;

    trigger OnPreReport()
    begin
        IF Item.GETFILTERS = '' THEN
            ERROR(ErrFilters);
        Window.OPEN(DlgMsg);
    end;

    var
        NewCoeff: Decimal;
        i: Integer;
        Window: Dialog;
        DlgMsg: Label 'Processing items :\@@1@@@@@@@@@@@@@@@@@@@@@@\##2######################';
        MsgCompleted: Label 'Process completed.';
        ErrFilters: Label 'Filters on Items cannot be empty.';
}

