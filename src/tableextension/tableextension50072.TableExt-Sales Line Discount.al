tableextension 50072 tableextension50072 extends "Sales Line Discount"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    //  //MARGEVENTE SM 15/10/06 NCS1.01 [FE024V1] Modif. champs : OptionString Type, SalesType, Code, Sales Code
    //                                            Ajout champ 50020 Profit %
    //                                            Ajout Profit% dans le key principal
    // 
    // //GESTION_REMISE FG 06/12/06 NSC1.01 Modification champ 1 nouvelle relation Fournisseur
    //                                                         21 nouvelle option
    // 
    // //>>CNE1.04
    //   FEP_ADVE_200711_21_A-DEROGATOIRE:SOBI 24/07/08 : add field 50010 Derogation No
    //                                                              50011 Added Discount %
    // 
    // ------------------------------------------------------------------------
    LookupPageID = 7004;
    fields
    {
        modify("Code")
        {
            TableRelation = IF (Type = CONST (Item)) Item
            ELSE
            IF (Type = CONST (Item Disc.Group)) "Item Discount Group"
                            ELSE IF (Type=CONST(Vendor)) Vendor;
            Description = 'MARGEVENTE SM 15/10/06 NCS1.01 [FE024V1] Ajout Table Relation "Item Sales Profit Group", NEWRELATION';
        }
        modify("Sales Code")
        {
            TableRelation = IF (Sales Type=CONST(Customer Disc. Group)) "Customer Discount Group"
                            ELSE IF (Sales Type=CONST(Customer)) Customer
                            ELSE IF (Sales Type=CONST(Campaign)) Campaign
                            ELSE IF (Sales Type=CONST(Customer Sales Profit Group)) "Customer Sales Profit Group";
            Description = 'MARGEVENTE SM 15/10/06 NCS1.01 [FE024V1] Ajout Table Relation "Customer Sales Profit Group"';
        }
        modify("Sales Type")
        {
            OptionCaption = 'Customer,Customer Disc. Group,All Customers,Campaign,Customer Sales Profit Group';

            //Unsupported feature: Property Modification (OptionString) on ""Sales Type"(Field 13)".

            Description = 'MARGEVENTE SM 15/10/06 NCS1.01 [FE024V1] Ajout OptionString"Customer Sales Profit Group"';
        }
        modify(Type)
        {
            OptionCaption = 'Item,Item Disc. Group,,,,,Vendor';

            //Unsupported feature: Property Modification (OptionString) on "Type(Field 21)".

            Description = 'NEWTYPE';
        }

        //Unsupported feature: Property Deletion (NotBlank) on "Code(Field 1)".



        //Unsupported feature: Code Modification on ""Starting Date"(Field 4).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ("Starting Date" > "Ending Date") AND ("Ending Date" <> 0D) THEN
              ERROR(Text000,FIELDCAPTION("Starting Date"),FIELDCAPTION("Ending Date"));

            IF CurrFieldNo = 0 THEN
              EXIT;
            IF "Sales Type" = "Sales Type"::Campaign THEN
              ERROR(Text003,FIELDCAPTION("Starting Date"),FIELDCAPTION("Ending Date"),FIELDCAPTION("Sales Type"),"Sales Type");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            //DateDebutOblig HJ 15/11/2006 NSC1.01 [24] Date Début Doit Etre Obligatoire
            #1..7
            */
        //end;
        field(50000;"Profit %";Decimal)
        {
            Description = 'MARGEVENTE SM 15/10/06 NCS1.01 [FE024V1] Ajout champ';
        }
        field(50010;"Dispensation No.";Code[20])
        {
            Caption = 'N° dérogation';
            Description = 'CNE1.04';

            trigger OnValidate()
            begin
                TESTFIELD("Sales Type","Sales Type"::Customer);
            end;
        }
        field(50011;"Added Discount %";Decimal)
        {
            Caption = '% remise complémentaire';
            Description = 'CNE1.04';

            trigger OnValidate()
            begin
                TESTFIELD("Dispensation No.");
            end;
        }
    }
    keys
    {
        key(Key1;"Code","Sales Code","Sales Type",Type,"Starting Date","Ending Date","Profit %")
        {
        }
    }

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: Brick)".


    var
        "-NSC1.01--": ;
        Text004: Label 'Date Début Doit Obligatoire';
}

