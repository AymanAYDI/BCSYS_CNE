pageextension 50099 "BC6_Bins" extends Bins //7302
{
    layout
    {
        addafter(Empty)
        {
            field("BC6_To Make Available"; Rec."BC6_To Make Available")
            {
                ApplicationArea = All;
            }
            field("BC6_Sales Order Not Shipped"; Rec."BC6_Sales Order Not Shipped")
            {
                ApplicationArea = All;
            }
            field("BC6_Exclude Inventory Pick"; Rec."BC6_Exclude Inventory Pick")
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
                    BinToPrint: Record Bin;
                    PrintLabel: Report "BC6_Bin Barcodes";
                begin
                    CurrPage.SETSELECTIONFILTER(BinToPrint);
                    CLEAR(PrintLabel);
                    PrintLabel.SETTABLEVIEW(BinToPrint);
                    PrintLabel.RUN();
                end;
            }
        }
    }
}
