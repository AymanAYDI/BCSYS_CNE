pageextension 50007 pageextension50007 extends "General Ledger Setup"
{
    // //Modif JX-VSC4.0-PBD du 26/01/15
    // Ajout Axes analytique (Shortcut 9 et 10)
    layout
    {
        addafter("Control 4")
        {
            field("Default Payment Class"; "Default Payment Class")
            {
            }
        }
        addafter("Control 22")
        {
            field("Shortcut Dimension 9 Code"; "Shortcut Dimension 9 Code")
            {
            }
            field("Shortcut Dimension 10 Code"; "Shortcut Dimension 10 Code")
            {
                Enabled = false;
                Visible = false;
            }
        }
        addafter("Control 16")
        {
            field("VAT Reg. No. Validation URL"; "VAT Reg. No. Validation URL")
            {
            }
        }
        addafter("Control 7")
        {
            group("Report Dimension Parameters")
            {
                Caption = 'Paramétrage Axes analytiques - Etats';
                field("Report Dimension 1"; "Report Dimension 1")
                {
                }
                field("Report Dimension 2"; "Report Dimension 2")
                {
                }
                field("Report Dimension 3"; "Report Dimension 3")
                {
                }
                field("Report Dimension 4"; "Report Dimension 4")
                {
                }
                field("Report Dimension 5"; "Report Dimension 5")
                {
                }
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Insertion (AccessByPermission) on "Action 44".

    }


    //Unsupported feature: Property Modification (TextConstString) on "Text001(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Do you want to change all open entries for every customer and vendor that are not blocked;FRA=Souhaitez-vous modifier toutes les écritures ouvertes de tous les clients et fournisseurs non bloqués ?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Do you want to change all open entries for every customer and vendor that are not blocked?;FRA=Souhaitez-vous modifier toutes les écritures ouvertes de tous les clients et fournisseurs non bloqués ?;
    //Variable type has not been exported.
}

