codeunit 50001 "BC6_FotoWin Management"
{
    trigger OnRun()
    begin
    end;

    var
        RecGContact: Record Contact;
        RecGSalesSetup: Record "Sales & Receivables Setup";

    [Scope('Internal')]
    procedure GetSalesTag(RecSalesHeader: Record "Sales Header")
    var
        TxtLString: Text[250];
    begin
        WITH RecSalesHeader DO BEGIN
            //Search Contact info to create PDF document and e-mail it
            RecGSalesSetup.GET();

            IF RecGContact.GET("Sell-to Contact No.") THEN
                IF RecGContact."Fax No." <> '' THEN
                    TxtLString := 'SESSION.exe "C:\Program Files\RTE\FOTOWIN\DBFAX\SESSION.DBF" -MA -F' +
                                  '"E:\Echange\test.txt -D' + RecGContact."Fax No." + '" -P1';
        END;
    end;

    [Scope('Internal')]
    procedure GetPurchTag(RecPurchHeader: Record "Purchase Header")
    var
        TxtLString: Text[250];
    begin
        WITH RecPurchHeader DO BEGIN
            //Search Contact info to create PDF document and e-mail it
            RecGSalesSetup.GET();

            IF RecGContact.GET("Pay-to Contact No.") THEN
                IF RecGContact."Fax No." <> '' THEN
                    TxtLString := RecGContact."E-Mail";
        END;
    end;
}

