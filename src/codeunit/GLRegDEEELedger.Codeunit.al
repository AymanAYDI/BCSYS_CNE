codeunit 50005 "G/L Reg.-DEEE Ledger"
{
    TableNo = 45;

    trigger OnRun()
    begin
        //>>DEEE1.00 : Navigate
        IF "From Entry No." > 0 THEN
            DEEEEntry.SETRANGE("Entry No.", "From Entry No.", "To Entry No.")
        ELSE
            DEEEEntry.SETRANGE("Entry No.", "To Entry No.", "From Entry No.");
        PAGE.RUN(PAGE::"DEEE Ledger Entries", DEEEEntry);
        //<<DEEE1.00 : Navigate
    end;

    var
        DEEEEntry: Record "50008";
}

