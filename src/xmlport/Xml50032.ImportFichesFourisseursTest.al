xmlport 50032 "Import Fiches Fourisseurs Test"
{
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Vendor Test"; "BC6_Vendor Test")
            {
                XmlName = 'VendorTest';
                fieldelement(No; "Vendor Test"."No.")
                {
                }
                textelement(DateCreation)
                {
                }
                textelement(GpeCompt1)
                {
                }
                textelement(GpeCompt2)
                {
                }
                fieldelement(Name; "Vendor Test".Name)
                {
                }
                fieldelement(Name2; "Vendor Test"."Name 2")
                {
                }
                fieldelement(Address; "Vendor Test".Address)
                {
                }
                fieldelement(Address2; "Vendor Test"."Address 2")
                {
                }
                textelement(Adresse3)
                {
                }
                fieldelement(PostCode; "Vendor Test"."Post Code")
                {
                }
                fieldelement(City; "Vendor Test".City)
                {
                }
                fieldelement(CountryCode; "Vendor Test"."Country Code")
                {
                }
                fieldelement(TerritoryCode; "Vendor Test"."Territory Code")
                {
                }
                fieldelement(PhoneNo; "Vendor Test"."Phone No.")
                {
                }
                fieldelement(FaxNo; "Vendor Test"."Fax No.")
                {
                }
                fieldelement(TelexNo; "Vendor Test"."Telex No.")
                {
                }
                fieldelement(VATRegistrationNo; "Vendor Test"."VAT Registration No.")
                {
                }
                textelement(ModeRegl)
                {
                }
                fieldelement(CurrencyCode; "Vendor Test"."Currency Code")
                {
                }
                textelement(Plafond)
                {
                }
                textelement(TvaFran)
                {
                }
                textelement(CodeAnalyt)
                {
                }
                textelement(MinCde)
                {
                }
                textelement(MinFranco)
                {
                }

                trigger OnBeforeInsertRecord()
                begin

                    "Vendor Test"."Vendor Posting Group" := GpeCompt1 + GpeCompt2;
                    IF (("Vendor Test"."Country Code" = '') OR ("Vendor Test"."Country Code" = 'FRA')) THEN
                        "Vendor Test"."Country Code" := 'FR'
                    ELSE
                        "Vendor Test"."Country Code" := "Vendor Test"."Country Code";
                    "Vendor Test"."Payment Terms Code" := ModeRegl;
                    "Vendor Test"."Payment Method Code" := ModeRegl;
                    IF (("Vendor Test"."Currency Code" = 'EUR') OR ("Vendor Test"."Currency Code" = 'FRF')) THEN
                        "Vendor Test"."Currency Code" := ''
                    ELSE
                        "Vendor Test"."Currency Code" := "Vendor Test"."Currency Code";
                    IF TvaFran = 'O' THEN BEGIN
                        "Vendor Test"."VAT Bus. Posting Group" := 'NATIONAL';
                        "Vendor Test"."Gen. Bus. Posting Group" := 'NATIONAL';
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

