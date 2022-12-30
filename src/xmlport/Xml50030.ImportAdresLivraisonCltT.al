xmlport 50030 "BC6_Import AdresLivraisonCltT"
{
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;
    Caption = 'Import AdresLivraisonCltT';

    schema
    {
        textelement(Root)
        {
            tableelement("Ship-to Address Test"; "BC6_Ship-to Address Test")
            {
                XmlName = 'ShiptoAddressTest';
                fieldelement(Code; "Ship-to Address Test".Code)
                {
                }
                fieldelement(CustomerNo; "Ship-to Address Test".Name)
                {
                }
                fieldelement(Name; "Ship-to Address Test".Name)
                {
                }
                fieldelement(Address; "Ship-to Address Test".Address)
                {
                }
                fieldelement(Address2; "Ship-to Address Test"."Address 2")
                {
                }
                textelement(Adresse3)
                {
                }
                fieldelement(PostCode; "Ship-to Address Test"."Post Code")
                {
                }
                fieldelement(City; "Ship-to Address Test".City)
                {
                }
                fieldelement(CountryCode; "Ship-to Address Test"."Country Code")
                {
                }

                trigger OnBeforeInsertRecord()
                begin

                    IF (("Ship-to Address Test"."Country Code" = '') OR ("Ship-to Address Test"."Country Code" = 'FRA')) THEN
                        "Ship-to Address Test"."Country Code" := 'FR'
                    ELSE
                        "Ship-to Address Test"."Country Code" := "Ship-to Address Test"."Country Code"
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

