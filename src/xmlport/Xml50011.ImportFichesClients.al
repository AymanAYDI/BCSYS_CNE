xmlport 50011 "BC6_Import Fiches Clients"
{
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(customer; Customer)
            {
                XmlName = 'Customer';
                fieldelement(No; Customer."No.")
                {
                    Width = 20;
                }
                textelement(datecreation)
                {
                    XmlName = 'DateCreation';
                }
                textelement(gpecompt1)
                {
                    XmlName = 'GpeCompt1';
                }
                textelement(gpecompt2)
                {
                    XmlName = 'GpeCompt2';
                }
                fieldelement(BilltoCustomerNo; Customer."Bill-to Customer No.")
                {
                    Width = 20;
                }
                fieldelement(Name; Customer.Name)
                {
                    Width = 30;
                }
                fieldelement(Name2; Customer."Name 2")
                {
                    Width = 30;
                }
                fieldelement(Address; Customer.Address)
                {
                    Width = 30;
                }
                fieldelement(Address2; Customer."Address 2")
                {
                }
                textelement(address3)
                {
                    XmlName = 'Address3';
                }
                textelement(cpville)
                {
                    XmlName = 'CpVille';
                }
                fieldelement(PostCode; Customer."Post Code")
                {
                    Width = 20;
                }
                fieldelement(City; Customer.City)
                {
                    Width = 30;
                }
                fieldelement(CountryCode; Customer."Country/Region Code")
                {
                    Width = 10;
                }
                fieldelement(TerritoryCode; Customer."Territory Code")
                {
                    Width = 10;
                }
                fieldelement(PhoneNo; Customer."Phone No.")
                {
                    Width = 30;
                }
                fieldelement(FaxNo; Customer."Fax No.")
                {
                    Width = 30;
                }
                fieldelement(TelexNo; Customer."Telex No.")
                {
                    Width = 30;
                }
                fieldelement(VATRegistrationNo; Customer."VAT Registration No.")
                {
                    Width = 30;
                }
                fieldelement(CodeSIREN; Customer."BC6_Code SIREN")
                {
                    Width = 14;
                }
                textelement(txescompte)
                {
                    XmlName = 'TxEscompte';
                }
                textelement(moderegl)
                {
                    XmlName = 'ModeRegl';
                }
                fieldelement(ShipmentMethodCode; Customer."Shipment Method Code")
                {
                    Width = 10;
                }
                fieldelement(CurrencyCode; Customer."Currency Code")
                {
                    Width = 10;
                }
                fieldelement(CreditLimitLCY; Customer."Credit Limit (LCY)")
                {
                    Width = 12;
                }
                fieldelement(SalespersonCode; Customer."Salesperson Code")
                {
                    Width = 10;
                }
                fieldelement(VATBusPostingGroup; Customer."VAT Bus. Posting Group")
                {
                    Width = 10;
                }
                fieldelement(LanguageCode; Customer."Language Code")
                {
                    Width = 10;
                }
                fieldelement(CustomerPriceGroup; Customer."Customer Price Group")
                {
                    Width = 10;
                }

                trigger OnBeforeInsertRecord()
                begin
                    Customer."Customer Posting Group" := GpeCompt1 + GpeCompt2;
                    IF (Customer."Bill-to Customer No." = Customer."No.") THEN
                        Customer."Bill-to Customer No." := ''
                    ELSE
                        Customer."Bill-to Customer No." := Customer."Bill-to Customer No.";
                    IF ((Customer."Country/Region Code" = '') OR (Customer."Country/Region Code" = 'FRA')) THEN
                        Customer."Country/Region Code" := 'FR'
                    ELSE
                        Customer."Country/Region Code" := Customer."Country/Region Code";
                    Customer."Payment Terms Code" := ModeRegl;
                    Customer."Payment Method Code" := ModeRegl;
                    IF ((Customer."Currency Code" = 'EUR') OR (Customer."Currency Code" = 'FRF')) THEN
                        Customer."Currency Code" := ''
                    ELSE
                        Customer."Currency Code" := Customer."Currency Code";
                    IF Customer."VAT Bus. Posting Group" = 'O' THEN BEGIN
                        Customer."VAT Bus. Posting Group" := 'NATIONAL';
                        Customer."Gen. Bus. Posting Group" := 'NATIONAL';
                    END
                    ELSE
                        Customer."Gen. Bus. Posting Group" := '';
                    Customer."Language Code" := 'FRA'
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

