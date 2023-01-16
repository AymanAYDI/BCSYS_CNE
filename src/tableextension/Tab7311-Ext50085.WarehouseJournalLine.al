tableextension 50085 "BC6_WarehouseJournalLine" extends "Warehouse Journal Line" //7311
{
    fields
    {
        field(50046; "BC6_Whse. Document Type 2"; enum "BC6_Whse. Document Type 2")
        {
            Caption = 'Whse. Document Type', Comment = 'FRA="Type document magasin 2"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50047; "BC6_Whse. Document No. 2"; Code[20])
        {
            Caption = 'Whse. Document No.', Comment = 'FRA="N° document magasin 2"';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = IF ("BC6_Whse. Document Type 2" = CONST("Invt. Pick")) "Warehouse Activity Header"."No." WHERE(Type = CONST("Invt. Pick"));
        }
        field(50048; "BC6_Whse. Document Line No. 2"; Integer)
        {
            BlankZero = true;
            Caption = 'Whse. Document Line No.', Comment = 'FRA="N° ligne document mag. 2"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50050; "BC6_Source Type 2"; Integer)
        {
            Caption = 'Source Type 2', Comment = 'FRA="Type origine 2"';
            DataClassification = CustomerContent;
        }
        field(50051; "BC6_Source Subtype 2"; enum "BC6_Source Subtype 2")
        {
            Caption = 'Source Subtype', Comment = 'FRA="Sous-type origine 2"';
            DataClassification = CustomerContent;
            Editable = false;
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
}
