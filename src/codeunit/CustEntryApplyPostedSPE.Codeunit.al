codeunit 50007 "CustEntry-Apply Posted SPE"
{
    // //NAVEASY BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Création du CU par copie du CU 226 Version List NAVW14.00.02

    Permissions = TableData 25 = rm;
    TableNo = 21;

    trigger OnRun()
    var
        EntriesToApply: Record "21";
        ApplicationDate: Date;
    begin
        WITH Rec DO BEGIN
            IF NOT PaymentToleracenMgt.PmtTolCust(Rec) THEN
                EXIT;
            GET("Entry No.");

            ApplicationDate := 0D;
            EntriesToApply.SETCURRENTKEY("Customer No.", "Applies-to ID");
            EntriesToApply.SETRANGE("Customer No.", "Customer No.");
            EntriesToApply.SETRANGE("Applies-to ID", "Applies-to ID");
            EntriesToApply.FIND('-');
            REPEAT
                IF EntriesToApply."Posting Date" > ApplicationDate THEN
                    ApplicationDate := EntriesToApply."Posting Date";
            UNTIL EntriesToApply.NEXT = 0;

            //std PostApplication.SetValues("Document No.",ApplicationDate);
            //std PostApplication.LOOKUPMODE(TRUE);
            //std IF ACTION::LookupOK = PostApplication.RUNMODAL THEN BEGIN
            GenJnlLine.INIT;
            //std PostApplication.GetValues(GenJnlLine."Document No.",GenJnlLine."Posting Date");

            //>>JNP
            GenJnlLine."Document No." := "Document No.";
            GenJnlLine."Posting Date" := "Posting Date";
            IF GenJnlLine."Posting Date" < ApplicationDate
               THEN
                GenJnlLine."Posting Date" := ApplicationDate;
            //<<JNP

            IF GenJnlLine."Posting Date" < ApplicationDate THEN
                ERROR(
                  Text003,
                  GenJnlLine.FIELDCAPTION("Posting Date"), FIELDCAPTION("Posting Date"), TABLECAPTION);
            //std END ELSE
            //std   EXIT;

            //std Window.OPEN(Text001);

            SourceCodeSetup.GET;

            GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
            GenJnlLine."Account No." := "Customer No.";
            CALCFIELDS("Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)");
            GenJnlLine.Correction :=
              ("Debit Amount" < 0) OR ("Credit Amount" < 0) OR
              ("Debit Amount (LCY)" < 0) OR ("Credit Amount (LCY)" < 0);
            GenJnlLine."Document Type" := "Document Type";
            GenJnlLine.Description := Description;
            GenJnlLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
            GenJnlLine."Posting Group" := "Customer Posting Group";
            GenJnlLine."Source Type" := GenJnlLine."Source Type"::Customer;
            GenJnlLine."Source No." := "Customer No.";
            GenJnlLine."Source Code" := SourceCodeSetup."Sales Entry Application";
            GenJnlLine."System-Created Entry" := TRUE;

            EntryNoBeforeApplication := FindLastApplDtldCustLedgEntry;

            GenJnlPostLine.CustPostApplyCustLedgEntry(GenJnlLine, Rec);

            EntryNoAfterApplication := FindLastApplDtldCustLedgEntry;
            /*std
            IF EntryNoAfterApplication = EntryNoBeforeApplication THEN
              ERROR(Text004);

            COMMIT;
            Window.CLOSE;
            MESSAGE(Text002);
          END;
             std*/


            IF EntryNoAfterApplication <> EntryNoBeforeApplication THEN BEGIN
                COMMIT;
                //std Window.CLOSE;
            END;
        END;

    end;

    var
        Text001: Label 'Posting application...';
        Text002: Label 'The application was successfully posted.';
        Text003: Label 'The %1 entered must not be before the %2 on the %3.';
        Text004: Label 'The application was successfully posted though no entries have been applied.';
        SourceCodeSetup: Record "242";
        GenJnlLine: Record "81";
        GenJnlCheckLine: Codeunit "11";
        GenJnlPostLine: Codeunit "12";
        PaymentToleracenMgt: Codeunit "426";
        Window: Dialog;
        EntryNoBeforeApplication: Integer;
        EntryNoAfterApplication: Integer;
        Text005: Label 'Before you can unapply this entry, you must first unapply all application entries that were posted after this entry.';
        Text006: Label '%1 No. %2 does not have an application entry.';
        Text007: Label 'Do you want to unapply the entries?';
        Text008: Label 'Unapplying and posting...';
        Text009: Label 'The entries were successfully unapplied.';
        Text010: Label 'There is nothing to unapply. ';
        Text011: Label 'To unapply these entries, the program will post correcting entries.\';
        Text012: Label 'Before you can unapply this entry, you must first unapply all application entries in %1 No. %2 that were posted after this entry.';
        Text013: Label '%1 is not within your range of allowed posting dates in %2 No. %3.';
        Text014: Label '%1 is not within your range of allowed posting dates.';
        Text015: Label 'The latest %3 must be an application in %1 No. %2.';
        Text016: Label 'You cannot unapply the entry with the posting date %1, because the exchange rate for the additional reporting currency has been changed. ';
        MaxPostingDate: Date;
        Text017: Label 'You cannot unapply %1 No. %2 because the entry has been involved in a reversal.';

    local procedure FindLastApplDtldCustLedgEntry(): Integer
    var
        DtldCustLedgEntry: Record "379";
    begin
        DtldCustLedgEntry.LOCKTABLE;
        IF DtldCustLedgEntry.FIND('+') THEN
            EXIT(DtldCustLedgEntry."Entry No.")
        ELSE
            EXIT(0);
    end;

    local procedure FindLastApplEntry(CustLedgEntryNo: Integer): Integer
    var
        DtldCustLedgEntry: Record "379";
        ApplicationEntryNo: Integer;
    begin
        DtldCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type");
        DtldCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntryNo);
        DtldCustLedgEntry.SETRANGE("Entry Type", DtldCustLedgEntry."Entry Type"::Application);
        ApplicationEntryNo := 0;
        IF DtldCustLedgEntry.FIND('-') THEN
            REPEAT
                IF (DtldCustLedgEntry."Entry No." > ApplicationEntryNo) AND NOT DtldCustLedgEntry.Unapplied THEN
                    ApplicationEntryNo := DtldCustLedgEntry."Entry No.";
            UNTIL DtldCustLedgEntry.NEXT = 0;
        EXIT(ApplicationEntryNo);
    end;

    local procedure FindLastTransactionNo(CustLedgEntryNo: Integer): Integer
    var
        DtldCustLedgEntry: Record "379";
        LastTransactionNo: Integer;
    begin
        DtldCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type");
        DtldCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntryNo);
        LastTransactionNo := 0;
        IF DtldCustLedgEntry.FIND('-') THEN
            REPEAT
                IF (DtldCustLedgEntry."Transaction No." > LastTransactionNo) AND NOT DtldCustLedgEntry.Unapplied THEN
                    LastTransactionNo := DtldCustLedgEntry."Transaction No.";
            UNTIL DtldCustLedgEntry.NEXT = 0;
        EXIT(LastTransactionNo);
    end;

    [Scope('Internal')]
    procedure UnApplyDtldCustLedgEntry(DtldCustLedgEntry: Record "379")
    var
        ApplicationEntryNo: Integer;
    begin
        DtldCustLedgEntry.TESTFIELD("Entry Type", DtldCustLedgEntry."Entry Type"::Application);
        DtldCustLedgEntry.TESTFIELD(Unapplied, FALSE);
        ApplicationEntryNo := FindLastApplEntry(DtldCustLedgEntry."Cust. Ledger Entry No.");

        IF DtldCustLedgEntry."Entry No." <> ApplicationEntryNo THEN
            ERROR(Text005);
        CheckReversal(DtldCustLedgEntry."Cust. Ledger Entry No.");
        UnApplyCustomer(DtldCustLedgEntry);
    end;

    [Scope('Internal')]
    procedure UnApplyCustLedgEntry(CustLedgEntryNo: Integer)
    var
        CustLedgentry: Record "21";
        DtldCustLedgEntry: Record "379";
        ApplicationEntryNo: Integer;
    begin
        CheckReversal(CustLedgEntryNo);
        ApplicationEntryNo := FindLastApplEntry(CustLedgEntryNo);
        IF ApplicationEntryNo = 0 THEN
            ERROR(Text006, CustLedgentry.TABLECAPTION, CustLedgEntryNo);
        DtldCustLedgEntry.GET(ApplicationEntryNo);
        UnApplyCustomer(DtldCustLedgEntry);
    end;

    local procedure UnApplyCustomer(DtldCustLedgEntry: Record "379")
    var
        UnapplyCustEntries: Page "623";
    begin
        WITH DtldCustLedgEntry DO BEGIN
            TESTFIELD("Entry Type", "Entry Type"::Application);
            TESTFIELD(Unapplied, FALSE);
            UnapplyCustEntries.SetDtldCustLedgEntry("Entry No.");
            UnapplyCustEntries.LOOKUPMODE(TRUE);
            UnapplyCustEntries.RUNMODAL;
        END;
    end;

    [Scope('Internal')]
    procedure PostUnApplyCustomer(var DtldCustLedgEntryBuf: Record "379"; DtldCustLedgEntry2: Record "379"; var DocNo: Code[20]; var PostingDate: Date)
    var
        GLEntry: Record "17";
        CustLedgEntry: Record "21";
        SourceCodeSetup: Record "242";
        GenJnlLine: Record "81";
        DtldCustLedgEntry: Record "379";
        GenJnlPostLine: Codeunit "12";
        DateComprReg: Record "87";
        Window: Dialog;
        ApplicationEntryNo: Integer;
        LastTransactionNo: Integer;
        AddCurrChecked: Boolean;
    begin
        IF NOT DtldCustLedgEntryBuf.FIND('-') THEN
            ERROR(Text010);
        IF NOT CONFIRM(Text011 + Text007, FALSE) THEN
            EXIT;
        MaxPostingDate := 0D;
        GLEntry.LOCKTABLE;
        DtldCustLedgEntry.LOCKTABLE;
        CustLedgEntry.LOCKTABLE;
        CustLedgEntry.GET(DtldCustLedgEntry2."Cust. Ledger Entry No.");
        CheckPostingDate(PostingDate, '', 0);
        DtldCustLedgEntry.SETCURRENTKEY("Transaction No.", "Customer No.", "Entry Type");
        DtldCustLedgEntry.SETRANGE("Transaction No.", DtldCustLedgEntry2."Transaction No.");
        DtldCustLedgEntry.SETRANGE("Customer No.", DtldCustLedgEntry2."Customer No.");
        IF DtldCustLedgEntry.FIND('-') THEN
            REPEAT
                IF (DtldCustLedgEntry."Entry Type" <> DtldCustLedgEntry."Entry Type"::"Initial Entry") AND
                   NOT DtldCustLedgEntry.Unapplied
                THEN BEGIN
                    IF NOT AddCurrChecked THEN BEGIN
                        CheckAdditionalCurrency(PostingDate, DtldCustLedgEntry."Posting Date");
                        AddCurrChecked := TRUE;
                    END;
                    CheckReversal(DtldCustLedgEntry."Cust. Ledger Entry No.");
                    IF DtldCustLedgEntry."Entry Type" = DtldCustLedgEntry."Entry Type"::Application THEN BEGIN
                        ApplicationEntryNo :=
                          FindLastApplEntry(DtldCustLedgEntry."Cust. Ledger Entry No.");
                        IF (ApplicationEntryNo <> 0) AND (ApplicationEntryNo <> DtldCustLedgEntry."Entry No.") THEN
                            ERROR(Text012, CustLedgEntry.TABLECAPTION, DtldCustLedgEntry."Cust. Ledger Entry No.");
                    END;
                    LastTransactionNo := FindLastTransactionNo(DtldCustLedgEntry."Cust. Ledger Entry No.");
                    IF (LastTransactionNo <> 0) AND (LastTransactionNo <> DtldCustLedgEntry."Transaction No.") THEN
                        ERROR(
                          Text015,
                          CustLedgEntry.TABLECAPTION,
                          DtldCustLedgEntry."Cust. Ledger Entry No.",
                          CustLedgEntry.FIELDCAPTION("Transaction No."));
                END;
            UNTIL DtldCustLedgEntry.NEXT = 0;

        DateComprReg.CheckMaxDateCompressed(MaxPostingDate, 0);

        WITH DtldCustLedgEntry2 DO BEGIN
            SourceCodeSetup.GET;
            CustLedgEntry.GET("Cust. Ledger Entry No.");
            GenJnlLine."Document No." := DocNo;
            GenJnlLine."Posting Date" := PostingDate;
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
            GenJnlLine."Account No." := "Customer No.";
            GenJnlLine.Correction := TRUE;
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
            GenJnlLine.Description := CustLedgEntry.Description;
            GenJnlLine."Shortcut Dimension 1 Code" := CustLedgEntry."Global Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := CustLedgEntry."Global Dimension 2 Code";
            GenJnlLine."Posting Group" := CustLedgEntry."Customer Posting Group";
            GenJnlLine."Source Type" := GenJnlLine."Source Type"::Customer;
            GenJnlLine."Source No." := "Customer No.";
            GenJnlLine."Source Code" := SourceCodeSetup."Unapplied Sales Entry Appln.";
            GenJnlLine."System-Created Entry" := TRUE;
            Window.OPEN(Text008);
            GenJnlPostLine.UnapplyCustLedgEntry(GenJnlLine, DtldCustLedgEntry2);
            DtldCustLedgEntryBuf.DELETEALL;
            DocNo := '';
            PostingDate := 0D;
            COMMIT;
            Window.CLOSE;
            MESSAGE(Text009);
        END;
    end;

    local procedure CheckPostingDate(PostingDate: Date; Caption: Text[50]; EntryNo: Integer)
    var
        CustLedgEntry: Record "21";
    begin
        IF GenJnlCheckLine.DateNotAllowed(PostingDate) THEN BEGIN
            IF Caption <> '' THEN
                ERROR(Text013, CustLedgEntry.FIELDCAPTION("Posting Date"), Caption, EntryNo)
            ELSE
                ERROR(Text014, CustLedgEntry.FIELDCAPTION("Posting Date"));
        END;
        IF PostingDate > MaxPostingDate THEN
            MaxPostingDate := PostingDate;
    end;

    local procedure CheckAdditionalCurrency(OldPostingDate: Date; NewPostingDate: Date)
    var
        GLSetup: Record "98";
        CurrExchRate: Record "330";
    begin
        IF OldPostingDate = NewPostingDate THEN
            EXIT;
        GLSetup.GET;
        IF GLSetup."Additional Reporting Currency" <> '' THEN
            IF CurrExchRate.ExchangeRate(OldPostingDate, GLSetup."Additional Reporting Currency") <>
               CurrExchRate.ExchangeRate(NewPostingDate, GLSetup."Additional Reporting Currency")
            THEN
                ERROR(Text016, NewPostingDate);
    end;

    [Scope('Internal')]
    procedure CheckReversal(CustLedgEntryNo: Integer)
    var
        CustLedgEntry: Record "21";
    begin
        CustLedgEntry.GET(CustLedgEntryNo);
        IF CustLedgEntry.Reversed THEN
            ERROR(Text017, CustLedgEntry.TABLECAPTION, CustLedgEntryNo);
    end;
}

