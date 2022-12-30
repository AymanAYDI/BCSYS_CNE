codeunit 50023 "BC6_IC Transfert Validation IC"
{

    Permissions = tabledata "BC6_IC Table Validate" = rimd;

    trigger OnRun()
    begin
        RecGCompagnyInfo.FINDFIRST();

        if RecGCompagnyInfo."BC6_Branch Company" = true then
            exit;

        RecGDocICIn.RESET();
        RecGDocICIn.SETRANGE(Validate, false);

        if RecGDocICIn.FINDSET(true, true) then
            repeat

                RecGDocICOut.RESET();
                RecGDocICOut.CHANGECOMPANY(RecGDocICIn."Navision Company");

                RecGSalesShipment.SETRANGE("Document No.", RecGDocICIn."Shipment No.");
                RecGSalesShipment.SETFILTER("BC6_Purchase No. Order Lien", '<> %1', '');
                RecGSalesShipment.SETFILTER("BC6_Purchase No. Line Lien", '<> %1', 0);

                if RecGSalesShipment.FIND('-') then
                    repeat

                        RecGDocICOut.TRANSFERFIELDS(RecGDocICIn);
                        RecGDocICOut."Purch Order IC Line" := RecGSalesShipment."BC6_Purchase No. Line Lien";

                        RecGDocICOut."Shipment Line No." := RecGSalesShipment."Line No.";
                        RecGDocICOut."Qty. to Receive" := RecGSalesShipment.Quantity;
                        RecGDocICOut."Purchase cost" := RecGSalesShipment."BC6_Purchase Cost";
                        if RecGSalesShipment.Correction then begin

                            if not RecGDocICOut.FIND() then begin
                                RecGDocICOut.TRANSFERFIELDS(RecGDocICIn);
                                RecGDocICOut."Purch Order IC Line" := RecGSalesShipment."BC6_Purchase No. Line Lien";

                                RecGDocICOut."Shipment Line No." := RecGSalesShipment."Line No.";
                                RecGDocICOut."Qty. to Receive" := RecGSalesShipment.Quantity;
                                RecGDocICOut."Purchase cost" := RecGSalesShipment."BC6_Purchase Cost";
                                RecGDocICOut.Canceled := true;
                                RecGDocICIn.Canceled := true;
                                RecGDocICOut.Validate := true;
                                RecGDocICOut."Validate Date" := TODAY;

                                RecGDocICOut.INSERT()
                            end else begin
                                RecGDocICOut.Canceled := true;
                                RecGDocICIn.Canceled := true;
                                RecGDocICOut.Validate := true;
                                RecGDocICOut."Validate Date" := TODAY;
                                RecGDocICOut.MODIFY();
                            end;

                        end else
                            RecGDocICOut.INSERT();


                    until RecGSalesShipment.NEXT() <= 0;

                RecGDocICIn.Validate := true;
                RecGDocICIn."Validate Date" := TODAY;
                RecGDocICIn.MODIFY();

            until RecGDocICIn.NEXT() <= 0;

        if GUIALLOWED then
            MESSAGE(Text001);
    end;

    var
        RecGDocICIn: Record "BC6_IC Table Validate";
        RecGDocICOut: Record "BC6_IC Table Validate";
        RecGCompagnyInfo: Record "Company Information";
        RecGSalesShipment: Record "Sales Shipment Line";
        Text001: Label 'Treatment Completed', Comment = 'FRA="Traitement Terminé"';
}

