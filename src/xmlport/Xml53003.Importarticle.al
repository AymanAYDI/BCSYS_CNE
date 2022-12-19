xmlport 53003 "BC6_Import article"
{
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table27; Item)
            {
                AutoSave = false;
                XmlName = 'Items';
                textelement(four)
                {
                }
                textelement(ref)
                {
                }
                textelement(refcne)
                {
                }
                textelement(ean)
                {
                }
                textelement(des)
                {
                }
                textelement(pxdt1)
                {
                }
                textelement(pxachat1)
                {
                }
                textelement(pxpub1)
                {
                }
                textelement(pxdt2)
                {
                }
                textelement(pxachat2)
                {
                }
                textelement(pxpub2)
                {
                }
                textelement(famille)
                {
                }
                textelement(uv)
                {
                }
                textelement(commentaire)
                {
                }
                textelement(nomenclature)
                {
                }
                textelement(coref)
                {
                }
                textelement(tva)
                {
                }
                textelement(dtreapro)
                {
                }
                textelement(emplacement)
                {
                }
                textelement(famillecne)
                {
                }
                textelement(stock)
                {
                }
                textelement(dtcrea)
                {
                }
                textelement(dtmodif)
                {
                }
                textelement(stockmini)
                {
                }
                textelement(pmp)
                {
                }
                textelement(stockcne)
                {
                }

                trigger OnAfterInitRecord()
                begin

                    recArticle.INIT;

                    four := '';
                    ref := '';
                    refcne := '';
                    ean := '';
                    des := '';
                    pxdt1 := '';
                    //pxachat1:=0;
                    pxachat1 := '';
                    DecGpxachat1 := 0;

                    //pxpub1:=0;
                    pxpub1 := '';
                    DecGpxpub1 := 0;
                    pxdt2 := '';
                    //pxachat2:=0;
                    pxachat2 := '';
                    DecGpxachat2 := 0;

                    //pxpub2:=0;
                    pxpub2 := '';
                    DecGpxpub2 := 0;
                    famille := '';
                    uv := '';
                    commentaire := '';
                    nomenclature := '';
                    coref := '';

                    tva := '';
                    dtreapro := '';
                    emplacement := '';
                    famillecne := '';
                    stock := '';
                    dtcrea := '';
                    dtmodif := '';
                    //stockmini:=0;
                    stockmini := '';
                    DecGstockmini := 0;

                    //pmp:=0;
                    pmp := '';
                    DecGpmp := 0;
                    stockcne := '';
                end;

                trigger OnBeforeInsertRecord()
                var
                    Dat1: Date;
                    Dat2: Date;
                    DelaiReapro: Integer;
                begin

                    IF recArticle.GET(refcne) THEN
                        refcne := refcne + '-2';

                    recArticle.VALIDATE("No.", refcne);
                    recArticle.INSERT(TRUE);


                    //Declanche de suite a cause des validates qui en decoulent
                    IF famillecne <> '' THEN BEGIN
                        IF NOT (recItemCatCode.GET(famillecne)) THEN BEGIN
                            recItemCatCode.INIT;
                            recItemCatCode.VALIDATE(Code, famillecne);
                            recItemCatCode.VALIDATE(Description, 'A compléter');
                            recItemCatCode.INSERT(TRUE);
                        END;

                        recArticle.VALIDATE("Item Category Code", famillecne);
                    END;



                    IF four <> '' THEN
                        recArticle.VALIDATE("Vendor No.", four);

                    IF ref <> '' THEN BEGIN
                        IF COPYSTR(ref, 1, 3) = COPYSTR(four, 1, 3) THEN
                            ref := COPYSTR(ref, 4, STRLEN(ref));

                        //item cross reference
                        recCross.INIT;
                        recCross.VALIDATE("Item No.", refcne);
                        recCross.VALIDATE("Cross-Reference Type", recCross."Cross-Reference Type"::Vendor);
                        recCross.VALIDATE("Cross-Reference Type No.", four);
                        recCross.VALIDATE("Cross-Reference No.", ref);
                        recCross.INSERT(TRUE);

                        recArticle.VALIDATE("Vendor Item No.", four);
                    END;


                    IF ean <> '' THEN BEGIN

                        //item cross reference
                        recCross.INIT;
                        recCross.VALIDATE("Item No.", refcne);
                        recCross.VALIDATE("Cross-Reference Type", recCross."Cross-Reference Type"::"Bar Code");
                        //recCross.VALIDATE("Cross-Reference Type No.",'');
                        recCross.VALIDATE("Cross-Reference No.", ean);
                        recCross.INSERT(TRUE);


                    END;

                    IF des <> '' THEN
                        recArticle.VALIDATE(Description, des);

                    //prendre les prix pub et achat de la date la plus récente
                    IF NOT EVALUATE(Dat1, pxdt1) THEN
                        Dat1 := 0D;

                    IF NOT EVALUATE(Dat2, pxdt2) THEN
                        Dat2 := 0D;

                    IF Dat1 = 19991231D THEN
                        Dat1 := 0D;

                    IF Dat2 = 19991231D THEN
                        Dat2 := 0D;

                    IF (Dat1 > Dat2) THEN BEGIN
                        IF uv = 'C' THEN BEGIN
                            IF EVALUATE(DecGpxpub1, pxpub1) THEN;
                            IF EVALUATE(DecGpxachat1, pxachat1) THEN;
                            recArticle.VALIDATE("Unit Price", DecGpxpub1 / 100);
                            recArticle.VALIDATE("Unit Cost", DecGpxachat1 / 100);
                            recArticle.VALIDATE("Standard Cost", DecGpxachat1 / 100);
                        END
                        ELSE BEGIN
                            IF EVALUATE(DecGpxpub1, pxpub1) THEN;
                            IF EVALUATE(DecGpxachat1, pxachat1) THEN;
                            recArticle.VALIDATE("Unit Price", DecGpxpub1);
                            recArticle.VALIDATE("Unit Cost", DecGpxachat1);
                            recArticle.VALIDATE("Standard Cost", DecGpxachat1);
                        END;

                        //Purchase Price
                        //Field, Item No., Vendor No., Starting Date, Currency Code, Variant Code, Unit of Measure Code, Minimum Quantity
                        recPPx.INIT;
                        recPPx.VALIDATE("Item No.", refcne);
                        recPPx.VALIDATE("Vendor No.", four);
                        IF EVALUATE(DecGpxachat1, pxachat1) THEN;
                        IF uv = 'C' THEN
                            recPPx.VALIDATE("Direct Unit Cost", DecGpxachat1 / 100)
                        ELSE
                            recPPx.VALIDATE("Direct Unit Cost", DecGpxachat1);

                        recPPx.VALIDATE("Starting Date", Dat1);
                        recPPx.INSERT(TRUE);
                    END
                    ELSE BEGIN
                        IF uv = 'C' THEN BEGIN
                            IF EVALUATE(DecGpxpub2, pxpub2) THEN;
                            IF EVALUATE(DecGpxachat2, pxachat2) THEN;
                            IF EVALUATE(DecGpxachat2, pxachat2) THEN;
                            recArticle.VALIDATE("Unit Price", DecGpxpub2 / 100);
                            recArticle.VALIDATE("Unit Cost", DecGpxachat2 / 100);
                            recArticle.VALIDATE("Standard Cost", DecGpxachat2 / 100);
                        END
                        ELSE BEGIN
                            IF EVALUATE(DecGpxpub2, pxpub2) THEN;
                            IF EVALUATE(DecGpxachat2, pxachat2) THEN;
                            IF EVALUATE(DecGpxachat2, pxachat2) THEN;
                            recArticle.VALIDATE("Unit Price", DecGpxpub2);
                            recArticle.VALIDATE("Unit Cost", DecGpxachat2);
                            recArticle.VALIDATE("Standard Cost", DecGpxachat2);

                        END;
                        //Purchase Price
                        //Field, Item No., Vendor No., Starting Date, Currency Code, Variant Code, Unit of Measure Code, Minimum Quantity
                        recPPx.INIT;
                        recPPx.VALIDATE("Item No.", refcne);
                        recPPx.VALIDATE("Vendor No.", four);
                        IF EVALUATE(DecGpxachat2, pxachat2) THEN;
                        IF uv = 'C' THEN
                            recPPx.VALIDATE("Direct Unit Cost", DecGpxachat2 / 100)
                        ELSE
                            recPPx.VALIDATE("Direct Unit Cost", DecGpxachat2);
                        recPPx.VALIDATE("Starting Date", Dat2);
                        recPPx.INSERT(TRUE);
                    END;

                    IF famille <> '' THEN BEGIN
                        //item Discount group
                        //code

                        IF NOT recIDicGroup.GET(famille) THEN BEGIN
                            recIDicGroup.INIT;
                            recIDicGroup.VALIDATE(Code, famille);
                            recIDicGroup.VALIDATE(Description, 'A compléter');
                            recIDicGroup.INSERT(TRUE);
                        END;
                        recArticle.VALIDATE("Item Disc. Group", famille);
                    END;


                    // unite de vte
                    IF uv <> '' THEN BEGIN
                        IF uv = 'C' THEN BEGIN
                            IF NOT recUv.GET(refcne, 'C') THEN BEGIN
                                recUv.INIT;
                                recUv.VALIDATE("Item No.", refcne);
                                recUv.VALIDATE(Code, 'C');
                                recUv.VALIDATE("Qty. per Unit of Measure", 100);
                                recUv.INSERT(TRUE);
                            END;

                            IF NOT recUv.GET(refcne, 'P') THEN BEGIN
                                recUv.INIT;
                                recUv.VALIDATE("Item No.", refcne);
                                recUv.VALIDATE(Code, 'P');
                                recUv.VALIDATE("Qty. per Unit of Measure", 1);
                                recUv.INSERT(TRUE);
                            END;

                            recArticle."Base Unit of Measure" := 'P';
                            recArticle."Purch. Unit of Measure" := 'C';
                            recArticle."Base Unit of Measure" := 'C';
                        END
                        ELSE BEGIN
                            IF NOT recUv.GET(refcne, 'P') THEN BEGIN
                                recUv.INIT;
                                recUv.VALIDATE("Item No.", refcne);
                                recUv.VALIDATE(Code, 'P');
                                recUv.VALIDATE("Qty. per Unit of Measure", 1);
                                recUv.INSERT(TRUE);
                            END;

                            recArticle."Base Unit of Measure" := 'P';
                            recArticle."Purch. Unit of Measure" := 'P';
                            recArticle."Base Unit of Measure" := 'P';
                        END;
                    END;


                    IF commentaire <> '' THEN BEGIN
                        recTextHeader.INIT;
                        recTextHeader.VALIDATE("Table Name", recTextHeader."Table Name"::Item);
                        recTextHeader.VALIDATE("No.", refcne);
                        recTextHeader.VALIDATE("Text No.", 0);
                        recTextHeader.VALIDATE("All Language Codes", TRUE);
                        recTextHeader.INSERT(TRUE);

                        recText.INIT;
                        recText.VALIDATE("Table Name", recText."Table Name"::Item);
                        recText.VALIDATE("No.", refcne);
                        recText.VALIDATE("Text No.", 1);
                        recText.VALIDATE("Line No.", 10000);
                        recText.VALIDATE(Text, commentaire);
                        recText.INSERT(TRUE);

                        recArticle.VALIDATE("Automatic Ext. Texts", TRUE);
                    END;



                    IF nomenclature <> '' THEN BEGIN
                        recArticle.VALIDATE("Tariff No.", nomenclature);
                    END;


                    IF coref <> '' THEN BEGIN
                        IF NOT recCountry.GET(coref) THEN BEGIN
                            recCountry.INIT;
                            recCountry.VALIDATE(Code, coref);
                            recCountry.VALIDATE(Name, 'A compléter');
                            recCountry.INSERT(TRUE);
                        END;

                        recArticle.VALIDATE("Country/Region of Origin Code", coref);
                    END;


                    IF tva <> '' THEN BEGIN
                        IF tva = '1' THEN
                            recArticle.VALIDATE("VAT Prod. Posting Group", 'TVA19,6')
                        ELSE
                            recArticle.VALIDATE("VAT Prod. Posting Group", 'SANS TVA')
                    END;


                    IF dtreapro <> '' THEN BEGIN
                        IF EVALUATE(DelaiReapro, dtreapro) THEN BEGIN
                            IF EVALUATE(recArticle."Lead Time Calculation", FORMAT(DelaiReapro) + 'J') THEN
                                recArticle.VALIDATE("Lead Time Calculation");
                        END;
                    END;


                    IF emplacement <> '' THEN
                        recArticle.VALIDATE("Shelf No.", emplacement);


                    //Voir plus haut pour categorie !!

                    //stock physique : pas pris en compte


                    IF dtcrea <> '' THEN BEGIN
                        EVALUATE(recArticle."BC6_Creation Date", dtcrea);
                        recArticle.VALIDATE("BC6_Creation Date");
                    END;
                    // date modif voir plus bas

                    IF EVALUATE(DecGstockmini, stockmini) THEN
                        IF DecGstockmini <> 0 THEN
                            recArticle.VALIDATE("Reorder Point", DecGstockmini);

                    IF EVALUATE(DecGpmp, pmp) THEN
                        IF DecGpmp <> 0 THEN
                            recArticle.VALIDATE("Last Direct Cost", DecGpmp);

                    recArticle.MODIFY(TRUE);

                    IF dtmodif <> '' THEN BEGIN
                        EVALUATE(recArticle."Last Date Modified", dtmodif);
                        recArticle.VALIDATE("Last Date Modified");
                        recArticle.MODIFY(FALSE);
                    END;
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
        recArticle: Record Item;
        recCross: Record "Item Cross Reference";
        recPPx: Record "Purchase Price";
        recIDicGroup: Record "Item Discount Group";
        recUv: Record "Item Unit of Measure";
        recText: Record "Extended Text Line";
        recCountry: Record "Country/Region";
        recTextHeader: Record "Extended Text Header";
        recItemCatCode: Record "Item Category";
        DecGpxachat1: Decimal;
        DecGpxpub1: Decimal;
        DecGpxachat2: Decimal;
        DecGpxpub2: Decimal;
        DecGstockmini: Decimal;
        DecGpmp: Decimal;
}

