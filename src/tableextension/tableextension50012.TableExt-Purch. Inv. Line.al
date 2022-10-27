tableextension 50012 tableextension50012 extends "Purch. Inv. Line"
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
    // 
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    //           - Add fields 80800, 80002..80007
    //           - CalcVATAmountLines
    // //>>CNE1.00
    // FEP-ADVE-200706_18_B:MA 12/11/2007 : Suivi historique
    //          - Add key "No.","Buy-from Vendor No."
    // FEP-ADVE-200706_18_E:MA 14/11/2007
    //           - Add Key "Buy-from Vendor No.","Type"
    // 
    // ------------------------------------------------------------------------
    LookupPageID = 529;
    DrillDownPageID = 529;
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
        field(1700;"Deferral Code";Code[10])
        {
            Caption = 'Deferral Code';
            TableRelation = "Deferral Template"."Deferral Code";
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
            AutoFormatType = 2;
            Caption = 'Discount Direct Unit Cost excluding VAT';
            Editable = false;

            trigger OnValidate()
            begin
                VALIDATE("Line Discount %");
            end;
        }
        field(80800;"DEEE Category Code";Code[10])
        {
            Caption = 'DEEE Category Code';
            Description = 'DEEE1.00';
            TableRelation = "Categories of item".Category;
        }
        field(80801;"DEEE Unit Price";Decimal)
        {
            Caption = 'DEEE Unit Price';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80802;"DEEE HT Amount";Decimal)
        {
            Caption = 'DEEE HT Amount';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80803;"DEEE Bases VAT Amount";Decimal)
        {
            Caption = 'DEEE Bases VAT Amount';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80804;"DEEE VAT Amount";Decimal)
        {
            Caption = 'DEEE VAT Amount';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80805;"DEEE TTC Amount";Decimal)
        {
            Caption = 'DEEE TTC Amount';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80806;"DEEE HT Amount (LCY)";Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80807;"Eco partner DEEE";Code[20])
        {
            Caption = 'Eco partner DEEE';
            Description = 'DEEE1.00';
            Editable = false;
            TableRelation = Vendor;
        }
    }
    keys
    {

        //Unsupported feature: Property Deletion (KeyGroups) on ""Blanket Order No.,Blanket Order Line No."(Key)".

        key(Key1;"No.")
        {
        }
        key(Key2;"Buy-from Vendor No.",Type)
        {
        }
        key(Key3;"No.","Buy-from Vendor No.","Document No.","Line No.")
        {
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: PostedDeferralHeader)()
    //Parameters and return type have not been exported.
    //begin
        /*
        */
    //end;


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PurchDocLineComments.SETRANGE("Document Type",PurchDocLineComments."Document Type"::"Posted Invoice");
        PurchDocLineComments.SETRANGE("No.","Document No.");
        PurchDocLineComments.SETRANGE("Document Line No.","Line No.");
        IF NOT PurchDocLineComments.ISEMPTY THEN
          PurchDocLineComments.DELETEALL;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5

        PostedDeferralHeader.DeleteHeader(DeferralUtilities.GetPurchDeferralDocType,'','',
          PurchDocLineComments."Document Type"::"Posted Invoice","Document No.","Line No.");
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ItemTrackingDocMgt) (VariableCollection) on "ShowItemTrackingLines(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "ShowItemTrackingLines(PROCEDURE 3)".

    //procedure ShowItemTrackingLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ItemTrackingMgt.CallPostedItemTrackingForm3(RowID1);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ItemTrackingDocMgt.ShowItemTrackingForInvoiceLine(RowID1);
        */
    //end;


    //Unsupported feature: Code Modification on "CalcVATAmountLines(PROCEDURE 2)".

    //procedure CalcVATAmountLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        VATAmountLine.DELETEALL;
        SETRANGE("Document No.",PurchInvHeader."No.");
        IF FIND('-') THEN
          REPEAT
            VATAmountLine.INIT;
            VATAmountLine."VAT Identifier" := "VAT Identifier";
            VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
            VATAmountLine."Tax Group Code" := "Tax Group Code";
            VATAmountLine."Use Tax" := "Use Tax";
            VATAmountLine."VAT %" := "VAT %";
            VATAmountLine."VAT Base" := Amount;
            VATAmountLine."VAT Amount" := "Amount Including VAT" - Amount;
            VATAmountLine."Amount Including VAT" := "Amount Including VAT";
            VATAmountLine."Line Amount" := "Line Amount";
            IF "Allow Invoice Disc." THEN
              VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
            VATAmountLine.Quantity := "Quantity (Base)";
            VATAmountLine."Calculated VAT Amount" := "Amount Including VAT" - Amount - "VAT Difference";
            VATAmountLine."VAT Difference" := "VAT Difference";
            VATAmountLine.InsertLine;
          UNTIL NEXT = 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TempVATAmountLine.DELETEALL;
        #2..4
            TempVATAmountLine.INIT;
            TempVATAmountLine.CopyFromPurchInvLine(Rec);

            //>>MIGRATION NAV 2013
            //>>DEEE1.00 : Update DEEE Amount for the VAT line (stat F9)
            TempVATAmountLine."DEEE HT Amount":=TempVATAmountLine."DEEE HT Amount"+"DEEE HT Amount" ;
            TempVATAmountLine."DEEE VAT Amount":=TempVATAmountLine."DEEE VAT Amount"+"DEEE VAT Amount" ;
            TempVATAmountLine."DEEE TTC Amount":=TempVATAmountLine."DEEE TTC Amount"+"DEEE TTC Amount" ;
            IF "Allow Invoice Disc." THEN
              TempVATAmountLine."Inv. Disc. Base Amount" := TempVATAmountLine."Inv. Disc. Base Amount"+"DEEE HT Amount" ;

            //<<DEEE1.00 : Update DEEE Amount for the VAT line (stat F9)
            //<<MIGRATION NAV 2013

            TempVATAmountLine.InsertLine;
          UNTIL NEXT = 0;
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "GetPurchRcptLines(PROCEDURE 5)".


    //Unsupported feature: Property Insertion (Local) on "FilterPstdDocLineValueEntries(PROCEDURE 7)".


    procedure InitFromPurchLine(PurchInvHeader: Record "122";PurchLine: Record "39")
    begin
        INIT;
        TRANSFERFIELDS(PurchLine);
        IF ("No." = '') AND (Type IN [Type::"G/L Account"..Type::"Charge (Item)"]) THEN
          Type := Type::" ";
        "Posting Date" := PurchInvHeader."Posting Date";
        "Document No." := PurchInvHeader."No.";
        Quantity := PurchLine."Qty. to Invoice";
        "Quantity (Base)" := PurchLine."Qty. to Invoice (Base)";
    end;

    procedure ShowDeferrals()
    begin
        DeferralUtilities.OpenLineScheduleView(
          "Deferral Code",DeferralUtilities.GetPurchDeferralDocType,'','',
          GetDocumentType,"Document No.","Line No.");
    end;

    procedure GetDocumentType(): Integer
    var
        PurchCommentLine: Record "43";
    begin
        EXIT(PurchCommentLine."Document Type"::"Posted Invoice")
    end;

    //Unsupported feature: Deletion (VariableCollection) on "ShowItemTrackingLines(PROCEDURE 3).ItemTrackingMgt(Variable 1000)".


    //Unsupported feature: Property Deletion (AsVar) on "CalcVATAmountLines(PROCEDURE 2).PurchInvHeader(Parameter 1000)".


    //Unsupported feature: Property Modification (Name) on "CalcVATAmountLines(PROCEDURE 2).VATAmountLine(Parameter 1001)".


    //Unsupported feature: Property Insertion (Temporary) on "CalcVATAmountLines(PROCEDURE 2).VATAmountLine(Parameter 1001)".


    var
        PostedDeferralHeader: Record "1704";

    var
        DeferralUtilities: Codeunit "1720";
}

