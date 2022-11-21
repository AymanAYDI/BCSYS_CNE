tableextension 50069 "BC6_ResponsibilityCenter" extends "Responsibility Center" //5714
{
    fields
    {
        field(50000; BC6_Picture; BLOB)
        {
            Caption = 'Picture', Comment = 'FRA="Image"';
            SubType = Bitmap;
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Alt Name"; Text[50])
        {
            Caption = 'Name', Comment = 'FRA="Alt Nom"';
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Alt Name 2"; Text[50])
        {
            Caption = 'Name 2', Comment = 'FRA="Alt Nom 2"';
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Alt Address"; Text[50])
        {
            Caption = 'Address', Comment = 'FRA="Alt Adresse"';
            DataClassification = CustomerContent;
        }
        field(50004; "BC6_Alt Address 2"; Text[50])
        {
            Caption = 'Address 2', Comment = 'FRA="Alt Adresse (2ème ligne)"';
            DataClassification = CustomerContent;
        }
        field(50005; "BC6_Alt City"; Text[30])
        {
            Caption = 'City', Comment = 'FRA="Alt Ville"';
            TableRelation = IF ("BC6_Alt Country Code" = CONST()) "Post Code".City
            ELSE
            IF ("BC6_Alt Country Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("BC6_Alt Country Code"));
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                TxtLCounty: Text[30];
            begin
                //>>MIGRATION NAV 2013
                //OLD PostCode.ValidateCity("Alt City","Alt Post Code");
                PostCode.ValidateCity("BC6_Alt City", "BC6_Alt Post Code", TxtLCounty, "BC6_Alt Country Code", (CurrFieldNo <> 0) AND GUIALLOWED);
                //<<MIGRATION NAV 2013
            end;
        }
        field(50006; "BC6_Alt Phone No."; Text[20])
        {
            Caption = 'Phone No.', Comment = 'FRA="Alt N° téléphone"';
            DataClassification = CustomerContent;
        }
        field(50007; "BC6_Alt Phone No. 2"; Text[20])
        {
            Caption = 'Phone No. 2', Comment = 'FRA="Alt N° téléphone 2"';
            DataClassification = CustomerContent;
        }
        field(50008; "BC6_Alt Telex No."; Text[20])
        {
            Caption = 'Telex No.', Comment = 'FRA="Alt N° télex"';
            DataClassification = CustomerContent;
        }
        field(50009; "BC6_Alt Fax No."; Text[20])
        {
            Caption = 'Fax No.', Comment = 'FRA="Alt N° télécopie"';
            DataClassification = CustomerContent;
        }
        field(50010; "BC6_Alt Post Code"; Code[20])
        {
            Caption = 'Post Code', Comment = 'FRA="Alt Code postal"';
            TableRelation = IF ("BC6_Alt Country Code" = CONST()) "Post Code"
            ELSE
            IF ("BC6_Alt Country Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("BC6_Alt Country Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                //>>MIGRATION NAV 2013
                //OLDPostCode.LookUpPostCode("Alt City","Alt Post Code",TRUE);
                //<<MIGRATION NAV 2013
            end;

            trigger OnValidate()
            var
                TxtLCounty: Text[30];
            begin
                //>>MIGRATION NAV 2013
                //OLD PostCode.ValidatePostCode("Alt City","Alt Post Code");
                PostCode.ValidatePostCode("BC6_Alt City", "BC6_Alt Post Code", TxtLCounty, "BC6_Alt Country Code", (CurrFieldNo <> 0) AND GUIALLOWED);
                //<<MIGRATION NAV 2013
            end;
        }
        field(50011; "BC6_Alt E-Mail"; Text[80])
        {
            Caption = 'E-Mail', Comment = 'FRA="Alt E-mail"';
            DataClassification = CustomerContent;
        }
        field(50012; "BC6_Alt Country Code"; Code[10])
        {
            Caption = 'Alt Code Pays', Comment = 'FRA="Alt Code Pays"';
            TableRelation = "Country/Region".Code;
            DataClassification = CustomerContent;
        }
        field(50013; "BC6_Alt Home Page"; Text[80])
        {
            Caption = 'Alt Home Page', Comment = 'FRA="Alt Page d''accueil"';
            DataClassification = CustomerContent;
        }
        field(50014; "BC6_Alt Picture"; BLOB)
        {
            Caption = 'Alt Picture', Comment = 'FRA="Alt Image"';
            SubType = Bitmap;
            DataClassification = CustomerContent;
        }
    }

    var
        PostCode: Record "Post Code";
}
