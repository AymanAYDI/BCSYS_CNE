codeunit 50008 "VendEntry-Apply Posted SPE"
{
    // //NAVEASY BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Création du CU par copie du CU 227 Version List NAVW14.00.02

    Permissions = TableData 25 = rm;
    TableNo = 25;

    trigger OnRun()
    var
        EntriesToApply: Record "25";
        ApplicationDate: Date;
    begin
        WITH Rec DO BEGIN
            IF NOT PaymentToleranceMgt.PmtTolVend(Rec) THEN
                EXIT;
            GET("Entry No.");

            ApplicationDate := 0D;
            EntriesToApply.SETCURRENTKEY("Vendor No.", "Applies-to ID");
            EntriesToApply.SETRANGE("Vendor No.", "Vendor No.");
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
            //std  PostApplication.GetValues(GenJnlLine."Document No.",GenJnlLine."Posting Date");

            //>>JNP
            GenJnlLine."Document No." := "Document No.";
            GenJnlLine."Posting Date" := "Posting Date";   //"Récup : code lettrage" ;
            IF GenJnlLine."Posting Date" < ApplicationDate
               THEN
                GenJnlLine."Posting Date" := ApplicationDate;
            //<< JNP

            IF GenJnlLine."Posting Date" < ApplicationDate THEN
                ERROR(
                  Text003,
                  GenJnlLine.FIELDCAPTION("Posting Date"), FIELDCAPTION("Posting Date"), TABLECAPTION,
                  GenJnlLine."Posting Date", ApplicationDate, "Applies-to ID");
            //std  END ELSE
            //std    EXIT;

            //std  Window.OPEN(Text001);

            SourceCodeSetup.GET;

            GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
            GenJnlLine."Account No." := "Vendor No.";
            CALCFIELDS("Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)");
            GenJnlLine.Correction :=
              ("Debit Amount" < 0) OR ("Credit Amount" < 0) OR
              ("Debit Amount (LCY)" < 0) OR ("Credit Amount (LCY)" < 0);
            GenJnlLine."Document Type" := "Document Type";
            GenJnlLine.Description := Description;
            GenJnlLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
            GenJnlLine."Posting Group" := "Vendor Posting Group";
            GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
            GenJnlLine."Source No." := "Vendor No.";
            GenJnlLine."Source Code" := SourceCodeSetup."Purchase Entry Application";
            GenJnlLine."System-Created Entry" := TRUE;

            EntryNoBeforeApplication := FindLastApplDtldVendLedgEntry;

            GenJnlPostLine.VendPostApplyVendLedgEntry(GenJnlLine, Rec);
            /*std
              EntryNoAfterApplication := FindLastApplDtldVendLedgEntry;
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
        PaymentToleranceMgt: Codeunit "426";
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

    local procedure FindLastApplDtldVendLedgEntry(): Integer
    var
        DtldVendLedgEntry: Record "380";
    begin
        DtldVendLedgEntry.LOCKTABLE;
        IF DtldVendLedgEntry.FIND('+') THEN
            EXIT(DtldVendLedgEntry."Entry No.")
        ELSE
            EXIT(0);
    end;

    local procedure FindLastApplEntry(VendLedgEntryNo: Integer): Integer
    var
        DtldVendLedgEntry: Record "380";
        ApplicationEntryNo: Integer;
    begin
        DtldVendLedgEntry.SETCURRENTKEY("Vendor Ledger Entry No.", "Entry Type");
        DtldVendLedgEntry.SETRANGE("Vendor Ledger Entry No.", VendLedgEntryNo);
        DtldVendLedgEntry.SETRANGE("Entry Type", DtldVendLedgEntry."Entry Type"::Application);
        ApplicationEntryNo := 0;
        IF DtldVendLedgEntry.FIND('-') THEN
            REPEAT
                IF (DtldVendLedgEntry."Entry No." > ApplicationEntryNo) AND NOT DtldVendLedgEntry.Unapplied THEN
                    ApplicationEntryNo := DtldVendLedgEntry."Entry No.";
            UNTIL DtldVendLedgEntry.NEXT = 0;
        EXIT(ApplicationEntryNo);
    end;

    local procedure FindLastTransactionNo(VendLedgEntryNo: Integer): Integer
    var
        DtldVendLedgEntry: Record "380";
        LastTransactionNo: Integer;
    begin
        DtldVendLedgEntry.SETCURRENTKEY("Vendor Ledger Entry No.", "Entry Type");
        DtldVendLedgEntry.SETRANGE("Vendor Ledger Entry No.", VendLedgEntryNo);
        LastTransactionNo := 0;
        IF DtldVendLedgEntry.FIND('-') THEN
            REPEAT
                IF (DtldVendLedgEntry."Transaction No." > LastTransactionNo) AND NOT DtldVendLedgEntry.Unapplied THEN
                    LastTransactionNo := DtldVendLedgEntry."Transaction No.";
            UNTIL DtldVendLedgEntry.NEXT = 0;
        EXIT(LastTransactionNo);
    end;

    [Scope('Internal')]
    procedure UnApplyDtldVendLedgEntry(DtldVendLedgEntry: Record "380")
    var
        ApplicationEntryNo: Integer;
    begin
        DtldVendLedgEntry.TESTFIELD("Entry Type", DtldVendLedgEntry."Entry Type"::Application);
        DtldVendLedgEntry.TESTFIELD(Unapplied, FALSE);
        ApplicationEntryNo := FindLastApplEntry(DtldVendLedgEntry."Vendor Ledger Entry No.");

        IF DtldVendLedgEntry."Entry No." <> ApplicationEntryNo THEN
            ERROR(Text005);
        CheckReversal(DtldVendLedgEntry."Vendor Ledger Entry No.");
        UnApplyVendor(DtldVendLedgEntry);
    end;

    [Scope('Internal')]
    procedure UnApplyVendLedgEntry(VendLedgEntryNo: Integer)
    var
        VendLedgentry: Record "25";
        DtldVendLedgEntry: Record "380";
        ApplicationEntryNo: Integer;
    begin
        CheckReversal(VendLedgEntryNo);
        ApplicationEntryNo := FindLastApplEntry(VendLedgEntryNo);
        IF ApplicationEntryNo = 0 THEN
            ERROR(Text006, VendLedgentry.TABLECAPTION, VendLedgEntryNo);
        DtldVendLedgEntry.GET(ApplicationEntryNo);
        UnApplyVendor(DtldVendLedgEntry);
    end;

    local procedure UnApplyVendor(DtldVendLedgEntry: Record "380")
    var
        UnapplyVendEntries: Page "624";
    begin
        WITH DtldVendLedgEntry DO BEGIN
            TESTFIELD("Entry Type", "Entry Type"::Application);
            TESTFIELD(Unapplied, FALSE);
            UnapplyVendEntries.SetDtldVendLedgEntry("Entry No.");
            UnapplyVendEntries.LOOKUPMODE(TRUE);
            UnapplyVendEntries.RUNMODAL;
        END;
    end;

    [Scope('Internal')]
    procedure PostUnApplyVendor(var DtldVendLedgEntryBuf: Record "380"; DtldVendLedgEntry2: Record "380"; var DocNo: Code[20]; var PostingDate: Date)
    var
        GLEntry: Record "17";
        VendLedgEntry: Record "25";
        DtldVendLedgEntry: Record "380";
        SourceCodeSetup: Record "242";
        GenJnlLine: Record "81";
        DateComprReg: Record "87";
        GenJnlPostLine: Codeunit "12";
        Window: Dialog;
        ApplicationEntryNo: Integer;
        LastTransactionNo: Integer;
        AddCurrChecked: Boolean;
    begin
        IF NOT DtldVendLedgEntryBuf.FIND('-') THEN
            ERROR(Text010);
        IF NOT CONFIRM(Text011 + Text007, FALSE) THEN
            EXIT;
        MaxPostingDate := 0D;
        GLEntry.LOCKTABLE;
        DtldVendLedgEntry.LOCKTABLE;
        VendLedgEntry.LOCKTABLE;
        VendLedgEntry.GET(DtldVendLedgEntry2."Vendor Ledger Entry No.");
        CheckPostingDate(PostingDate, '', 0);
        DtldVendLedgEntry.SETCURRENTKEY("Transaction No.", "Vendor No.", "Entry Type");
        DtldVendLedgEntry.SETRANGE("Transaction No.", DtldVendLedgEntry2."Transaction No.");
        DtldVendLedgEntry.SETRANGE("Vendor No.", DtldVendLedgEntry2."Vendor No.");
        IF DtldVendLedgEntry.FIND('-') THEN
            REPEAT
                IF (DtldVendLedgEntry."Entry Type" <> DtldVendLedgEntry."Entry Type"::"Initial Entry") AND
                   NOT DtldVendLedgEntry.Unapplied
                THEN BEGIN
                    IF NOT AddCurrChecked THEN BEGIN
                        CheckAdditionalCurrency(PostingDate, DtldVendLedgEntry."Posting Date");
                        AddCurrChecked := TRUE;
                    END;
                    CheckReversal(DtldVendLedgEntry."Vendor Ledger Entry No.");
                    IF DtldVendLedgEntry."Entry Type" = DtldVendLedgEntry."Entry Type"::Application THEN BEGIN
                        ApplicationEntryNo :=
                          FindLastApplEntry(DtldVendLedgEntry."Vendor Ledger Entry No.");
                        IF (ApplicationEntryNo <> 0) AND (ApplicationEntryNo <> DtldVendLedgEntry."Entry No.") THEN
                            ERROR(Text012, VendLedgEntry.TABLECAPTION, DtldVendLedgEntry."Vendor Ledger Entry No.");
                    END;
                    LastTransactionNo := FindLastTransactionNo(DtldVendLedgEntry."Vendor Ledger Entry No.");
                    IF (LastTransactionNo <> 0) AND (LastTransactionNo <> DtldVendLedgEntry."Transaction No.") THEN
                        ERROR(
                          Text015,
                          VendLedgEntry.TABLECAPTION,
                          DtldVendLedgEntry."Vendor Ledger Entry No.",
                          VendLedgEntry.FIELDCAPTION("Transaction No."));
                END;
            UNTIL DtldVendLedgEntry.NEXT = 0;

        DateComprReg.CheckMaxDateCompressed(MaxPostingDate, 0);

        WITH DtldVendLedgEntry2 DO BEGIN
            SourceCodeSetup.GET;
            VendLedgEntry.GET("Vendor Ledger Entry No.");
            GenJnlLine."Document No." := DocNo;
            GenJnlLine."Posting Date" := PostingDate;
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
            GenJnlLine."Account No." := "Vendor No.";
            GenJnlLine.Correction := TRUE;
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
            GenJnlLine.Description := VendLedgEntry.Description;
            GenJnlLine."Shortcut Dimension 1 Code" := VendLedgEntry."Global Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := VendLedgEntry."Global Dimension 2 Code";
            GenJnlLine."Posting Group" := VendLedgEntry."Vendor Posting Group";
            GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
            GenJnlLine."Source No." := "Vendor No.";
            GenJnlLine."Source Code" := SourceCodeSetup."Unapplied Purch. Entry Appln.";
            GenJnlLine."System-Created Entry" := TRUE;
            Window.OPEN(Text008);
            GenJnlPostLine.UnapplyVendLedgEntry(GenJnlLine, DtldVendLedgEntry2);
            DtldVendLedgEntryBuf.DELETEALL;
            DocNo := '';
            PostingDate := 0D;
            COMMIT;
            Window.CLOSE;
            MESSAGE(Text009);
        END;
    end;

    local procedure CheckPostingDate(PostingDate: Date; Caption: Text[50]; EntryNo: Integer)
    var
        VendLedgEntry: Record "25";
    begin
        IF GenJnlCheckLine.DateNotAllowed(PostingDate) THEN BEGIN
            IF Caption <> '' THEN
                ERROR(Text013, VendLedgEntry.FIELDCAPTION("Posting Date"), Caption, EntryNo)
            ELSE
                ERROR(Text014, VendLedgEntry.FIELDCAPTION("Posting Date"));
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
    procedure CheckReversal(VendLedgEntryNo: Integer)
    var
        VendLedgEntry: Record "25";
    begin
        VendLedgEntry.GET(VendLedgEntryNo);
        IF VendLedgEntry.Reversed THEN
            ERROR(Text017, VendLedgEntry.TABLECAPTION, VendLedgEntryNo);
    end;
}

