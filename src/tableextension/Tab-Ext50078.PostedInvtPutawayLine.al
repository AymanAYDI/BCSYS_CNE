tableextension 50078 "BC6_PostedInvtPutawayLine" extends "Posted Invt. Put-away Line"
{
    fields
    {
        field(50040; "BC6_Source No. 2"; Code[20])
        {
            Caption = 'Source No.';
            Description = 'CNE4.01';
            Editable = false;
            TableRelation = IF ("BC6_Source Document 2" = CONST("Sales Order")) "Sales Header"."No." WHERE("Document Type" = CONST(Order));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50041; "BC6_Source Line No. 2"; Integer)
        {
            BlankZero = true;
            Caption = 'Source Line No.';
            Description = 'CNE4.01';
            Editable = false;
        }
        field(50042; "BC6_Source Document 2"; enum "BC6_Source Document 2")
        {
            BlankZero = true;
            Caption = 'Source Document';
            Description = 'CNE4.01';
            Editable = false;
        }
        field(50043; "BC6_Source Bin Code"; Code[20])
        {
            Caption = 'Lien code emplacement origine';
            Description = 'CNE4.01';
            Editable = false;
        }
        field(50045; "BC6_Warehouse Comment"; Text[50])
        {
            Caption = 'Warehouse Comments';
            Description = 'CNE4.01';
        }
    }
}

