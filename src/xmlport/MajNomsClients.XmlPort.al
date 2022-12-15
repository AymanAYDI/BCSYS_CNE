xmlport 53008 "Maj Noms Clients"
{
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(customer; Table18)
            {
                XmlName = 'Customer';
                textelement(num)
                {
                    XmlName = 'num';
                }
                textelement(nom1)
                {
                    XmlName = 'nom1';
                }
                textelement(nom2)
                {
                    XmlName = 'nom2';
                }

                trigger OnBeforeInsertRecord()
                begin
                    IF Customer.GET(num) THEN BEGIN
                        Customer.Name := nom2;
                        Customer.MODIFY;
                    END;
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

