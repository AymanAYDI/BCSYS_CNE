codeunit 50097 "Batch.Update Location"
{

    trigger OnRun()
    begin
        OLDLocation.GET('CNE');
        Location.GET('ACTI');
        Location.TESTFIELD("Bin Mandatory");
        Location.TESTFIELD("Shipment Bin Code");
        Location.TESTFIELD("Receipt Bin Code");

        Customer.RESET;
        TotalCounter := Customer.COUNTAPPROX;

        /*SalesHeader.RESET;
        SalesHeader.SETRANGE("Document Type",SalesHeader."Document Type"::Order);
        // SalesHeader.SETFILTER("No.",'%1..','CC58399');
        TotalCounter2 := SalesHeader.COUNTAPPROX; */

        Vendor.RESET;
        TotalCounter3 := Vendor.COUNTAPPROX;

        /*PurchHeader.RESET;
        PurchHeader.SETRANGE("Document Type",PurchHeader."Document Type"::Order);
        // PurchHeader.SETFILTER("No.",'%1..','CA23000');
        TotalCounter4 := PurchHeader.COUNTAPPROX;  */

        Window.OPEN(Text001 + '\' +
                    Text002 + '\' +
                    Text003 + '\' +
                    Text004 + '\' +
                    Text005);

        Window.UPDATE(2, TotalCounter);
        Window.UPDATE(4, TotalCounter2);
        Window.UPDATE(6, TotalCounter3);
        Window.UPDATE(8, TotalCounter4);

        // 1. Clients
        Counter := 0;
        IF Customer.FIND('-') THEN
            REPEAT
                Counter += 1;
                Window.UPDATE(1, Counter);
                Customer.VALIDATE("Location Code", Location.Code);
                Customer.MODIFY;
            UNTIL (Customer.NEXT = 0) OR (Counter > 100000);

        // 2. Commandes vente
        /*SalesDocReleaseOk := FALSE;
        Counter := 0;
        IF SalesHeader.FIND('-') THEN
          REPEAT
            SalesDocReleaseOk := FALSE;
            Counter += 1;
            Window.UPDATE(3,Counter);
        
            SalesHeader.CALCFIELDS("Completely Shipped");
            IF  (SalesHeader."Completely Shipped" = FALSE)  AND
                (SalesHeader."Location Code" = OLDLocation.Code) THEN
              BEGIN
              SalesHeader.SetHideValidationDialog(TRUE);
        
              IF SalesHeader.Status = SalesHeader.Status::Released THEN
                BEGIN
                  SalesDocReleaseOk := TRUE;
                  CLEAR(ReleaseSalesDoc);
                  ReleaseSalesDoc.Reopen(SalesHeader);
              END;
              SalesHeader.VALIDATE("Location Code",Location.Code);
              SalesHeader.VALIDATE("Bin Code",Location."Shipment Bin Code");
              SalesHeader.MODIFY;
        
              SalesLine.RESET;
              SalesLine.SETRANGE("Document Type",SalesHeader."Document Type");
              SalesLine.SETRANGE("Document No.",SalesHeader."No.");
              SalesLine.SetHideValidationDialog(TRUE);
              IF SalesLine.FIND('-') THEN
                REPEAT
                  SalesLine.CALCFIELDS("Reserved Quantity");
                  IF (SalesLine."Location Code" = OLDLocation.Code) AND
                     (SalesLine."Reserved Quantity" = 0) AND
                     (SalesLine."Outstanding Quantity" > 0) AND
                     (SalesLine."Qty. Shipped Not Invoiced" = 0) THEN
                    BEGIN
                      SalesLine.VALIDATE("Location Code",Location.Code);
                      SalesLine.VALIDATE("Bin Code",SalesHeader."Bin Code");
                      SalesLine.MODIFY;
                  END;
              UNTIL SalesLine.NEXT = 0;
        
              IF SalesDocReleaseOk THEN
                BEGIN
                  // CLEAR(ReleaseSalesDoc);
                  // ReleaseSalesDoc.RUN(SalesHeader);
              END;
        
            END;
        UNTIL (SalesHeader.NEXT = 0) OR (Counter > 100000);*/

        // 3. Fournisseurs
        Counter := 0;
        IF Vendor.FIND('-') THEN
            REPEAT
                Counter += 1;
                Window.UPDATE(5, Counter);
                Vendor.VALIDATE("Location Code", Location.Code);
                Vendor.MODIFY;
            UNTIL (Vendor.NEXT = 0) OR (Counter > 100000);

        // 4. Commandes achat
        /*PurchDocReleaseOk := FALSE;
        Counter := 0;
        IF PurchHeader.FIND('-') THEN
          REPEAT
            PurchDocReleaseOk := FALSE;
            Counter += 1;
            Window.UPDATE(7,Counter);
        
            PurchHeader.SetHideValidationDialog(TRUE);
            PurchHeader.CALCFIELDS("Completely Received");
            IF  (PurchHeader."Completely Received" = FALSE)  AND
                (PurchHeader."Location Code" = OLDLocation.Code) THEN
              BEGIN
              IF PurchHeader.Status = PurchHeader.Status::Released THEN
                BEGIN
                  PurchDocReleaseOk := TRUE;
                  CLEAR(ReleasePurchDoc);
                  ReleasePurchDoc.SetHideValidationDialog(TRUE);
                  ReleasePurchDoc.Reopen(PurchHeader);
              END;
              PurchHeader.VALIDATE("Location Code",Location.Code);
              // PurchHeader.VALIDATE("Bin Code",Location."Shipment Bin Code");
              PurchHeader.MODIFY;
        
              PurchLine.RESET;
              PurchLine.SETRANGE("Document Type",PurchHeader."Document Type");
              PurchLine.SETRANGE("Document No.",PurchHeader."No.");
              // PurchLine.SetHideValidationDialog(TRUE);
              IF PurchLine.FIND('-') THEN
                REPEAT
                  PurchLine.CALCFIELDS("Reserved Quantity");
                  IF (PurchLine."Location Code" = OLDLocation.Code) AND
                     (PurchLine."Reserved Quantity" = 0) AND
                     (PurchLine."Outstanding Quantity" > 0) AND
                     (PurchLine."Qty. Rcd. Not Invoiced" = 0) THEN
                    BEGIN
                      PurchLine.VALIDATE("Location Code",Location.Code);
                      PurchLine.VALIDATE("Bin Code",Location."Receipt Bin Code");
                      PurchLine.MODIFY;
                  END;
              UNTIL PurchLine.NEXT = 0;
        
              IF PurchDocReleaseOk THEN
                BEGIN
                  // CLEAR(ReleasePurchDoc);
                  // ReleasePurchDoc.SetHideValidationDialog(TRUE);
                  // ReleasePurchDoc.RUN(PurchHeader);
              END;
        
            END;
        UNTIL (PurchHeader.NEXT = 0) OR (Counter > 100000); */


        SLEEP(1000);
        Window.CLOSE;

    end;

    var
        Window: Dialog;
        TotalCounter: Integer;
        TotalCounter2: Integer;
        TotalCounter3: Integer;
        TotalCounter4: Integer;
        Counter: Integer;
        Text001: Label 'Update Cross. Ref. Bar Code...';
        Text002: Label 'Clients         #1### / #2###';
        Customer: Record "18";
        Vendor: Record "23";
        Location: Record "14";
        OLDLocation: Record "14";
        SalesHeader: Record "36";
        PurchHeader: Record "38";
        SalesLine: Record "37";
        Text003: Label 'Commandes vente #3### / #4###';
        Text004: Label 'Fournisseurs    #5### / #6###';
        PurchLine: Record "39";
        ReleaseSalesDoc: Codeunit "414";
        ReleasePurchDoc: Codeunit "415";
        SalesDocReleaseOk: Boolean;
        Text005: Label 'Commandes achat #7### / #8###';
        PurchDocReleaseOk: Boolean;
}

