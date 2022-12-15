xmlport 59999 "Import/Export Source Code"
{

    schema
    {
        textelement(Root)
        {
            tableelement(Table230; Table230)
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
                fieldelement(Sim; "Source Code".Simulation)
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

