pageextension 50120 pageextension50120 extends "Sales Line FactBox"
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
            group(ACTI)
            {
                Caption = 'ACTI';
                Visible = ShowAvaibility;
                field("Available Inventory ACTI"; SalesInfoPaneMgt.CalcAvailableInventoryCNE(Rec, GR_ItemCNE))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Available Inventory ACTI';
                    DecimalPlaces = 0 : 5;
                    ToolTip = 'Specifies the quantity of the item that is currently in inventory and not reserved for other demand.';
                    Visible = ShowAvaibility;
                }
                field("Item Availability ACTI"; SalesInfoPaneMgt.CalcAvailabilityCNE(Rec, GR_ItemCNE))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Availability ACTI';
                    DecimalPlaces = 0 : 5;
                    DrillDown = false;
                    ToolTip = 'Specifies how may units of the item on the sales line are available, in inventory or incoming before the shipment date.';
                    Visible = ShowAvaibility;

                    trigger OnDrillDown()
                    begin
                        //ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec,ItemAvailFormsMgt.ByEvent);
                        //CurrPage.UPDATE(TRUE);
                    end;
                }
            }
            group(METZ)
            {
                Caption = 'METZ';
                Visible = ShowAvaibility;
                field("Available Inventory METZ"; SalesInfoPaneMgt.CalcAvailableInventoryMETZ(Rec, GR_ItemMETZ))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Available Inventory METZ';
                    DecimalPlaces = 0 : 5;
                    ToolTip = 'Specifies the quantity of the item that is currently in inventory and not reserved for other demand.';
                    Visible = ShowAvaibility;
                }
                field("Item Availability METZ"; SalesInfoPaneMgt.CalcAvailabilityMETZ(Rec, GR_ItemMETZ))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Availability METZ';
                    DecimalPlaces = 0 : 5;
                    DrillDown = false;
                    ToolTip = 'Specifies how may units of the item on the sales line are available, in inventory or incoming before the shipment date.';
                    Visible = ShowAvaibility;

                    trigger OnDrillDown()
                    begin
                        //ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec,ItemAvailFormsMgt.ByEvent);
                        //CurrPage.UPDATE(TRUE);
                    end;
                }
            }
            group()
            {
            }
        }
        addafter("Reserved Requirements")
        {
            field("CNE Inventory"; SalesInfoPaneMgt.CalcCNEInventory(Rec))
            {
                Caption = 'CNE Inventory';
                Visible = ShowCNEInfo;
            }
            field("CNE Qty. on Purch. Order"; SalesInfoPaneMgt.CalcCNEQtyOnPurchOrder(Rec))
            {
                Caption = 'CNE Qty. on Purch. Order';
                Visible = ShowCNEInfo;
            }
        }
        addafter(Item)
        {
            field(AvailabilityToPick; STRSUBSTNO('%1', SalesInfoPaneMgt.CalcQtyAvailToPick(Rec)))
            {
                Caption = 'Availa&bility To Pick';

                trigger OnDrillDown()
                begin
                    //>>MIGRATION NAV 2013
                    SalesInfoPaneMgt.LookupItem(Rec);
                    //<<MIGRATION NAV 2013
                end;
            }
            field(QtyOnPurchOrder; STRSUBSTNO('%1', SalesInfoPaneMgt.CalcQtyOnPurchOrder(Rec)))
            {
                Caption = 'Qty. on Purch. Order';

                trigger OnDrillDown()
                begin
                    //>> CNE 5.01
                    SalesInfoPaneMgt.LookupQtyOnPurchOrder(Rec);
                end;
            }
        }
    }

    var
        "-MIGNAV2013-": ;
        TxtGTxt001: Label '......';
        ShowCNEInfo: Boolean;
        GR_ItemCNE: Record "27";
        GR_ItemMETZ: Record "27";
        ShowAvaibility: Boolean;


        //Unsupported feature: Code Modification on "OnAfterGetRecord".

        //trigger OnAfterGetRecord()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CALCFIELDS("Reserved Quantity");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CALCFIELDS("Reserved Quantity");
        //BCSYS 220321
        IF (Type = Type::Item) AND ("No." <> '') THEN
          InitItemAvailibility;
        */
        //end;


        //Unsupported feature: Code Insertion on "OnOpenPage".

        //trigger OnOpenPage()
        //begin
        /*
        //BCSYS - MM
        IF COMPANYNAME = 'CNE 2007' THEN BEGIN
          ShowCNEInfo := FALSE;
          ShowAvaibility := TRUE;
        END
        ELSE BEGIN
          ShowCNEInfo := TRUE;
          ShowAvaibility := FALSE;
        END;
        //FIN BCSYS - MM
        */
        //end;

    local procedure InitItemAvailibility()
    begin
        //Calcul du stock Dispo CNE
        GR_ItemCNE.GET("No.");
        GR_ItemCNE.SETRANGE("Location Filter", 'ACTI');

        //Calcul du stock Dispo METZ
        GR_ItemMETZ.GET("No.");
        GR_ItemMETZ.SETRANGE("Location Filter", 'METZ');
    end;
}

