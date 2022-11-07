pageextension 50016 pageextension50016 extends "Posted Purchase Invoice"
{
    // Début Modif JX-XAD du 05/08/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
    // 
    // JX-XAD 05/06/2009
    // Traduction en Anglais
    // 
    // ------------------------------------ V1.2 ------------------------------------
    // 
    // Modif JX-XAD du 19/11/2009
    // Ajout des champs :
    // - Utilisateur initial
    // - Date de création
    // - Date de réception facture
    // 
    // ------------------------------ V1.2 ---------------------------
    // CREATION JX-XAD 26/02/2010
    // Gestion des contrats : ajout du bouton "Contrat"
    // 
    // MODIF JX-XAD 23/03/2010
    // Mise à jour des axes analytiques dans les documents enregistrés
    // 
    // Modif JX-AUD 10/10/2011
    // Remise en place du filtre sur Receipt pour avoir l'historique des mails
    // 
    // //Modif JX-AUD du 17/02/2012
    // //Ajout du Champs "Matricule" et traitement de celui-ci
    // 
    // //JX-AUD du 01/07/2013
    // //Ajout du champ Litige
    // 
    // //JX-AUD du 24/02/2015
    // Ajout des champs N°BC, N° Yooz, Lien token Yooz en non éditable

    //Unsupported feature: Property Insertion (Permissions) on ""Posted Purchase Invoice"(Page 138)".

    layout
    {
        addafter("Control 16")
        {
            field("Original user"; "Original user")
            {
                Editable = false;
            }
            field("User ID"; "User ID")
            {
                Editable = false;
            }
            field("Matricule No."; "Matricule No.")
            {
                Editable = false;
            }
            field(Litige; Litige)
            {
            }
        }
        addafter("Control 71")
        {
            field("Creation date"; "Creation date")
            {
                Editable = false;
            }
            field("Invoice receipt date"; "Invoice receipt date")
            {
                Editable = false;
            }
        }
        addafter("Control 92")
        {
            field("BC No."; "BC No.")
            {
            }
            field("Yooz No."; "Yooz No.")
            {
            }
            field("Yooz Token link"; "Yooz Token link")
            {
                ExtendedDatatype = URL;
            }
        }
        addafter("Control 28")
        {
            field("Vendor Posting Group"; "Vendor Posting Group")
            {
                Editable = false;
            }
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                Editable = false;
            }
            field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
            {
                Editable = false;
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Insertion (AccessByPermission) on "Action 89".

        addafter("Action 106")
        {
            group("Modify dimension")
            {
                Caption = 'Modify dimension';
                action(Period)
                {
                    Caption = 'Period';

                    trigger OnAction()
                    begin
                        ModifierAxe.SetPostedInvoice(Rec);
                        ModifierAxe.RUNMODAL;
                        CLEAR(ModifierAxe);
                    end;
                }
            }
            action(Historic)
            {
                Caption = 'Historic';

                trigger OnAction()
                var
                    Lrec_Historic: Record "50004";
                    Lform_Historic: Page "50014";
                begin
                    //Début Ajout JX-XAD 20/11/2009
                    //Lrec_Historic.SETFILTER(Lrec_Historic.Type,'%1',Lrec_Historic.Type::Invoice);//Modif JX-AUD 10/10/2011
                    Lrec_Historic.SETFILTER(Lrec_Historic.Type, '%1|%2', Lrec_Historic.Type::Invoice, Lrec_Historic.Type::Receipt);
                    Lrec_Historic.SETFILTER(Lrec_Historic."No.", '%1', "Pre-Assigned No.");
                    Lform_Historic.SETTABLEVIEW(Lrec_Historic);
                    Lform_Historic.RUNMODAL;
                    //Fin Ajout JX-XAD 20/11/2009
                end;
            }
            action(Contract)
            {
                Caption = 'Contract';

                trigger OnAction()
                var
                    Lcu_ContractManagement: Codeunit "50005";
                begin
                    //Début Modif JX-XAD du 26/02/2010
                    Lcu_ContractManagement.RunContractFormPostedInvoice("No.");
                    //Fin Modif JX-XAD du 26/02/2010
                end;
            }
            group("&Line")
            {
                Caption = '&Line';
                separator()
                {
                }
            }
        }
        addafter("Action 57")
        {
            action("Payer ce document")
            {
                Caption = 'Payer ce document';
                Image = VendorPayment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    lPaymentMgt: Codeunit "50010";
                begin
                    lPaymentMgt.CreatePaymentInv(Rec);
                end;
            }
        }
    }

    var
        UserMgt: Codeunit "5700";
        ModifierAxe: Report "50023";
        Grec_PurchInvLine: Record "123";
        ModifierAxesFacture: Report "50037";


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

