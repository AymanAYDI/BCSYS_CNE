xmlport 50000 "Export Purchase Price"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Export_Tarifs_Fns] Creation du Dataport
    //                                                           => permet de générer un fichier txt pour l'ouvrir par excel
    //                                                                        choisir ; pour séparateur et dans le 3e ecran
    //                                                           pour format des données en colonnes : choisir Texte pour garder les 0
    //                                                           devant les codes articles par exemple
    //                                                           Et Enregistrer le fichier en Texte (DOS) (*.txt) tout
    //                                                           le temps qu'il y a des modifs
    //                                                           Ensuite pour l'importer il faut :
    //                                                             1) Supprimer les 2 lignes d'entête
    //                                                             2)l'enregistrer en CSV (DOS) (*.csv)
    // //CORRECTIF   STLA 01.08.2006 NSC1.00 [Export_Tarifs_Fns] Modification du dataport pour que cela fonctionne !!
    //                                                           On peut générer directement un .csv
    //                                                           l'ouvrir avec excel
    //                                                           sauvegarder les modifs
    //                                                           et reimporter
    // ------------------------------------------------------------------------

    Caption = 'Export Purchase Price';
    Direction = Export;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement("<root>")
        {
            XmlName = 'Root';
            tableelement(Table2000000026; Table2000000026)
            {
                XmlName = 'Integer';
                SourceTableView = SORTING (Field1)
                                  WHERE (Field1 = CONST (1));
                textelement(text1)
                {
                    XmlName = 'Text1';
                }

                trigger OnAfterGetRecord()
                begin

                    Text1 := PurchasePrice.FIELDCAPTION("Item No.") + ';' +
                             GItem1.FIELDCAPTION(Description) + ';' +
                             PurchasePrice.FIELDCAPTION("Vendor No.") + ';' +
                             Vendor.FIELDCAPTION(Name) + ';' +
                             PurchasePrice.FIELDCAPTION("Currency Code") + ';' +
                             PurchasePrice.FIELDCAPTION("Starting Date") + ';' +
                             PurchasePrice.FIELDCAPTION("Ending Date") + ';' +
                             PurchasePrice.FIELDCAPTION("Direct Unit Cost") + ';' +
                             PurchasePrice.FIELDCAPTION("Minimum Quantity") + ';' +
                             PurchasePrice.FIELDCAPTION("Unit of Measure Code") + ';' +
                             PurchasePrice.FIELDCAPTION("Variant Code");
                    //CurrFile.WRITE(Text1);
                end;
            }
            tableelement(Table7012; Table7012)
            {
                AutoSave = true;
                AutoUpdate = true;
                RequestFilterFields = Field1, Field2;
                XmlName = 'PurchasePrice';
                fieldelement(ItemNo; "Purchase Price"."Item No.")
                {
                }
                textelement(description)
                {
                    XmlName = 'Description';
                }
                fieldelement(VendorNo; "Purchase Price"."Vendor No.")
                {
                }
                textelement(name)
                {
                    XmlName = 'Name';
                }
                fieldelement(CurrencyCode; "Purchase Price"."Currency Code")
                {
                }
                fieldelement(StartingDate; "Purchase Price"."Starting Date")
                {
                }
                fieldelement(EndingDate; "Purchase Price"."Ending Date")
                {
                }
                fieldelement(DirectUnitCost; "Purchase Price"."Direct Unit Cost")
                {
                }
                fieldelement(MinimumQuantity; "Purchase Price"."Minimum Quantity")
                {
                }
                fieldelement(UnitofMeasureCode; "Purchase Price"."Unit of Measure Code")
                {
                }
                fieldelement(VariantCode; "Purchase Price"."Variant Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Description := '';
                    IF "Purchase Price"."Item No." <> '' THEN BEGIN
                        Trovato := GItem1.GET("Purchase Price"."Item No.");
                        Description := GItem1.Description;
                    END;

                    Name := '';
                    IF ("Purchase Price"."Vendor No." <> '') THEN
                        IF Vendor.GET("Purchase Price"."Vendor No.") THEN
                            Name := Vendor.Name;
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
        TableNumber: Integer;
        Trovato: Boolean;
        TrovatoError: Boolean;
        NumError: Integer;
        GItem1: Record "27";
        GVATBusinessPostingGroup2: Record "323";
        PurchasePrice: Record "7012";
        Text11: Text[1000];
        Text2: Text[1000];
        Vendor: Record "23";
        Text001: Label '%1 %2 wrong';
}

