tableextension 50077 tableextension50077 extends "Warehouse Entry"
{
    // -----------------------------------------------
    // Prodware -www.prodware.fr
    // -----------------------------------------------
    // 
    // //>>MIGRATION NAV 2013
    // //>> CNE4.01
    // B:FE07 01.09.2011 : Invt Pick Card MiniForm
    //                   - Add Field 50046 Whse. Document Type 2
    //                   - Add Field 50047 Whse. Document No. 2
    //                   - Add Field 50048 Whse. Document Line No. 2
    LookupPageID = 7318;
    DrillDownPageID = 7318;
    fields
    {
        modify(Description)
        {
            Caption = 'Description';
        }
        field(50046; "Whse. Document Type 2"; Option)
        {
            Caption = 'Whse. Document Type';
            Description = 'CNE4.01';
            Editable = false;
            OptionCaption = ' ,Invt. Pick';
            OptionMembers = " ","Invt. Pick";

            trigger OnValidate()
            begin
                //
            end;
        }
        field(50047; "Whse. Document No. 2"; Code[20])
        {
            Caption = 'Whse. Document No.';
            Description = 'CNE4.01';
            Editable = false;
            TableRelation = IF (Whse. Document Type 2=CONST(Invt. Pick)) "Warehouse Activity Header".No. WHERE (Type=CONST(Invt. Pick));
        }
        field(50048; "Whse. Document Line No. 2"; Integer)
        {
            BlankZero = true;
            Caption = 'Whse. Document Line No.';
            Description = 'CNE4.01';
            Editable = false;
        }
        field(50050; "Source Type 2"; Integer)
        {
            Caption = 'Source Type 2';
            Description = 'CNE4.02';
        }
        field(50051; "Source Subtype 2"; Option)
        {
            Caption = 'Source Subtype';
            Description = 'CNE4.02';
            Editable = false;
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
        }
        field(50052; "Source No. 2"; Code[20])
        {
            Caption = 'Source No. 2';
            Description = 'CNE4.02';
        }
        field(50053; "Source Line No. 2"; Integer)
        {
            BlankZero = true;
            Caption = 'Source Line No. 2';
            Description = 'CNE4.02';
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Source Type,Source Subtype,Source No."(Key)".


        //Unsupported feature: Property Deletion (MaintainSIFTIndex) on ""Item No.,Bin Code,Location Code,Variant Code,Unit of Measure Code,Lot No.,Serial No.,Entry Type,Dedicated"(Key)".


        //Unsupported feature: Property Deletion (SIFTLevelsToMaintain) on ""Item No.,Location Code,Variant Code,Bin Type Code,Unit of Measure Code,Lot No.,Serial No.,Dedicated"(Key)".

        key(Key1; "Source Type", "Source Subtype", "Source No.", "Source Line No.", "Source Subline No.", "Source Document", "Bin Code")
        {
        }
        key(Key2; "Whse. Document Type 2", "Whse. Document No. 2")
        {
        }
        key(Key3; "Item No.")
        {
        }
    }

    procedure TrackingExists(): Boolean
    begin
        EXIT(("Lot No." <> '') OR ("Serial No." <> ''));
    end;
}

