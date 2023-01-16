pageextension 50034 "BC6_UserSetup" extends "User Setup" //119
{
    layout
    {
        addafter("Allow Posting To")
        {
            field("BC6_SAV Admin"; Rec."BC6_SAV Admin")
            {
                ApplicationArea = All;
            }
        }
        addafter("Time Sheet Admin.")
        {
            field("BC6_E-mail Business Reminder"; Rec."BC6_E-mail Business Reminder")
            {
                ApplicationArea = All;
            }
            field("BC6_Min. Forms Menu"; Rec."BC6_Min. Forms Menu")
            {
                ApplicationArea = All;
            }
            field("BC6_Autorize Qty. to Handle Change"; Rec."BC6_Auth.Qty.to Handle Change")
            {
                ApplicationArea = All;
            }
            field("BC6_Aut. Qty. to Han. Test PickQty"; Rec."BC6_Aut.Qty.toHan.TestPickQty")
            {
                ApplicationArea = All;
            }
            field("BC6_Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
            {
                ApplicationArea = All;
            }
            field("BC6_Limited User"; Rec."BC6_Limited User")
            {
                ApplicationArea = All;
            }
            field("BC6_Aut. Real Sales Profit %"; Rec."BC6_Aut. Real Sales Profit %")
            {
                ApplicationArea = All;
            }
            field("BC6_Activ. Mini Margin Control"; Rec."BC6_Activ. Mini Margin Control")
            {
                ApplicationArea = All;
            }
        }
    }
}
