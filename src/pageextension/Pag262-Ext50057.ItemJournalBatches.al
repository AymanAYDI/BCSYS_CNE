pageextension 50057 "BC6_ItemJournalBatches" extends "Item Journal Batches" //262
{
    layout
    {
        addafter("Posting No. Series")
        {
            field("BC6_Assigned User ID"; Rec."BC6_Assigned User ID")
            {
                ApplicationArea = All;
            }
            field("BC6_Phys. Inv. Survey"; Rec."BC6_Phys. Inv. Survey")
            {
                ApplicationArea = All;
            }
            field("BC6_Phys. Inv. Check Batch Name"; Rec."BC6_Phys. Inv. Check Bat. Name")
            {
                ApplicationArea = All;
            }
        }
    }
}
