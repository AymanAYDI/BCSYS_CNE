pageextension 50039 "BC6_PurchaseReturnOrder" extends "Purchase Return Order"//6640
{
    layout
    {

        addafter("Buy-from Contact No.")
        {
            field(BC6_ID; Rec.ID) { }
            field("BC6_Buy-from Fax No."; Rec."BC6_Buy-from Fax No.") { }

        }
        addafter(Status)
        {
            field("BC6_Return Order Type"; "BC6_Return Order Type")
            {
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
            }

        }

    }
    actions
    {
        modify("&Print")
        {
            visible = false;
        }
        addafter("Comment")
        {

            action(BC6_Print)
            {
                Ellipsis = true;
                Caption = 'Print';
                Promoted = true;
                Image = Print;
                PromotedCategory = Process;
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
                        REPORT.RUNMODAL(50061, TRUE, FALSE, L_PurchaseHeader);
                    END;
                END;

            }
        }
    }
    Trigger OnAfterGetCurrRecord()
    begin
        //>>BCSYS
        IF "BC6_Return Order Type" = "BC6_Return Order Type"::SAV THEN
            BooGReminderDateVisible := TRUE;
        //<<BCSYS

    end;

    var
        BooGReminderDateVisible: Boolean;


}
