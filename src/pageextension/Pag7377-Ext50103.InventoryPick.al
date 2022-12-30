pageextension 50103 "BC6_InventoryPick" extends "Inventory Pick"//7377
{
    layout
    {
        modify("Source No.")
        {
            visible = false;
        }
        modify("Destination No.")
        {
            visible = false;
        }
        modify(Control1905767507) { visible = false; }
        addafter(SourceDocument)
        {
            field("BC6_Source No."; "Source No.")
            {
                Editable = BooGSourceNoCtrl;
                trigger OnValidate()
                begin
                    CurrPage.Update();
                    CurrPage.WhseActivityLines.PAGE.UpdateForm();
                end;

                trigger OnLookup(var Text: Text): Boolean
                begin

                    CtrlEditable();

                    CODEUNIT.RUN(CODEUNIT::"Create Inventory Pick/Movement", Rec);
                    CurrPage.UPDATE();
                    CurrPage.WhseActivityLines.PAGE.UpdateForm();
                end;
            }
            field("BC6_Destination No."; "Destination No.")
            {
                CaptionClass = FORMAT(WMSMgt.GetCaption("Destination Type".AsInteger(), "Source Document".AsInteger(), 0));
                Editable = BooGDestinationNoCtrl;
            }
        }
        addafter("WMSMgt.GetDestinationName(""Destination Type"",""Destination No."")")
        {
            field("BC6_Sales Counter"; "BC6_Sales Counter")
            {
                trigger OnValidate()
                BEGIN
                    CtrlEditable();
                END;
            }
            field("BC6_No. Printed"; "No. Printed") { }
            field("BC6_Bin Code"; "BC6_Bin Code") { }
            field("BC6_Your Reference"; "BC6_Your Reference") { }
            field("BC6_Destination Name"; "BC6_Destination Name") { }
            field(BC6_Comments; BC6_Comments) { }
        }
    }

    actions
    {
        modify("&Get Source Document")
        {
            visible = false;
        }
        modify(AutofillQtyToHandle)
        {
            visible = false;
        }
        modify("Delete Qty. to Handle")
        {
            visible = false;
        }
        addafter("&Print")
        {
            action("BC6_&ToCheck")
            {
                Caption = 'ToCheck', Comment = 'FRA=""';
                Image = Confirm;
                trigger OnAction()
                var
                    FunctionMgt: Codeunit "BC6_Functions Mgt";
                begin
                    FunctionMgt.PrintInvtPickHeaderCheck(Rec, FALSE);
                end;
            }
        }
        addafter("Posted Picks")
        {
            action("BC6_Posted Mouvement")
            {
                RunObject = Page "Warehouse Entries";
                RunPageView = SORTING("BC6_Whse. Document Type 2", "BC6_Whse. Document No. 2")
                                  ORDER(Ascending)
                                  WHERE("BC6_Whse. Document Type 2" = CONST("Invt. Pick"));
                RunPageLink = "BC6_Whse. Document No. 2" = FIELD("No.");
                Image = PostedTaxInvoice;
            }
        }
        addafter("F&unctions")
        {
            action("BC6_Get Source Document")
            {
                ShortCutKey = 'Ctrl+F7';
                Ellipsis = True;
                Caption = 'Get Source Document', Comment = 'FRA=""';
                Promoted = True;
                Image = GetSourceDoc;
                PromotedCategory = Process;
                Trigger OnAction()
                BEGIN
                    IF CurrFormEditableOk THEN
                        CODEUNIT.RUN(CODEUNIT::"Create Inventory Pick/Movement", Rec);
                END;
            }
            action(BC6_AutofillQtyToHandle)
            {
                Caption = 'Autofill Qty. to Handle', Comment = 'FRA=""';
                Image = AutofillQtyToHandle;
                trigger OnAction()
                BEGIN
                    IF CurrFormEditableOk THEN
                        CurrPage.WhseActivityLines.PAGE.AutofillQtyToHandle();
                END;
            }
            action("BC6_Delete Qty. to Handle")
            {
                Caption = 'Delete Qty. to Handle', Comment = 'FRA=""';
                Image = DeleteQtyToHandle;
                trigger OnAction()
                BEGIN
                    IF CurrFormEditableOk THEN
                        CurrPage.WhseActivityLines.PAGE.DeleteQtyToHandle();
                END;
            }
        }
    }
    var
        WMSMgt: Codeunit "WMS Management";
        BooGDestinationNoCtrl: Boolean;
        BooGSourceNoCtrl: Boolean;
        BooGWhseActivityLines: Boolean;
        CtrlEditableOk: Boolean;
        CurrFormEditableOk: Boolean;

    PROCEDURE CtrlEditable()
    BEGIN
        CtrlEditableOk := ("Source No." = '') AND ("BC6_Sales Counter");
        BooGDestinationNoCtrl := CtrlEditableOk;
        BooGSourceNoCtrl := NOT "BC6_Sales Counter";
    END;

    trigger OnAfterGetRecord()
    begin
        CtrlEditable();
    END;

    trigger OnOpenPage()
    var
        PermissionForm: Codeunit "BC6_Permission Form";
    begin
        CurrFormEditableOk := TRUE;
        IF NOT PermissionForm.HasEditablePermission(USERID, 8, 7377) THEN
            CurrPage.EDITABLE(FALSE);
        IF NOT PermissionForm.HasEditablePermission(USERID, 8, 7378) THEN
            CurrFormEditableOk := FALSE;
        BooGWhseActivityLines := CurrFormEditableOk;
    end;
}
