pageextension 50023 pageextension50023 extends "Posted Purchase Credit Memos"
{
    // //Modif JX-AUD du 10/07/2013
    // //Ajout du champ Litige
    // // Modif JX-ABE du 14/09/2016
    // // modifier "l'extended datatype" du champ "Yooz Tooken link" en URL
    layout
    {
        addafter("Control 2")
        {
            field(Litige; Litige)
            {
            }
        }
        addafter("Control 1102601003")
        {
            field("BC No."; "BC No.")
            {
            }
            field("Yooz No."; "Yooz No.")
            {
                Editable = false;
            }
            field("Yooz Token link"; "Yooz Token link")
            {
                Editable = false;
                ExtendedDatatype = URL;
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Insertion (AccessByPermission) on "Action 1102601000".

        addfirst("Action 23")
        {
            action(Card)
            {
                Caption = 'Card';
                Image = EditLines;
                RunObject = Page 147;
                RunPageLink = No.=FIELD(No.);
                ShortCutKey = 'Shift+F5';
            }
        }
    }

    var
        UserMgt: Codeunit "5700";


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
        SetSecurityFilterOnRespCenter;

        //Début Modif JX-XAD du 05/08/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        FILTERGROUP(2);
        SETFILTER("User ID",UserMgt.jx_GetPurchasesFilter);
        FILTERGROUP(0);
        //Fin Modif JX-XAD du 05/08/2008
        */
    //end;
}

