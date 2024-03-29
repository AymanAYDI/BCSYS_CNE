report 50000 "BC6_Item rere"
{
    ApplicationArea = all;
    Caption = 'Item rere';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = WHERE(Description = CONST('COLLIER EN INOX DE LIAISON'));

            trigger OnAfterGetRecord()
            begin
                IF Item."No." <> 'CEL0-031820' THEN
                    Item.RENAME('MIGRATION 2013');
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
}
