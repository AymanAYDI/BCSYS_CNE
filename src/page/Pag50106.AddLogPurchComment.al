page 50106 "BC6_Add Log Purch. Comment"
{
    Caption = 'Add Log Purch. Comment', comment = 'FRA="Ajouter information connexe"';
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
                    Caption = 'Qty', comment = 'FRA="Qté"';
                }
                field(ReceiptType2; ReceiptType)
                {
                    Caption = 'Type', comment = 'FRA="Type"';

                    //TODO: optioncaption
                    // OptionCaption = 'Package,Pallet';
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
        ReceiptType: Enum "BC6_ReceiptType";
}
