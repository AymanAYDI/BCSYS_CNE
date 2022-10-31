tableextension 50085 "BC6_WarehouseBasicCue" extends "Warehouse Basic Cue"
{
    fields
    {

        field(62000; "BC6_My Invt. Lines Until Today"; Integer)
        {
            CalcFormula = Count("Item Journal Line" WHERE("Journal Template Name" = FIELD("BC6_Journal Template Name Filter I"),
                                                           "Journal Batch Name" = FIELD("BC6_Journal Batch Name Filter Inv")));
            Caption = 'My Invt. Lines Until Today';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62001; "BC6_My Reclass. Lines Until Today"; Integer)
        {
            CalcFormula = Count("Item Journal Line" WHERE("Journal Template Name" = FIELD("BC6_Journal Template Name Filter R"),
                                                           "Journal Batch Name" = FIELD("BC6_Journal Batch Name Filter Rec")));
            Caption = 'My Reclass. Lines Until Today';
            Editable = false;
            FieldClass = FlowField;
        }
        field(63000; "BC6_Journal Batch Name Filter Inv"; Code[10])
        {
            Caption = 'Journal Batch Name Filter Inv';
            FieldClass = FlowFilter;
            TableRelation = "Item Journal Batch";
        }
        field(63001; "BC6_Journal Batch Name Filter Rec"; Code[10])
        {
            Caption = 'Journal Batch Name Filter Rec';
            FieldClass = FlowFilter;
            TableRelation = "Item Journal Batch";
        }
        field(63002; "BC6_Journal Template Name Filter I"; Code[10])
        {
            Caption = 'Journal Template Name Filter I';
            FieldClass = FlowFilter;
            TableRelation = "Item Journal Template";
        }
        field(63003; "BC6_Journal Template Name Filter R"; Code[10])
        {
            Caption = 'Journal Template Name Filter R';
            FieldClass = FlowFilter;
            TableRelation = "Item Journal Template";
        }
        field(63004; "BC6_Upcoming Orders"; Integer)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = FILTER(Order),
                                                         Status = FILTER(Released)));
            Caption = 'Upcoming Orders';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

