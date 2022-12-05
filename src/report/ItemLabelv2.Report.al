report 50049 "Item Label v2"
{
    // -----------------------------------------------
    // Prodware -www.prodware.fr
    // -----------------------------------------------
    // 
    // //>> CNE4.01
    // A:FE03 01.09.2011 : Item Label Print
    // 
    // //>> CNE4.03 Show Price Include VAT
    DefaultLayout = RDLC;
    RDLCLayout = './ItemLabelv2.rdlc';

    Caption = 'Item Label 108x35';

    dataset
    {
        dataitem(Item; Table27)
        {
            RequestFilterFields = "No.", Description, "Print Unit Price Includes VAT";
            dataitem(CopyLoop; Table2000000026)
            {
                DataItemTableView = SORTING (Number)
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
                ItemDescription := Description + ' ' + "Description 2";

                // VAT Unit Prices
                CLEAR(UnitPriceIncVATTxt);
                IF "Print Unit Price Includes VAT" THEN
                    UnitPriceIncVATTxt := STRSUBSTNO(Text1100267001, FORMAT("Unit Price Includes VAT", 12, '<Precision,2:2><Standard Format,0>'));

                CLEAR(UnitPriceTxt);
                IF "Print Unit Price Includes VAT" THEN
                    UnitPriceTxt := STRSUBSTNO(Text1100267003, FORMAT("Unit Price", 12, '<Precision,2:2><Standard Format,0>'));

                // EAN13 GS1
                EAN13Bar := '';
                EAN13Txt := '';
                EAN13BarTxt := '';
                CLEAR(DistInt);
                EAN13Bar := COPYSTR(DistInt.GetItemEAN13Code("No."), 1, MAXSTRLEN(EAN13Bar));
                IF EAN13Bar <> '' THEN BEGIN
                    // i := MAXSTRLEN(EAN13Bar) - STRLEN(EAN13Bar);
                    // IF (i > 0) THEN
                    //  REPEAT
                    //    EAN13Bar := '0' + EAN13Bar;
                    //    i := i - 1;
                    // UNTIL i <= 0;
                    CLEAR(ConvertAutoIDEAN13);
                    EAN13BarTxt := ConvertAutoIDEAN13.EncodeBarcodeEAN13(EAN13Bar, EAN13Txt);
                END ELSE
                    CurrReport.SKIP;
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
        EAN13Txt: Text[13];
        EAN13Bar: Text[13];
        EAN13BarTxt: Text[120];
        i: Integer;
        NumOfLabel: Integer;
        ConvertAutoIDEAN13: Codeunit "50099";
        DistInt: Codeunit "5702";
        ItemDescription: Text[120];
        UnitPriceIncVATTxt: Text[120];
        Text1100267001: Label '%1 € TTC';
        UnitPriceTxt: Text[120];
        Text1100267003: Label '%1 € HT  ';
}

