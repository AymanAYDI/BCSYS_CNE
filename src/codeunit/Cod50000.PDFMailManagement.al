codeunit 50000 "BC6_PDF Mail Management"
{


    trigger OnRun()
    begin
    end;

    var
        TxtGMail: Text[250];
        RecGContact: Record Contact;
        RecGSalesSetup: Record "Sales & Receivables Setup";
        OptGSelection: Option Print,Fax,"E-mail";

    [Scope('Internal')]
    procedure GetSalesTag(RecSalesHeader: Record "Sales Header") TxtTag: Text[250]
    begin
        WITH RecSalesHeader DO BEGIN
            //Search Contact info to create PDF document and e-mail it
            RecGSalesSetup.GET;

            IF RecGContact.GET("Sell-to Contact No.") THEN
                IF RecGContact."E-Mail" <> '' THEN
                    TxtTag := RecGSalesSetup."BC6_PDF Mail Tag" + RecGContact."E-Mail";
        END;
    end;

    [Scope('Internal')]
    procedure GetPurchTag(RecPurchHeader: Record "Purchase Header") TxtTag: Text[250]
    begin
        WITH RecPurchHeader DO BEGIN
            //Search Contact info to create PDF document and e-mail it
            RecGSalesSetup.GET;

            IF RecGContact.GET("Pay-to Contact No.") THEN
                IF RecGContact."E-Mail" <> '' THEN
                    TxtTag := RecGSalesSetup."BC6_PDF Mail Tag" + RecGContact."E-Mail";
        END;
    end;
}
