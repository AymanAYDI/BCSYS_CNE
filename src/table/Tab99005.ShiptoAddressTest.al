table 99005 "BC6_Ship-to Address Test"
{
    Caption = 'Ship-to Address', Comment = 'FRA="Adresse destinataire"';
    DataCaptionFields = "Customer No.", Name, "Code";
    DataClassification = CustomerContent;
    LookupPageID = "Ship-to Address List";
    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.', comment = 'FRA="N° client"';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = Customer;
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code', comment = 'FRA="Code"';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(3; Name; Text[30])
        {
            Caption = 'Name', comment = 'FRA="Nom"';
            DataClassification = CustomerContent;
        }
        field(4; "Name 2"; Text[30])
        {
            Caption = 'Name 2', comment = 'FRA="Nom 2"';
            DataClassification = CustomerContent;
        }
        field(5; Address; Text[30])
        {
            Caption = 'Address', comment = 'FRA="Adresse"';
            DataClassification = CustomerContent;
        }
        field(6; "Address 2"; Text[30])
        {
            Caption = 'Address 2', comment = 'FRA="Adresse (2ème ligne)"';
            DataClassification = CustomerContent;
        }
        field(7; City; Text[30])
        {
            Caption = 'City', comment = 'FRA="Ville"';
            DataClassification = CustomerContent;
        }
        field(8; Contact; Text[30])
        {
            Caption = 'Contact', comment = 'FRA="Contact"';
            DataClassification = CustomerContent;
        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.', comment = 'FRA="N° téléphone"';
            DataClassification = CustomerContent;
        }
        field(10; "Telex No."; Text[30])
        {
            Caption = 'Telex No.', comment = 'FRA="N° télex"';
            DataClassification = CustomerContent;
        }
        field(30; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code', comment = 'FRA="Code condition livraison"';
            DataClassification = CustomerContent;
            TableRelation = "Shipment Method";
        }
        field(31; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code', comment = 'FRA="Code transporteur"';
            DataClassification = CustomerContent;
            TableRelation = "Shipping Agent";
        }
        field(32; "Place of Export"; Code[20])
        {
            Caption = 'Place of Export', comment = 'FRA="Lieu d''exportation"';
            DataClassification = CustomerContent;
        }
        field(35; "Country Code"; Code[10])
        {
            Caption = 'Country Code', comment = 'FRA="Code pays"';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(54; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified', comment = 'FRA="Date dern. modification"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(83; "Location Code"; Code[10])
        {
            Caption = 'Location Code', comment = 'FRA="Code magasin"';
            DataClassification = CustomerContent;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(84; "Fax No."; Text[30])
        {
            Caption = 'Fax No.', comment = 'FRA="N° télécopie"';
            DataClassification = CustomerContent;
        }
        field(85; "Telex Answer Back"; Text[20])
        {
            Caption = 'Telex Answer Back', comment = 'FRA="Télex retour"';
            DataClassification = CustomerContent;
        }
        field(91; "Post Code"; Code[20])
        {
            Caption = 'Post Code', comment = 'FRA="Code postal"';
            DataClassification = CustomerContent;
            TableRelation = "Post Code";
            ValidateTableRelation = false;
        }
        field(92; County; Text[30])
        {
            Caption = 'County', comment = 'FRA="Région"';
            DataClassification = CustomerContent;
        }
        field(102; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail', comment = 'FRA="E-mail"';
            DataClassification = CustomerContent;
        }
        field(103; "Home Page"; Text[80])
        {
            Caption = 'Home Page', comment = 'FRA="Page d''accueil"';
            DataClassification = CustomerContent;
        }
        field(108; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code', comment = 'FRA="Code zone recouvrement"';
            DataClassification = CustomerContent;
            TableRelation = "Tax Area";
        }
        field(109; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable', comment = 'FRA="Soumis à recouvrement"';
            DataClassification = CustomerContent;
        }
        field(5792; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code', comment = 'FRA="Code prestation transporteur"';
            DataClassification = CustomerContent;
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        }
        field(5900; "Service Zone Code"; Code[10])
        {
            Caption = 'Service Zone Code', comment = 'FRA="Code zone service"';
            DataClassification = CustomerContent;
            TableRelation = "Service Zone";
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
