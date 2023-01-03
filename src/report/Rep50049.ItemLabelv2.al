report 50049 "BC6_Item Label v2"
{

    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/ItemLabelv2.rdl';

    Caption = 'Item Label 108x35', Comment = 'FRA="Etiquette article 108x35"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

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

            // trigger OnAfterGetRecord()
            // var
            //     FunctionMgt: Codeunit "BC6_Functions Mgt";
            // begin
            //     CLEAR(ItemDescription);
            //     ItemDescription := Description + ' ' + "Description 2";

            //     CLEAR(UnitPriceIncVATTxt);
            //     IF "BC6_Print Unit Price Incl. VAT" THEN
            //         UnitPriceIncVATTxt := STRSUBSTNO(Text1100267001, FORMAT("BC6_Print Unit Price Incl. VAT", 12, '<Precision,2:2><Standard Format,0>'));

            //     CLEAR(UnitPriceTxt);
            //     IF "BC6_Print Unit Price Incl. VAT" THEN
            //         UnitPriceTxt := STRSUBSTNO(Text1100267003, FORMAT("Unit Price", 12, '<Precision,2:2><Standard Format,0>'));

            //     EAN13Bar := '';
            //     EAN13Txt := '';
            //     EAN13BarTxt := '';
            //     CLEAR(DistInt);
            //     EAN13Bar := COPYSTR(FunctionMgt.GetItemEAN13Code("No."), 1, MAXSTRLEN(EAN13Bar));
            //     IF EAN13Bar <> '' THEN BEGIN
            //         CLEAR(ConvertAutoIDEAN13);
            //         EAN13BarTxt := ConvertAutoIDEAN13.EncodeBarcodeEAN13(EAN13Bar, EAN13Txt);
            //     END ELSE
            //         CurrReport.SKIP();
            // end;

            trigger OnAfterGetRecord()
            var
                FunctionMgt: Codeunit "BC6_Functions Mgt";
                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeString: Text;
                BarcodeFontProvider: Interface "Barcode Font Provider";
            begin
                EAN13Txt := FunctionMgt.GetItemEAN13Code("No.");
                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbology := Enum::"Barcode Symbology"::"EAN-13";
                BarcodeString := EAN13Txt;
                BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                EAN13BarTxt := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
            end;
        }
    }

    labels
    {
    }

    var
        NumOfLabel: Integer;
        EAN13BarTxt: Text;
        EAN13Txt: Text[20];
        ItemDescription: Text[120];
        UnitPriceIncVATTxt: Text[120];
        UnitPriceTxt: Text[120];
}

