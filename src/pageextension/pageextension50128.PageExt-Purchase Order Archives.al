pageextension 50128 pageextension50128 extends "Purchase Order Archives"
{
    layout
    {
        addfirst("Control 1")
        {
            field("No."; "No.")
            {
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Insertion (AccessByPermission) on "Action 1102601003".

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

