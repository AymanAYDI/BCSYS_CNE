page 50061 "BC6_Recherche Fichier"
{
    PageType = Card;
    UsageCategory = Administration;
    Caption = 'Recherche fichier';
    layout
    {
        area(content)
        {
            group(Rechercher)
            {
                field(Init_Dir; Init_Dir)
                {
                    Enabled = true;
                    ApplicationArea = All;
                    Caption = 'Repértoire Initiale';
                }
                field(Filtre; Filtre)
                {
                    Enabled = true;
                    ApplicationArea = All;
                    Caption = 'Filtre';
                }
                field(File_Name; File_Name)
                {
                    Enabled = true;
                    ApplicationArea = All;
                    Caption = 'Fichier';
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
        Filtre: Text[10];
        File_Name: Text[100];
        Init_Dir: Text[100];
}

