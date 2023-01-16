pageextension 50001 "BC6_ShipmentMethods" extends "Shipment Methods" //11
{
    layout
    {
        addafter(Description)
        {
            field("BC6_To Make Available"; Rec."BC6_To Make Available")
            {
                ApplicationArea = All;
            }
        }
    }
}
