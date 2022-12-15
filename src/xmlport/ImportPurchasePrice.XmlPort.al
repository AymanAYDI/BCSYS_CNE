xmlport 50001 "Import Purchase Price"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Import_Tarifs_Fns] Creation du Dataport
    //                                                           => permet de générer un fichier txt pour l'ouvrir par excel
    //                                                                        choisir ; pour séparateur et dans le 3e ecran
    //                                                           pour format des données en colonnes : choisir Texte pour garder les 0
    //                                                           devant les codes articles par exemple
    //                                                           Et Enregistrer le fichier en Texte (DOS) (*.txt) tout le temps
    //                                                           qu'il y a des modifs
    //                                                           Ensuite pour l'importer il faut :
    //                                                               1) Supprimer les 2 lignes d'entête
    //                                                               2)l'enregistrer en CSV (DOS) (*.csv)
    // //CORRECTIF   STLA 01.08.2006 NSC1.00 [Import_Tarifs_Fns] Modification du dataport pour que cela fonctionne !!
    //                                                           On peut générer directement un .csv
    //                                                           l'ouvrir avec excel
    //                                                           sauvegarder les modifs
    //                                                           et reimporter
    // ------------------------------------------------------------------------

    Caption = 'Import Purchase Price';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    FileName = '<>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table7012; Table7012)
            {
                AutoSave = true;
                AutoUpdate = true;
                XmlName = 'PurchasePrice';
                SourceTableView = SORTING (Field1, Field2, Field4, Field3, Field5700, Field5400, Field14);
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

                trigger OnBeforeInsertRecord()
                begin

                    /*
                    IF "Starting Date"= 0D THEN BEGIN
                      ERROR(Text001,FIELDCAPTION("Starting Date"),"Starting Date",FIELDCAPTION("Item No."),"Item No.");
                      CurrDataport.QUIT;
                    END;
                    */

                    IF "Purchase Price"."Item No." <> '' THEN BEGIN
                        Trovato := GItem1.GET("Purchase Price"."Item No.");
                        IF (NOT Trovato) THEN BEGIN
                            ERROR(Text001, "Purchase Price".FIELDCAPTION("Item No."), "Purchase Price"."Item No.");
                            currXMLport.QUIT;
                        END;
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
        TableNumber: Integer;
        Trovato: Boolean;
        TrovatoError: Boolean;
        NumError: Integer;
        GItem1: Record "27";
        GVATBusinessPostingGroup2: Record "323";
        PurchasePrice: Record "7012";
        Text1: Text[1000];
        Text2: Text[1000];
        Vendor: Record "23";
        RecGPurchasePrice: Record "7012";
        Text001: Label '%1 %2 wrong';
}

