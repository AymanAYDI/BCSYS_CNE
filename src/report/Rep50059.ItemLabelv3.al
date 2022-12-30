report 50059 "BC6_Item Label v3"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDL/ItemLabelv3.rdl';

    Caption = 'Item Label 108x35', comment = 'FRA="Etiquette article 108x35"';

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", Description, "BC6_Print Unit Price Incl. VAT";
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    ORDER(Ascending);
                column(Item__No__; Item."No.")
                {
                }
                column(ItemDescription; ItemDescription)
                {
                }
                column(EAN13BarTxt; EAN13BarTxt)
                {
                }
                column(EAN13BarTxt_Control1000000003; EAN13BarTxt)
                {
                }
                column(UnitPriceIncVATTxt; UnitPriceIncVATTxt)
                {
                }
                column(UnitPriceTxt; UnitPriceTxt)
                {
                }
                column(CopyLoop_Number; Number)
                {
                }

                trigger OnPreDataItem()
                begin
                    NumOfLabel := 1;
                    SETRANGE(Number, 1, NumOfLabel);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(ItemDescription);
                CLEAR(ExtendedTextItem);
                ItemDescription := Description; // + ' ' + "Description 2";

                ExtendedTextHeader.SETRANGE("No.", "No.");

                ExtendedTextHeader.SETRANGE("Starting Date", 0D, WORKDATE());
                ExtendedTextHeader.SETFILTER("Ending Date", '%1..|%2', WORKDATE(), 0D);
                ExtendedTextHeader.SETRANGE("All Language Codes", TRUE);

                IF ExtendedTextHeader.FINDFIRST() THEN BEGIN
                    ExtendedTextLine.SETRANGE("No.", "No.");
                    IF ExtendedTextLine.FINDFIRST() THEN
                        ExtendedTextItem := ExtendedTextLine.Text;
                END;

                ItemDescription := ItemDescription + ' ' + ExtendedTextItem;


                CLEAR(UnitPriceIncVATTxt);
                IF "BC6_Print Unit Price Incl. VAT" THEN
                    UnitPriceIncVATTxt := STRSUBSTNO(Text1100267001, FORMAT("BC6_Unit Price Includes VAT", 12, '<Precision,2:2><Standard Format,0>'));

                CLEAR(UnitPriceTxt);
                IF "BC6_Print Unit Price Incl. VAT" THEN
                    UnitPriceTxt := STRSUBSTNO(Text1100267003, FORMAT("Unit Price", 12, '<Precision,2:2><Standard Format,0>'));

                EAN13Bar := '';
                EAN13Txt := '';
                EAN13BarTxt := '';
                CLEAR(DistInt);
                EAN13Bar := COPYSTR(FctMangt.GetItemEAN13Code("No."), 1, MAXSTRLEN(EAN13Bar));
                IF EAN13Bar <> '' THEN BEGIN
                    CLEAR(ConvertAutoIDEAN13);
                    EAN13BarTxt := ConvertAutoIDEAN13.EncodeBarcodeEAN13(EAN13Bar, EAN13Txt);
                END ELSE
                    CurrReport.SKIP();
            end;
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

    labels
    {
    }

    var
        ExtendedTextHeader: Record "Extended Text Header";
        ExtendedTextLine: Record "Extended Text Line";
        ConvertAutoIDEAN13: Codeunit "BC6_Barcode Mngt AutoID";
        FctMangt: Codeunit "BC6_Functions Mgt";
        DistInt: Codeunit "Dist. Integration";
        NumOfLabel: Integer;
        Text1100267001: Label '%1 € TTC';
        Text1100267003: Label '%1 € HT  ';
        EAN13Bar: Text[13];
        EAN13Txt: Text[13];
        ExtendedTextItem: Text[50];
        EAN13BarTxt: Text[120];
        ItemDescription: Text[120];
        UnitPriceIncVATTxt: Text[120];
        UnitPriceTxt: Text[120];
}

