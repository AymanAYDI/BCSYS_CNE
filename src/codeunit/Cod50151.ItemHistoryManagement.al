codeunit 50151 "BC6_Item History Management"
{

    trigger OnRun()
    begin
    end;

    var
        RecGItem: Record Item;
        RecGItemHistory: Page "BC6_Item Sales/Purch. History";

    [Scope('Internal')]
    procedure GetItem(ItemNo: Code[20])
    begin
        IF ItemNo <> '' THEN BEGIN
            IF ItemNo <> RecGItem."No." THEN
                IF NOT RecGItem.GET(ItemNo) THEN
                    CLEAR(RecGItem);
        END ELSE
            CLEAR(RecGItem);
    end;

    [Scope('Internal')]
    procedure LookupItemSalesHistory(SalesLines: Record "Sales Line"; ItemNo: Code[20]; filterCust: Boolean)
    begin
        GetItem(ItemNo);
        //TODO RecGItemHistory.SetToSalesHeader(SalesLines, filterCust);
        RecGItemHistory.SETRECORD(RecGItem);
        RecGItemHistory.LOOKUPMODE := TRUE;
        RecGItemHistory.RUNMODAL;
        CLEAR(RecGItemHistory);
    end;

    [Scope('Internal')]
    procedure LookupItemHistory(ItemNo: Code[20])
    begin
        GetItem(ItemNo);
        RecGItemHistory.SETRECORD(RecGItem);
        RecGItemHistory.LOOKUPMODE := TRUE;
        RecGItemHistory.RUNMODAL;
        CLEAR(RecGItemHistory);
    end;

    [Scope('Internal')]
    procedure LookupItemPurchHistory(PurchLine: Record "Purchase Line"; ItemNo: Code[20])
    begin
        GetItem(ItemNo);
        //TODO RecGItemHistory.SetToPurchHeader(PurchLine);
        RecGItemHistory.SETRECORD(RecGItem);
        RecGItemHistory.LOOKUPMODE := TRUE;
        RecGItemHistory.RUNMODAL;
        CLEAR(RecGItemHistory);
    end;
}

