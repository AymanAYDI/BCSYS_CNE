report 50043 "BC6_Conditions Sales - C.Memo"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/ConditionsofSalesCMemo.rdl';
    UsageCategory = None;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Payment Terms', Comment = 'FRA="Mode règlement"';
            column(No; "No.")
            {
            }
        }
    }

    labels
    {
    }
}
