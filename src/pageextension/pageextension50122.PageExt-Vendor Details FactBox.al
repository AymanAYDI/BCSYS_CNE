pageextension 50122 pageextension50122 extends "Vendor Details FactBox"
{
    layout
    {
        addafter("Control 11")
        {
            field("Mini Amount"; "Mini Amount")
            {
            }
            field("Freight Amount"; "Freight Amount")
            {
            }
            field(PurchasesLCY; PurchasesLCY)
            {
                AutoFormatType = 1;
                Caption = 'Purchases (LCY)';
            }
        }
    }

    var
        CurrentDate: Date;
        VendDateFilter: Text[30];
        VendDateName: Text[30];
        DateFilterCalc: Codeunit "358";
        PurchasesLCY: Decimal;


        //Unsupported feature: Code Insertion on "OnAfterGetRecord".

        //trigger OnAfterGetRecord()
        //begin
        /*
        CLEAR(DateFilterCalc);
        IF CurrentDate <> WORKDATE THEN BEGIN
          CurrentDate := WORKDATE;
          DateFilterCalc.CreateFiscalYearFilter(VendDateFilter,VendDateName,CurrentDate,0);
        END;

        SETFILTER("Date Filter",VendDateFilter);
        CALCFIELDS("Purchases (LCY)");
        PurchasesLCY := "Purchases (LCY)";
        */
        //end;
}

