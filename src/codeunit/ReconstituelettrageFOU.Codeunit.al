codeunit 50003 "Reconstitue lettrage FOU"
{
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Création du CU
    //                                                              => permet d'initialiser les écritures a lettrer
    //                                                              => permet de lancer le CU 50006 lettrant les écritures
    // //TDL point 97 09/05/07 DARI
    //                   VendEntryApplyPostedEntries.RUN(VendLedgerEntry);
    // // Error CustEntryApplyPostedEntries.RUN(CustLedgerEntry); : 50 002 from NAVEASY
    // // Rename in 50 008
    // // SU Change Rigths on Vendor Ledger Entry

    Permissions = TableData 25 = rim;

    trigger OnRun()
    begin
    end;

    var
        VendEntryApplyPostedEntries: Codeunit "50008";
        flag: Text[100];

    [Scope('Internal')]
    procedure InitialisationLettrage(VendLedgerEntry: Record "25")
    begin

        VendLedgerEntry."Applies-to ID" := USERID;
        IF VendLedgerEntry."Applies-to ID" = '' THEN
            VendLedgerEntry."Applies-to ID" := '***';

        VendLedgerEntry."Applying Entry" := TRUE; // !!!!!!!!!!!
        VendLedgerEntry.CALCFIELDS("Remaining Amount");
        VendLedgerEntry."Amount to Apply" := VendLedgerEntry."Remaining Amount"; //devise ?
        VendLedgerEntry.MODIFY;
    end;

    [Scope('Internal')]
    procedure Lettrage(VendorNo: Code[20])
    var
        VendLedgerEntry: Record "25";
        VendLedgerEntry2: Record "25";
    begin
        VendLedgerEntry2.SETCURRENTKEY("Vendor No.", "Applies-to ID");
        VendLedgerEntry2.SETRANGE("Vendor No.", VendorNo);
        VendLedgerEntry2.SETFILTER("Applies-to ID", '<>%1', '');
        flag := 'jnpat';
        IF VendLedgerEntry2.FIND('-') THEN
            REPEAT

                IF flag <> VendLedgerEntry2."Applies-to ID"
                   THEN BEGIN
                    VendLedgerEntry.SETCURRENTKEY("Vendor No.", "Applies-to ID");
                    VendLedgerEntry.SETRANGE("Vendor No.", VendLedgerEntry2."Vendor No.");
                    VendLedgerEntry.SETRANGE(VendLedgerEntry."Applies-to ID", VendLedgerEntry2."Applies-to ID");
                    VendLedgerEntry.FIND('-');
                    VendEntryApplyPostedEntries.RUN(VendLedgerEntry);
                    flag := VendLedgerEntry2."Applies-to ID";
                END;
            UNTIL VendLedgerEntry2.NEXT = 0; //écritures
    end;
}

