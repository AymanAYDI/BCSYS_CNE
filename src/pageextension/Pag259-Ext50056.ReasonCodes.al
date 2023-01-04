pageextension 50056 "BC6_ReasonCodes" extends "Reason Codes" //259
{
    layout
    {
        addafter(Description)
        {
            field("BC6_Disable DEEE"; Rec."BC6_Disable DEEE")
            {
                ApplicationArea = All;
            }
        }
    }
}

