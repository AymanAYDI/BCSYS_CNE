xmlport 53001 "BC6_import vendor"
{
    Caption = 'import vendor';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table23; Vendor)
            {
                XmlName = 'Vendor';
                textelement(no)
                {
                }
                textelement(dtcrea)
                {
                }
                textelement(collectif)
                {
                }
                textelement(nom)
                {
                }
                textelement(nom2)
                {
                }
                textelement(adresse1)
                {
                }
                textelement(adresse2)
                {
                }
                textelement(adresse3)
                {
                }
                textelement(cp)
                {
                }
                textelement(ville)
                {
                }
                textelement(pays)
                {
                }
                textelement(tel)
                {
                }
                textelement(telecop)
                {
                }
                textelement(telex)
                {
                }
                textelement(intracomm)
                {
                }
                textelement(cdtpay)
                {
                }
                textelement(tva)
                {
                }
                textelement(cmdmin)
                {
                }
                textelement(francomin)
                {
                }
                textelement(commentaire)
                {
                }
                textelement(portsifranco)
                {
                }

                trigger OnAfterInitRecord()
                begin

                    regVendor.INIT();

                    no := '';
                    //dtcrea:=0D;
                    dtcrea := '';
                    DatGdtcrea := 0D;

                    collectif := '';
                    nom := '';
                    nom2 := '';
                    adresse1 := '';
                    adresse2 := '';
                    adresse3 := '';
                    cp := '';
                    ville := '';
                    pays := '';
                    tel := '';
                    telecop := '';
                    telex := '';
                    intracomm := '';
                    cdtpay := '';
                    tva := '';
                    //cmdmin:=0;
                    cmdmin := '';
                    IntGcmdmin := 0;
                    //francomin:=0;
                    IntGfrancomin := 0;
                    francomin := '';
                    commentaire := '';
                    //portsifranco:=0;
                    //portsifranco:=0;
                    portsifranco := '';
                    IntGportsifranco := 0;
                end;

                trigger OnBeforeInsertRecord()
                var
                    CPLength: Integer;
                    i: Integer;
                begin

                    regVendor.VALIDATE("No.", no);

                    regVendor.INSERT(TRUE);
                    IF EVALUATE(DatGdtcrea, dtcrea) THEN;
                    IF DatGdtcrea <> 0D THEN
                        regVendor.VALIDATE("BC6_Creation Date", DatGdtcrea);

                    IF collectif <> '' THEN
                        regVendor.VALIDATE("Vendor Posting Group", collectif);

                    IF nom <> '' THEN
                        regVendor.VALIDATE(Name, nom);
                    IF nom2 <> '' THEN
                        regVendor.VALIDATE("Name 2", nom2);
                    IF adresse1 <> '' THEN
                        regVendor.VALIDATE(Address, adresse1);

                    IF adresse2 <> '' THEN
                        regVendor.VALIDATE("Address 2", adresse2);

                    IF adresse3 <> '' THEN
                        regVendor.VALIDATE(County, adresse3);

                    //Code postal et Ville

                    IF (cp <> '') OR (ville <> '') THEN BEGIN
                        //Code postal et Ville
                        IF STRLEN(cp) < 5 THEN BEGIN
                            CPLength := STRLEN(cp);
                            FOR i := 1 TO 5 - CPLength DO
                                cp := '0' + cp;
                        END;

                        PostCode.RESET();

                        PostCode.SETCURRENTKEY("Search City");
                        PostCode.SETRANGE("Search City", UPPERCASE(ville));
                        PostCode.SETRANGE(Code, cp);
                        IF NOT PostCode.FIND('-') THEN BEGIN
                            PostCode.INIT();

                            PostCode.Code := cp;
                            PostCode.City := ville;
                            PostCode."Search City" := ville;

                            PostCode.VALIDATE(Code, cp);
                            PostCode.VALIDATE(City, ville);
                            PostCode.INSERT(TRUE);
                        END;

                        regVendor."Post Code" := cp;
                        regVendor.City := ville;
                    END;

                    IF pays <> '' THEN BEGIN
                        IF pays = 'FRA' THEN pays := 'FR';

                        IF NOT Country.GET(pays) THEN BEGIN
                            Country.INIT();
                            Country.VALIDATE(Code, pays);
                            Country.VALIDATE(Name, 'libelle import');
                            Country.INSERT(TRUE);
                        END;
                        regVendor.VALIDATE("Country/Region Code", pays);
                    END
                    ELSE
                        regVendor.VALIDATE("Country/Region Code", 'FR');

                    IF tel <> '' THEN
                        regVendor.VALIDATE("Phone No.", tel);

                    IF telecop <> '' THEN
                        regVendor.VALIDATE("Fax No.", telecop);

                    IF telex <> '' THEN
                        regVendor.VALIDATE("Telex No.", telex);

                    IF intracomm <> '' THEN
                        regVendor.VALIDATE("VAT Registration No.", intracomm);

                    regVendor.VALIDATE("Payment Terms Code", 'V7');
                    regVendor.VALIDATE("Payment Method Code", 'VIREMENT');

                    IF tva <> '' THEN
                        IF tva = 'O' THEN
                            regVendor.VALIDATE("Gen. Bus. Posting Group", 'NATIONAL')
                        ELSE
                            regVendor.VALIDATE("Gen. Bus. Posting Group", 'EXPORT');

                    IF EVALUATE(IntGcmdmin, cmdmin) THEN;
                    IF IntGcmdmin <> 0 THEN
                        regVendor.VALIDATE("BC6_Order Minimum", IntGcmdmin);

                    IF EVALUATE(IntGfrancomin, francomin) THEN;
                    IF IntGfrancomin <> 0 THEN
                        regVendor.VALIDATE("BC6_Mini Amount", IntGfrancomin);

                    // Commentaires
                    IF commentaire <> '' THEN BEGIN
                        Com.INIT();
                        Com.VALIDATE("Table Name", Com."Table Name"::Vendor);
                        Com.VALIDATE("No.", no);
                        Com.VALIDATE("Line No.", 10000);
                        Com.VALIDATE(Date, WORKDATE());
                        Com.VALIDATE(Comment, commentaire);
                        Com.INSERT(TRUE);
                    END;
                    IF EVALUATE(IntGportsifranco, portsifranco) THEN;
                    IF IntGportsifranco <> 0 THEN
                        regVendor.VALIDATE("BC6_Freight Amount", IntGportsifranco);

                    regVendor.VALIDATE("Language Code", 'FRA');
                    regVendor.VALIDATE("Location Code", 'CNE');

                    regVendor.MODIFY(TRUE);
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    var
        Com: Record "Comment Line";
        Country: Record "Country/Region";
        PostCode: Record "Post Code";
        regVendor: Record Vendor;
        DatGdtcrea: Date;
        IntGcmdmin: Integer;
        IntGfrancomin: Integer;
        IntGportsifranco: Integer;
}
