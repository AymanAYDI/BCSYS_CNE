pageextension 50103 pageextension50103 extends Bins
{
    layout
    {
        addafter("Control 4")
        {
            field("To Make Available"; "To Make Available")
            {
            }
            field("Sales Order Not Shipped"; "Sales Order Not Shipped")
            {
            }
            field("Exclude Inventory Pick"; "Exclude Inventory Pick")
            {
            }
        }
    }
    actions
    {
        addafter("Action 30")
        {
            action("Imprimer étiquette")
            {
                Image = BarCode;

                trigger OnAction()
                var
                    "-MIGNAV2013-": Integer;
                    PrintLabel: Report "50048";
                    BinToPrint: Record "7354";
                begin
                    //>>MIGRATION NAV 2013

                    CurrPage.SETSELECTIONFILTER(BinToPrint);
                    CLEAR(PrintLabel);
                    PrintLabel.SETTABLEVIEW(BinToPrint);
                    PrintLabel.RUN;

                    //<<MIGRATION NAV 2013
                end;
            }
        }
    }
}

