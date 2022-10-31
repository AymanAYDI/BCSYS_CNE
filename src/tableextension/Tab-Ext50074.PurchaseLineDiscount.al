tableextension 50074 "BC6_PurchaseLineDiscount" extends "Purchase Line Discount"
{
    fields
    {
        modify("Item No.")
        {
            Caption = 'Code';
        }
        modify("Unit of Measure Code")
        {
            TableRelation = IF (BC6_Type = CONST(Item)) "Item Unit of Measure"."Item No." WHERE("Item No." = FIELD("Item No."));
        }
        modify("Variant Code")
        {
            TableRelation = IF (BC6_Type = CONST(Item)) "Item Variant"."Item No." WHERE("Item No." = FIELD("Item No."));
        }
        field(50021; BC6_Type; enum "BC6_Purchase Line Disc. Type")
        {
            Caption = 'Type';
            Description = 'NEWTYPE';

            trigger OnValidate()
            begin
                IF xRec.BC6_Type <> BC6_Type THEN
                    VALIDATE("Item No.", '');
            end;
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Item No.,Vendor No.,Starting Date,Currency Code,Variant Code,Unit of Measure Code,Minimum Quantity"(Key)".

        // key(Key1; BC6_Type, "Item No.", "Vendor No.", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity") TODO:
        // {
        //     Clustered = true;
        // }
        // key(Key2; "Item No.", "Vendor No.", BC6_Type)
        // {
        // }
    }

    var
        Item: Record Item;
        "-NSC1.01-": Integer;
}

