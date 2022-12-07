pageextension 50134 "BC6_PaymentSlipSubform" extends "Payment Slip Subform" //10869
{
    layout
    {
        addfirst("Control1")
        {
            field("BC6_Applies-to ID"; "Applies-to ID")
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
                Caption = 'Application Pay-to';
                ShortCutKey = 'Ctrl+F9';

                trigger OnAction()
                begin
                    ApplicationTiersPayeur;
                end;
            }
        }
    }

    procedure ApplicationTiersPayeur()
    var
        PaymentApplyTo: Codeunit "Payment-Apply";
    begin
        //TODO : missing a fct
        //     PaymentApplyTo.OnRunTiersPayeur(Rec);
    end;
}

