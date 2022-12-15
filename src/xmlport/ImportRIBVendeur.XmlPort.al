xmlport 50016 "Import RIB Vendeur"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // //>>CNE1.00
    // FE0021.001:FAFU 28/12/2006 : Reprise de données
    //                              - Creation
    // ------------------------------------------------------------------------

    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table288; Table288)
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

                    RibVend.RESET;
                    RibVend."Vendor No." := NumVend;
                    RibVend.Code := CodeVend;
                    RibVend."Bank Branch No." := CodeEtab;
                    RibVend."Agency Code" := Guichet;
                    RibVend."Bank Account No." := Compte;
                    //RibVend."RIB Key":=RIB;
                    IF EVALUATE(RibVend."RIB Key", RIB) THEN;
                    RibVend.Name := Nom;
                    RibVend."Name 2" := Nom2;
                    RibVend.INSERT;
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
            RibVend.DELETE;
    end;

    var
        RibVend: Record "288";
}

