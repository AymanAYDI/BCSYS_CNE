xmlport 50000 "BC6_Export Purchase Price"
{
    Caption = 'Export Purchase Price', Comment = 'FRA="Export Tarifs fournisseurs"';
    Direction = Export;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement("<root>")
        {
            XmlName = 'Root';
            tableelement(Table2000000026; Integer)
            {
                XmlName = 'Integer';
                SourceTableView = SORTING(Number)
                                  WHERE(Number = CONST(1));
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
            tableelement("Purchase Price"; "Purchase Price")
            {
                AutoSave = true;
                AutoUpdate = true;
                RequestFilterFields = "Item No.", "Vendor No.";
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
        GItem1: Record Item;
        GVATBusinessPostingGroup2: Record "VAT Business Posting Group";
        PurchasePrice: Record "Purchase Price";
        Text11: Text[1000];
        Text2: Text[1000];
        Vendor: Record Vendor;
        Text001: Label '%1 %2 wrong', Comment = 'FRA="%1 %2 invalide"';
}

