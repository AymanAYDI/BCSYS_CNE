codeunit 50000 "BC6_PDF Mail Management"
{



    var
        RecGContact: Record Contact;
        RecGSalesSetup: Record "Sales & Receivables Setup";

    procedure GetSalesTag(RecSalesHeader: Record "Sales Header") TxtTag: Text[250]
    begin
        WITH RecSalesHeader DO BEGIN
            RecGSalesSetup.GET();

            IF RecGContact.GET("Sell-to Contact No.") THEN
                IF RecGContact."E-Mail" <> '' THEN
                    TxtTag := RecGSalesSetup."BC6_PDF Mail Tag" + RecGContact."E-Mail";
        END;
    end;

    procedure GetPurchTag(RecPurchHeader: Record "Purchase Header") TxtTag: Text[250]
    begin
        WITH RecPurchHeader DO BEGIN
            //Search Contact info to create PDF document and e-mail it
            RecGSalesSetup.GET();

            IF RecGContact.GET("Pay-to Contact No.") THEN
                IF RecGContact."E-Mail" <> '' THEN
                    TxtTag := RecGSalesSetup."BC6_PDF Mail Tag" + RecGContact."E-Mail";
        END;
    end;

}

