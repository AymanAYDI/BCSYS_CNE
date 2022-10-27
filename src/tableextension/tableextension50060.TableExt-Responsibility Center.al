tableextension 50060 tableextension50060 extends "Responsibility Center"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //>>CNE3.03
    // FED_ADV_ 20091005_CENTRE GESTION STANDARD: OR 13/01/2010 - RESPONSABILITY CENTER MANAGEMENT
    //                                                            Add Field ID 50000 to 50014
    // 
    // ------------------------------------------------------------------------
    LookupPageID = 5715;
    DrillDownPageID = 5715;
    fields
    {
        modify(City)
        {
            TableRelation = IF (Country/Region Code=CONST()) "Post Code".City
                            ELSE IF (Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Country/Region Code));
        }
        modify("Post Code")
        {
            TableRelation = IF (Country/Region Code=CONST()) "Post Code"
                            ELSE IF (Country/Region Code=FILTER(<>'')) "Post Code" WHERE (Country/Region Code=FIELD(Country/Region Code));
        }
        modify("E-Mail")
        {
            Caption = 'Email';
        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Contract Gain/Loss Amount"(Field 5901)".

        field(50000;Picture;BLOB)
        {
            Caption = 'Picture';
            Description = 'CNE3.03';
            SubType = Bitmap;
        }
        field(50001;"Alt Name";Text[50])
        {
            Caption = 'Name';
            Description = 'CNE3.03';
        }
        field(50002;"Alt Name 2";Text[50])
        {
            Caption = 'Name 2';
            Description = 'CNE3.03';
        }
        field(50003;"Alt Address";Text[50])
        {
            Caption = 'Address';
            Description = 'CNE3.03';
        }
        field(50004;"Alt Address 2";Text[50])
        {
            Caption = 'Address 2';
            Description = 'CNE3.03';
        }
        field(50005;"Alt City";Text[30])
        {
            Caption = 'City';
            Description = 'CNE3.03';
            TableRelation = IF (Alt Country Code=CONST()) "Post Code".City
                            ELSE IF (Alt Country Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Alt Country Code));

            trigger OnLookup()
            begin
                //>>MIGRATION NAV 2013
                //OLD PostCode.LookUpCity("Alt City","Alt Post Code",TRUE);
                //<<MIGRATION NAV 2013
            end;

            trigger OnValidate()
            var
                "- MIGNAV2013 -": Integer;
                TxtLCounty: Text[30];
            begin
                //>>MIGRATION NAV 2013
                //OLD PostCode.ValidateCity("Alt City","Alt Post Code");
                PostCode.ValidateCity("Alt City","Alt Post Code",TxtLCounty,"Alt Country Code",(CurrFieldNo <> 0) AND GUIALLOWED);
                //<<MIGRATION NAV 2013
            end;
        }
        field(50006;"Alt Phone No.";Text[20])
        {
            Caption = 'Phone No.';
            Description = 'CNE3.03';
        }
        field(50007;"Alt Phone No. 2";Text[20])
        {
            Caption = 'Phone No. 2';
            Description = 'CNE3.03';
        }
        field(50008;"Alt Telex No.";Text[20])
        {
            Caption = 'Telex No.';
            Description = 'CNE3.03';
        }
        field(50009;"Alt Fax No.";Text[20])
        {
            Caption = 'Fax No.';
            Description = 'CNE3.03';
        }
        field(50010;"Alt Post Code";Code[20])
        {
            Caption = 'Post Code';
            Description = 'CNE3.03';
            TableRelation = IF (Alt Country Code=CONST()) "Post Code"
                            ELSE IF (Alt Country Code=FILTER(<>'')) "Post Code" WHERE (Country/Region Code=FIELD(Alt Country Code));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //>>MIGRATION NAV 2013
                //OLDPostCode.LookUpPostCode("Alt City","Alt Post Code",TRUE);
                //<<MIGRATION NAV 2013
            end;

            trigger OnValidate()
            var
                "- MIGNAV2013 -": Integer;
                TxtLCounty: Text[30];
            begin
                //>>MIGRATION NAV 2013
                //OLD PostCode.ValidatePostCode("Alt City","Alt Post Code");
                PostCode.ValidatePostCode("Alt City","Alt Post Code",TxtLCounty,"Alt Country Code",(CurrFieldNo <> 0) AND GUIALLOWED);
                //<<MIGRATION NAV 2013
            end;
        }
        field(50011;"Alt E-Mail";Text[80])
        {
            Caption = 'E-Mail';
            Description = 'CNE3.03';
        }
        field(50012;"Alt Country Code";Code[10])
        {
            Caption = 'Alt Code Pays';
            Description = 'CNE3.03';
            TableRelation = Country/Region.Code;
        }
        field(50013;"Alt Home Page";Text[80])
        {
            Description = 'CNE3.03';
        }
        field(50014;"Alt Picture";BLOB)
        {
            Description = 'CNE3.03';
            SubType = Bitmap;
        }
    }

    //Unsupported feature: Property Insertion (Local) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: Brick)".

}

