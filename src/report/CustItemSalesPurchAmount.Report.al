report 50046 "Cust/Item Sales (Purch.Amount)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CustItemSalesPurchAmount.rdlc';
    Caption = 'Cust/Item Sales (Purch.Amount)';

    dataset
    {
        dataitem(DataItem6836; Table18)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group";
            column(STRSUBSTNO_Text000_PeriodText_; STRSUBSTNO(Text000, PeriodText))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
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
            column(ValueEntryBuffer__Sales_Amount__Actual__; ValueEntryBuffer."Sales Amount (Actual)")
            {
            }
            column(ValueEntryBuffer__Discount_Amount_; -ValueEntryBuffer."Discount Amount")
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
            dataitem(DataItem2; Table5802)
            {
                DataItemLink = Source No.=FIELD(No.),
                               Posting Date=FIELD(Date Filter),
                               Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                               Global Dimension 2 Code=FIELD(Global Dimension 2 Filter);
                DataItemTableView = SORTING(Source Type,Source No.,Item No.,Variant Code,Posting Date)
                                    WHERE(Source Type=CONST(Customer),
                                          Item Charge No.=CONST(),
                                          Expected Cost=CONST(No));
                RequestFilterFields = "Item No.","Posting Date";

                trigger OnAfterGetRecord()
                var
                    EntryInBufferExists: Boolean;
                begin
                    ValueEntryBuffer.INIT;
                    ValueEntryBuffer.SETRANGE("Item No.","Item No.");
                    EntryInBufferExists := ValueEntryBuffer.FINDFIRST;

                    IF NOT EntryInBufferExists THEN
                      ValueEntryBuffer."Entry No." := "Item Ledger Entry No.";
                    ValueEntryBuffer."Item No." := "Item No.";
                    ValueEntryBuffer."Invoiced Quantity" += "Invoiced Quantity";
                    ValueEntryBuffer."Sales Amount (Actual)" += "Sales Amount (Actual)";
                    ValueEntryBuffer."Cost Amount (Actual)" += "Cost Amount (Actual)";
                    ValueEntryBuffer."Cost Amount (Non-Invtbl.)" += "Cost Amount (Non-Invtbl.)";
                    ValueEntryBuffer."Discount Amount" += "Discount Amount";
                    IF EntryInBufferExists THEN
                      ValueEntryBuffer.MODIFY
                    ELSE
                      ValueEntryBuffer.INSERT;
                end;

                trigger OnPreDataItem()
                begin
                    ValueEntryBuffer.RESET;
                    ValueEntryBuffer.DELETEALL;
                end;
            }
            dataitem(DataItem5444;Table2000000026)
            {
                DataItemTableView = SORTING(Number);
                column(ValueEntryBuffer__Item_No__;ValueEntryBuffer."Item No.")
                {
                }
                column(Item_Description;Item.Description)
                {
                }
                column(ValueEntryBuffer__Invoiced_Quantity_;-ValueEntryBuffer."Invoiced Quantity")
                {
                    DecimalPlaces = 0:5;
                }
                column(ValueEntryBuffer__Sales_Amount__Actual___Control44;ValueEntryBuffer."Sales Amount (Actual)")
                {
                    AutoFormatType = 1;
                }
                column(ValueEntryBuffer__Discount_Amount__Control45;-ValueEntryBuffer."Discount Amount")
                {
                    AutoFormatType = 1;
                }
                column(ValueEntryBuffer__Cost_Amount__Actual;ValueEntryBuffer."Cost Amount (Actual)")
                {
                }
                column(Profit_Control46;Profit)
                {
                    AutoFormatType = 1;
                }
                column(ProfitPct_Control47;ProfitPct)
                {
                    DecimalPlaces = 1:1;
                }
                column(Item__Base_Unit_of_Measure_;Item."Base Unit of Measure")
                {
                }

                trigger OnAfterGetRecord()
                var
                    ValueEntry: Record "5802";
                begin
                    IF Number = 1 THEN
                      ValueEntryBuffer.FIND('-')
                    ELSE
                      ValueEntryBuffer.NEXT;

                    "Value Entry".COPYFILTER("Posting Date",ValueEntry."Posting Date");
                    ValueEntry.SETRANGE("Item No.",ValueEntryBuffer."Item No.");
                    ValueEntry.SETFILTER("Item Charge No.",'<>%1','');
                    ValueEntry.CALCSUMS("Sales Amount (Actual)","Cost Amount (Actual)","Cost Amount (Non-Invtbl.)","Discount Amount");

                    ValueEntryBuffer."Sales Amount (Actual)" += ValueEntry."Sales Amount (Actual)";
                    ValueEntryBuffer."Cost Amount (Actual)" += ValueEntry."Cost Amount (Actual)";
                    ValueEntryBuffer."Cost Amount (Non-Invtbl.)" += ValueEntry."Cost Amount (Non-Invtbl.)";
                    ValueEntryBuffer."Discount Amount" += ValueEntry."Discount Amount";

                    Profit :=
                      ValueEntryBuffer."Sales Amount (Actual)" +
                      ValueEntryBuffer."Cost Amount (Actual)" +
                      ValueEntryBuffer."Cost Amount (Non-Invtbl.)";

                    IF Item.GET(ValueEntryBuffer."Item No.") THEN ;
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS(
                      ValueEntryBuffer."Sales Amount (Actual)",
                      ValueEntryBuffer."Discount Amount",
                      ValueEntryBuffer."Cost Amount (Actual)", //BCSYS 220121
                      Profit);

                    ValueEntryBuffer.RESET;
                    SETRANGE(Number,1,ValueEntryBuffer.COUNT);
                end;
            }

            trigger OnPreDataItem()
            begin
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;

                CurrReport.CREATETOTALS(
                  ValueEntryBuffer."Sales Amount (Actual)",
                  ValueEntryBuffer."Discount Amount",
                  ValueEntryBuffer."Cost Amount (Actual)", //BCSYS 220121
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
                    field(PrintOnlyOnePerPage;PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'New Page per Customer';
                        ToolTip = 'Specifies if each customer''s information is printed on a new page if you have chosen two or more customers to be included in the report.';
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
        CaptionManagement: Codeunit "42";
    begin
        CustFilter := CaptionManagement.GetRecordFiltersWithCaptions(Customer);
        ValueEntryFilter := "Value Entry".GETFILTERS;
        PeriodText := "Value Entry".GETFILTER("Posting Date");
    end;

    var
        Text000: Label 'Period: %1';
        Item: Record "27";
        ValueEntryBuffer: Record "5802" temporary;
        CustFilter: Text;
        ValueEntryFilter: Text;
        PeriodText: Text;
        PrintOnlyOnePerPage: Boolean;
        Profit: Decimal;
        ProfitPct: Decimal;
        Customer_Item_SalesCaptionLbl: Label 'Customer/Item Sales';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
        ValueEntryBuffer__Item_No__CaptionLbl: Label 'Item No.';
        Item_DescriptionCaptionLbl: Label 'Description';
        ValueEntryBuffer__Invoiced_Quantity_CaptionLbl: Label 'Invoiced Quantity';
        Item__Base_Unit_of_Measure_CaptionLbl: Label 'Unit of Measure';
        ValueEntryBuffer__Sales_Amount__Actual___Control44CaptionLbl: Label 'Amount';
        ValueEntryBuffer__Discount_Amount__Control45CaptionLbl: Label 'Discount Amount';
        Profit_Control46CaptionLbl: Label 'Profit';
        ProfitPct_Control47CaptionLbl: Label 'Profit %';
        TotalCaptionLbl: Label 'Total';
        ValueEntryBuffer_PurchAmountCaption: Label 'Purchase Amount';

    [Scope('Internal')]
    procedure InitializeRequest(NewPagePerCustomer: Boolean)
    begin
        PrintOnlyOnePerPage := NewPagePerCustomer;
    end;
}

