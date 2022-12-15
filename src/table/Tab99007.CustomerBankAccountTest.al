table 99007 "BC6_Customer Bank Account Test"
{
    Caption = 'Customer Bank Account',comment='FRA="Compte bancaire client"';
    DataCaptionFields = "Customer No.", "Code", Name;
    DrillDownPageID = "Customer Bank Account List";
    LookupPageID = "Customer Bank Account List";

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.',comment='FRA="N° client"';
            NotBlank = true;
            TableRelation = Customer;
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code',comment='FRA="Code"';
            NotBlank = true;
        }
        field(3; Name; Text[30])
        {
            Caption = 'Name',comment='FRA="Nom"';
        }
        field(5; "Name 2"; Text[30])
        {
            Caption = 'Name 2',comment='FRA="Nom 2"';
        }
        field(6; Address; Text[30])
        {
            Caption = 'Address',comment='FRA="Adresse"';
        }
        field(7; "Address 2"; Text[30])
        {
            Caption = 'Address 2',comment='FRA="Adresse (2ème ligne)"';
        }
        field(8; City; Text[30])
        {
            Caption = 'City',comment='FRA="Ville"';
        }
        field(9; "Post Code"; Code[20])
        {
            Caption = 'Post Code',comment='FRA="Code postal"';
            TableRelation = "Post Code";
            //This property is currently not supported
            TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(10; Contact; Text[30])
        {
            Caption = 'Contact',comment='FRA="Contact"';
        }
        field(11; "Phone No."; Text[30])
        {
            Caption = 'Phone No.',comment='FRA="N° téléphone"';
        }
        field(12; "Telex No."; Text[20])
        {
            Caption = 'Telex No.',comment='FRA="N° télex"';
        }
        field(13; "Bank Branch No."; Text[20])
        {
            Caption = 'Bank Branch No.',comment='FRA="Code établissement"';
        }
        field(14; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.',comment='FRA="N° compte bancaire"';
        }
        field(15; "Transit No."; Text[20])
        {
            Caption = 'Transit No.',comment='FRA="N° interne"';
        }
        field(16; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code',comment='FRA="Code devise"';
            TableRelation = Currency;
        }
        field(17; "Country Code"; Code[10])
        {
            Caption = 'Country Code',comment='FRA="Code pays"';
            TableRelation = "Country/Region";
        }
        field(18; County; Text[30])
        {
            Caption = 'County',comment='FRA="Région"';
        }
        field(19; "Fax No."; Text[30])
        {
            Caption = 'Fax No.',comment='FRA="N° télécopie"';
        }
        field(20; "Telex Answer Back"; Text[20])
        {
            Caption = 'Telex Answer Back',comment='FRA="Télex retour"';
        }
        field(21; "Language Code"; Code[10])
        {
            Caption = 'Language Code',comment='FRA="Code langue"';
            TableRelation = Language;
        }
        field(22; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail',comment='FRA="E-mail"';
        }
        field(23; "Home Page"; Text[80])
        {
            Caption = 'Home Page',comment='FRA="Page d''accueil"';
        }
        field(24; IBAN; Code[50])
        {
            Caption = 'IBAN',comment='FRA="IBAN"';

        }
        field(25; "SWIFT Code"; Code[20])
        {
            Caption = 'SWIFT Code',comment='FRA="Code SWIFT"';
        }
        field(10851; "Agency Code"; Text[20])
        {
            Caption = 'Agency Code',comment='FRA="Code agence"';
        }
        field(10852; "RIB Key"; Integer)
        {
            Caption = 'RIB Key',comment='FRA="Clé RIB"';
        }
        field(10853; "RIB Checked"; Boolean)
        {
            Caption = 'RIB Checked',comment='FRA="Vérification RIB"';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Customer No.", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

}

