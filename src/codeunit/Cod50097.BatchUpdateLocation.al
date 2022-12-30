codeunit 50097 "BC6_Batch.Update Location"
{

    trigger OnRun()
    begin
        OLDLocation.GET('CNE');
        Location.GET('ACTI');
        Location.TESTFIELD("Bin Mandatory");
        Location.TESTFIELD("Shipment Bin Code");
        Location.TESTFIELD("Receipt Bin Code");

        Customer.RESET();
        TotalCounter := Customer.COUNTAPPROX;
        Vendor.RESET();
        TotalCounter3 := Vendor.COUNTAPPROX;
        Window.OPEN(Text001 + '\' +
                    Text002 + '\' +
                    Text003 + '\' +
                    Text004 + '\' +
                    Text005);

        Window.UPDATE(2, TotalCounter);
        Window.UPDATE(4, TotalCounter2);
        Window.UPDATE(6, TotalCounter3);
        Window.UPDATE(8, TotalCounter4);
        Counter := 0;
        IF Customer.FIND('-') THEN
            REPEAT
                Counter += 1;
                Window.UPDATE(1, Counter);
                Customer.VALIDATE("Location Code", Location.Code);
                Customer.MODIFY();
            UNTIL (Customer.NEXT() = 0) OR (Counter > 100000);

        Counter := 0;
        IF Vendor.FIND('-') THEN
            REPEAT
                Counter += 1;
                Window.UPDATE(5, Counter);
                Vendor.VALIDATE("Location Code", Location.Code);
                Vendor.MODIFY();
            UNTIL (Vendor.NEXT() = 0) OR (Counter > 100000);

        SLEEP(1000);
        Window.CLOSE();

    end;

    var
        Customer: Record Customer;
        Location: Record Location;
        OLDLocation: Record Location;
        Vendor: Record Vendor;
        Window: Dialog;
        Counter: Integer;
        TotalCounter: Integer;
        TotalCounter2: Integer;
        TotalCounter3: Integer;
        TotalCounter4: Integer;
        Text001: Label 'Update Cross. Ref. Bar Code...', comment = 'FRA="Mise à jour magasin..."';
        Text002: Label 'Clients         #1### / #2###';
        Text003: Label 'Commandes vente #3### / #4###';
        Text004: Label 'Fournisseurs    #5### / #6###';
        Text005: Label 'Commandes achat #7### / #8###';
}

