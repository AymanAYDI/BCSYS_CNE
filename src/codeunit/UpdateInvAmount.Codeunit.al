codeunit 50094 "Update Inv. Amount"
{
    // //MIG 2017 >>


    trigger OnRun()
    begin
        Window.OPEN('Mise à jour valeur inventaire');
        InvDate := DMY2DATE(19, 12, 2011);

        ItemJnlLine.RESET;
        ItemJnlLine.SETRANGE("Journal Template Name", 'INV');
        // ItemJnlLine.SETRANGE("Journal Batch Name",'CTRL');
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
                //MIG 2017 >>
                //ItemJnlLine.UpdateAmount;
                ItemJnlLine.Amount := ROUND(ItemJnlLine.Quantity * ItemJnlLine."Unit Amount");
                //MIG 2017 <<
                ItemJnlLine.MODIFY(TRUE);
                Counter += 1;
            END;
        UNTIL ItemJnlLine.NEXT = 0;


        MESSAGE('%1 ligne(s) traitée(s)', Counter);
    end;

    var
        ItemJnlLine: Record "83";
        Item: Record "27";
        Counter: Integer;
        Window: Dialog;
        InvDate: Date;
}

