pageextension 50004 pageextension50004 extends "Payment Slip Subform"
{
    layout
    {
        addfirst("Control 1")
        {
            field("Applies-to ID"; "Applies-to ID")
            {
            }
        }
    }
    actions
    {
        addfirst("Action 1907935204")
        {
            action("Application Pay-to")
            {
                Caption = 'Application Pay-to';
                ShortCutKey = 'Ctrl+F9';

                trigger OnAction()
                begin
                    //>>MIGRATION NAV 2013
                    // This functionality was copied from page #10868. Unsupported part was commented. Please check it.

                    //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout fonction "Lettrer Tiers payeur" - MenuButton "Lignes"
                    /*CurrForm.Lines.PAGE.*/
                    ApplicationTiersPayeur;
                    //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout fonction "Lettrer Tiers payeur" - MenuButton "Lignes"
                    //<<MIGRATION NAV 2013

                end;
            }
        }
    }

    procedure "---NSC1.00---"()
    begin
    end;

    procedure ApplicationTiersPayeur()
    var
        PaymentApplyTo: Codeunit "10861";
    begin
        PaymentApplyTo.OnRunTiersPayeur(Rec);
    end;
}

