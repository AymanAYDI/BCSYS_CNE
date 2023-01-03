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
                field("Affect purchase order"; "BC6_Affect purchase order")
                {
                    Editable = true;

                    trigger OnValidate()
                    begin
                        IF "BC6_Affect purchase order" AND (Docstatus = RecLSalesHdr.Status::Released) THEN BEGIN
                            "BC6_Affect purchase order" := FALSE;
                            MESSAGE(textg001);
                        END;
                    end;
                }
                field("Document Type"; "Document Type")
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
                field("Document No."; "Document No.")
                {
                    Editable = false;
                }
                field("Line No."; "Line No.")
                {
                    Editable = false;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    Editable = false;
                }
                field(Type; Type)
                {
                    Editable = false;
                }
                field("No."; "No.")
                {
                    Editable = false;
                }
                field(Quantity; Quantity)
                {
                    Editable = false;
                }
                field("Unit Price"; "Unit Price")
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
        IF RecLSalesHdr.GET("Document Type", "Document No.") THEN
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

