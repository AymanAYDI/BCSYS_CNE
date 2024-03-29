pageextension 50116 "BC6_VendorDetailsFactBox" extends "Vendor Details FactBox" //9093
{
    layout
    {
        addafter(Contact)
        {
            field("BC6_Mini Amount"; Rec."BC6_Mini Amount")
            {
                ApplicationArea = All;
            }
            field("BC6_Freight Amount"; Rec."BC6_Freight Amount")
            {
                ApplicationArea = All;
            }
            field(BC6_PurchasesLCY; PurchasesLCY)
            {
                ApplicationArea = All;
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

        Rec.SETFILTER("Date Filter", VendDateFilter);
        Rec.CALCFIELDS("Purchases (LCY)");
        PurchasesLCY := Rec."Purchases (LCY)";
    end;
}
