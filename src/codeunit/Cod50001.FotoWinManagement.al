codeunit 50001 "BC6_FotoWin Management"
{

    var
        RecGContact: Record Contact;
        RecGSalesSetup: Record "Sales & Receivables Setup";

    procedure GetSalesTag(RecSalesHeader: Record "Sales Header")
    var
        TxtLString: Text[250];
    begin
        //Search Contact info to create PDF document and e-mail it
        RecGSalesSetup.GET();

        IF RecGContact.GET(RecSalesHeader."Sell-to Contact No.") THEN
            IF RecGContact."Fax No." <> '' THEN
                TxtLString := 'SESSION.exe "C:\Program Files\RTE\FOTOWIN\DBFAX\SESSION.DBF" -MA -F' +
                              '"E:\Echange\test.txt -D' + RecGContact."Fax No." + '" -P1';
    end;

    procedure GetPurchTag(RecPurchHeader: Record "Purchase Header")
    var
        TxtLString: Text[250];
    begin
        //Search Contact info to create PDF document and e-mail it
        RecGSalesSetup.GET();

        IF RecGContact.GET(RecPurchHeader."Pay-to Contact No.") THEN
            IF RecGContact."Fax No." <> '' THEN
                TxtLString := RecGContact."E-Mail";
    end;
}

