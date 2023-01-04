xmlport 50016 "BC6_Import RIB Vendeur"
{
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;
    Caption = 'Import RIB Vendeur';

    schema
    {
        textelement(Root)
        {
            tableelement("Vendor Bank Account"; "Vendor Bank Account")
            {
                XmlName = 'VendorBankAccount';
                textelement(NumVend)
                {
                }
                textelement(CodeVend)
                {
                }
                textelement(CodeEtab)
                {
                }
                textelement(Guichet)
                {
                }
                textelement(Compte)
                {
                }
                textelement(RIB)
                {
                }
                textelement(Nom)
                {
                }
                textelement(Nom2)
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    RibVend.Init();
                    RibVend.RESET();
                    RibVend."Vendor No." := NumVend;
                    RibVend.Code := CodeVend;
                    RibVend."Bank Branch No." := CodeEtab;
                    RibVend."Agency Code" := Guichet;
                    RibVend."Bank Account No." := Compte;
                    //RibVend."RIB Key":=RIB;
                    IF EVALUATE(RibVend."RIB Key", RIB) THEN;
                    RibVend.Name := Nom;
                    RibVend."Name 2" := Nom2;
                    RibVend.INSERT();
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

    trigger OnPostXmlPort()
    begin

        RibVend.SETRANGE(Code, '');
        IF RibVend.FIND('-') THEN
            RibVend.DELETE();
    end;

    var
        RibVend: Record "Vendor Bank Account";
}

