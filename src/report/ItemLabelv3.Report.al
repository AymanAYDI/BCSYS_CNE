report 50059 "Item Label v3"
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
    RDLCLayout = './ItemLabelv3.rdlc';

    Caption = 'Item Label 108x35';

    dataset
    {
        dataitem(Item; Table27)
        {
            RequestFilterFields = "No.", Description, "Print Unit Price Includes VAT";
            dataitem(CopyLoop; Table2000000026)
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
                //BCSYS 290719 - Description 2 non utilisé?
                //ItemDescription := Description + ' ' + "Description 2";
                ItemDescription := Description; // + ' ' + "Description 2";

                //BCSYS 290719 - prob nb total caractere . ne prend que la première ligne limitée à 20
                ExtendedTextHeader.SETRANGE("No.", "No.");

                ExtendedTextHeader.SETRANGE("Starting Date", 0D, WORKDATE);
                ExtendedTextHeader.SETFILTER("Ending Date", '%1..|%2', WORKDATE, 0D);
                ExtendedTextHeader.SETRANGE("All Language Codes", TRUE);

                IF ExtendedTextHeader.FINDFIRST THEN BEGIN
                    ExtendedTextLine.SETRANGE("No.", "No.");
                    IF ExtendedTextLine.FINDFIRST THEN
                        ExtendedTextItem := ExtendedTextLine.Text;
                END;

                ItemDescription := ItemDescription + ' ' + ExtendedTextItem;
                //fin BCSYS 290719


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
        ExtendedTextLine: Record "280";
        ExtendedTextHeader: Record "279";
        ExtendedTextItem: Text[50];
}

