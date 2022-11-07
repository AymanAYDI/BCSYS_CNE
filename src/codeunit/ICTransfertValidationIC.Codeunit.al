codeunit 50023 "IC Transfert Validation IC"
{
    // //>>CNEIC : 06/2015 : Transfert informations pour validation doc IC
    //             le 06/08/15 : ajout permissions 'TableData IC Table Validate=rimd'
    //                           exclure les lignes de BL sans n° achat lien.

    Permissions = TableData 50012 = rimd;

    trigger OnRun()
    begin
        // Recherche des informations société.
        RecGCompagnyInfo.FINDFIRST;

        // Uniquement une société non filiale.
        IF RecGCompagnyInfo."Branch Company" = TRUE THEN
            EXIT;

        // Recherche des documents non validés.
        RecGDocICIn.RESET;
        RecGDocICIn.SETRANGE(Validate, FALSE);

        IF RecGDocICIn.FINDSET(TRUE, TRUE) THEN
            REPEAT

                // DAns la table de la sté destinataire
                RecGDocICOut.RESET;
                RecGDocICOut.CHANGECOMPANY(RecGDocICIn."Navision Company");

                // Recherche des lignes de BL.
                RecGSalesShipment.SETRANGE("Document No.", RecGDocICIn."Shipment No.");
                //>>PWD : le 06/08/15
                RecGSalesShipment.SETFILTER("Purchase No. Order Lien", '<> %1', '');
                RecGSalesShipment.SETFILTER("Purchase No. Line Lien", '<> %1', 0);

                //<<PWD : le 06/08/15

                IF RecGSalesShipment.FIND('-') THEN
                    REPEAT

                        RecGDocICOut.TRANSFERFIELDS(RecGDocICIn);
                        RecGDocICOut."Purch Order IC Line" := RecGSalesShipment."Purchase No. Line Lien";

                        RecGDocICOut."Shipment Line No." := RecGSalesShipment."Line No.";
                        RecGDocICOut."Qty. to Receive" := RecGSalesShipment.Quantity;
                        RecGDocICOut."Purchase cost" := RecGSalesShipment."Purchase Cost";
                        IF RecGSalesShipment.Correction THEN BEGIN

                            IF NOT RecGDocICOut.FIND THEN BEGIN
                                RecGDocICOut.TRANSFERFIELDS(RecGDocICIn);
                                RecGDocICOut."Purch Order IC Line" := RecGSalesShipment."Purchase No. Line Lien";

                                RecGDocICOut."Shipment Line No." := RecGSalesShipment."Line No.";
                                RecGDocICOut."Qty. to Receive" := RecGSalesShipment.Quantity;
                                RecGDocICOut."Purchase cost" := RecGSalesShipment."Purchase Cost";
                                RecGDocICOut.Canceled := TRUE;
                                RecGDocICIn.Canceled := TRUE;
                                RecGDocICOut.Validate := TRUE;
                                RecGDocICOut."Validate Date" := TODAY;

                                RecGDocICOut.INSERT
                            END ELSE BEGIN
                                RecGDocICOut.Canceled := TRUE;
                                RecGDocICIn.Canceled := TRUE;
                                RecGDocICOut.Validate := TRUE;
                                RecGDocICOut."Validate Date" := TODAY;
                                RecGDocICOut.MODIFY;
                            END;

                        END ELSE BEGIN
                            RecGDocICOut.INSERT;
                        END;

                    UNTIL RecGSalesShipment.NEXT <= 0;

                // MàJ des tops lignes
                RecGDocICIn.Validate := TRUE;
                RecGDocICIn."Validate Date" := TODAY;
                RecGDocICIn.MODIFY;

            UNTIL RecGDocICIn.NEXT <= 0;

        IF GUIALLOWED THEN
            MESSAGE(Text001);
    end;

    var
        RecGCompagnyInfo: Record "79";
        RecGDocICIn: Record "50012";
        RecGDocICOut: Record "50012";
        RecGSalesShipment: Record "111";
        RecGDocICIn2: Record "50012";
        Text001: Label 'Treatment Completed';
}

