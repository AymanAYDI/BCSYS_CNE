codeunit 50051 "tmp SH"
{

    trigger OnRun()
    begin
        CustLedgerEntry.SETFILTER("Posting Date", '%1..', 041618D);
        CustLedgerEntry.SETFILTER("DEEE TTC Amount", '<>0');
        CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::Invoice, CustLedgerEntry."Document Type"::"Credit Memo");
        GLEntry.SETRANGE("Source Type", GLEntry."Source Type"::Customer);
        GenJnlLine.SETRANGE("Journal Template Name", 'OD');
        GenJnlLine.SETRANGE("Journal Batch Name", 'COR');
        GenJnlLine.DELETEALL(TRUE);

        LineNo := 10000;
        IF CustLedgerEntry.FINDSET THEN
            REPEAT
                CustLedgerEntry.CALCFIELDS(Amount);
                GLEntry.SETRANGE("Document No.", CustLedgerEntry."Document No.");
                GLEntry.SETRANGE("Posting Date", CustLedgerEntry."Posting Date");
                GLEntry.SETFILTER("G/L Account No.", '41*');
                GLEntry.FINDFIRST;
                GLEntry.CALCSUMS(Amount);
                IF CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::"Credit Memo" THEN
                    CustLedgerEntry."DEEE TTC Amount" := CustLedgerEntry."DEEE TTC Amount" * -1;
                IF ABS(GLEntry.Amount) <> ABS(CustLedgerEntry.Amount + CustLedgerEntry."DEEE TTC Amount") THEN BEGIN
                    LineNo := LineNo + 10000;
                    GenJnlLine.INIT;
                    GenJnlLine."Journal Template Name" := 'OD';
                    GenJnlLine."Journal Batch Name" := 'COR';
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."System-Created Entry" := TRUE;
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                    GenJnlLine.VALIDATE("Account No.", '708000');
                    GenJnlLine.VALIDATE("Posting Date", CustLedgerEntry."Posting Date");
                    GenJnlLine."Source Code" := CustLedgerEntry."Source Code";
                    GenJnlLine."Document No." := CustLedgerEntry."Document No.";
                    //GenJnlLine."Document Type" := CustLedgerEntry."Document Type";
                    GenJnlLine."Due Date" := CustLedgerEntry."Due Date";
                    GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::Sale;
                    GenJnlLine.VALIDATE("VAT Bus. Posting Group", 'NATIONAL');
                    GenJnlLine.VALIDATE("VAT Prod. Posting Group", 'TVA20');
                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::Customer;
                    GenJnlLine.VALIDATE("Bal. Account No.", CustLedgerEntry."Customer No.");
                    GenJnlLine.VALIDATE(Amount, GLEntry.Amount - (CustLedgerEntry.Amount + CustLedgerEntry."DEEE TTC Amount"));
                    GenJnlLine.Description := COPYSTR(STRSUBSTNO('%1 %2 - Régul. Imputation DEEE', CustLedgerEntry."Document Type", CustLedgerEntry."Document No."), 1, MAXSTRLEN(GenJnlLine.Description));
                    GenJnlLine."Dimension Set ID" := CustLedgerEntry."Dimension Set ID";
                    GenJnlLine.INSERT(TRUE);
                END;
            UNTIL CustLedgerEntry.NEXT = 0;
        MESSAGE('OK');
    end;

    var
        CustLedgerEntry: Record "21";
        GLEntry: Record "17";
        GenJnlLine: Record "81";
        LineNo: Integer;
}

