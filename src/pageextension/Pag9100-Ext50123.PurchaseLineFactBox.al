pageextension 50123 "BC6_PurchaseLineFactBox" extends "Purchase Line FactBox" //9100
{
    layout
    {
        addafter(PurchaseLineDiscounts)
        {
            field(BC6_CstG001; CstG001)
            {
                Caption = 'Item Sales/Purch. H&istory';

                trigger OnAssistEdit()
                begin
                    //TODO CuGItemHistoryMgt.LookupItemPurchHistory(Rec, "No.")
                end;
            }
        }
    }

    var
        //TODO // CuGItemHistoryMgt: Codeunit 50009;
        CstG001: Label '......';
}

