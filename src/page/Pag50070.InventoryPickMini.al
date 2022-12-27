page 50070 "BC6_Inventory Pick Mini"
{
    Caption = 'Inventory Pick', Comment = 'FRA="Prélèvement stock"';
    PageType = Document;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "Warehouse Activity Header";
    SourceTableView = WHERE(Type = CONST("Invt. Pick"));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'FRA="Général"';
                field("No."; "No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Source Document"; "Source Document")
                {
                    DrillDown = false;
                    Lookup = false;
                    ApplicationArea = All;
                }
                field(SourceNoCtrl; "Source No.")
                {
                    Editable = BooGSourceNoCtrl;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CreateInvtPick: Codeunit "Create Inventory Pick/Movement";
                    begin
                        CreateInvtPick.RUN(Rec);

                        //>>MIGRATION NAV 2013
                        CtrlEditable();
                        //<<MIGRATION NAV 2013

                        CurrPage.UPDATE();
                        CurrPage.WhseActivityLines.PAGE.UpdateForm();
                    end;

                    trigger OnValidate()
                    begin
                        SourceNoOnAfterValidate();
                    end;
                }
                field(DestinationNoCtrl; "Destination No.")
                {
                    CaptionClass = FORMAT(WMSMgt.GetCaption("Destination Type", "Source Document", 0));
                    Editable = BooGDestinationNoCtrl;
                    ApplicationArea = All;
                }
                field(DestinationName; WMSMgt.GetDestinationEntityName("Destination Type", "Destination No."))
                {
                    CaptionClass = FORMAT(WMSMgt.GetCaption(Rec."Destination Type", Rec."Source Document", 1));
                    Caption = 'Name', Comment = 'FRA="Nom"';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sales Counter"; "BC6_Sales Counter")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //>>MIGRATION NAV 2013
                        CtrlEditable();
                        //<<MIGRATION NAV 2013
                    end;
                }
                field("No. Printed"; "No. Printed")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; "BC6_Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Your Reference"; "BC6_Your Reference")
                {
                    ApplicationArea = All;
                }
                field("Destination Name"; "BC6_Destination Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Comments; BC6_Comments)
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("External Document No."; "External Document No.")
                {
                    CaptionClass = FORMAT(WMSMgt.GetCaption(Rec."Destination Type", Rec."Source Document", 2));
                    ApplicationArea = All;
                }
                field("External Document No.2"; "External Document No.2")
                {
                    CaptionClass = FORMAT(WMSMgt.GetCaption("Destination Type", "Source Document", 3));
                    ApplicationArea = All;
                }
            }
            part(WhseActivityLines; "Invt. Pick Subform")
            {
                SubPageLink = "Activity Type" = FIELD(Type),
                              "No." = FIELD("No.");
                SubPageView = SORTING("Activity Type", "No.", "Sorting Sequence No.")
                              WHERE(Breakbulk = CONST(false));
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            part("Lot Numbers by Bin FactBox"; "Lot Numbers by Bin FactBox")
            {
                Provider = WhseActivityLines;
                SubPageLink = "Item No." = FIELD("Item No."),
                              "Variant Code" = FIELD("Variant Code"),
                              "Location Code" = FIELD("Location Code");
                Visible = false;
                ApplicationArea = All;
            }
            systempart("RecordLinks"; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart("Notes"; Notes)
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("P&ick")
            {
                Caption = 'P&ick', Comment = 'FRA="&Prélèvement"';
                Image = CreateInventoryPickup;
                action(List)
                {
                    Caption = 'List', Comment = 'FRA="Lister"';
                    Image = OpportunitiesList;
                    ShortCutKey = 'Shift+Ctrl+L';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        LookupActivityHeader("Location Code", Rec);
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments', Comment = 'FRA="Co&mmentaires"';
                    Image = ViewComments;
                    RunObject = Page "Warehouse Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Whse. Activity Header"),
                                  Type = FIELD(Type),
                                  "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Posted Picks")
                {
                    Caption = 'Posted Picks', Comment = 'FRA="Prélèvements enregistrés"';
                    Image = PostedInventoryPick;
                    RunObject = Page "Posted Invt. Pick List";
                    RunPageLink = "Invt Pick No." = FIELD("No.");
                    RunPageView = SORTING("Invt Pick No.");
                    ApplicationArea = All;
                }
                action("Posted Mouvement")
                {
                    Caption = 'Posted Mouvement', Comment = 'FRA="Mouvements enregistrés"';
                    Image = PostedTaxInvoice;
                    RunObject = Page "Warehouse Entries";
                    RunPageLink = "BC6_Whse. Document No. 2" = FIELD("No.");
                    RunPageView = SORTING("BC6_Whse. Document Type 2", "BC6_Whse. Document No. 2")
                                  ORDER(Ascending)
                                  WHERE("BC6_Whse. Document Type 2" = CONST("Invt. Pick"));
                    ApplicationArea = All;
                }
                action("Source Document")
                {
                    Caption = 'Source Document', Comment = 'FRA="Document origine"';
                    Image = "Order";
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        WMSMgt: Codeunit "WMS Management";
                    begin
                        WMSMgt.ShowSourceDocCard("Source Type", "Source Subtype", "Source No.");
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions', Comment = 'FRA="Fonction&s"';
                Image = "Action";
                action("&Get Source Document")
                {
                    Caption = '&Get Source Document', Comment = 'FRA="E&xtraire document origine"';
                    Ellipsis = true;
                    Image = GetSourceDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        CreateInvtPick: Codeunit "Create Inventory Pick/Movement";
                    begin
                        //>>MIGRATION NAV 2013
                        IF CurrFormEditableOk THEN
                            //<<MIGRATION NAV 2013
                            CreateInvtPick.RUN(Rec);
                    end;
                }
                action(AutofillQtyToHandle)
                {
                    Caption = 'Autofill Qty. to Handle', Comment = 'FRA="Remplir qté à traiter"';
                    Image = AutofillQtyToHandle;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //>>MIGRATION NAV 2013
                        IF CurrFormEditableOk THEN
                            //<<MIGRATION NAV 2013
                            AutofillQtyToHandle();
                    end;
                }
                action("Delete Qty. to Handle")
                {
                    Caption = 'Delete Qty. to Handle', Comment = 'FRA="Vider quantité à traiter"';
                    Image = DeleteQtyToHandle;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //>>MIGRATION NAV 2013
                        IF CurrFormEditableOk THEN
                            //<<MIGRATION NAV 2013
                            DeleteQtyToHandle();
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting', Comment = 'FRA="&Validation"';
                Image = Post;
                action("P&ost")
                {
                    Caption = 'P&ost', Comment = 'FRA="&Valider"';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        PostPickYesNo();
                    end;
                }
                action(PostAndPrint)
                {
                    Caption = 'Post and &Print', Comment = 'FRA="Valider et i&mprimer"';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        PostAndPrint();
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print', Comment = 'FRA="&Imprimer"';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    WhseActPrint.PrintInvtPickHeader(Rec, FALSE);
                end;
            }
            action("&ToCheck")
            {
                Caption = '&ToCheck', Comment = 'FRA="&Contrôler"';
                Image = Confirm;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    WhseActPrint.PrintInvtPickHeader(Rec, FALSE);
                end;
            }
        }
        area(reporting)
        {
            action("Picking List")
            {
                Caption = 'Picking List', Comment = 'FRA="Liste des prélèvements"';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Picking List";
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //>>MIGRATION NAV 2013
        CtrlEditable();
        //<<MIGRATION NAV 2013
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.UPDATE();
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        EXIT(FindFirstAllowedRec(Which));
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Location Code" := GetUserLocation();
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        EXIT(FindNextAllowedRec(Steps));
    end;

    trigger OnOpenPage()
    var
        PermissionForm: Codeunit "BC6_Permission Form";
    begin
        ErrorIfUserIsNotWhseEmployee();
        CurrFormEditableOk := TRUE;
        IF NOT PermissionForm.HasEditablePermission(USERID, 8, 7377) THEN
            CurrPage.EDITABLE(FALSE);
        IF NOT PermissionForm.HasEditablePermission(USERID, 8, 7378) THEN
            CurrFormEditableOk := FALSE;
        BooGWhseActivityLines := CurrFormEditableOk;
    end;

    var
        WhseActPrint: Codeunit "Warehouse Document-Print";
        WMSMgt: Codeunit "WMS Management";
        [InDataSet]
        BooGDestinationNoCtrl: Boolean;
        [InDataSet]
        BooGSourceNoCtrl: Boolean;
        [InDataSet]
        BooGWhseActivityLines: Boolean;
        CtrlEditableOk: Boolean;
        CurrFormEditableOk: Boolean;
        "- MIGNAV2013 -": Integer;

    local procedure AutofillQtyToHandle()
    begin
        CurrPage.WhseActivityLines.PAGE.AutofillQtyToHandle();
    end;

    local procedure DeleteQtyToHandle()
    begin
        CurrPage.WhseActivityLines.PAGE.DeleteQtyToHandle();
    end;

    local procedure PostPickYesNo()
    begin
        CurrPage.WhseActivityLines.PAGE.PostPickYesNo();
    end;

    local procedure PostAndPrint()
    begin
        CurrPage.WhseActivityLines.PAGE.PostAndPrint();
    end;

    local procedure SourceNoOnAfterValidate()
    begin
        CurrPage.UPDATE();
        CurrPage.WhseActivityLines.PAGE.UpdateForm();
    end;

    procedure "--- MIGNAV2013 ---"()
    begin
    end;

    procedure CtrlEditable()
    begin
        CtrlEditableOk := ("Source No." = '') AND ("BC6_Sales Counter");
        BooGDestinationNoCtrl := CtrlEditableOk;
        BooGSourceNoCtrl := NOT "BC6_Sales Counter";
    end;
}

