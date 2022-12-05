report 50044 "Conditions of Sales - Invoice"
{
    // +-------------------------------------------+
    // |  BCSYS - www.bcsys.fr                     |
    // +-------------------------------------------+
    // //BCSYS 290321 CGV
    // 
    // +-------------------------------------------+
    DefaultLayout = RDLC;
    RDLCLayout = './ConditionsofSalesInvoice.rdlc';


    dataset
    {
        dataitem(DataItem1000000000; Table112)
        {
            DataItemTableView = SORTING (No.);
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Payment Terms';
            column(No; "No.")
            {
            }
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

