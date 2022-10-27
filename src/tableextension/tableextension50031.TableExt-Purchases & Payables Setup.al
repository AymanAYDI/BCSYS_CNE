tableextension 50031 tableextension50031 extends "Purchases & Payables Setup"
{
    // //MINMACDE SM 13/10/06 NSC1.01 [FE02] Ajout du champ 60000
    // 
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    //           - Add fields 80800
    // ------------------------------------------------------------------------
    // 
    // //TODO point 57 FLGR 08/02/2007 : parametrer la demande de creation de prix négocié ajout champ 60003
    LookupPageID = 460;
    DrillDownPageID = 460;
    fields
    {

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Receipt on Invoice"(Field 6)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Order Nos."(Field 11)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Posted Receipt Nos."(Field 16)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Blanket Order Nos."(Field 19)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Calc. Inv. Discount"(Field 20)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Appln. between Currencies"(Field 21)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Copy Comments Blanket to Order"(Field 22)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Copy Comments Order to Invoice"(Field 23)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Copy Comments Order to Receipt"(Field 24)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Default Qty. to Receive"(Field 36)".

        modify("Job Q. Prio. for Post & Print")
        {
            Caption = 'Job Q. Prio. for Post & Print';
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Posted Return Shpt. Nos."(Field 5800)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Copy Cmts Ret.Ord. to Ret.Shpt"(Field 5801)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Copy Cmts Ret.Ord. to Cr. Memo"(Field 5802)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Return Order Nos."(Field 6600)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Return Shipment on Credit Memo"(Field 6601)".

        field(46; "Allow Document Deletion Before"; Date)
        {
            Caption = 'Allow Document Deletion Before';
        }
        field(1217; "Debit Acc. for Non-Item Lines"; Code[20])
        {
            Caption = 'Debit Acc. for Non-Item Lines';
            TableRelation = "G/L Account" WHERE (Direct Posting=CONST(Yes),
                                                 Account Type=CONST(Posting),
                                                 Blocked=CONST(No));
        }
        field(1218; "Credit Acc. for Non-Item Lines"; Code[20])
        {
            Caption = 'Credit Acc. for Non-Item Lines';
            TableRelation = "G/L Account" WHERE (Direct Posting=CONST(Yes),
                                                 Account Type=CONST(Posting),
                                                 Blocked=CONST(No));
        }
        field(50000; "SAV Return Order Nos."; Code[10])
        {
            AccessByPermission = TableData 6650 = R;
            Caption = 'SAV Return Order Nos.';
            Description = 'BC6';
            TableRelation = "No. Series";
        }
        field(60000; "Minima de cde"; Boolean)
        {
            Caption = 'Montant mini pour franco';
            Description = 'MINMACDE SM 13/10/06 NSC1.01 [FE02] Ajout du champ 60000';
        }
        field(60001; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(60002; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST (" ")) "Standard Text"
            ELSE
            IF (Type = CONST (G/L Account)) "G/L Account"
                            ELSE IF (Type=CONST(Item)) Item
                            ELSE IF (Type=CONST(Resource)) Resource
                            ELSE IF (Type=CONST(Fixed Asset)) "Fixed Asset"
                            ELSE IF (Type=CONST("Charge (Item)")) "Item Charge";

            trigger OnValidate()
            var
                ICPartner: Record "413";
                ItemCrossReference: Record "5717";
                "**NSC1.01**": Integer;
                SalesLineProfit: Record "7004";
                PurchPrice: Record "7012";
            begin
            end;
        }
        field(60003;"Ask custom purch price";Boolean)
        {
            Caption = 'Ask For custom Purchase Price';
        }
        field(80800;"DEEE Management";Boolean)
        {
            Caption = 'DEEE Management';
            Description = 'DEEE1.00';
        }
    }
}

