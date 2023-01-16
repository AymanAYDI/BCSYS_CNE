pageextension 50046 "BC6_PostedSalesCreditMemos" extends "Posted Sales Credit Memos" //144
{
    layout
    {
        addafter("Document Exchange Status")
        {
            field("BC6_Affair No."; Rec."BC6_Affair No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Return Order No."; Rec."Return Order No.")
            {
                ApplicationArea = All;
            }
        }
    }

    var
        RecGUserSeup: Record "User Setup";

    trigger OnOpenPage()
    begin
        IF NOT Rec.FINDFIRST() THEN
            Rec.INIT();
        IF NOT RecGUserSeup.GET(USERID) THEN
            RecGUserSeup.INIT();
        IF RecGUserSeup."BC6_Limited User" THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETFILTER("BC6_Salesperson Filter", '*' + RecGUserSeup."Salespers./Purch. Code" + '*');
            Rec.FILTERGROUP(0);
        END;
    end;
}
