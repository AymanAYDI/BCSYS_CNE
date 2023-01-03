report 50021 "BC6_Dispensed Sales"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/DispensedSales.rdl';
    Caption = 'Dispensed Sales', Comment = 'FRA="Ventes dérogatoires"';
    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(STRSUBSTNO_Text005_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text005))
            {
            }
            column("USERID"; USERID)
            {
            }
            column(DatGDateDebut_Debut; DatGDateDebut_Debut)
            {
            }
            column(DatGDateFin2; DatGDateFin2)
            {
            }
            column(Vendor_Vendor__No__; Vendor."No.")
            {
            }
            column(Vendor_Vendor_Name; Vendor.Name)
            {
            }
            column(DecGTotalAmountPerVendor_8_; DecGTotalAmountPerVendor[8])
            {
            }
            column(DecGTotalAmountPerVendor_7_; DecGTotalAmountPerVendor[7])
            {
            }
            column(DecGTotalAmountPerVendor_6_; DecGTotalAmountPerVendor[6])
            {
            }
            column(Dispensed_Sales___ReportCaption; Dispensed_Sales___ReportCaptionLbl)
            {
            }
            column(Vendor_No_Caption; Vendor_No_CaptionLbl)
            {
            }
            column(Vendor_NameCaption; Vendor_NameCaptionLbl)
            {
            }
            column(Document_No_Caption; Document_No_CaptionLbl)
            {
            }
            column(Customer_TdvCaption; Customer_TdvCaptionLbl)
            {
            }
            column(Mt_Std_DOCaption; Mt_Std_DOCaptionLbl)
            {
            }
            column(Additional_DiscountCaption; Additional_DiscountCaptionLbl)
            {
            }
            column(Credit_memoCaption; Credit_memoCaptionLbl)
            {
            }
            column(Mt_net_DOCaption; Mt_net_DOCaptionLbl)
            {
            }
            column(From__Caption; From__CaptionLbl)
            {
            }
            column(To__Caption; To__CaptionLbl)
            {
            }
            column(Dispense_No_Caption; Dispense_No_CaptionLbl)
            {
            }
            column(Family_codeCaption; Family_codeCaptionLbl)
            {
            }
            column(Item_No_Caption; Item_No_CaptionLbl)
            {
            }
            column(Customer_nameCaption; Customer_nameCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(QtyCaption; QtyCaptionLbl)
            {
            }
            dataitem(SalesInvoiceLine; "Sales Invoice Line")
            {
                DataItemLink = "BC6_Buy-from Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("BC6_Buy-from Vendor No.")
                                    WHERE(Type = FILTER(Item),
                                          "BC6_Dispensation No." = FILTER(<> ''));
                column(CstG001__Document_No__; CstG001 + "Document No.")
                {
                }
                column(DecGAmount_1_; DecGAmount[1])
                {
                }
                column(DecGAmount_5_; DecGAmount[5])
                {
                }
                column(DecGAmount_6_; DecGAmount[6])
                {
                }
                column(DecGAmount_7_; DecGAmount[7])
                {
                }
                column(DecGAmount_8_; DecGAmount[8])
                {
                }
                column(Sales_Invoice_Line__Dispensation_No__; "BC6_Dispensation No.")
                {
                }
                column(Sales_Invoice_Line__Sales_Invoice_Line___Item_Disc__Group_; SalesInvoiceLine."BC6_Item Disc. Group")
                {
                }
                column(Sales_Invoice_Line__No__; "No.")
                {
                }
                column(TxtGCustomerName; TxtGCustomerName)
                {
                }
                column(Sales_Invoice_Line_Document_No_; "Document No.")
                {
                }
                column(Sales_Invoice_Line_Line_No_; "Line No.")
                {
                }
                column(Sales_Invoice_Line_Buy_from_Vendor_No_; "BC6_Buy-from Vendor No.")
                {
                }
                column(Sales_Invoice_Line_Quantity; Quantity)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF RecGSalesInvoiceHeader.GET(SalesInvoiceLine."Document No.") THEN
                        IF ((RecGSalesInvoiceHeader."Posting Date" < DatGDateDebut_Debut) OR
                           (RecGSalesInvoiceHeader."Posting Date" > DatGDateFin_Fin)) THEN
                            CurrReport.SKIP();

                    //>>MIGRATION NAV 2013
                    CLEAR(TxtGCustomerName);
                    IF RecGCustomer.GET("Sell-to Customer No.") THEN
                        TxtGCustomerName := RecGCustomer.Name;
                    //<<MIGRATION NAV 2013


                    IF SalesInvoiceLine."BC6_Public Price" <> 0 THEN BEGIN

                        DecGAmount[1] := (1 - (SalesInvoiceLine."Line Discount %" / 100)) * 10;
                        DecGAmount[3] := SalesInvoiceLine."BC6_Purchase Cost" / SalesInvoiceLine."BC6_Public Price";
                        DecGAmount[4] := SalesInvoiceLine."BC6_Dispensed Purchase Cost" / SalesInvoiceLine."BC6_Public Price";
                    END;
                    DecGAmount[2] := SalesInvoiceLine.Amount;
                    DecGAmount[5] := SalesInvoiceLine."BC6_Additional Discount %";
                    DecGAmount[6] := SalesInvoiceLine."BC6_Purchase Cost" * SalesInvoiceLine.Quantity;
                    DecGAmount[7] := SalesInvoiceLine.Quantity * SalesInvoiceLine."BC6_Dispensed Purchase Cost";
                    DecGAmount[8] := DecGAmount[6] - DecGAmount[7];
                    IF DecGAmount[2] <> 0 THEN
                        DecGAmount[9] := (DecGAmount[2] - DecGAmount[7]) / DecGAmount[2] * 100;

                    FOR IntGI := 1 TO 8 DO BEGIN
                        DecGTotalAmountPerVendor[IntGI] += DecGAmount[IntGI];
                    END;
                end;
            }
            dataitem(SalesCrMemoLine; "Sales Cr.Memo Line")
            {
                DataItemLink = "BC6_Buy-from Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("BC6_Buy-from Vendor No.")
                                    WHERE(Type = CONST(Item),
                                          "BC6_Dispensation No." = FILTER(<> ''));
                column(CstG002__Document_No__; CstG002 + "Document No.")
                {
                }
                column(DecGAmount_8__Control1000000030; DecGAmount[8])
                {
                }
                column(DecGAmount_7__Control1000000033; DecGAmount[7])
                {
                }
                column(DecGAmount_5__Control1000000040; DecGAmount[5])
                {
                }
                column(DecGAmount_6__Control1000000042; DecGAmount[6])
                {
                }
                column(DecGAmount_1__Control1000000047; DecGAmount[1])
                {
                }
                column(Sales_Cr_Memo_Line__No__; "No.")
                {
                }
                column(TxtGCustomerName_Control1000000056; TxtGCustomerName)
                {
                }
                column(Sales_Cr_Memo_Line__Sales_Cr_Memo_Line___Item_Disc__Group_; SalesInvoiceLine."BC6_Item Disc. Group")
                {
                }
                column(Sales_Cr_Memo_Line__Dispensation_No__; "BC6_Dispensation No.")
                {
                }
                column(Sales_Cr_Memo_Line_Document_No_; "Document No.")
                {
                }
                column(Sales_Cr_Memo_Line_Line_No_; "Line No.")
                {
                }
                column(Sales_Cr_Memo_Line_Buy_from_Vendor_No_; "BC6_Buy-from Vendor No.")
                {
                }
                column(Sales_Cr_Memo_Line_Quantity; Quantity)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF RecGSalesCrMemoHeader.GET(SalesInvoiceLine."Document No.") THEN
                        IF ((RecGSalesCrMemoHeader."Posting Date" < DatGDateDebut_Debut) OR
                           (RecGSalesCrMemoHeader."Posting Date" > DatGDateFin_Fin)) THEN
                            CurrReport.SKIP();


                    CLEAR(TxtGCustomerName);
                    IF RecGCustomer.GET("Sell-to Customer No.") THEN
                        TxtGCustomerName := RecGCustomer.Name;


                    IF SalesInvoiceLine."BC6_Public Price" <> 0 THEN BEGIN
                        DecGAmount[1] := (1 - (SalesInvoiceLine."Line Discount %" / 100)) * 10;
                        DecGAmount[3] := SalesInvoiceLine."BC6_Purchase cost" / SalesInvoiceLine."BC6_Public Price";
                        DecGAmount[4] := SalesInvoiceLine."BC6_Dispensed Purchase Cost" / SalesInvoiceLine."BC6_Public Price";
                    END;
                    DecGAmount[2] := SalesInvoiceLine.Amount;
                    DecGAmount[5] := SalesInvoiceLine."BC6_Additional Discount %";
                    DecGAmount[6] := SalesInvoiceLine."BC6_Purchase cost" * SalesInvoiceLine.Quantity;
                    DecGAmount[7] := SalesInvoiceLine.Quantity * SalesInvoiceLine."BC6_Dispensed Purchase Cost";
                    DecGAmount[8] := DecGAmount[6] - DecGAmount[7];
                    IF DecGAmount[2] <> 0 THEN
                        DecGAmount[9] := (DecGAmount[2] - DecGAmount[7]) / DecGAmount[2] * 100;

                    FOR IntGI := 1 TO 9 DO BEGIN
                        DecGTotalAmountPerVendor[IntGI] += DecGAmount[IntGI];
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                FOR IntGI := 1 TO 9 DO BEGIN
                    DecGTotalAmountPerVendor[IntGI] := 0;
                END;

                DiaGWin.UPDATE(1, Vendor."No.");


                BooGShowEntries := FALSE;
                RecGSalesInvoiceLine.RESET();
                RecGSalesInvoiceLine.SETCURRENTKEY("BC6_Buy-from Vendor No.");
                RecGSalesInvoiceLine.SETFILTER("BC6_Buy-from Vendor No.", '%1', FORMAT(Vendor."No."));
                RecGSalesInvoiceLine.SETFILTER("BC6_Dispensation No.", '<>%1', '');
                IF RecGSalesInvoiceLine.FINDset() THEN
                    REPEAT
                        RecGSalesInvoiceHeader.GET(RecGSalesInvoiceLine."Document No.");
                        IF ((RecGSalesInvoiceHeader."Posting Date" >= DatGDateDebut_Debut) AND (RecGSalesInvoiceHeader."Posting Date" <= DatGDateFin_Fin)) THEN
                            BooGShowEntries := TRUE;
                    UNTIL ((RecGSalesInvoiceLine.NEXT() = 0) OR (BooGShowEntries));
                IF NOT BooGShowEntries THEN BEGIN
                    RecGSalesCreditMemoLine.RESET();
                    RecGSalesCreditMemoLine.SETCURRENTKEY("BC6_Buy-from Vendor No.");
                    RecGSalesCreditMemoLine.SETFILTER("BC6_Buy-from Vendor No.", '%1', FORMAT(Vendor."No."));
                    RecGSalesCreditMemoLine.SETFILTER("BC6_Dispensation No.", '<>%1', '');
                    IF RecGSalesCreditMemoLine.FINDSET() THEN
                        REPEAT
                            RecGSalesCrMemoHeader.GET(RecGSalesCreditMemoLine."Document No.");
                            IF ((RecGSalesCrMemoHeader."Posting Date" >= DatGDateDebut_Debut) AND (RecGSalesCrMemoHeader."Posting Date" <= DatGDateFin_Fin)) THEN
                                BooGShowEntries := TRUE;
                        UNTIL ((RecGSalesInvoiceLine.NEXT() = 0) OR (BooGShowEntries));
                END;



                IF NOT BooGShowEntries THEN
                    CurrReport.SKIP();
            end;

            trigger OnPostDataItem()
            begin
                DiaGWin.CLOSE();
            end;

            trigger OnPreDataItem()
            begin
                DiaGWin.OPEN('####1####');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(DatGDateDebut; DatGDateDebut_Debut)
                    {
                        Caption = 'Date début';
                    }
                    field(DatGDateFin; DatGDateFin_Fin)
                    {
                        Caption = 'Date fin';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }



    trigger OnPreReport()
    begin
        DatGDateFin2 := DatGDateFin_Fin;
        IF DatGDateFin_Fin = 0D THEN
            DatGDateFin_Fin := 19991231D;


        RowNo := 1;
        ColumnNo := 1;

        TempExcelBuf.RESET();
        TempExcelBuf.DELETEALL();
    end;

    var
        RecGCustomer: Record Customer;
        TempExcelBuf: Record "Excel Buffer" temporary;
        RecGItem: Record Item;
        RecGSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        RecGSalesCreditMemoLine: Record "Sales Cr.Memo Line";
        RecGSalesInvoiceHeader: Record "Sales Invoice Header";
        RecGSalesInvoiceLine: Record "Sales Invoice Line";
        BooGExportToExcel: Boolean;
        BooGShowEntries: Boolean;
        DatGDateDebut_Debut: Date;
        DatGDateFin_Fin: Date;
        DatGDateFin2: Date;
        DecGAmount: array[9] of Decimal;
        DecGFinalTotal: array[9] of Decimal;
        DecGTotalAmountPerVendor: array[9] of Decimal;
        DiaGWin: Dialog;
        ColumnNo: Integer;
        i: Integer;
        IntGI: Integer;
        RowNo: Integer;
        Additional_DiscountCaptionLbl: Label 'Additional Discount', comment = 'FRA="Remise complémentaire"';
        Credit_memoCaptionLbl: Label 'Credit memo', comment = 'FRA="Avoir"';
        CstG001: Label 'Invoice :', comment = 'FRA="Facture"';
        CstG002: Label 'Cr. memo : ', comment = 'FRA="Avoir"';
        Customer_nameCaptionLbl: Label 'Customer name', comment = 'FRA="Nom client"';
        Customer_TdvCaptionLbl: Label 'Customer Tdv', comment = 'FRA="TdV client"';
        Dispense_No_CaptionLbl: Label 'Dispense No.', comment = 'FRA="No dérogation"';
        Dispensed_Sales___ReportCaptionLbl: Label 'Dispensed Sales - Report', comment = 'FRA="Etat des ventes d2rogatoires"';
        Document_No_CaptionLbl: Label 'Document No.', comment = 'FRA="No document"';
        Family_codeCaptionLbl: Label 'Family code', comment = 'FRA="Code famille"';
        From__CaptionLbl: Label 'From :', comment = 'FRA="Du:"';
        Item_No_CaptionLbl: Label 'Item No.', comment = 'FRA="No article"';
        Mt_net_DOCaptionLbl: Label 'Mt net DO', comment = 'FRA="Mt net DO"';
        Mt_Std_DOCaptionLbl: Label 'Mt Std DO', comment = 'FRA="Mt Std DO"';
        QtyCaptionLbl: Label 'Qty', comment = 'FRA="Qte"';
        Text005: Label 'Page :';
        To__CaptionLbl: Label 'To :', comment = 'FRA="Au:"';
        TotalCaptionLbl: Label 'Total', comment = 'FRA="Total"';
        Vendor_NameCaptionLbl: Label 'Vendor Name', comment = 'FRA="Nom fournisseur"';
        Vendor_No_CaptionLbl: Label 'Vendor No.', comment = 'FRA="n° fournisseur"';
        TxtGCustomerName: Text[50];

    local procedure EnterCell("RowNo.": Integer; "ColumnNo.": Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean; NumberFormat: Text[30])
    begin
        TempExcelBuf.INIT();
        TempExcelBuf.VALIDATE("Row No.", "RowNo.");
        TempExcelBuf.VALIDATE("Column No.", "ColumnNo.");
        TempExcelBuf."Cell Value as Text" := CellValue;
        TempExcelBuf.Formula := '';
        TempExcelBuf.Bold := Bold;
        TempExcelBuf.Underline := UnderLine;
        TempExcelBuf.NumberFormat := NumberFormat;
        TempExcelBuf.INSERT();
    end;
}

