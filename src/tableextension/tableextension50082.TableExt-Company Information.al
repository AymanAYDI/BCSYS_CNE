tableextension 50082 tableextension50082 extends "Company Information"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // // creation commercials States CASC 13/12/2006 [FE001].NSC1.01 : Add Fields
    //                                                                  50000 Alt Picture
    //                                                                  50001 Alt Name
    //                                                                  50002 Alt Name 2
    //                                                                  50003 Alt Address
    //                                                                  50004 Alt Address 2
    //                                                                  50005 Alt City
    //                                                                  50006 Alt Phone No.
    //                                                                  50007 Alt Phone No. 2
    //                                                                  50008 Alt Telex No.
    //                                                                  50009 Alt Fax No.
    //                                                                  50010 Alt Post Code
    //                                                                  50011 Alt E-Mail
    //                                                                  50012 Alt Country Code
    // // creation commercials States DARI 22/01/2007 [] NSC1.03      : Add Fields
    //                                                                  50013 Alt Home Page
    // //>> CNEIC : 06/2015 : ajout du champ 'Branch Company' pour gérer les sociétes filiales.
    fields
    {
        modify(City)
        {
            TableRelation = IF (Country/Region Code=CONST()) "Post Code".City
                            ELSE IF (Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Country/Region Code));
        }
        modify("Ship-to City")
        {
            TableRelation = IF (Ship-to Country/Region Code=CONST()) "Post Code".City
                            ELSE IF (Ship-to Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Ship-to Country/Region Code));
        }
        modify("Post Code")
        {
            TableRelation = IF (Country/Region Code=CONST()) "Post Code".Code
                            ELSE IF (Country/Region Code=FILTER(<>'')) "Post Code".Code WHERE (Country/Region Code=FIELD(Country/Region Code));
        }
        modify("Ship-to Post Code")
        {
            TableRelation = IF (Ship-to Country/Region Code=CONST()) "Post Code".Code
                            ELSE IF (Ship-to Country/Region Code=FILTER(<>'')) "Post Code".Code WHERE (Country/Region Code=FIELD(Ship-to Country/Region Code));
        }
        modify("E-Mail")
        {
            Caption = 'Email';
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""IC Partner Code"(Field 41)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""IC Inbox Type"(Field 42)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""IC Inbox Details"(Field 43)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Check-Avail. Period Calc."(Field 5791)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Check-Avail. Time Bucket"(Field 5792)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Cal. Convergence Time Frame"(Field 7601)".

        field(90;GLN;Code[13])
        {
            Caption = 'GLN';
            Numeric = true;

            trigger OnValidate()
            var
                GLNCalculator: Codeunit "1607";
            begin
                IF GLN <> '' THEN
                  IF NOT GLNCalculator.IsValidCheckDigit13(GLN) THEN
                    ERROR(GLNCheckDigitErr,FIELDCAPTION(GLN));
            end;
        }
        field(99;"Created DateTime";DateTime)
        {
            Caption = 'Created DateTime';
            Editable = false;
        }
        field(100;"Demo Company";Boolean)
        {
            Caption = 'Demo Company';
            Editable = false;
        }
        field(7602;"Show Chart On RoleCenter";Boolean)
        {
            Caption = 'Show Chart On RoleCenter';
        }
        field(50000;"Alt Picture";BLOB)
        {
            Caption = 'Picture';
            Description = 'NSC1.01';
            SubType = Bitmap;
        }
        field(50001;"Alt Name";Text[50])
        {
            Caption = 'Name';
            Description = 'NSC1.01';
        }
        field(50002;"Alt Name 2";Text[50])
        {
            Caption = 'Name 2';
            Description = 'NSC1.01';
        }
        field(50003;"Alt Address";Text[50])
        {
            Caption = 'Address';
            Description = 'NSC1.01';
        }
        field(50004;"Alt Address 2";Text[50])
        {
            Caption = 'Address 2';
            Description = 'NSC1.01';
        }
        field(50005;"Alt City";Text[30])
        {
            Caption = 'City';
            Description = 'NSC1.01';
            TableRelation = IF (Alt Country Code=CONST()) "Post Code".City
                            ELSE IF (Alt Country Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Alt Country Code));

            trigger OnLookup()
            begin
                //>>MIGRATION NAV 2013
                //OLD PostCode.LookUpCity("Alt City","Alt Post Code",TRUE);
            end;

            trigger OnValidate()
            var
                "- MIGNAV2013 -": Integer;
                TxtLAltCounty: Text[30];
            begin
                //>>MIGRATION NAV 2013
                //OLD PostCode.ValidateCity("Alt City","Alt Post Code");
                //NEW
                PostCode.ValidateCity("Alt City","Alt Post Code",TxtLAltCounty,"Alt Country Code",(CurrFieldNo <> 0) AND GUIALLOWED);
                //<<MIGRATION NAV 2013
            end;
        }
        field(50006;"Alt Phone No.";Text[20])
        {
            Caption = 'Phone No.';
            Description = 'NSC1.01';
        }
        field(50007;"Alt Phone No. 2";Text[20])
        {
            Caption = 'Phone No. 2';
            Description = 'NSC1.01';
        }
        field(50008;"Alt Telex No.";Text[20])
        {
            Caption = 'Telex No.';
            Description = 'NSC1.01';
        }
        field(50009;"Alt Fax No.";Text[20])
        {
            Caption = 'Fax No.';
            Description = 'NSC1.01';
        }
        field(50010;"Alt Post Code";Code[20])
        {
            Caption = 'Post Code';
            Description = 'NSC1.01';
            TableRelation = IF (Alt Country Code=CONST()) "Post Code".Code
                            ELSE IF (Alt Country Code=FILTER(<>'')) "Post Code".Code WHERE (Country/Region Code=FIELD(Alt Country Code));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //MIGRATION NAV 2013
                //OLD PostCode.LookUpPostCode("Alt City","Alt Post Code",TRUE);
            end;

            trigger OnValidate()
            var
                "- MIGNAV2013 -": Integer;
                TxtLAltCounty: Text[30];
            begin
                //>>MIGRATION NAV 2013
                //OLD PostCode.ValidateCity("Alt City","Alt Post Code");
                //NEW
                PostCode.ValidateCity("Alt City","Alt Post Code",TxtLAltCounty,"Alt Country Code",(CurrFieldNo <> 0) AND GUIALLOWED);
                //<<MIGRATION NAV 2013
            end;
        }
        field(50011;"Alt E-Mail";Text[80])
        {
            Caption = 'E-Mail';
            Description = 'NSC1.01';
        }
        field(50012;"Alt Country Code";Code[10])
        {
            Caption = 'Alt Code Pays';
            Description = 'NSC1.01';
            TableRelation = Country/Region.Code;
        }
        field(50013;"Alt Home Page";Text[80])
        {
            Description = 'NSC1.01';
        }
        field(50014;"Branch Company";Boolean)
        {
            Caption = 'Branch Company';
            Description = 'CNEIC';
        }
        field(50015;"Purchaser E-Mail";Text[80])
        {
            Caption = 'Purchaser E-Mail';
            Description = 'NSC1.01';
        }
        field(50016;"Alt2 Name";Text[50])
        {
            Caption = 'Name';
            Description = 'NSC1.01';
        }
        field(50017;"Alt2 Phone No.";Text[20])
        {
            Caption = 'Phone No.';
            Description = 'NSC1.01';
        }
        field(50018;"Alt2 Fax No.";Text[20])
        {
            Caption = 'Fax No.';
            Description = 'NSC1.01';
        }
        field(50019;"Alt2 E-Mail";Text[80])
        {
            Caption = 'E-Mail';
            Description = 'NSC1.01';
        }
    }

    //Unsupported feature: Property Insertion (Local) on "IsPaymentInfoAvailble(PROCEDURE 10)".



    //Unsupported feature: Code Modification on "GetControlSum(PROCEDURE 1120001)".

    //procedure GetControlSum();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        EVALUATE(SIREN,COPYSTR(DELCHR("Registration No."),1,9));
        ControlSum := (12 + 3 * SIREN MOD 97 ) MOD 97;
        EXIT(FORMAT(ControlSum,0,'<Integer,2><Filler,0>'));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ControlSum := (12 + 3 * (GetSIREN MOD 97)) MOD 97;
        EXIT(FORMAT(ControlSum,0,'<Integer,2><Filler,0>'));
        */
    //end;

    procedure GetRegistrationNumber(): Text
    begin
        EXIT("Registration No.");
    end;

    procedure GetRegistrationNumberLbl(): Text
    begin
        EXIT(FIELDCAPTION("Registration No."));
    end;

    procedure GetVATRegistrationNumber(): Text
    begin
        EXIT("VAT Registration No.");
    end;

    procedure GetVATRegistrationNumberLbl(): Text
    begin
        EXIT(FIELDCAPTION("VAT Registration No."));
    end;

    procedure GetLegalOffice(): Text
    begin
        EXIT('');
    end;

    procedure GetLegalOfficeLbl(): Text
    begin
        EXIT('');
    end;

    procedure GetCustomGiro(): Text
    begin
        EXIT('');
    end;

    procedure GetCustomGiroLbl(): Text
    begin
        EXIT('');
    end;

    procedure GetSIREN() Result: Integer
    begin
        EVALUATE(Result,COPYSTR(DELCHR("Registration No."),1,9));
    end;

    procedure GetCountryRegionCode(CountryRegionCode: Code[10]): Code[10]
    begin
        CASE CountryRegionCode OF
          '',"Country/Region Code":
            EXIT("Country/Region Code");
          ELSE
            EXIT(CountryRegionCode);
        END;
    end;

    procedure GetDevBetaModeTxt(): Text[250]
    begin
        EXIT(DevBetaModeTxt);
    end;

    //Unsupported feature: Deletion (VariableCollection) on "GetControlSum(PROCEDURE 1120001).SIREN(Variable 1120000)".


    var
        GLNCheckDigitErr: Label 'The %1 is not valid.';
        DevBetaModeTxt: Label 'DEV_BETA', Locked=true;
}

