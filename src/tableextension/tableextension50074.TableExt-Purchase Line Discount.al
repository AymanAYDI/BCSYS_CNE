tableextension 50074 tableextension50074 extends "Purchase Line Discount"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // //GESTION_REMISE FG 06/12/06 NSC1.01
    //                              Création champ 50021
    // 
    //                              Modification champ 1 "Item No." --> Code
    //                                                    NotBlank --> No
    //                              TableRelation Item
    //                              --> IF (Type=CONST(Item)) Item ELSE IF (Type=CONST(Item Disc. Group)) "Item Discount Group"
    // 
    //                              Modification clé primaire
    //                                  Code,Vendor No.,Starting Date,Currency Code,Variant Code,Unit of Measure Code,Minimum Quantity
    //                              --> Type,Code,Vendor No.,Starting Date,Currency Code,Variant Code,Unit of Measure Code,Minimum Quantity
    // 
    //                              Modification champ 5400 TableRelation
    //                                  "Item Unit of Measure".Code WHERE (Item No.=FIELD(Item No.))
    //                              --> IF (Type=CONST(Item)) "Item Unit of Measure".Code WHERE (Item No.=FIELD(Code))
    // 
    //                              Modification champ 5700 TableRelation
    //                                  "Item Variant".Code WHERE (Item No.=FIELD(Item No.))
    //                              --> IF (Type=CONST(Item)) "Item Variant".Code WHERE (Item No.=FIELD(Code))
    // 
    // //>>CNE5.00
    // TDL.76:20131120/CSC - Add key on "Code,Vendor No.,Type"
    // 
    // ------------------------------------------------------------------------
    // BC6 > renommage champ 1 en "item no" et captions seulement en code
    LookupPageID = 7014;
    fields
    {
        modify("Item No.")
        {
            Caption = 'Code';
        }
        modify("Unit of Measure Code")
        {
            TableRelation = IF (Type = CONST (Item)) "Item Unit of Measure"."Item No." WHERE (Item No.=FIELD(Item No.));
        }
        modify("Variant Code")
        {
            TableRelation = IF (Type=CONST(Item)) "Item Variant"."Item No." WHERE (Item No.=FIELD(Item No.));
        }
        field(50021;Type;Option)
        {
            Caption = 'Type';
            Description = 'NEWTYPE';
            OptionCaption = 'Item,Item Disc. Group,All items';
            OptionMembers = Item,"Item Disc. Group","All items";

            trigger OnValidate()
            begin
                IF xRec.Type <> Type THEN
                  VALIDATE("Item No.",'');
            end;
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Item No.,Vendor No.,Starting Date,Currency Code,Variant Code,Unit of Measure Code,Minimum Quantity"(Key)".

        key(Key1;Type,"Item No.","Vendor No.","Starting Date","Currency Code","Variant Code","Unit of Measure Code","Minimum Quantity")
        {
            Clustered = true;
        }
        key(Key2;"Item No.","Vendor No.",Type)
        {
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TESTFIELD("Vendor No.");
        TESTFIELD("Item No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TESTFIELD("Vendor No.");
         //>>MIGRATION NAV 2013
        //STD TESTFIELD("Item No.");

        //GESTION_REMISE FG 06/12/06 NSC1.01
        //TESTFIELD(Code);
          IF Type <> Type :: "All items" THEN
            TESTFIELD("Item No.");
        //Fin GESTION_REMISE FG 06/12/06 NSC1.01
        //<<MIGRATION NAV 2013
        */
    //end;


    //Unsupported feature: Code Modification on "OnRename".

    //trigger OnRename()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TESTFIELD("Vendor No.");
        TESTFIELD("Item No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TESTFIELD("Vendor No.");
        //>>MIGRATION NAV 2013
        //STD TESTFIELD("Item No.");

        //GESTION_REMISE FG 06/12/06 NSC1.01
        //TESTFIELD(Code);
          IF Type <> Type :: "All items" THEN
            TESTFIELD("Item No.");
        //Fin GESTION_REMISE FG 06/12/06 NSC1.01
        //<<MIGRATION NAV 2013
        */
    //end;

    var
        "-NSC1.01-": Integer;
        Item: Record "27";
}

