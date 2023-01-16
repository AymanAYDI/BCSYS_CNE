page 50061 "BC6_Recherche Fichier"
{
    ApplicationArea = All;
    Caption = 'Recherche fichier';
    PageType = Card;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(Rechercher)
            {
                field(Init_Dir; Init_Dir)
                {
                    ApplicationArea = All;
                    Caption = 'Repértoire Initiale';
                    Enabled = true;
                }
                field(Filtre; Filtre)
                {
                    ApplicationArea = All;
                    Caption = 'Filtre';
                    Enabled = true;
                }
                field(File_Name; File_Name)
                {
                    ApplicationArea = All;
                    Caption = 'Fichier';
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
        Filtre: Text[10];
        File_Name: Text[100];
        Init_Dir: Text[100];
}
