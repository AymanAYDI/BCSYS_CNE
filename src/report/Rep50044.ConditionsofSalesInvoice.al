report 50044 "Conditions of Sales - Invoice"
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

