pageextension 50050 pageextension50050 extends "Vendor Bank Account Card"
{
    // //Modif LAB du 26/05/2010
    // //Ajout du champ Modification du RIB/IBAN
    // 
    // ---------------------------- V1.2 ----------------------------
    // 
    // //Ajout JX-XAD le 15/06/2010 (fait le 15/10/2010)
    // //Ajout de la fonction "Dupliquer" dans le menu Banque
    layout
    {
        addafter("Control 1120004")
        {
            field("Change RIB/IBAN"; "Change RIB/IBAN")
            {
            }
        }
        addafter("Control 30")
        {
            field("Bank Clearing Standard"; "Bank Clearing Standard")
            {
            }
            field("Bank Clearing Code"; "Bank Clearing Code")
            {
            }
        }
        moveafter("Control 14"; "Control 18")
    }
    actions
    {
        addfirst(navigation)
        {
            group("&Bank Acc.")
            {
                Caption = '&Bank Acc.';
            }
            separator()
            {
            }
            action("Dupliquer vers une autre société")
            {
                Caption = 'Dupliquer vers une autre société';

                trigger OnAction()
                begin
                    //DEBUT MODIF JX-XAD 15/06/2010
                    GForm_Dupliquer.initialiser(Gopt_TypeFiche::VendorBankAccount, "Vendor No.", Code);
                    GForm_Dupliquer.RUNMODAL;
                    CLEAR(GForm_Dupliquer);
                    //FIN MODIF JX-XAD 15/06/2010
                end;
            }
        }
    }

    var
        GForm_Dupliquer: Page "50013";
        Gopt_TypeFiche: Option ,Vendor,"G/L Account",Item,VendorBankAccount;
}

