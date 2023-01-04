pageextension 50059 "BC6_GenBusinessPostingGroups" extends "Gen. Business Posting Groups" //312
{
    layout
    {
        addafter("Auto Insert Default")
        {
            field("BC6_Subject to DEEE"; Rec."BC6_Subject to DEEE")
            {
                ApplicationArea = All;
            }
        }
    }
}

