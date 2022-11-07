codeunit 50001 "FotoWin Management"
{
    // ------------------------------------------------------------------------
    // www.Prodware.Fr
    // ------------------------------------------------------------------------
    // 
    // //>>NSC1.01
    // 
    // FE005.001:SEBC 05/01/2007 : - FotoWin Management
    //                             - Creation


    trigger OnRun()
    begin
    end;

    var
        TxtGMail: Text[250];
        RecGContact: Record "5050";
        RecGSalesSetup: Record "311";
        OptGSelection: Option Print,Fax,"E-mail";

    [Scope('Internal')]
    procedure GetSalesTag(RecSalesHeader: Record "36")
    var
        TxtLString: Text[250];
    begin
        WITH RecSalesHeader DO BEGIN
            //Search Contact info to create PDF document and e-mail it
            RecGSalesSetup.GET;

            IF RecGContact.GET("Sell-to Contact No.") THEN
                IF RecGContact."Fax No." <> '' THEN
                    TxtLString := 'SESSION.exe "C:\Program Files\RTE\FOTOWIN\DBFAX\SESSION.DBF" -MA -F' +
                                  '"E:\Echange\test.txt -D' + RecGContact."Fax No." + '" -P1';
            //IF SHELL(TxtLString) > 0 THEN;
        END;
    end;

    [Scope('Internal')]
    procedure GetPurchTag(RecPurchHeader: Record "38")
    var
        TxtLString: Text[250];
    begin
        WITH RecPurchHeader DO BEGIN
            //Search Contact info to create PDF document and e-mail it
            RecGSalesSetup.GET;

            IF RecGContact.GET("Pay-to Contact No.") THEN
                IF RecGContact."Fax No." <> '' THEN
                    TxtLString := RecGContact."E-Mail";
        END;
    end;
}

