xmlport 50010 "BC6_Import Plan Comptable"
{
    Caption = 'Import Plan Comptable';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(glaccount; "G/L Account")
            {
                AutoReplace = true;
                XmlName = 'GLAccount';
                textelement(numcompte)
                {
                    XmlName = 'NumCompte';
                }
                textelement(libelle)
                {
                    XmlName = 'Libelle';
                }
                textelement(type)
                {
                    XmlName = 'Type';
                }
                textelement(exercice)
                {
                    XmlName = 'Exercice';
                }
                textelement(ligneblanresultat)
                {
                    XmlName = 'LigneBlanResultat';
                }
                textelement(classe)
                {
                    XmlName = 'Classe';
                }

                trigger OnBeforeInsertRecord()
                begin
                    GLAccount."No." := NumCompte;
                    GLAccount.Name := Libelle;
                    GLAccount."Account Type" := GLAccount."Account Type"::Posting;
                    GLAccount."Direct Posting" := TRUE;
                    //AAYDI
                    //IF (Classe <= 5) THEN GLAccount."Income/Balance" := 1
                    //ELSE GLAccount."Income/Balance":=0
                    //AAYDI
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
