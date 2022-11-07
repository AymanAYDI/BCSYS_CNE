codeunit 50009 "Item History Management"
{

    trigger OnRun()
    begin
    end;

    var
        RecGItem: Record "27";
        RecGItemHistory: Page "50014";

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
    procedure LookupItemSalesHistory(SalesLines: Record "37"; ItemNo: Code[20]; filterCust: Boolean)
    begin
        GetItem(ItemNo);
        RecGItemHistory.SetToSalesHeader(SalesLines, filterCust);
        RecGItemHistory.SETRECORD(RecGItem);
        RecGItemHistory.LOOKUPMODE := TRUE;
        RecGItemHistory.RUNMODAL;
        CLEAR(RecGItemHistory);
    end;

    [Scope('Internal')]
    procedure LookupItemHistory(ItemNo: Code[20])
    begin
        GetItem(ItemNo);
        //RecGItemHistory.SetToSalesHeader(SalesLines,filterCust);
        RecGItemHistory.SETRECORD(RecGItem);
        RecGItemHistory.LOOKUPMODE := TRUE;
        RecGItemHistory.RUNMODAL;
        CLEAR(RecGItemHistory);
    end;

    [Scope('Internal')]
    procedure LookupItemPurchHistory(PurchLine: Record "39"; ItemNo: Code[20])
    begin
        GetItem(ItemNo);
        RecGItemHistory.SetToPurchHeader(PurchLine);
        RecGItemHistory.SETRECORD(RecGItem);
        RecGItemHistory.LOOKUPMODE := TRUE;
        RecGItemHistory.RUNMODAL;
        CLEAR(RecGItemHistory);
    end;
}

