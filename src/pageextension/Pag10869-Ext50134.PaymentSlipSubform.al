pageextension 50134 "BC6_PaymentSlipSubform" extends "Payment Slip Subform" //10869
{
    layout
    {
        addfirst("Control1")
        {
            field("BC6_Applies-to ID"; Rec."Applies-to ID")
            {
            }
        }
    }
    actions
    {
        addfirst("&Line")
        {
            action("BC6_Application Pay-to")
            {
                Caption = 'Application Pay-to', Comment = 'FRA="Lettrer Tiers payeur"';
                ShortCutKey = 'Ctrl+F9';
                image = ApplicationWorksheet;

                trigger OnAction()
                begin
                    ApplicationTiersPayeur();
                end;
            }
        }
    }

    procedure ApplicationTiersPayeur()
    var
        FunctionMgt: Codeunit "BC6_Functions Mgt";
    begin
        FunctionMgt.OnRunTiersPayeur(Rec);
    end;
}

