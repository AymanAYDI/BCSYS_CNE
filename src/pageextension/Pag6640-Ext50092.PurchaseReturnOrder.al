pageextension 50092 "BC6_PurchaseReturnOrder" extends "Purchase Return Order" //6640
{
    layout
    {
        addafter("Buy-from Contact No.")
        {
            field(BC6_ID; Rec.BC6_ID)
            {
                ApplicationArea = All;
            }
            field("BC6_Buy-from Fax No."; Rec."BC6_Buy-from Fax No.")
            {
                ApplicationArea = All;
            }
        }

        addafter(Status)
        {
            field("BC6_Return Order Type"; Rec."BC6_Return Order Type")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    IF Rec."BC6_Return Order Type" = Rec."BC6_Return Order Type"::SAV THEN
                        BooGReminderDateVisible := TRUE
                    ELSE
                        BooGReminderDateVisible := FALSE
                end;
            }
            field("BC6_Reminder Date"; Rec."BC6_Reminder Date")
            {
                ApplicationArea = All;
                Editable = BooGReminderDateVisible;
            }
        }
    }

    actions
    {
        modify("&Print")
        {
            Visible = false;
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            Visible = false;
        }
        addafter("&Print")
        {
            action("BC6_&Print2")
            {
                ApplicationArea = PurchReturnOrder;
                Caption = '&Print', Comment = 'FRA="&Imprimer"';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category10;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                VAR
                    L_PurchaseHeader: Record "Purchase Header";
                    DocPrint: Codeunit "Document-Print";
                BEGIN
                    IF Rec."BC6_Return Order Type" = Rec."BC6_Return Order Type"::Location THEN
                        DocPrint.PrintPurchHeader(Rec)
                    ELSE BEGIN
                        L_PurchaseHeader.RESET();
                        L_PurchaseHeader.SETRANGE("Document Type", Rec."Document Type");
                        L_PurchaseHeader.SETRANGE("No.", Rec."No.");
                        REPORT.RUNMODAL(Report::"BC6_Purchase Ret. Order - SAV", TRUE, FALSE, L_PurchaseHeader);
                    END;
                END;
            }
        }
        addafter("Create &Warehouse Shipment")
        {
            action("BC6_Create Inventor&y Put-away/Pick")
            {
                AccessByPermission = TableData "Posted Invt. Pick Header" = R;
                ApplicationArea = Warehouse;
                Caption = 'Create Inventor&y Put-away/Pick', Comment = 'FRA="Créer prélèv./rangement stock"';
                Ellipsis = true;
                Image = CreateInventoryPickup;
                trigger OnAction()
                var
                    FunctionsMgt: codeunit "BC6_Functions Mgt";

                begin
                    FunctionsMgt.BC6_CreateInvtPutAwayPick_Purchase(rec);
                end;
            }
        }
    }

    var
        BooGReminderDateVisible: Boolean;
}
