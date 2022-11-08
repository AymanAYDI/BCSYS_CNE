codeunit 50094 "BC6_Update Inv. Amount"
{
    trigger OnRun()
    begin
        Window.OPEN('Mise à jour valeur inventaire');
        InvDate := DMY2DATE(19, 12, 2011);

        ItemJnlLine.RESET();
        ItemJnlLine.SETRANGE("Journal Template Name", 'INV');
        ItemJnlLine.FIND('-');
        REPEAT
            CLEAR(Item);
            IF Item.GET(ItemJnlLine."Item No.") THEN BEGIN
                IF Item."Costing Method" = Item."Costing Method"::Standard THEN BEGIN
                    Item."Unit Cost" := Item."Standard Cost";
                    Item.MODIFY(FALSE);
                END;
                IF ItemJnlLine."Posting Date" <> InvDate THEN
                    ItemJnlLine.VALIDATE("Posting Date", InvDate);
                ItemJnlLine."Unit Cost" := Item."Unit Cost";
                ItemJnlLine."Unit Amount" := ItemJnlLine."Unit Cost";
                ItemJnlLine.Amount := ROUND(ItemJnlLine.Quantity * ItemJnlLine."Unit Amount");
                ItemJnlLine.MODIFY(TRUE);
                Counter += 1;
            END;
        UNTIL ItemJnlLine.NEXT() = 0;


        MESSAGE('%1 ligne(s) traitée(s)', Counter);
    end;

    var
        ItemJnlLine: Record "Item Journal Line";
        Item: Record Item;
        Counter: Integer;
        Window: Dialog;
        InvDate: Date;
}

