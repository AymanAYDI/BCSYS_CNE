tableextension 50082 "BC6_CompanyInformation" extends "Company Information"
{
    fields
    {
        field(50000; "BC6_Alt Picture"; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(50001; "BC6_Alt Name"; Text[50])
        {
            Caption = 'Name';
        }
        field(50002; "BC6_Alt Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(50003; "BC6_Alt Address"; Text[50])
        {
            Caption = 'Address';
        }
        field(50004; "BC6_Alt Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(50005; "BC6_Alt City"; Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("BC6_Alt Country Code" = CONST()) "Post Code".City
            ELSE
            IF ("BC6_Alt Country Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("BC6_Alt Country Code"));

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
                // PostCode.ValidateCity("BC6_Alt City", "BC6_Alt Post Code", TxtLAltCounty, "BC6_Alt Country Code", (CurrFieldNo <> 0) AND GUIALLOWED); // TODO: function PostCode Declarer Global
            end;
        }
        field(50006; "BC6_Alt Phone No."; Text[20])
        {
            Caption = 'Phone No.';
        }
        field(50007; "BC6_Alt Phone No. 2"; Text[20])
        {
            Caption = 'Phone No. 2';
        }
        field(50008; "BC6_Alt Telex No."; Text[20])
        {
            Caption = 'Telex No.';
        }
        field(50009; "BC6_Alt Fax No."; Text[20])
        {
            Caption = 'Fax No.';
        }
        field(50010; "BC6_Alt Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF ("BC6_Alt Country Code" = CONST()) "Post Code".Code
            ELSE
            IF ("BC6_Alt Country Code" = FILTER(<> '')) "Post Code".Code WHERE("Country/Region Code" = FIELD("BC6_Alt Country Code"));
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
                // PostCode.ValidateCity("BC6_Alt City", "BC6_Alt Post Code", TxtLAltCounty, "BC6_Alt Country Code", (CurrFieldNo <> 0) AND GUIALLOWED); // TODO: function PostCode Declarer Global
            end;
        }
        field(50011; "BC6_Alt E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
        }
        field(50012; "BC6_Alt Country Code"; Code[10])
        {
            Caption = 'Alt Code Pays';
            TableRelation = "Country/Region".Code;
        }
        field(50013; "BC6_Alt Home Page"; Text[80])
        {
        }
        field(50014; "BC6_Branch Company"; Boolean)
        {
            Caption = 'Branch Company';
        }
        field(50015; "BC6_Purchaser E-Mail"; Text[80])
        {
            Caption = 'Purchaser E-Mail';
        }
        field(50016; "BC6_Alt2 Name"; Text[50])
        {
            Caption = 'Name';
        }
        field(50017; "BC6_Alt2 Phone No."; Text[20])
        {
            Caption = 'Phone No.';
        }
        field(50018; "BC6_Alt2 Fax No."; Text[20])
        {
            Caption = 'Fax No.';
        }
        field(50019; "BC6_Alt2 E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
        }
    }

}

