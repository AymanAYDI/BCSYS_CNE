tableextension 50078 "BC6_PostedInvtPutawayLine" extends "Posted Invt. Put-away Line" //7341
{
    fields
    {
        field(50040; "BC6_Source No. 2"; Code[20])
        {
            Caption = 'Source No.', Comment = 'FRA="Lien n° origine"';
            Editable = false;
            TableRelation = IF ("BC6_Source Document 2" = CONST("Sales Order")) "Sales Header"."No." WHERE("Document Type" = CONST(Order));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(50041; "BC6_Source Line No. 2"; Integer)
        {
            BlankZero = true;
            Caption = 'Source Line No.', Comment = 'FRA="Lien n° ligne origine"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50042; "BC6_Source Document 2"; enum "BC6_Source Document 2")
        {
            BlankZero = true;
            Caption = 'Source Document', Comment = 'FRA="Lien document origine"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50043; "BC6_Source Bin Code"; Code[20])
        {
            Caption = 'Lien code emplacement origine', Comment = 'FRA="Lien code emplacement origine"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50045; "BC6_Warehouse Comment"; Text[50])
        {
            Caption = 'Warehouse Comments', Comment = 'FRA="Commentaire magasin"';
            DataClassification = CustomerContent;
        }
    }
}

