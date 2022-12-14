tableextension 50081 "BC6_SalesLineDiscount" extends "Sales Line Discount" //7004
{
    fields
    {
        modify("Code")
        {
            TableRelation = IF (Type = CONST(Item)) Item
            ELSE
            IF (Type = CONST("Item Disc. Group")) "Item Discount Group"
            ELSE
            IF (Type = CONST(Vendor)) Vendor;
        }
        modify("Sales Code")
        {
            TableRelation = IF ("Sales Type" = CONST("Customer Disc. Group")) "Customer Discount Group"
            ELSE
            IF ("Sales Type" = CONST(Customer)) Customer
            ELSE
            IF ("Sales Type" = CONST(Campaign)) Campaign;
        }
        field(50000; "BC6_Profit %"; Decimal)
        {
            Caption = 'Profit %', Comment = 'FRA="% Profit"';
            DataClassification = CustomerContent;
        }
        field(50010; "BC6_Dispensation No."; Code[20])
        {
            Caption = 'N° dérogation', Comment = 'FRA="N° dérogation"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TESTFIELD("Sales Type", "Sales Type"::Customer);
            end;
        }
        field(50011; "BC6_Added Discount %"; Decimal)
        {
            Caption = '% remise complémentaire', Comment = 'FRA="% remise complémentaire"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TESTFIELD("BC6_Dispensation No.");
            end;
        }
    }
    keys
    {
    }
}
