codeunit 50050 "BC6_Temp EA"
{

    trigger OnRun()
    begin
        exit;
        location.SETRANGE(Code, 'METZ');
        if location.FINDFIRST() then begin
            location."Receipt Bin Code" := 'R.R.01.1';
            location.MODIFY();
        end;
        MESSAGE('terminé');

        location.SETRANGE(Code, 'METZ');
        if location.FINDFIRST() then begin
            location."Shipment Bin Code" := 'E.E.01.1';
            location.MODIFY();
        end;
        MESSAGE('terminé');

        exit;

        Field.SETRANGE(FieldName, 'Salesperson Code');
        MESSAGE(FORMAT(Field.COUNT));
    end;

    var
        "Field": Record Field;
        location: Record Location;

}

