page 50061 "BC6_Recherche Fichier"
{
    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = All;
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
                    Caption = 'Init_Dir';
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
                    Caption = 'File_Name';
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

