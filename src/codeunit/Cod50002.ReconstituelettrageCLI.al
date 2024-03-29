codeunit 50002 "BC6_Reconstitue lettrage CLI"
{
    Permissions = TableData "Cust. Ledger Entry" = rimd;

    var
        CustEntryApplyPostedEntries: Codeunit "BC6_CustEntry-Apply Posted SPE";
        flag: Text[100];

    procedure InitialisationLettrage(CustLedgerEntry: Record "Cust. Ledger Entry")
    begin

        CustLedgerEntry."Applies-to ID" := CopyStr(UserId, 1, MaxStrLen(CustLedgerEntry."Applies-to ID")); //USERID
        IF CustLedgerEntry."Applies-to ID" = '' THEN
            CustLedgerEntry."Applies-to ID" := '***';

        CustLedgerEntry."Applying Entry" := TRUE;
        CustLedgerEntry.CALCFIELDS("Remaining Amount");
        CustLedgerEntry."Amount to Apply" := CustLedgerEntry."Remaining Amount";
        CustLedgerEntry.MODIFY();
    end;

    procedure Lettrage(CustNo: Code[20])
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry2: Record "Cust. Ledger Entry";
    begin
        CustLedgerEntry2.SETCURRENTKEY("Customer No.", "Applies-to ID");
        CustLedgerEntry2.SETRANGE("Customer No.", CustNo);
        CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Applies-to ID", '<>%1', '');
        flag := 'jnpat';
        IF CustLedgerEntry2.FIND('-') THEN
            REPEAT

                IF flag <> CustLedgerEntry2."Applies-to ID"
                   THEN BEGIN

                    CustLedgerEntry.SETCURRENTKEY("Customer No.", "Applies-to ID");
                    CustLedgerEntry.SETRANGE("Customer No.", CustLedgerEntry2."Customer No.");
                    CustLedgerEntry.SETRANGE(CustLedgerEntry."Applies-to ID", CustLedgerEntry2."Applies-to ID");
                    CustLedgerEntry.FINd();
                    CustEntryApplyPostedEntries.RUN(CustLedgerEntry);
                    flag := CustLedgerEntry2."Applies-to ID";
                END;
            UNTIL CustLedgerEntry2.NEXT() = 0; //écritures
    end;
}
