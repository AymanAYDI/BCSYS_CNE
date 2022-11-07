codeunit 50024 "IC Validation IC Doc lien"
{
    // //>>CNEIC : 06/2015 : Validation des documents IC liés
    //             09/2015 : pb de validation si +sieurs envois de Bl pour une commande
    //             09/2015 : Problème si Cde Achat n'existante pas, l'ancien n° de commande ne se réinitiale pas.


    trigger OnRun()
    begin
        // Recherche des informations société.
        RecGCompagnyInfo.FINDFIRST;

        // Uniquement une société non filiale.
        IF RecGCompagnyInfo."Branch Company" = FALSE THEN
            EXIT;

        // Recherche des documents non validés.
        RecGDocIC.RESET;
        RecGDocIC.SETRANGE(Validate, FALSE);

        IF RecGDocIC.FIND('-') THEN
            REPEAT
                //>>09/2015
                //IF CodeGAncPurchOrder = '' THEN CodeGAncPurchOrder := RecGDocIC."Purch Order IC No.";
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
                        //>>CNEIC : 09/2015 : Problème si Cde Achat n'existante pas.
                        //CodeGAncPurchOrder := RecGDocIC."Purch Order IC No.";
                        //Rupture := RecGDocIC."Shipment No." + RecGDocIC."Purch Order IC No.";
                        //<<CNEIC : 09/2015 : Problème si Cde Achat n'existante pas.
                    END;
                    //>>CNEIC : 09/2015 : Problème si Cde Achat n'existante pas.
                    CodeGAncPurchOrder := RecGDocIC."Purch Order IC No.";
                    Rupture := RecGDocIC."Shipment No." + RecGDocIC."Purch Order IC No.";
                    //<<CNEIC : 09/2015 : Problème si Cde Achat n'existante pas.
                END;
                //<<09/2015


                // Recherche de la ligne Achat IC correspondante
                IF RecGICPurchOrderLines.GET(RecGICPurchOrderLines."Document Type"::Order, RecGDocIC."Purch Order IC No.", RecGDocIC."Purch Order IC Line") THEN BEGIN
                    IF RecGICPurchOrderLines."Unit Cost" <> RecGDocIC."Purchase cost" THEN BEGIN
                        RecGICPurchOrderLines.SuspendStatusCheck(TRUE);
                        RecGICPurchOrderLines.VALIDATE("Direct Unit Cost", RecGDocIC."Purchase cost");

                        IF RecGICSalesOrderLines.GET(RecGICSalesOrderLines."Document Type"::Order, RecGICPurchOrderLines."Sales No. Order Lien", RecGICPurchOrderLines."Sales No. Line Lien") THEN BEGIN
                            RecGICSalesOrderLines.SuspendStatusCheck(TRUE);
                            RecGICSalesOrderLines.VALIDATE("Purchase cost", RecGDocIC."Purchase cost");
                            RecGICSalesOrderLines.MODIFY;
                        END;
                    END;
                    IF RecGICPurchOrderLines."Outstanding Quantity" <> 0 THEN BEGIN
                        //BCSYS 020718
                        //          IF RecGICPurchOrderLines."Outstanding Quantity" <= RecGDocIC."Qty. to Receive" THEN
                        //            RecGICPurchOrderLines.VALIDATE("Qty. to Receive",RecGDocIC."Qty. to Receive")
                        //          ELSE
                        //            RecGICPurchOrderLines.VALIDATE("Qty. to Receive", RecGICPurchOrderLines."Outstanding Quantity");
                        IF (RecGICPurchOrderLines.Quantity - (RecGICPurchOrderLines."Quantity Received" + RecGDocIC."Qty. to Receive")) >= 0 THEN BEGIN
                            IF (RecGICPurchOrderLines."Outstanding Quantity" >= RecGICPurchOrderLines.Quantity - (RecGICPurchOrderLines."Quantity Received" + RecGDocIC."Qty. to Receive")) THEN
                                RecGICPurchOrderLines.VALIDATE("Qty. to Receive", RecGDocIC."Qty. to Receive")
                            ELSE
                                RecGICPurchOrderLines.VALIDATE("Qty. to Receive", RecGICPurchOrderLines."Outstanding Quantity");
                        END;
                        //fin BCSYS 020718
                    END;
                    RecGICPurchOrderLines.MODIFY;

                END;

                // Changement de N° exped ==> on valide le document la réception IC.

                // MàJ des tops lignes
                RecGDocIC.Validate := TRUE;
                RecGDocIC."Validate Date" := TODAY;
                RecGDocIC.MODIFY;

            UNTIL RecGDocIC.NEXT <= 0;

        IF CodeGAncPurchOrder <> '' THEN BEGIN
            IF RecGICPurchOrder.GET(RecGICPurchOrder."Document Type"::Order, CodeGAncPurchOrder) THEN BEGIN
                RecGICPurchOrder.Invoice := FALSE;
                RecGICPurchOrder.Receive := TRUE;
                IF CanBeReceived(RecGICPurchOrderLines, RecGICPurchOrder) THEN
                    CODEUNIT.RUN(CODEUNIT::"Purch.-Post", RecGICPurchOrder);
            END;
        END;

        IF GUIALLOWED THEN
            MESSAGE(Text001);
    end;

    var
        RecGCompagnyInfo: Record "79";
        RecGDocIC: Record "50012";
        RecGICPurchOrderLines: Record "39";
        RecGICSalesOrderLines: Record "37";
        RecGICPurchOrder: Record "38";
        CodeGAncPurchOrder: Code[20];
        Text001: Label 'Treatment Completed';
        Rupture: Code[50];

    local procedure CanBeReceived(var PurchLine2: Record "39"; PurchHeader2: Record "38") OK: Boolean
    begin

        PurchLine2.SETRANGE("Document Type", PurchHeader2."Document Type");
        PurchLine2.SETRANGE("Document No.", PurchHeader2."No.");
        PurchLine2.SETFILTER("Qty. to Receive", '<>%1', 0);

        OK := NOT PurchLine2.ISEMPTY;
        PurchLine2.SETRANGE("Qty. to Receive");
    end;
}

