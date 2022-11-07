pageextension 50070 pageextension50070 extends "Purchase List"
{
    // Modif JX-LAB du 18/09/2008
    // ajout du champ "statut"
    // 
    // //Modif JX-AUD du 23/04/2013
    // //Ajout du champ Commentaire et libre
    // //Ajout Description Statut FAP
    // //Ajout du champ Montant à enregistrer
    // 
    // //Modif JX-AUD du 10/07/2013
    // //Ajout de la de la colonne Litige
    layout
    {
        addafter("Control 2")
        {
            field(Litige; Litige)
            {
            }
        }
        addafter("Control 6")
        {
            field("Your Reference"; "Your Reference")
            {
            }
            field("Free comment"; "Free comment")
            {
            }
            field("Status description"; "Status description")
            {
                Caption = 'FAP status description';
            }
            field("Register amount"; "Register amount")
            {
            }
            field(Status; Status)
            {
            }
            field("Matricule No."; "Matricule No.")
            {
            }
            field("Quote No."; "Quote No.")
            {
            }
            field("Document Date"; "Document Date")
            {
            }
            field("Lines Amount"; "Lines Amount")
            {
            }
        }
    }

    var
        UserMgt: Codeunit "5700";


        //Unsupported feature: Code Insertion on "OnOpenPage".

        //trigger OnOpenPage()
        //begin
        /*
        //Début Modif JX-XAD du 11/06/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        FILTERGROUP(2);
        SETFILTER("Assigned User ID",UserMgt.jx_GetPurchasesFilter);
        FILTERGROUP(0);
        //Fin Modif JX-XAD du 11/06/2008
        */
        //end;
}

