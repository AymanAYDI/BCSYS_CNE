xmlport 59999 "Import/Export Source Code"
{

    schema
    {
        textelement(Root)
        {
            tableelement("Source Code"; "Source Code")
            {
                AutoReplace = true;
                AutoSave = true;
                XmlName = 'SourceCode';
                fieldelement(Code; "Source Code".Code)
                {
                }
                fieldelement(Desc; "Source Code".Description)
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

