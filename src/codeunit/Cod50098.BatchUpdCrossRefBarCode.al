codeunit 50098 "Batch Upd. Cross Ref. Bar Code"
{

    trigger OnRun()
    begin

        InvSetup.GET();
        InvSetup.TESTFIELD("BC6_Cross.Ref.Type No.BarCode");
        RefTypeNo := InvSetup."BC6_Cross.Ref.Type No.BarCode";

        Counter := 0;
        ItemReference.RESET();
        //TODO: Field 'Discontinue Bar Code' is removed.
        //ItemReference.SETCURRENTKEY("Reference No.", "Reference Type", "Reference Type No.", "Discontinue Bar Code");
        ItemReference.SETCURRENTKEY("Reference No.", "Reference Type", "Reference Type No.");
        ItemReference.SETRANGE("Reference Type", ItemReference."Reference Type"::"Bar Code");
        TotalCounter := ItemReference.COUNT;
        Window.OPEN(Text003 + '`\' + Text002 + ' / ' + FORMAT(TotalCounter));
        IF ItemReference.FINDFIRST() THEN
            REPEAT
                Counter += 1;
                Window.UPDATE(1, Counter);
                IF (ItemReference."Reference Type No." <> 'EAN13') OR
                    (ItemReference."Reference No." = '') OR
                    (STRLEN(ItemReference."Reference No.") <> 13) THEN
                    ItemReference.DELETE(FALSE)
                ELSE
                    IF (ItemReference.Description = '') OR
                       (ItemReference.Description = 'SUP') THEN BEGIN
                        Item.GET(ItemReference."Item No.");
                        ItemReference.Description := Item.Description;
                        ItemReference.MODIFY(FALSE);
                    END;

            UNTIL (ItemReference.NEXT() = 0) OR (Counter > 2000000);
        Window.CLOSE();

    end;

    var
        Item: Record Item;
        InvSetup: Record "Inventory Setup";
        ItemReference: Record "Item Reference";
        RefTypeNo: Code[20];
        Window: Dialog;
        Counter: Integer;
        TotalCounter: Integer;
        Text001: Label 'Update Cross. Ref. Bar Code...', comment = 'FRA="Mise à jour magasin..."';
        Text002: Label '#1#####';
        Text003: Label 'Update Cross. Ref. Bar Code...', comment = 'FRA="Mise à jour magasin..."';
}

