xmlport 97900 "Copy Table SPE To Temp"
{
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table97901; Table97901)
            {
                AutoReplace = true;
                XmlName = 'UpgradeTableSPE';
                fieldelement(Source; "Upgrade Table SPE"."Table Source")
                {
                }
                fieldelement(Cible; "Upgrade Table SPE"."Table Cible")
                {
                }
                fieldelement(Type; "Upgrade Table SPE".Type)
                {
                }
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

