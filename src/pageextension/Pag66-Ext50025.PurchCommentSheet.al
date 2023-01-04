pageextension 50025 "BC6_PurchCommentSheet" extends "Purch. Comment Sheet" //66
{
    //CODE INSRTION IN TRIGGER ONOPENPAGE
    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETRANGE("BC6_Is Log", FALSE);
        Rec.FILTERGROUP(0);
    end;
}
