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

            trigger OnAfterGetRecord()
            var
                FunctionMgt: Codeunit "BC6_Functions Mgt";
            begin
                CLEAR(ItemDescription);
                ItemDescription := Description + ' ' + "Description 2";

                CLEAR(UnitPriceIncVATTxt);
                IF "BC6_Print Unit Price Incl. VAT" THEN
                    UnitPriceIncVATTxt := STRSUBSTNO(Text1100267001, FORMAT("BC6_Print Unit Price Incl. VAT", 12, '<Precision,2:2><Standard Format,0>'));

                CLEAR(UnitPriceTxt);
                IF "BC6_Print Unit Price Incl. VAT" THEN
                    UnitPriceTxt := STRSUBSTNO(Text1100267003, FORMAT("Unit Price", 12, '<Precision,2:2><Standard Format,0>'));

                EAN13Bar := '';
                EAN13Txt := '';
                EAN13BarTxt := '';
                CLEAR(DistInt);
                EAN13Bar := COPYSTR(FunctionMgt.GetItemEAN13Code("No."), 1, MAXSTRLEN(EAN13Bar));
                IF EAN13Bar <> '' THEN BEGIN
                    CLEAR(ConvertAutoIDEAN13);
                    EAN13BarTxt := ConvertAutoIDEAN13.EncodeBarcodeEAN13(EAN13Bar, EAN13Txt);
                END ELSE
                    CurrReport.SKIP();
            end;
        }
    }

    labels
    {
    }

    var
        ConvertAutoIDEAN13: Codeunit "BC6_Barcode Mngt AutoID";
        DistInt: Codeunit "Dist. Integration";
        NumOfLabel: Integer;
        Text1100267001: Label '%1 € TTC';
        Text1100267003: Label '%1 € HT  ';
        EAN13Bar: Text[13];
        EAN13Txt: Text[13];
        EAN13BarTxt: Text[120];
        ItemDescription: Text[120];
        UnitPriceIncVATTxt: Text[120];
        UnitPriceTxt: Text[120];
}

