pageextension 50083 "BC6_LocationCard" extends "Location Card" //5703
{
    layout
    {
        modify("Receipt Bin Code")
        {
            Visible = false;
        }
        modify("Shipment Bin Code")
        {
            Visible = false;
        }
        modify("Asm.-to-Order Shpt. Bin Code")
        {
            Visible = false;
        }
        addafter("From-Assembly Bin Code")
        {
            field("BC6_Asm.-to-Order Shpt. Bin Code"; rec."Asm.-to-Order Shpt. Bin Code")
            {
                ApplicationArea = Warehouse;
                Enabled = NewAssemblyShipmentBinCodeEnable;
                ToolTip = 'Specifies the bin where finished assembly items are posted to when they are assembled to a linked sales order.';

            }
        }
        addafter(Shipment)
        {
            field("BC6_Shipment Bin Code"; Rec."Shipment Bin Code")
            {
                ApplicationArea = Warehouse;
                Enabled = NewShipmentBinCodeEnable;
                Importance = Promoted;
                ToolTip = 'Specifies the default shipment bin code.';
            }
        }
        addafter(Receipt)
        {
            field("BC6_Receipt Bin Code"; rec."Receipt Bin Code")
            {
                ApplicationArea = Warehouse;
                Enabled = NewReceiptBinCodeEnable;
                Importance = Promoted;
                ToolTip = 'Specifies the default receipt bin code.';
            }
        }
        addafter("Default Bin Selection")
        {
            field(BC6_Blocked; "BC6_Blocked")
            {
            }
        }
    }

    var
        [InDataSet]
        NewAssemblyShipmentBinCodeEnable: boolean;
        [InDataSet]
        NewReceiptBinCodeEnable: Boolean;
        [InDataSet]
        NewShipmentBinCodeEnable: Boolean;

    trigger OnOpenPage()
    begin
        NewReceiptBinCodeEnable := true;
        NewShipmentBinCodeEnable := true;
        NewAssemblyShipmentBinCodeEnable := true;
    end;
}

