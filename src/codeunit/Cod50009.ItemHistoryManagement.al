codeunit 50009 "BC6_Item History Management"
{
    var
        RecGItem: Record Item;
        RecGItemHistory: Page "BC6_Item Sales/Purch. History";

    procedure GetItem(ItemNo: Code[20])
    begin
        IF ItemNo <> '' THEN BEGIN
            IF ItemNo <> RecGItem."No." THEN
                IF NOT RecGItem.GET(ItemNo) THEN
                    CLEAR(RecGItem);
        END ELSE
            CLEAR(RecGItem);
    end;

    procedure LookupItemSalesHistory(SalesLines: Record "Sales Line"; ItemNo: Code[20]; filterCust: Boolean)
    begin
        GetItem(ItemNo);
        RecGItemHistory.SetToSalesHeader(SalesLines, filterCust);
        RecGItemHistory.SETRECORD(RecGItem);
        RecGItemHistory.LOOKUPMODE := TRUE;
        RecGItemHistory.RUNMODAL();
        CLEAR(RecGItemHistory);
    end;

    procedure LookupItemHistory(ItemNo: Code[20])
    begin
        GetItem(ItemNo);
        RecGItemHistory.SETRECORD(RecGItem);
        RecGItemHistory.LOOKUPMODE := TRUE;
        RecGItemHistory.RUNMODAL();
        CLEAR(RecGItemHistory);
    end;

    procedure LookupItemPurchHistory(PurchLine: Record "Purchase Line"; ItemNo: Code[20])
    begin
        GetItem(ItemNo);
        RecGItemHistory.SetToPurchHeader(PurchLine);
        RecGItemHistory.SETRECORD(RecGItem);
        RecGItemHistory.LOOKUPMODE := TRUE;
        RecGItemHistory.RUNMODAL();
        CLEAR(RecGItemHistory);
    end;
}
