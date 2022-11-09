pageextension 50123 pageextension50123 extends "Purchase Line FactBox"
{
    layout
    {
        addafter(PurchaseLineDiscounts)
        {
            field(CstG001; CstG001)
            {
                Caption = 'Item Sales/Purch. H&istory';

                trigger OnAssistEdit()
                begin
                    //>>MIGRATION NAV 2013
                    CuGItemHistoryMgt.LookupItemPurchHistory(Rec, "No.")
                    //<<MIGRATION NAV 2013
                end;
            }
        }
    }

    var
        "- MIGNAV2013 -": Integer;
        CuGItemHistoryMgt: Codeunit "50009";
        "-- MIGNAV2013 --": ;
        CstG001: Label '......';
}

