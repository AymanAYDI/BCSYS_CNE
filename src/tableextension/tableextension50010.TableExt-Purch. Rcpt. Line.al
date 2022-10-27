tableextension 50010 tableextension50010 extends "Purch. Rcpt. Line"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //Demande de prix FE004.2 11/12/2003 ajout champ 50000 à 50002
    // 
    // //Propagation CASC 18/01/207 NSC1.01 : Add fields
    //                                         50022 Public Price
    //                                         50031 Direct Unit Cost
    // //>>CNE1.00
    // FEP-ADVE-200706_18_B.001:MA 12/11/2007 : Suivi historique
    //    - add key "Buy-from Vendor No.","No."
    // ------------------------------------------------------------------------
    LookupPageID = 528;
    DrillDownPageID = 528;
    fields
    {
        modify("No.")
        {
            TableRelation = IF (Type = CONST (G/L Account)) "G/L Account"
                            ELSE IF (Type=CONST(Item)) Item
                            ELSE IF (Type=CONST(Fixed Asset)) "Fixed Asset"
                            ELSE IF (Type=CONST("Charge (Item)")) "Item Charge";
            CaptionClass = GetCaptionClass(FIELDNO("No."));
        }
        modify("Posting Group")
        {
            TableRelation = IF (Type=CONST(Item)) "Inventory Posting Group"
                            ELSE IF (Type=CONST(Fixed Asset)) "FA Posting Group";
        }
        modify(Description)
        {
            Caption = 'Description';
        }
        modify("Description 2")
        {
            Caption = 'Description 2';
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Appl.-to Item Entry"(Field 38)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Qty. Rcd. Not Invoiced"(Field 58)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Order No."(Field 65)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Order Line No."(Field 66)".

        modify("Blanket Order Line No.")
        {
            TableRelation = "Purchase Line"."Line No." WHERE (Document Type=CONST(Blanket Order),
                                                              Document No.=FIELD(Blanket Order No.));
        }
        modify("Job Line Type")
        {
            OptionCaption = ' ,Budget,Billable,Both Budget and Billable';

            //Unsupported feature: Property Modification (OptionString) on ""Job Line Type"(Field 1002)".

        }
        modify("Bin Code")
        {
            TableRelation = Bin.Code WHERE (Location Code=FIELD(Location Code),
                                            Item Filter=FIELD(No.),
                                            Variant Filter=FIELD(Variant Code));
        }
        modify("Unit of Measure Code")
        {
            TableRelation = IF (Type=CONST(Item)) "Item Unit of Measure".Code WHERE (Item No.=FIELD(No.))
                            ELSE "Unit of Measure";
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Cross-Reference No."(Field 5705)".


        //Unsupported feature: Property Modification (Data type) on ""Item Category Code"(Field 5709)".


        //Unsupported feature: Property Insertion (ValidateTableRelation) on ""Product Group Code"(Field 5712)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Requested Receipt Date"(Field 5790)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Lead Time Calculation"(Field 5792)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Inbound Whse. Handling Time"(Field 5793)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Order Date"(Field 5795)".

        modify("Operation No.")
        {
            TableRelation = "Prod. Order Routing Line"."Operation No." WHERE (Status=FILTER(Released..),
                                                                              Prod. Order No.=FIELD(Prod. Order No.),
                                                                              Routing No.=FIELD(Routing No.));
        }
        modify("Prod. Order Line No.")
        {
            TableRelation = "Prod. Order Line"."Line No." WHERE (Status=FILTER(Released..),
                                                                 Prod. Order No.=FIELD(Prod. Order No.));
        }
        field(50000;"Sales No.";Code[20])
        {
            Caption = 'Sales Order No.';
            Editable = false;
        }
        field(50001;"Sales Line No.";Integer)
        {
            Caption = 'Sales Order Line No.';
            Editable = false;
        }
        field(50002;"Sales Document Type";Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(50022;"Public Price";Decimal)
        {
            Caption = 'Tarif Public';
            Description = 'TARIFPUB SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
        }
        field(50031;"Discount Direct Unit Cost";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Discount Direct Unit Cost excluding VAT';
            Editable = false;

            trigger OnValidate()
            begin
                VALIDATE("Line Discount %");
            end;
        }
    }
    keys
    {

        //Unsupported feature: Property Deletion (KeyGroups) on ""Blanket Order No.,Blanket Order Line No."(Key)".

        key(Key1;"No.")
        {
        }
        key(Key2;Type,"No.")
        {
        }
        key(Key3;"No.","Buy-from Vendor No.","Document No.","Line No.")
        {
        }
    }

    //Unsupported feature: Variable Insertion (Variable: ItemTrackingDocMgt) (VariableCollection) on "ShowItemTrackingLines(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "ShowItemTrackingLines(PROCEDURE 3)".

    //procedure ShowItemTrackingLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ItemTrackingMgt.CallPostedItemTrackingForm(DATABASE::"Purch. Rcpt. Line",0,"Document No.",'',0,"Line No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ItemTrackingDocMgt.ShowItemTrackingForShptRcptLine(DATABASE::"Purch. Rcpt. Line",0,"Document No.",'',0,"Line No.");
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: LanguageManagement) (VariableCollection) on "InsertInvLineFromRcptLine(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "InsertInvLineFromRcptLine(PROCEDURE 2)".

    //procedure InsertInvLineFromRcptLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SETRANGE("Document No.","Document No.");

        TempPurchLine := PurchLine;
        IF PurchLine.FIND('+') THEN
          NextLineNo := PurchLine."Line No." + 10000
        ELSE
          NextLineNo := 10000;

        IF PurchInvHeader."No." <> TempPurchLine."Document No." THEN
          PurchInvHeader.GET(TempPurchLine."Document Type",TempPurchLine."Document No.");

        IF PurchLine."Receipt No." <> "Document No." THEN BEGIN
          PurchLine.INIT;
          PurchLine."Line No." := NextLineNo;
          PurchLine."Document Type" := TempPurchLine."Document Type";
          PurchLine."Document No." := TempPurchLine."Document No.";
          PurchLine.Description := STRSUBSTNO(Text000,"Document No.");
          PurchLine.INSERT;
          NextLineNo := NextLineNo + 10000;
        END;

        TransferOldExtLines.ClearLineNumbers;

        REPEAT
          ExtTextLine := (TransferOldExtLines.GetNewLineNumber("Attached to Line No.") <> 0);

          IF PurchOrderLine.GET(
               PurchOrderLine."Document Type"::Order,"Order No.","Order Line No.")
          THEN BEGIN
            IF (PurchOrderHeader."Document Type" <> PurchOrderLine."Document Type"::Order) OR
               (PurchOrderHeader."No." <> PurchOrderLine."Document No.")
            THEN
              PurchOrderHeader.GET(PurchOrderLine."Document Type"::Order,"Order No.");

            InitCurrency("Currency Code");

            IF PurchInvHeader."Prices Including VAT" THEN BEGIN
              IF NOT PurchOrderHeader."Prices Including VAT" THEN
                PurchOrderLine."Direct Unit Cost" :=
                  ROUND(
                    PurchOrderLine."Direct Unit Cost" * (1 + PurchOrderLine."VAT %" / 100),
                    Currency."Unit-Amount Rounding Precision");
            END ELSE BEGIN
              IF PurchOrderHeader."Prices Including VAT" THEN
                PurchOrderLine."Direct Unit Cost" :=
                  ROUND(
                    PurchOrderLine."Direct Unit Cost" / (1 + PurchOrderLine."VAT %" / 100),
                    Currency."Unit-Amount Rounding Precision");
            END;
          END ELSE BEGIN
            IF ExtTextLine THEN BEGIN
              PurchOrderLine.INIT;
              PurchOrderLine."Line No." := "Order Line No.";
              PurchOrderLine.Description := Description;
              PurchOrderLine."Description 2" := "Description 2";
            END ELSE
              ERROR(Text001);
          END;
          PurchLine := PurchOrderLine;
          PurchLine."Line No." := NextLineNo;
          PurchLine."Document Type" := TempPurchLine."Document Type";
          PurchLine."Document No." := TempPurchLine."Document No.";
          PurchLine."Variant Code" := "Variant Code";
          PurchLine."Location Code" := "Location Code";
          PurchLine."Quantity (Base)" := 0;
          PurchLine.Quantity := 0;
          PurchLine."Outstanding Qty. (Base)" := 0;
          PurchLine."Outstanding Quantity" := 0;
          PurchLine."Quantity Received" := 0;
          PurchLine."Qty. Received (Base)" := 0;
          PurchLine."Quantity Invoiced" := 0;
          PurchLine."Qty. Invoiced (Base)" := 0;
          PurchLine.Amount := 0;
          PurchLine."Amount Including VAT" := 0;
          PurchLine."Sales Order No." := '';
          PurchLine."Sales Order Line No." := 0;
          PurchLine."Drop Shipment" := FALSE;
          PurchLine."Special Order Sales No." := '';
          PurchLine."Special Order Sales Line No." := 0;
          PurchLine."Special Order" := FALSE;
          PurchLine."Receipt No." := "Document No.";
          PurchLine."Receipt Line No." := "Line No.";
          PurchLine."Appl.-to Item Entry" := 0;
          PurchLine."Prepmt. Amt. Inv." := 0;
          IF NOT ExtTextLine THEN BEGIN
            PurchLine.VALIDATE(Quantity,Quantity - "Quantity Invoiced");
            PurchLine.VALIDATE("Direct Unit Cost",PurchOrderLine."Direct Unit Cost");
            PurchLine.VALIDATE(
              "Line Discount Amount",
              ROUND(
                PurchOrderLine."Line Discount Amount" * PurchLine.Quantity / PurchOrderLine.Quantity,
                Currency."Amount Rounding Precision"));
            PurchLine."Line Discount %" := PurchOrderLine."Line Discount %";
            PurchLine.UpdatePrePaymentAmounts;
            PurchSetup.GET;
            IF NOT PurchSetup."Calc. Inv. Discount" THEN
              IF PurchOrderLine.Quantity = 0 THEN
                PurchLine.VALIDATE("Inv. Discount Amount",0)
              ELSE BEGIN
                PurchLine.VALIDATE(
                  "Inv. Discount Amount",
                  ROUND(
                    PurchOrderLine."Inv. Discount Amount" * PurchLine.Quantity / PurchOrderLine.Quantity,
                    Currency."Amount Rounding Precision"));
                PurchLine.VALIDATE("Prepmt. Amt. Inv.",PurchOrderLine."Prepmt. Amt. Inv.");
              END;
          END;

          PurchLine."Attached to Line No." :=
            TransferOldExtLines.TransferExtendedText(
              "Line No.",
              NextLineNo,
              "Attached to Line No.");
          PurchLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
          PurchLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
          PurchLine."Dimension Set ID" := "Dimension Set ID";

          IF "Sales Order No." = '' THEN
            PurchLine."Drop Shipment" := FALSE
          ELSE
            PurchLine."Drop Shipment" := TRUE;

          PurchLine.INSERT;

          ItemTrackingMgt.CopyHandledItemTrkgToInvLine2(PurchOrderLine,PurchLine);

          NextLineNo := NextLineNo + 10000;
          IF "Attached to Line No." = 0 THEN
            SETRANGE("Attached to Line No.","Line No.");
        UNTIL (NEXT = 0) OR ("Attached to Line No." = 0);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..16
          LanguageManagement.SetGlobalLanguageByCode(PurchInvHeader."Language Code");
          PurchLine.Description := STRSUBSTNO(Text000,"Document No.");
          LanguageManagement.RestoreGlobalLanguage;
        #18..83
        #85..87
            PurchOrderLine."Line Discount Amount" :=
              ROUND(
                PurchOrderLine."Line Discount Amount" * PurchLine.Quantity / PurchOrderLine.Quantity,
                Currency."Amount Rounding Precision");
            IF PurchInvHeader."Prices Including VAT" THEN BEGIN
              IF NOT PurchOrderHeader."Prices Including VAT" THEN
                PurchOrderLine."Line Discount Amount" :=
                  ROUND(
                    PurchOrderLine."Line Discount Amount" *
                    (1 + PurchOrderLine."VAT %" / 100),Currency."Amount Rounding Precision");
            END ELSE
              IF PurchOrderHeader."Prices Including VAT" THEN
                PurchOrderLine."Line Discount Amount" :=
                  ROUND(
                    PurchOrderLine."Line Discount Amount" /
                    (1 + PurchOrderLine."VAT %" / 100),Currency."Amount Rounding Precision");
            PurchLine.VALIDATE("Line Discount Amount",PurchOrderLine."Line Discount Amount");
            PurchLine."Line Discount %" := PurchOrderLine."Line Discount %";
            PurchLine.UpdatePrePaymentAmounts;
            IF PurchOrderLine.Quantity = 0 THEN
              PurchLine.VALIDATE("Inv. Discount Amount",0)
            ELSE
              PurchLine.VALIDATE(
                "Inv. Discount Amount",
                ROUND(
                  PurchOrderLine."Inv. Discount Amount" * PurchLine.Quantity / PurchOrderLine.Quantity,
                  Currency."Amount Rounding Precision"));
        #107..130
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "GetPurchInvLines(PROCEDURE 4)".


    procedure InitFromPurchLine(PurchRcptHeader: Record "120";PurchLine: Record "39")
    var
        Factor: Decimal;
    begin
        INIT;
        TRANSFERFIELDS(PurchLine);
        IF ("No." = '') AND (Type IN [Type::"G/L Account"..Type::"Charge (Item)"]) THEN
          Type := Type::" ";
        "Posting Date" := PurchRcptHeader."Posting Date";
        "Document No." := PurchRcptHeader."No.";
        Quantity := PurchLine."Qty. to Receive";
        "Quantity (Base)" := PurchLine."Qty. to Receive (Base)";
        IF ABS(PurchLine."Qty. to Invoice") > ABS(PurchLine."Qty. to Receive") THEN BEGIN
          "Quantity Invoiced" := PurchLine."Qty. to Receive";
          "Qty. Invoiced (Base)" := PurchLine."Qty. to Receive (Base)";
        END ELSE BEGIN
          "Quantity Invoiced" := PurchLine."Qty. to Invoice";
          "Qty. Invoiced (Base)" := PurchLine."Qty. to Invoice (Base)";
        END;
        "Qty. Rcd. Not Invoiced" := Quantity - "Quantity Invoiced";
        IF PurchLine."Document Type" = PurchLine."Document Type"::Order THEN BEGIN
          "Order No." := PurchLine."Document No.";
          "Order Line No." := PurchLine."Line No.";
        END;
        IF (PurchLine.Quantity <> 0) AND ("Job No." <> '') THEN BEGIN
          Factor := PurchLine."Qty. to Receive" / PurchLine.Quantity;
          IF Factor <> 1 THEN
            UpdateJobPrices(Factor);
        END;
    end;

    local procedure UpdateJobPrices(Factor: Decimal)
    begin
        "Job Total Price" :=
          ROUND("Job Total Price" * Factor,Currency."Amount Rounding Precision");
        "Job Total Price (LCY)" :=
          ROUND("Job Total Price (LCY)" * Factor,Currency."Amount Rounding Precision");
        "Job Line Amount" :=
          ROUND("Job Line Amount" * Factor,Currency."Amount Rounding Precision");
        "Job Line Amount (LCY)" :=
          ROUND("Job Line Amount (LCY)" * Factor,Currency."Amount Rounding Precision");
        "Job Line Discount Amount" :=
          ROUND("Job Line Discount Amount" * Factor,Currency."Amount Rounding Precision");
        "Job Line Disc. Amount (LCY)" :=
          ROUND("Job Line Disc. Amount (LCY)" * Factor,Currency."Amount Rounding Precision");
    end;

    local procedure GetFieldCaption(FieldNumber: Integer): Text[100]
    var
        "Field": Record "2000000041";
    begin
        Field.GET(DATABASE::"Purch. Rcpt. Line",FieldNumber);
        EXIT(Field."Field Caption");
    end;

    local procedure GetCaptionClass(FieldNumber: Integer): Text[80]
    begin
        CASE FieldNumber OF
          FIELDNO("No."):
            BEGIN
              IF ApplicationAreaSetup.IsFoundationEnabled THEN
                EXIT(STRSUBSTNO('3,%1',ItemNoFieldCaptionTxt));
              EXIT(STRSUBSTNO('3,%1',GetFieldCaption(FieldNumber)));
            END;
        END;
    end;

    //Unsupported feature: Deletion (VariableCollection) on "ShowItemTrackingLines(PROCEDURE 3).ItemTrackingMgt(Variable 1000)".


    //Unsupported feature: Property Insertion (Temporary) on "InsertInvLineFromRcptLine(PROCEDURE 2).TempPurchLine(Variable 1003)".


    //Unsupported feature: Deletion (VariableCollection) on "InsertInvLineFromRcptLine(PROCEDURE 2).PurchSetup(Variable 1011)".


    var
        ApplicationAreaSetup: Record "9178";

    var
        ItemNoFieldCaptionTxt: Label 'Item No.';
}

