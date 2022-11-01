page 50070 "Inventory Pick Mini"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // ------------------------------------------------------------------------

    Caption = 'Inventory Pick';
    PageType = Document;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = Table5766;
    SourceTableView = WHERE (Type = CONST (Invt. Pick));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Location Code"; "Location Code")
                {
                }
                field("Source Document"; "Source Document")
                {
                    DrillDown = false;
                    Lookup = false;
                }
                field(SourceNoCtrl; "Source No.")
                {
                    Editable = BooGSourceNoCtrl;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CreateInvtPick: Codeunit "7322";
                    begin
                        CreateInvtPick.RUN(Rec);

                        //>>MIGRATION NAV 2013
                        CtrlEditable();
                        //<<MIGRATION NAV 2013

                        CurrPage.UPDATE;
                        CurrPage.WhseActivityLines.PAGE.UpdateForm;
                    end;

                    trigger OnValidate()
                    begin
                        SourceNoOnAfterValidate;
                    end;
                }
                field(DestinationNoCtrl; "Destination No.")
                {
                    CaptionClass = FORMAT(WMSMgt.GetCaption("Destination Type", "Source Document", 0));
                    Editable = BooGDestinationNoCtrl;
                }
                field(WMSMgt.GetDestinationName("Destination Type","Destination No.");
                    WMSMgt.GetDestinationName("Destination Type","Destination No."))
                {
                    CaptionClass = FORMAT(WMSMgt.GetCaption("Destination Type","Source Document",1));
                    Caption = 'Name';
                    Editable = false;
                }
                field("Sales Counter"; "Sales Counter")
                {

                    trigger OnValidate()
                    begin
                        //>>MIGRATION NAV 2013
                        CtrlEditable();
                        //<<MIGRATION NAV 2013
                    end;
                }
                field("No. Printed"; "No. Printed")
                {
                }
                field("Bin Code"; "Bin Code")
                {
                }
                field("Your Reference"; "Your Reference")
                {
                }
                field("Destination Name"; "Destination Name")
                {
                    Editable = false;
                }
                field(Comments; Comments)
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Shipment Date"; "Shipment Date")
                {
                    Editable = false;
                }
                field("External Document No."; "External Document No.")
                {
                    CaptionClass = FORMAT(WMSMgt.GetCaption("Destination Type", "Source Document", 2));
                }
                field("External Document No.2"; "External Document No.2")
                {
                    CaptionClass = FORMAT(WMSMgt.GetCaption("Destination Type", "Source Document", 3));
                }
            }
            part(WhseActivityLines; 7378)
            {
                SubPageLink = Activity Type=FIELD(Type),
                              No.=FIELD(No.);
                SubPageView = SORTING(Activity Type,No.,Sorting Sequence No.)
                              WHERE(Breakbulk=CONST(No));
            }
        }
        area(factboxes)
        {
            part(;9126)
            {
                Provider = WhseActivityLines;
                SubPageLink = Item No.=FIELD(Item No.),
                              Variant Code=FIELD(Variant Code),
                              Location Code=FIELD(Location Code);
                Visible = false;
            }
            systempart(;Links)
            {
                Visible = false;
            }
            systempart(;Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("P&ick")
            {
                Caption = 'P&ick';
                Image = CreateInventoryPickup;
                action(List)
                {
                    Caption = 'List';
                    Image = OpportunitiesList;
                    ShortCutKey = 'Shift+Ctrl+L';

                    trigger OnAction()
                    begin
                        LookupActivityHeader("Location Code",Rec);
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 5776;
                                    RunPageLink = Table Name=CONST(Whse. Activity Header),
                                  Type=FIELD(Type),
                                  No.=FIELD(No.);
                }
                action("Posted Picks")
                {
                    Caption = 'Posted Picks';
                    Image = PostedInventoryPick;
                    RunObject = Page 7395;
                                    RunPageLink = Invt Pick No.=FIELD(No.);
                    RunPageView = SORTING(Invt Pick No.);
                }
                action("Posted Mouvement")
                {
                    Caption = 'Posted Mouvement';
                    Image = PostedTaxInvoice;
                    RunObject = Page 7318;
                                    RunPageLink = Whse. Document No. 2=FIELD(No.);
                    RunPageView = SORTING(Whse. Document Type 2,Whse. Document No. 2)
                                  ORDER(Ascending)
                                  WHERE(Whse. Document Type 2=CONST(Invt. Pick));
                }
                action("Source Document")
                {
                    Caption = 'Source Document';
                    Image = "Order";

                    trigger OnAction()
                    var
                        WMSMgt: Codeunit "7302";
                    begin
                        WMSMgt.ShowSourceDocCard("Source Type","Source Subtype","Source No.");
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("&Get Source Document")
                {
                    Caption = '&Get Source Document';
                    Ellipsis = true;
                    Image = GetSourceDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    var
                        CreateInvtPick: Codeunit "7322";
                    begin
                        //>>MIGRATION NAV 2013
                        IF CurrFormEditableOk THEN
                        //<<MIGRATION NAV 2013
                          CreateInvtPick.RUN(Rec);
                    end;
                }
                action(AutofillQtyToHandle)
                {
                    Caption = 'Autofill Qty. to Handle';
                    Image = AutofillQtyToHandle;

                    trigger OnAction()
                    begin
                        //>>MIGRATION NAV 2013
                        IF CurrFormEditableOk THEN
                        //<<MIGRATION NAV 2013
                          AutofillQtyToHandle;
                    end;
                }
                action("Delete Qty. to Handle")
                {
                    Caption = 'Delete Qty. to Handle';
                    Image = DeleteQtyToHandle;

                    trigger OnAction()
                    begin
                        //>>MIGRATION NAV 2013
                        IF CurrFormEditableOk THEN
                        //<<MIGRATION NAV 2013
                          DeleteQtyToHandle;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        PostPickYesNo;
                    end;
                }
                action(PostAndPrint)
                {
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        PostAndPrint;
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    WhseActPrint.PrintInvtPickHeader(Rec,FALSE);
                end;
            }
            action("&ToCheck")
            {
                Caption = '&ToCheck';
                Image = Confirm;

                trigger OnAction()
                begin
                    //>>MIGRATION NAV 2013
                    WhseActPrint.PrintInvtPickHeaderCheck(Rec,FALSE);
                    //<<MIGRATION NAV 2013
                end;
            }
        }
        area(reporting)
        {
            action("Picking List")
            {
                Caption = 'Picking List';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 5752;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //>>MIGRATION NAV 2013
        CtrlEditable;
        //<<MIGRATION NAV 2013
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.UPDATE;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        EXIT(FindFirstAllowedRec(Which));
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Location Code" := GetUserLocation;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        EXIT(FindNextAllowedRec(Steps));
    end;

    trigger OnOpenPage()
    var
        PermissionForm: Codeunit "50091";
    begin
        ErrorIfUserIsNotWhseEmployee;
        //>>AAYDI
        //>>MIGRATION NAV 2013
        CurrFormEditableOk := TRUE;
        //MIGRATION 2013 ALMI
        //IF NOT PermissionForm.HasEditablePermission(USERID,2,7377) THEN
        IF NOT PermissionForm.HasEditablePermission(USERID,8,7377) THEN
        //MIGRATION 2013 ALMI
          CurrPage.EDITABLE(FALSE);
        //MIGRATION 2013 ALMI
        //IF NOT PermissionForm.HasEditablePermission(USERID,2,7378) THEN
        IF NOT PermissionForm.HasEditablePermission(USERID,8,7378) THEN
        //MIGRATION 2013 ALMI
         CurrFormEditableOk := FALSE;
        BooGWhseActivityLines := CurrFormEditableOk;
        //<<MIGRATION NAV 2013
        //<<AAYDI
    end;

    var
        WhseActPrint: Codeunit "5776";
        WMSMgt: Codeunit "7302";
        "- MIGNAV2013 -": Integer;
        CtrlEditableOk: Boolean;
        CurrFormEditableOk: Boolean;
        [InDataSet]
        BooGDestinationNoCtrl: Boolean;
        [InDataSet]
        BooGSourceNoCtrl: Boolean;
        [InDataSet]
        BooGWhseActivityLines: Boolean;

    local procedure AutofillQtyToHandle()
    begin
        CurrPage.WhseActivityLines.PAGE.AutofillQtyToHandle;
    end;

    local procedure DeleteQtyToHandle()
    begin
        CurrPage.WhseActivityLines.PAGE.DeleteQtyToHandle;
    end;

    local procedure PostPickYesNo()
    begin
        CurrPage.WhseActivityLines.PAGE.PostPickYesNo;
    end;

    local procedure PostAndPrint()
    begin
        CurrPage.WhseActivityLines.PAGE.PostAndPrint;
    end;

    local procedure SourceNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
        CurrPage.WhseActivityLines.PAGE.UpdateForm;
    end;

    [Scope('Internal')]
    procedure "--- MIGNAV2013 ---"()
    begin
    end;

    [Scope('Internal')]
    procedure CtrlEditable()
    begin
        CtrlEditableOk := ("Source No." = '') AND ("Sales Counter");
        BooGDestinationNoCtrl := CtrlEditableOk;
        BooGSourceNoCtrl := NOT "Sales Counter";
    end;
}

