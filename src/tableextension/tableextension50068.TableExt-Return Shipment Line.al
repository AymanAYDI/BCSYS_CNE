tableextension 50068 tableextension50068 extends "Return Shipment Line"
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
    //                   - Add key "No.","Buy-from Vendor No."
    // ------------------------------------------------------------------------
    LookupPageID = 6653;
    fields
    {
        modify("No.")
        {
            TableRelation = IF (Type = CONST (G/L Account)) "G/L Account"
                            ELSE IF (Type=CONST(Item)) Item
                            ELSE IF (Type=CONST(Fixed Asset)) "Fixed Asset"
                            ELSE IF (Type=CONST("Charge (Item)")) "Item Charge";
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


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Blanket Order No."(Field 97)".

        modify("Blanket Order Line No.")
        {
            TableRelation = "Sales Line"."Line No." WHERE (Document Type=CONST(Blanket Order),
                                                           Document No.=FIELD(Blanket Order No.));

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Blanket Order Line No."(Field 98)".

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
        key(Key1;"No.")
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
        ItemTrackingMgt.CallPostedItemTrackingForm(DATABASE::"Return Shipment Line",0,"Document No.",'',0,"Line No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ItemTrackingDocMgt.ShowItemTrackingForShptRcptLine(DATABASE::"Return Shipment Line",0,"Document No.",'',0,"Line No.");
        */
    //end;


    //Unsupported feature: Code Modification on "InsertInvLineFromRetShptLine(PROCEDURE 2)".

    //procedure InsertInvLineFromRetShptLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SETRANGE("Document No.","Document No.");

        TempPurchLine := PurchLine;
        #4..81
            PurchLine.VALIDATE(Quantity,Quantity - "Quantity Invoiced");
            PurchLine.VALIDATE("Direct Unit Cost",PurchOrderLine."Direct Unit Cost");
            PurchLine.VALIDATE("Line Discount %",PurchOrderLine."Line Discount %");
            IF NOT PurchSetup."Calc. Inv. Discount" THEN
              PurchLine.VALIDATE("Inv. Discount Amount",PurchOrderLine."Inv. Discount Amount");
          END;
          PurchLine."Attached to Line No." :=
            TransferOldExtLines.TransferExtendedText(
        #90..100
          IF "Attached to Line No." = 0 THEN
            SETRANGE("Attached to Line No.","Line No.");
        UNTIL (NEXT = 0) OR ("Attached to Line No." = 0);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..84
            IF PurchOrderLine.Quantity = 0 THEN
              PurchLine.VALIDATE("Inv. Discount Amount",0)
            ELSE
              PurchLine.VALIDATE(
                "Inv. Discount Amount",
                ROUND(
                  PurchOrderLine."Inv. Discount Amount" * PurchLine.Quantity / PurchOrderLine.Quantity,
                  Currency."Amount Rounding Precision"));
        #87..103
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "GetPurchCrMemoLines(PROCEDURE 4)".


    procedure InitFromPurchLine(ReturnShptHeader: Record "6650";PurchLine: Record "39")
    begin
        INIT;
        TRANSFERFIELDS(PurchLine);
        IF ("No." = '') AND (Type IN [Type::"G/L Account"..Type::"Charge (Item)"]) THEN
          Type := Type::" ";
        "Posting Date" := ReturnShptHeader."Posting Date";
        "Document No." := ReturnShptHeader."No.";
        Quantity := PurchLine."Return Qty. to Ship";
        "Quantity (Base)" := PurchLine."Return Qty. to Ship (Base)";
        IF ABS(PurchLine."Qty. to Invoice") > ABS(PurchLine."Return Qty. to Ship") THEN BEGIN
          "Quantity Invoiced" := PurchLine."Return Qty. to Ship";
          "Qty. Invoiced (Base)" := PurchLine."Return Qty. to Ship (Base)";
        END ELSE BEGIN
          "Quantity Invoiced" := PurchLine."Qty. to Invoice";
          "Qty. Invoiced (Base)" := PurchLine."Qty. to Invoice (Base)";
        END;
        "Return Qty. Shipped Not Invd." := Quantity - "Quantity Invoiced";
        IF PurchLine."Document Type" = PurchLine."Document Type"::"Return Order" THEN BEGIN
          "Return Order No." := PurchLine."Document No.";
          "Return Order Line No." := PurchLine."Line No.";
        END;
    end;

    //Unsupported feature: Deletion (VariableCollection) on "ShowItemTrackingLines(PROCEDURE 3).ItemTrackingMgt(Variable 1000)".


    //Unsupported feature: Property Insertion (Temporary) on "InsertInvLineFromRetShptLine(PROCEDURE 2).TempPurchLine(Variable 1003)".

}

