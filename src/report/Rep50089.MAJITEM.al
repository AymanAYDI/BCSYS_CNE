report 50089 "BC6_MAJ ITEM"
{
    ApplicationArea = All;
    Caption = 'MAJ ITEM';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    UseRequestPage = false;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = WHERE("No." = FILTER('CLI*'));

            trigger OnAfterGetRecord()
            begin
                Item.Blocked := FALSE;
                MODIFY();
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
