report 50046 "Cust/Item Sales (Purch.Amount)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/CustItemSalesPurchAmount.rdl';
    Caption = 'Cust/Item Sales (Purch.Amount)', Comment = 'FRA="Ventes d''articles par client (Montant Achat)"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group";
            column(STRSUBSTNO_Text000_PeriodText_; STRSUBSTNO(Text000, PeriodText))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
            {
            }
            column(Customer_TABLECAPTION__________CustFilter; TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(Value_Entry__TABLECAPTION__________ItemLedgEntryFilter; "Value Entry".TABLECAPTION + ': ' + ValueEntryFilter)
            {
            }
            column(ItemLedgEntryFilter; ValueEntryFilter)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer__Phone_No__; "Phone No.")
            {
            }
            column(ValueEntryBuffer__Sales_Amount__Actual__; TempValueEntryBuffer."Sales Amount (Actual)")
            {
            }
            column(ValueEntryBuffer__Discount_Amount_; -TempValueEntryBuffer."Discount Amount")
            {
            }
            column(Profit; Profit)
            {
                AutoFormatType = 1;
            }
            column(ProfitPct; ProfitPct)
            {
                DecimalPlaces = 1 : 1;
            }
            column(Customer_Item_SalesCaption; Customer_Item_SalesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(ValueEntryBuffer__Item_No__Caption; ValueEntryBuffer__Item_No__CaptionLbl)
            {
            }
            column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
            {
            }
            column(ValueEntryBuffer__Invoiced_Quantity_Caption; ValueEntryBuffer__Invoiced_Quantity_CaptionLbl)
            {
            }
            column(Item__Base_Unit_of_Measure_Caption; Item__Base_Unit_of_Measure_CaptionLbl)
            {
            }
            column(ValueEntryBuffer__Sales_Amount__Actual___Control44Caption; ValueEntryBuffer__Sales_Amount__Actual___Control44CaptionLbl)
            {
            }
            column(ValueEntryBuffer__Discount_Amount__Control45Caption; ValueEntryBuffer__Discount_Amount__Control45CaptionLbl)
            {
            }
            column(Profit_Control46Caption; Profit_Control46CaptionLbl)
            {
            }
            column(ProfitPct_Control47Caption; ProfitPct_Control47CaptionLbl)
            {
            }
            column(Customer__Phone_No__Caption; FIELDCAPTION("Phone No."))
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(ValueEntryBuffer_PurchAmount; ValueEntryBuffer_PurchAmountCaption)
            {
            }
            dataitem("Value Entry"; "Value Entry")
            {
                DataItemLink = "Source No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter"),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Source Type", "Source No.", "Item No.", "Variant Code", "Posting Date")
                                    WHERE("Source Type" = CONST(Customer),
                                          "Item Charge No." = CONST(),
                                          "Expected Cost" = CONST(False));
                RequestFilterFields = "Item No.", "Posting Date";

                trigger OnAfterGetRecord()
                var
                    EntryInBufferExists: Boolean;
                begin
                    TempValueEntryBuffer.INIT();
                    TempValueEntryBuffer.SETRANGE("Item No.", "Item No.");
                    EntryInBufferExists := TempValueEntryBuffer.FINDFIRST();

                    IF NOT EntryInBufferExists THEN
                        TempValueEntryBuffer."Entry No." := "Item Ledger Entry No.";
                    TempValueEntryBuffer."Item No." := "Item No.";
                    TempValueEntryBuffer."Invoiced Quantity" += "Invoiced Quantity";
                    TempValueEntryBuffer."Sales Amount (Actual)" += "Sales Amount (Actual)";
                    TempValueEntryBuffer."Cost Amount (Actual)" += "Cost Amount (Actual)";
                    TempValueEntryBuffer."Cost Amount (Non-Invtbl.)" += "Cost Amount (Non-Invtbl.)";
                    TempValueEntryBuffer."Discount Amount" += "Discount Amount";
                    IF EntryInBufferExists THEN
                        TempValueEntryBuffer.MODIFY()
                    ELSE
                        TempValueEntryBuffer.INSERT();
                end;

                trigger OnPreDataItem()
                begin
                    TempValueEntryBuffer.RESET();
                    TempValueEntryBuffer.DELETEALL();
                end;
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(ValueEntryBuffer__Item_No__; TempValueEntryBuffer."Item No.")
                {
                }
                column(Item_Description; Item.Description)
                {
                }
                column(ValueEntryBuffer__Invoiced_Quantity_; -TempValueEntryBuffer."Invoiced Quantity")
                {
                    DecimalPlaces = 0 : 5;
                }
                column(ValueEntryBuffer__Sales_Amount__Actual___Control44; TempValueEntryBuffer."Sales Amount (Actual)")
                {
                    AutoFormatType = 1;
                }
                column(ValueEntryBuffer__Discount_Amount__Control45; -TempValueEntryBuffer."Discount Amount")
                {
                    AutoFormatType = 1;
                }
                column(ValueEntryBuffer__Cost_Amount__Actual; TempValueEntryBuffer."Cost Amount (Actual)")
                {
                }
                column(Profit_Control46; Profit)
                {
                    AutoFormatType = 1;
                }
                column(ProfitPct_Control47; ProfitPct)
                {
                    DecimalPlaces = 1 : 1;
                }
                column(Item__Base_Unit_of_Measure_; Item."Base Unit of Measure")
                {
                }

                trigger OnAfterGetRecord()
                var
                    ValueEntry: Record "Value Entry";
                begin
                    IF Number = 1 THEN
                        TempValueEntryBuffer.FIND('-')
                    ELSE
                        TempValueEntryBuffer.NEXT();

                    "Value Entry".COPYFILTER("Posting Date", ValueEntry."Posting Date");
                    ValueEntry.SETRANGE("Item No.", TempValueEntryBuffer."Item No.");
                    ValueEntry.SETFILTER("Item Charge No.", '<>%1', '');
                    ValueEntry.CALCSUMS("Sales Amount (Actual)", "Cost Amount (Actual)", "Cost Amount (Non-Invtbl.)", "Discount Amount");

                    TempValueEntryBuffer."Sales Amount (Actual)" += ValueEntry."Sales Amount (Actual)";
                    TempValueEntryBuffer."Cost Amount (Actual)" += ValueEntry."Cost Amount (Actual)";
                    TempValueEntryBuffer."Cost Amount (Non-Invtbl.)" += ValueEntry."Cost Amount (Non-Invtbl.)";
                    TempValueEntryBuffer."Discount Amount" += ValueEntry."Discount Amount";

                    Profit :=
                      TempValueEntryBuffer."Sales Amount (Actual)" +
                      TempValueEntryBuffer."Cost Amount (Actual)" +
                      TempValueEntryBuffer."Cost Amount (Non-Invtbl.)";

                    IF Item.GET(TempValueEntryBuffer."Item No.") THEN;
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS(
                      TempValueEntryBuffer."Sales Amount (Actual)",
                      TempValueEntryBuffer."Discount Amount",
                      TempValueEntryBuffer."Cost Amount (Actual)", //BCSYS 220121
                      Profit);

                    TempValueEntryBuffer.RESET();
                    SETRANGE(Number, 1, TempValueEntryBuffer.COUNT);
                end;
            }

            trigger OnPreDataItem()
            begin
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;

                CurrReport.CREATETOTALS(
                  TempValueEntryBuffer."Sales Amount (Actual)",
                  TempValueEntryBuffer."Discount Amount",
                  TempValueEntryBuffer."Cost Amount (Actual)", //BCSYS 220121
                  Profit);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Page per Customer', Comment = 'FRA="Nouvelle page par client"';
                        ToolTip = 'Specifies if each customer''s information is printed on a new page if you have chosen two or more customers to be included in the report.', Comment = 'FRA="Indique si les informations client sont imprimées sur une nouvelle page si vous avez choisi plusieurs clients à inclure dans l''état, activez ce champ pour imprimer le solde de chaque client sur une page distincte."';
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
    var
        FormatDocument: Codeunit "Format Document";
    begin
        CustFilter := FormatDocument.GetRecordFiltersWithCaptions(Customer);
        ValueEntryFilter := "Value Entry".GETFILTERS;
        PeriodText := "Value Entry".GETFILTER("Posting Date");
    end;

    var
        Item: Record Item;
        TempValueEntryBuffer: Record "Value Entry" temporary;
        PrintOnlyOnePerPage: Boolean;
        Profit: Decimal;
        ProfitPct: Decimal;
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY', Comment = 'FRA="Tous les montants sont en DS"';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Customer_Item_SalesCaptionLbl: Label 'Customer/Item Sales', Comment = 'FRA="Ventes d''articles par client"';
        Item__Base_Unit_of_Measure_CaptionLbl: Label 'Unit of Measure', Comment = 'FRA="Unité"';
        Item_DescriptionCaptionLbl: Label 'Description';
        Profit_Control46CaptionLbl: Label 'Profit', Comment = 'FRA="Marge"';
        ProfitPct_Control47CaptionLbl: Label 'Profit %', Comment = 'FRA="% marge sur vente"';
        Text000: Label 'Period: %1', Comment = 'FRA="Période : %1"';
        TotalCaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        ValueEntryBuffer__Discount_Amount__Control45CaptionLbl: Label 'Discount Amount', Comment = 'FRA="Montant remise"';
        ValueEntryBuffer__Invoiced_Quantity_CaptionLbl: Label 'Invoiced Quantity', Comment = 'FRA="Quantité facturée"';
        ValueEntryBuffer__Item_No__CaptionLbl: Label 'Item No.', Comment = 'FRA="Quantité facturée"';
        ValueEntryBuffer__Sales_Amount__Actual___Control44CaptionLbl: Label 'Amount', Comment = 'FRA="Montant"';
        ValueEntryBuffer_PurchAmountCaption: Label 'Purchase Amount', Comment = 'FRA="Montant remise"';
        CustFilter: Text;
        PeriodText: Text;
        ValueEntryFilter: Text;


    procedure InitializeRequest(NewPagePerCustomer: Boolean)
    begin
        PrintOnlyOnePerPage := NewPagePerCustomer;
    end;
}

