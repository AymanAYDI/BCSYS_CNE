pageextension 50019 pageextension50019 extends "Posted Purchase Credit Memo"
{
    // Début Modif JX-XAD du 05/08/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
    // 
    // JX-XAD 05/06/2009
    // Traduction en Anglais
    // 
    // MODIF JX-XAD 04/05/2010
    // Ajout d'un bouton "Modifier axes analytiques"
    // 
    // //Modif JX-AUD du 17/02/2012
    // //Ajout du Champs "Matricule" et traitement de celui-ci
    // 
    // //Modif JX-AUD du 10/07/2013
    // //Ajout du champ Litige

    //Unsupported feature: Property Insertion (Permissions) on ""Posted Purchase Credit Memo"(Page 140)".

    layout
    {
        addafter("Control 59")
        {
            field("Matricule No."; "Matricule No.")
            {
                Editable = false;
            }
        }
        addafter("Control 20")
        {
            field(Litige; Litige)
            {
            }
            field("BC No."; "BC No.")
            {
            }
            field("Yooz No."; "Yooz No.")
            {
            }
            field("Yooz Token link"; "Yooz Token link")
            {
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Insertion (AccessByPermission) on "Action 79".

        addafter("Action 88")
        {
            group("Modify dimension")
            {
                Caption = 'Modify dimension';
                action(period)
                {
                    Caption = 'period';

                    trigger OnAction()
                    begin
                        ModifierAxe.SetPostedCreditMemo(Rec);
                        ModifierAxe.RUNMODAL;
                        CLEAR(ModifierAxe);
                    end;
                }
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
        ModifierAxe: Report "50024";
        Grec_PurchCrMemoLine: Record "125";
        ModifierAxesAvoir: Report "50038";


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

