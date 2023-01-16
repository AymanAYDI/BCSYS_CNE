report 50095 "BC6_Update Salesperson Filter"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/UpdateSalespersonFilter.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin

                IF "BC6_Salesperson Filter" = '' THEN
                    CurrReport.SKIP();

                VALIDATE("BC6_Salesperson Filter");
                MODIFY();
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
