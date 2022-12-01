pageextension 50033 "BC6_InventoryPick" extends "Inventory Pick"//7377
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

                    //>>MIGRATION NAV 2013
                    CtrlEditable();
                    //<<MIGRATION NAV 2013

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
                    //>>MIGRATION NAV 2013
                    CtrlEditable();
                    //<<MIGRATION NAV 2013
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
                Caption = 'ToCheck';
                Image = Confirm;
                trigger OnAction()
                begin
                    //>>MIGRATION NAV 2013
                    //TODO   WhseActPrint.PrintInvtPickHeaderCheck(Rec, FALSE);
                    //<<MIGRATION NAV 2013
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
                Caption = 'Get Source Document';
                Promoted = True;
                Image = GetSourceDoc;
                PromotedCategory = Process;
                Trigger OnAction()
                BEGIN
                    //>>MIGRATION NAV 2013
                    IF CurrFormEditableOk THEN
                        //<<MIGRATION NAV 2013
                        CODEUNIT.RUN(CODEUNIT::"Create Inventory Pick/Movement", Rec);
                END;
            }
            action(BC6_AutofillQtyToHandle)
            {
                Caption = 'Autofill Qty. to Handle';
                Image = AutofillQtyToHandle;
                trigger OnAction()
                BEGIN
                    //>>MIGRATION NAV 2013
                    IF CurrFormEditableOk THEN
                        //<<MIGRATION NAV 2013
CurrPage.WhseActivityLines.PAGE.AutofillQtyToHandle();
                END;

            }
            action("BC6_Delete Qty. to Handle")
            {
                Caption = 'Delete Qty. to Handle';
                Image = DeleteQtyToHandle;
                trigger OnAction()
                BEGIN
                    //>>MIGRATION NAV 2013
                    IF CurrFormEditableOk THEN
                        //<<MIGRATION NAV 2013
                       CurrPage.WhseActivityLines.PAGE.DeleteQtyToHandle();
                END;

            }

        }

    }
    var
        WhseActPrint: Codeunit "Warehouse Document-Print";
        WMSMgt: Codeunit "WMS Management";
        CtrlEditableOk: Boolean;
        CurrFormEditableOk: Boolean;
        BooGDestinationNoCtrl: Boolean;
        BooGSourceNoCtrl: Boolean;
        BooGWhseActivityLines: Boolean;

    PROCEDURE CtrlEditable()
    BEGIN
        CtrlEditableOk := ("Source No." = '') AND ("BC6_Sales Counter");
        BooGDestinationNoCtrl := CtrlEditableOk;
        BooGSourceNoCtrl := NOT "BC6_Sales Counter";
    END;

    trigger OnAfterGetRecord()
    begin
        //>>MIGRATION NAV 2013
        CtrlEditable();
        //<<MIGRATION NAV 2013
    END;

    trigger OnOpenPage()
    var
    //TODO PermissionForm: Codeunit 50091;
    begin
        //>>AAYDI
        //>>MIGRATION NAV 2013
        CurrFormEditableOk := TRUE;
        //MIGRATION 2013 ALMI
        //IF NOT PermissionForm.HasEditablePermission(USERID,2,7377) THEN
        //TODO       IF NOT PermissionForm.HasEditablePermission(USERID, 8, 7377) THEN
        //MIGRATION 2013 ALMI
        CurrPage.EDITABLE(FALSE);
        //MIGRATION 2013 ALMI
        //IF NOT PermissionForm.HasEditablePermission(USERID,2,7378) THEN
        //TODO      IF NOT PermissionForm.HasEditablePermission(USERID, 8, 7378) THEN
        //MIGRATION 2013 ALMI
        CurrFormEditableOk := FALSE;
        BooGWhseActivityLines := CurrFormEditableOk;
        //<<MIGRATION NAV 2013
        //<<AAYDI

    end;
}
