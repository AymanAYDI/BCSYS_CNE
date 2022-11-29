pageextension 50005 "BC6_ShipmentMethods" extends "Shipment Methods" //11
{
    layout
    {
        addafter(Description)
        {
            field("BC6_To Make Available"; "BC6_To Make Available")
            {
                ApplicationArea = All;
            }
        }
    }
}

