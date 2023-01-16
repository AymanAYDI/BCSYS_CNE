report 50044 "BC6_Conditions Sales - Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/ConditionsofSalesInvoice.rdl';
    UsageCategory = None;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
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
