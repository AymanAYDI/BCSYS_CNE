codeunit 50050 "BC6_Temp EA"
{

    trigger OnRun()
    begin
        EXIT;
        location.SETRANGE(Code, 'METZ');  //TODO: Unreachable code detected.( warning)
        IF location.FINDFIRST() THEN BEGIN
            location."Receipt Bin Code" := 'R.R.01.1';
            location.MODIFY();
        END;
        MESSAGE('terminé');

        location.SETRANGE(Code, 'METZ');
        IF location.FINDFIRST() THEN BEGIN
            location."Shipment Bin Code" := 'E.E.01.1';
            location.MODIFY();
        END;
        MESSAGE('terminé');

        EXIT;

        Field.SETRANGE(FieldName, 'Salesperson Code');
        MESSAGE(FORMAT(Field.COUNT));
    end;

    var
        "Field": Record Field;
        location: Record Location;

}

