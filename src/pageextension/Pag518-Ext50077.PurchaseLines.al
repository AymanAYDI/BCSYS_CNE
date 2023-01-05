pageextension 50077 "BC6_PurchaseLines" extends "Purchase Lines" //518
{
    layout
    {
        modify("Reserved Qty. (Base)")
        {
            Visible = false;
        }
        modify("Expected Receipt Date")
        {
            Visible = false;
        }
        modify("Outstanding Quantity")
        {
            Visible = false;
        }
        addafter("Document No.")
        {
            field("BC6_Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
        }

        addafter("Reserved Qty. (Base)")
        {
            field("BC6_Outstanding Quantity"; Rec."Outstanding Quantity")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies how many units on the order line have not yet been received.', Comment = 'FRA="Spécifie le nombre d''unités de la ligne vente qui n''ont pas encore été reçues."';
            }
            field("BC6_Expected Receipt Date"; Rec."Expected Receipt Date")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the date that you expect the items to be available in your warehouse.', Comment = 'FRA="Spécifie la date à laquelle  les articles doivent étre disponibles dans votre entrepot."';
            }
        }
    }
}
