tableextension 50060 "BC6_ResponsibilityCenter" extends "Responsibility Center"
{
    fields
    {
        field(50000; BC6_Picture; BLOB)
        {
            Caption = 'Picture';
            Description = 'CNE3.03';
            SubType = Bitmap;
        }
        field(50001; "BC6_Alt Name"; Text[50])
        {
            Caption = 'Name';
            Description = 'CNE3.03';
        }
        field(50002; "BC6_Alt Name 2"; Text[50])
        {
            Caption = 'Name 2';
            Description = 'CNE3.03';
        }
        field(50003; "BC6_Alt Address"; Text[50])
        {
            Caption = 'Address';
            Description = 'CNE3.03';
        }
        field(50004; "BC6_Alt Address 2"; Text[50])
        {
            Caption = 'Address 2';
            Description = 'CNE3.03';
        }
        field(50005; "BC6_Alt City"; Text[30])
        {
            Caption = 'City';
            Description = 'CNE3.03';
            TableRelation = IF ("BC6_Alt Country Code" = CONST()) "Post Code".City
            ELSE
            IF ("BC6_Alt Country Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("BC6_Alt Country Code"));

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
                // PostCode.ValidateCity("BC6_Alt City", "BC6_Alt Post Code", TxtLCounty, "BC6_Alt Country Code", (CurrFieldNo <> 0) AND GUIALLOWED); //TODO: Globol variabl
                //<<MIGRATION NAV 2013
            end;
        }
        field(50006; "BC6_Alt Phone No."; Text[20])
        {
            Caption = 'Phone No.';
            Description = 'CNE3.03';
        }
        field(50007; "BC6_Alt Phone No. 2"; Text[20])
        {
            Caption = 'Phone No. 2';
            Description = 'CNE3.03';
        }
        field(50008; "BC6_Alt Telex No."; Text[20])
        {
            Caption = 'Telex No.';
            Description = 'CNE3.03';
        }
        field(50009; "BC6_Alt Fax No."; Text[20])
        {
            Caption = 'Fax No.';
            Description = 'CNE3.03';
        }
        field(50010; "BC6_Alt Post Code"; Code[20])
        {
            Caption = 'Post Code';
            Description = 'CNE3.03';
            TableRelation = IF ("BC6_Alt Country Code" = CONST()) "Post Code"
            ELSE
            IF ("BC6_Alt Country Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("BC6_Alt Country Code"));
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
                // PostCode.ValidatePostCode("BC6_Alt City", "BC6_Alt Post Code", TxtLCounty, "BC6_Alt Country Code", (CurrFieldNo <> 0) AND GUIALLOWED); //TODO: Globol variabl
                //<<MIGRATION NAV 2013
            end;
        }
        field(50011; "BC6_Alt E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            Description = 'CNE3.03';
        }
        field(50012; "BC6_Alt Country Code"; Code[10])
        {
            Caption = 'Alt Code Pays';
            Description = 'CNE3.03';
            TableRelation = "Country/Region".Code;
        }
        field(50013; "BC6_Alt Home Page"; Text[80])
        {
            Description = 'CNE3.03';
        }
        field(50014; "BC6_Alt Picture"; BLOB)
        {
            Description = 'CNE3.03';
            SubType = Bitmap;
        }
    }
}

