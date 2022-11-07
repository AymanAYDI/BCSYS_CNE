codeunit 50014 "Format Report Footer Address"
{
    // //BCSYS 25022022: Print Posting Sales Invoice/Sales Credit Mémo : add Footer Company Address


    trigger OnRun()
    begin
    end;

    [Scope('Internal')]
    procedure FormatAddrFooter(var AddrArray: array[5] of Text[400]; var CompInfo: Record "79")
    var
        PhoneCaption: Label 'TEL : %1';
        FaxCaption: Label 'FAX : %1';
        StockCapitalCaption: Label '%1 wtih a capital of %2';
        VatRegistrationNoCaption: Label 'VAT No. : %1';
        EmailCaption: Label 'email : %1';
        TextAPECode: Label ' APE%1';
        TextBankInfo: Label 'Bank Details : ';
        TextSwiftCode: Label ' BIC : %1';
        RegistrationNoCaption: Label 'Registration No. %1 :';
    begin
        //BCSYS 25022022
        WITH CompInfo DO BEGIN
            IF NOT CompInfo."Branch Company" THEN BEGIN
                AddrArray[1] := Name + ' - ' + Address + ' - ' + "Address 2" + ' - ' + "Post Code" + ' ' + City + ' - ' + STRSUBSTNO(PhoneCaption, "Phone No.") + ' - ' + STRSUBSTNO(FaxCaption, "Fax No.") + ' - ' + STRSUBSTNO(EmailCaption, "E-Mail");
                AddrArray[2] := "Alt2 Name" + ' - ' + Address + ' - ' + "Address 2" + ' - ' + "Post Code" + ' ' + City + ' - ' + STRSUBSTNO(PhoneCaption, "Alt2 Phone No.") + ' - ' + STRSUBSTNO(FaxCaption, "Alt2 Fax No.") + ' - ' + STRSUBSTNO(EmailCaption, "Alt2 E-Mail")
                  + ' - ' + "Alt Home Page";
                AddrArray[3] := "Alt Name" + ' - ' + "Alt Address" + ' - ' + "Alt Post Code" + ' ' + "Alt City" + ' - ' + STRSUBSTNO(PhoneCaption, "Alt Phone No.") + ' - ' + STRSUBSTNO(FaxCaption, "Alt Fax No.") + ' - ' + STRSUBSTNO(EmailCaption, "Alt E-Mail");
                AddrArray[4] := STRSUBSTNO(StockCapitalCaption, "Legal Form", "Stock Capital") + ' - ' + "Trade Register" + ' - ' + STRSUBSTNO(TextAPECode, "APE Code") + ' - ' + STRSUBSTNO(VatRegistrationNoCaption, "VAT Registration No.");
                AddrArray[5] := TextBankInfo + FIELDCAPTION(IBAN) + ' : ' + IBAN + ' - ' + STRSUBSTNO(TextSwiftCode, "SWIFT Code");
            END ELSE BEGIN
                AddrArray[1] := '';
                AddrArray[2] := '';
                IF ("Address 2" = '') AND ("Fax No." = '') THEN
                    AddrArray[3] := Name + ' - ' + Address + ' - ' + "Post Code" + ' ' + City + ' - ' + STRSUBSTNO(PhoneCaption, "Phone No.") + ' - ' + STRSUBSTNO(EmailCaption, "E-Mail") + ' - ' + "Home Page"
                ELSE
                    AddrArray[3] := Name + ' - ' + Address + ' - ' + "Address 2" + ' - ' + "Post Code" + ' ' + City + ' - ' + STRSUBSTNO(PhoneCaption, "Phone No.") + ' - ' + STRSUBSTNO(FaxCaption, "Fax No.") + ' - ' +
                      STRSUBSTNO(EmailCaption, "E-Mail") + ' - ' + "Home Page";
                AddrArray[4] := STRSUBSTNO(StockCapitalCaption, "Legal Form", "Stock Capital") + ' - ' + "Trade Register" + ' - ' + STRSUBSTNO(VatRegistrationNoCaption, "VAT Registration No.") + ' - ' +
                  STRSUBSTNO(RegistrationNoCaption, "Registration No.") + ' - ' + STRSUBSTNO(TextAPECode, "APE Code");
                AddrArray[5] := TextBankInfo + FIELDCAPTION(IBAN) + ' : ' + IBAN + ' - ' + STRSUBSTNO(TextSwiftCode, "SWIFT Code");
            END;
        END;
    end;
}

