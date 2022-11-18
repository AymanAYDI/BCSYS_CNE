tableextension 50001 "BC6_SalespersonPurchaser" extends "Salesperson/Purchaser" //13
{
    fields
    {
        field(50000; "BC6_Grouping Code"; Text[100])
        {
            Caption = 'Grouping Code', Comment = 'FRA="Regroupement codes"';
            DataClassification = CustomerContent;
        }
    }
}