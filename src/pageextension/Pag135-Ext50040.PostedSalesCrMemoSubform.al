pageextension 50040 "BC6_PostedSalesCrMemoSubform" extends "Posted Sales Cr. Memo Subform" //135
{
    layout
    {
        addafter("Unit of Measure Code")
        {
            field("BC6_Purchase cost"; Rec."BC6_Purchase cost")
            {
                ApplicationArea = All;
            }
        }
    }
}

