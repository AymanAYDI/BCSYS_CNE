codeunit 50002 "Reconstitue lettrage CLI"
{
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Création du CU
    //                                                              => permet d'initialiser les écritures a lettrer
    //                                                              => permet de lancer le CU 50005 lettrant les écritures
    // //TDL point 97 09/05/07 DARI
    // // Error CustEntryApplyPostedEntries.RUN(CustLedgerEntry); : 50 001 from NAVEASY
    // // Rename in 50 007

    Permissions = TableData 21 = rimd;

    trigger OnRun()
    begin
    end;

    var
        CustEntryApplyPostedEntries: Codeunit "50007";
        flag: Text[100];

    [Scope('Internal')]
    procedure InitialisationLettrage(CustLedgerEntry: Record "21")
    begin

        CustLedgerEntry."Applies-to ID" := USERID;
        IF CustLedgerEntry."Applies-to ID" = '' THEN
            CustLedgerEntry."Applies-to ID" := '***';

        CustLedgerEntry."Applying Entry" := TRUE; // !!!!!!!!!!!
        CustLedgerEntry.CALCFIELDS("Remaining Amount");
        CustLedgerEntry."Amount to Apply" := CustLedgerEntry."Remaining Amount";
        CustLedgerEntry.MODIFY;
    end;

    [Scope('Internal')]
    procedure Lettrage(CustNo: Code[20])
    var
        CustLedgerEntry: Record "21";
        CustLedgerEntry2: Record "21";
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
                    CustLedgerEntry.FIND('-');
                    CustEntryApplyPostedEntries.RUN(CustLedgerEntry);
                    flag := CustLedgerEntry2."Applies-to ID";
                END;
            UNTIL CustLedgerEntry2.NEXT = 0; //écritures
    end;
}

