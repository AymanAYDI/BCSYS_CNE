pageextension 50093 "BC6_PurchaseReturnOrderSubform" extends "Purchase Return Order Subform" //6641
{
    layout
    {
        addafter("Return Reason Code")
        {
            field("BC6_Solution Code"; Rec."BC6_Solution Code")
            {
                ApplicationArea = All;
            }
            field("BC6_Return Comment"; Rec."BC6_Return Comment")
            {
                Visible = BooGSAVVisible;
                ApplicationArea = All;
            }
        }
        addafter("Appl.-to Item Entry")
        {
            field("BC6_DEEE Category Code"; Rec."BC6_DEEE Category Code")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE Unit Price"; Rec."BC6_DEEE Unit Price")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE HT Amount"; Rec."BC6_DEEE HT Amount")
            {
                ApplicationArea = All;
            }
        }
        addafter(ShortcutDimCode8)
        {
            field("BC6_Series No."; Rec."BC6_Series No.")
            {
                ApplicationArea = All;
            }
        }
    }

    var
        BooGSAVVisible: Boolean;

    procedure SetBooGSAVVisible(_BooGSAVVisible: Boolean)
    begin
        BooGSAVVisible := _BooGSAVVisible;
    end;

}

