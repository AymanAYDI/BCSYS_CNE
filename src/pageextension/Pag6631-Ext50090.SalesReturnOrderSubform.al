pageextension 50090 "BC6_SalesReturnOrderSubform" extends "Sales Return Order Subform" //6631
{
    layout
    {
        addafter(Type)
        {
            field("BC6_Purchase cost"; Rec."BC6_Purchase cost")
            {
                ApplicationArea = All;
            }
        }
        addafter("Return Reason Code")
        {
            field("BC6_Solution Code"; Rec."BC6_Solution Code")
            {
                ApplicationArea = All;
            }
            field("BC6_Return Comment"; Rec."BC6_Return Comment")
            {
                ApplicationArea = All;
                Visible = BooGSAVVisible;
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
    //Rq: the code inside the OnAfterGetCurrRecord has totally changed
    trigger OnAfterGetCurrRecord()
    var
        SalesHeader: Record "Sales Header";
    begin
        BooGSAVVisible := SalesHeader."BC6_Return Order Type" = SalesHeader."BC6_Return Order Type"::SAV;
    end;
}
