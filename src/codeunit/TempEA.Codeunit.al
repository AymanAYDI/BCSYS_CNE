codeunit 50050 "Temp EA"
{

    trigger OnRun()
    begin
        EXIT;
        location.SETRANGE(Code, 'METZ');
        IF location.FINDFIRST THEN BEGIN
            location."Receipt Bin Code" := 'R.R.01.1';
            location.MODIFY;
        END;
        MESSAGE('terminé');

        location.SETRANGE(Code, 'METZ');
        IF location.FINDFIRST THEN BEGIN
            location."Shipment Bin Code" := 'E.E.01.1';
            location.MODIFY;
        END;
        MESSAGE('terminé');

        EXIT;

        Field.SETRANGE(FieldName, 'Salesperson Code');
        MESSAGE(FORMAT(Field.COUNT));
    end;

    var
        "Field": Record "2000000041";
        location: Record "14";
        TermsandConditionsofSales: Report "50044";
}

