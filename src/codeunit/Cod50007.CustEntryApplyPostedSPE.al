codeunit 50007 "BC6_CustEntry-Apply Posted SPE"
{

    Permissions = TableData "Vendor Ledger Entry" = rm;
    TableNo = "Cust. Ledger Entry";

    trigger OnRun()
    var
        EntriesToApply: Record "Cust. Ledger Entry";
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
            EntriesToApply.FIND();
            REPEAT
                IF EntriesToApply."Posting Date" > ApplicationDate THEN
                    ApplicationDate := EntriesToApply."Posting Date";
            UNTIL EntriesToApply.NEXT = 0;
            GenJnlLine.INIT;
            GenJnlLine."Document No." := "Document No.";
            GenJnlLine."Posting Date" := "Posting Date";
            IF GenJnlLine."Posting Date" < ApplicationDate
               THEN
                GenJnlLine."Posting Date" := ApplicationDate;

            IF GenJnlLine."Posting Date" < ApplicationDate THEN
                ERROR(
                  Text003,
                  GenJnlLine.FIELDCAPTION("Posting Date"), FIELDCAPTION("Posting Date"), TABLECAPTION);
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

            IF EntryNoAfterApplication <> EntryNoBeforeApplication THEN BEGIN
                COMMIT;
            END;
        END;

    end;

    var
        SourceCodeSetup: Record "Source Code Setup";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlCheckLine: Codeunit "Gen. Jnl.-Check Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PaymentToleracenMgt: Codeunit "Payment Tolerance Management";

        Text001: Label 'Posting application...', Comment = 'FRA="Validation du lettrage..."';
        Text002: Label 'The application was successfully posted.', Comment = 'FRA="Le lettrage a été validé avec succés."';
        Text003: Label 'The %1 entered must not be before the %2 on the %3.', Comment = 'FRA="La %1 saisie ne doit pas étre antérieure à la %2 sur %3."';
        Text004: Label 'The application was successfully posted though no entries have been applied.', Comment = 'FRA="Le lettrage a été validé avec succès bien qu''aucune écriture n''ait été lettré."';
        Window: Dialog;
        EntryNoBeforeApplication: Integer;
        EntryNoAfterApplication: Integer;
        Text005: Label 'Before you can unapply this entry, you must first unapply all application entries that were posted after this entry.', Comment = 'FRA="Avant de délettrer cette écriture, vous devez délettrer toutes les écritures comptabilisées postérieurement."';
        Text006: Label '%1 No. %2 does not have an application entry.', Comment = 'FRA="Le (la) %1 n° %2 n''a pas d''écriture de lettrage."';
        Text007: Label 'Do you want to unapply the entries?', Comment = 'FRA="Souhaitez-vous délettrer les écritures ?"';
        Text008: Label 'Unapplying and posting...', Comment = 'FRA="Délettrage et comptabilisation..."';
        Text009: Label 'The entries were successfully unapplied.', Comment = 'FRA="Délettrage des écritures réussi."';
        Text010: Label 'There is nothing to unapply. ', Comment = 'FRA="Aucun délettrage à effectuer. "';
        Text011: Label 'To unapply these entries, the program will post correcting entries.\', Comment = 'FRA="Pour délettrer ces écritures, le programme va valider les écritures correctrices.\"';
        Text012: Label 'Before you can unapply this entry, you must first unapply all application entries in %1 No. %2 that were posted after this entry.', Comment = 'FRA="Avant de délettrer cette écriture, vous devez délettrer toutes les écritures de %1 n° %2 comptabilisées postérieurement."';
        Text013: Label '%1 is not within your range of allowed posting dates in %2 No. %3.', Comment = 'FRA="%1 n''appartient pas à la plage de dates de comptabilisation autorisée dans %2 n° %3."';
        Text014: Label '%1 is not within your range of allowed posting dates.', Comment = 'FRA="%1 n''appartient pas à  la plage de dates de comptabilisation autorisée."';
        Text015: Label 'The latest %3 must be an application in %1 No. %2.', Comment = 'FRA="Le (la) dernier (dernière) %3 doit correspondre à  un lettrage dans %1 n° %2."';
        Text016: Label 'You cannot unapply the entry with the posting date %1, because the exchange rate for the additional reporting currency has been changed. ', Comment = 'FRA="Vous ne pouvez pas délettrer l''écriture dont la date de comptabilisation est %1, car le taux de change de la devise report supplémentaire a changé."';
        MaxPostingDate: Date;
        Text017: Label 'You cannot unapply %1 No. %2 because the entry has been involved in a reversal.', Comment = 'FRA="Vous ne pouvez pas délettrer %1 n° %2, car l''écriture a été impliquée dans une contrepassation."';

    local procedure FindLastApplDtldCustLedgEntry(): Integer
    var
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        DtldCustLedgEntry.LOCKTABLE;
        IF DtldCustLedgEntry.FIND('+') THEN
            EXIT(DtldCustLedgEntry."Entry No.")
        ELSE
            EXIT(0);
    end;

    local procedure FindLastApplEntry(CustLedgEntryNo: Integer): Integer
    var
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        ApplicationEntryNo: Integer;
    begin
        DtldCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type");
        DtldCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntryNo);
        DtldCustLedgEntry.SETRANGE("Entry Type", DtldCustLedgEntry."Entry Type"::Application);
        ApplicationEntryNo := 0;
        IF DtldCustLedgEntry.FindFirst() THEN
            REPEAT
                IF (DtldCustLedgEntry."Entry No." > ApplicationEntryNo) AND NOT DtldCustLedgEntry.Unapplied THEN
                    ApplicationEntryNo := DtldCustLedgEntry."Entry No.";
            UNTIL DtldCustLedgEntry.NEXT = 0;
        EXIT(ApplicationEntryNo);
    end;

    local procedure FindLastTransactionNo(CustLedgEntryNo: Integer): Integer
    var
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        LastTransactionNo: Integer;
    begin
        DtldCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type");
        DtldCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntryNo);
        LastTransactionNo := 0;
        IF DtldCustLedgEntry.FindFirst() THEN
            REPEAT
                IF (DtldCustLedgEntry."Transaction No." > LastTransactionNo) AND NOT DtldCustLedgEntry.Unapplied THEN
                    LastTransactionNo := DtldCustLedgEntry."Transaction No.";
            UNTIL DtldCustLedgEntry.NEXT = 0;
        EXIT(LastTransactionNo);
    end;

    procedure UnApplyDtldCustLedgEntry(DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
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

    procedure UnApplyCustLedgEntry(CustLedgEntryNo: Integer)
    var
        CustLedgentry: Record "Cust. Ledger Entry";
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        ApplicationEntryNo: Integer;
    begin
        CheckReversal(CustLedgEntryNo);
        ApplicationEntryNo := FindLastApplEntry(CustLedgEntryNo);
        IF ApplicationEntryNo = 0 THEN
            ERROR(Text006, CustLedgentry.TABLECAPTION, CustLedgEntryNo);
        DtldCustLedgEntry.GET(ApplicationEntryNo);
        UnApplyCustomer(DtldCustLedgEntry);
    end;

    local procedure UnApplyCustomer(DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    var
        UnapplyCustEntries: Page "Unapply Customer Entries";
    begin
        WITH DtldCustLedgEntry DO BEGIN
            TESTFIELD("Entry Type", "Entry Type"::Application);
            TESTFIELD(Unapplied, FALSE);
            UnapplyCustEntries.SetDtldCustLedgEntry("Entry No.");
            UnapplyCustEntries.LOOKUPMODE(TRUE);
            UnapplyCustEntries.RUNMODAL;
        END;
    end;

    procedure PostUnApplyCustomer(var DtldCustLedgEntryBuf: Record "Detailed Cust. Ledg. Entry"; DtldCustLedgEntry2: Record "Detailed Cust. Ledg. Entry"; var DocNo: Code[20]; var PostingDate: Date)
    var
        GLEntry: Record "G/L Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        BC6_SourceCodeSetup: Record "Source Code Setup";
        BC6_GenJnlLine: Record "Gen. Journal Line";
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        BC6_GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        DateComprReg: Record "Date Compr. Register";
        BC6_Window: Dialog;
        ApplicationEntryNo: Integer;
        LastTransactionNo: Integer;
        AddCurrChecked: Boolean;
    begin
        IF NOT DtldCustLedgEntryBuf.FindFirst() THEN
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
        IF DtldCustLedgEntry.FindFirst() THEN
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
            BC6_SourceCodeSetup.GET;
            CustLedgEntry.GET("Cust. Ledger Entry No.");
            BC6_GenJnlLine."Document No." := DocNo;
            BC6_GenJnlLine."Posting Date" := PostingDate;
            BC6_GenJnlLine."Account Type" := BC6_GenJnlLine."Account Type"::Customer;
            BC6_GenJnlLine."Account No." := "Customer No.";
            BC6_GenJnlLine.Correction := TRUE;
            BC6_GenJnlLine."Document Type" := BC6_GenJnlLine."Document Type"::" ";
            BC6_GenJnlLine.Description := CustLedgEntry.Description;
            BC6_GenJnlLine."Shortcut Dimension 1 Code" := CustLedgEntry."Global Dimension 1 Code";
            BC6_GenJnlLine."Shortcut Dimension 2 Code" := CustLedgEntry."Global Dimension 2 Code";
            BC6_GenJnlLine."Posting Group" := CustLedgEntry."Customer Posting Group";
            BC6_GenJnlLine."Source Type" := BC6_GenJnlLine."Source Type"::Customer;
            BC6_GenJnlLine."Source No." := "Customer No.";
            BC6_GenJnlLine."Source Code" := BC6_SourceCodeSetup."Unapplied Sales Entry Appln.";
            BC6_GenJnlLine."System-Created Entry" := TRUE;
            BC6_Window.OPEN(Text008);
            BC6_GenJnlPostLine.UnapplyCustLedgEntry(BC6_GenJnlLine, DtldCustLedgEntry2);
            DtldCustLedgEntryBuf.DELETEALL;
            DocNo := '';
            PostingDate := 0D;
            COMMIT;
            BC6_Window.CLOSE;
            MESSAGE(Text009);
        END;
    end;

    local procedure CheckPostingDate(PostingDate: Date; Caption: Text[50]; EntryNo: Integer)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
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
        GLSetup: Record "General Ledger Setup";
        CurrExchRate: Record "Currency Exchange Rate";
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

    procedure CheckReversal(CustLedgEntryNo: Integer)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.GET(CustLedgEntryNo);
        IF CustLedgEntry.Reversed THEN
            ERROR(Text017, CustLedgEntry.TABLECAPTION, CustLedgEntryNo);
    end;
}

