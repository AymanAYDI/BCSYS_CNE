pageextension 50116 "BC6_VendorDetailsFactBox" extends "Vendor Details FactBox" //9093
{
    layout
    {
        addafter(Contact)
        {
            field("BC6_Mini Amount"; "BC6_Mini Amount")
            {
            }
            field("BC6_Freight Amount"; "BC6_Freight Amount")
            {
            }
            field(BC6_PurchasesLCY; PurchasesLCY)
            {
                AutoFormatType = 1;
                Caption = 'Purchases (LCY)', Comment = 'FRA="Achats DS"';
            }
        }
    }

    var
        DateFilterCalc: Codeunit "DateFilter-Calc";
        CurrentDate: Date;
        PurchasesLCY: Decimal;
        VendDateFilter: Text[30];
        VendDateName: Text[30];

    trigger OnAfterGetRecord()
    begin
        CLEAR(DateFilterCalc);
        IF CurrentDate <> WORKDATE() THEN BEGIN
            CurrentDate := WORKDATE();
            DateFilterCalc.CreateFiscalYearFilter(VendDateFilter, VendDateName, CurrentDate, 0);
        END;

        SETFILTER("Date Filter", VendDateFilter);
        CALCFIELDS("Purchases (LCY)");
        PurchasesLCY := "Purchases (LCY)";
    end;
}

