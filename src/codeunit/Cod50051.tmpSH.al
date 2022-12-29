codeunit 50051 "BC6_tmp SH"
{

    trigger OnRun()
    var
        Txtlbl: Label '%1 %2 - Régul. Imputation DEEE';
    begin
        CustLedgerEntry.SETFILTER("Posting Date", '%1..', 20160418D);
        CustLedgerEntry.SETFILTER("BC6_DEEE TTC Amount", '<>0');
        CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::Invoice, CustLedgerEntry."Document Type"::"Credit Memo");
        GLEntry.SETRANGE("Source Type", GLEntry."Source Type"::Customer);
        GenJnlLine.SETRANGE("Journal Template Name", 'OD');
        GenJnlLine.SETRANGE("Journal Batch Name", 'COR');
        GenJnlLine.DELETEALL(true);

        LineNo := 10000;
        if CustLedgerEntry.FINDSET() then
            repeat
                CustLedgerEntry.CALCFIELDS(Amount);
                GLEntry.SETRANGE("Document No.", CustLedgerEntry."Document No.");
                GLEntry.SETRANGE("Posting Date", CustLedgerEntry."Posting Date");
                GLEntry.SETFILTER("G/L Account No.", '41*');
                GLEntry.FINDFIRST();
                GLEntry.CALCSUMS(Amount);
                if CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::"Credit Memo" then
                    CustLedgerEntry."BC6_DEEE TTC Amount" := CustLedgerEntry."BC6_DEEE TTC Amount" * -1;
                if ABS(GLEntry.Amount) <> ABS(CustLedgerEntry.Amount + CustLedgerEntry."BC6_DEEE TTC Amount") then begin
                    LineNo := LineNo + 10000;
                    GenJnlLine.INIT();
                    GenJnlLine."Journal Template Name" := 'OD';
                    GenJnlLine."Journal Batch Name" := 'COR';
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."System-Created Entry" := true;
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
                    GenJnlLine.VALIDATE(Amount, GLEntry.Amount - (CustLedgerEntry.Amount + CustLedgerEntry."BC6_DEEE TTC Amount"));
                    GenJnlLine.Description := COPYSTR(STRSUBSTNO(Txtlbl, CustLedgerEntry."Document Type", CustLedgerEntry."Document No."), 1, MAXSTRLEN(GenJnlLine.Description));
                    GenJnlLine."Dimension Set ID" := CustLedgerEntry."Dimension Set ID";
                    GenJnlLine.INSERT(true);
                end;
            until CustLedgerEntry.NEXT() = 0;
        MESSAGE('OK');
    end;

    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        GLEntry: Record "G/L Entry";
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
}

