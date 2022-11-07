pageextension 50022 pageextension50022 extends "Posted Purchase Receipts"
{
    layout
    {
        addafter("Control 6")
        {
            field("Your Reference"; "Your Reference")
            {
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Insertion (AccessByPermission) on "Action 1102601000".

        addfirst("Action 8")
        {
            action(Card)
            {
                Caption = 'Card';
                Image = EditLines;
                RunObject = Page 145;
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

