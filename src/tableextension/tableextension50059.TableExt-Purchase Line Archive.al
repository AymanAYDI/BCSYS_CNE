tableextension 50059 tableextension50059 extends "Purchase Line Archive"
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
    // ------------------------------------------------------------------------
    fields
    {
        modify("Document No.")
        {
            TableRelation = "Purchase Header Archive".No. WHERE (Document Type=FIELD(Document Type),
                                                                 Version No.=FIELD(Version No.));
        }
        modify("No.")
        {
            TableRelation = IF (Type=CONST(" ")) "Standard Text"
                            ELSE IF (Type=CONST(G/L Account)) "G/L Account"
                            ELSE IF (Type=CONST(Item)) Item
                            ELSE IF (Type=CONST(3)) Resource
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

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Qty. to Receive"(Field 18)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Appl.-to Item Entry"(Field 38)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Quantity Received"(Field 60)".

        modify("Sales Order Line No.")
        {
            TableRelation = IF (Drop Shipment=CONST(Yes)) "Sales Line"."Line No." WHERE (Document Type=CONST(Order),
                                                                                         Document No.=FIELD(Sales Order No.));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Drop Shipment"(Field 73)".

        modify("Attached to Line No.")
        {
            TableRelation = "Purchase Line Archive"."Line No." WHERE (Document Type=FIELD(Document Type),
                                                                      Document No.=FIELD(Document No.),
                                                                      Doc. No. Occurrence=FIELD(Doc. No. Occurrence),
                                                                      Version No.=FIELD(Version No.));
        }
        modify("Blanket Order Line No.")
        {
            TableRelation = "Purchase Line"."Line No." WHERE (Document Type=CONST(Blanket Order),
                                                              Document No.=FIELD(Blanket Order No.));
        }
        modify("Unit of Measure Code")
        {
            TableRelation = IF (Type=CONST(Item)) "Item Unit of Measure".Code WHERE (Item No.=FIELD(No.))
                            ELSE "Unit of Measure";
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Cross-Reference No."(Field 5705)".


        //Unsupported feature: Property Modification (Data type) on ""Item Category Code"(Field 5709)".


        //Unsupported feature: Property Insertion (ValidateTableRelation) on ""Product Group Code"(Field 5712)".

        modify("Special Order Sales Line No.")
        {
            TableRelation = IF (Special Order=CONST(Yes)) "Sales Line"."Line No." WHERE (Document Type=CONST(Order),
                                                                                         Document No.=FIELD(Special Order Sales No.));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Requested Receipt Date"(Field 5790)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Lead Time Calculation"(Field 5792)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Inbound Whse. Handling Time"(Field 5793)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Order Date"(Field 5795)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Allow Item Charge Assignment"(Field 5800)".

        modify("Operation No.")
        {
            TableRelation = "Prod. Order Routing Line"."Operation No." WHERE (Status=CONST(Released),
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
        field(1702;"Returns Deferral Start Date";Date)
        {
            Caption = 'Returns Deferral Start Date';
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
        key(Key1;Type,"No.")
        {
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: DeferralHeaderArchive)()
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
        PurchCommentLineArch.SETRANGE("Document Type","Document Type");
        PurchCommentLineArch.SETRANGE("No.","No.");
        PurchCommentLineArch.SETRANGE("Document Line No.","Line No.");
        PurchCommentLineArch.SETRANGE("Doc. No. Occurrence","Doc. No. Occurrence");
        PurchCommentLineArch.SETRANGE("Version No.","Version No.");
        IF NOT PurchCommentLineArch.ISEMPTY THEN
          PurchCommentLineArch.DELETEALL;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7

        IF "Deferral Code" <> '' THEN
          DeferralHeaderArchive.DeleteHeader(DeferralUtilities.GetPurchDeferralDocType,
            "Document Type","Document No.","Doc. No. Occurrence","Version No.","Line No.");
        */
    //end;

    procedure ShowDeferrals()
    begin
        DeferralUtilities.OpenLineScheduleArchive(
          "Deferral Code",DeferralUtilities.GetPurchDeferralDocType,
          "Document Type","Document No.",
          "Doc. No. Occurrence","Version No.","Line No.");
    end;

    var
        DeferralHeaderArchive: Record "5127";

    var
        DeferralUtilities: Codeunit "1720";
}

