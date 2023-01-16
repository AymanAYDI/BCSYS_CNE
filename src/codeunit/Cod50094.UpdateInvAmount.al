codeunit 50094 "BC6_Update Inv. Amount"
{
    trigger OnRun()
    begin
        Window.OPEN('Mise à jour valeur inventaire');
        InvDate := DMY2DATE(19, 12, 2011);

        ItemJnlLine.RESET();
        ItemJnlLine.SETRANGE("Journal Template Name", 'INV');
        ItemJnlLine.FIND('-');
        repeat
            CLEAR(Item);
            if Item.GET(ItemJnlLine."Item No.") then begin
                if Item."Costing Method" = Item."Costing Method"::Standard then begin
                    Item."Unit Cost" := Item."Standard Cost";
                    Item.MODIFY(false);
                end;
                if ItemJnlLine."Posting Date" <> InvDate then
                    ItemJnlLine.VALIDATE("Posting Date", InvDate);
                ItemJnlLine."Unit Cost" := Item."Unit Cost";
                ItemJnlLine."Unit Amount" := ItemJnlLine."Unit Cost";
                ItemJnlLine.Amount := ROUND(ItemJnlLine.Quantity * ItemJnlLine."Unit Amount");
                ItemJnlLine.MODIFY(true);
                Counter += 1;
            end;
        until ItemJnlLine.NEXT() = 0;

        MESSAGE('%1 ligne(s) traitée(s)', Counter);
    end;

    var
        Item: Record Item;
        ItemJnlLine: Record "Item Journal Line";
        InvDate: Date;
        Window: Dialog;
        Counter: Integer;
}
