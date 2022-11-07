codeunit 50098 "Batch Upd. Cross Ref. Bar Code"
{

    trigger OnRun()
    begin
        // Item.RESET;
        // MESSAGE('%1',Item.COUNT);
        // EXIT;

        InvSetup.GET;
        InvSetup.TESTFIELD("Cross. Ref. Type No. BarCode");
        CrossRefTypeNo := InvSetup."Cross. Ref. Type No. BarCode";

        /*ItemCrossReference.RESET;
        ItemCrossReference.SETCURRENTKEY("Item No.","Variant Code","Unit of Measure","Cross-Reference Type",
                                         "Cross-Reference No.","Discontinue Bar Code");
        ItemCrossReference.SETRANGE("Cross-Reference Type",ItemCrossReference."Cross-Reference Type"::"Bar Code");
        ItemCrossReference.SETFILTER(Description,'<>%1','SUP');
        ItemCrossReference.SETRANGE("Discontinue Bar Code",FALSE);
        TotalCounter := ItemCrossReference.COUNTAPPROX;
        
        Window.OPEN(Text001 + '\' + Text002 + ' / ' +
                    FORMAT(TotalCounter));
        
        IF ItemCrossReference.FINDSET(TRUE,TRUE) THEN
          REPEAT
            Counter += 1;
            Window.UPDATE(1,Counter);
        
            ToItemCrossReference.INIT;
            ToItemCrossReference := ItemCrossReference;
            ToItemCrossReference."Cross-Reference Type No." := CrossRefTypeNo;
            ToItemCrossReference."Cross-Reference No." := ItemCrossReference."Cross-Reference Type No.";
            IF ToItemCrossReference.INSERT(FALSE) THEN
              BEGIN
                ItemCrossReference.Description := 'SUP';
                ItemCrossReference.MODIFY(FALSE);
            END;
        UNTIL (ItemCrossReference.NEXT = 0) OR (Counter > 1000000);
        Window.CLOSE; */


        // Delete
        Counter := 0;
        ItemCrossReference.RESET;
        ItemCrossReference.SETCURRENTKEY("Cross-Reference No.", "Cross-Reference Type", "Cross-Reference Type No.", "Discontinue Bar Code");
        ItemCrossReference.SETRANGE("Cross-Reference Type", ItemCrossReference."Cross-Reference Type"::"Bar Code");
        TotalCounter := ItemCrossReference.COUNT;
        Window.OPEN(Text003 + '`\' + Text002 + ' / ' + FORMAT(TotalCounter));
        IF ItemCrossReference.FINDFIRST THEN
            REPEAT
                Counter += 1;
                Window.UPDATE(1, Counter);
                IF (ItemCrossReference."Cross-Reference Type No." <> 'EAN13') OR
                    (ItemCrossReference."Cross-Reference No." = '') OR
                    (STRLEN(ItemCrossReference."Cross-Reference No.") <> 13) THEN BEGIN
                    ItemCrossReference.DELETE(FALSE);
                END ELSE BEGIN
                    IF (ItemCrossReference.Description = '') OR
                       (ItemCrossReference.Description = 'SUP') THEN BEGIN
                        Item.GET(ItemCrossReference."Item No.");
                        ItemCrossReference.Description := Item.Description;
                        ItemCrossReference.MODIFY(FALSE);
                    END;
                END;
            UNTIL (ItemCrossReference.NEXT = 0) OR (Counter > 2000000);
        Window.CLOSE;

    end;

    var
        InvSetup: Record "313";
        CrossRefTypeNo: Code[20];
        ItemCrossReference: Record "5717";
        ToItemCrossReference: Record "5717";
        Window: Dialog;
        TotalCounter: Integer;
        Counter: Integer;
        Text001: Label 'Update Cross. Ref. Bar Code...';
        Text002: Label '#1#####';
        Item: Record "27";
        Text003: Label 'Update Cross. Ref. Bar Code...';
}

