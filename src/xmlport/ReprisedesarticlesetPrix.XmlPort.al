xmlport 50017 "Reprise des articles et Prix"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // ------------------------------------------------------------------------

    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table27; Table27)
            {
                RequestFilterFields = Field31, Field5702;
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

                    //Integration Articles et Tarifs  SBH [006]

                    //MAJ Table 27 Article
                    Art.RESET;
                    Art.SETRANGE("No.", REF_INT);
                    IF Art.FIND('-') THEN BEGIN
                        Art."No." := REF_INT;
                        //Art."Vendor No.":=CodeFrs;
                        //Art."Item Category Code":="Item Category Code";
                        Art."Vendor Item No." := COPYSTR(Item."Vendor No.", 1, 3) + REF_EXT;
                        Art.Description := COPYSTR(Designation, 1, 30);
                        Art."Item Disc. Group" := FAMILLE;
                        //Art."Unit Cost":=PX_NET;
                        IF EVALUATE(Art."Unit Cost", PX_NET) THEN;
                        //Art."Standard Cost":=PX_NET;
                        IF EVALUATE(Art."Standard Cost", PX_NET) THEN;
                        Art."Sales Unit of Measure" := UNIT_VTE;
                        Art."Sales Unit of Measure" := UniteArt.Code;
                        Art."Purch. Unit of Measure" := UNIT_ACH;

                        Art."Country/Region of Origin Code" := DEB_PAYS;
                        //Art."Gross Weight":=DEB_BRUT;
                        IF EVALUATE(Art."Gross Weight", DEB_BRUT) THEN;
                        //Art."Net Weight":=DEB_NET;
                        IF EVALUATE(Art."Net Weight", DEB_NET) THEN;
                        //>>TDL90:MICO 25/04/07
                        //Art."Unit Price" := PX_PUBLIC;
                        IF EVALUATE(Art."Unit Price", PX_PUBLIC) THEN;
                        //<<TDL90:MICO 25/04/07
                        Art.MODIFY;
                    END
                    ELSE BEGIN
                        Art."No." := REF_INT;
                        Art."Vendor No." := CodeFrs;
                        Art."Item Category Code" := CodeCat;
                        Art."Vendor Item No." := COPYSTR(Item."Vendor No.", 1, 3) + REF_EXT;
                        Art.Description := COPYSTR(Designation, 1, 30);
                        Art."Item Disc. Group" := FAMILLE;
                        //Art."Unit Cost":=PX_NET;
                        IF EVALUATE(Art."Unit Cost", PX_NET) THEN;
                        //Art."Standard Cost":=PX_NET;
                        IF EVALUATE(Art."Standard Cost", PX_NET) THEN;
                        Art."Sales Unit of Measure" := UNIT_VTE;
                        Art."Purch. Unit of Measure" := UNIT_ACH;
                        Art."Country/Region of Origin Code" := DEB_PAYS;
                        //Art."Gross Weight":=DEB_BRUT;
                        IF EVALUATE(Art."Gross Weight", DEB_BRUT) THEN;
                        //Art."Net Weight":=DEB_NET;
                        IF EVALUATE(Art."Net Weight", DEB_NET) THEN;
                        //>>TDL90:MICO
                        //Art."Unit Price" := PX_PUBLIC;
                        IF EVALUATE(Art."Unit Price", PX_PUBLIC) THEN;
                        //<<TDL90:MICO
                        Art.INSERT;
                    END;
                    //Fin MAJ Table 27 Article

                    //MAJ Table 7012  Prix achat
                    PrixUnit.RESET;
                    PrixUnit.SETRANGE("Item No.", REF_INT);
                    PrixUnit.SETRANGE("Ending Date", 0D);
                    IF PrixUnit.FIND('-') THEN BEGIN
                        PrixUnit."Item No." := REF_INT;
                        PrixUnit."Direct Unit Cost" := Art."Standard Cost";
                        PrixUnit."Vendor No." := Art."Vendor No.";
                        //>>TDL90:MICO 25/04/07
                        //PrixUnit."Starting Date":=DateDeb;
                        //PrixUnit."Ending Date":=DateFin;
                        PrixUnit.MODIFYALL("Ending Date", WORKDATE - 1);
                        PrixUnit."Ending Date" := 0D;
                        //<<TDL90:MICO 25/04/07
                        PrixUnit.MODIFY;
                    END
                    ELSE BEGIN
                        PrixUnit."Item No." := REF_INT;
                        PrixUnit."Direct Unit Cost" := Art."Standard Cost";
                        PrixUnit."Vendor No." := Art."Vendor No.";
                        //PrixUnit."Starting Date":=DateDeb;
                        IF EVALUATE(PrixUnit."Starting Date", DateDeb) THEN;
                        //PrixUnit."Ending Date":=DateFin;
                        IF EVALUATE(PrixUnit."Ending Date", DateFin) THEN;
                        PrixUnit.INSERT;
                    END;
                    //Fin MAJ Table 7012 Prix achat

                    //MAJ Table 7014 Remise ligne achat
                    Remise.RESET;
                    Remise.SETRANGE("Item No.", REF_INT);
                    IF Remise.FIND('-') THEN BEGIN
                        Remise."Item No." := REF_INT;
                        //Remise."Line Discount %":=REM_DISTI;
                        IF EVALUATE(Remise."Line Discount %", REM_DISTI) THEN;
                        Remise.MODIFY;
                        Remise."Item No." := REF_INT;
                        //Remise."Line Discount %":=REM_DISTI;
                        IF EVALUATE(Remise."Line Discount %", REM_DISTI) THEN;
                        Remise.MODIFY;
                    END;
                    //Fin MAJ Table 7014 Remise ligne achat

                    //MAJ TABLE 99 Fournisseur article
                    Catalogue.SETRANGE("Item No.", REF_INT);
                    IF Catalogue.FIND('-') THEN BEGIN
                        Catalogue."Vendor No." := CodeFrs;
                        Catalogue."Item No." := REF_INT;
                        Catalogue."Vendor Item No." := COPYSTR(Item."Vendor No.", 1, 3) + REF_EXT;
                        Catalogue.MODIFY;
                    END
                    ELSE BEGIN
                        Catalogue."Vendor No." := CodeFrs;
                        Catalogue."Item No." := REF_INT;
                        Catalogue."Vendor Item No." := COPYSTR(Item."Vendor No.", 1, 3) + REF_EXT;
                        ;
                        Catalogue.INSERT;
                    END;
                    //Fin MAJ TABLE 99 Fournisseur article
                    //Fin Integration Articles et Tarifs  SBH [006]
                end;
            }
            tableelement(Table7012; Table7012)
            {
                RequestFilterFields = Field4, Field15;
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
        "--NSC1.01--": Integer;
        Article: Record "27";
        Vendor: Record "23";
        Catalogue: Record "99";
        REF: Record "7704";
        UNITE: Record "5404";
        Remise: Record "7014";
        Frs: Record "23";
        Categorie: Record "5722";
        CodeFrs: Code[20];
        CodeCat: Code[20];
        Art: Record "27";
        PrixUnit: Record "7012";
        UniteArt: Record "5404";
}

