xmlport 50030 "Import AdressesLivrasonClt T"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // ------------------------------------------------------------------------

    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table99005; Table99005)
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

