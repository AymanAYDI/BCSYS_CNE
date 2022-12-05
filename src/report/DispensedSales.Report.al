report 50021 "Dispensed Sales"
{
    // ---------------------------------------
    // Prodware - www.prodware.fr
    // ---------------------------------------
    // //>>CN1.04
    //   FEP_ADVE_200711_21_1-DEROGATOIRE:SOBI  24/07/08 : - creation
    // 
    // //>> BCSYS_04/11/2021_Ajout la colonne "Quantité"
    DefaultLayout = RDLC;
    RDLCLayout = './DispensedSales.rdlc';

    Caption = 'Dispensed Sales';

    dataset
    {
        dataitem(DataItem3182; Table23)
        {
            DataItemTableView = SORTING (No.);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(STRSUBSTNO_Text005_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text005))
            {
            }
            column(USERID; USERID)
            {
            }
            column(DatGDateDebut; DatGDateDebut)
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
            dataitem(DataItem1570; Table113)
            {
                DataItemLink = Buy-from Vendor No.=FIELD(No.);
                DataItemTableView = SORTING (Buy-from Vendor No.)
                                    WHERE (Type = FILTER (Item),
                                          Dispensation No.=FILTER(<>''));
                column(CstG001__Document_No__;CstG001+"Document No.")
                {
                }
                column(DecGAmount_1_;DecGAmount[1])
                {
                }
                column(DecGAmount_5_;DecGAmount[5])
                {
                }
                column(DecGAmount_6_;DecGAmount[6])
                {
                }
                column(DecGAmount_7_;DecGAmount[7])
                {
                }
                column(DecGAmount_8_;DecGAmount[8])
                {
                }
                column(Sales_Invoice_Line__Dispensation_No__;"Dispensation No.")
                {
                }
                column(Sales_Invoice_Line__Sales_Invoice_Line___Item_Disc__Group_;"Sales Invoice Line"."Item Disc. Group")
                {
                }
                column(Sales_Invoice_Line__No__;"No.")
                {
                }
                column(TxtGCustomerName;TxtGCustomerName)
                {
                }
                column(Sales_Invoice_Line_Document_No_;"Document No.")
                {
                }
                column(Sales_Invoice_Line_Line_No_;"Line No.")
                {
                }
                column(Sales_Invoice_Line_Buy_from_Vendor_No_;"Buy-from Vendor No.")
                {
                }
                column(Sales_Invoice_Line_Quantity;Quantity)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF RecGSalesInvoiceHeader.GET("Sales Invoice Line"."Document No.") THEN
                       IF ((RecGSalesInvoiceHeader."Posting Date" < DatGDateDebut) OR
                          (RecGSalesInvoiceHeader."Posting Date" > DatGDateFin)) THEN
                          CurrReport.SKIP;

                    //>>MIGRATION NAV 2013
                    CLEAR(TxtGCustomerName);
                    IF RecGCustomer.GET("Sell-to Customer No.") THEN
                       TxtGCustomerName := RecGCustomer.Name;
                    //<<MIGRATION NAV 2013


                    IF "Sales Invoice Line"."Public Price" <> 0 THEN BEGIN
                       //DecGAmount[1] := "Sales Invoice Line"."Standard Net Price" / "Sales Invoice Line"."Public Price";
                       DecGAmount[1] := (1 - ("Sales Invoice Line"."Line Discount %" / 100)) * 10;
                       DecGAmount[3] := "Sales Invoice Line"."Purchase Cost" / "Sales Invoice Line"."Public Price";
                       DecGAmount[4] := "Sales Invoice Line"."Dispensed Purchase Cost" / "Sales Invoice Line"."Public Price";
                    END;
                    DecGAmount[2] := "Sales Invoice Line".Amount;
                    DecGAmount[5] := "Sales Invoice Line"."Additional Discount %";
                    DecGAmount[6] := "Sales Invoice Line"."Purchase Cost" * "Sales Invoice Line".Quantity;
                    DecGAmount[7] := "Sales Invoice Line".Quantity * "Sales Invoice Line"."Dispensed Purchase Cost";
                    DecGAmount[8] := DecGAmount[6] - DecGAmount[7];
                    IF DecGAmount[2] <> 0 THEN
                       DecGAmount[9] := (DecGAmount[2] - DecGAmount[7]) / DecGAmount[2] * 100;

                    FOR IntGI := 1 TO 8 DO BEGIN
                        DecGTotalAmountPerVendor[IntGI] += DecGAmount[IntGI];
                    END;
                end;
            }
            dataitem(DataItem3364;Table115)
            {
                DataItemLink = Buy-from Vendor No.=FIELD(No.);
                DataItemTableView = SORTING(Buy-from Vendor No.)
                                    WHERE(Type=CONST(Item),
                                          Dispensation No.=FILTER(<>''));
                column(CstG002__Document_No__;CstG002+"Document No.")
                {
                }
                column(DecGAmount_8__Control1000000030;DecGAmount[8])
                {
                }
                column(DecGAmount_7__Control1000000033;DecGAmount[7])
                {
                }
                column(DecGAmount_5__Control1000000040;DecGAmount[5])
                {
                }
                column(DecGAmount_6__Control1000000042;DecGAmount[6])
                {
                }
                column(DecGAmount_1__Control1000000047;DecGAmount[1])
                {
                }
                column(Sales_Cr_Memo_Line__No__;"No.")
                {
                }
                column(TxtGCustomerName_Control1000000056;TxtGCustomerName)
                {
                }
                column(Sales_Cr_Memo_Line__Sales_Cr_Memo_Line___Item_Disc__Group_;"Sales Cr.Memo Line"."Item Disc. Group")
                {
                }
                column(Sales_Cr_Memo_Line__Dispensation_No__;"Dispensation No.")
                {
                }
                column(Sales_Cr_Memo_Line_Document_No_;"Document No.")
                {
                }
                column(Sales_Cr_Memo_Line_Line_No_;"Line No.")
                {
                }
                column(Sales_Cr_Memo_Line_Buy_from_Vendor_No_;"Buy-from Vendor No.")
                {
                }
                column(Sales_Cr_Memo_Line_Quantity;Quantity)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF RecGSalesCrMemoHeader.GET("Sales Cr.Memo Line"."Document No.") THEN
                       IF ((RecGSalesCrMemoHeader."Posting Date" < DatGDateDebut) OR
                          (RecGSalesCrMemoHeader."Posting Date" > DatGDateFin)) THEN
                          CurrReport.SKIP;


                    CLEAR(TxtGCustomerName);
                    IF RecGCustomer.GET("Sell-to Customer No.") THEN
                       TxtGCustomerName := RecGCustomer.Name;


                    IF "Sales Cr.Memo Line"."Public Price" <> 0 THEN BEGIN
                       //DecGAmount[1] := "Sales Cr.Memo Line"."Standard Net Price" / "Sales Cr.Memo Line"."Public Price";
                       DecGAmount[1] := (1- ("Sales Cr.Memo Line"."Line Discount %" / 100)) * 10;
                       DecGAmount[3] := "Sales Cr.Memo Line"."Purchase cost" / "Sales Cr.Memo Line"."Public Price";
                       DecGAmount[4] := "Sales Cr.Memo Line"."Dispensed Purchase Cost" / "Sales Cr.Memo Line"."Public Price";
                    END;
                    DecGAmount[2] := "Sales Cr.Memo Line".Amount;
                    DecGAmount[5] := "Sales Cr.Memo Line"."Additional Discount %";
                    DecGAmount[6] := "Sales Cr.Memo Line"."Purchase cost" * "Sales Cr.Memo Line".Quantity;
                    DecGAmount[7] := "Sales Cr.Memo Line".Quantity * "Sales Cr.Memo Line"."Dispensed Purchase Cost";
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

                DiaGWin.UPDATE(1,Vendor."No.");


                BooGShowEntries := FALSE;
                   RecGSalesInvoiceLine.RESET;
                   RecGSalesInvoiceLine.SETCURRENTKEY("Buy-from Vendor No.");
                   //RecGSalesInvoiceLine.SETFILTER(Type,'%1',RecGSalesInvoiceLine.Type::Item);
                   RecGSalesInvoiceLine.SETFILTER("Buy-from Vendor No.",'%1',FORMAT(Vendor."No."));
                   RecGSalesInvoiceLine.SETFILTER("Dispensation No.",'<>%1','');
                   IF RecGSalesInvoiceLine.FIND('-') THEN REPEAT
                      RecGSalesInvoiceHeader.GET(RecGSalesInvoiceLine."Document No.");
                      IF ((RecGSalesInvoiceHeader."Posting Date" >= DatGDateDebut) AND (RecGSalesInvoiceHeader."Posting Date" <= DatGDateFin)) THEN
                         BooGShowEntries := TRUE;
                   UNTIL ((RecGSalesInvoiceLine.NEXT = 0) OR (BooGShowEntries));
                   IF NOT BooGShowEntries THEN BEGIN
                      RecGSalesCreditMemoLine.RESET;
                      RecGSalesCreditMemoLine.SETCURRENTKEY("Buy-from Vendor No.");
                      //RecGSalesCreditMemoLine.SETFILTER(Type,'%1',RecGSalesCreditMemoLine.Type::Item);
                      RecGSalesCreditMemoLine.SETFILTER("Buy-from Vendor No.",'%1',FORMAT(Vendor."No."));
                      RecGSalesCreditMemoLine.SETFILTER("Dispensation No.",'<>%1','');
                      IF RecGSalesCreditMemoLine.FIND('-') THEN REPEAT
                         RecGSalesCrMemoHeader.GET(RecGSalesCreditMemoLine."Document No.");
                         IF ((RecGSalesCrMemoHeader."Posting Date" >= DatGDateDebut) AND (RecGSalesCrMemoHeader."Posting Date" <= DatGDateFin)) THEN
                            BooGShowEntries := TRUE;
                      UNTIL ((RecGSalesInvoiceLine.NEXT = 0) OR (BooGShowEntries));
                   END;



                IF NOT  BooGShowEntries THEN
                   CurrReport.SKIP;
            end;

            trigger OnPostDataItem()
            begin
                DiaGWin.CLOSE;
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
                    field(DatGDateDebut;DatGDateDebut)
                    {
                        Caption = 'Date début';
                    }
                    field(DatGDateFin;DatGDateFin)
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

    trigger OnPostReport()
    begin
        //A migrer
        /*
        IF BooGExportToExcel THEN BEGIN
           ExcelBuf.CreateBook();
           ExcelBuf.CreateSheet('Ventes dérogatoires','',COMPANYNAME,USERID);
           ExcelBuf.GiveUserControl();
        END;
        */

    end;

    trigger OnPreReport()
    begin
        DatGDateFin2 := DatGDateFin;
        IF DatGDateFin = 0D THEN
           DatGDateFin := 12319999D;


        RowNo := 1;
        ColumnNo := 1;

        ExcelBuf.RESET;
        ExcelBuf.DELETEALL;
    end;

    var
        DecGAmount: array [9] of Decimal;
        DecGTotalAmountPerVendor: array [9] of Decimal;
        DecGFinalTotal: array [9] of Decimal;
        IntGI: Integer;
        BooGExportToExcel: Boolean;
        DatGDateDebut: Date;
        DatGDateFin: Date;
        RecGSalesInvoiceHeader: Record "112";
        RecGSalesCrMemoHeader: Record "114";
        BooGShowEntries: Boolean;
        RecGItem: Record "27";
        RecGSalesInvoiceLine: Record "113";
        RecGSalesCreditMemoLine: Record "115";
        Text005: Label 'Page :';
        CstG002: Label 'Cr. memo : ';
        CstG001: Label 'Invoice :';
        ExcelBuf: Record "370" temporary;
        RowNo: Integer;
        ColumnNo: Integer;
        i: Integer;
        DiaGWin: Dialog;
        DatGDateFin2: Date;
        TxtGCustomerName: Text[50];
        RecGCustomer: Record "18";
        Dispensed_Sales___ReportCaptionLbl: Label 'Dispensed Sales - Report';
        Vendor_No_CaptionLbl: Label 'Vendor No.';
        Vendor_NameCaptionLbl: Label 'Vendor Name';
        Document_No_CaptionLbl: Label 'Document No.';
        Customer_TdvCaptionLbl: Label 'Customer Tdv';
        Mt_Std_DOCaptionLbl: Label 'Mt Std DO';
        Additional_DiscountCaptionLbl: Label 'Additional Discount';
        Credit_memoCaptionLbl: Label 'Credit memo';
        Mt_net_DOCaptionLbl: Label 'Mt net DO';
        From__CaptionLbl: Label 'From :';
        To__CaptionLbl: Label 'To :';
        Dispense_No_CaptionLbl: Label 'Dispense No.';
        Family_codeCaptionLbl: Label 'Family code';
        Item_No_CaptionLbl: Label 'Item No.';
        Customer_nameCaptionLbl: Label 'Customer name';
        TotalCaptionLbl: Label 'Total';
        QtyCaptionLbl: Label 'Qty';

    local procedure EnterCell(RowNo: Integer;ColumnNo: Integer;CellValue: Text[250];Bold: Boolean;UnderLine: Boolean;NumberFormat: Text[30])
    begin
        ExcelBuf.INIT;
        ExcelBuf.VALIDATE("Row No.",RowNo);
        ExcelBuf.VALIDATE("Column No.",ColumnNo);
        ExcelBuf."Cell Value as Text" := CellValue;
        ExcelBuf.Formula := '';
        ExcelBuf.Bold := Bold;
        ExcelBuf.Underline := UnderLine;
        ExcelBuf.NumberFormat := NumberFormat;
        ExcelBuf.INSERT;
    end;
}

