page 50106 "BC6_Add Log Purch. Comment"
{
    Caption = 'Add Log Purch. Comment';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = StandardDialog;
    ShowFilter = false;
    SourceTable = "Purchase Header";

    layout
    {
        area(content)
        {
            group("Général")
            {
                field(Qty; Qty)
                {
                    Caption = 'Qty';
                }
                field(ReceiptType2; ReceiptType)
                {
                    Caption = 'Type';
                    OptionCaption = 'Package,Pallet';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction = ACTION::LookupOK THEN
            AddLogComment(Qty, ReceiptType);
    end;

    var
        Qty: Integer;
        ReceiptType: Option Colis,Palette;
}

