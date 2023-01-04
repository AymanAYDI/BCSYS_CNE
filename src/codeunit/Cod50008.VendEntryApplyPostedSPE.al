codeunit 50008 "BC6_VendEntry-Apply Posted SPE"
{

    Permissions = TableData "Vendor Ledger Entry" = rm;
    TableNo = "Vendor Ledger Entry";

    trigger OnRun()
    var
        EntriesToApply: Record "Vendor Ledger Entry";
        ApplicationDate: Date;
    begin
        IF NOT PaymentToleranceMgt.PmtTolVend(Rec) THEN
            EXIT;
        Rec.GET(Rec."Entry No.");

        ApplicationDate := 0D;
        EntriesToApply.SETCURRENTKEY("Vendor No.", "Applies-to ID");
        EntriesToApply.SETRANGE("Vendor No.", Rec."Vendor No.");
        EntriesToApply.SETRANGE("Applies-to ID", Rec."Applies-to ID");
        EntriesToApply.FIND('-');
        REPEAT
            IF EntriesToApply."Posting Date" > ApplicationDate THEN
                ApplicationDate := EntriesToApply."Posting Date";
        UNTIL EntriesToApply.NEXT() = 0;

        GenJnlLine.INIT();
        GenJnlLine."Document No." := Rec."Document No.";
        GenJnlLine."Posting Date" := Rec."Posting Date";
        IF GenJnlLine."Posting Date" < ApplicationDate
           THEN
            GenJnlLine."Posting Date" := ApplicationDate;

        IF GenJnlLine."Posting Date" < ApplicationDate THEN
            ERROR(
              Text003,
              GenJnlLine.FIELDCAPTION("Posting Date"), Rec.FIELDCAPTION("Posting Date"), Rec.TABLECAPTION,
              GenJnlLine."Posting Date", ApplicationDate, Rec."Applies-to ID");

        SourceCodeSetup.GET();

        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
        GenJnlLine."Account No." := Rec."Vendor No.";
        Rec.CALCFIELDS("Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)");
        GenJnlLine.Correction :=
          (Rec."Debit Amount" < 0) OR (Rec."Credit Amount" < 0) OR
          (Rec."Debit Amount (LCY)" < 0) OR (Rec."Credit Amount (LCY)" < 0);
        GenJnlLine."Document Type" := Rec."Document Type";
        GenJnlLine.Description := Rec.Description;
        GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
        GenJnlLine."Posting Group" := Rec."Vendor Posting Group";
        GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
        GenJnlLine."Source No." := Rec."Vendor No.";
        GenJnlLine."Source Code" := SourceCodeSetup."Purchase Entry Application";
        GenJnlLine."System-Created Entry" := TRUE;

        EntryNoBeforeApplication := FindLastApplDtldVendLedgEntry();

        GenJnlPostLine.VendPostApplyVendLedgEntry(GenJnlLine, Rec);

        IF EntryNoAfterApplication <> EntryNoBeforeApplication THEN BEGIN
            COMMIT();
        END;

    end;

    var
        GenJnlLine: Record "Gen. Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
        GenJnlCheckLine: Codeunit "Gen. Jnl.-Check Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        MaxPostingDate: Date;
        Window: Dialog;
        EntryNoAfterApplication: Integer;
        EntryNoBeforeApplication: Integer;

        Text001: Label 'Posting application...', Comment = 'FRA="Validation du lettrage..."';
        Text002: Label 'The application was successfully posted.', Comment = 'FRA="Le lettrage a été validé avec succés."';
        Text003: Label 'The %1 entered must not be before the %2 on the %3.', Comment = 'FRA="La %1 saisie ne doit pas étre antérieure à la %2 sur %3."';
        Text004: Label 'The application was successfully posted though no entries have been applied.', Comment = 'FRA="Le lettrage a été validé avec succés bien qu''aucune écriture n''ait été lettré."';
        Text005: Label 'Before you can unapply this entry, you must first unapply all application entries that were posted after this entry.', Comment = 'FRA="Avant de délettrer cette écriture, vous devez délettrer toutes les écritures comptabilisées postérieurement."';
        Text006: Label '%1 No. %2 does not have an application entry.', Comment = 'FRA="Le (la) %1 n° %2 n''a pas d''écriture de lettrage."';
        Text007: Label 'Do you want to unapply the entries?', Comment = 'FRA="Souhaitez-vous délettrer les écritures ?"';
        Text008: Label 'Unapplying and posting...', Comment = 'FRA="Délettrage et comptabilisation..."';
        Text009: Label 'The entries were successfully unapplied.', Comment = 'FRA="Délettrage des écritures réussi."';
        Text010: Label 'There is nothing to unapply. ', Comment = 'FRA="Aucun délettrage à effectuer. "';
        Text011: Label 'To unapply these entries, the program will post correcting entries.\', Comment = 'FRA="Pour délettrer ces écritures, le programme va valider les écritures correctrices.\"';
        Text012: Label 'Before you can unapply this entry, you must first unapply all application entries in %1 No. %2 that were posted after this entry.', Comment = 'FRA="Avant de délettrer cette écriture, vous devez délettrer toutes les écritures de %1 n° %2 comptabilisées postérieurement."';
        Text013: Label '%1 is not within your range of allowed posting dates in %2 No. %3.', Comment = 'FRA="%1 n''appartient pas à la plage de dates de comptabilisation autorisée dans %2 n° %3."';
        Text014: Label '%1 is not within your range of allowed posting dates.', Comment = 'FRA="%1 n''appartient pas à la plage de dates de comptabilisation autorisée."';
        Text015: Label 'The latest %3 must be an application in %1 No. %2.', Comment = 'FRA="Le (la) dernier (dernière) %3 doit correspondre à  un lettrage dans %1 n° %2."';
        Text016: Label 'You cannot unapply the entry with the posting date %1, because the exchange rate for the additional reporting currency has been changed. ', Comment = 'FRA="Vous ne pouvez pas délettrer l''écriture dont la date de comptabilisation est %1, car le taux de change de la devise report supplémentaire a changé."';
        Text017: Label 'You cannot unapply %1 No. %2 because the entry has been involved in a reversal.', Comment = 'FRA="Vous ne pouvez pas délettrer %1 n° %2, car l''écriture a été impliquée dans une contrepassation."';

    local procedure FindLastApplDtldVendLedgEntry(): Integer
    var
        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
    begin
        DtldVendLedgEntry.LOCKTABLE();
        IF DtldVendLedgEntry.FIND('+') THEN
            EXIT(DtldVendLedgEntry."Entry No.")
        ELSE
            EXIT(0);
    end;

    local procedure FindLastApplEntry(VendLedgEntryNo: Integer): Integer
    var
        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
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
            UNTIL DtldVendLedgEntry.NEXT() = 0;
        EXIT(ApplicationEntryNo);
    end;

    local procedure FindLastTransactionNo(VendLedgEntryNo: Integer): Integer
    var
        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        LastTransactionNo: Integer;
    begin
        DtldVendLedgEntry.SETCURRENTKEY("Vendor Ledger Entry No.", "Entry Type");
        DtldVendLedgEntry.SETRANGE("Vendor Ledger Entry No.", VendLedgEntryNo);
        LastTransactionNo := 0;
        IF DtldVendLedgEntry.FIND('-') THEN
            REPEAT
                IF (DtldVendLedgEntry."Transaction No." > LastTransactionNo) AND NOT DtldVendLedgEntry.Unapplied THEN
                    LastTransactionNo := DtldVendLedgEntry."Transaction No.";
            UNTIL DtldVendLedgEntry.NEXT() = 0;
        EXIT(LastTransactionNo);
    end;

    procedure UnApplyDtldVendLedgEntry(DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry")
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

    procedure UnApplyVendLedgEntry(VendLedgEntryNo: Integer)
    var
        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        VendLedgentry: Record "Vendor Ledger Entry";
        ApplicationEntryNo: Integer;
    begin
        CheckReversal(VendLedgEntryNo);
        ApplicationEntryNo := FindLastApplEntry(VendLedgEntryNo);
        IF ApplicationEntryNo = 0 THEN
            ERROR(Text006, VendLedgentry.TABLECAPTION, VendLedgEntryNo);
        DtldVendLedgEntry.GET(ApplicationEntryNo);
        UnApplyVendor(DtldVendLedgEntry);
    end;

    local procedure UnApplyVendor(DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry")
    var
        UnapplyVendEntries: Page "Unapply Vendor Entries";
    begin
        DtldVendLedgEntry.TESTFIELD("Entry Type", DtldVendLedgEntry."Entry Type"::Application);
        DtldVendLedgEntry.TESTFIELD(Unapplied, FALSE);
        UnapplyVendEntries.SetDtldVendLedgEntry(DtldVendLedgEntry."Entry No.");
        UnapplyVendEntries.LOOKUPMODE(TRUE);
        UnapplyVendEntries.RUNMODAL();
    end;

    procedure PostUnApplyVendor(var DtldVendLedgEntryBuf: Record "Detailed Vendor Ledg. Entry"; DtldVendLedgEntry2: Record "Detailed Vendor Ledg. Entry"; var DocNo: Code[20]; var PostingDate: Date)
    var
        DateComprReg: Record "Date Compr. Register";
        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        GLEntry: Record "G/L Entry";
        BC6_GenJnlLine: Record "Gen. Journal Line";
        BC6_SourceCodeSetup: Record "Source Code Setup";
        VendLedgEntry: Record "Vendor Ledger Entry";
        BC6_GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        AddCurrChecked: Boolean;
        BC6_Window: Dialog;
        ApplicationEntryNo: Integer;
        LastTransactionNo: Integer;
    begin
        IF NOT DtldVendLedgEntryBuf.FindFirst() THEN
            ERROR(Text010);
        IF NOT CONFIRM(Text011 + Text007, FALSE) THEN
            EXIT;
        MaxPostingDate := 0D;
        GLEntry.LOCKTABLE();
        DtldVendLedgEntry.LOCKTABLE();
        VendLedgEntry.LOCKTABLE();
        VendLedgEntry.GET(DtldVendLedgEntry2."Vendor Ledger Entry No.");
        CheckPostingDate(PostingDate, '', 0);
        DtldVendLedgEntry.SETCURRENTKEY("Transaction No.", "Vendor No.", "Entry Type");
        DtldVendLedgEntry.SETRANGE("Transaction No.", DtldVendLedgEntry2."Transaction No.");
        DtldVendLedgEntry.SETRANGE("Vendor No.", DtldVendLedgEntry2."Vendor No.");
        IF DtldVendLedgEntry.FindFirst() THEN
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
            UNTIL DtldVendLedgEntry.NEXT() = 0;

        DateComprReg.CheckMaxDateCompressed(MaxPostingDate, 0);

        BC6_SourceCodeSetup.GET();
        VendLedgEntry.GET(DtldVendLedgEntry2."Vendor Ledger Entry No.");
        BC6_GenJnlLine."Document No." := DocNo;
        BC6_GenJnlLine."Posting Date" := PostingDate;
        BC6_GenJnlLine."Account Type" := BC6_GenJnlLine."Account Type"::Vendor;
        BC6_GenJnlLine."Account No." := DtldVendLedgEntry2."Vendor No.";
        BC6_GenJnlLine.Correction := TRUE;
        BC6_GenJnlLine."Document Type" := BC6_GenJnlLine."Document Type"::" ";
        BC6_GenJnlLine.Description := VendLedgEntry.Description;
        BC6_GenJnlLine."Shortcut Dimension 1 Code" := VendLedgEntry."Global Dimension 1 Code";
        BC6_GenJnlLine."Shortcut Dimension 2 Code" := VendLedgEntry."Global Dimension 2 Code";
        BC6_GenJnlLine."Posting Group" := VendLedgEntry."Vendor Posting Group";
        BC6_GenJnlLine."Source Type" := BC6_GenJnlLine."Source Type"::Vendor;
        BC6_GenJnlLine."Source No." := DtldVendLedgEntry2."Vendor No.";
        BC6_GenJnlLine."Source Code" := BC6_SourceCodeSetup."Unapplied Purch. Entry Appln.";
        BC6_GenJnlLine."System-Created Entry" := TRUE;
        BC6_Window.OPEN(Text008);
        BC6_GenJnlPostLine.UnapplyVendLedgEntry(BC6_GenJnlLine, DtldVendLedgEntry2);
        DtldVendLedgEntryBuf.DELETEALL();
        DocNo := '';
        PostingDate := 0D;
        COMMIT();
        BC6_Window.CLOSE();
        MESSAGE(Text009);
    end;

    local procedure CheckPostingDate(PostingDate: Date; Caption: Text[50]; EntryNo: Integer)
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
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
        CurrExchRate: Record "Currency Exchange Rate";
        GLSetup: Record "General Ledger Setup";
    begin
        IF OldPostingDate = NewPostingDate THEN
            EXIT;
        GLSetup.GET();
        IF GLSetup."Additional Reporting Currency" <> '' THEN
            IF CurrExchRate.ExchangeRate(OldPostingDate, GLSetup."Additional Reporting Currency") <>
               CurrExchRate.ExchangeRate(NewPostingDate, GLSetup."Additional Reporting Currency")
            THEN
                ERROR(Text016, NewPostingDate);
    end;

    procedure CheckReversal(VendLedgEntryNo: Integer)
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        VendLedgEntry.GET(VendLedgEntryNo);
        IF VendLedgEntry.Reversed THEN
            ERROR(Text017, VendLedgEntry.TABLECAPTION, VendLedgEntryNo);
    end;
}

