codeunit 50024 "BC6_IC Validation IC Doc lien"
{

    trigger OnRun()
    begin
        RecGCompagnyInfo.FINDFIRST();

        if RecGCompagnyInfo."BC6_Branch Company" = false then
            exit;

        RecGDocIC.RESET();
        RecGDocIC.SETRANGE(Validate, false);

        if RecGDocIC.FIND('-') then
            repeat
                if Rupture = '' then begin
                    CodeGAncPurchOrder := RecGDocIC."Purch Order IC No.";
                    Rupture := RecGDocIC."Shipment No." + RecGDocIC."Purch Order IC No.";
                end;
                if Rupture <> STRSUBSTNO('%1%2', RecGDocIC."Shipment No.", RecGDocIC."Purch Order IC No.") then begin
                    if RecGICPurchOrder.GET(RecGICPurchOrder."Document Type"::Order, CodeGAncPurchOrder) then begin
                        RecGICPurchOrder.Invoice := false;
                        RecGICPurchOrder.Receive := true;
                        if CanBeReceived(RecGICPurchOrderLines, RecGICPurchOrder) then
                            CODEUNIT.RUN(CODEUNIT::"Purch.-Post", RecGICPurchOrder);
                    end;
                    CodeGAncPurchOrder := RecGDocIC."Purch Order IC No.";
                    Rupture := RecGDocIC."Shipment No." + RecGDocIC."Purch Order IC No.";
                end;
                if RecGICPurchOrderLines.GET(RecGICPurchOrderLines."Document Type"::Order, RecGDocIC."Purch Order IC No.", RecGDocIC."Purch Order IC Line") then begin
                    if RecGICPurchOrderLines."Unit Cost" <> RecGDocIC."Purchase cost" then begin
                        RecGICPurchOrderLines.SuspendStatusCheck(true);
                        RecGICPurchOrderLines.VALIDATE("Direct Unit Cost", RecGDocIC."Purchase cost");

                        if RecGICSalesOrderLines.GET(RecGICSalesOrderLines."Document Type"::Order, RecGICPurchOrderLines."BC6_Sales No. Order Lien", RecGICPurchOrderLines."BC6_Sales No. Line Lien") then begin
                            RecGICSalesOrderLines.SuspendStatusCheck(true);
                            RecGICSalesOrderLines.VALIDATE("BC6_Purchase cost", RecGDocIC."Purchase cost");
                            RecGICSalesOrderLines.MODIFY();
                        end;
                    end;
                    if RecGICPurchOrderLines."Outstanding Quantity" <> 0 then
                        if (RecGICPurchOrderLines.Quantity - (RecGICPurchOrderLines."Quantity Received" + RecGDocIC."Qty. to Receive")) >= 0 then
                            if (RecGICPurchOrderLines."Outstanding Quantity" >= RecGICPurchOrderLines.Quantity - (RecGICPurchOrderLines."Quantity Received" + RecGDocIC."Qty. to Receive")) then
                                RecGICPurchOrderLines.VALIDATE("Qty. to Receive", RecGDocIC."Qty. to Receive")
                            else
                                RecGICPurchOrderLines.VALIDATE("Qty. to Receive", RecGICPurchOrderLines."Outstanding Quantity");

                    RecGICPurchOrderLines.MODIFY();

                end;
                RecGDocIC.Validate := true;
                RecGDocIC."Validate Date" := TODAY;
                RecGDocIC.MODIFY();

            until RecGDocIC.NEXT() <= 0;

        if CodeGAncPurchOrder <> '' then
            if RecGICPurchOrder.GET(RecGICPurchOrder."Document Type"::Order, CodeGAncPurchOrder) then begin
                RecGICPurchOrder.Invoice := false;
                RecGICPurchOrder.Receive := true;
                if CanBeReceived(RecGICPurchOrderLines, RecGICPurchOrder) then
                    CODEUNIT.RUN(CODEUNIT::"Purch.-Post", RecGICPurchOrder);
            end;

        if GUIALLOWED then
            MESSAGE(Text001);
    end;

    var
        RecGCompagnyInfo: Record "Company Information";
        RecGDocIC: Record "BC6_IC Table Validate";
        RecGICPurchOrderLines: Record "Purchase Line";
        RecGICSalesOrderLines: Record "Sales Line";
        RecGICPurchOrder: Record "Purchase Header";
        CodeGAncPurchOrder: Code[20];
        Text001: label 'Treatment Completed', comment = 'FRA="Traitement Terminé"';
        Rupture: Code[50];

    local procedure CanBeReceived(var PurchLine2: Record "Purchase Line"; PurchHeader2: Record "Purchase Header") OK: Boolean
    begin

        PurchLine2.SETRANGE("Document Type", PurchHeader2."Document Type");
        PurchLine2.SETRANGE("Document No.", PurchHeader2."No.");
        PurchLine2.SETFILTER("Qty. to Receive", '<>%1', 0);

        OK := not PurchLine2.ISEMPTY;
        PurchLine2.SETRANGE("Qty. to Receive");
    end;
}

