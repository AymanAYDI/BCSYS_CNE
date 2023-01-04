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
                    Caption = 'Available Inventory ACTI', Comment = 'FRA="Stock disponible ACTI"';
                    DecimalPlaces = 0 : 5;
                    ToolTip = 'Specifies the quantity of the item that is currently in inventory and not reserved for other demand.', Comment = 'FRA="Spécifie la quantité de l''article actuellement en stock et non réservée pour une autre demande."';
                    Visible = ShowAvaibility;
                }
                field("Item Availability ACTI"; FunctionMgt.CalcAvailabilityCNE(Rec, GR_ItemCNE))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Availability ACTI', Comment = 'FRA=Disponibilité article ACTI"';
                    DecimalPlaces = 0 : 5;
                    DrillDown = false;
                    ToolTip = 'Specifies how may units of the item on the sales line are available, in inventory or incoming before the shipment date.', Comment = 'FRA="Spécifie combien d''unités de l''article de la ligne vente sont disponibles, en stock ou entrantes avant la date d''expédition."';
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
                    Caption = 'Available Inventory METZ', Comment = 'FRA="Stock disponible METZ"';
                    DecimalPlaces = 0 : 5;
                    ToolTip = 'Specifies the quantity of the item that is currently in inventory and not reserved for other demand.', Comment = 'FRA="Spécifie la quantité de l''article actuellement en stock et non réservée pour une autre demande."';
                    Visible = ShowAvaibility;
                }
                field("Item Availability METZ"; FunctionMgt.CalcAvailabilityMETZ(Rec, GR_ItemMETZ))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Availability METZ', Comment = 'FRA="Disponibilité article METZ"';
                    DecimalPlaces = 0 : 5;
                    DrillDown = false;
                    ToolTip = 'Specifies how may units of the item on the sales line are available, in inventory or incoming before the shipment date.', Comment = 'FRA="Spécifie combien d''unités de l''article de la ligne vente sont disponibles, en stock ou entrantes avant la date d''expédition."';
                    Visible = ShowAvaibility;

                }
            }

        }
        addafter("Reserved Requirements")
        {
            field("BC6_CNE Inventory"; FunctionMgt.CalcCNEInventory(Rec))
            {
                Caption = 'CNE Inventory', Comment = 'FRA="Stocks CNE"';
                Visible = ShowCNEInfo;
                ApplicationArea = All;
            }
            field("BC6_CNE Qty. on Purch. Order"; FunctionMgt.CalcCNEQtyOnPurchOrder(Rec))
            {
                Caption = 'CNE Qty. on Purch. Order', Comment = 'FRA="Qté sur commande achat CNE"';
                Visible = ShowCNEInfo;
                ApplicationArea = All;
            }
        }
        addafter(Item)
        {
            field(AvailabilityToPick; STRSUBSTNO(txtlbl1, FunctionMgt.CalcQtyAvailToPick(Rec)))
            {
                Caption = 'Availa&bility To Pick', Comment = 'FRA="Disp&o. prélèv."';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    SalesInfoPaneMgt.LookupItem(Rec);
                end;
            }
            field(QtyOnPurchOrder; STRSUBSTNO(txtlbl1, FunctionMgt.CalcQtyOnPurchOrder(Rec)))
            {
                Caption = 'Qty. on Purch. Order', Comment = 'FRA="Qté sur commande achat"';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    FunctionMgt.LookupQtyOnPurchOrder(Rec);
                end;
            }
        }
    }

    var
        GR_ItemCNE: Record Item;
        GR_ItemMETZ: Record Item;
        FunctionMgt: Codeunit "BC6_Functions Mgt";
        ShowAvaibility: Boolean;
        ShowCNEInfo: Boolean;
        txtlbl1: label '%1';





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
        IF (Rec.Type = Rec.Type::Item) AND (Rec."No." <> '') THEN
            InitItemAvailibility();
    end;

    local procedure InitItemAvailibility()
    begin
        GR_ItemCNE.GET(Rec."No.");
        GR_ItemCNE.SETRANGE("Location Filter", 'ACTI');
        GR_ItemMETZ.GET(Rec."No.");
        GR_ItemMETZ.SETRANGE("Location Filter", 'METZ');
    end;
}

