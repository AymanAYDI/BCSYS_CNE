codeunit 50150 "BC6_PDW Trsf Articles Bourg"
{


    trigger OnRun()
    begin
        Dialog_D.OPEN('Article #1######################');

        PXAch_Cible.RESET();
        PXAch_Cible.CHANGECOMPANY('SCENEO_Bourgogne');

        PXAch_Source.RESET();
        PXAch_Source.SETRANGE("Item No.", '3EI322210');
        IF PXAch_Source.FIND('-') THEN
            REPEAT
                I += 1;
                IF I = 10000 THEN BEGIN
                    Dialog_D.UPDATE(1, PXAch_Source."Item No.");
                    I := 0;
                END;
                PXAch_Cible.TRANSFERFIELDS(PXAch_Source);
                PXAch_Cible."Vendor No." := 'CNE';
                IF PXAch_Cible.INSERT(FALSE) THEN;
            UNTIL PXAch_Source.NEXT() <= 0;

        Dialog_D.CLOSE();
    end;

    var
        PXAch_Source: Record "Purchase Price"; //TODO:for removal
        PXAch_Cible: Record "Purchase Price";
        Dialog_D: Dialog;
        I: Integer;
}

