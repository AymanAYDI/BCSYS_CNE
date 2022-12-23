tableextension 50019 "BC6_CompanyInformation" extends "Company Information" //79
{
    fields
    {
        field(50000; "BC6_Alt Picture"; BLOB)
        {
            Caption = 'Picture', comment = 'FRA="Alt Image"';
            SubType = Bitmap;
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Alt Name"; Text[50])
        {
            Caption = 'Name', comment = 'FRA="Alt Nom"';
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Alt Name 2"; Text[50])
        {
            Caption = 'Name 2', comment = 'FRA="Alt Nom 2"';
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Alt Address"; Text[50])
        {
            Caption = 'Address', comment = 'FRA="Alt Adresse"';
            DataClassification = CustomerContent;
        }
        field(50004; "BC6_Alt Address 2"; Text[50])
        {
            Caption = 'Address 2', Comment = 'FRA="Alt Adresse (2ème ligne)"';
            DataClassification = CustomerContent;
        }
        field(50005; "BC6_Alt City"; Text[30])
        {
            Caption = 'City', comment = 'FRA="Alt Ville"';
            TableRelation = IF ("BC6_Alt Country Code" = CONST()) "Post Code".City
            ELSE
            IF ("BC6_Alt Country Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("BC6_Alt Country Code"));
            DataClassification = CustomerContent;
            trigger onvalidate()
            var
                PostCode: Record "Post Code";
                TxtLAltCounty: Text[30];
            begin
                PostCode.ValidateCity("BC6_Alt City", "BC6_Alt Post Code", TxtLAltCounty, "BC6_Alt Country Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(50006; "BC6_Alt Phone No."; Text[20])
        {
            Caption = 'Phone No.', comment = 'FRA="Alt N° téléphone"';
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
            TableRelation = IF ("BC6_Alt Country Code" = CONST()) "Post Code".Code
            ELSE
            IF ("BC6_Alt Country Code" = FILTER(<> '')) "Post Code".Code WHERE("Country/Region Code" = FIELD("BC6_Alt Country Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                PostCode: Record "Post Code";
                TxtLAltCounty: Text[30];
            begin
                PostCode.ValidateCity("BC6_Alt City", "BC6_Alt Post Code", TxtLAltCounty, "BC6_Alt Country Code", (CurrFieldNo <> 0) AND GUIALLOWED);
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
            Caption = 'Home page', Comment = 'FRA="Page d''accueil"';
            DataClassification = CustomerContent;
        }
        field(50014; "BC6_Branch Company"; Boolean)
        {
            Caption = 'Branch Company', Comment = 'FRA="Société Filiale"';
            DataClassification = CustomerContent;
        }
        field(50015; "BC6_Purchaser E-Mail"; Text[80])
        {
            Caption = 'Purchaser E-Mail', Comment = 'FRA="Email Service achat"';
            DataClassification = CustomerContent;
        }
        field(50016; "BC6_Alt2 Name"; Text[50])
        {
            Caption = 'Name', Comment = 'FRA="Alt2 Nom"';
            DataClassification = CustomerContent;
        }
        field(50017; "BC6_Alt2 Phone No."; Text[20])
        {
            Caption = 'Phone No.', Comment = 'FRA="Alt2 N° téléphone"';
            DataClassification = CustomerContent;
        }
        field(50018; "BC6_Alt2 Fax No."; Text[20])
        {
            Caption = 'Fax No.', Comment = 'FRA="Alt2 N° télécopie"';
            DataClassification = CustomerContent;
        }
        field(50019; "BC6_Alt2 E-Mail"; Text[80])
        {
            Caption = 'E-Mail', comment = 'FRA="Alt2 E-mail"';
            DataClassification = CustomerContent;
        }
    }
}
