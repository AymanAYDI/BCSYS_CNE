pageextension 50055 "BC6_PurchaseJournal" extends "Purchase Journal" //254
{
    layout
    {
        addfirst(Control1)
        {
            field("BC6_Source Code"; Rec."Source Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
