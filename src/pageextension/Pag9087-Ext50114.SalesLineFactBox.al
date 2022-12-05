pageextension 50114 "BC6_SalesLineFactBox" extends "Sales Line FactBox"  //9087
{
    layout
    {

        modify("Item Availability")
        {
            Visible = ShowCNEInfo;
        }
        modify("Available Inventory")
        {
            Visible = ShowCNEInfo;
        }
        modify(Substitutions)
        {
            Visible = false;
        }
        modify(SalesPrices)
        {
            Visible = false;
        }
        modify(SalesLineDiscounts)
        {
            Visible = false;
        }
        addafter(Availability)
        {
            group(BC6_ACTI)
            {
                Caption = 'ACTI';
                Visible = ShowAvaibility;
                field("Available Inventory ACTI"; FunctionMgt.CalcAvailableInventoryCNE(Rec, GR_ItemCNE))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Available Inventory ACTI';
                    //TODO // DecimalPlaces = 0 : 5;
                    ToolTip = 'Specifies the quantity of the item that is currently in inventory and not reserved for other demand.';
                    Visible = ShowAvaibility;
                }
                field("Item Availability ACTI"; FunctionMgt.CalcAvailabilityCNE(Rec, GR_ItemCNE))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Availability ACTI';
                    //TODO // DecimalPlaces = 0 : 5;
                    DrillDown = false;
                    ToolTip = 'Specifies how may units of the item on the sales line are available, in inventory or incoming before the shipment date.';
                    Visible = ShowAvaibility;

                }
            }
            group(BC6_METZ)
            {
                Caption = 'METZ';
                Visible = ShowAvaibility;
                field("Available Inventory METZ"; FunctionMgt.CalcAvailableInventoryMETZ(Rec, GR_ItemMETZ))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Available Inventory METZ';
                    //TODO // DecimalPlaces = 0 : 5;
                    ToolTip = 'Specifies the quantity of the item that is currently in inventory and not reserved for other demand.';
                    Visible = ShowAvaibility;
                }
                field("Item Availability METZ"; FunctionMgt.CalcAvailabilityMETZ(Rec, GR_ItemMETZ))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Availability METZ';
                    //TODO // DecimalPlaces = 0 : 5;
                    DrillDown = false;
                    ToolTip = 'Specifies how may units of the item on the sales line are available, in inventory or incoming before the shipment date.';
                    Visible = ShowAvaibility;

                }
            }

        }
        addafter("Reserved Requirements")
        {
            field("BC6_CNE Inventory"; FunctionMgt.CalcCNEInventory(Rec))
            {
                Caption = 'CNE Inventory';
                Visible = ShowCNEInfo;
                ApplicationArea = All;
            }
            field("BC6_CNE Qty. on Purch. Order"; FunctionMgt.CalcCNEQtyOnPurchOrder(Rec))
            {
                Caption = 'CNE Qty. on Purch. Order';
                Visible = ShowCNEInfo;
                ApplicationArea = All;
            }
        }
        addafter(Item)
        {
            field(AvailabilityToPick; STRSUBSTNO('%1', FunctionMgt.CalcQtyAvailToPick(Rec)))
            {
                Caption = 'Availa&bility To Pick';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    SalesInfoPaneMgt.LookupItem(Rec);
                end;
            }
            field(QtyOnPurchOrder; STRSUBSTNO('%1', FunctionMgt.CalcQtyOnPurchOrder(Rec)))
            {
                Caption = 'Qty. on Purch. Order';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    FunctionMgt.LookupQtyOnPurchOrder(Rec);
                end;
            }
        }
    }

    var
        GR_ItemCNE: Record 27;
        GR_ItemMETZ: Record 27;
        ShowAvaibility: Boolean;
        ShowCNEInfo: Boolean;
        FunctionMgt: Codeunit "BC6_Functions Mgt";




    trigger OnOpenPage()
    begin
        IF COMPANYNAME = 'CNE 2007' THEN BEGIN
            ShowCNEInfo := FALSE;
            ShowAvaibility := TRUE;
        END
        ELSE BEGIN
            ShowCNEInfo := TRUE;
            ShowAvaibility := FALSE;
        END;
    end;

    trigger OnAfterGetRecord()
    begin
        IF (Type = Type::Item) AND ("No." <> '') THEN
            InitItemAvailibility();
    end;

    local procedure InitItemAvailibility()
    begin
        GR_ItemCNE.GET("No.");
        GR_ItemCNE.SETRANGE("Location Filter", 'ACTI');
        GR_ItemMETZ.GET("No.");
        GR_ItemMETZ.SETRANGE("Location Filter", 'METZ');
    end;
}

