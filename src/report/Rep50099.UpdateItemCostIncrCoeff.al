report 50099 "Update Item Cost Incr. Coeff."
{
    Caption = 'Update Item Cost Incr. Coeff.', Comment = 'FRA="Mise à jour coeff de majoration du côut"';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Item Category Code";

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, ROUND((i / Item.COUNT) * 10000, 1));
                Window.UPDATE(2, STRSUBSTNO('%1 / %2', i, Item.COUNT));

                Item."BC6_Cost Increase Coeff %" := NewCoeff;
                Item.MODIFY();

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
                        Caption = 'New Coefficient (%)', Comment = 'FRA="Nouveau coefficient (%)"';
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
        DlgMsg: Label 'Processing items :\@@1@@@@@@@@@@@@@@@@@@@@@@\##2######################', Comment = 'FRA="Traitement des articles en cours :\@@1@@@@@@@@@@@@@@@@@@@@@@\##2######################"';
        MsgCompleted: Label 'Process completed.', Comment = 'FRA="Traitement terminé."';
        ErrFilters: Label 'Filters on Items cannot be empty.', Comment = 'FRA="Au moins un filtre est requis sur la liste des articles."';
}

