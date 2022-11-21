tableextension 50074 "BC6_ItemReference" extends "Item Reference" //5777
{
    fields
    {
        field(50000; "BC6_Internal Bar Code"; Boolean)
        {
            Caption = 'Internal Bar Code', Comment = 'FRA="Code barre interne"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF ("BC6_Internal Bar Code") AND
                   ("Reference Type" <> "Reference Type"::"Bar Code")
                THEN
                    ERROR(Text001, TABLECAPTION);
            end;
        }
        field(50001; BC6_Inventory; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."), "Variant Code" = FIELD("Variant Code")));
            Caption = 'Inventory', Comment = 'FRA="Stock"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
    }
    var
        Text001: Label 'This %1 is not a bar code.', Comment = 'FRA = "Cette %1 n''est pas un code barre."';
}
