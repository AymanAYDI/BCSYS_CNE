tableextension 50072 "BC6_SalesLineDiscount" extends "Sales Line Discount"
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
            Description = 'MARGEVENTE SM 15/10/06 NCS1.01 [FE024V1] Ajout Table Relation "Item Sales Profit Group", NEWRELATION';
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

            //Unsupported feature: Property Modification (OptionString) on "Type(Field 21)".

            Description = 'NEWTYPE';
        }


        field(50000; "BC6_Profit %"; Decimal)
        {
        }
        field(50010; "BC6_Dispensation No."; Code[20])
        {
            Caption = 'N° dérogation';

            trigger OnValidate()
            begin
                TESTFIELD("Sales Type", "Sales Type"::Customer);
            end;
        }
        field(50011; "BC6_Added Discount %"; Decimal)
        {
            Caption = '% remise complémentaire';

            trigger OnValidate()
            begin
                TESTFIELD("BC6_Dispensation No.");
            end;
        }
    }
    keys
    {
        // key(Key3; "Code", "Sales Code", "Sales Type", Type, "Starting Date", "Ending Date", "BC6_Profit %") // TODO: The property 'Key3' can only be set if the specified fields are from the same table.
        // {
        // }
    }

    var
        "-NSC1.01--": TextConst;
        Text004: Label 'Date Début Doit Obligatoire';
}

