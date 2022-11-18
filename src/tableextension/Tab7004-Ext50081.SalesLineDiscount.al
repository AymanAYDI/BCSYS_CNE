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
            // ELSE
            // IF ("Sales Type" = CONST("Customer Sales Profit Group")) "Customer Sales Profit Group"; TODO:
        }
        modify("Sales Type")
        {
            OptionCaption = 'Customer,Customer Disc. Group,All Customers,Campaign,Customer Sales Profit Group';
            // OptionString = Customer,"Customer Disc. Group","All Customers",Campaign,"Customer Sales Profit Group"; TODO:
        }
        modify(Type)
        {
            OptionCaption = 'Item,Item Disc. Group,,,,,Vendor';

            //Unsupported feature: Property Modification (OptionString) on "Type(Field 21)". TODO:
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
        // key(Key3; "Code", "Sales Code", "Sales Type", Type, "Starting Date", "Ending Date", "BC6_Profit %") // TODO: La propriété 'Key3' ne peut être définie que si les champs spécifiés proviennent de la même table.
        // {
        // }
    }

    var
        "-NSC1.01--": TextConst;
        Text004: Label 'Start Date Must Mandatory', Comment = 'FRA="Date Début Doit Obligatoire"';
}

