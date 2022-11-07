pageextension 50014 pageextension50014 extends "Posted Purchase Receipt"
{
    // Début Modif JX-XAD du 05/08/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
    // Ajout du champ "Code utilisateur"
    // 
    // ------------------------------ V1.2 ---------------------------
    // CREATION JX-XAD 26/02/2010
    // Gestion des contrats : ajout du bouton "Contrat"
    // 
    // MODIF JX-XAD 04/05/2010
    // Ajout du bouton "Modifier axes analytiques"
    // 
    // //Modif JX-AUD du 17/02/2012
    // //Ajout du Champs "Matricule" et traitement de celui-ci
    layout
    {
        addafter("Control 16")
        {
            field("User ID"; "User ID")
            {
                Caption = 'Code utilisateur :';
                Editable = false;
            }
            field("Matricule No."; "Matricule No.")
            {
                Editable = false;
            }
        }
        moveafter("Control 54"; "Control 6")
    }
    actions
    {

        //Unsupported feature: Property Insertion (AccessByPermission) on "Action 77".

        addafter("Action 99")
        {
            action(Contract)
            {
                Caption = 'Contract';
                RunObject = Page 50019;
                RunPageLink = Order No.=FIELD(Order No.);
            }
            group("&Line")
            {
                Caption = '&Line';
                separator()
                {
                }
            }
        }
    }

    var
        UserMgt: Codeunit "5700";
        Grec_PurchRcptLine: Record "121";
        ModifierAxesReception: Report "50039";


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetSecurityFilterOnRespCenter;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        //Début Modif JX-XAD du 05/08/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        FILTERGROUP(2);
        SETFILTER("User ID",UserMgt.jx_GetPurchasesFilter);
        FILTERGROUP(0);
        //Fin Modif JX-XAD du 05/08/2008

        SetSecurityFilterOnRespCenter;
        */
    //end;
}

