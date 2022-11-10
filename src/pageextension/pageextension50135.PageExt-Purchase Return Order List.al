pageextension 50135 pageextension50135 extends "Purchase Return Order List"
{
    layout
    {
        addafter("Control 5")
        {
            field("Affair No."; "Affair No.")
            {
            }
            field("Return Order Type"; "Return Order Type")
            {
            }
            field("Sales No. Order Lien"; "Sales No. Order Lien")
            {
                Caption = 'Sales No. Order Link';
            }
            field(Amount; Amount)
            {
            }
        }
    }
}

