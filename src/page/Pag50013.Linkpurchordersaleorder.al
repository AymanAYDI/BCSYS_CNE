page 50013 "Link purch. order - sale order"
{
    Caption = 'Link purch. order - sale order', comment = 'FRA="Lien commande achat - commande vente"';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Sales Line" = rm;
    SourceTable = "Sales Line";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Affect purchase order"; Rec."BC6_Affect purchase order")
                {
                    Editable = true;

                    trigger OnValidate()
                    begin
                        IF Rec."BC6_Affect purchase order" AND (Docstatus = RecLSalesHdr.Status::Released) THEN BEGIN
                            Rec."BC6_Affect purchase order" := FALSE;
                            MESSAGE(textg001);
                        END;
                    end;
                }
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                }
                field("document status"; RecLSalesHdr.Status)
                {
                    BlankZero = false;
                    Caption = 'Document status', comment = 'FRA="Statut Document"';
                    Editable = false;
                    Lookup = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF RecLSalesHdr.GET(Rec."Document Type", Rec."Document No.") THEN
            Docstatus := RecLSalesHdr.Status
        ELSE
            // Docstatus := 0;
            Docstatus := RecLSalesHdr.Status::Open;
    end;

    var
        RecLSalesHdr: Record "Sales Header";
        Docstatus: Enum "Sales Document Status";
        textg001: Label 'Order isn''t modifiable', comment = 'FRA="Commande non modifiable"';
}

