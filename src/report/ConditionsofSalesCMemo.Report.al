report 50043 "Conditions of Sales - C.Memo"
{
    // +-------------------------------------------+
    // |  BCSYS - www.bcsys.fr                     |
    // +-------------------------------------------+
    // //BCSYS 290321 CGV
    // 
    // +-------------------------------------------+
    DefaultLayout = RDLC;
    RDLCLayout = './ConditionsofSalesCMemo.rdlc';


    dataset
    {
        dataitem(DataItem1000000000; Table114)
        {
            DataItemTableView = SORTING(No.);
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

