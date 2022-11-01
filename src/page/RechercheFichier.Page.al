page 50061 "Recherche Fichier"
{
    PageType = Card;

    layout
    {
        area(content)
        {
            group(Rechercher)
            {
                Caption = 'Rechercher';
                field(Init_Dir; Init_Dir)
                {
                    Caption = 'Initial Directory';
                    Enabled = true;
                }
                field(Filtre; Filtre)
                {
                    Caption = 'Filter';
                    Enabled = true;
                }
                field(File_Name; File_Name)
                {
                    Caption = 'File';
                    Enabled = true;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Init_Dir := 'C:\';
        Filtre := '*.Txt';
    end;

    var
        File_Name: Text[100];
        Filtre: Text[10];
        Init_Dir: Text[100];
        Text19062749: Label 'Filter';
        Text19016114: Label 'File';
}

