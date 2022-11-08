codeunit 99000 temp
{

    trigger OnRun()
    begin
        recGT111.RESET;
        recGT111.MODIFYALL(recGT111."Outstanding Quantity", 0, FALSE);
    end;

    var
        recGT111: Record "111";
}

