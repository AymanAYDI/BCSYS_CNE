codeunit 50015 UpdateSalesShipment
{
    Permissions = TableData 110 = rm;

    trigger OnRun()
    var
        SalesHeader: Record "36";
        Counter: Integer;
        UpdateCounter: Boolean;
        Nb: Integer;
    begin
        SalesHeader.SETAUTOCALCFIELDS(Shipped);
        SalesHeader.LOCKTABLE;
        //SalesHeader.SETFILTER("Your Reference",'<>%1','');
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SETRANGE(Shipped, TRUE);

        Nb := SalesHeader.COUNT;
        // ERROR(FORMAT(Nb));
        IF SalesHeader.FINDSET THEN
            REPEAT
                UpdateCounter := FALSE;
                IF SalesHeader.Shipped THEN BEGIN
                    IF SalesHeader."Your Reference" <> '' THEN BEGIN
                        UpdateYourRefOnSalesShpt(SalesHeader);
                        UpdateCounter := TRUE;
                    END;
                    IF SalesHeader."Affair No." <> '' THEN BEGIN
                        UpdateAffairNoOnSalesShpt(SalesHeader);
                        IF NOT UpdateCounter THEN
                            UpdateCounter := TRUE;
                    END;
                    IF UpdateCounter THEN
                        Counter += 1;
                END;
                IF Counter MOD 50 = 0 THEN
                    COMMIT;
            UNTIL SalesHeader.NEXT = 0;
        MESSAGE('%1 updated orders', Counter);
    end;

    [Scope('Internal')]
    procedure UpdateYourRefOnSalesShpt(SalesHeader: Record "36")
    var
        SalesShipmentHeader: Record "110";
    begin
        SalesShipmentHeader.SETFILTER("Your Reference", '%1', '');
        SalesShipmentHeader.SETRANGE("Order No.", SalesHeader."No.");
        IF NOT SalesShipmentHeader.ISEMPTY THEN
            SalesShipmentHeader.MODIFYALL("Your Reference", SalesHeader."Your Reference");
    end;

    [Scope('Internal')]
    procedure UpdateAffairNoOnSalesShpt(SalesHeader: Record "36")
    var
        SalesShipmentHeader: Record "110";
    begin
        SalesShipmentHeader.SETFILTER("Affair No.", '%1', '');
        SalesShipmentHeader.SETRANGE("Order No.", SalesHeader."No.");
        IF NOT SalesShipmentHeader.ISEMPTY THEN
            SalesShipmentHeader.MODIFYALL("Affair No.", SalesHeader."Affair No.");
    end;
}

