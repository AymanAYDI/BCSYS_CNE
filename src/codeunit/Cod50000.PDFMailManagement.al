codeunit 50000 "BC6_PDF Mail Management"
{



    var
        RecGContact: Record Contact;
        RecGSalesSetup: Record "Sales & Receivables Setup";

    procedure GetSalesTag(RecSalesHeader: Record "Sales Header") TxtTag: Text[250]
    begin
        RecGSalesSetup.GET();

        IF RecGContact.GET(RecSalesHeader."Sell-to Contact No.") THEN
            IF RecGContact."E-Mail" <> '' THEN
                TxtTag := RecGSalesSetup."BC6_PDF Mail Tag" + RecGContact."E-Mail";
    end;

    procedure GetPurchTag(RecPurchHeader: Record "Purchase Header") TxtTag: Text[250]
    begin
        //Search Contact info to create PDF document and e-mail it
        RecGSalesSetup.GET();

        IF RecGContact.GET(RecPurchHeader."Pay-to Contact No.") THEN
            IF RecGContact."E-Mail" <> '' THEN
                TxtTag := RecGSalesSetup."BC6_PDF Mail Tag" + RecGContact."E-Mail";
    end;

}

