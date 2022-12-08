pageextension 50092 "BC6_PurchaseReturnOrder" extends "Purchase Return Order" //6640
{
    layout
    {
        addafter("Buy-from Contact No.")
        {
            field(BC6_ID; ID)
            {
                ApplicationArea = All;
            }
            field("BC6_Buy-from Fax No."; "BC6_Buy-from Fax No.")
            {
                ApplicationArea = All;
            }
        }

        addafter(Status)
        {
            field("BC6_Return Order Type"; "BC6_Return Order Type")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    IF "BC6_Return Order Type" = "BC6_Return Order Type"::SAV THEN
                        BooGReminderDateVisible := TRUE
                    ELSE
                        BooGReminderDateVisible := FALSE
                end;
            }
            field("BC6_Reminder Date"; "BC6_Reminder Date")
            {
                Editable = BooGReminderDateVisible;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        modify("&Print")
        {
            Visible = false;
        }
        addafter("&Print")
        {
            action("BC6_&Print2")
            {
                ApplicationArea = PurchReturnOrder;
                Caption = '&Print';
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
                    IF "BC6_Return Order Type" = "BC6_Return Order Type"::Location THEN
                        DocPrint.PrintPurchHeader(Rec)
                    ELSE BEGIN
                        L_PurchaseHeader.RESET();
                        L_PurchaseHeader.SETRANGE("Document Type", "Document Type");
                        L_PurchaseHeader.SETRANGE("No.", "No.");
                        REPORT.RUNMODAL(Report::"Purchase Return Order - SAV", TRUE, FALSE, L_PurchaseHeader);
                    END;
                END;
            }
        }
    }

    var
        BooGReminderDateVisible: Boolean;
}
