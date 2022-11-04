tableextension 50068 "BC6_ReturnShipmentLine" extends "Return Shipment Line"
{
    fields
    {
        field(50000; "BC6_Sales No."; Code[20])
        {
            Caption = 'Sales Order No.';
            Editable = false;
        }
        field(50001; "BC6_Sales Line No."; Integer)
        {
            Caption = 'Sales Order Line No.';
            Editable = false;
        }
        field(50002; "BC6_Sales Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';
        }
        field(50022; "BC6_Public Price"; Decimal)
        {
            Caption = 'Tarif Public';
        }
        field(50031; "BC6_Discount Direct Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Discount Direct Unit Cost excluding VAT';
            Editable = false;

            trigger OnValidate()
            begin
                VALIDATE("Line Discount %");
            end;
        }
    }
    keys
    {
        key(Key6; "No.")
        {
        }
    }

}

