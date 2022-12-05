pageextension 50046 "BC6_PostedSalesCreditMemos" extends "Posted Sales Credit Memos" //144
{
    layout
    {
        addafter("Document Exchange Status")
        {
            field("BC6_Affair No."; "BC6_Affair No.")
            {
            }
            field("BC6_Return Order No."; "Return Order No.")
            {
            }
        }
    }

    var
        RecGUserSeup: Record "User Setup";

    trigger OnOpenPage()
    begin
        IF NOT FINDFIRST() THEN
            INIT();
        IF NOT RecGUserSeup.GET(USERID) THEN
            RecGUserSeup.INIT();
        IF RecGUserSeup."BC6_Limited User" THEN BEGIN
            FILTERGROUP(2);
            SETFILTER("BC6_Salesperson Filter", '*' + RecGUserSeup."Salespers./Purch. Code" + '*');
            FILTERGROUP(0);
        END;

    end;
}

