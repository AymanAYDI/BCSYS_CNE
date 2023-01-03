xmlport 50001 "BC6_Import Purchase Price"
{
    Caption = 'Import Purchase Price', Comment = 'FRA="Import Tarifs fournisseurs"';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    FileName = '<>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
#pragma warning disable AL0432
            tableelement("Purchase Price"; "Purchase Price")
#pragma warning restore AL0432
            {
                AutoSave = true;
                AutoUpdate = true;
                XmlName = 'PurchasePrice';
                SourceTableView = SORTING("Item No.", "Vendor No.", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity");
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

                    IF "Purchase Price"."Item No." <> '' THEN BEGIN
                        Trovato := GItem1.GET("Purchase Price"."Item No.");
                        IF (NOT Trovato) THEN BEGIN
                            ERROR(Text001, "Purchase Price".FIELDCAPTION("Item No."), "Purchase Price"."Item No.");
#pragma warning disable AA0136
                            currXMLport.QUIT();
#pragma warning restore AA0136
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
        GItem1: Record Item;
        Trovato: Boolean;
        Text001: Label '%1 %2 wrong', Comment = 'FRA="%1 %2 invalide"';

}

