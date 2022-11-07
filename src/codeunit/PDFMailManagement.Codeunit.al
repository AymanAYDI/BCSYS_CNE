codeunit 50000 "PDF Mail Management"
{
    // ------------------------------------------------------------------------
    // www.Prodware.Fr
    // ------------------------------------------------------------------------
    // 
    // //>>NSC1.01
    // 
    // FE005.001:SEBC 05/01/2007 : - PDF Mail Management
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
    procedure GetSalesTag(RecSalesHeader: Record "36") TxtTag: Text[250]
    begin
        WITH RecSalesHeader DO BEGIN
            //Search Contact info to create PDF document and e-mail it
            RecGSalesSetup.GET;

            IF RecGContact.GET("Sell-to Contact No.") THEN
                IF RecGContact."E-Mail" <> '' THEN
                    TxtTag := RecGSalesSetup."PDF Mail Tag" + RecGContact."E-Mail";
        END;
    end;

    [Scope('Internal')]
    procedure GetPurchTag(RecPurchHeader: Record "38") TxtTag: Text[250]
    begin
        WITH RecPurchHeader DO BEGIN
            //Search Contact info to create PDF document and e-mail it
            RecGSalesSetup.GET;

            IF RecGContact.GET("Pay-to Contact No.") THEN
                IF RecGContact."E-Mail" <> '' THEN
                    TxtTag := RecGSalesSetup."PDF Mail Tag" + RecGContact."E-Mail";
        END;
    end;
}

