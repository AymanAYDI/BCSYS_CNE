pageextension 50085 pageextension50085 extends "Location Card"
{
    layout
    {
        addafter("Control 82")
        {
            field(Blocked; Blocked)
            {
            }
        }
    }


    //Unsupported feature: Code Modification on "UpdateEnabled(PROCEDURE 1)".

    //procedure UpdateEnabled();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RequirePickEnable := NOT "Use As In-Transit" AND NOT "Directed Put-away and Pick";
    RequirePutAwayEnable := NOT "Use As In-Transit" AND NOT "Directed Put-away and Pick";
    RequireReceiveEnable := NOT "Use As In-Transit" AND NOT "Directed Put-away and Pick";
    RequireShipmentEnable := NOT "Use As In-Transit" AND NOT "Directed Put-away and Pick";
    OutboundWhseHandlingTimeEnable := NOT "Use As In-Transit";
    InboundWhseHandlingTimeEnable := NOT "Use As In-Transit";
    BinMandatoryEnable := NOT "Use As In-Transit" AND NOT "Directed Put-away and Pick";
    DirectedPutawayandPickEnable := NOT "Use As In-Transit" AND "Bin Mandatory";
    BaseCalendarCodeEnable := NOT "Use As In-Transit";

    BinCapacityPolicyEnable := "Directed Put-away and Pick";
    SpecialEquipmentEnable := "Directed Put-away and Pick";
    AllowBreakbulkEnable := "Directed Put-away and Pick";
    PutAwayTemplateCodeEnable := "Directed Put-away and Pick";
    UsePutAwayWorksheetEnable :=
      "Directed Put-away and Pick" OR ("Require Put-away" AND "Require Receive" AND NOT "Use As In-Transit");
    AlwaysCreatePickLineEnable := "Directed Put-away and Pick";
    AlwaysCreatePutawayLineEnable := "Directed Put-away and Pick";

    UseCrossDockingEnable := NOT "Use As In-Transit" AND "Require Receive" AND "Require Shipment" AND "Require Put-away" AND
      "Require Pick";
    CrossDockDueDateCalcEnable := "Use Cross-Docking";

    OpenShopFloorBinCodeEnable := "Bin Mandatory";
    ToProductionBinCodeEnable := "Bin Mandatory";
    FromProductionBinCodeEnable := "Bin Mandatory";
    ReceiptBinCodeEnable := "Bin Mandatory" AND "Require Receive";
    ShipmentBinCodeEnable := "Bin Mandatory" AND "Require Shipment";
    AdjustmentBinCodeEnable := "Directed Put-away and Pick";
    CrossDockBinCodeEnable := "Bin Mandatory" AND "Use Cross-Docking";
    ToAssemblyBinCodeEnable := "Bin Mandatory";
    FromAssemblyBinCodeEnable := "Bin Mandatory";
    AssemblyShipmentBinCodeEnable := "Bin Mandatory" AND NOT ShipmentBinCodeEnable;
    DefaultBinSelectionEnable := "Bin Mandatory" AND NOT "Directed Put-away and Pick";
    UseADCSEnable := NOT "Use As In-Transit" AND "Directed Put-away and Pick";
    PickAccordingToFEFOEnable := "Require Pick" AND "Bin Mandatory";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..26
    //>>MIGRATION NAV2013
    //ReceiptBinCodeEnable := "Bin Mandatory" AND "Require Receive";
    //STD ShipmentBinCodeEnable := "Bin Mandatory" AND "Require Shipment";
    ReceiptBinCodeEnable := ("Bin Mandatory" AND "Require Receive") OR "Directed Put-away and Pick";
    ShipmentBinCodeEnable := ("Bin Mandatory" AND "Require Shipment") OR "Directed Put-away and Pick";
    //<<MIGRATION NAV 2013

    #29..36
    */
    //end;
}

