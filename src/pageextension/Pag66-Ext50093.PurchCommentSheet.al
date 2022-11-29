pageextension 50093 "BC6_PurchCommentSheet" extends "Purch. Comment Sheet" //66
{
    //CODE INSRTION IN TRIGGER ONOPENPAGE
    trigger OnOpenPage()
    begin
        FILTERGROUP(2);
        SETRANGE("BC6_Is Log", FALSE);
        FILTERGROUP(0);
    end;
}
