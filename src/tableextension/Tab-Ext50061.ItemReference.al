tableextension 50061 "BC6_ItemReference" extends "Item Reference"
{
    fields
    {
        field(50000; "BC6_Internal Bar Code"; Boolean)
        {
            Caption = 'Internal Bar Code';

            trigger OnValidate()
            begin
                //>> A:FE02 Begin
                IF ("BC6_Internal Bar Code") AND
                   ("Reference Type" <> "Reference Type"::"Bar Code")
                THEN
                    ERROR(Text001, TABLECAPTION);
                //<< End
            end;
        }
        field(50001; BC6_Inventory; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."), "Variant Code" = FIELD("Variant Code")));
            Caption = 'Inventory';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
    }

    var
        Text001: Label 'This %1 is not a bar code.', Comment = 'FRA = "Cette %1 n''est pas un code barre."'; //TODO: check

}

