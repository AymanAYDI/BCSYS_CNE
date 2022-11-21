tableextension 50089 "BC6_WarehouseEntry" extends "Warehouse Entry" //7312
{
    fields
    {
        field(50046; "BC6_Whse. Document Type 2"; enum "BC6_Whse. Document Type 2")
        {
            Caption = 'Whse. Document Type', Comment = 'FRA="Type document magasin 2"';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //
            end;
        }
        field(50047; "BC6_Whse. Document No. 2"; Code[20])
        {
            Caption = 'Whse. Document No.', Comment = 'FRA="N° document magasin 2"';
            Editable = false;
            TableRelation = IF ("BC6_Whse. Document Type 2" = CONST("Invt. Pick")) "Warehouse Activity Header"."No." WHERE(Type = CONST("Invt. Pick"));
            DataClassification = CustomerContent;
        }
        field(50048; "BC6_Whse. Document Line No. 2"; Integer)
        {
            BlankZero = true;
            Caption = 'Whse. Document Line No.', Comment = 'FRA="N° ligne document mag. 2"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50050; "BC6_Source Type 2"; Integer)
        {
            Caption = 'Source Type 2', Comment = 'FRA="Type origine 2"';
            DataClassification = CustomerContent;
        }
        field(50051; "BC6_Source Subtype 2"; enum "BC6_Source Subtype 2")
        {
            Caption = 'Source Subtype', Comment = 'FRA="Sous-type origine 2"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50052; "BC6_Source No. 2"; Code[20])
        {
            Caption = 'Source No. 2', Comment = 'FRA="N° origine 2"';
            DataClassification = CustomerContent;
        }
        field(50053; "BC6_Source Line No. 2"; Integer)
        {
            BlankZero = true;
            Caption = 'Source Line No. 2', Comment = 'FRA="N° ligne origine 2"';
            DataClassification = CustomerContent;
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
