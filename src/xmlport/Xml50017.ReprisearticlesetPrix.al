xmlport 50017 "BC6_Reprise articles et Prix"
{
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;
    Caption = 'Reprise articles et Prix';

    schema
    {
        textelement(Root)
        {
            tableelement(Item; Item)
            {
                RequestFilterFields = "Vendor No.", "Item Category Code";
                XmlName = 'Items';
                textelement(REF_EXT)
                {
                }
                textelement(REF_INT)
                {
                }
                textelement(EAN)
                {
                }
                textelement(Designation)
                {
                }
                textelement(PX_PUBLIC)
                {
                }
                textelement(FAMILLE)
                {
                }
                textelement(REM_DISTI)
                {
                }
                textelement(PX_NET)
                {
                }
                textelement(UNIT_VTE)
                {
                }
                textelement(UNIT_ACH)
                {
                }
                textelement(QTE_MINI_ACH)
                {
                }
                textelement(COMMENTAIRE)
                {
                }
                textelement(DEB_NOMENCL)
                {
                }
                textelement(DEB_BRUT)
                {
                }
                textelement(DEB_NET)
                {
                }
                textelement(DEB_PAYS)
                {
                }

                trigger OnBeforeInsertRecord()
                begin

                    Art.RESET();
                    Art.SETRANGE("No.", REF_INT);
                    IF Art.FIND('-') THEN BEGIN
                        Art."No." := REF_INT;
                        Art."Vendor Item No." := COPYSTR(Item."Vendor No.", 1, 3) + REF_EXT;
                        Art.Description := COPYSTR(Designation, 1, 30);
                        Art."Item Disc. Group" := FAMILLE;
                        IF EVALUATE(Art."Unit Cost", PX_NET) THEN;
                        IF EVALUATE(Art."Standard Cost", PX_NET) THEN;
                        Art."Sales Unit of Measure" := UNIT_VTE;
                        Art."Sales Unit of Measure" := UniteArt.Code;
                        Art."Purch. Unit of Measure" := UNIT_ACH;

                        Art."Country/Region of Origin Code" := DEB_PAYS;
                        IF EVALUATE(Art."Gross Weight", DEB_BRUT) THEN;
                        IF EVALUATE(Art."Net Weight", DEB_NET) THEN;
                        IF EVALUATE(Art."Unit Price", PX_PUBLIC) THEN;
                        Art.MODIFY();
                    END
                    ELSE BEGIN
                        ART.Init();
                        Art."No." := REF_INT;
                        Art."Vendor No." := CodeFrs;
                        Art."Item Category Code" := CodeCat;
                        Art."Vendor Item No." := COPYSTR(Item."Vendor No.", 1, 3) + REF_EXT;
                        Art.Description := COPYSTR(Designation, 1, 30);
                        Art."Item Disc. Group" := FAMILLE;
                        IF EVALUATE(Art."Unit Cost", PX_NET) THEN;
                        IF EVALUATE(Art."Standard Cost", PX_NET) THEN;
                        Art."Sales Unit of Measure" := UNIT_VTE;
                        Art."Purch. Unit of Measure" := UNIT_ACH;
                        Art."Country/Region of Origin Code" := DEB_PAYS;
                        IF EVALUATE(Art."Gross Weight", DEB_BRUT) THEN;
                        IF EVALUATE(Art."Net Weight", DEB_NET) THEN;
                        IF EVALUATE(Art."Unit Price", PX_PUBLIC) THEN;
                        Art.INSERT();
                    END;
                    PrixUnit.RESET();
                    PrixUnit.SETRANGE("Item No.", REF_INT);
                    PrixUnit.SETRANGE("Ending Date", 0D);
                    IF PrixUnit.FIND('-') THEN BEGIN
                        PrixUnit."Item No." := REF_INT;
                        PrixUnit."Direct Unit Cost" := Art."Standard Cost";
                        PrixUnit."Vendor No." := Art."Vendor No.";
                        PrixUnit.MODIFYALL("Ending Date", WORKDATE() - 1);
                        PrixUnit."Ending Date" := 0D;
                        PrixUnit.MODIFY();
                    END
                    ELSE BEGIN
                        PrixUnit.Init();
                        PrixUnit."Item No." := REF_INT;
                        PrixUnit."Direct Unit Cost" := Art."Standard Cost";
                        PrixUnit."Vendor No." := Art."Vendor No.";
                        IF EVALUATE(PrixUnit."Starting Date", DateDeb) THEN;
                        IF EVALUATE(PrixUnit."Ending Date", DateFin) THEN;
                        PrixUnit.INSERT();
                    END;
                    Remise.RESET();
                    Remise.SETRANGE("Item No.", REF_INT);
                    IF Remise.FIND('-') THEN BEGIN
                        Remise."Item No." := REF_INT;
                        IF EVALUATE(Remise."Line Discount %", REM_DISTI) THEN;
                        Remise.MODIFY();
                        Remise."Item No." := REF_INT;
                        IF EVALUATE(Remise."Line Discount %", REM_DISTI) THEN;
                        Remise.MODIFY();
                    END;
                    Catalogue.SETRANGE("Item No.", REF_INT);
                    IF Catalogue.FIND('-') THEN BEGIN
                        Catalogue."Vendor No." := CodeFrs;
                        Catalogue."Item No." := REF_INT;
                        Catalogue."Vendor Item No." := COPYSTR(Item."Vendor No.", 1, 3) + REF_EXT;
                        Catalogue.MODIFY();
                    END
                    ELSE BEGIN
                        Catalogue."Vendor No." := CodeFrs;
                        Catalogue."Item No." := REF_INT;
                        Catalogue."Vendor Item No." := COPYSTR(Item."Vendor No.", 1, 3) + REF_EXT;
                        Catalogue.INSERT();
                    END;
                end;
            }
#pragma warning disable AL0432
            tableelement("Purchase Price"; "Purchase Price")
#pragma warning restore AL0432
            {
                RequestFilterFields = "Starting Date", "Ending Date";
                XmlName = 'PurchasePrice';
                textelement(DateDeb)
                {
                }
                textelement(DateFin)
                {
                }
                fieldelement(ItemNo; "Purchase Price"."Item No.")
                {
                }
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
        Art: Record Item;
        UniteArt: Record "Item Unit of Measure";
        Catalogue: Record "Item Vendor";
#pragma warning disable AL0432
        Remise: Record "Purchase Line Discount";
#pragma warning restore AL0432
#pragma warning disable AL0432
        PrixUnit: Record "Purchase Price";
#pragma warning restore AL0432
        CodeCat: Code[20];
        CodeFrs: Code[20];
}

