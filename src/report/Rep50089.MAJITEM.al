report 50089 "BC6_MAJ ITEM"
{
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'MAJ ITEM';

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

