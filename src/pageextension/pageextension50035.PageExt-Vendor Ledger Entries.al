pageextension 50035 pageextension50035 extends "Vendor Ledger Entries"
{
    // Début Modif JX-XAD du 16/09/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
    layout
    {
        addafter("Control 6")
        {
            field("Transaction No."; "Transaction No.")
            {
            }
        }
        addafter("Control 16")
        {
            field("Document Type Prepaid"; "Document Type Prepaid")
            {
            }
            field("Document Prepaid"; "Document Prepaid")
            {
            }
        }
        addafter("Control 76")
        {
            field("Closed by Entry No."; "Closed by Entry No.")
            {
            }
        }
        addafter("Control 30")
        {
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

        //Unsupported feature: Property Insertion (Scope) on "Action 72".


        //Unsupported feature: Property Insertion (AccessByPermission) on "Action 55".


        //Unsupported feature: Property Insertion (Scope) on "Action 55".


        //Unsupported feature: Property Insertion (Scope) on "Action 54".


        //Unsupported feature: Property Insertion (Scope) on "ActionApplyEntries(Action 36)".


        //Unsupported feature: Property Insertion (Scope) on "UnapplyEntries(Action 67)".


        //Unsupported feature: Property Insertion (Scope) on "ReverseTransaction(Action 69)".


        //Unsupported feature: Property Insertion (Scope) on "Action 37".


        //Unsupported feature: Property Insertion (Scope) on "Action 7".

        addafter("Action 37")
        {
            action("Show Posted Document")
            {
                Caption = 'Show Posted Document';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Return';

                trigger OnAction()
                begin
                    ShowDoc
                end;
            }
        }
    }

    var
        UserMgt: Codeunit "5700";


        //Unsupported feature: Code Insertion on "OnOpenPage".

        //trigger OnOpenPage()
        //begin
        /*
        //Début Modif JX-XAD du 16/09/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        FILTERGROUP(2);
        SETFILTER("User ID",UserMgt.jx_GetPurchasesFilter);
        FILTERGROUP(0);
        //Fin Modif JX-XAD du 16/09/2008
        */
        //end;
}

