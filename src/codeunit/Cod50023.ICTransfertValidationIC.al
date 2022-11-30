codeunit 50023 "BC6_IC Transfert Validation IC"
{

    Permissions = TableData "BC6_IC Table Validate" = rimd;

    trigger OnRun()
    begin
        RecGCompagnyInfo.FINDFIRST();

        IF RecGCompagnyInfo."BC6_Branch Company" = TRUE THEN
            EXIT;

        RecGDocICIn.RESET();
        RecGDocICIn.SETRANGE(Validate, FALSE);

        IF RecGDocICIn.FINDSET(TRUE, TRUE) THEN
            REPEAT

                RecGDocICOut.RESET();
                RecGDocICOut.CHANGECOMPANY(RecGDocICIn."Navision Company");

                RecGSalesShipment.SETRANGE("Document No.", RecGDocICIn."Shipment No.");
                RecGSalesShipment.SETFILTER("BC6_Purchase No. Order Lien", '<> %1', '');
                RecGSalesShipment.SETFILTER("BC6_Purchase No. Line Lien", '<> %1', 0);

                IF RecGSalesShipment.FIND('-') THEN
                    REPEAT

                        RecGDocICOut.TRANSFERFIELDS(RecGDocICIn);
                        RecGDocICOut."Purch Order IC Line" := RecGSalesShipment."BC6_Purchase No. Line Lien";

                        RecGDocICOut."Shipment Line No." := RecGSalesShipment."Line No.";
                        RecGDocICOut."Qty. to Receive" := RecGSalesShipment.Quantity;
                        RecGDocICOut."Purchase cost" := RecGSalesShipment."BC6_Purchase Cost";
                        IF RecGSalesShipment.Correction THEN BEGIN

                            IF NOT RecGDocICOut.FIND() THEN BEGIN
                                RecGDocICOut.TRANSFERFIELDS(RecGDocICIn);
                                RecGDocICOut."Purch Order IC Line" := RecGSalesShipment."BC6_Purchase No. Line Lien";

                                RecGDocICOut."Shipment Line No." := RecGSalesShipment."Line No.";
                                RecGDocICOut."Qty. to Receive" := RecGSalesShipment.Quantity;
                                RecGDocICOut."Purchase cost" := RecGSalesShipment."BC6_Purchase Cost";
                                RecGDocICOut.Canceled := TRUE;
                                RecGDocICIn.Canceled := TRUE;
                                RecGDocICOut.Validate := TRUE;
                                RecGDocICOut."Validate Date" := TODAY;

                                RecGDocICOut.INSERT()
                            END ELSE BEGIN
                                RecGDocICOut.Canceled := TRUE;
                                RecGDocICIn.Canceled := TRUE;
                                RecGDocICOut.Validate := TRUE;
                                RecGDocICOut."Validate Date" := TODAY;
                                RecGDocICOut.MODIFY();
                            END;

                        END ELSE
                            RecGDocICOut.INSERT();


                    UNTIL RecGSalesShipment.NEXT() <= 0;

                RecGDocICIn.Validate := TRUE;
                RecGDocICIn."Validate Date" := TODAY;
                RecGDocICIn.MODIFY();

            UNTIL RecGDocICIn.NEXT() <= 0;

        IF GUIALLOWED THEN
            MESSAGE(Text001);
    end;

    var
        RecGCompagnyInfo: Record "Company Information";
        RecGDocICIn: Record "BC6_IC Table Validate";
        RecGDocICOut: Record "BC6_IC Table Validate";
        RecGSalesShipment: Record "Sales Shipment Line";
        Text001: Label 'Treatment Completed', Comment = 'FRA="Traitement Terminé"';
}

