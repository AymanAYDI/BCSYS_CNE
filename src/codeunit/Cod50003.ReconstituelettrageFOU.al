codeunit 50003 "BC6_Reconstitue lettrage FOU"
{
    Permissions = TableData "Vendor Ledger Entry" = rim;

    var
        VendEntryApplyPostedEntries: Codeunit "BC6_VendEntry-Apply Posted SPE";
        flag: Text[100];

    procedure InitialisationLettrage(VendLedgerEntry: Record "Vendor Ledger Entry")
    begin

        VendLedgerEntry."Applies-to ID" := CopyStr(USERID, 1, MaxStrLen(VendLedgerEntry."Applies-to ID")); //USERID cannot assgined to   code[50]
        IF VendLedgerEntry."Applies-to ID" = '' THEN
            VendLedgerEntry."Applies-to ID" := '***';

        VendLedgerEntry."Applying Entry" := TRUE;
        VendLedgerEntry.CALCFIELDS("Remaining Amount");
        VendLedgerEntry."Amount to Apply" := VendLedgerEntry."Remaining Amount";
        VendLedgerEntry.MODIFY();
    end;

    procedure Lettrage(VendorNo: Code[20])
    var
        VendLedgerEntry: Record "Vendor Ledger Entry";
        VendLedgerEntry2: Record "Vendor Ledger Entry";
    begin
        VendLedgerEntry2.SETCURRENTKEY("Vendor No.", "Applies-to ID");
        VendLedgerEntry2.SETRANGE("Vendor No.", VendorNo);
        VendLedgerEntry2.SETFILTER("Applies-to ID", '<>%1', '');
        flag := 'jnpat';
        IF VendLedgerEntry2.FIND() THEN
            REPEAT

                IF flag <> VendLedgerEntry2."Applies-to ID"
                   THEN BEGIN
                    VendLedgerEntry.SETCURRENTKEY("Vendor No.", "Applies-to ID");
                    VendLedgerEntry.SETRANGE("Vendor No.", VendLedgerEntry2."Vendor No.");
                    VendLedgerEntry.SETRANGE(VendLedgerEntry."Applies-to ID", VendLedgerEntry2."Applies-to ID");
                    VendLedgerEntry.FIND();
                    VendEntryApplyPostedEntries.RUN(VendLedgerEntry);
                    flag := VendLedgerEntry2."Applies-to ID";
                END;
            UNTIL VendLedgerEntry2.NEXT() = 0; //écritures
    end;
}
