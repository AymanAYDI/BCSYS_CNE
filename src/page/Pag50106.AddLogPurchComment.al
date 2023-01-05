page 50106 "BC6_Add Log Purch. Comment"
{
    Caption = 'Add Log Purch. Comment', comment = 'FRA="Ajouter information connexe"';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = StandardDialog;
    ShowFilter = false;
    SourceTable = "Purchase Header";
    UsageCategory = None;
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
            Rec.AddLogComment(Qty, ReceiptType);
    end;

    var
        ReceiptType: Enum "BC6_ReceiptType";
        Qty: Integer;
}

