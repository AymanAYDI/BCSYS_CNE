pageextension 50015 pageextension50015 extends "Posted Purchase Rcpt. Subform"
{
    // MODIF JX-XAD 04/05/2010
    // Ajout d'une fonction dans le cadre de la modification analytique

    //Unsupported feature: Property Insertion (Permissions) on ""Posted Purchase Rcpt. Subform"(Page 137)".

    actions
    {

        //Unsupported feature: Property Insertion (AccessByPermission) on "Action 1901741704".

    }

    procedure ReturnRecord(var Prec_PurchRcptLine: Record "121")
    begin
        Prec_PurchRcptLine := Rec;
    end;
}

