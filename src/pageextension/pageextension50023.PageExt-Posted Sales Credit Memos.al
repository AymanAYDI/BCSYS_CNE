pageextension 50023 pageextension50023 extends "Posted Sales Credit Memos"
{
    layout
    {
        addafter("Control 11")
        {
            field("Affair No."; "Affair No.")
            {
            }
            field("Return Order No."; "Return Order No.")
            {
            }
        }
    }

    var
        RecGUserSeup: Record "91";


        //Unsupported feature: Code Modification on "OnOpenPage".

        //trigger OnOpenPage()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SetSecurityFilterOnRespCenter;
        IsOfficeAddin := OfficeMgt.IsAvailable;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SetSecurityFilterOnRespCenter;
        IsOfficeAddin := OfficeMgt.IsAvailable;
        //>>MIGRATION CNE 2013
        IF NOT FINDFIRST THEN
          INIT;
        //<<MIGRATION CNE 2013

        //>>P24233_001 SOBI APA 02/02/17
        IF NOT RecGUserSeup.GET(USERID) THEN
           RecGUserSeup.INIT;
        IF RecGUserSeup."Limited User" THEN BEGIN
          FILTERGROUP(2);
          SETFILTER("Salesperson Filter",'*'+RecGUserSeup."Salespers./Purch. Code"+'*');
          FILTERGROUP(0);
        END;
        //<<P24233_001 SOBI APA 02/02/17
        */
        //end;
}

