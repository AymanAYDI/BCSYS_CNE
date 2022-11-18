tableextension 50093 "BC6_WarehouseBasicCue" extends "Warehouse Basic Cue" //9050
{
    fields
    {

        field(62000; "BC6_My Invt. Lines Until Today"; Integer)
        {
            CalcFormula = Count("Item Journal Line" WHERE("Journal Template Name" = FIELD("BC6_Journal Template Name Filter I"),
                                                           "Journal Batch Name" = FIELD("BC6_Journal Batch Name Filter Inv")));
            Caption = 'My Invt. Lines Until Today', Comment = 'FRA="Mes lignes prélèvements stock à ce jour"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62001; "BC6_My Reclass. Lines Until Today"; Integer)
        {
            CalcFormula = Count("Item Journal Line" WHERE("Journal Template Name" = FIELD("BC6_Journal Template Name Filter R"),
                                                           "Journal Batch Name" = FIELD("BC6_Journal Batch Name Filter Rec")));
            Caption = 'My Reclass. Lines Until Today', Comment = 'FRA="Mes lignes reclassement  stock à ce jour"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(63000; "BC6_Journal Batch Name Filter Inv"; Code[10])
        {
            Caption = 'Journal Batch Name Filter Inv', Comment = 'FRA="Nom feuille prélèvement"';
            FieldClass = FlowFilter;
            TableRelation = "Item Journal Batch";
        }
        field(63001; "BC6_Journal Batch Name Filter Rec"; Code[10])
        {
            Caption = 'Journal Batch Name Filter Rec', Comment = 'FRA="Nom feuille Reclassement"';
            FieldClass = FlowFilter;
            TableRelation = "Item Journal Batch";
        }
        field(63002; "BC6_Journal Template Name Filter I"; Code[10])
        {
            Caption = 'Journal Template Name Filter I', Comment = 'FRA="Nom modèle feuille Prélèvement"';
            FieldClass = FlowFilter;
            TableRelation = "Item Journal Template";
        }
        field(63003; "BC6_Journal Template Name Filter R"; Code[10])
        {
            Caption = 'Journal Template Name Filter R', Comment = 'FRA="Nom modèle feuille Reclassment"';
            FieldClass = FlowFilter;
            TableRelation = "Item Journal Template";
        }
        field(63004; "BC6_Upcoming Orders"; Integer)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = FILTER(Order),
                                                         Status = FILTER(Released)));
            Caption = 'Upcoming Orders', Comment = 'FRA="Commandes à venir"';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

