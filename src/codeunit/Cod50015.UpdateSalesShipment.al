codeunit 50015 "BC6_UpdateSalesShipment"
{
    Permissions = TableData "Sales Shipment Header" = rm;

    trigger OnRun()
    var
        SalesHeader: Record "Sales Header";
        UpdateCounter: Boolean;
        Counter: Integer;
    begin
        SalesHeader.SETAUTOCALCFIELDS(Shipped);
        SalesHeader.LOCKTABLE();
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SETRANGE(Shipped, TRUE);
        IF SalesHeader.FINDSET() THEN
            REPEAT
                UpdateCounter := FALSE;
                IF SalesHeader.Shipped THEN BEGIN
                    IF SalesHeader."Your Reference" <> '' THEN BEGIN
                        UpdateYourRefOnSalesShpt(SalesHeader);
                        UpdateCounter := TRUE;
                    END;
                    IF SalesHeader."BC6_Affair No." <> '' THEN BEGIN
                        UpdateAffairNoOnSalesShpt(SalesHeader);
                        IF NOT UpdateCounter THEN
                            UpdateCounter := TRUE;
                    END;
                    IF UpdateCounter THEN
                        Counter += 1;
                END;
                IF Counter MOD 50 = 0 THEN
                    COMMIT();
            UNTIL SalesHeader.NEXT() = 0;
        MESSAGE('%1 updated orders', Counter);
    end;

    procedure UpdateYourRefOnSalesShpt(SalesHeader: Record "Sales Header")
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        SalesShipmentHeader.SETFILTER("Your Reference", '%1', '');
        SalesShipmentHeader.SETRANGE("Order No.", SalesHeader."No.");
        IF NOT SalesShipmentHeader.ISEMPTY THEN
            SalesShipmentHeader.MODIFYALL("Your Reference", SalesHeader."Your Reference");
    end;

    procedure UpdateAffairNoOnSalesShpt(SalesHeader: Record "Sales Header")
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        SalesShipmentHeader.SETFILTER("BC6_Affair No.", '%1', '');
        SalesShipmentHeader.SETRANGE("Order No.", SalesHeader."No.");
        IF NOT SalesShipmentHeader.ISEMPTY THEN
            SalesShipmentHeader.MODIFYALL("BC6_Affair No.", SalesHeader."BC6_Affair No.");
    end;
}
