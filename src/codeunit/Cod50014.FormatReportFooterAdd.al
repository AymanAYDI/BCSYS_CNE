codeunit 50014 "BC6_Format Report Footer Add"
{


    procedure FormatAddrFooter(var AddrArray: array[5] of Text[400]; var CompInfo: Record "Company Information")
    var
        EmailCaption: Label 'email : %1', Comment = 'FRA="email : %1"';
        FaxCaption: Label 'FAX : %1', Comment = 'FRA="FAX : %1"';
        PhoneCaption: Label 'TEL : %1', Comment = 'FRA="TEL : %1"';
        RegistrationNoCaption: Label 'Registration No. %1 :', Comment = 'FRA="SIRET : %1"';
        StockCapitalCaption: Label '%1 wtih a capital of %2', Comment = 'FRA="%1 au capital de %2"';
        TextAPECode: Label ' APE%1', Comment = 'FRA="APE%1"';
        TextBankInfo: Label 'Bank Details : ', Comment = 'FRA="Coordonnées bancaires : "';
        TextSwiftCode: Label ' BIC : %1', Comment = 'FRA="BIC : %1"';
        VatRegistrationNoCaption: Label 'VAT No. : %1', Comment = 'FRA="No. TVA : %1"';
    begin
        IF NOT CompInfo."BC6_Branch Company" THEN BEGIN
            AddrArray[1] := CompInfo.Name + ' - ' + CompInfo.Address + ' - ' + CompInfo."Address 2" + ' - ' + CompInfo."Post Code" + ' ' + CompInfo.City + ' - ' + STRSUBSTNO(PhoneCaption, CompInfo."Phone No.") + ' - ' + STRSUBSTNO(FaxCaption, CompInfo."Fax No.") + ' - ' + STRSUBSTNO(EmailCaption, CompInfo."E-Mail");
            AddrArray[2] := CompInfo."BC6_Alt2 Name" + ' - ' + CompInfo.Address + ' - ' + CompInfo."Address 2" + ' - ' + CompInfo."Post Code" + ' ' + CompInfo.City + ' - ' + STRSUBSTNO(PhoneCaption, CompInfo."BC6_Alt2 Phone No.") + ' - ' + STRSUBSTNO(FaxCaption, CompInfo."BC6_Alt2 Fax No.") + ' - ' + STRSUBSTNO(EmailCaption, CompInfo."BC6_Alt2 E-Mail")
              + ' - ' + CompInfo."BC6_Alt Home Page";
            AddrArray[3] := CompInfo."BC6_Alt Name" + ' - ' + CompInfo."BC6_Alt Address" + ' - ' + CompInfo."BC6_Alt Post Code" + ' ' + CompInfo."BC6_Alt City" + ' - ' + STRSUBSTNO(PhoneCaption, CompInfo."BC6_Alt Phone No.") + ' - ' + STRSUBSTNO(FaxCaption, CompInfo."BC6_Alt Fax No.") + ' - ' + STRSUBSTNO(EmailCaption, CompInfo."BC6_Alt E-Mail");
            AddrArray[4] := STRSUBSTNO(StockCapitalCaption, CompInfo."Legal Form", CompInfo."Stock Capital") + ' - ' + CompInfo."Trade Register" + ' - ' + STRSUBSTNO(TextAPECode, CompInfo."APE Code") + ' - ' + STRSUBSTNO(VatRegistrationNoCaption, CompInfo."VAT Registration No.");
            AddrArray[5] := TextBankInfo + CompInfo.FIELDCAPTION(IBAN) + ' : ' + CompInfo.IBAN + ' - ' + STRSUBSTNO(TextSwiftCode, CompInfo."SWIFT Code");
        END ELSE BEGIN
            AddrArray[1] := '';
            AddrArray[2] := '';
            IF (CompInfo."Address 2" = '') AND (CompInfo."Fax No." = '') THEN
                AddrArray[3] := CompInfo.Name + ' - ' + CompInfo.Address + ' - ' + CompInfo."Post Code" + ' ' + CompInfo.City + ' - ' + STRSUBSTNO(PhoneCaption, CompInfo."Phone No.") + ' - ' + STRSUBSTNO(EmailCaption, CompInfo."E-Mail") + ' - ' + CompInfo."Home Page"
            ELSE
                AddrArray[3] := CompInfo.Name + ' - ' + CompInfo.Address + ' - ' + CompInfo."Address 2" + ' - ' + CompInfo."Post Code" + ' ' + CompInfo.City + ' - ' + STRSUBSTNO(PhoneCaption, CompInfo."Phone No.") + ' - ' + STRSUBSTNO(FaxCaption, CompInfo."Fax No.") + ' - ' +
                  STRSUBSTNO(EmailCaption, CompInfo."E-Mail") + ' - ' + CompInfo."Home Page";
            AddrArray[4] := STRSUBSTNO(StockCapitalCaption, CompInfo."Legal Form", CompInfo."Stock Capital") + ' - ' + CompInfo."Trade Register" + ' - ' + STRSUBSTNO(VatRegistrationNoCaption, CompInfo."VAT Registration No.") + ' - ' +
              STRSUBSTNO(RegistrationNoCaption, CompInfo."Registration No.") + ' - ' + STRSUBSTNO(TextAPECode, CompInfo."APE Code");
            AddrArray[5] := TextBankInfo + CompInfo.FIELDCAPTION(IBAN) + ' : ' + CompInfo.IBAN + ' - ' + STRSUBSTNO(TextSwiftCode, CompInfo."SWIFT Code");
        END;
    end;
}

