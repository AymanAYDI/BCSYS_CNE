xmlport 53001 "BC6_import vendor"
{
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

                    regVendor.INIT;

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
                    IF DatGdtcrea <> 0D THEN BEGIN
                        regVendor.VALIDATE("BC6_Creation Date", DatGdtcrea);
                    END;

                    IF collectif <> '' THEN BEGIN
                        regVendor.VALIDATE("Vendor Posting Group", collectif);
                    END;

                    IF nom <> '' THEN BEGIN
                        regVendor.VALIDATE(Name, nom);
                    END;
                    IF nom2 <> '' THEN BEGIN
                        regVendor.VALIDATE("Name 2", nom2);
                    END;
                    IF adresse1 <> '' THEN BEGIN
                        regVendor.VALIDATE(Address, adresse1);
                    END;

                    IF adresse2 <> '' THEN BEGIN
                        regVendor.VALIDATE("Address 2", adresse2);
                    END;

                    IF adresse3 <> '' THEN BEGIN
                        regVendor.VALIDATE(County, adresse3);
                    END;

                    //Code postal et Ville

                    IF (cp <> '') OR (ville <> '') THEN BEGIN
                        //Code postal et Ville
                        IF STRLEN(cp) < 5 THEN BEGIN
                            CPLength := STRLEN(cp);
                            FOR i := 1 TO 5 - CPLength DO BEGIN
                                cp := '0' + cp;
                            END;
                        END;


                        PostCode.RESET;

                        PostCode.SETCURRENTKEY("Search City");
                        PostCode.SETRANGE("Search City", UPPERCASE(ville));
                        PostCode.SETRANGE(Code, cp);
                        IF NOT PostCode.FIND('-') THEN BEGIN
                            PostCode.INIT;

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
                            Country.INIT;
                            Country.VALIDATE(Code, pays);
                            Country.VALIDATE(Name, 'libelle import');
                            Country.INSERT(TRUE);
                        END;
                        regVendor.VALIDATE("Country/Region Code", pays);
                    END
                    ELSE BEGIN
                        regVendor.VALIDATE("Country/Region Code", 'FR');
                    END;


                    IF tel <> '' THEN BEGIN
                        regVendor.VALIDATE("Phone No.", tel);
                    END;

                    IF telecop <> '' THEN BEGIN
                        regVendor.VALIDATE("Fax No.", telecop);
                    END;

                    IF telex <> '' THEN BEGIN
                        regVendor.VALIDATE("Telex No.", telex);
                    END;

                    IF intracomm <> '' THEN BEGIN
                        regVendor.VALIDATE("VAT Registration No.", intracomm);
                    END;

                    regVendor.VALIDATE("Payment Terms Code", 'V7');
                    regVendor.VALIDATE("Payment Method Code", 'VIREMENT');

                    IF tva <> '' THEN BEGIN
                        IF tva = 'O' THEN
                            regVendor.VALIDATE("Gen. Bus. Posting Group", 'NATIONAL')
                        ELSE
                            regVendor.VALIDATE("Gen. Bus. Posting Group", 'EXPORT');
                    END;

                    IF EVALUATE(IntGcmdmin, cmdmin) THEN;
                    IF IntGcmdmin <> 0 THEN BEGIN
                        regVendor.VALIDATE("BC6_Order Minimum", IntGcmdmin);
                    END;

                    IF EVALUATE(IntGfrancomin, francomin) THEN;
                    IF IntGfrancomin <> 0 THEN
                        regVendor.VALIDATE("BC6_Mini Amount", IntGfrancomin);


                    // Commentaires
                    IF commentaire <> '' THEN BEGIN
                        Com.INIT;
                        Com.VALIDATE("Table Name", Com."Table Name"::Vendor);
                        Com.VALIDATE("No.", no);
                        Com.VALIDATE("Line No.", 10000);
                        Com.VALIDATE(Date, WORKDATE);
                        Com.VALIDATE(Comment, commentaire);
                        Com.INSERT(TRUE);
                    END;
                    IF EVALUATE(IntGportsifranco, portsifranco) THEN;
                    IF IntGportsifranco <> 0 THEN BEGIN
                        regVendor.VALIDATE("BC6_Freight Amount", IntGportsifranco)
                    END;

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
        regVendor: Record Vendor;
        PostCode: Record "Post Code";
        Country: Record "Country/Region";
        Com: Record "Comment Line";
        DatGdtcrea: Date;
        IntGcmdmin: Integer;
        IntGfrancomin: Integer;
        IntGportsifranco: Integer;
}

