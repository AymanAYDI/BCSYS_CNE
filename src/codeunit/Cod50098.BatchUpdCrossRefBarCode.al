codeunit 50098 "Batch Upd. Cross Ref. Bar Code"
{

    trigger OnRun()
    begin

        InvSetup.GET();
        InvSetup.TESTFIELD("BC6_Cross. Ref. Type No. BarCode");
        CrossRefTypeNo := InvSetup."BC6_Cross. Ref. Type No. BarCode";

        Counter := 0;
        ItemCrossReference.RESET();
        ItemCrossReference.SETCURRENTKEY("Cross-Reference No.", "Cross-Reference Type", "Cross-Reference Type No.", "Discontinue Bar Code");
        ItemCrossReference.SETRANGE("Cross-Reference Type", ItemCrossReference."Cross-Reference Type"::"Bar Code");
        TotalCounter := ItemCrossReference.COUNT;
        Window.OPEN(Text003 + '`\' + Text002 + ' / ' + FORMAT(TotalCounter));
        IF ItemCrossReference.FINDFIRST() THEN
            REPEAT
                Counter += 1;
                Window.UPDATE(1, Counter);
                IF (ItemCrossReference."Cross-Reference Type No." <> 'EAN13') OR
                    (ItemCrossReference."Cross-Reference No." = '') OR
                    (STRLEN(ItemCrossReference."Cross-Reference No.") <> 13) THEN
                    ItemCrossReference.DELETE(FALSE)
                ELSE
                    IF (ItemCrossReference.Description = '') OR
                       (ItemCrossReference.Description = 'SUP') THEN BEGIN
                        Item.GET(ItemCrossReference."Item No.");
                        ItemCrossReference.Description := Item.Description;
                        ItemCrossReference.MODIFY(FALSE);
                    END;

            UNTIL (ItemCrossReference.NEXT() = 0) OR (Counter > 2000000);
        Window.CLOSE();

    end;

    var
        Item: Record Item;
        InvSetup: Record "Inventory Setup";
        ItemCrossReference: Record "Item Cross Reference";  //TODO: crossRef
        ToItemCrossReference: Record "Item Cross Reference";
        CrossRefTypeNo: Code[20];
        Window: Dialog;
        Counter: Integer;
        TotalCounter: Integer;
        Text001: Label 'Update Cross. Ref. Bar Code...';
        Text002: Label '#1#####';
        Text003: Label 'Update Cross. Ref. Bar Code...';
}

