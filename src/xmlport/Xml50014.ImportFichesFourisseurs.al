xmlport 50014 "BC6_Import Fiches Fourisseurs"
{
    Caption = 'Import Fiches Fourisseurs';
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Vendor; Vendor)
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'Vendors';
                fieldelement(No; Vendor."No.")
                {
                    Width = 20;
                }
                textelement(DateCreationTxt)
                {
                    Width = 0;
                }
                textelement(GpeCompt1)
                {
                    Width = 0;
                }
                textelement(GpeCompt2)
                {
                    Width = 0;
                }
                fieldelement(Name; Vendor.Name)
                {
                    Width = 30;
                }
                fieldelement(Name2; Vendor."Name 2")
                {
                    Width = 30;
                }
                fieldelement(Address; Vendor.Address)
                {
                    Width = 30;
                }
                fieldelement(Address2; Vendor."Address 2")
                {
                    Width = 30;
                }
                textelement(Adresse3)
                {
                    Width = 0;
                }
                fieldelement(PostCode; Vendor."Post Code")
                {
                    Width = 20;
                }
                textelement(CpVille)
                {
                    Width = 0;
                }
                fieldelement(CountryRegionCode; Vendor."Country/Region Code")
                {
                    Width = 10;
                }
                fieldelement(TerritoryCode; Vendor."Territory Code")
                {
                    Width = 10;
                }
                fieldelement(PhoneNo; Vendor."Phone No.")
                {
                    Width = 30;
                }
                fieldelement(FaxNo; Vendor."Fax No.")
                {
                    Width = 30;
                }
                fieldelement(TelexNo; Vendor."Telex No.")
                {
                    Width = 30;
                }
                fieldelement(VATRegistrationNo; Vendor."VAT Registration No.")
                {
                    Width = 30;
                }
                textelement(ModeRegl)
                {
                    Width = 0;
                }
                fieldelement(CurrencyCode; Vendor."Currency Code")
                {
                    Width = 10;
                }
                textelement(Plafond)
                {
                    Width = 0;
                }
                textelement(TvaFran)
                {
                    Width = 0;
                }
                textelement(CodeAnalyt)
                {
                    Width = 0;
                }
                fieldelement(MiniAmount; Vendor."BC6_Mini Amount")
                {
                    Width = 0;
                }
                textelement(MinFranco)
                {
                    Width = 0;
                }

                trigger OnBeforeInsertRecord()
                begin

                    Vendor."Vendor Posting Group" := GpeCompt1 + GpeCompt2;
                    IF ((Vendor."Country/Region Code" = '') OR (Vendor."Country/Region Code" = 'FRA')) THEN
                        Vendor."Country/Region Code" := 'FR'
                    ELSE
                        Vendor."Country/Region Code" := Vendor."Country/Region Code";
                    Vendor."Payment Terms Code" := ModeRegl;
                    Vendor."Payment Method Code" := ModeRegl;
                    IF ((Vendor."Currency Code" = 'EUR') OR (Vendor."Currency Code" = 'FRF')) THEN
                        Vendor."Currency Code" := ''
                    ELSE
                        Vendor."Currency Code" := Vendor."Currency Code";
                    IF TvaFran = 'O' THEN BEGIN
                        Vendor."VAT Bus. Posting Group" := 'NATIONAL';
                        Vendor."Gen. Bus. Posting Group" := 'NATIONAL';
                    END
                    ELSE
                        ;
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }
}
