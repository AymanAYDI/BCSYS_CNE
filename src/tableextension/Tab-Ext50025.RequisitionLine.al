tableextension 50025 "BC6_RequisitionLine" extends "Requisition Line"
{
    LookupPageID = "Requisition Lines";
    DrillDownPageID = "Requisition Lines";
    fields
    {
        modify("Location Code")
        {
            //TODO: to check 
            trigger OnAfterValidate()
            var
                WMSManagement: Codeunit "WMS Management";
                Location: Record Location;

            begin
                Location.Get();
                IF Location."Require Put-away" AND NOT (Location."Require Receive") THEN
                    "Bin Code" := Location."Receipt Bin Code"
                ELSE
                    WMSManagement.GetDefaultBin("No.", "Variant Code", "Location Code", "Bin Code");

            end;
        }
    }
    keys
    { }


    var
        SourceDropShipment: Boolean;
}

