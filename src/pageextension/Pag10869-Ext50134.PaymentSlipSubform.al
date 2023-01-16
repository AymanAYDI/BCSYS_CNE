pageextension 50134 "BC6_PaymentSlipSubform" extends "Payment Slip Subform" //10869
{
    layout
    {
        addfirst("Control1")
        {
            field("BC6_Applies-to ID"; Rec."Applies-to ID")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addfirst("&Line")
        {
            action("BC6_Application Pay-to")
            {
                ApplicationArea = All;
                Caption = 'Application Pay-to', Comment = 'FRA="Lettrer Tiers payeur"';
                image = ApplicationWorksheet;
                ShortCutKey = 'Ctrl+F9';

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
