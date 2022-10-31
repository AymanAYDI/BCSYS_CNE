tableextension 50077 "BC6_WarehouseEntry" extends "Warehouse Entry"
{
    fields
    {
        modify(Description)
        {
            Caption = 'Description';
        }
        field(50046; "BC6_Whse. Document Type 2"; enum "BC6_Whse. Document Type 2")
        {
            Caption = 'Whse. Document Type';
            Description = 'CNE4.01';
            Editable = false;

            trigger OnValidate()
            begin
                //
            end;
        }
        field(50047; "BC6_Whse. Document No. 2"; Code[20])
        {
            Caption = 'Whse. Document No.';
            Description = 'CNE4.01';
            Editable = false;
            TableRelation = IF ("BC6_Whse. Document Type 2" = CONST("Invt. Pick")) "Warehouse Activity Header"."No." WHERE(Type = CONST("Invt. Pick"));
        }
        field(50048; "BC6_Whse. Document Line No. 2"; Integer)
        {
            BlankZero = true;
            Caption = 'Whse. Document Line No.';
            Description = 'CNE4.01';
            Editable = false;
        }
        field(50050; "BC6_Source Type 2"; Integer)
        {
            Caption = 'Source Type 2';
            Description = 'CNE4.02';
        }
        field(50051; "BC6_Source Subtype 2"; enum "BC6_Source Subtype 2")
        {
            Caption = 'Source Subtype';
            Description = 'CNE4.02';
            Editable = false;
        }
        field(50052; "BC6_Source No. 2"; Code[20])
        {
            Caption = 'Source No. 2';
            Description = 'CNE4.02';
        }
        field(50053; "BC6_Source Line No. 2"; Integer)
        {
            BlankZero = true;
            Caption = 'Source Line No. 2';
            Description = 'CNE4.02';
        }
    }
    keys
    {
        key(Key10; "BC6_Whse. Document Type 2", "BC6_Whse. Document No. 2")
        {
        }
        key(Key11; "Item No.")
        {
        }
    }
}

