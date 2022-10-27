tableextension 50085 tableextension50085 extends "Warehouse Basic Cue"
{
    fields
    {
        modify("Released Sales Orders - Today")
        {

            //Unsupported feature: Property Modification (Name) on ""Released Sales Orders - Today"(Field 2)".


            //Unsupported feature: Property Modification (CalcFormula) on ""Released Sales Orders - Today"(Field 2)".

            Caption = 'Rlsd. Sales Orders Until Today';

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Released Sales Orders - Today"(Field 2)".

        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Posted Sales Shipments - Today"(Field 3)".

        modify("Expected Purch. Orders - Today")
        {

            //Unsupported feature: Property Modification (Name) on ""Expected Purch. Orders - Today"(Field 4)".


            //Unsupported feature: Property Modification (CalcFormula) on ""Expected Purch. Orders - Today"(Field 4)".

            Caption = 'Exp. Purch. Orders Until Today';

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Expected Purch. Orders - Today"(Field 4)".

        }
        modify("Posted Purch. Receipts - Today")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Posted Purch. Receipts - Today"(Field 5)".

            Caption = 'Posted Purch. Receipts - Today';
        }
        modify("Inventory Picks - Today")
        {

            //Unsupported feature: Property Modification (Name) on ""Inventory Picks - Today"(Field 6)".


            //Unsupported feature: Property Modification (CalcFormula) on ""Inventory Picks - Today"(Field 6)".

            Caption = 'Invt. Picks Until Today';
        }
        modify("Inventory Put-aways - Today")
        {

            //Unsupported feature: Property Modification (Name) on ""Inventory Put-aways - Today"(Field 7)".


            //Unsupported feature: Property Modification (CalcFormula) on ""Inventory Put-aways - Today"(Field 7)".

            Caption = 'Invt. Put-aways Until Today';
        }
        field(62000; "My Invt. Lines Until Today"; Integer)
        {
            CalcFormula = Count ("Item Journal Line" WHERE (Journal Template Name=FIELD(Journal Template Name Filter I),
                                                           Journal Batch Name=FIELD(Journal Batch Name Filter Inv)));
            Caption = 'My Invt. Lines Until Today';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62001;"My Reclass. Lines Until Today";Integer)
        {
            CalcFormula = Count("Item Journal Line" WHERE (Journal Template Name=FIELD(Journal Template Name Filter R),
                                                           Journal Batch Name=FIELD(Journal Batch Name Filter Rec)));
            Caption = 'My Reclass. Lines Until Today';
            Editable = false;
            FieldClass = FlowField;
        }
        field(63000;"Journal Batch Name Filter Inv";Code[10])
        {
            Caption = 'Journal Batch Name Filter Inv';
            FieldClass = FlowFilter;
            TableRelation = "Item Journal Batch";
        }
        field(63001;"Journal Batch Name Filter Rec";Code[10])
        {
            Caption = 'Journal Batch Name Filter Rec';
            FieldClass = FlowFilter;
            TableRelation = "Item Journal Batch";
        }
        field(63002;"Journal Template Name Filter I";Code[10])
        {
            Caption = 'Journal Template Name Filter I';
            FieldClass = FlowFilter;
            TableRelation = "Item Journal Template";
        }
        field(63003;"Journal Template Name Filter R";Code[10])
        {
            Caption = 'Journal Template Name Filter R';
            FieldClass = FlowFilter;
            TableRelation = "Item Journal Template";
        }
        field(63004;"Upcoming Orders";Integer)
        {
            AccessByPermission = TableData 120=R;
            CalcFormula = Count("Purchase Header" WHERE (Document Type=FILTER(Order),
                                                         Status=FILTER(Released)));
            Caption = 'Upcoming Orders';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

