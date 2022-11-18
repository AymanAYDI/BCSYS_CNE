codeunit 50005 "BC6_G/L Reg.-DEEE Ledger"
{
    TableNo = "G/L Register";

    trigger OnRun()
    begin
        IF "From Entry No." > 0 THEN
            DEEEEntry.SETRANGE("Entry No.", "From Entry No.", "To Entry No.")
        ELSE
            DEEEEntry.SETRANGE("Entry No.", "To Entry No.", "From Entry No.");
        //TODO PAGE.RUN(PAGE::"BC6_DEEE Ledger Entries", DEEEEntry);
    end;

    var
        DEEEEntry: Record "BC6_DEEE Ledger Entry";
}

