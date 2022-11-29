pageextension 50103 "BC6_Bins" extends Bins //7302
{
    layout
    {
        addafter(Empty)
        {
            field("BC6_To Make Available"; "BC6_To Make Available")
            {
                ApplicationArea = All;
            }
            field("BC6_Sales Order Not Shipped"; "BC6_Sales Order Not Shipped")
            {
                ApplicationArea = All;
            }
            field("BC6_Exclude Inventory Pick"; "BC6_Exclude Inventory Pick")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("&Contents")
        {
            action("Imprimer étiquette")
            {
                Image = BarCode;
                ApplicationArea = All;

                trigger OnAction()
                var
                    //TODO  // PrintLabel: Report 50048;
                    BinToPrint: Record 7354;
                begin
                    CurrPage.SETSELECTIONFILTER(BinToPrint);
                    //TODO    // CLEAR(PrintLabel);
                    // PrintLabel.SETTABLEVIEW(BinToPrint);
                    // PrintLabel.RUN;
                end;
            }
        }
    }
}

