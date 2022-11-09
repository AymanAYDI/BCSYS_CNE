codeunit 99000 "BC6_temp"
{

    trigger OnRun()
    begin
        recGT111.RESET();
        recGT111.MODIFYALL(recGT111."BC6_Outstanding Quantity", 0, FALSE);
    end;

    var
        recGT111: Record "Sales Shipment Line";
}

