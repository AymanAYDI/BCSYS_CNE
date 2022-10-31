tableextension 50015 "BC6_SalespersonPurchaser" extends "Salesperson/Purchaser"
{
    LookupPageID = "Salespersons/Purchasers";
    fields
    {

        field(50000; "BC6_Grouping Code"; Text[100])
        {
            Caption = 'Grouping Code';
        }
    }

}

