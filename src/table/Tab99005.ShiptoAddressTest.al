table 99005 "BC6_Ship-to Address Test"
{
    Caption = 'Ship-to Address', Comment = 'FRA="Adresse destinataire"';
    DataCaptionFields = "Customer No.", Name, "Code";
    LookupPageID = "Ship-to Address List";

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.', comment = 'FRA="N° client"';
            NotBlank = true;
            TableRelation = Customer;
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code', comment = 'FRA="Code"';
            NotBlank = true;
        }
        field(3; Name; Text[30])
        {
            Caption = 'Name', comment = 'FRA="Nom"';
        }
        field(4; "Name 2"; Text[30])
        {
            Caption = 'Name 2', comment = 'FRA="Nom 2"';
        }
        field(5; Address; Text[30])
        {
            Caption = 'Address', comment = 'FRA="Adresse"';
        }
        field(6; "Address 2"; Text[30])
        {
            Caption = 'Address 2', comment = 'FRA="Adresse (2ème ligne)"';
        }
        field(7; City; Text[30])
        {
            Caption = 'City', comment = 'FRA="Ville"';
        }
        field(8; Contact; Text[30])
        {
            Caption = 'Contact', comment = 'FRA="Contact"';
        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.', comment = 'FRA="N° téléphone"';
        }
        field(10; "Telex No."; Text[30])
        {
            Caption = 'Telex No.', comment = 'FRA="N° télex"';
        }
        field(30; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code', comment = 'FRA="Code condition livraison"';
            TableRelation = "Shipment Method";
        }
        field(31; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code', comment = 'FRA="Code transporteur"';
            TableRelation = "Shipping Agent";
        }
        field(32; "Place of Export"; Code[20])
        {
            Caption = 'Place of Export', comment = 'FRA="Lieu d''exportation"';
        }
        field(35; "Country Code"; Code[10])
        {
            Caption = 'Country Code', comment = 'FRA="Code pays"';
            TableRelation = "Country/Region";
        }
        field(54; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified', comment = 'FRA="Date dern. modification"';
            Editable = false;
        }
        field(83; "Location Code"; Code[10])
        {
            Caption = 'Location Code', comment = 'FRA="Code magasin"';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(84; "Fax No."; Text[30])
        {
            Caption = 'Fax No.', comment = 'FRA="N° télécopie"';
        }
        field(85; "Telex Answer Back"; Text[20])
        {
            Caption = 'Telex Answer Back', comment = 'FRA="Télex retour"';
        }
        field(91; "Post Code"; Code[20])
        {
            Caption = 'Post Code', comment = 'FRA="Code postal"';
            TableRelation = "Post Code";
            ValidateTableRelation = false;
        }
        field(92; County; Text[30])
        {
            Caption = 'County', comment = 'FRA="Région"';
        }
        field(102; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail', comment = 'FRA="E-mail"';
        }
        field(103; "Home Page"; Text[80])
        {
            Caption = 'Home Page', comment = 'FRA="Page d''accueil"';
        }
        field(108; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code', comment = 'FRA="Code zone recouvrement"';
            TableRelation = "Tax Area";
        }
        field(109; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable', comment = 'FRA="Soumis à recouvrement"';
        }
        field(5792; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code', comment = 'FRA="Code prestation transporteur"';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        }
        field(5900; "Service Zone Code"; Code[10])
        {
            Caption = 'Service Zone Code', comment = 'FRA="Code zone service"';
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

