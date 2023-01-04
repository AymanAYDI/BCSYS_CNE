pageextension 50117 "BC6_PurchaseLineFactBox" extends "Purchase Line FactBox" //9100
{
    layout
    {
        addafter(PurchaseLineDiscounts)
        {
            field(BC6_CstG001; CstG001)
            {
                Caption = 'Item Sales/Purch. H&istory', Comment = 'FRA="H&istorique ventes/achat article"';

                trigger OnAssistEdit()
                begin
                    CuGItemHistoryMgt.LookupItemPurchHistory(Rec, Rec."No.")
                end;
            }
        }
    }

    var
        CuGItemHistoryMgt: Codeunit "BC6_Item History Management";
        CstG001: Label '......';
}

