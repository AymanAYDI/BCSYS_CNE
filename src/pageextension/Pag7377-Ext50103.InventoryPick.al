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
            field("BC6_Source No."; Rec."Source No.")
            {
                ApplicationArea = All;
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
            field("BC6_Destination No."; Rec."Destination No.")
            {
                ApplicationArea = All;
                CaptionClass = FORMAT(WMSMgt.GetCaption("Destination Type".AsInteger(), "Source Document".AsInteger(), 0));
                Editable = BooGDestinationNoCtrl;
            }
        }
        addafter("WMSMgt.GetDestinationName(""Destination Type"",""Destination No."")")
        {
            field("BC6_Sales Counter"; Rec."BC6_Sales Counter")
            {
                ApplicationArea = All;
                trigger OnValidate()
                BEGIN
                    CtrlEditable();
                END;
            }
            field("BC6_No. Printed"; Rec."No. Printed")
            {
                ApplicationArea = All;
            }
            field("BC6_Bin Code"; Rec."BC6_Bin Code")
            {
                ApplicationArea = All;
            }
            field("BC6_Your Reference"; Rec."BC6_Your Reference")
            {
                ApplicationArea = All;
            }
            field("BC6_Destination Name"; Rec."BC6_Destination Name")
            {
                ApplicationArea = All;
            }
            field(BC6_Comments; Rec.BC6_Comments)
            {
                ApplicationArea = All;
            }
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
                ApplicationArea = All;
                Caption = 'ToCheck', Comment = 'FRA="Contrôler"';
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
                ApplicationArea = All;
                Caption = 'Posted Mouvement', Comment = 'FRA="Mouvements enregistrés"';
                Image = PostedTaxInvoice;
                RunObject = Page "Warehouse Entries";
                RunPageLink = "BC6_Whse. Document No. 2" = FIELD("No.");
                RunPageView = SORTING("BC6_Whse. Document Type 2", "BC6_Whse. Document No. 2")
                                  ORDER(Ascending)
                                  WHERE("BC6_Whse. Document Type 2" = CONST("Invt. Pick"));
            }
        }
        addafter("F&unctions")
        {
            action("BC6_Get Source Document")
            {
                ApplicationArea = All;
                Caption = 'Get Source Document', Comment = 'FRA="Extraire document origine"';
                Ellipsis = True;
                Image = GetSourceDoc;
                Promoted = True;
                PromotedCategory = Process;
                ShortCutKey = 'Ctrl+F7';
                Trigger OnAction()
                BEGIN
                    IF CurrFormEditableOk THEN
                        CODEUNIT.RUN(CODEUNIT::"Create Inventory Pick/Movement", Rec);
                END;
            }
            action(BC6_AutofillQtyToHandle)
            {
                ApplicationArea = All;
                Caption = 'Autofill Qty. to Handle', Comment = 'FRA="Remplir qté à traiter"';
                Image = AutofillQtyToHandle;
                trigger OnAction()
                BEGIN
                    IF CurrFormEditableOk THEN
                        CurrPage.WhseActivityLines.PAGE.AutofillQtyToHandle();
                END;
            }
            action("BC6_Delete Qty. to Handle")
            {
                ApplicationArea = All;
                Caption = 'Delete Qty. to Handle', Comment = 'FRA="Vider quantité à traiter"';
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
        CtrlEditableOk: Boolean;
        CurrFormEditableOk: Boolean;

    PROCEDURE CtrlEditable()
    BEGIN
        CtrlEditableOk := (Rec."Source No." = '') AND (Rec."BC6_Sales Counter");
        BooGDestinationNoCtrl := CtrlEditableOk;
        BooGSourceNoCtrl := NOT Rec."BC6_Sales Counter";
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
        IF NOT PermissionForm.HasEditablePermission(CopyStr(USERID, 1, 65), 8, 7377) THEN
            CurrPage.EDITABLE(FALSE);
        IF NOT PermissionForm.HasEditablePermission(CopyStr(USERID, 1, 65), 8, 7378) THEN
            CurrFormEditableOk := FALSE;
    end;
}
