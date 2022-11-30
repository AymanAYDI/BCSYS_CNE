codeunit 50024 "BC6_IC Validation IC Doc lien"
{

    trigger OnRun()
    begin
        RecGCompagnyInfo.FINDFIRST();

        IF RecGCompagnyInfo."BC6_Branch Company" = FALSE THEN
            EXIT;

        RecGDocIC.RESET();
        RecGDocIC.SETRANGE(Validate, FALSE);

        IF RecGDocIC.FIND('-') THEN
            REPEAT
                IF Rupture = '' THEN BEGIN
                    CodeGAncPurchOrder := RecGDocIC."Purch Order IC No.";
                    Rupture := RecGDocIC."Shipment No." + RecGDocIC."Purch Order IC No.";
                END;
                IF Rupture <> STRSUBSTNO('%1%2', RecGDocIC."Shipment No.", RecGDocIC."Purch Order IC No.") THEN BEGIN
                    IF RecGICPurchOrder.GET(RecGICPurchOrder."Document Type"::Order, CodeGAncPurchOrder) THEN BEGIN
                        RecGICPurchOrder.Invoice := FALSE;
                        RecGICPurchOrder.Receive := TRUE;
                        IF CanBeReceived(RecGICPurchOrderLines, RecGICPurchOrder) THEN
                            CODEUNIT.RUN(CODEUNIT::"Purch.-Post", RecGICPurchOrder);
                    END;
                    CodeGAncPurchOrder := RecGDocIC."Purch Order IC No.";
                    Rupture := RecGDocIC."Shipment No." + RecGDocIC."Purch Order IC No.";
                END;
                IF RecGICPurchOrderLines.GET(RecGICPurchOrderLines."Document Type"::Order, RecGDocIC."Purch Order IC No.", RecGDocIC."Purch Order IC Line") THEN BEGIN
                    IF RecGICPurchOrderLines."Unit Cost" <> RecGDocIC."Purchase cost" THEN BEGIN
                        RecGICPurchOrderLines.SuspendStatusCheck(TRUE);
                        RecGICPurchOrderLines.VALIDATE("Direct Unit Cost", RecGDocIC."Purchase cost");

                        IF RecGICSalesOrderLines.GET(RecGICSalesOrderLines."Document Type"::Order, RecGICPurchOrderLines."BC6_Sales No. Order Lien", RecGICPurchOrderLines."BC6_Sales No. Line Lien") THEN BEGIN
                            RecGICSalesOrderLines.SuspendStatusCheck(TRUE);
                            RecGICSalesOrderLines.VALIDATE("BC6_Purchase cost", RecGDocIC."Purchase cost");
                            RecGICSalesOrderLines.MODIFY();
                        END;
                    END;
                    IF RecGICPurchOrderLines."Outstanding Quantity" <> 0 THEN
                        IF (RecGICPurchOrderLines.Quantity - (RecGICPurchOrderLines."Quantity Received" + RecGDocIC."Qty. to Receive")) >= 0 THEN
                            IF (RecGICPurchOrderLines."Outstanding Quantity" >= RecGICPurchOrderLines.Quantity - (RecGICPurchOrderLines."Quantity Received" + RecGDocIC."Qty. to Receive")) THEN
                                RecGICPurchOrderLines.VALIDATE("Qty. to Receive", RecGDocIC."Qty. to Receive")
                            ELSE
                                RecGICPurchOrderLines.VALIDATE("Qty. to Receive", RecGICPurchOrderLines."Outstanding Quantity");

                    RecGICPurchOrderLines.MODIFY();

                END;
                RecGDocIC.Validate := TRUE;
                RecGDocIC."Validate Date" := TODAY;
                RecGDocIC.MODIFY();

            UNTIL RecGDocIC.NEXT() <= 0;

        IF CodeGAncPurchOrder <> '' THEN
            IF RecGICPurchOrder.GET(RecGICPurchOrder."Document Type"::Order, CodeGAncPurchOrder) THEN BEGIN
                RecGICPurchOrder.Invoice := FALSE;
                RecGICPurchOrder.Receive := TRUE;
                IF CanBeReceived(RecGICPurchOrderLines, RecGICPurchOrder) THEN
                    CODEUNIT.RUN(CODEUNIT::"Purch.-Post", RecGICPurchOrder);
            END;

        IF GUIALLOWED THEN
            MESSAGE(Text001);
    end;

    var
        RecGCompagnyInfo: Record "Company Information";
        RecGDocIC: Record "BC6_IC Table Validate";
        RecGICPurchOrderLines: Record "Purchase Line";
        RecGICSalesOrderLines: Record "Sales Line";
        RecGICPurchOrder: Record "Purchase Header";
        CodeGAncPurchOrder: Code[20];
        Text001: Label 'Treatment Completed', Comment = 'FRA="Traitement Terminé"';
        Rupture: Code[50];

    local procedure CanBeReceived(var PurchLine2: Record "Purchase Line"; PurchHeader2: Record "Purchase Header") OK: Boolean
    begin

        PurchLine2.SETRANGE("Document Type", PurchHeader2."Document Type");
        PurchLine2.SETRANGE("Document No.", PurchHeader2."No.");
        PurchLine2.SETFILTER("Qty. to Receive", '<>%1', 0);

        OK := NOT PurchLine2.ISEMPTY;
        PurchLine2.SETRANGE("Qty. to Receive");
    end;
}

