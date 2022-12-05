report 50095 "Update Salesperson Filter"
{
    // ---------------------------------------------------------------
    //  Prodware - www.prodware.fr
    // ---------------------------------------------------------------
    // 
    // //>>CNE7.01
    // //>>P24233_001 SOBI APA 02/02/17
    //                     Create
    DefaultLayout = RDLC;
    RDLCLayout = './UpdateSalespersonFilter.rdlc';


    dataset
    {
        dataitem(DataItem1100267000; Table18)
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin

                IF "Salesperson Filter" = '' THEN
                    CurrReport.SKIP;

                VALIDATE("Salesperson Filter");
                MODIFY;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('Terminé');
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

