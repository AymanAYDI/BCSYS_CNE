tableextension 50035 tableextension50035 extends "Sales Header"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm]             Mise à jour Codes INCOTERM Onglet "INTERNATIONAL"
    //                                                              sur le trigger "Sell-to Customer No. - OnValidate()"
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Post_It]              Affiche les textes de type postit
    //                                                              sur le trigger "Sell-to Customer No. - OnValidate()"
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Archivage_Devis]      Ajout du champ 50000
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ 50003
    //                                                              Ajout code pr récupérer Tiers payeur dans trigger
    //                                                              Sell-to Customer No. - OnValidate()
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Champs_Suppl]         Ajout du champ 50004
    //                                                              => utilisé sur le Page 42 et les Reports NAVIDIIGEST Ventes
    // //GRPMARGEVENTE SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ 50020  et ramener 50020 de la fiche client
    // //AjoutCodeUtilisateur RD 13/11/06 NCS1.01 [FE019V1] Ajout du code utilisateur dans les documents d'achats & ventes
    //                                                      Ajout du champs 50010
    // //VERSION FG 04/12/2006 NSC1.01 ajout champ 50040
    // //FE004 FLGR 05/12/2006 ajout fonction CreatePurchaseQuote
    // //FE015 FLGR 07/12/2006 ajout champ statut 50060 statut devis
    //                         ajout fonction verifyquotestatus
    // //FE018 FLGR 08/12/2006 Regroupement BL par commande ajout champ 50025 Combine Shipments by order
    //         ajout clef Document Type,Combine Shipments by Order,Combine Shipments,Bill-to Customer No.,Currency Code
    // //COUT_ACHAT FG 20/12/06 NSC1.01
    // //marge sur entete doc vente FE019 FLGR 28/12/2006 modif champ 50030, 50031, 50032
    // //FE005 SEBC 08/01/2007 Add field
    //                         50061 Sell-to Fax No.
    // //Propagation CASC 18/01/2007 NSC1.01 : Add fields
    //                                         50033 Invoiced
    //                                         Purchase Cost renumber to 50026
    //                                         50031 Profit LCY
    // 
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    //           - Reason Code - OnValidate()
    // 
    // //TODOLIST POINT 40  FLGR 26/01/2007 : autorisation modification champs 5794, 105 et 106 quand commande est lancée
    // //todolist point 47  FLGR 09/02/2007 : modif adresse client, facturation et livraison pour celle du contact selectionné.
    //                 modif updateselltocust function
    // 
    // //FE005 MICO 12/02/2007 : Ajout champ 50062 Sell-to E-Mail Address
    //                                 fonction UpdateSellToMail
    // //TODOLIST point 65 FLGR 20/02/2007 : modif libelle ecriture article
    // //VERSIONNING FG 28/02/07 suite au Merge
    // 
    // //>>CNE1.00
    // cuFEP-ACHAT-200706_18_A.001:MA 09/11/2007 : Achats groupés
    //                                           - Add Fields :
    //                                                50001 : "Purchaser Comments"
    //                                                50002 : "Warehouse Comments"
    // //>>CNE1.00
    // FEP-ADVE-200706_18_A.001:MA 14/11/2007 : Gestion des appels d'offres
    //     - Add field 50005
    // 
    // //>>CNE1.00
    // FEP-ACHAT-200706_18_A.001:MA 16/11/2007 : Achats groupés
    //                                           - Add Code to "CreatePurchaseQuote" function
    //                                             --> to populate field "Purchase Receipt Date" (Sales Line)
    // 
    // //>> CNE4.02
    // C:FE09 05.10.2011 : Availability Customer Area - Shipping Bin
    //                     - Add Field    : 50403 Bin Code
    // 
    // //>>MIGRATION NAV 2013
    // Increase the length of the Field 50010 ID 20-->50 (The length of User ID in NAV 2013 is 50)
    // Modify function CreateInvtPutAwayPick()
    // 
    // //>>CNE5.00
    // TDL.80:20131120/CSC
    // - Add a new key on "Document Type,Order Date,No."
    // 
    // //TDL.EC05  CNE6.01 Copy Sell-to Address in Invoice-to/Ship-to Address
    //                     Add Fonction : CopySellToAddress
    // 
    // //>>CNEIC : 06/2015 : ajout du champs 50080  pour le lien avec la commande Achat.
    //                       CTRL lors de la suppression, pour une filiale, qu'il n'existe pas de commande achat lien.
    //             07/08/15 : ajout d'une possibilité de lookup sur le n° cde achat lien
    // 
    // //>>CNE7.01
    // //>>P24233_001 SOBI APA 02/02/17
    //                     Add Field 50100
    //                     Modify Bill-to Customer No. - OnValidate
    // 
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013 - 2017
    // //>> CNE4.01 Bin default
    // //BC6 EABO 11/04/18 : mise à jour de la référence et du code affaire sur les expé
    // 
    // 
    // //>> CNE : 25/06 : Flux SAV
    //           Ajout du champ 50120 "Return Order Type"
    // //>>BC6 01102020 :
    //   - Modify Functions TestNoSeries And GetNoSeriesCode
    LookupPageID = 45;
    fields
    {
        modify("Bill-to Name")
        {
            TableRelation = Customer;

            //Unsupported feature: Property Insertion (ValidateTableRelation) on ""Bill-to Name"(Field 5)".

        }
        modify("Bill-to City")
        {
            TableRelation = IF (Bill-to Country/Region Code=CONST()) "Post Code".City
                            ELSE IF (Bill-to Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Bill-to Country/Region Code));
        }
        modify("Ship-to City")
        {
            TableRelation = IF (Ship-to Country/Region Code=CONST()) "Post Code".City
                            ELSE IF (Ship-to Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Ship-to Country/Region Code));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Order Date"(Field 19)".

        modify("Shortcut Dimension 1 Code")
        {
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(1),
                                                          Blocked=CONST(No));
        }
        modify("Shortcut Dimension 2 Code")
        {
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(2),
                                                          Blocked=CONST(No));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Invoice Disc. Code"(Field 37)".


        //Unsupported feature: Property Modification (CalcFormula) on "Comment(Field 46)".

        modify("Bal. Account No.")
        {
            TableRelation = IF (Bal. Account Type=CONST(G/L Account)) "G/L Account"
                            ELSE IF (Bal. Account Type=CONST(Bank Account)) "Bank Account";
        }

        //Unsupported feature: Property Modification (CalcFormula) on "Amount(Field 60)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Amount Including VAT"(Field 61)".

        modify("Sell-to Customer Name")
        {
            TableRelation = Customer;

            //Unsupported feature: Property Insertion (ValidateTableRelation) on ""Sell-to Customer Name"(Field 79)".

        }
        modify("Sell-to City")
        {
            TableRelation = IF (Sell-to Country/Region Code=CONST()) "Post Code".City
                            ELSE IF (Sell-to Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Sell-to Country/Region Code));
        }
        modify("Sell-to Post Code")
        {
            TableRelation = IF (Sell-to Country/Region Code=CONST()) "Post Code"
                            ELSE IF (Sell-to Country/Region Code=FILTER(<>'')) "Post Code" WHERE (Country/Region Code=FIELD(Sell-to Country/Region Code));
        }
        modify("Ship-to Post Code")
        {
            TableRelation = IF (Ship-to Country/Region Code=CONST()) "Post Code"
                            ELSE IF (Ship-to Country/Region Code=FILTER(<>'')) "Post Code" WHERE (Country/Region Code=FIELD(Ship-to Country/Region Code));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipping Agent Code"(Field 105)".


        //Unsupported feature: Property Insertion (ValidateTableRelation) on ""Tax Area Code"(Field 114)".


        //Unsupported feature: Property Insertion (InitValue) on "Reserve(Field 117)".


        //Unsupported feature: Property Insertion (AccessByPermission) on "Reserve(Field 117)".

        modify("Incoming Document Entry No.")
        {
            TableRelation = "Incoming Document";
        }
        modify("Direct Debit Mandate ID")
        {

            //Unsupported feature: Property Modification (Data type) on ""Direct Debit Mandate ID"(Field 1200)".

            TableRelation = "SEPA Direct Debit Mandate" WHERE (Customer No.=FIELD(Bill-to Customer No.),
                                                               Closed=CONST(No),
                                                               Blocked=CONST(No));
            Caption = 'Direct Debit Mandate ID';
        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Invoice Discount Amount"(Field 1305)".


        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Archived Versions"(Field 5043)".

        modify("Opportunity No.")
        {
            TableRelation = IF (Document Type=FILTER(<>Order)) Opportunity.No. WHERE (Contact No.=FIELD(Sell-to Contact No.),
                                                                                      Closed=CONST(No))
                                                                                      ELSE IF (Document Type=CONST(Order)) Opportunity.No. WHERE (Contact No.=FIELD(Sell-to Contact No.),
                                                                                                                                                  Sales Document No.=FIELD(No.),
                                                                                                                                                  Sales Document Type=CONST(Order));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipping Advice"(Field 5750)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Shipped Not Invoiced"(Field 5751)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipped Not Invoiced"(Field 5751)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Completely Shipped"(Field 5752)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Posting from Whse. Ref."(Field 5753)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Requested Delivery Date"(Field 5790)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Promised Delivery Date"(Field 5791)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipping Time"(Field 5792)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Outbound Whse. Handling Time"(Field 5793)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Late Order Shipping"(Field 5795)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Late Order Shipping"(Field 5795)".



        //Unsupported feature: Code Modification on ""Sell-to Customer No."(Field 2).OnValidate".

        //trigger "(Field 2)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            IF ("Sell-to Customer No." <> xRec."Sell-to Customer No.") AND
               (xRec."Sell-to Customer No." <> '')
            THEN BEGIN
              IF ("Opportunity No." <> '') AND ("Document Type" IN ["Document Type"::Quote,"Document Type"::Order]) THEN
                ERROR(
                  Text062,
                  FIELDCAPTION("Sell-to Customer No."),
                  FIELDCAPTION("Opportunity No."),
                  "Opportunity No.",
                  "Document Type");
              IF HideValidationDialog OR NOT GUIALLOWED THEN
                Confirmed := TRUE
              ELSE
                Confirmed := CONFIRM(Text004,FALSE,FIELDCAPTION("Sell-to Customer No."));
              IF Confirmed THEN BEGIN
                SalesLine.SETRANGE("Document Type","Document Type");
                SalesLine.SETRANGE("Document No.","No.");
                IF "Sell-to Customer No." = '' THEN BEGIN
                  IF SalesLine.FINDFIRST THEN
                    ERROR(
                      Text005,
                      FIELDCAPTION("Sell-to Customer No."));
                  INIT;
                  SalesSetup.GET;
                  "No. Series" := xRec."No. Series";
                  InitRecord;
                  IF xRec."Shipping No." <> '' THEN BEGIN
                    "Shipping No. Series" := xRec."Shipping No. Series";
                    "Shipping No." := xRec."Shipping No.";
                  END;
                  IF xRec."Posting No." <> '' THEN BEGIN
                    "Posting No. Series" := xRec."Posting No. Series";
                    "Posting No." := xRec."Posting No.";
                  END;
                  IF xRec."Return Receipt No." <> '' THEN BEGIN
                    "Return Receipt No. Series" := xRec."Return Receipt No. Series";
                    "Return Receipt No." := xRec."Return Receipt No.";
                  END;
                  IF xRec."Prepayment No." <> '' THEN BEGIN
                    "Prepayment No. Series" := xRec."Prepayment No. Series";
                    "Prepayment No." := xRec."Prepayment No.";
                  END;
                  IF xRec."Prepmt. Cr. Memo No." <> '' THEN BEGIN
                    "Prepmt. Cr. Memo No. Series" := xRec."Prepmt. Cr. Memo No. Series";
                    "Prepmt. Cr. Memo No." := xRec."Prepmt. Cr. Memo No.";
                  END;
                  EXIT;
                END;
                IF "Document Type" = "Document Type"::Order THEN
                  SalesLine.SETFILTER("Quantity Shipped",'<>0')
                ELSE
                  IF "Document Type" = "Document Type"::Invoice THEN BEGIN
                    SalesLine.SETRANGE("Sell-to Customer No.",xRec."Sell-to Customer No.");
                    SalesLine.SETFILTER("Shipment No.",'<>%1','');
                  END;

                IF SalesLine.FINDFIRST THEN
                  IF "Document Type" = "Document Type"::Order THEN
                    SalesLine.TESTFIELD("Quantity Shipped",0)
                  ELSE
                    SalesLine.TESTFIELD("Shipment No.",'');
                SalesLine.SETRANGE("Shipment No.");
                SalesLine.SETRANGE("Quantity Shipped");

                IF "Document Type" = "Document Type"::Order THEN BEGIN
                  SalesLine.SETFILTER("Prepmt. Amt. Inv.",'<>0');
                  IF SalesLine.FIND('-') THEN
                    SalesLine.TESTFIELD("Prepmt. Amt. Inv.",0);
                  SalesLine.SETRANGE("Prepmt. Amt. Inv.");
                END;

                IF "Document Type" = "Document Type"::"Return Order" THEN
                  SalesLine.SETFILTER("Return Qty. Received",'<>0')
                ELSE
                  IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                    SalesLine.SETRANGE("Sell-to Customer No.",xRec."Sell-to Customer No.");
                    SalesLine.SETFILTER("Return Receipt No.",'<>%1','');
                  END;

                IF SalesLine.FINDFIRST THEN
                  IF "Document Type" = "Document Type"::"Return Order" THEN
                    SalesLine.TESTFIELD("Return Qty. Received",0)
                  ELSE
                    SalesLine.TESTFIELD("Return Receipt No.",'');
                SalesLine.RESET
              END ELSE BEGIN
                Rec := xRec;
                EXIT;
              END;
            END;

            IF ("Document Type" = "Document Type"::Order) AND
               (xRec."Sell-to Customer No." <> "Sell-to Customer No.")
            THEN BEGIN
              SalesLine.SETRANGE("Document Type",SalesLine."Document Type"::Order);
              SalesLine.SETRANGE("Document No.","No.");
              SalesLine.SETFILTER("Purch. Order Line No.",'<>0');
              IF NOT SalesLine.ISEMPTY THEN
                ERROR(
                  Text006,
                  FIELDCAPTION("Sell-to Customer No."));
              SalesLine.RESET;
            END;

            GetCust("Sell-to Customer No.");

            Cust.CheckBlockedCustOnDocs(Cust,"Document Type",FALSE,FALSE);
            Cust.TESTFIELD("Gen. Bus. Posting Group");
            "Sell-to Customer Template Code" := '';
            "Sell-to Customer Name" := Cust.Name;
            "Sell-to Customer Name 2" := Cust."Name 2";
            "Sell-to Address" := Cust.Address;
            "Sell-to Address 2" := Cust."Address 2";
            "Sell-to City" := Cust.City;
            "Sell-to Post Code" := Cust."Post Code";
            "Sell-to County" := Cust.County;
            "Sell-to Country/Region Code" := Cust."Country/Region Code";
            IF NOT SkipSellToContact THEN
              "Sell-to Contact" := Cust.Contact;
            "Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
            "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
            "Tax Area Code" := Cust."Tax Area Code";
            "Tax Liable" := Cust."Tax Liable";
            "VAT Registration No." := Cust."VAT Registration No.";
            "VAT Country/Region Code" := Cust."Country/Region Code";
            "Shipping Advice" := Cust."Shipping Advice";
            "Responsibility Center" := UserSetupMgt.GetRespCenter(0,Cust."Responsibility Center");
            VALIDATE("Location Code",UserSetupMgt.GetLocation(0,Cust."Location Code","Responsibility Center"));

            IF "Sell-to Customer No." = xRec."Sell-to Customer No." THEN BEGIN
              IF ShippedSalesLinesExist OR ReturnReceiptExist THEN BEGIN
                TESTFIELD("VAT Bus. Posting Group",xRec."VAT Bus. Posting Group");
                TESTFIELD("Gen. Bus. Posting Group",xRec."Gen. Bus. Posting Group");
              END;
            END;

            "Sell-to IC Partner Code" := Cust."IC Partner Code";
            "Send IC Document" := ("Sell-to IC Partner Code" <> '') AND ("IC Direction" = "IC Direction"::Outgoing);

            IF Cust."Bill-to Customer No." <> '' THEN
              VALIDATE("Bill-to Customer No.",Cust."Bill-to Customer No.")
            ELSE BEGIN
              IF "Bill-to Customer No." = "Sell-to Customer No." THEN
                SkipBillToContact := TRUE;
              VALIDATE("Bill-to Customer No.","Sell-to Customer No.");
              SkipBillToContact := FALSE;
            END;
            VALIDATE("Ship-to Code",'');

            GetShippingTime(FIELDNO("Sell-to Customer No."));

            IF (xRec."Sell-to Customer No." <> "Sell-to Customer No.") OR
               (xRec."Currency Code" <> "Currency Code") OR
               (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group") OR
               (xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group")
            THEN
              RecreateSalesLines(FIELDCAPTION("Sell-to Customer No."));

            IF NOT SkipSellToContact THEN
              UpdateSellToCont("Sell-to Customer No.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CheckCreditLimitIfLineNotInsertedYet;
            IF "No." = '' THEN
              InitRecord;
            #1..14
                Confirmed := CONFIRM(ConfirmChangeQst,FALSE,SellToCustomerTxt);
            #16..27
                  InitNoSeries;
                  EXIT;
                END;

                CheckShipmentInfo(SalesLine,FALSE);
                CheckPrepmtInfo(SalesLine);
                CheckReturnInfo(SalesLine,FALSE);

                SalesLine.RESET;
            #87..92
            //>>MIGRATION NAV 2013
            //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Post_It] Affiche les textes de type postit
            //IF NOT HideValidationDialog THEN
            IF CurrFieldNo <> 0 THEN
             IF RecGParamNavi.FIND THEN BEGIN
              IF RecGParamNavi."Used Post-it"<>'' THEN BEGIN
               RecGCommentLine.SETRANGE(Code,RecGParamNavi."Used Post-it");
               RecGCommentLine.SETRANGE("No.","Sell-to Customer No.");
               IF RecGCommentLine.FIND('-') THEN  BEGIN
                FrmGLignesCommentaires.EDITABLE(FALSE);
                FrmGLignesCommentaires.CAPTION('Post-it');
                FrmGLignesCommentaires.SETTABLEVIEW(RecGCommentLine);
                IF FrmGLignesCommentaires.RUNMODAL = ACTION::OK THEN;
               END;
              END;
             RecGCommentLine.SETRANGE(Code,'');
             END;
            //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Post_It] Affiche les textes de type postit
            //<<MIGRATION NAV 2013

            #93..112
            CopySellToCustomerAddressFieldsFromCustomer(Cust);
            //>>MIGRATION NAV 2013
            //>>FE018
            "Combine Shipments by Order" := Cust."Combine Shipments by Order";
            //>>FE018

            //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout code pr récupérer Tiers payeur
            "Pay-to Customer No.":=Cust."Pay-to Customer No.";
            //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout code pr récupérer Tiers payeur
            //<<MIGARTION NAV 2013

            //>> CNE6.01
            CASE "Document Type" OF
              "Document Type"::Quote,"Document Type"::Order:
                "Copy Sell-to Address" := Cust."Copy Sell-to Address";
            END;

            #119..130
            IF "Sell-to Customer No." = xRec."Sell-to Customer No." THEN
            #132..135
            #137..157
              RecreateSalesLines(SellToCustomerTxt);
            #159..161

            //>>MIGRATION NAV 2013
            //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Mise à jour Codes INCOTERM Onglet "INTERNATIONAL"
            UpdateIncoterm;
            //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Mise à jour Codes INCOTERM Onglet "INTERNATIONAL"
            //>>FE015
            // verifyquotestatus  ;
            //<<FE015

            //>>TODOLIST point 65
            IF "Document Type" IN ["Document Type"::Order , "Document Type"::Invoice, "Document Type"::"Credit Memo"] THEN
              "Posting Description" := COPYSTR(FORMAT("Sell-to Customer Name") + ' : ' + FORMAT("Document Type") + ' ' + "No."
                                         , 1, MAXSTRLEN("Posting Description"));
            //<<TODOLIST point 65
            //<<MIGRATION NAV 2013
            */
        //end;


        //Unsupported feature: Code Modification on ""Bill-to Customer No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            BilltoCustomerNoChanged := xRec."Bill-to Customer No." <> "Bill-to Customer No.";
            IF BilltoCustomerNoChanged AND
               (xRec."Bill-to Customer No." <> '')
            THEN BEGIN
              VALIDATE("Credit Card No.",'');
              IF HideValidationDialog OR NOT GUIALLOWED THEN
                Confirmed := TRUE
              ELSE
                Confirmed := CONFIRM(Text004,FALSE,FIELDCAPTION("Bill-to Customer No."));
              IF Confirmed THEN BEGIN
                SalesLine.SETRANGE("Document Type","Document Type");
                SalesLine.SETRANGE("Document No.","No.");
                IF "Document Type" = "Document Type"::Order THEN
                  SalesLine.SETFILTER("Quantity Shipped",'<>0')
                ELSE
                  IF "Document Type" = "Document Type"::Invoice THEN
                    SalesLine.SETFILTER("Shipment No.",'<>%1','');

                IF SalesLine.FINDFIRST THEN
                  IF "Document Type" = "Document Type"::Order THEN
                    SalesLine.TESTFIELD("Quantity Shipped",0)
                  ELSE
                    SalesLine.TESTFIELD("Shipment No.",'');
                SalesLine.SETRANGE("Shipment No.");
                SalesLine.SETRANGE("Quantity Shipped");

                IF "Document Type" = "Document Type"::Order THEN BEGIN
                  SalesLine.SETFILTER("Prepmt. Amt. Inv.",'<>0');
                  IF SalesLine.FIND('-') THEN
                    SalesLine.TESTFIELD("Prepmt. Amt. Inv.",0);
                  SalesLine.SETRANGE("Prepmt. Amt. Inv.");
                END;

                IF "Document Type" = "Document Type"::"Return Order" THEN
                  SalesLine.SETFILTER("Return Qty. Received",'<>0')
                ELSE
                  IF "Document Type" = "Document Type"::"Credit Memo" THEN
                    SalesLine.SETFILTER("Return Receipt No.",'<>%1','');

                IF SalesLine.FINDFIRST THEN
                  IF "Document Type" = "Document Type"::"Return Order" THEN
                    SalesLine.TESTFIELD("Return Qty. Received",0)
                  ELSE
                    SalesLine.TESTFIELD("Return Receipt No.",'');
                SalesLine.RESET
              END ELSE
                "Bill-to Customer No." := xRec."Bill-to Customer No.";
            END;

            GetCust("Bill-to Customer No.");
            Cust.CheckBlockedCustOnDocs(Cust,"Document Type",FALSE,FALSE);
            Cust.TESTFIELD("Customer Posting Group");
            CheckCrLimit;
            "Bill-to Customer Template Code" := '';
            "Bill-to Name" := Cust.Name;
            "Bill-to Name 2" := Cust."Name 2";
            "Bill-to Address" := Cust.Address;
            "Bill-to Address 2" := Cust."Address 2";
            "Bill-to City" := Cust.City;
            "Bill-to Post Code" := Cust."Post Code";
            "Bill-to County" := Cust.County;
            "Bill-to Country/Region Code" := Cust."Country/Region Code";
            IF NOT SkipBillToContact THEN
              "Bill-to Contact" := Cust.Contact;
            "Payment Terms Code" := Cust."Payment Terms Code";
            "Prepmt. Payment Terms Code" := Cust."Payment Terms Code";

            IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
              "Payment Method Code" := '';
              IF PaymentTerms.GET("Payment Terms Code") THEN
                IF PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" THEN
                  "Payment Method Code" := Cust."Payment Method Code"
            END ELSE
              "Payment Method Code" := Cust."Payment Method Code";

            GLSetup.GET;
            IF GLSetup."Bill-to/Sell-to VAT Calc." = GLSetup."Bill-to/Sell-to VAT Calc."::"Bill-to/Pay-to No." THEN BEGIN
              "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
              "VAT Country/Region Code" := Cust."Country/Region Code";
              "VAT Registration No." := Cust."VAT Registration No.";
              "Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
            END;
            "Customer Posting Group" := Cust."Customer Posting Group";
            "Currency Code" := Cust."Currency Code";
            "Customer Price Group" := Cust."Customer Price Group";
            "Prices Including VAT" := Cust."Prices Including VAT";
            "Allow Line Disc." := Cust."Allow Line Disc.";
            "Invoice Disc. Code" := Cust."Invoice Disc. Code";
            "Customer Disc. Group" := Cust."Customer Disc. Group";
            "Language Code" := Cust."Language Code";
            "Salesperson Code" := Cust."Salesperson Code";
            "Combine Shipments" := Cust."Combine Shipments";
            Reserve := Cust.Reserve;
            IF "Document Type" = "Document Type"::Order THEN
              "Prepayment %" := Cust."Prepayment %";

            IF NOT BilltoCustomerNoChanged THEN BEGIN
              IF ShippedSalesLinesExist THEN BEGIN
                TESTFIELD("Customer Disc. Group",xRec."Customer Disc. Group");
                TESTFIELD("Currency Code",xRec."Currency Code");
              END;
            END;

            CreateDim(
              DATABASE::Customer,"Bill-to Customer No.",
              DATABASE::"Salesperson/Purchaser","Salesperson Code",
              DATABASE::Campaign,"Campaign No.",
              DATABASE::"Responsibility Center","Responsibility Center",
              DATABASE::"Customer Template","Bill-to Customer Template Code");

            VALIDATE("Payment Terms Code");
            VALIDATE("Prepmt. Payment Terms Code");
            VALIDATE("Payment Method Code");
            VALIDATE("Currency Code");
            VALIDATE("Prepayment %");

            IF (xRec."Sell-to Customer No." = "Sell-to Customer No.") AND
               BilltoCustomerNoChanged
            THEN BEGIN
              RecreateSalesLines(FIELDCAPTION("Bill-to Customer No."));
              BilltoCustomerNoChanged := FALSE;
            END;
            IF NOT SkipBillToContact THEN
              UpdateBillToCont("Bill-to Customer No.");

            "Bill-to IC Partner Code" := Cust."IC Partner Code";
            "Send IC Document" := ("Bill-to IC Partner Code" <> '') AND ("IC Direction" = "IC Direction"::Outgoing);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);


            //BC6 18/04/18
            #51..54
            //BC6 18/04/18

            BilltoCustomerNoChanged := xRec."Bill-to Customer No." <> "Bill-to Customer No.";
            IF BilltoCustomerNoChanged THEN
              IF xRec."Bill-to Customer No." = '' THEN
                InitRecord
              ELSE BEGIN
                IF HideValidationDialog OR NOT GUIALLOWED THEN
                  Confirmed := TRUE
                ELSE
                  Confirmed := CONFIRM(ConfirmChangeQst,FALSE,BillToCustomerTxt);
                IF Confirmed THEN BEGIN
                  SalesLine.SETRANGE("Document Type","Document Type");
                  SalesLine.SETRANGE("Document No.","No.");

                  CheckShipmentInfo(SalesLine,TRUE);
                  CheckPrepmtInfo(SalesLine);
                  CheckReturnInfo(SalesLine,TRUE);

                  SalesLine.RESET;
                END ELSE
                  "Bill-to Customer No." := xRec."Bill-to Customer No.";
              END;


            //BC6 18/04/18 code moved above
            // GetCust("Bill-to Customer No.");
            // Cust.CheckBlockedCustOnDocs(Cust,"Document Type",FALSE,FALSE);
            // Cust.TESTFIELD("Customer Posting Group");
            // CheckCrLimit;
            //BC6 18/04/18 code moved above

            #55..57
            CopyBillToCustomerAddressFieldsFromCustomer(Cust);
            #64..92
            //>>P24233_001 SOBI APA 02/02/17
            "Salesperson Filter" := Cust."Salesperson Filter";
            //<<P24233_001 SOBI APA 02/02/17

            "Combine Shipments" := Cust."Combine Shipments";
            Reserve := Cust.Reserve;

            //>>MIGRATION NAV 2013
            //GRPMARGEVENTE SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ 50020  et ramener 50020 de la fiche client
            "Customer Sales Profit Group" := Cust."Customer Sales Profit Group";
            //FIN GRPMARGEVENTE SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ 50020  et ramener 50020 de la fiche client
            //<<MIGRATION NAV 2013

            #95..120
              RecreateSalesLines(BillToCustomerTxt);
            #122..128
            */
        //end;


        //Unsupported feature: Code Insertion on ""Bill-to Name"(Field 5)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //var
            //Customer: Record "18";
        //begin
            /*
            //BC6>>
            IF xRec."Bill-to Customer No." = '' THEN
            //BC6<<
            VALIDATE("Bill-to Customer No.",Customer.GetCustNo("Bill-to Name"));
            */
        //end;


        //Unsupported feature: Code Insertion on ""Bill-to Contact"(Field 10)".

        //trigger OnLookup(var Text: Text): Boolean
        //var
            //Contact: Record "5050";
        //begin
            /*
            LookupContact("Bill-to Customer No.","Bill-to Contact No.",Contact);
            IF PAGE.RUNMODAL(0,Contact) = ACTION::LookupOK THEN
              VALIDATE("Bill-to Contact No.",Contact."No.");
            */
        //end;


        //Unsupported feature: Code Insertion on ""Your Reference"(Field 11)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            //BC6 EABO 11/04/18 >>
            UpdateSalesShipment.UpdateYourRefOnSalesShpt(Rec);
            //BC6 EABO 11/04/18 <<
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Ship-to Code"(Field 12).OnValidate".

        //trigger (Variable: ShipToAddr)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Ship-to Code"(Field 12).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ("Document Type" = "Document Type"::Order) AND
               (xRec."Ship-to Code" <> "Ship-to Code")
            THEN BEGIN
            #4..10
              SalesLine.RESET;
            END;

            IF ("Document Type" <> "Document Type"::"Return Order") AND
               ("Document Type" <> "Document Type"::"Credit Memo")
            THEN BEGIN
              IF "Ship-to Code" <> '' THEN BEGIN
                IF xRec."Ship-to Code" <> '' THEN
                  BEGIN
            #20..44
                  GetCust("Sell-to Customer No.");
                  "Ship-to Name" := Cust.Name;
                  "Ship-to Name 2" := Cust."Name 2";
                  "Ship-to Address" := Cust.Address;
                  "Ship-to Address 2" := Cust."Address 2";
                  "Ship-to City" := Cust.City;
                  "Ship-to Post Code" := Cust."Post Code";
                  "Ship-to County" := Cust.County;
                  VALIDATE("Ship-to Country/Region Code",Cust."Country/Region Code");
                  "Ship-to Contact" := Cust.Contact;
                  "Shipment Method Code" := Cust."Shipment Method Code";
                  "Tax Area Code" := Cust."Tax Area Code";
            #57..59
                  "Shipping Agent Code" := Cust."Shipping Agent Code";
                  "Shipping Agent Service Code" := Cust."Shipping Agent Service Code";
                END;
            END;

            GetShippingTime(FIELDNO("Ship-to Code"));

            #67..78
                IF xRec."Tax Liable" <> "Tax Liable" THEN
                  VALIDATE("Tax Liable");
              END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..13
            IF NOT IsCreditDocType THEN
            #17..47
                  CopyShipToCustomerAddressFieldsFromCustomer(Cust);
            #54..62
            #64..81
            */
        //end;


        //Unsupported feature: Code Modification on ""Posting Date"(Field 20).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TestNoSeriesDate(
              "Posting No.","Posting No. Series",
              FIELDCAPTION("Posting No."),FIELDCAPTION("Posting No. Series"));
            #4..7
              "Prepmt. Cr. Memo No.","Prepmt. Cr. Memo No. Series",
              FIELDCAPTION("Prepmt. Cr. Memo No."),FIELDCAPTION("Prepmt. Cr. Memo No. Series"));

            VALIDATE("Document Date","Posting Date");

            IF ("Document Type" IN ["Document Type"::Invoice,"Document Type"::"Credit Memo"]) AND
               NOT ("Posting Date" = xRec."Posting Date")
            #15..20
                ConfirmUpdateCurrencyFactor;
            END;

            SynchronizeAsmHeader;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..10
            IF "Incoming Document Entry No." = 0 THEN
              VALIDATE("Document Date","Posting Date");
            #12..23
            IF "Posting Date" <> xRec."Posting Date" THEN
              IF DeferralHeadersExist THEN
                ConfirmUpdateDeferralDate;
            SynchronizeAsmHeader;
            */
        //end;


        //Unsupported feature: Code Modification on ""Payment Terms Code"(Field 23).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ("Payment Terms Code" <> '') AND ("Document Date" <> 0D) THEN BEGIN
              PaymentTerms.GET("Payment Terms Code");
              IF (("Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"]) AND
                  NOT PaymentTerms."Calc. Pmt. Disc. on Cr. Memos")
              THEN BEGIN
                VALIDATE("Due Date","Document Date");
                VALIDATE("Pmt. Discount Date",0D);
                VALIDATE("Payment Discount %",0);
            #9..23
                "Prepayment Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Document Date");
              VALIDATE("Prepmt. Payment Terms Code","Payment Terms Code");
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF ("Payment Terms Code" <> '') AND ("Document Date" <> 0D) THEN BEGIN
              PaymentTerms.GET("Payment Terms Code");
              IF IsCreditDocType AND NOT PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" THEN BEGIN
            #6..26
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Shipment Method Code"(Field 27).OnValidate".

        //trigger (Variable: WMSManagement)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Shipment Method Code"(Field 27).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            //>>MIGRATION NAV 2013
            IF ShipmentMethodRec.GET("Shipment Method Code") THEN
              IF ShipmentMethodRec."To Make Available" THEN
                BEGIN
                  IF (Bin.GET("Location Code","Bin Code") AND
                     NOT (Bin."To Make Available")) OR ("Bin Code" = '') THEN
                       BEGIN
                         WMSManagement.GetShipmentBin("Location Code",BinCode);
                         IF "Bin Code" <> BinCode THEN
                           VALIDATE("Bin Code",BinCode);
                       END ELSE BEGIN
                END;
            END;

            //<<MIGRATION NAV 2013
            */
        //end;


        //Unsupported feature: Code Modification on ""Location Code"(Field 28).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            IF ("Location Code" <> xRec."Location Code") AND
               (xRec."Sell-to Customer No." = "Sell-to Customer No.")
            THEN
              MessageIfSalesLinesExist(FIELDCAPTION("Location Code"));

            UpdateShipToAddress;

            IF "Location Code" <> '' THEN BEGIN
              IF Location.GET("Location Code") THEN
                "Outbound Whse. Handling Time" := Location."Outbound Whse. Handling Time";
            END ELSE BEGIN
              IF InvtSetup.GET THEN
                "Outbound Whse. Handling Time" := InvtSetup."Outbound Whse. Handling Time";
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..7
            UpdateOutboundWhseHandlingTime;
            */
        //end;


        //Unsupported feature: Code Modification on ""Currency Code"(Field 32).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF NOT (CurrFieldNo IN [0,FIELDNO("Posting Date")]) OR ("Currency Code" <> xRec."Currency Code") THEN
              TESTFIELD(Status,Status::Open);
            IF DOPaymentTransLogEntry.FINDFIRST THEN
              DOPaymentTransLogMgt.ValidateHasNoValidTransactions("Document Type",FORMAT("Document Type"),"No.");
            IF (CurrFieldNo <> FIELDNO("Currency Code")) AND ("Currency Code" = xRec."Currency Code") THEN
              UpdateCurrencyFactor
            ELSE BEGIN
              IF "Currency Code" <> xRec."Currency Code" THEN BEGIN
                UpdateCurrencyFactor;
                RecreateSalesLines(FIELDCAPTION("Currency Code"));
            #11..13
                  IF "Currency Factor" <> xRec."Currency Factor" THEN
                    ConfirmUpdateCurrencyFactor;
                END;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF NOT (CurrFieldNo IN [0,FIELDNO("Posting Date")]) OR ("Currency Code" <> xRec."Currency Code") THEN
              TESTFIELD(Status,Status::Open);
            IF (CurrFieldNo <> FIELDNO("Currency Code")) AND ("Currency Code" = xRec."Currency Code") THEN
              UpdateCurrencyFactor
            ELSE
            #8..16

            //>>MIGRATION NAV 2013
            //>>COUT_ACHAT
            IF "Currency Code" <> '' THEN
              MESSAGE(TextG001);
            //<<COUT_ACHAT
            //<<MIGRATION NAV 2013
            */
        //end;


        //Unsupported feature: Code Modification on ""Prices Including VAT"(Field 35).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);

            IF "Prices Including VAT" <> xRec."Prices Including VAT" THEN BEGIN
            #4..22
                    TRUE);
                SalesLine.SetSalesHeader(Rec);

                IF "Currency Code" = '' THEN
                  Currency.InitRoundingPrecision
                ELSE
            #29..34
                  SalesLine.TESTFIELD("Prepmt. Amt. Inv.",0);
                  IF NOT RecalculatePrice THEN BEGIN
                    SalesLine."VAT Difference" := 0;
                    SalesLine.InitOutstandingAmount;
                  END ELSE
                    IF "Prices Including VAT" THEN BEGIN
                      SalesLine."Unit Price" :=
            #42..71
                UNTIL SalesLine.NEXT = 0;
              END;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..25
                IF RecalculatePrice AND "Prices Including VAT" THEN
                  SalesLine.MODIFYALL(Amount,0,TRUE);

            #26..37
                    SalesLine.UpdateAmounts;
            #39..74
            */
        //end;


        //Unsupported feature: Code Modification on ""Salesperson Code"(Field 43).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ApprovalEntry.SETRANGE("Table ID",DATABASE::"Sales Header");
            ApprovalEntry.SETRANGE("Document Type","Document Type");
            ApprovalEntry.SETRANGE("Document No.","No.");
            ApprovalEntry.SETFILTER(Status,'<>%1&<>%2',ApprovalEntry.Status::Canceled,ApprovalEntry.Status::Rejected);
            IF NOT ApprovalEntry.ISEMPTY THEN
              ERROR(Text053,FIELDCAPTION("Salesperson Code"));

            #8..10
              DATABASE::Campaign,"Campaign No.",
              DATABASE::"Responsibility Center","Responsibility Center",
              DATABASE::"Customer Template","Bill-to Customer Template Code");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
            ApprovalEntry.SETFILTER(Status,'%1|%2',ApprovalEntry.Status::Created,ApprovalEntry.Status::Open);
            #5..13
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Applies-to Doc. No."(Field 53).OnLookup".

        //trigger (Variable: GenJnlLine)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Applies-to Doc. No."(Field 53).OnLookup".

        //trigger  No()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Bal. Account No.",'');
            CustLedgEntry.SETCURRENTKEY("Customer No.",Open,Positive,"Due Date");
            CustLedgEntry.SETRANGE("Customer No.","Bill-to Customer No.");
            #4..26
            IF ApplyCustEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
              ApplyCustEntries.GetCustLedgEntry(CustLedgEntry);
              GenJnlApply.CheckAgainstApplnCurrency(
                "Currency Code",CustLedgEntry."Currency Code",GenJnILine."Account Type"::Customer,TRUE);
              "Applies-to Doc. Type" := CustLedgEntry."Document Type";
              "Applies-to Doc. No." := CustLedgEntry."Document No.";
            END;
            CLEAR(ApplyCustEntries);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..29
                "Currency Code",CustLedgEntry."Currency Code",GenJnlLine."Account Type"::Customer,TRUE);
            #31..34
            */
        //end;


        //Unsupported feature: Code Insertion on ""Reason Code"(Field 73)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //var
            //RecLReasonCode: Record "231";
            //RecLSalesLine: Record "37";
        //begin
            /*
            //>>MIGRATION NAV 2013

            //>>DEEE1.00 : Update DEEE details on sales lines
            IF xRec."Reason Code" <> Rec."Reason Code" THEN BEGIN
              RecLSalesLine.SETRANGE("Document Type","Document Type") ;
              RecLSalesLine.SETRANGE("Document No.","No.") ;
              IF RecLSalesLine.FIND('-') THEN
                REPEAT
                  RecLSalesLine."DEEE Category Code":=RecLSalesLine."DEEE Category Code";
                  RecLSalesLine.CalculateDEEE(Rec."Reason Code") ;
                  RecLSalesLine.MODIFY;
                UNTIL RecLSalesLine.NEXT=0 ;
            END ;
            //<<DEEE1.00 : Update DEEE details on sales lines
            //<<MIGRATION NAV 2013
            */
        //end;


        //Unsupported feature: Code Modification on ""Gen. Bus. Posting Group"(Field 74).OnValidate".

        //trigger  Bus()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            IF xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" THEN
              IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") THEN BEGIN
                "VAT Bus. Posting Group" := GenBusPostingGrp."Def. VAT Bus. Posting Group";
                RecreateSalesLines(FIELDCAPTION("Gen. Bus. Posting Group"));
              END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            IF xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" THEN BEGIN
              IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") THEN
                "VAT Bus. Posting Group" := GenBusPostingGrp."Def. VAT Bus. Posting Group";
              RecreateSalesLines(FIELDCAPTION("Gen. Bus. Posting Group"));
            END;
            */
        //end;


        //Unsupported feature: Code Insertion on ""Sell-to Customer Name"(Field 79)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //var
            //Customer: Record "18";
        //begin
            /*
            //BC6>>
            IF xRec."Sell-to Customer Name" = '' THEN
            //BC6<<
            VALIDATE("Sell-to Customer No.",Customer.GetCustNo("Sell-to Customer Name"));
            GetShippingTime(FIELDNO("Sell-to Customer Name"));
            //>> CNE6.01
            CopySellToAddress(CurrFieldNo);
            */
        //end;


        //Unsupported feature: Code Insertion on ""Sell-to Customer Name 2"(Field 80)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            //>> CNE6.01
            CopySellToAddress(CurrFieldNo);
            */
        //end;


        //Unsupported feature: Code Insertion on ""Sell-to Address"(Field 81)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            UpdateShipToAddressFromSellToAddress(FIELDNO("Ship-to Address"));
            //>> CNE6.01
            CopySellToAddress(CurrFieldNo);
            */
        //end;


        //Unsupported feature: Code Insertion on ""Sell-to Address 2"(Field 82)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            UpdateShipToAddressFromSellToAddress(FIELDNO("Ship-to Address 2"));
            //>> CNE6.01
            CopySellToAddress(CurrFieldNo);
            */
        //end;


        //Unsupported feature: Code Modification on ""Sell-to City"(Field 83).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            PostCode.ValidateCity(
              "Sell-to City","Sell-to Post Code","Sell-to County","Sell-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            PostCode.ValidateCity(
              "Sell-to City","Sell-to Post Code","Sell-to County","Sell-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            UpdateShipToAddressFromSellToAddress(FIELDNO("Ship-to City"));
            //>> CNE6.01
            CopySellToAddress(CurrFieldNo);
            */
        //end;


        //Unsupported feature: Code Insertion on ""Sell-to Contact"(Field 84)".

        //trigger OnLookup(var Text: Text): Boolean
        //var
            //Contact: Record "5050";
        //begin
            /*
            LookupContact("Sell-to Customer No.","Sell-to Contact No.",Contact);
            IF PAGE.RUNMODAL(0,Contact) = ACTION::LookupOK THEN
              VALIDATE("Sell-to Contact No.",Contact."No.");
            */
        //end;


        //Unsupported feature: Code Insertion on ""Sell-to Contact"(Field 84)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //var
            //RecLContact: Record "5050";
        //begin
            /*
            //>> CNE6.01
            CopySellToAddress(CurrFieldNo);
            */
        //end;


        //Unsupported feature: Code Modification on ""Sell-to Post Code"(Field 88).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            PostCode.ValidatePostCode(
              "Sell-to City","Sell-to Post Code","Sell-to County","Sell-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            PostCode.ValidatePostCode(
              "Sell-to City","Sell-to Post Code","Sell-to County","Sell-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            UpdateShipToAddressFromSellToAddress(FIELDNO("Ship-to Post Code"));
            //>> CNE6.01
            CopySellToAddress(CurrFieldNo);
            */
        //end;


        //Unsupported feature: Code Insertion on ""Sell-to County"(Field 89)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            UpdateShipToAddressFromSellToAddress(FIELDNO("Ship-to County"));
            //>> CNE6.01
            CopySellToAddress(CurrFieldNo);
            */
        //end;


        //Unsupported feature: Code Insertion on ""Sell-to Country/Region Code"(Field 90)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            UpdateShipToAddressFromSellToAddress(FIELDNO("Ship-to Country/Region Code"));
            //>> CNE6.01
            CopySellToAddress(CurrFieldNo);
            */
        //end;


        //Unsupported feature: Code Modification on ""Payment Method Code"(Field 104).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF DOPaymentTransLogEntry.FINDFIRST THEN
              DOPaymentTransLogMgt.ValidateHasNoValidTransactions("Document Type",FORMAT("Document Type"),"No.");
            IF DOPaymentMgt.IsValidPaymentMethod(xRec."Payment Method Code") AND NOT DOPaymentMgt.IsValidPaymentMethod("Payment Method Code")
            THEN
              TESTFIELD("Credit Card No.",'');
            PaymentMethod.INIT;
            IF "Payment Method Code" <> '' THEN
              PaymentMethod.GET("Payment Method Code");
            IF PaymentMethod."Direct Debit" THEN BEGIN
              IF "Direct Debit Mandate ID" = '' THEN
                "Direct Debit Mandate ID" := SEPADirectDebitMandate.GetDefaultMandate("Bill-to Customer No.","Due Date");
              IF "Payment Terms Code" = '' THEN
                "Payment Terms Code" := PaymentMethod."Direct Debit Pmt. Terms Code";
            END;
            "Bal. Account Type" := PaymentMethod."Bal. Account Type";
            "Bal. Account No." := PaymentMethod."Bal. Account No.";
            IF "Bal. Account No." <> '' THEN BEGIN
              TESTFIELD("Applies-to Doc. No.",'');
              TESTFIELD("Applies-to ID",'');
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #6..9
              "Direct Debit Mandate ID" := SEPADirectDebitMandate.GetDefaultMandate("Bill-to Customer No.","Due Date");
              IF "Payment Terms Code" = '' THEN
                "Payment Terms Code" := PaymentMethod."Direct Debit Pmt. Terms Code";
            END ELSE
              "Direct Debit Mandate ID" := '';
            #15..19
              CLEAR("Payment Service Set ID");
            END;
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Shipping Agent Code"(Field 105).OnValidate".

        //trigger (Variable: BoolReclose)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Shipping Agent Code"(Field 105).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            IF xRec."Shipping Agent Code" = "Shipping Agent Code" THEN
              EXIT;

            "Shipping Agent Service Code" := '';
            GetShippingTime(FIELDNO("Shipping Agent Code"));
            UpdateSalesLines(FIELDCAPTION("Shipping Agent Code"),CurrFieldNo <> 0);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            //>>MIGRATION NAV 2013
            //>>TODOLIST POINT 40  FLGR 26/01/2007
            IF (Status <> Status::Open) AND (xRec."Shipping Agent Code" <> "Shipping Agent Code")
              AND ("Document Type" = "Document Type"::Order)
            THEN BEGIN
              CDUReleaseDoc.Reopen(Rec);
              BoolReclose := TRUE;
            END;
            //<<TODOLIST POINT 40  FLGR 26/01/2007
            //<<MIGRATION NAV 2013

            #1..7
            //>>MIGRATION NAV 2013
            //>>TODOLIST POINT 40  FLGR 26/01/2007
            IF BoolReclose THEN BEGIN
              CDUReleaseDoc.RUN(Rec);
              BoolReclose := FALSE;
            END;
            //<<TODOLIST POINT 40  FLGR 26/01/2007
            //<<MIGRATION NAV 2013
            */
        //end;


        //Unsupported feature: Code Modification on ""Tax Area Code"(Field 114).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            MessageIfSalesLinesExist(FIELDCAPTION("Tax Area Code"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            ValidateTaxAreaCode;
            MessageIfSalesLinesExist(FIELDCAPTION("Tax Area Code"));
            */
        //end;


        //Unsupported feature: Code Modification on ""Prepmt. Payment Terms Code"(Field 139).OnValidate".

        //trigger  Payment Terms Code"(Field 139)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ("Prepmt. Payment Terms Code" <> '') AND ("Document Date" <> 0D) THEN BEGIN
              PaymentTerms.GET("Prepmt. Payment Terms Code");
              IF (("Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"]) AND
                  NOT PaymentTerms."Calc. Pmt. Disc. on Cr. Memos")
              THEN BEGIN
                VALIDATE("Prepayment Due Date","Document Date");
                VALIDATE("Prepmt. Pmt. Discount Date",0D);
                VALIDATE("Prepmt. Payment Discount %",0);
            #9..18
                VALIDATE("Prepmt. Payment Discount %",0);
              END;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF ("Prepmt. Payment Terms Code" <> '') AND ("Document Date" <> 0D) THEN BEGIN
              PaymentTerms.GET("Prepmt. Payment Terms Code");
              IF IsCreditDocType AND NOT PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" THEN BEGIN
            #6..21
            */
        //end;


        //Unsupported feature: Code Modification on ""Incoming Document Entry No."(Field 165).OnValidate".

        //trigger "(Field 165)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IncomingDocument.SetSalesDoc(Rec);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF "Incoming Document Entry No." = xRec."Incoming Document Entry No." THEN
              EXIT;
            IF "Incoming Document Entry No." = 0 THEN
              IncomingDocument.RemoveReferenceToWorkingDocument(xRec."Incoming Document Entry No.")
            ELSE
              IncomingDocument.SetSalesDoc(Rec);
            */
        //end;


        //Unsupported feature: Code Insertion on ""Dimension Set ID"(Field 480)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
            */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on ""Authorization Required"(Field 825)".


        //Unsupported feature: Deletion (FieldCollection) on ""Credit Card No."(Field 827)".


        //Unsupported feature: Deletion on ""Direct Debit Mandate ID"(Field 1200).OnLookup".



        //Unsupported feature: Code Modification on ""Sell-to Customer Template Code"(Field 5051).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Document Type","Document Type"::Quote);
            TESTFIELD(Status,Status::Open);

            IF NOT InsertMode AND
               ("Sell-to Customer Template Code" <> xRec."Sell-to Customer Template Code") AND
               (xRec."Sell-to Customer Template Code" <> '')
            THEN BEGIN
              IF HideValidationDialog THEN
                Confirmed := TRUE
              ELSE
                Confirmed := CONFIRM(Text004,FALSE,FIELDCAPTION("Sell-to Customer Template Code"));
              IF Confirmed THEN BEGIN
                SalesLine.RESET;
                SalesLine.SETRANGE("Document Type","Document Type");
                SalesLine.SETRANGE("Document No.","No.");
                IF "Sell-to Customer Template Code" = '' THEN BEGIN
                  IF NOT SalesLine.ISEMPTY THEN
                    ERROR(Text005,FIELDCAPTION("Sell-to Customer Template Code"));
                  INIT;
                  SalesSetup.GET;
                  InitRecord;
                  "No. Series" := xRec."No. Series";
                  IF xRec."Shipping No." <> '' THEN BEGIN
                    "Shipping No. Series" := xRec."Shipping No. Series";
                    "Shipping No." := xRec."Shipping No.";
                  END;
                  IF xRec."Posting No." <> '' THEN BEGIN
                    "Posting No. Series" := xRec."Posting No. Series";
                    "Posting No." := xRec."Posting No.";
                  END;
                  IF xRec."Return Receipt No." <> '' THEN BEGIN
                    "Return Receipt No. Series" := xRec."Return Receipt No. Series";
                    "Return Receipt No." := xRec."Return Receipt No.";
                  END;
                  IF xRec."Prepayment No." <> '' THEN BEGIN
                    "Prepayment No. Series" := xRec."Prepayment No. Series";
                    "Prepayment No." := xRec."Prepayment No.";
                  END;
                  IF xRec."Prepmt. Cr. Memo No." <> '' THEN BEGIN
                    "Prepmt. Cr. Memo No. Series" := xRec."Prepmt. Cr. Memo No. Series";
                    "Prepmt. Cr. Memo No." := xRec."Prepmt. Cr. Memo No.";
                  END;
                  EXIT;
                END;
              END ELSE BEGIN
                "Sell-to Customer Template Code" := xRec."Sell-to Customer Template Code";
                EXIT;
              END;
            END;

            IF SellToCustTemplate.GET("Sell-to Customer Template Code") THEN BEGIN
              SellToCustTemplate.TESTFIELD("Gen. Bus. Posting Group");
              "Gen. Bus. Posting Group" := SellToCustTemplate."Gen. Bus. Posting Group";
              "VAT Bus. Posting Group" := SellToCustTemplate."VAT Bus. Posting Group";
              IF "Bill-to Customer No." = '' THEN
                VALIDATE("Bill-to Customer Template Code","Sell-to Customer Template Code");
            END;

            IF NOT InsertMode AND
               ((xRec."Sell-to Customer Template Code" <> "Sell-to Customer Template Code") OR
                (xRec."Currency Code" <> "Currency Code"))
            THEN
              RecreateSalesLines(FIELDCAPTION("Sell-to Customer Template Code"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..10
                Confirmed := CONFIRM(ConfirmChangeQst,FALSE,FIELDCAPTION("Sell-to Customer Template Code"));
              IF Confirmed THEN BEGIN
                IF InitFromTemplate("Sell-to Customer Template Code",FIELDCAPTION("Sell-to Customer Template Code")) THEN
                  EXIT
            #45..63
            */
        //end;


        //Unsupported feature: Code Modification on ""Sell-to Contact No."(Field 5052).OnLookup".

        //trigger "(Field 5052)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Sell-to Customer No." <> '' THEN BEGIN
              IF Cont.GET("Sell-to Contact No.") THEN
                Cont.SETRANGE("Company No.",Cont."Company No.")
              ELSE BEGIN
            #5..10
                ELSE
                  Cont.SETRANGE("No.",'');
              END;
            END;

            IF "Sell-to Contact No." <> '' THEN
              IF Cont.GET("Sell-to Contact No.") THEN ;
            IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN BEGIN
              xRec := Rec;
              VALIDATE("Sell-to Contact No.",Cont."No.");
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF "Sell-to Customer No." <> '' THEN
            #2..13
            #15..21
            */
        //end;


        //Unsupported feature: Code Modification on ""Sell-to Contact No."(Field 5052).OnValidate".

        //trigger "(Field 5052)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);

            IF ("Sell-to Contact No." <> xRec."Sell-to Contact No.") AND
               (xRec."Sell-to Contact No." <> '')
            THEN BEGIN
              IF ("Sell-to Contact No." = '') AND ("Opportunity No." <> '') THEN
                ERROR(Text049,FIELDCAPTION("Sell-to Contact No."));
              IF HideValidationDialog OR NOT GUIALLOWED THEN
                Confirmed := TRUE
              ELSE
                Confirmed := CONFIRM(Text004,FALSE,FIELDCAPTION("Sell-to Contact No."));
              IF Confirmed THEN BEGIN
                SalesLine.RESET;
                SalesLine.SETRANGE("Document Type","Document Type");
                SalesLine.SETRANGE("Document No.","No.");
                IF ("Sell-to Contact No." = '') AND ("Sell-to Customer No." = '') THEN BEGIN
                  IF NOT SalesLine.ISEMPTY THEN
                    ERROR(Text005,FIELDCAPTION("Sell-to Contact No."));
                  INIT;
                  SalesSetup.GET;
                  InitRecord;
                  "No. Series" := xRec."No. Series";
                  IF xRec."Shipping No." <> '' THEN BEGIN
                    "Shipping No. Series" := xRec."Shipping No. Series";
                    "Shipping No." := xRec."Shipping No.";
                  END;
                  IF xRec."Posting No." <> '' THEN BEGIN
                    "Posting No. Series" := xRec."Posting No. Series";
                    "Posting No." := xRec."Posting No.";
                  END;
                  IF xRec."Return Receipt No." <> '' THEN BEGIN
                    "Return Receipt No. Series" := xRec."Return Receipt No. Series";
                    "Return Receipt No." := xRec."Return Receipt No.";
                  END;
                  IF xRec."Prepayment No." <> '' THEN BEGIN
                    "Prepayment No. Series" := xRec."Prepayment No. Series";
                    "Prepayment No." := xRec."Prepayment No.";
                  END;
                  IF xRec."Prepmt. Cr. Memo No." <> '' THEN BEGIN
                    "Prepmt. Cr. Memo No. Series" := xRec."Prepmt. Cr. Memo No. Series";
                    "Prepmt. Cr. Memo No." := xRec."Prepmt. Cr. Memo No.";
                  END;
                  EXIT;
                END;
                IF "Opportunity No." <> '' THEN BEGIN
                  Opportunity.GET("Opportunity No.");
                  IF Opportunity."Contact No." <> "Sell-to Contact No." THEN BEGIN
                    MODIFY;
                    Opportunity.VALIDATE("Contact No.","Sell-to Contact No.");
                    Opportunity.MODIFY;
                  END
                END;
              END ELSE BEGIN
                Rec := xRec;
                EXIT;
              END;
            END;

            IF ("Sell-to Customer No." <> '') AND ("Sell-to Contact No." <> '') THEN BEGIN
              Cont.GET("Sell-to Contact No.");
              ContBusinessRelation.RESET;
              ContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
              ContBusinessRelation.SETRANGE("Link to Table",ContBusinessRelation."Link to Table"::Customer);
              ContBusinessRelation.SETRANGE("No.","Sell-to Customer No.");
              IF ContBusinessRelation.FINDFIRST THEN
                IF ContBusinessRelation."Contact No." <> Cont."Company No." THEN
                  ERROR(Text038,Cont."No.",Cont.Name,"Sell-to Customer No.");
            END;

            UpdateSellToCust("Sell-to Contact No.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..10
                Confirmed := CONFIRM(ConfirmChangeQst,FALSE,FIELDCAPTION("Sell-to Contact No."));
              IF Confirmed THEN BEGIN
                IF InitFromContact("Sell-to Contact No.","Sell-to Customer No.",FIELDCAPTION("Sell-to Contact No.")) THEN
                  EXIT;
            #45..69
            IF "Sell-to Contact No." <> '' THEN
              IF Cont.GET("Sell-to Contact No.") THEN
                IF ("Salesperson Code" = '') AND (Cont."Salesperson Code" <> '') THEN
                  VALIDATE("Salesperson Code",Cont."Salesperson Code");

            UpdateSellToCust("Sell-to Contact No.");
            UpdateSellToCustTemplateCode;
            UpdateShipToContact;
            */
        //end;


        //Unsupported feature: Code Modification on ""Bill-to Contact No."(Field 5053).OnLookup".

        //trigger "(Field 5053)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Bill-to Customer No." <> '' THEN BEGIN
              IF Cont.GET("Bill-to Contact No.") THEN
                Cont.SETRANGE("Company No.",Cont."Company No.")
              ELSE BEGIN
            #5..10
                ELSE
                  Cont.SETRANGE("No.",'');
              END;
            END;

            IF "Bill-to Contact No." <> '' THEN
              IF Cont.GET("Bill-to Contact No.") THEN ;
            IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN BEGIN
              xRec := Rec;
              VALIDATE("Bill-to Contact No.",Cont."No.");
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF "Bill-to Customer No." <> '' THEN
            #2..13
            #15..21
            */
        //end;


        //Unsupported feature: Code Modification on ""Bill-to Contact No."(Field 5053).OnValidate".

        //trigger "(Field 5053)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);

            IF ("Bill-to Contact No." <> xRec."Bill-to Contact No.") AND
               (xRec."Bill-to Contact No." <> '')
            THEN BEGIN
              IF HideValidationDialog THEN
                Confirmed := TRUE
              ELSE
                Confirmed := CONFIRM(Text004,FALSE,FIELDCAPTION("Bill-to Contact No."));
              IF Confirmed THEN BEGIN
                SalesLine.RESET;
                SalesLine.SETRANGE("Document Type","Document Type");
                SalesLine.SETRANGE("Document No.","No.");
                IF ("Bill-to Contact No." = '') AND ("Bill-to Customer No." = '') THEN BEGIN
                  IF NOT SalesLine.ISEMPTY THEN
                    ERROR(Text005,FIELDCAPTION("Bill-to Contact No."));
                  INIT;
                  SalesSetup.GET;
                  InitRecord;
                  "No. Series" := xRec."No. Series";
                  IF xRec."Shipping No." <> '' THEN BEGIN
                    "Shipping No. Series" := xRec."Shipping No. Series";
                    "Shipping No." := xRec."Shipping No.";
                  END;
                  IF xRec."Posting No." <> '' THEN BEGIN
                    "Posting No. Series" := xRec."Posting No. Series";
                    "Posting No." := xRec."Posting No.";
                  END;
                  IF xRec."Return Receipt No." <> '' THEN BEGIN
                    "Return Receipt No. Series" := xRec."Return Receipt No. Series";
                    "Return Receipt No." := xRec."Return Receipt No.";
                  END;
                  IF xRec."Prepayment No." <> '' THEN BEGIN
                    "Prepayment No. Series" := xRec."Prepayment No. Series";
                    "Prepayment No." := xRec."Prepayment No.";
                  END;
                  IF xRec."Prepmt. Cr. Memo No." <> '' THEN BEGIN
                    "Prepmt. Cr. Memo No. Series" := xRec."Prepmt. Cr. Memo No. Series";
                    "Prepmt. Cr. Memo No." := xRec."Prepmt. Cr. Memo No.";
                  END;
                  EXIT;
                END;
              END ELSE BEGIN
                "Bill-to Contact No." := xRec."Bill-to Contact No.";
                EXIT;
              END;
            END;

            IF ("Bill-to Customer No." <> '') AND ("Bill-to Contact No." <> '') THEN BEGIN
              Cont.GET("Bill-to Contact No.");
              ContBusinessRelation.RESET;
              ContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
              ContBusinessRelation.SETRANGE("Link to Table",ContBusinessRelation."Link to Table"::Customer);
              ContBusinessRelation.SETRANGE("No.","Bill-to Customer No.");
              IF ContBusinessRelation.FINDFIRST THEN
                IF ContBusinessRelation."Contact No." <> Cont."Company No." THEN
                  ERROR(Text038,Cont."No.",Cont.Name,"Bill-to Customer No.");
            END;

            UpdateBillToCust("Bill-to Contact No.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..8
                Confirmed := CONFIRM(ConfirmChangeQst,FALSE,FIELDCAPTION("Bill-to Contact No."));
              IF Confirmed THEN BEGIN
                IF InitFromContact("Bill-to Contact No.","Bill-to Customer No.",FIELDCAPTION("Bill-to Contact No.")) THEN
                  EXIT;
            #43..60
            */
        //end;


        //Unsupported feature: Code Modification on ""Bill-to Customer Template Code"(Field 5054).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Document Type","Document Type"::Quote);
            TESTFIELD(Status,Status::Open);

            IF NOT InsertMode AND
               ("Bill-to Customer Template Code" <> xRec."Bill-to Customer Template Code") AND
               (xRec."Bill-to Customer Template Code" <> '')
            THEN BEGIN
              IF HideValidationDialog THEN
                Confirmed := TRUE
              ELSE
                Confirmed := CONFIRM(Text004,FALSE,FIELDCAPTION("Bill-to Customer Template Code"));
              IF Confirmed THEN BEGIN
                SalesLine.RESET;
                SalesLine.SETRANGE("Document Type","Document Type");
                SalesLine.SETRANGE("Document No.","No.");
                IF "Bill-to Customer Template Code" = '' THEN BEGIN
                  IF NOT SalesLine.ISEMPTY THEN
                    ERROR(Text005,FIELDCAPTION("Bill-to Customer Template Code"));
                  INIT;
                  SalesSetup.GET;
                  InitRecord;
                  "No. Series" := xRec."No. Series";
                  IF xRec."Shipping No." <> '' THEN BEGIN
                    "Shipping No. Series" := xRec."Shipping No. Series";
                    "Shipping No." := xRec."Shipping No.";
                  END;
                  IF xRec."Posting No." <> '' THEN BEGIN
                    "Posting No. Series" := xRec."Posting No. Series";
                    "Posting No." := xRec."Posting No.";
                  END;
                  IF xRec."Return Receipt No." <> '' THEN BEGIN
                    "Return Receipt No. Series" := xRec."Return Receipt No. Series";
                    "Return Receipt No." := xRec."Return Receipt No.";
                  END;
                  IF xRec."Prepayment No." <> '' THEN BEGIN
                    "Prepayment No. Series" := xRec."Prepayment No. Series";
                    "Prepayment No." := xRec."Prepayment No.";
                  END;
                  IF xRec."Prepmt. Cr. Memo No." <> '' THEN BEGIN
                    "Prepmt. Cr. Memo No. Series" := xRec."Prepmt. Cr. Memo No. Series";
                    "Prepmt. Cr. Memo No." := xRec."Prepmt. Cr. Memo No.";
                  END;
                  EXIT;
                END;
              END ELSE BEGIN
                "Bill-to Customer Template Code" := xRec."Bill-to Customer Template Code";
                EXIT;
              END;
            END;

            VALIDATE("Ship-to Code",'');
            IF BillToCustTemplate.GET("Bill-to Customer Template Code") THEN BEGIN
              BillToCustTemplate.TESTFIELD("Customer Posting Group");
              "Customer Posting Group" := BillToCustTemplate."Customer Posting Group";
              "Invoice Disc. Code" := BillToCustTemplate."Invoice Disc. Code";
              "Customer Price Group" := BillToCustTemplate."Customer Price Group";
              "Customer Disc. Group" := BillToCustTemplate."Customer Disc. Group";
              "Allow Line Disc." := BillToCustTemplate."Allow Line Disc.";
              VALIDATE("Payment Terms Code",BillToCustTemplate."Payment Terms Code");
              VALIDATE("Payment Method Code",BillToCustTemplate."Payment Method Code");
              "Shipment Method Code" := BillToCustTemplate."Shipment Method Code";
            END;

            CreateDim(
              DATABASE::"Customer Template","Bill-to Customer Template Code",
              DATABASE::"Salesperson/Purchaser","Salesperson Code",
              DATABASE::Customer,"Bill-to Customer No.",
              DATABASE::Campaign,"Campaign No.",
              DATABASE::"Responsibility Center","Responsibility Center");

            IF NOT InsertMode AND
               (xRec."Sell-to Customer Template Code" = "Sell-to Customer Template Code") AND
               (xRec."Bill-to Customer Template Code" <> "Bill-to Customer Template Code")
            THEN
              RecreateSalesLines(FIELDCAPTION("Bill-to Customer Template Code"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..10
                Confirmed := CONFIRM(ConfirmChangeQst,FALSE,FIELDCAPTION("Bill-to Customer Template Code"));
              IF Confirmed THEN BEGIN
                IF InitFromTemplate("Bill-to Customer Template Code",FIELDCAPTION("Bill-to Customer Template Code")) THEN
                  EXIT
            #45..75
            */
        //end;


        //Unsupported feature: Code Modification on ""Responsibility Center"(Field 5700).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            IF NOT UserSetupMgt.CheckRespCenter(0,"Responsibility Center") THEN
              ERROR(
                Text027,
                RespCenter.TABLECAPTION,UserSetupMgt.GetSalesFilter);

            "Location Code" := UserSetupMgt.GetLocation(0,'',"Responsibility Center");
            IF "Location Code" <> '' THEN BEGIN
              IF Location.GET("Location Code") THEN
                "Outbound Whse. Handling Time" := Location."Outbound Whse. Handling Time";
            END ELSE BEGIN
              IF InvtSetup.GET THEN
                "Outbound Whse. Handling Time" := InvtSetup."Outbound Whse. Handling Time";
            END;

            UpdateShipToAddress;

            CreateDim(
            #19..25
              RecreateSalesLines(FIELDCAPTION("Responsibility Center"));
              "Assigned User ID" := '';
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..7
            UpdateOutboundWhseHandlingTime;
            #16..28
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Shipping Agent Service Code"(Field 5794).OnValidate".

        //trigger (Variable: BoolReclose)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Shipping Agent Service Code"(Field 5794).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            GetShippingTime(FIELDNO("Shipping Agent Service Code"));
            UpdateSalesLines(FIELDCAPTION("Shipping Agent Service Code"),CurrFieldNo <> 0);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            //>>MIGRATION NAV 2013
            //>>TODOLIST POINT 40  FLGR 26/01/2007
            IF (Status <> Status::Open) AND (xRec."Shipping Agent Service Code" <> "Shipping Agent Service Code")
              AND ("Document Type" = "Document Type"::Order)
            THEN BEGIN
              CDUReleaseDoc.Reopen(Rec);
              BoolReclose := TRUE;
            END;
            //<<TODOLIST POINT 40  FLGR 26/01/2007
            //<<MIGRATION NAV 2013
            #1..3
            //>>MIGRATION NAV 2013
            //>>TODOLIST POINT 40  FLGR 26/01/2007
            IF BoolReclose THEN BEGIN
              CDUReleaseDoc.RUN(Rec);
              BoolReclose := FALSE;
            END;
            //<<TODOLIST POINT 40  FLGR 26/01/2007
            //<<MIGRATION NAV 2013
            */
        //end;
        field(56;"Recalculate Invoice Disc.";Boolean)
        {
            CalcFormula = Exist("Sales Line" WHERE (Document Type=FIELD(Document Type),
                                                    Document No.=FIELD(No.),
                                                    Recalculate Invoice Disc.=CONST(Yes)));
            Caption = 'Recalculate Invoice Disc.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(200;"Work Description";BLOB)
        {
            Caption = 'Work Description';
        }
        field(600;"Payment Service Set ID";Integer)
        {
            Caption = 'Payment Service Set ID';
        }
        field(5755;Shipped;Boolean)
        {
            AccessByPermission = TableData 110=R;
            CalcFormula = Exist("Sales Line" WHERE (Document Type=FIELD(Document Type),
                                                    Document No.=FIELD(No.),
                                                    Qty. Shipped (Base)=FILTER(<>0)));
            Caption = 'Shipped';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000;"Cause filing";Option)
        {
            Caption = 'Cause filing';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Archivage_Devis] Ajout du champ';
            OptionCaption = 'No proceeded,Deleted,Change in Order';
            OptionMembers = "No proceeded",Deleted,"Change in Order";
        }
        field(50001;"Purchaser Comments";Text[50])
        {
            Caption = 'Purchaser Comments';
            Description = 'CNE1.00';
        }
        field(50002;"Warehouse Comments";Text[50])
        {
            Caption = 'Warehouse Comments';
            Description = 'CNE1.00';
        }
        field(50003;"Pay-to Customer No.";Code[20])
        {
            Caption = 'Pay-to Customer No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Customer;
        }
        field(50004;"Advance Payment";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            Caption = 'Advance Payment';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Champs_Suppl] Ajout du champ';
        }
        field(50005;"Affair No.";Code[20])
        {
            Caption = 'Affair No.';
            Description = 'CNE1.00';
            TableRelation = Job.No.;

            trigger OnValidate()
            begin
                //BC6 EABO 11/04/18 >>
                UpdateSalesShipment.UpdateAffairNoOnSalesShpt(Rec);
                //BC6 EABO 11/04/18 <<
            end;
        }
        field(50010;ID;Code[50])
        {
            Caption = 'User ID';
            Description = 'AjoutCodeUtilisateur RD 13/11/06 NCS1.01 [FE019V1] Ajout du code utilisateur dans les documents d''achats & ventes';
            Editable = false;

            trigger OnLookup()
            var
                RecLUserMgt: Codeunit "418";
                CodLUserID: Code[50];
            begin
                //>>MIGRATION NAV 2013
                CodLUserID := ID;
                RecLUserMgt.LookupUserID(CodLUserID);
                //<<MIGRATION NAV 2013
            end;
        }
        field(50020;"Customer Sales Profit Group";Code[10])
        {
            Caption = 'Goupe Marge Vente Client';
            Description = 'GRPMARGECLT SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            Enabled = false;
            TableRelation = "Customer Sales Profit Group";
        }
        field(50025;"Combine Shipments by Order";Boolean)
        {
            Caption = 'Combine Shipment By Order';
            Description = 'FE018 regroupement BL par CMD';
        }
        field(50026;"Purchase cost";Decimal)
        {
            CalcFormula = Sum("Sales Line"."Purchase cost" WHERE (Document Type=FIELD(Document Type),
                                                                  Document No.=FIELD(No.)));
            Caption = 'Purchase Cost';
            Description = 'SM Besoin pour Etat Bible';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50029;"Copy Sell-to Address";Boolean)
        {
            Caption = 'Copy Sell-to Address';
            Description = 'CNE6.01';
        }
        field(50030;"Sales LCY";Decimal)
        {
            Caption = 'Ventes DS';
            Description = 'SM Besoin pour Etat Bible';
        }
        field(50031;"Profit LCY";Decimal)
        {
            Caption = 'Marge DS';
            Description = 'SM  Besoin Etat Bible';
            Editable = true;
        }
        field(50032;"% Profit";Decimal)
        {
            Caption = '% de marge sur vente';
            Description = 'SM Besoin pour Etat Bible';
        }
        field(50033;Invoiced;Boolean)
        {
            Caption = 'Invoiced';
        }
        field(50040;"Prod. Version No.";Integer)
        {
            Caption = 'Version No.';
        }
        field(50050;"Document description";Text[50])
        {
            Caption = 'Document description';
        }
        field(50060;"Quote statut";Option)
        {
            Caption = 'Quote status';
            OptionCaption = ' ,Approved,Locked';
            OptionMembers = " ",approved,locked;
        }
        field(50061;"Sell-to Fax No.";Text[30])
        {
            Caption = 'Sell-to Fax No.';
            Description = 'FE005 SEBC 08/01/2007';
        }
        field(50062;"Sell-to E-Mail Address";Text[50])
        {
            Caption = 'Sell-to E-Mail address';
            Description = 'FE005 MICO 12/02/07';
        }
        field(50070;"Sales Counter";Boolean)
        {
            Caption = 'Sales Counter';
        }
        field(50080;"Purchase No. Order Lien";Code[20])
        {
            Caption = 'Purchase No. Order Lien';
            Description = 'CNEIC';

            trigger OnLookup()
            var
                reclPurchHdr: Record "38";
            begin
                //>>CNEIC : Le 07/08/15
                reclPurchHdr.SETRANGE("Document Type", reclPurchHdr."Document Type"::Order);
                reclPurchHdr.SETFILTER("No.","Purchase No. Order Lien");

                PAGE.RUNMODAL(PAGE::"Purchase Order", reclPurchHdr) ;
                //<<CNEIC : Le 07/08/15
            end;
        }
        field(50100;"Salesperson Filter";Text[250])
        {
            Caption = 'Salesperson Filter';
            Editable = false;
        }
        field(50110;"Mailing List Code";Code[10])
        {
            Caption = 'Mailing List Code';
            TableRelation = "Mailing List";
        }
        field(50120;"Return Order Type";Option)
        {
            Caption = 'Return Order Type';
            Description = 'BCSYS';
            OptionCaption = 'Location,SAV';
            OptionMembers = Location,SAV;

            trigger OnValidate()
            begin
                UpdateSalesLineReturnType
            end;
        }
        field(50403;"Bin Code";Code[20])
        {

            trigger OnLookup()
            var
                WMSManagement: Codeunit "7302";
                BinCode: Code[20];
            begin
                //>> C:FE09 Begin
                IF NOT ("Document Type" = "Document Type"::Order) THEN
                  EXIT;

                BinCode := WMSManagement.BinLookUp2("Location Code","Bin Code");

                IF BinCode <> '' THEN
                  VALIDATE("Bin Code",BinCode);
                //<< End
            end;

            trigger OnValidate()
            var
                WMSManagement: Codeunit "7302";
            begin
                //>> C:FE09 Begin
                IF NOT ("Document Type" = "Document Type"::Order) THEN
                  EXIT;


                IF "Bin Code" <> '' THEN
                  BEGIN
                    TESTFIELD("Location Code");
                    Location.GET("Location Code");
                    Location.TESTFIELD("Bin Mandatory");
                    Location.TESTFIELD("Require Shipment",FALSE);
                    Location.TESTFIELD("Require Pick");
                END;

                IF xRec."Bin Code" <> "Bin Code" THEN BEGIN
                  UpdateSalesLines(FIELDCAPTION("Bin Code"),CurrFieldNo<>0);
                END;
                //>> End
            end;
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Document Type,Combine Shipments,Bill-to Customer No.,Currency Code,EU 3-Party Trade"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Document Type,Sell-to Contact No."(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Bill-to Contact No."(Key)".

        key(Key1;"Document Type","Combine Shipments","Bill-to Customer No.","Currency Code","EU 3-Party Trade","Dimension Set ID")
        {
        }
        key(Key2;"Document Type","Combine Shipments by Order","Combine Shipments","Bill-to Customer No.","Currency Code")
        {
        }
        key(Key3;"Shipping Agent Code")
        {
        }
        key(Key4;"Affair No.")
        {
        }
        key(Key5;"Document Type","External Document No.")
        {
        }
        key(Key6;Status,"Document Type","Document Date")
        {
        }
        key(Key7;Status,"Document Type","No.","Sell-to Customer No.")
        {
        }
        key(Key8;"Document Type","Document Date")
        {
        }
        key(Key9;"Order Date","Document Type")
        {
        }
        key(Key10;Status,"Document Type","Shipment Date","No.")
        {
        }
        key(Key11;"Document Type","Sell-to Customer No.","Document Date","No.")
        {
        }
        key(Key12;"Document Type","Order Date","No.")
        {
        }
        key(Key13;"Document Type","Sell-to Customer No.","Salesperson Filter","Order Date","No.")
        {
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: PostSalesDelete)()
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
        IF DOPaymentTransLogEntry.FINDFIRST THEN
          DOPaymentTransLogMgt.ValidateCanDeleteDocument("Payment Method Code","Document Type",FORMAT("Document Type"),"No.");

        IF NOT UserSetupMgt.CheckRespCenter(0,"Responsibility Center") THEN
          ERROR(
            Text022,
            RespCenter.TABLECAPTION,UserSetupMgt.GetSalesFilter);

        IF ("Opportunity No." <> '') AND
           ("Document Type" IN ["Document Type"::Quote,"Document Type"::Order])
        THEN BEGIN
          IF Opp.GET("Opportunity No.") THEN BEGIN
            IF "Document Type" = "Document Type"::Order THEN BEGIN
              IF NOT CONFIRM(Text040,TRUE) THEN
                ERROR(Text044);
              TempOpportunityEntry.INIT;
              TempOpportunityEntry.VALIDATE("Opportunity No.",Opp."No.");
              TempOpportunityEntry."Sales Cycle Code" := Opp."Sales Cycle Code";
              TempOpportunityEntry."Contact No." := Opp."Contact No.";
              TempOpportunityEntry."Contact Company No." := Opp."Contact Company No.";
              TempOpportunityEntry."Salesperson Code" := Opp."Salesperson Code";
              TempOpportunityEntry."Campaign No." := Opp."Campaign No.";
              TempOpportunityEntry."Action Taken" := TempOpportunityEntry."Action Taken"::Lost;
              TempOpportunityEntry.INSERT;
              TempOpportunityEntry.SETRANGE("Action Taken",TempOpportunityEntry."Action Taken"::Lost);
              PAGE.RUNMODAL(PAGE::"Close Opportunity",TempOpportunityEntry);
              IF Opp.GET("Opportunity No.") THEN
                IF Opp.Status <> Opp.Status::Lost THEN
                  ERROR(Text043);
            END;
            Opp."Sales Document Type" := Opp."Sales Document Type"::" ";
            Opp."Sales Document No." := '';
            Opp.MODIFY;
            "Opportunity No." := '';
          END;
        END;

        SalesPost.DeleteHeader(
          Rec,SalesShptHeader,SalesInvHeader,SalesCrMemoHeader,ReturnRcptHeader,SalesInvHeaderPrepmt,SalesCrMemoHeaderPrepmt);
        VALIDATE("Applies-to ID",'');

        ApprovalMgt.DeleteApprovalEntry(DATABASE::"Sales Header","Document Type","No.");
        SalesLine.RESET;
        SalesLine.LOCKTABLE;

        WhseRequest.SETRANGE("Source Type",DATABASE::"Sales Line");
        WhseRequest.SETRANGE("Source Subtype","Document Type");
        WhseRequest.SETRANGE("Source No.","No.");
        WhseRequest.DELETEALL(TRUE);

        SalesLine.SETRANGE("Document Type","Document Type");
        SalesLine.SETRANGE("Document No.","No.");
        SalesLine.SETRANGE(Type,SalesLine.Type::"Charge (Item)");

        DeleteSalesLines;
        SalesLine.SETRANGE(Type);
        DeleteSalesLines;

        SalesCommentLine.SETRANGE("Document Type","Document Type");
        SalesCommentLine.SETRANGE("No.","No.");
        SalesCommentLine.DELETEALL;

        IF (SalesShptHeader."No." <> '') OR
           (SalesInvHeader."No." <> '') OR
           (SalesCrMemoHeader."No." <> '') OR
           (ReturnRcptHeader."No." <> '') OR
           (SalesInvHeaderPrepmt."No." <> '') OR
           (SalesCrMemoHeaderPrepmt."No." <> '')
        THEN BEGIN
          COMMIT;

          IF SalesShptHeader."No." <> '' THEN
            IF CONFIRM(
                 Text000,TRUE,
                 SalesShptHeader."No.")
            THEN BEGIN
              SalesShptHeader.SETRECFILTER;
              SalesShptHeader.PrintRecords(TRUE);
            END;

          IF SalesInvHeader."No." <> '' THEN
            IF CONFIRM(
                 Text001,TRUE,
                 SalesInvHeader."No.")
            THEN BEGIN
              SalesInvHeader.SETRECFILTER;
              SalesInvHeader.PrintRecords(TRUE);
            END;

          IF SalesCrMemoHeader."No." <> '' THEN
            IF CONFIRM(
                 Text002,TRUE,
                 SalesCrMemoHeader."No.")
            THEN BEGIN
              SalesCrMemoHeader.SETRECFILTER;
              SalesCrMemoHeader.PrintRecords(TRUE);
            END;

          IF ReturnRcptHeader."No." <> '' THEN
            IF CONFIRM(
                 Text023,TRUE,
                 ReturnRcptHeader."No.")
            THEN BEGIN
              ReturnRcptHeader.SETRECFILTER;
              ReturnRcptHeader.PrintRecords(TRUE);
            END;

          IF SalesInvHeaderPrepmt."No." <> '' THEN
            IF CONFIRM(
                 Text055,TRUE,
                 SalesInvHeader."No.")
            THEN BEGIN
              SalesInvHeaderPrepmt.SETRECFILTER;
              SalesInvHeaderPrepmt.PrintRecords(TRUE);
            END;

          IF SalesCrMemoHeaderPrepmt."No." <> '' THEN
            IF CONFIRM(
                 Text054,TRUE,
                 SalesCrMemoHeaderPrepmt."No.")
            THEN BEGIN
              SalesCrMemoHeaderPrepmt.SETRECFILTER;
              SalesCrMemoHeaderPrepmt.PrintRecords(TRUE);
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #4..8
        PostSalesDelete.DeleteHeader(
          Rec,SalesShptHeader,SalesInvHeader,SalesCrMemoHeader,ReturnRcptHeader,
          SalesInvHeaderPrepmt,SalesCrMemoHeaderPrepmt);

        ArchiveManagement.AutoArchiveSalesDocument(Rec);

        UpdateOpportunity;

        VALIDATE("Applies-to ID",'');
        VALIDATE("Incoming Document Entry No.",0);

        ApprovalsMgmt.DeleteApprovalEntries(RECORDID);
        #43..48
        IF NOT WhseRequest.ISEMPTY THEN
          WhseRequest.DELETEALL(TRUE);
        #50..68
        THEN
          MESSAGE(PostedDocsToPrintCreatedMsg);

        //>>CNEIC
        CompanyInfo.FINDFIRST;
        IF CompanyInfo."Branch Company" THEN
          BEGIN
           IF "Purchase No. Order Lien" <> '' THEN
             ERROR(TextG003);
          END;
        //<<CNEIC

        //>>BCSYS 29062020
        IF NOT IsDeleteFromReturnOrder THEN BEGIN
          G_ReturnOrderMgt.DeleteRelatedDocument(Rec);

          G_ReturnOrderMgt.DeleteRelatedSalesOrderNo(Rec);
        END;
        //<<BCSYS 29062020
        */
    //end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "No." = '' THEN BEGIN
          TestNoSeries;
          NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Posting Date","No.","No. Series");
        END;

        InitRecord;
        InsertMode := TRUE;

        IF GETFILTER("Sell-to Customer No.") <> '' THEN
          IF GETRANGEMIN("Sell-to Customer No.") = GETRANGEMAX("Sell-to Customer No.") THEN
            VALIDATE("Sell-to Customer No.",GETRANGEMIN("Sell-to Customer No."));

        IF GETFILTER("Sell-to Contact No.") <> '' THEN
          IF GETRANGEMIN("Sell-to Contact No.") = GETRANGEMAX("Sell-to Contact No.") THEN
            VALIDATE("Sell-to Contact No.",GETRANGEMIN("Sell-to Contact No."));

        "Doc. No. Occurrence" := ArchiveManagement.GetNextOccurrenceNo(DATABASE::"Sales Header","Document Type","No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        InitInsert;
        InsertMode := TRUE;

        SetSellToCustomerFromFilter;

        IF GetFilterContNo <> '' THEN
          VALIDATE("Sell-to Contact No.",GetFilterContNo);

        //>>MIGRATION NAV 2013
        //AjoutCodeUtilisateur RD 13/11/06 NCS1.01 [FE019V1] Ajout du code utilisateur dans les documents d'achats & ventes
        ID := USERID;
        //Fin AjoutCodeUtilisateur RD 13/11/06 NCS1.01 [FE019V1] Ajout du code utilisateur dans les documents d'achats & ventes
        //<<MIGRATION NAV 2013
        */
    //end;


    //Unsupported feature: Code Insertion on "OnModify".

    //trigger OnModify()
    //begin
        /*
        UpdateCustomerAddress;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ArchiveManagement) (VariableCollection) on "InitRecord(PROCEDURE 10)".



    //Unsupported feature: Code Modification on "InitRecord(PROCEDURE 10)".

    //procedure InitRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesSetup.GET;

        CASE "Document Type" OF
        #4..58

        VALIDATE("Location Code",UserSetupMgt.GetLocation(0,Cust."Location Code","Responsibility Center"));

        IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN BEGIN
          GLSetup.GET;
          Correction := GLSetup."Mark Cr. Memos as Corrections";
        END;

        "Posting Description" := FORMAT("Document Type") + ' ' + "No.";

        Reserve := Reserve::Optional;

        IF InvtSetup.GET THEN
          VALIDATE("Outbound Whse. Handling Time",InvtSetup."Outbound Whse. Handling Time");

        "Responsibility Center" := UserSetupMgt.GetRespCenter(0,"Responsibility Center");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..61
        IF IsCreditDocType THEN BEGIN
        #63..68
        UpdateOutboundWhseHandlingTime;

        "Responsibility Center" := UserSetupMgt.GetRespCenter(0,"Responsibility Center");
        "Doc. No. Occurrence" := ArchiveManagement.GetNextOccurrenceNo(DATABASE::"Sales Header","Document Type","No.");
        */
    //end;


    //Unsupported feature: Code Modification on "TestNoSeries(PROCEDURE 6)".

    //procedure TestNoSeries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesSetup.GET;

        CASE "Document Type" OF
        #4..10
              SalesSetup.TESTFIELD("Posted Invoice Nos.");
            END;
          "Document Type"::"Return Order":
            SalesSetup.TESTFIELD("Return Order Nos.");
          "Document Type"::"Credit Memo":
            BEGIN
              SalesSetup.TESTFIELD("Credit Memo Nos.");
              SalesSetup.TESTFIELD("Posted Credit Memo Nos.");
            END;
          "Document Type"::"Blanket Order":
            SalesSetup.TESTFIELD("Blanket Order Nos.");
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..13
            //>>BC6
            // OLD STD SalesSetup.TESTFIELD("Return Order Nos.");
            BEGIN
              IF "Return Order Type" = "Return Order Type"::SAV THEN
                SalesSetup.TESTFIELD("SAV Return Order Nos.")
              ELSE
                SalesSetup.TESTFIELD("Return Order Nos.");
            END;
            //<<BC6
        #15..22
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: NoSeriesCode) (VariableCollection) on "GetNoSeriesCode(PROCEDURE 9)".



    //Unsupported feature: Code Modification on "GetNoSeriesCode(PROCEDURE 9)".

    //procedure GetNoSeriesCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE "Document Type" OF
          "Document Type"::Quote:
            EXIT(SalesSetup."Quote Nos.");
          "Document Type"::Order:
            EXIT(SalesSetup."Order Nos.");
          "Document Type"::Invoice:
            EXIT(SalesSetup."Invoice Nos.");
          "Document Type"::"Return Order":
            EXIT(SalesSetup."Return Order Nos.");
          "Document Type"::"Credit Memo":
            EXIT(SalesSetup."Credit Memo Nos.");
          "Document Type"::"Blanket Order":
            EXIT(SalesSetup."Blanket Order Nos.");
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CASE "Document Type" OF
          "Document Type"::Quote:
            NoSeriesCode := SalesSetup."Quote Nos.";
          "Document Type"::Order:
            NoSeriesCode := SalesSetup."Order Nos.";
          "Document Type"::Invoice:
            NoSeriesCode := SalesSetup."Invoice Nos.";
          "Document Type"::"Return Order":
            //>>BC6
            // OLD STD NoSeriesCode := SalesSetup."Return Order Nos.";
            BEGIN
              IF "Return Order Type" = "Return Order Type"::SAV THEN
                NoSeriesCode := SalesSetup."SAV Return Order Nos."
              ELSE
                NoSeriesCode := SalesSetup."Return Order Nos.";
            END;
            //<<BC6
          "Document Type"::"Credit Memo":
            NoSeriesCode := SalesSetup."Credit Memo Nos.";
          "Document Type"::"Blanket Order":
            NoSeriesCode := SalesSetup."Blanket Order Nos.";
        END;
        EXIT(NoSeriesMgt.GetNoSeriesWithCheck(NoSeriesCode,SelectNoSeriesAllowed,"No. Series"));
        */
    //end;


    //Unsupported feature: Code Modification on "GetPostingNoSeriesCode(PROCEDURE 8)".

    //procedure GetPostingNoSeriesCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
          EXIT(SalesSetup."Posted Credit Memo Nos.");
        EXIT(SalesSetup."Posted Invoice Nos.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF IsCreditDocType THEN
          EXIT(SalesSetup."Posted Credit Memo Nos.");
        EXIT(SalesSetup."Posted Invoice Nos.");
        */
    //end;


    //Unsupported feature: Code Modification on "GetPostingPrepaymentNoSeriesCode(PROCEDURE 59)".

    //procedure GetPostingPrepaymentNoSeriesCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
          EXIT(SalesSetup."Posted Prepmt. Cr. Memo Nos.");
        EXIT(SalesSetup."Posted Prepmt. Inv. Nos.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF IsCreditDocType THEN
          EXIT(SalesSetup."Posted Prepmt. Cr. Memo Nos.");
        EXIT(SalesSetup."Posted Prepmt. Inv. Nos.");
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: SourceCode) (VariableCollection) on "ConfirmDeletion(PROCEDURE 11)".


    //Unsupported feature: Variable Insertion (Variable: SourceCodeSetup) (VariableCollection) on "ConfirmDeletion(PROCEDURE 11)".


    //Unsupported feature: Variable Insertion (Variable: PostSalesDelete) (VariableCollection) on "ConfirmDeletion(PROCEDURE 11)".



    //Unsupported feature: Code Modification on "ConfirmDeletion(PROCEDURE 11)".

    //procedure ConfirmDeletion();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesPost.TestDeleteHeader(
          Rec,SalesShptHeader,SalesInvHeader,SalesCrMemoHeader,ReturnRcptHeader,
          SalesInvHeaderPrepmt,SalesCrMemoHeaderPrepmt);
        IF SalesShptHeader."No." <> '' THEN
          IF NOT CONFIRM(
               Text009,TRUE,
               SalesShptHeader."No.")
          THEN
            EXIT;
        IF SalesInvHeader."No." <> '' THEN
          IF NOT CONFIRM(
               Text012,TRUE,
               SalesInvHeader."No.")
          THEN
            EXIT;
        IF SalesCrMemoHeader."No." <> '' THEN
          IF NOT CONFIRM(
               Text014,TRUE,
               SalesCrMemoHeader."No.")
          THEN
            EXIT;
        IF ReturnRcptHeader."No." <> '' THEN
          IF NOT CONFIRM(
               Text030,TRUE,
               ReturnRcptHeader."No.")
          THEN
            EXIT;
        IF "Prepayment No." <> '' THEN
          IF NOT CONFIRM(
               Text056,TRUE,
               SalesInvHeaderPrepmt."No.")
          THEN
            EXIT;
        IF "Prepmt. Cr. Memo No." <> '' THEN
          IF NOT CONFIRM(
               Text057,TRUE,
               SalesCrMemoHeaderPrepmt."No.")
          THEN
            EXIT;
        EXIT(TRUE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SourceCodeSetup.GET;
        SourceCodeSetup.TESTFIELD("Deleted Document");
        SourceCode.GET(SourceCodeSetup."Deleted Document");

        PostSalesDelete.InitDeleteHeader(
          Rec,SalesShptHeader,SalesInvHeader,SalesCrMemoHeader,ReturnRcptHeader,
          SalesInvHeaderPrepmt,SalesCrMemoHeaderPrepmt,SourceCode.Code);

        IF SalesShptHeader."No." <> '' THEN
          IF NOT CONFIRM(Text009,TRUE,SalesShptHeader."No.") THEN
            EXIT;
        IF SalesInvHeader."No." <> '' THEN
          IF NOT CONFIRM(Text012,TRUE,SalesInvHeader."No.") THEN
            EXIT;
        IF SalesCrMemoHeader."No." <> '' THEN
          IF NOT CONFIRM(Text014,TRUE,SalesCrMemoHeader."No.") THEN
            EXIT;
        IF ReturnRcptHeader."No." <> '' THEN
          IF NOT CONFIRM(Text030,TRUE,ReturnRcptHeader."No.") THEN
            EXIT;
        IF "Prepayment No." <> '' THEN
          IF NOT CONFIRM(Text056,TRUE,SalesInvHeaderPrepmt."No.") THEN
            EXIT;
        IF "Prepmt. Cr. Memo No." <> '' THEN
          IF NOT CONFIRM(Text057,TRUE,SalesCrMemoHeaderPrepmt."No.") THEN
            EXIT;
        EXIT(TRUE);
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: TempSalesLine) (VariableCollection) on "RecreateSalesLines(PROCEDURE 4)".


    //Unsupported feature: Variable Insertion (Variable: TransferExtendedText) (VariableCollection) on "RecreateSalesLines(PROCEDURE 4)".


    //Unsupported feature: Property Insertion (Local) on "RecreateSalesLines(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "RecreateSalesLines(PROCEDURE 4)".

    //procedure RecreateSalesLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF SalesLinesExist THEN BEGIN
          IF HideValidationDialog OR NOT GUIALLOWED THEN
            Confirmed := TRUE
          ELSE
            Confirmed :=
              CONFIRM(
                Text015,FALSE,ChangedFieldName);
          IF Confirmed THEN BEGIN
            SalesLine.LOCKTABLE;
            ItemChargeAssgntSales.LOCKTABLE;
            ReservEntry.LOCKTABLE;
            MODIFY;

            SalesLine.RESET;
            SalesLine.SETRANGE("Document Type","Document Type");
            SalesLine.SETRANGE("Document No.","No.");
            IF SalesLine.FINDSET THEN BEGIN
              TempReservEntry.DELETEALL;
              REPEAT
                SalesLine.TESTFIELD("Job No.",'');
                SalesLine.TESTFIELD("Job Contract Entry No.",0);
                SalesLine.TESTFIELD("Quantity Shipped",0);
                SalesLine.TESTFIELD("Quantity Invoiced",0);
                SalesLine.TESTFIELD("Return Qty. Received",0);
                SalesLine.TESTFIELD("Shipment No.",'');
                SalesLine.TESTFIELD("Return Receipt No.",'');
                SalesLine.TESTFIELD("Blanket Order No.",'');
                SalesLine.TESTFIELD("Prepmt. Amt. Inv.",0);
                IF (SalesLine."Location Code" <> "Location Code") AND NOT SalesLine.IsServiceItem THEN
                  SalesLine.VALIDATE("Location Code","Location Code");
                SalesLineTmp := SalesLine;
                IF SalesLine.Nonstock THEN BEGIN
                  SalesLine.Nonstock := FALSE;
                  SalesLine.MODIFY;
                END;

                IF ATOLink.AsmExistsForSalesLine(SalesLineTmp) THEN BEGIN
                  TempATOLink := ATOLink;
                  TempATOLink.INSERT;
                  ATOLink.DELETE;
                END;

                SalesLineTmp.INSERT;
                RecreateReservEntry(SalesLine,0,TRUE);
                RecreateReqLine(SalesLine,0,TRUE);
              UNTIL SalesLine.NEXT = 0;

              ItemChargeAssgntSales.SETRANGE("Document Type","Document Type");
              ItemChargeAssgntSales.SETRANGE("Document No.","No.");
              IF ItemChargeAssgntSales.FINDSET THEN BEGIN
                REPEAT
                  TempItemChargeAssgntSales.INIT;
                  TempItemChargeAssgntSales := ItemChargeAssgntSales;
                  TempItemChargeAssgntSales.INSERT;
                UNTIL ItemChargeAssgntSales.NEXT = 0;
                ItemChargeAssgntSales.DELETEALL;
              END;

              SalesLine.DELETEALL(TRUE);
              SalesLine.INIT;
              SalesLine."Line No." := 0;
              SalesLineTmp.FINDSET;
              ExtendedTextAdded := FALSE;
              SalesLine.BlockDynamicTracking(TRUE);
              REPEAT
                IF SalesLineTmp."Attached to Line No." = 0 THEN BEGIN
                  SalesLine.INIT;
                  SalesLine."Line No." := SalesLine."Line No." + 10000;
                  SalesLine.VALIDATE(Type,SalesLineTmp.Type);
                  IF SalesLineTmp."No." = '' THEN BEGIN
                    SalesLine.VALIDATE(Description,SalesLineTmp.Description);
                    SalesLine.VALIDATE("Description 2",SalesLineTmp."Description 2");
                  END ELSE BEGIN
                    SalesLine.VALIDATE("No.",SalesLineTmp."No.");
                    IF SalesLine.Type <> SalesLine.Type::" " THEN BEGIN
                      SalesLine.VALIDATE("Unit of Measure Code",SalesLineTmp."Unit of Measure Code");
                      SalesLine.VALIDATE("Variant Code",SalesLineTmp."Variant Code");
                      IF SalesLineTmp.Quantity <> 0 THEN BEGIN
                        SalesLine.VALIDATE(Quantity,SalesLineTmp.Quantity);
                        SalesLine.VALIDATE("Qty. to Assemble to Order",SalesLineTmp."Qty. to Assemble to Order");
                      END;
                      SalesLine."Purchase Order No." := SalesLineTmp."Purchase Order No.";
                      SalesLine."Purch. Order Line No." := SalesLineTmp."Purch. Order Line No.";
                      SalesLine."Drop Shipment" := SalesLine."Purch. Order Line No." <> 0;
                    END;
                  END;

                  SalesLine.INSERT;
                  ExtendedTextAdded := FALSE;

                  IF SalesLine.Type = SalesLine.Type::Item THEN BEGIN
                    ClearItemAssgntSalesFilter(TempItemChargeAssgntSales);
                    TempItemChargeAssgntSales.SETRANGE("Applies-to Doc. Type",SalesLineTmp."Document Type");
                    TempItemChargeAssgntSales.SETRANGE("Applies-to Doc. No.",SalesLineTmp."Document No.");
                    TempItemChargeAssgntSales.SETRANGE("Applies-to Doc. Line No.",SalesLineTmp."Line No.");
                    IF TempItemChargeAssgntSales.FINDSET THEN
                      REPEAT
                        IF NOT TempItemChargeAssgntSales.MARK THEN BEGIN
                          TempItemChargeAssgntSales."Applies-to Doc. Line No." := SalesLine."Line No.";
                          TempItemChargeAssgntSales.Description := SalesLine.Description;
                          TempItemChargeAssgntSales.MODIFY;
                          TempItemChargeAssgntSales.MARK(TRUE);
                        END;
                      UNTIL TempItemChargeAssgntSales.NEXT = 0;
                  END;
                  IF SalesLine.Type = SalesLine.Type::"Charge (Item)" THEN BEGIN
                    TempInteger.INIT;
                    TempInteger.Number := SalesLine."Line No.";
                    TempInteger.INSERT;
                  END;
                END ELSE
                  IF NOT ExtendedTextAdded THEN BEGIN
                    TransferExtendedText.SalesCheckIfAnyExtText(SalesLine,TRUE);
                    TransferExtendedText.InsertSalesExtText(SalesLine);
                    SalesLine.FINDLAST;
                    ExtendedTextAdded := TRUE;
                  END;
                RecreateReservEntry(SalesLineTmp,SalesLine."Line No.",FALSE);
                RecreateReqLine(SalesLineTmp,SalesLine."Line No.",FALSE);
                SynchronizeForReservations(SalesLine,SalesLineTmp);

                IF TempATOLink.AsmExistsForSalesLine(SalesLineTmp) THEN BEGIN
                  ATOLink := TempATOLink;
                  ATOLink.INSERT;
                  SalesLine.AutoAsmToOrder;
                  TempATOLink.DELETE;
                END;
              UNTIL SalesLineTmp.NEXT = 0;

              ClearItemAssgntSalesFilter(TempItemChargeAssgntSales);
              SalesLineTmp.SETRANGE(Type,SalesLine.Type::"Charge (Item)");
              IF SalesLineTmp.FINDSET THEN
                REPEAT
                  TempItemChargeAssgntSales.SETRANGE("Document Line No.",SalesLineTmp."Line No.");
                  IF TempItemChargeAssgntSales.FINDSET THEN BEGIN
                    REPEAT
                      TempInteger.FINDFIRST;
                      ItemChargeAssgntSales.INIT;
                      ItemChargeAssgntSales := TempItemChargeAssgntSales;
                      ItemChargeAssgntSales."Document Line No." := TempInteger.Number;
                      ItemChargeAssgntSales.VALIDATE("Unit Cost",0);
                      ItemChargeAssgntSales.INSERT;
                    UNTIL TempItemChargeAssgntSales.NEXT = 0;
                    TempInteger.DELETE;
                  END;
                UNTIL SalesLineTmp.NEXT = 0;

              SalesLineTmp.SETRANGE(Type);
              SalesLineTmp.DELETEALL;
              ClearItemAssgntSalesFilter(TempItemChargeAssgntSales);
              TempItemChargeAssgntSales.DELETEALL;
            END;
          END ELSE
            ERROR(
              Text017,ChangedFieldName);
        END;
        SalesLine.BlockDynamicTracking(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..12
        #14..18
              RecreateReservEntryReqLine(TempSalesLine,TempATOLink,ATOLink);
              ItemChargeAssgntSales.SETRANGE("Document Type","Document Type");
              ItemChargeAssgntSales.SETRANGE("Document No.","No.");
              TransferItemChargeAssgntSalesToTemp(ItemChargeAssgntSales,TempItemChargeAssgntSales);
        #59..61
              TempSalesLine.FINDSET;
        #63..65
                IF TempSalesLine."Attached to Line No." = 0 THEN BEGIN
                  CreateSalesLine(TempSalesLine);
        #89..92
                    TempItemChargeAssgntSales.SETRANGE("Applies-to Doc. Type",TempSalesLine."Document Type");
                    TempItemChargeAssgntSales.SETRANGE("Applies-to Doc. No.",TempSalesLine."Document No.");
                    TempItemChargeAssgntSales.SETRANGE("Applies-to Doc. Line No.",TempSalesLine."Line No.");
        #96..117
                RecreateReservEntry(TempSalesLine,SalesLine."Line No.",FALSE);
                RecreateReqLine(TempSalesLine,SalesLine."Line No.",FALSE);
                SynchronizeForReservations(SalesLine,TempSalesLine);

                IF TempATOLink.AsmExistsForSalesLine(TempSalesLine) THEN BEGIN
                  ATOLink := TempATOLink;
                  ATOLink."Document Line No." := SalesLine."Line No.";
                  ATOLink.INSERT;
                  ATOLink.UpdateAsmFromSalesLineATOExist(SalesLine);
                  TempATOLink.DELETE;
                END;
              UNTIL TempSalesLine.NEXT = 0;

              ClearItemAssgntSalesFilter(TempItemChargeAssgntSales);
              TempSalesLine.SETRANGE(Type,SalesLine.Type::"Charge (Item)");
              CreateItemChargeAssgntSales(ItemChargeAssgntSales,TempItemChargeAssgntSales,TempSalesLine,TempInteger);
              TempSalesLine.SETRANGE(Type);
              TempSalesLine.DELETEALL;
        #150..157
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "MessageIfSalesLinesExist(PROCEDURE 5)".


    //Unsupported feature: Property Insertion (Local) on "PriceMessageIfSalesLinesExist(PROCEDURE 7)".


    //Unsupported feature: Variable Insertion (Variable: PermissionManager) (VariableCollection) on "UpdateSalesLines(PROCEDURE 15)".


    //Unsupported feature: Variable Insertion (Variable: NotRunningOnSaaS) (VariableCollection) on "UpdateSalesLines(PROCEDURE 15)".


    //Unsupported feature: Property Insertion (Local) on "UpdateSalesLines(PROCEDURE 15)".



    //Unsupported feature: Code Modification on "UpdateSalesLines(PROCEDURE 15)".

    //procedure UpdateSalesLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT SalesLinesExist THEN
          EXIT;

        IF AskQuestion THEN BEGIN
          Question := STRSUBSTNO(
              Text031 +
              Text032,ChangedFieldName);
          IF GUIALLOWED THEN
            IF DIALOG.CONFIRM(Question,TRUE) THEN
              CASE ChangedFieldName OF
                FIELDCAPTION("Shipment Date"),
                FIELDCAPTION("Shipping Agent Code"),
                FIELDCAPTION("Shipping Agent Service Code"),
                FIELDCAPTION("Shipping Time"),
                FIELDCAPTION("Requested Delivery Date"),
                FIELDCAPTION("Promised Delivery Date"),
                FIELDCAPTION("Outbound Whse. Handling Time"):
                  ConfirmResvDateConflict;
              END
            ELSE
              EXIT;
        END;

        SalesLine.LOCKTABLE;
        MODIFY;

        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type","Document Type");
        SalesLine.SETRANGE("Document No.","No.");
        IF SalesLine.FINDSET THEN
          REPEAT
            CASE ChangedFieldName OF
              FIELDCAPTION("Shipment Date"):
                IF SalesLine."No." <> '' THEN
                  SalesLine.VALIDATE("Shipment Date","Shipment Date");
              FIELDCAPTION("Currency Factor"):
                IF SalesLine.Type <> SalesLine.Type::" " THEN BEGIN
                  SalesLine.VALIDATE("Unit Price");
                  SalesLine.VALIDATE("Unit Cost (LCY)");
                  IF SalesLine."Job No." <> '' THEN
                    JobTransferLine.FromSalesHeaderToPlanningLine(SalesLine,"Currency Factor");
                END;
              FIELDCAPTION("Transaction Type"):
                SalesLine.VALIDATE("Transaction Type","Transaction Type");
              FIELDCAPTION("Transport Method"):
                SalesLine.VALIDATE("Transport Method","Transport Method");
              FIELDCAPTION("Exit Point"):
                SalesLine.VALIDATE("Exit Point","Exit Point");
              FIELDCAPTION(Area):
                SalesLine.VALIDATE(Area,Area);
              FIELDCAPTION("Transaction Specification"):
                SalesLine.VALIDATE("Transaction Specification","Transaction Specification");
              FIELDCAPTION("Shipping Agent Code"):
                SalesLine.VALIDATE("Shipping Agent Code","Shipping Agent Code");
              FIELDCAPTION("Shipping Agent Service Code"):
                IF SalesLine."No." <> '' THEN
                  SalesLine.VALIDATE("Shipping Agent Service Code","Shipping Agent Service Code");
              FIELDCAPTION("Shipping Time"):
                IF SalesLine."No." <> '' THEN
                  SalesLine.VALIDATE("Shipping Time","Shipping Time");
              FIELDCAPTION("Prepayment %"):
                IF SalesLine."No." <> '' THEN
                  SalesLine.VALIDATE("Prepayment %","Prepayment %");
              FIELDCAPTION("Requested Delivery Date"):
                IF SalesLine."No." <> '' THEN
                  SalesLine.VALIDATE("Requested Delivery Date","Requested Delivery Date");
              FIELDCAPTION("Promised Delivery Date"):
                IF SalesLine."No." <> '' THEN
                  SalesLine.VALIDATE("Promised Delivery Date","Promised Delivery Date");
              FIELDCAPTION("Outbound Whse. Handling Time"):
                IF SalesLine."No." <> '' THEN
                  SalesLine.VALIDATE("Outbound Whse. Handling Time","Outbound Whse. Handling Time");
            END;
            SalesLineReserve.AssignForPlanning(SalesLine);
            SalesLine.MODIFY(TRUE);
          UNTIL SalesLine.NEXT = 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        NotRunningOnSaaS := TRUE;
        CASE ChangedFieldName OF
          FIELDCAPTION("Shipping Agent Code"),
          FIELDCAPTION("Shipping Agent Service Code"):
            NotRunningOnSaaS := NOT PermissionManager.SoftwareAsAService;
        END;
        #4..8
            IF NotRunningOnSaaS THEN
              IF DIALOG.CONFIRM(Question,TRUE) THEN
                CASE ChangedFieldName OF
                  FIELDCAPTION("Shipment Date"),
                  FIELDCAPTION("Shipping Agent Code"),
                  FIELDCAPTION("Shipping Agent Service Code"),
                  FIELDCAPTION("Shipping Time"),
                  FIELDCAPTION("Requested Delivery Date"),
                  FIELDCAPTION("Promised Delivery Date"),
                  FIELDCAPTION("Outbound Whse. Handling Time"):
                    ConfirmResvDateConflict;
                END
              ELSE
                EXIT
            ELSE
              ConfirmResvDateConflict;
        #22..72
              SalesLine.FIELDCAPTION("Deferral Code"):
                IF SalesLine."No." <> '' THEN
                  SalesLine.VALIDATE("Deferral Code");
                //>>MIGRATION NAV 2013
                // 16.05.2011
                FIELDCAPTION("Bin Code") :
                  IF SalesLine."No." <> '' THEN
                    IF (SalesLine."Location Code" =  "Location Code") THEN
                      SalesLine.VALIDATE("Bin Code","Bin Code");
                //<<MIGRATION NAV 2013
        #73..76
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "ConfirmResvDateConflict(PROCEDURE 41)".


    //Unsupported feature: Property Insertion (Local) on "ValidateShortcutDimCode(PROCEDURE 19)".


    //Unsupported feature: Property Insertion (Local) on "ShippedSalesLinesExist(PROCEDURE 22)".


    //Unsupported feature: Property Insertion (Local) on "ReturnReceiptExist(PROCEDURE 5800)".


    //Unsupported feature: Variable Insertion (Variable: ReservMgt) (VariableCollection) on "DeleteSalesLines(PROCEDURE 20)".



    //Unsupported feature: Code Modification on "DeleteSalesLines(PROCEDURE 20)".

    //procedure DeleteSalesLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF SalesLine.FINDSET THEN BEGIN
          HandleItemTrackingDeletion;
          REPEAT
            SalesLine.SuspendStatusCheck(TRUE);
            SalesLine.DELETE(TRUE);
          UNTIL SalesLine.NEXT = 0;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF SalesLine.FINDSET THEN BEGIN
          ReservMgt.DeleteDocumentReservation(DATABASE::"Sales Line","Document Type","No.",HideValidationDialog);
        #3..7
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: TaxArea) (VariableCollection) on "ValidateTaxAreaCode(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Name) on "HandleItemTrackingDeletion(PROCEDURE 36)".


    //Unsupported feature: Property Insertion (Local) on "HandleItemTrackingDeletion(PROCEDURE 36)".



    //Unsupported feature: Code Modification on "HandleItemTrackingDeletion(PROCEDURE 36)".

    //procedure HandleItemTrackingDeletion();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH ReservEntry DO BEGIN
          RESET;
          SETCURRENTKEY(
            "Source ID","Source Ref. No.","Source Type","Source Subtype",
            "Source Batch Name","Source Prod. Order Line","Reservation Status");
          SETRANGE("Source Type",DATABASE::"Sales Line");
          SETRANGE("Source Subtype","Document Type");
          SETRANGE("Source ID","No.");
          SETRANGE("Source Batch Name",'');
          SETRANGE("Source Prod. Order Line",0);
          SETFILTER("Item Tracking",'> %1',"Item Tracking"::None);
          IF ISEMPTY THEN
            EXIT;

          IF HideValidationDialog OR NOT GUIALLOWED THEN
            Confirmed := TRUE
          ELSE
            Confirmed := CONFIRM(Text052,FALSE,LOWERCASE(FORMAT("Document Type")),"No.");

          IF NOT Confirmed THEN
            ERROR('');

          IF FINDSET THEN
            REPEAT
              ReservEntry2 := ReservEntry;
              ReservEntry2.ClearItemTrackingFields;
              ReservEntry2.MODIFY;
            UNTIL NEXT = 0;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF "Tax Area Code" = '' THEN
          EXIT;
        IF TaxArea.GET("Tax Area Code") THEN
          EXIT;
        TaxArea.CreateTaxArea("Tax Area Code","Sell-to City","Sell-to County");
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "RecreateReservEntry(PROCEDURE 21)".


    //Unsupported feature: Variable Insertion (Variable: TempReqLine) (VariableCollection) on "RecreateReqLine(PROCEDURE 33)".


    //Unsupported feature: Property Insertion (Local) on "RecreateReqLine(PROCEDURE 33)".


    //Unsupported feature: Variable Insertion (Variable: OfficeContact) (VariableCollection) on "UpdateSellToCont(PROCEDURE 24)".


    //Unsupported feature: Variable Insertion (Variable: OfficeMgt) (VariableCollection) on "UpdateSellToCont(PROCEDURE 24)".


    //Unsupported feature: Variable Insertion (Variable: --) (VariableCollection) on "UpdateSellToCont(PROCEDURE 24)".


    //Unsupported feature: Variable Insertion (Variable: RecLContact) (VariableCollection) on "UpdateSellToCont(PROCEDURE 24)".


    //Unsupported feature: Property Insertion (Local) on "UpdateSellToCont(PROCEDURE 24)".



    //Unsupported feature: Code Modification on "UpdateSellToCont(PROCEDURE 24)".

    //procedure UpdateSellToCont();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Cust.GET(CustomerNo) THEN BEGIN
          IF Cust."Primary Contact No." <> '' THEN
            "Sell-to Contact No." := Cust."Primary Contact No."
          ELSE BEGIN
            ContBusRel.RESET;
            ContBusRel.SETCURRENTKEY("Link to Table","No.");
            ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Customer);
            ContBusRel.SETRANGE("No.","Sell-to Customer No.");
            IF ContBusRel.FINDFIRST THEN
              "Sell-to Contact No." := ContBusRel."Contact No."
            ELSE
              "Sell-to Contact No." := '';
          END;
          "Sell-to Contact" := Cust.Contact;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF OfficeMgt.GetContact(OfficeContact,CustomerNo) THEN BEGIN
          HideValidationDialog := TRUE;
          UpdateSellToCust(OfficeContact."No.");
          HideValidationDialog := FALSE;
        END ELSE
          IF Cust.GET(CustomerNo) THEN BEGIN
            IF Cust."Primary Contact No." <> '' THEN
              "Sell-to Contact No." := Cust."Primary Contact No."
            ELSE BEGIN
              ContBusRel.RESET;
              ContBusRel.SETCURRENTKEY("Link to Table","No.");
              ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Customer);
              ContBusRel.SETRANGE("No.","Sell-to Customer No.");
              IF ContBusRel.FINDFIRST THEN
                "Sell-to Contact No." := ContBusRel."Contact No."
              ELSE
                "Sell-to Contact No." := '';
            END;
            "Sell-to Contact" := Cust.Contact;

          //>>MIGRATION NAV 2013
          //>>FE005
          UpdateSellToFax("Sell-to Contact No.");
          UpdateSellToMail("Sell-to Contact No.");
          //<<FE005
          //<<MIGRATION NAV 2013
          END;
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "UpdateBillToCont(PROCEDURE 27)".


    //Unsupported feature: Property Insertion (Local) on "UpdateSellToCust(PROCEDURE 25)".



    //Unsupported feature: Code Modification on "UpdateSellToCust(PROCEDURE 25)".

    //procedure UpdateSellToCust();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Cont.GET(ContactNo) THEN
          "Sell-to Contact No." := Cont."No."
        ELSE BEGIN
        #4..24
            ContComp.GET(Cont."Company No.");
            "Sell-to Customer Name" := ContComp."Company Name";
            "Sell-to Customer Name 2" := ContComp."Name 2";
            "Ship-to Name" := ContComp."Company Name";
            "Ship-to Name 2" := ContComp."Name 2";
            "Ship-to Address" := ContComp.Address;
            "Ship-to Address 2" := ContComp."Address 2";
            "Ship-to City" := ContComp.City;
            "Ship-to Post Code" := ContComp."Post Code";
            "Ship-to County" := ContComp.County;
            VALIDATE("Ship-to Country/Region Code",ContComp."Country/Region Code");
            IF ("Sell-to Customer Template Code" = '') AND (NOT CustTemplate.ISEMPTY) THEN
              VALIDATE("Sell-to Customer Template Code",Cont.FindCustomerTemplate);
          END ELSE
        #39..46
          ELSE
            "Sell-to Contact" := '';

        IF "Document Type" = "Document Type"::Quote THEN BEGIN
          IF Customer.GET("Sell-to Customer No.") OR Customer.GET(ContBusinessRelation."No.") THEN BEGIN
            IF Customer."Copy Sell-to Addr. to Qte From" = Customer."Copy Sell-to Addr. to Qte From"::Company THEN BEGIN
              Cont.TESTFIELD("Company No.");
              Cont.GET(Cont."Company No.");
            END;
        #56..62
          "Sell-to Post Code" := Cont."Post Code";
          "Sell-to County" := Cont.County;
          "Sell-to Country/Region Code" := Cont."Country/Region Code";
        END;
        IF ("Sell-to Customer No." = "Bill-to Customer No.") OR
           ("Bill-to Customer No." = '')
        THEN
          VALIDATE("Bill-to Contact No.","Sell-to Contact No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..27
            SetShipToAddress(
              ContComp."Company Name",ContComp."Name 2",ContComp.Address,ContComp."Address 2",
              ContComp.City,ContComp."Post Code",ContComp.County,ContComp."Country/Region Code");
        #36..49
        //>>MIGRATION NAV 2013
        //>>todolist point 47  FLGR 09/02/2007
        //IF "Document Type" = "Document Type"::Quote THEN BEGIN
        SalesSetup.GET;
        IF ("Document Type" = "Document Type"::Quote)
           OR (("Document Type" = "Document Type"::Order) AND SalesSetup."Contact's Address on sales doc") THEN BEGIN
        //<<todolist point 47  FLGR 09/02/2007

        //<<MIGRATION NAV 2013
          IF (Customer.GET("Sell-to Customer No.") OR Customer.GET(ContBusinessRelation."No."))  THEN BEGIN
            IF (Customer."Copy Sell-to Addr. to Qte From" = Customer."Copy Sell-to Addr. to Qte From"::Company) THEN BEGIN
        #53..65

          //>>MIGRATION NAV 2013
          //>>todolist point 47  FLGR 09/02/2007
          IF "Document Type" = "Document Type"::Order THEN BEGIN
            IF CONFIRM(TextG002,FALSE) THEN BEGIN
              "Bill-to Address" := Cont.Address;
              "Bill-to Address 2" := Cont."Address 2";
              "Bill-to City" := Cont.City;
              "Bill-to Post Code" := Cont."Post Code";
              "Bill-to County" := Cont.County;
              "Bill-to Country/Region Code" := Cont."Country/Region Code";
            END;
          END;
          //<<todolist point 47  FLGR 09/02/2007
          //<<MIGRATION NAV 2013

        END;
        //>>MIGRATION NAV 2013
        //>>FE005
        UpdateSellToFax(ContactNo);
        UpdateSellToMail(ContactNo);
        //<<FE005
        //<<MIGRATION NAV 2013

        #67..70
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "UpdateBillToCust(PROCEDURE 26)".


    //Unsupported feature: Variable Insertion (Variable: ShippingAgentServices) (VariableCollection) on "GetShippingTime(PROCEDURE 23)".


    //Unsupported feature: Property Insertion (Local) on "GetShippingTime(PROCEDURE 23)".



    //Unsupported feature: Code Modification on "GetShippingTime(PROCEDURE 23)".

    //procedure GetShippingTime();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF (CalledByFieldNo <> CurrFieldNo) AND (CurrFieldNo <> 0) THEN
          EXIT;

        IF ShippingAgentService.GET("Shipping Agent Code","Shipping Agent Service Code") THEN
          "Shipping Time" := ShippingAgentService."Shipping Time"
        ELSE BEGIN
          GetCust("Sell-to Customer No.");
          "Shipping Time" := Cust."Shipping Time"
        END;
        IF NOT (CalledByFieldNo IN [FIELDNO("Shipping Agent Code"),FIELDNO("Shipping Agent Service Code")]) THEN
          VALIDATE("Shipping Time");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        IF ShippingAgentServices.GET("Shipping Agent Code","Shipping Agent Service Code") THEN
          "Shipping Time" := ShippingAgentServices."Shipping Time"
        #6..11
        */
    //end;


    //Unsupported feature: Code Modification on "CheckCreditMaxBeforeInsert(PROCEDURE 28)".

    //procedure CheckCreditMaxBeforeInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF HideCreditCheckDialogue THEN
          EXIT;
        IF GETFILTER("Sell-to Customer No.") <> '' THEN BEGIN
          IF GETRANGEMIN("Sell-to Customer No.") = GETRANGEMAX("Sell-to Customer No.") THEN BEGIN
            Cust.GET(GETRANGEMIN("Sell-to Customer No."));
            IF Cust."Bill-to Customer No." <> '' THEN
              SalesHeader."Bill-to Customer No." := Cust."Bill-to Customer No."
            ELSE
              SalesHeader."Bill-to Customer No." := Cust."No.";
            CustCheckCreditLimit.SalesHeaderCheck(SalesHeader);
          END
        END ELSE
          IF GETFILTER("Sell-to Contact No.") <> '' THEN
            IF GETRANGEMIN("Sell-to Contact No.") = GETRANGEMAX("Sell-to Contact No.") THEN BEGIN
              Cont.GET(GETRANGEMIN("Sell-to Contact No."));
              ContBusinessRelation.RESET;
              ContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
              ContBusinessRelation.SETRANGE("Link to Table",ContBusinessRelation."Link to Table"::Customer);
              ContBusinessRelation.SETRANGE("Contact No.",Cont."Company No.");
              IF ContBusinessRelation.FINDFIRST THEN BEGIN
                Cust.GET(ContBusinessRelation."No.");
                IF Cust."Bill-to Customer No." <> '' THEN
                  SalesHeader."Bill-to Customer No." := Cust."Bill-to Customer No."
                ELSE
                  SalesHeader."Bill-to Customer No." := Cust."No.";
                CustCheckCreditLimit.SalesHeaderCheck(SalesHeader);
              END;
            END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF HideCreditCheckDialogue THEN
          EXIT;
        IF (GetFilterCustNo <> '') OR ("Sell-to Customer No." <> '') THEN BEGIN
          IF "Sell-to Customer No." <> '' THEN
            Cust.GET("Sell-to Customer No.")
          ELSE
            Cust.GET(GetFilterCustNo);
          IF Cust."Bill-to Customer No." <> '' THEN
            SalesHeader."Bill-to Customer No." := Cust."Bill-to Customer No."
          ELSE
            SalesHeader."Bill-to Customer No." := Cust."No.";
          CustCheckCreditLimit.SalesHeaderCheck(SalesHeader);
        END ELSE
          IF GetFilterContNo <> '' THEN BEGIN
            Cont.GET(GetFilterContNo);
            ContBusinessRelation.RESET;
            ContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
            ContBusinessRelation.SETRANGE("Link to Table",ContBusinessRelation."Link to Table"::Customer);
            ContBusinessRelation.SETRANGE("Contact No.",Cont."Company No.");
            IF ContBusinessRelation.FINDFIRST THEN BEGIN
              Cust.GET(ContBusinessRelation."No.");
              IF Cust."Bill-to Customer No." <> '' THEN
                SalesHeader."Bill-to Customer No." := Cust."Bill-to Customer No."
              ELSE
                SalesHeader."Bill-to Customer No." := Cust."No.";
              CustCheckCreditLimit.SalesHeaderCheck(SalesHeader);
            END;
          END;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: RepLCreateInvtPutPickMvmt) (VariableCollection) on "CreateInvtPutAwayPick(PROCEDURE 29)".



    //Unsupported feature: Code Modification on "CreateInvtPutAwayPick(PROCEDURE 29)".

    //procedure CreateInvtPutAwayPick();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TESTFIELD(Status,Status::Released);

        WhseRequest.RESET;
        WhseRequest.SETCURRENTKEY("Source Document","Source No.");
        CASE "Document Type" OF
          "Document Type"::Order:
            WhseRequest.SETRANGE("Source Document",WhseRequest."Source Document"::"Sales Order");
          "Document Type"::"Return Order":
            WhseRequest.SETRANGE("Source Document",WhseRequest."Source Document"::"Sales Return Order");
        END;
        WhseRequest.SETRANGE("Source No.","No.");
        REPORT.RUNMODAL(REPORT::"Create Invt Put-away/Pick/Mvmt",TRUE,FALSE,WhseRequest);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF "Document Type" = "Document Type"::Order THEN
          IF NOT IsApprovedForPosting THEN
            EXIT;
        #1..6
            BEGIN
              IF "Shipping Advice" = "Shipping Advice"::Complete THEN
                CheckShippingAdvice;
              WhseRequest.SETRANGE("Source Document",WhseRequest."Source Document"::"Sales Order");
            END;
        #8..11

        //>>MIGRATION 2013
        RepLCreateInvtPutPickMvmt.SETTABLEVIEW(WhseRequest);
        RepLCreateInvtPutPickMvmt.InitializeRequest(FALSE,TRUE,FALSE,TRUE,FALSE);
        RepLCreateInvtPutPickMvmt.RUN;
        //REPORT.RUNMODAL(REPORT::"Create Invt Put-away/Pick/Mvmt",TRUE,FALSE,WhseRequest);
        //>>MIGRATION 2013
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateShipToAddress(PROCEDURE 31)".

    //procedure UpdateShipToAddress();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN BEGIN
          IF "Location Code" <> '' THEN BEGIN
            Location.GET("Location Code");
            "Ship-to Name" := Location.Name;
            "Ship-to Name 2" := Location."Name 2";
            "Ship-to Address" := Location.Address;
            "Ship-to Address 2" := Location."Address 2";
            "Ship-to City" := Location.City;
            "Ship-to Post Code" := Location."Post Code";
            "Ship-to County" := Location.County;
            "Ship-to Country/Region Code" := Location."Country/Region Code";
            "Ship-to Contact" := Location.Contact;
          END ELSE BEGIN
            CompanyInfo.GET;
            "Ship-to Code" := '';
            "Ship-to Name" := CompanyInfo."Ship-to Name";
            "Ship-to Name 2" := CompanyInfo."Ship-to Name 2";
            "Ship-to Address" := CompanyInfo."Ship-to Address";
            "Ship-to Address 2" := CompanyInfo."Ship-to Address 2";
            "Ship-to City" := CompanyInfo."Ship-to City";
            "Ship-to Post Code" := CompanyInfo."Ship-to Post Code";
            "Ship-to County" := CompanyInfo."Ship-to County";
            "Ship-to Country/Region Code" := CompanyInfo."Ship-to Country/Region Code";
            "Ship-to Contact" := CompanyInfo."Ship-to Contact";
          END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF IsCreditDocType THEN BEGIN
          IF "Location Code" <> '' THEN BEGIN
            Location.GET("Location Code");
            SetShipToAddress(
              Location.Name,Location."Name 2",Location.Address,Location."Address 2",Location.City,
              Location."Post Code",Location.County,Location."Country/Region Code");
        #12..15
            SetShipToAddress(
              CompanyInfo."Ship-to Name",CompanyInfo."Ship-to Name 2",CompanyInfo."Ship-to Address",CompanyInfo."Ship-to Address 2",
              CompanyInfo."Ship-to City",CompanyInfo."Ship-to Post Code",CompanyInfo."Ship-to County",
              CompanyInfo."Ship-to Country/Region Code");
        #24..26
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ShippedReceivedItemLineDimChangeConfirmed) (VariableCollection) on "UpdateAllLineDim(PROCEDURE 34)".



    //Unsupported feature: Code Modification on "UpdateAllLineDim(PROCEDURE 34)".

    //procedure UpdateAllLineDim();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        // Update all lines with changed dimensions.

        IF NewParentDimSetID = OldParentDimSetID THEN
          EXIT;
        IF NOT HideValidationDialog OR NOT GUIALLOWED THEN
          IF NOT CONFIRM(Text064) THEN
            EXIT;

        #9..14
            NewDimSetID := DimMgt.GetDeltaDimSetID(SalesLine."Dimension Set ID",NewParentDimSetID,OldParentDimSetID);
            IF SalesLine."Dimension Set ID" <> NewDimSetID THEN BEGIN
              SalesLine."Dimension Set ID" := NewDimSetID;
              DimMgt.UpdateGlobalDimFromDimSetID(
                SalesLine."Dimension Set ID",SalesLine."Shortcut Dimension 1 Code",SalesLine."Shortcut Dimension 2 Code");
              SalesLine.MODIFY;
              ATOLink.UpdateAsmDimFromSalesLine(SalesLine);
            END;
          UNTIL SalesLine.NEXT = 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        IF NOT HideValidationDialog AND GUIALLOWED THEN
        #6..17

              IF NOT HideValidationDialog AND GUIALLOWED THEN
                VerifyShippedReceivedItemLineDimChange(ShippedReceivedItemLineDimChangeConfirmed);

        #18..23
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "CreateTempAdjmtValueEntries(PROCEDURE 38)".


    //Unsupported feature: Parameter Insertion (Parameter: FieldNumber) (ParameterCollection) on "UpdateShipToAddressFromSellToAddress(PROCEDURE 50)".


    //Unsupported feature: Property Modification (Name) on "Authorize(PROCEDURE 50)".


    //Unsupported feature: Property Insertion (Local) on "Authorize(PROCEDURE 50)".



    //Unsupported feature: Code Modification on "Authorize(PROCEDURE 50)".

    //procedure Authorize();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT DOPaymentMgt.IsValidPaymentMethod("Payment Method Code") THEN
          ERROR(Text069,FIELDCAPTION("Payment Method Code"));
        DOPaymentTransLogMgt.FindValidAuthorizationEntry("Document Type","No.",DOPaymentTransLogEntry);
        IF DOPaymentTransLogEntry."Entry No." = DOPaymentMgt.AuthorizeSalesDoc(Rec,0,TRUE) THEN
          ERROR(Text067,
            DOPaymentTransLogEntry."Document Type",
            DOPaymentTransLogEntry.Amount,
            DOPaymentTransLogEntry."Transaction Date-Time",
            DOPaymentTransLogEntry."Document No.");
        "Authorization Required" := TRUE;
        MODIFY;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF ("Ship-to Code" = '') AND ShipToAddressEqualsOldSellToAddress THEN
          CASE FieldNumber OF
            FIELDNO("Ship-to Address"):
              "Ship-to Address" := "Sell-to Address";
            FIELDNO("Ship-to Address 2"):
              "Ship-to Address 2" := "Sell-to Address 2";
            FIELDNO("Ship-to City"),FIELDNO("Ship-to Post Code"):
              BEGIN
                "Ship-to City" := "Sell-to City";
                "Ship-to Post Code" := "Sell-to Post Code";
                "Ship-to County" := "Sell-to County";
                "Ship-to Country/Region Code" := "Sell-to Country/Region Code";
              END;
            FIELDNO("Ship-to County"):
              "Ship-to County" := "Sell-to County";
            FIELDNO("Ship-to Country/Region Code"):
              "Ship-to Country/Region Code" := "Sell-to Country/Region Code";
          END;
        */
    //end;

    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "ShipToAddressEqualsOldSellToAddress(PROCEDURE 51)".


    //Unsupported feature: Property Modification (Name) on "Void(PROCEDURE 51)".


    //Unsupported feature: Property Insertion (Local) on "Void(PROCEDURE 51)".



    //Unsupported feature: Code Modification on "Void(PROCEDURE 51)".

    //procedure Void();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT DOPaymentMgt.IsValidPaymentMethod("Payment Method Code") THEN
          ERROR(Text069,FIELDCAPTION("Payment Method Code"));
        CLEAR(DOPaymentMgt);
        DOPaymentMgt.CheckSalesDoc(Rec);
        IF DOPaymentTransLogMgt.FindValidAuthorizationEntry("Document Type","No.",DOPaymentTransLogEntry) THEN
          DOPaymentMgt.VoidSalesDoc(Rec,DOPaymentTransLogEntry)
        ELSE
          MESSAGE(Text068);
        "Authorization Required" := FALSE;
        MODIFY;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        EXIT(IsShipToAddressEqualToSellToAddress(xRec,Rec));
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: SellToCustomerFilter) (VariableCollection) on "CopySellToCustomerFilter(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Name) on "GetCreditcardNumber(PROCEDURE 44)".



    //Unsupported feature: Code Modification on "GetCreditcardNumber(PROCEDURE 44)".

    //procedure GetCreditcardNumber();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Credit Card No." = '' THEN
          EXIT('');
        EXIT(DOPaymentCreditCard.GetCreditCardNumber("Credit Card No."));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SellToCustomerFilter := GETFILTER("Sell-to Customer No.");
        IF SellToCustomerFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETFILTER("Sell-to Customer No.",SellToCustomerFilter);
          FILTERGROUP(0)
        END;
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "SynchronizeForReservations(PROCEDURE 42)".


    //Unsupported feature: Variable Insertion (Variable: SalesHeader) (VariableCollection) on "CheckCrLimit(PROCEDURE 47)".


    //Unsupported feature: Property Insertion (Local) on "CheckCrLimit(PROCEDURE 47)".



    //Unsupported feature: Code Modification on "CheckCrLimit(PROCEDURE 47)".

    //procedure CheckCrLimit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF GUIALLOWED AND (CurrFieldNo <> 0) AND ("Document Type" <= "Document Type"::Invoice) THEN BEGIN
          "Amount Including VAT" := 0;
          IF "Document Type" = "Document Type"::Order THEN
            IF BilltoCustomerNoChanged THEN BEGIN
        #5..9
          CustCheckCreditLimit.SalesHeaderCheck(Rec);
          CALCFIELDS("Amount Including VAT");
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SalesHeader := Rec;
        IF GUIALLOWED AND
           (CurrFieldNo <> 0) AND
           ("Document Type" <= "Document Type"::Invoice) AND
           SalesHeader.FIND
        THEN BEGIN
        #2..12
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: PrepaymentMgt) (VariableCollection) on "IsApprovedForPosting(PROCEDURE 53)".



    //Unsupported feature: Code Modification on "IsApprovedForPosting(PROCEDURE 53)".

    //procedure IsApprovedForPosting();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PurchaseHeader.INIT;
        IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN BEGIN
          IF ApprovalMgt.TestSalesPrepayment(Rec) THEN
            ERROR(STRSUBSTNO(Text071,"Document Type","No."));
          IF ApprovalMgt.TestSalesPayment(Rec) THEN
            ERROR(STRSUBSTNO(Text072,"Document Type","No."));
          EXIT(TRUE);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN BEGIN
          IF PrepaymentMgt.TestSalesPrepayment(Rec) THEN
            ERROR(STRSUBSTNO(Text071,"Document Type","No."));
          IF "Document Type" = "Document Type"::Order THEN
            IF PrepaymentMgt.TestSalesPayment(Rec) THEN
              ERROR(STRSUBSTNO(Text072,"Document Type","No."));
          EXIT(TRUE);
        END;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: PrepaymentMgt) (VariableCollection) on "IsApprovedForPostingBatch(PROCEDURE 54)".



    //Unsupported feature: Code Modification on "IsApprovedForPostingBatch(PROCEDURE 54)".

    //procedure IsApprovedForPostingBatch();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PurchaseHeader.INIT;
        IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN BEGIN
          IF ApprovalMgt.TestSalesPrepayment(Rec) THEN
            EXIT(FALSE);
          IF ApprovalMgt.TestSalesPayment(Rec) THEN
            EXIT(FALSE);
          EXIT(TRUE);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN BEGIN
          IF PrepaymentMgt.TestSalesPrepayment(Rec) THEN
            EXIT(FALSE);
          IF PrepaymentMgt.TestSalesPayment(Rec) THEN
        #6..8
        */
    //end;

    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "GetCardpageID(PROCEDURE 58)".


    //Unsupported feature: Property Modification (Name) on "ShowDirectDebitMandates(PROCEDURE 58)".



    //Unsupported feature: Code Modification on "ShowDirectDebitMandates(PROCEDURE 58)".

    //procedure ShowDirectDebitMandates();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TESTFIELD("Bill-to Customer No.");
        SEPADirectDebitMandate.SETRANGE("Customer No.","Bill-to Customer No.");
        IF "Direct Debit Mandate ID" <> '' THEN
          SEPADirectDebitMandate.GET("Direct Debit Mandate ID");
        SEPADirectDebitMandates.SETTABLEVIEW(SEPADirectDebitMandate);
        SEPADirectDebitMandates.SETRECORD(SEPADirectDebitMandate);
        IF SEPADirectDebitMandates.RUNMODAL = ACTION::OK THEN BEGIN
          SEPADirectDebitMandates.GETRECORD(SEPADirectDebitMandate);
          "Direct Debit Mandate ID" := SEPADirectDebitMandate.ID;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CASE "Document Type" OF
          "Document Type"::Quote:
            EXIT(PAGE::"Sales Quote");
          "Document Type"::Order:
            EXIT(PAGE::"Sales Order");
          "Document Type"::Invoice:
            EXIT(PAGE::"Sales Invoice");
          "Document Type"::"Credit Memo":
            EXIT(PAGE::"Sales Credit Memo");
          "Document Type"::"Blanket Order":
            EXIT(PAGE::"Blanket Sales Order");
          "Document Type"::"Return Order":
            EXIT(PAGE::"Sales Return Order");
        END;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: QtyToShipBaseTotal) (VariableCollection) on "CheckShippingAdvice(PROCEDURE 55)".


    //Unsupported feature: Variable Insertion (Variable: Result) (VariableCollection) on "CheckShippingAdvice(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Name) on "ZeroAmountInLines(PROCEDURE 55)".



    //Unsupported feature: Code Modification on "ZeroAmountInLines(PROCEDURE 55)".

    //procedure ZeroAmountInLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesLine.SetSalesHeader(SalesHeader);
        SalesLine.SETRANGE("Document Type","Document Type");
        SalesLine.SETRANGE("Document No.","No.");
        SalesLine.SETFILTER(Type,'>0');
        SalesLine.SETFILTER(Quantity,'<>0');
        IF SalesLine.FINDSET(TRUE) THEN
          REPEAT
            SalesLine.Amount := 0;
            SalesLine."Amount Including VAT" := 0;
            SalesLine."VAT Base Amount" := 0;
            SalesLine.InitOutstandingAmount;
            SalesLine.MODIFY;
          UNTIL SalesLine.NEXT = 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SalesLine.SETRANGE("Document Type","Document Type");
        SalesLine.SETRANGE("Document No.","No.");
        SalesLine.SETRANGE("Drop Shipment",FALSE);
        Result := TRUE;
        IF SalesLine.FINDSET THEN
          REPEAT
            IF SalesLine.IsShipment THEN BEGIN
              QtyToShipBaseTotal += SalesLine."Qty. to Ship (Base)";
              IF SalesLine."Quantity (Base)" <>
                 SalesLine."Qty. to Ship (Base)" + SalesLine."Qty. Shipped (Base)"
              THEN
                Result := FALSE;
            END;
          UNTIL SalesLine.NEXT = 0;
        IF QtyToShipBaseTotal = 0 THEN
          Result := TRUE;
        IF NOT Result THEN
          ERROR(ShippingAdviceErr);
        */
    //end;

    procedure InitInsert()
    var
        NoSeries: Record "308";
    begin
        IF "No." = '' THEN BEGIN
          TestNoSeries;
          NoSeries.GET(GetNoSeriesCode);
          IF (NOT NoSeries."Default Nos.") AND SelectNoSeriesAllowed AND NoSeriesMgt.IsSeriesSelected THEN
            "No." := NoSeriesMgt.GetNextNo(NoSeries.Code,"Posting Date",TRUE)
          ELSE
            NoSeriesMgt.InitSeries(NoSeries.Code,xRec."No. Series","Posting Date","No.","No. Series");
        END;

        InitRecord;
    end;

    local procedure InitNoSeries()
    begin
        IF xRec."Shipping No." <> '' THEN BEGIN
          "Shipping No. Series" := xRec."Shipping No. Series";
          "Shipping No." := xRec."Shipping No.";
        END;
        IF xRec."Posting No." <> '' THEN BEGIN
          "Posting No. Series" := xRec."Posting No. Series";
          "Posting No." := xRec."Posting No.";
        END;
        IF xRec."Return Receipt No." <> '' THEN BEGIN
          "Return Receipt No. Series" := xRec."Return Receipt No. Series";
          "Return Receipt No." := xRec."Return Receipt No.";
        END;
        IF xRec."Prepayment No." <> '' THEN BEGIN
          "Prepayment No. Series" := xRec."Prepayment No. Series";
          "Prepayment No." := xRec."Prepayment No.";
        END;
        IF xRec."Prepmt. Cr. Memo No." <> '' THEN BEGIN
          "Prepmt. Cr. Memo No. Series" := xRec."Prepmt. Cr. Memo No. Series";
          "Prepmt. Cr. Memo No." := xRec."Prepmt. Cr. Memo No.";
        END;
    end;

    local procedure CheckShipmentInfo(var SalesLine: Record "37";BillTo: Boolean)
    begin
        IF "Document Type" = "Document Type"::Order THEN
          SalesLine.SETFILTER("Quantity Shipped",'<>0')
        ELSE
          IF "Document Type" = "Document Type"::Invoice THEN BEGIN
            IF NOT BillTo THEN
              SalesLine.SETRANGE("Sell-to Customer No.",xRec."Sell-to Customer No.");
            SalesLine.SETFILTER("Shipment No.",'<>%1','');
          END;

        IF SalesLine.FINDFIRST THEN
          IF "Document Type" = "Document Type"::Order THEN
            SalesLine.TESTFIELD("Quantity Shipped",0)
          ELSE
            SalesLine.TESTFIELD("Shipment No.",'');
        SalesLine.SETRANGE("Shipment No.");
        SalesLine.SETRANGE("Quantity Shipped");
    end;

    local procedure CheckPrepmtInfo(var SalesLine: Record "37")
    begin
        IF "Document Type" = "Document Type"::Order THEN BEGIN
          SalesLine.SETFILTER("Prepmt. Amt. Inv.",'<>0');
          IF SalesLine.FIND('-') THEN
            SalesLine.TESTFIELD("Prepmt. Amt. Inv.",0);
          SalesLine.SETRANGE("Prepmt. Amt. Inv.");
        END;
    end;

    local procedure CheckReturnInfo(var SalesLine: Record "37";BillTo: Boolean)
    begin
        IF "Document Type" = "Document Type"::"Return Order" THEN
          SalesLine.SETFILTER("Return Qty. Received",'<>0')
        ELSE
          IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
            IF NOT BillTo THEN
              SalesLine.SETRANGE("Sell-to Customer No.",xRec."Sell-to Customer No.");
            SalesLine.SETFILTER("Return Receipt No.",'<>%1','');
          END;

        IF SalesLine.FINDFIRST THEN
          IF "Document Type" = "Document Type"::"Return Order" THEN
            SalesLine.TESTFIELD("Return Qty. Received",0)
          ELSE
            SalesLine.TESTFIELD("Return Receipt No.",'');
    end;

    local procedure UpdateSellToCustTemplateCode()
    var
        CustomerTemplate: Record "5105";
        Contact: Record "5050";
    begin
        IF ("Document Type" = "Document Type"::Quote) AND ("Sell-to Customer No." = '') AND ("Sell-to Customer Template Code" = '') AND
           (GetFilterContNo = '')
        THEN BEGIN
          Contact.GET("Sell-to Contact No.");
          IF Contact.Type = Contact.Type::Person THEN
            Contact.GET(Contact."Company No.");
          IF NOT Contact.ContactToCustBusinessRelationExist THEN
            IF CONFIRM(SelectCustomerTemplateQst,FALSE) THEN BEGIN
              COMMIT;
              IF PAGE.RUNMODAL(0,CustomerTemplate) = ACTION::LookupOK THEN
                VALIDATE("Sell-to Customer Template Code",CustomerTemplate.Code);
            END;
        END;
    end;

    local procedure VerifyShippedReceivedItemLineDimChange(var ShippedReceivedItemLineDimChangeConfirmed: Boolean)
    begin
        IF SalesLine.IsShippedReceivedItemDimChanged THEN
          IF NOT ShippedReceivedItemLineDimChangeConfirmed THEN
            ShippedReceivedItemLineDimChangeConfirmed := SalesLine.ConfirmShippedReceivedItemDimChange;
    end;

    procedure GetCustomerVATRegistrationNumber(): Text
    begin
        EXIT("VAT Registration No.");
    end;

    procedure GetCustomerVATRegistrationNumberLbl(): Text
    begin
        EXIT(FIELDCAPTION("VAT Registration No."));
    end;

    procedure GetCustomerGlobalLocationNumber(): Text
    begin
        EXIT('');
    end;

    procedure GetCustomerGlobalLocationNumberLbl(): Text
    begin
        EXIT('');
    end;

    procedure CheckItemAvailabilityInLines()
    var
        SalesLine: Record "37";
        ItemCheckAvail: Codeunit "311";
    begin
        SalesLine.SETRANGE("Document Type","Document Type");
        SalesLine.SETRANGE("Document No.","No.");
        SalesLine.SETRANGE(Type,SalesLine.Type::Item);
        SalesLine.SETFILTER("No.",'<>%1','');
        SalesLine.SETFILTER("Outstanding Quantity",'<>%1',0);
        IF SalesLine.FINDSET THEN
          REPEAT
            IF ItemCheckAvail.SalesLineCheck(SalesLine) THEN
              ItemCheckAvail.RaiseUpdateInterruptedError;
          UNTIL SalesLine.NEXT = 0;
    end;

    procedure GetLegalStatement(): Text
    begin
        SalesSetup.GET;
        EXIT(SalesSetup.GetLegalStatement);
    end;

    local procedure GetFilterCustNo(): Code[20]
    begin
        IF GETFILTER("Sell-to Customer No.") <> '' THEN
          IF GETRANGEMIN("Sell-to Customer No.") = GETRANGEMAX("Sell-to Customer No.") THEN
            EXIT(GETRANGEMAX("Sell-to Customer No."));
    end;

    local procedure GetFilterContNo(): Code[20]
    begin
        IF GETFILTER("Sell-to Contact No.") <> '' THEN
          IF GETRANGEMIN("Sell-to Contact No.") = GETRANGEMAX("Sell-to Contact No.") THEN
            EXIT(GETRANGEMAX("Sell-to Contact No."));
    end;

    local procedure CheckCreditLimitIfLineNotInsertedYet()
    begin
        IF "No." = '' THEN BEGIN
          HideCreditCheckDialogue := FALSE;
          CheckCreditMaxBeforeInsert;
          HideCreditCheckDialogue := TRUE;
        END;
    end;

    procedure InvoicedLineExists(): Boolean
    var
        SalesLine: Record "37";
    begin
        SalesLine.SETRANGE("Document Type","Document Type");
        SalesLine.SETRANGE("Document No.","No.");
        SalesLine.SETFILTER(Type,'<>%1',SalesLine.Type::" ");
        SalesLine.SETFILTER("Quantity Invoiced",'<>%1',0);
        EXIT(NOT SalesLine.ISEMPTY);
    end;

    procedure CreateDimSetForPrepmtAccDefaultDim()
    var
        SalesLine: Record "37";
        TempSalesLine: Record "37" temporary;
    begin
        SalesLine.SETRANGE("Document Type","Document Type");
        SalesLine.SETRANGE("Document No.","No.");
        SalesLine.SETFILTER("Prepmt. Amt. Inv.",'<>%1',0);
        IF SalesLine.FINDSET THEN
          REPEAT
            CollectParamsInBufferForCreateDimSet(TempSalesLine,SalesLine);
          UNTIL SalesLine.NEXT = 0;
        TempSalesLine.RESET;
        TempSalesLine.MARKEDONLY(FALSE);
        IF TempSalesLine.FINDSET THEN
          REPEAT
            SalesLine.CreateDim(DATABASE::"G/L Account",TempSalesLine."No.",
              DATABASE::Job,TempSalesLine."Job No.",
              DATABASE::"Responsibility Center",TempSalesLine."Responsibility Center");
          UNTIL TempSalesLine.NEXT = 0;
    end;

    local procedure CollectParamsInBufferForCreateDimSet(var TempSalesLine: Record "37" temporary;SalesLine: Record "37")
    var
        GenPostingSetup: Record "252";
        DefaultDimension: Record "352";
    begin
        TempSalesLine.SETRANGE("Gen. Bus. Posting Group",SalesLine."Gen. Bus. Posting Group");
        TempSalesLine.SETRANGE("Gen. Prod. Posting Group",SalesLine."Gen. Prod. Posting Group");
        IF NOT TempSalesLine.FINDFIRST THEN BEGIN
          GenPostingSetup.GET(SalesLine."Gen. Bus. Posting Group",SalesLine."Gen. Prod. Posting Group");
          GenPostingSetup.TESTFIELD("Sales Prepayments Account");
          DefaultDimension.SETRANGE("Table ID",DATABASE::"G/L Account");
          DefaultDimension.SETRANGE("No.",GenPostingSetup."Sales Prepayments Account");
          InsertTempSalesLineInBuffer(TempSalesLine,SalesLine,GenPostingSetup."Sales Prepayments Account",DefaultDimension.ISEMPTY);
        END ELSE
          IF NOT TempSalesLine.MARK THEN BEGIN
            TempSalesLine.SETRANGE("Job No.",SalesLine."Job No.");
            TempSalesLine.SETRANGE("Responsibility Center",SalesLine."Responsibility Center");
            IF TempSalesLine.ISEMPTY THEN
              InsertTempSalesLineInBuffer(TempSalesLine,SalesLine,TempSalesLine."No.",FALSE);
          END;
    end;

    local procedure InsertTempSalesLineInBuffer(var TempSalesLine: Record "37" temporary;SalesLine: Record "37";AccountNo: Code[20];DefaultDimensionsNotExist: Boolean)
    begin
        TempSalesLine.INIT;
        TempSalesLine."Line No." := SalesLine."Line No.";
        TempSalesLine."No." := AccountNo;
        TempSalesLine."Job No." := SalesLine."Job No.";
        TempSalesLine."Responsibility Center" := SalesLine."Responsibility Center";
        TempSalesLine."Gen. Bus. Posting Group" := SalesLine."Gen. Bus. Posting Group";
        TempSalesLine."Gen. Prod. Posting Group" := SalesLine."Gen. Prod. Posting Group";
        TempSalesLine.MARK := DefaultDimensionsNotExist;
        TempSalesLine.INSERT;
    end;

    procedure OpenSalesOrderStatistics()
    begin
        CalcInvDiscForHeader;
        CreateDimSetForPrepmtAccDefaultDim;
        COMMIT;
        PAGE.RUNMODAL(PAGE::"Sales Order Statistics",Rec);
    end;

    procedure CheckAvailableCreditLimit(): Decimal
    var
        Customer: Record "18";
        AvailableCreditLimit: Decimal;
    begin
        IF NOT Customer.GET("Bill-to Customer No.") THEN
          Customer.GET("Sell-to Customer No.");

        AvailableCreditLimit := Customer.CalcAvailableCredit;

        IF AvailableCreditLimit < 0 THEN
          OnCustomerCreditLimitExceeded
        ELSE
          OnCustomerCreditLimitNotExceeded;

        EXIT(AvailableCreditLimit);
    end;

    procedure SetStatus(NewStatus: Option)
    begin
        Status := NewStatus;
        MODIFY;
    end;

    local procedure TestSalesLineFieldsBeforeRecreate()
    begin
        SalesLine.TESTFIELD("Job No.",'');
        SalesLine.TESTFIELD("Job Contract Entry No.",0);
        SalesLine.TESTFIELD("Quantity Shipped",0);
        SalesLine.TESTFIELD("Quantity Invoiced",0);
        SalesLine.TESTFIELD("Return Qty. Received",0);
        SalesLine.TESTFIELD("Shipment No.",'');
        SalesLine.TESTFIELD("Return Receipt No.",'');
        SalesLine.TESTFIELD("Blanket Order No.",'');
        SalesLine.TESTFIELD("Prepmt. Amt. Inv.",0);
    end;

    local procedure RecreateReservEntryReqLine(var TempSalesLine: Record "37" temporary;var TempATOLink: Record "904" temporary;var ATOLink: Record "904")
    begin
        REPEAT
          TestSalesLineFieldsBeforeRecreate;
          IF (SalesLine."Location Code" <> "Location Code") AND NOT SalesLine.IsServiceItem THEN
            SalesLine.VALIDATE("Location Code","Location Code");
          TempSalesLine := SalesLine;
          IF SalesLine.Nonstock THEN BEGIN
            SalesLine.Nonstock := FALSE;
            SalesLine.MODIFY;
          END;

          IF ATOLink.AsmExistsForSalesLine(TempSalesLine) THEN BEGIN
            TempATOLink := ATOLink;
            TempATOLink.INSERT;
            ATOLink.DELETE;
          END;

          TempSalesLine.INSERT;
          RecreateReservEntry(SalesLine,0,TRUE);
          RecreateReqLine(SalesLine,0,TRUE);
        UNTIL SalesLine.NEXT = 0;
    end;

    local procedure TransferItemChargeAssgntSalesToTemp(var ItemChargeAssgntSales: Record "5809";var TempItemChargeAssgntSales: Record "5809" temporary)
    begin
        IF ItemChargeAssgntSales.FINDSET THEN BEGIN
          REPEAT
            TempItemChargeAssgntSales.INIT;
            TempItemChargeAssgntSales := ItemChargeAssgntSales;
            TempItemChargeAssgntSales.INSERT;
          UNTIL ItemChargeAssgntSales.NEXT = 0;
          ItemChargeAssgntSales.DELETEALL;
        END;
    end;

    local procedure CreateSalesLine(var TempSalesLine: Record "37" temporary)
    begin
        SalesLine.INIT;
        SalesLine."Line No." := SalesLine."Line No." + 10000;
        SalesLine.VALIDATE(Type,TempSalesLine.Type);
        IF TempSalesLine."No." = '' THEN BEGIN
          SalesLine.VALIDATE(Description,TempSalesLine.Description);
          SalesLine.VALIDATE("Description 2",TempSalesLine."Description 2");
        END ELSE BEGIN
          SalesLine.VALIDATE("No.",TempSalesLine."No.");
          IF SalesLine.Type <> SalesLine.Type::" " THEN BEGIN
            SalesLine.VALIDATE("Unit of Measure Code",TempSalesLine."Unit of Measure Code");
            SalesLine.VALIDATE("Variant Code",TempSalesLine."Variant Code");
            IF TempSalesLine.Quantity <> 0 THEN BEGIN
              SalesLine.VALIDATE(Quantity,TempSalesLine.Quantity);
              SalesLine.VALIDATE("Qty. to Assemble to Order",TempSalesLine."Qty. to Assemble to Order");
            END;
            SalesLine."Purchase Order No." := TempSalesLine."Purchase Order No.";
            SalesLine."Purch. Order Line No." := TempSalesLine."Purch. Order Line No.";
            SalesLine."Drop Shipment" := SalesLine."Purch. Order Line No." <> 0;
          END;
          SalesLine.VALIDATE("Shipment Date",TempSalesLine."Shipment Date");
        END;
        SalesLine.INSERT;
    end;

    local procedure CreateItemChargeAssgntSales(var ItemChargeAssgntSales: Record "5809";var TempItemChargeAssgntSales: Record "5809" temporary;var TempSalesLine: Record "37" temporary;var TempInteger: Record "2000000026" temporary)
    begin
        IF TempSalesLine.FINDSET THEN
          REPEAT
            TempItemChargeAssgntSales.SETRANGE("Document Line No.",TempSalesLine."Line No.");
            IF TempItemChargeAssgntSales.FINDSET THEN BEGIN
              REPEAT
                TempInteger.FINDFIRST;
                ItemChargeAssgntSales.INIT;
                ItemChargeAssgntSales := TempItemChargeAssgntSales;
                ItemChargeAssgntSales."Document Line No." := TempInteger.Number;
                ItemChargeAssgntSales.VALIDATE("Unit Cost",0);
                ItemChargeAssgntSales.INSERT;
              UNTIL TempItemChargeAssgntSales.NEXT = 0;
              TempInteger.DELETE;
            END;
          UNTIL TempSalesLine.NEXT = 0;
    end;

    local procedure UpdateOutboundWhseHandlingTime()
    begin
        IF "Location Code" <> '' THEN BEGIN
          IF Location.GET("Location Code") THEN
            "Outbound Whse. Handling Time" := Location."Outbound Whse. Handling Time";
            //>>MIGRATION NAV 2013
            //>> 16.05.2011
            VALIDATE("Shipment Method Code");
            IF "Bin Code" = '' THEN
              "Bin Code":= Location."Shipment Bin Code";
            //<<MIGRATION NAV 2013
        END ELSE BEGIN
          IF InvtSetup.GET THEN
            "Outbound Whse. Handling Time" := InvtSetup."Outbound Whse. Handling Time";
            //>>MIGRATION NAV 2013
            "Bin Code" := '';
            //<<MIGRATION NAV 2013
        END;
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnCheckSalesPostRestrictions()
    begin
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnCustomerCreditLimitExceeded()
    begin
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnCustomerCreditLimitNotExceeded()
    begin
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnCheckSalesReleaseRestrictions()
    begin
    end;

    procedure DeferralHeadersExist(): Boolean
    var
        DeferralHeader: Record "1701";
        DeferralUtilities: Codeunit "1720";
    begin
        DeferralHeader.SETRANGE("Deferral Doc. Type",DeferralUtilities.GetSalesDeferralDocType);
        DeferralHeader.SETRANGE("Gen. Jnl. Template Name",'');
        DeferralHeader.SETRANGE("Gen. Jnl. Batch Name",'');
        DeferralHeader.SETRANGE("Document Type","Document Type");
        DeferralHeader.SETRANGE("Document No.","No.");
        EXIT(NOT DeferralHeader.ISEMPTY);
    end;

    procedure SetSellToCustomerFromFilter()
    var
        SellToCustomerNo: Code[20];
    begin
        SellToCustomerNo := GetFilterCustNo;
        IF SellToCustomerNo = '' THEN BEGIN
          FILTERGROUP(2);
          SellToCustomerNo := GetFilterCustNo;
          FILTERGROUP(0);
        END;
        IF SellToCustomerNo <> '' THEN
          VALIDATE("Sell-to Customer No.",SellToCustomerNo);
    end;

    local procedure ConfirmUpdateDeferralDate()
    begin
        IF HideValidationDialog THEN
          Confirmed := TRUE
        ELSE
          Confirmed := CONFIRM(DeferralLineQst,FALSE);
        IF Confirmed THEN
          UpdateSalesLines(SalesLine.FIELDCAPTION("Deferral Code"),FALSE);
    end;

    procedure BatchConfirmUpdateDeferralDate(var BatchConfirm: Option " ",Skip,Update;ReplacePostingDate: Boolean;PostingDateReq: Date)
    begin
        IF (NOT ReplacePostingDate) OR (PostingDateReq = "Posting Date") OR (BatchConfirm = BatchConfirm::Skip) THEN
          EXIT;

        IF NOT DeferralHeadersExist THEN
          EXIT;

        "Posting Date" := PostingDateReq;
        CASE BatchConfirm OF
          BatchConfirm::" ":
            BEGIN
              ConfirmUpdateDeferralDate;
              IF Confirmed THEN
                BatchConfirm := BatchConfirm::Update
              ELSE
                BatchConfirm := BatchConfirm::Skip;
            END;
          BatchConfirm::Update:
            UpdateSalesLines(SalesLine.FIELDCAPTION("Deferral Code"),FALSE);
        END;
        COMMIT;
    end;

    procedure GetSelectedPaymentServicesText(): Text
    var
        PaymentServiceSetup: Record "1060";
    begin
        EXIT(PaymentServiceSetup.GetSelectedPaymentsText("Payment Service Set ID"));
    end;

    procedure SetDefaultPaymentServices()
    var
        PaymentServiceSetup: Record "1060";
        SetID: Integer;
    begin
        IF NOT PaymentServiceSetup.CanChangePaymentService(Rec) THEN
          EXIT;

        IF PaymentServiceSetup.GetDefaultPaymentServices(SetID) THEN
          VALIDATE("Payment Service Set ID",SetID);
    end;

    procedure ChangePaymentServiceSetting()
    var
        PaymentServiceSetup: Record "1060";
        SetID: Integer;
    begin
        SetID := "Payment Service Set ID";
        IF PaymentServiceSetup.SelectPaymentService(SetID) THEN BEGIN
          VALIDATE("Payment Service Set ID",SetID);
          MODIFY(TRUE);
        END;
    end;

    procedure IsCreditDocType(): Boolean
    begin
        EXIT("Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"]);
    end;

    local procedure UpdateCustomerAddress()
    var
        Customer: Record "18";
    begin
        IF Customer.GET("Sell-to Customer No.") THEN
          IF NOT Customer.HasAddress THEN
            CASE TRUE OF
              HasSellToAddress:
                CopySellToCustomerAddressFieldsFromSalesDocument(Customer);
              HasShipToAddress:
                CopyShipToCustomerAddressFieldsFromSalesDocument(Customer);
            END;

        IF "Bill-to Customer No." <> "Sell-to Customer No." THEN
          IF Customer.GET("Bill-to Customer No.") THEN
            IF NOT Customer.HasAddress THEN
              CopyBillToCustomerAddressFieldsFromSalesDocument(Customer);
    end;

    local procedure CopySellToCustomerAddressFieldsFromSalesDocument(var Customer: Record "18")
    begin
        Customer.Address := "Sell-to Address";
        Customer."Address 2" := "Sell-to Address 2";
        Customer.City := "Sell-to City";
        Customer.Contact := "Sell-to Contact";
        Customer."Country/Region Code" := "Sell-to Country/Region Code";
        Customer.County := "Sell-to County";
        Customer."Post Code" := "Sell-to Post Code";
        Customer.MODIFY(TRUE);
    end;

    local procedure CopyShipToCustomerAddressFieldsFromSalesDocument(var Customer: Record "18")
    begin
        Customer.Address := "Ship-to Address";
        Customer."Address 2" := "Ship-to Address 2";
        Customer.City := "Ship-to City";
        Customer.Contact := "Ship-to Contact";
        Customer."Country/Region Code" := "Ship-to Country/Region Code";
        Customer.County := "Ship-to County";
        Customer."Post Code" := "Ship-to Post Code";
        Customer.MODIFY(TRUE);
    end;

    local procedure CopyBillToCustomerAddressFieldsFromSalesDocument(var Customer: Record "18")
    begin
        Customer.Address := "Bill-to Address";
        Customer."Address 2" := "Bill-to Address 2";
        Customer.City := "Bill-to City";
        Customer.Contact := "Bill-to Contact";
        Customer."Country/Region Code" := "Bill-to Country/Region Code";
        Customer.County := "Bill-to County";
        Customer."Post Code" := "Bill-to Post Code";
        Customer.MODIFY(TRUE);
    end;

    local procedure UpdateShipToContact()
    begin
        IF NOT (CurrFieldNo IN [FIELDNO("Sell-to Contact"),FIELDNO("Sell-to Contact No.")]) THEN
          EXIT;

        IF IsCreditDocType THEN
          EXIT;

        VALIDATE("Ship-to Contact","Sell-to Contact");
    end;

    procedure HasSellToAddress(): Boolean
    begin
        CASE TRUE OF
          "Sell-to Address" <> '':
            EXIT(TRUE);
          "Sell-to Address 2" <> '':
            EXIT(TRUE);
          "Sell-to City" <> '':
            EXIT(TRUE);
          "Sell-to Country/Region Code" <> '':
            EXIT(TRUE);
          "Sell-to County" <> '':
            EXIT(TRUE);
          "Sell-to Post Code" <> '':
            EXIT(TRUE);
          "Sell-to Contact" <> '':
            EXIT(TRUE);
        END;

        EXIT(FALSE);
    end;

    procedure HasShipToAddress(): Boolean
    begin
        CASE TRUE OF
          "Ship-to Address" <> '':
            EXIT(TRUE);
          "Ship-to Address 2" <> '':
            EXIT(TRUE);
          "Ship-to City" <> '':
            EXIT(TRUE);
          "Ship-to Country/Region Code" <> '':
            EXIT(TRUE);
          "Ship-to County" <> '':
            EXIT(TRUE);
          "Ship-to Post Code" <> '':
            EXIT(TRUE);
          "Ship-to Contact" <> '':
            EXIT(TRUE);
        END;

        EXIT(FALSE);
    end;

    procedure HasBillToAddress(): Boolean
    begin
        CASE TRUE OF
          "Bill-to Address" <> '':
            EXIT(TRUE);
          "Bill-to Address 2" <> '':
            EXIT(TRUE);
          "Bill-to City" <> '':
            EXIT(TRUE);
          "Bill-to Country/Region Code" <> '':
            EXIT(TRUE);
          "Bill-to County" <> '':
            EXIT(TRUE);
          "Bill-to Post Code" <> '':
            EXIT(TRUE);
          "Bill-to Contact" <> '':
            EXIT(TRUE);
        END;

        EXIT(FALSE);
    end;

    local procedure CopySellToCustomerAddressFieldsFromCustomer(var SellToCustomer: Record "18")
    begin
        IF SellToCustomerIsReplaced OR ShouldCopyAddressFromSellToCustomer(SellToCustomer) THEN BEGIN
          "Sell-to Address" := SellToCustomer.Address;
          "Sell-to Address 2" := SellToCustomer."Address 2";
          "Sell-to City" := SellToCustomer.City;
          "Sell-to Post Code" := SellToCustomer."Post Code";
          "Sell-to County" := SellToCustomer.County;
          "Sell-to Country/Region Code" := SellToCustomer."Country/Region Code";
        END;
    end;

    local procedure CopyShipToCustomerAddressFieldsFromCustomer(var SellToCustomer: Record "18")
    begin
        IF SellToCustomerIsReplaced OR ShipToAddressEqualsOldSellToAddress THEN BEGIN
          "Ship-to Address" := SellToCustomer.Address;
          "Ship-to Address 2" := SellToCustomer."Address 2";
          "Ship-to City" := SellToCustomer.City;
          "Ship-to Post Code" := SellToCustomer."Post Code";
          "Ship-to County" := SellToCustomer.County;
          VALIDATE("Ship-to Country/Region Code",SellToCustomer."Country/Region Code");
        END;
    end;

    local procedure CopyBillToCustomerAddressFieldsFromCustomer(var BillToCustomer: Record "18")
    begin
        IF BillToCustomerIsReplaced OR ShouldCopyAddressFromBillToCustomer(BillToCustomer) THEN BEGIN
          "Bill-to Address" := BillToCustomer.Address;
          "Bill-to Address 2" := BillToCustomer."Address 2";
          "Bill-to City" := BillToCustomer.City;
          "Bill-to Post Code" := BillToCustomer."Post Code";
          "Bill-to County" := BillToCustomer.County;
          "Bill-to Country/Region Code" := BillToCustomer."Country/Region Code";
        END;
    end;

    local procedure SetShipToAddress(ShipToName: Text[50];ShipToName2: Text[50];ShipToAddress: Text[50];ShipToAddress2: Text[50];ShipToCity: Text[30];ShipToPostCode: Code[20];ShipToCounty: Text[30];ShipToCountryRegionCode: Code[10])
    begin
        "Ship-to Name" := ShipToName;
        "Ship-to Name 2" := ShipToName2;
        "Ship-to Address" := ShipToAddress;
        "Ship-to Address 2" := ShipToAddress2;
        "Ship-to City" := ShipToCity;
        "Ship-to Post Code" := ShipToPostCode;
        "Ship-to County" := ShipToCounty;
        "Ship-to Country/Region Code" := ShipToCountryRegionCode;
    end;

    local procedure ShouldCopyAddressFromSellToCustomer(SellToCustomer: Record "18"): Boolean
    begin
        EXIT((NOT HasSellToAddress) AND SellToCustomer.HasAddress);
    end;

    local procedure ShouldCopyAddressFromBillToCustomer(BillToCustomer: Record "18"): Boolean
    begin
        EXIT((NOT HasBillToAddress) AND BillToCustomer.HasAddress);
    end;

    local procedure SellToCustomerIsReplaced(): Boolean
    begin
        EXIT((xRec."Sell-to Customer No." <> '') AND (xRec."Sell-to Customer No." <> "Sell-to Customer No."));
    end;

    local procedure BillToCustomerIsReplaced(): Boolean
    begin
        EXIT((xRec."Bill-to Customer No." <> '') AND (xRec."Bill-to Customer No." <> "Bill-to Customer No."));
    end;

    procedure ShipToAddressEqualsSellToAddress(): Boolean
    begin
        EXIT(IsShipToAddressEqualToSellToAddress(Rec,Rec));
    end;

    local procedure IsShipToAddressEqualToSellToAddress(SalesHeaderWithSellTo: Record "36";SalesHeaderWithShipTo: Record "36"): Boolean
    begin
        IF (SalesHeaderWithSellTo."Sell-to Address" = SalesHeaderWithShipTo."Ship-to Address") AND
           (SalesHeaderWithSellTo."Sell-to Address 2" = SalesHeaderWithShipTo."Ship-to Address 2") AND
           (SalesHeaderWithSellTo."Sell-to City" = SalesHeaderWithShipTo."Ship-to City") AND
           (SalesHeaderWithSellTo."Sell-to County" = SalesHeaderWithShipTo."Ship-to County") AND
           (SalesHeaderWithSellTo."Sell-to Post Code" = SalesHeaderWithShipTo."Ship-to Post Code") AND
           (SalesHeaderWithSellTo."Sell-to Country/Region Code" = SalesHeaderWithShipTo."Ship-to Country/Region Code") AND
           (SalesHeaderWithSellTo."Sell-to Contact" = SalesHeaderWithShipTo."Ship-to Contact")
        THEN
          EXIT(TRUE);
    end;

    procedure CopySellToAddressToShipToAddress()
    begin
        VALIDATE("Ship-to Address","Sell-to Address");
        VALIDATE("Ship-to Address 2","Sell-to Address 2");
        VALIDATE("Ship-to City","Sell-to City");
        VALIDATE("Ship-to Contact","Sell-to Contact");
        VALIDATE("Ship-to Country/Region Code","Sell-to Country/Region Code");
        VALIDATE("Ship-to County","Sell-to County");
        VALIDATE("Ship-to Post Code","Sell-to Post Code");
    end;

    procedure ConfirmCloseUnposted(): Boolean
    var
        InstructionMgt: Codeunit "1330";
    begin
        //BC6>>
        EXIT(TRUE);
        //BC6<<
        IF SalesLinesExist THEN
          EXIT(InstructionMgt.ShowConfirm(DocumentNotPostedClosePageQst,InstructionMgt.QueryPostOnCloseCode));
        EXIT(TRUE)
    end;

    local procedure UpdateOpportunity()
    var
        Opp: Record "5092";
        OpportunityEntry: Record "5093";
    begin
        IF NOT ("Opportunity No." <> '') OR NOT ("Document Type" IN ["Document Type"::Quote,"Document Type"::Order]) THEN
          EXIT;

        IF NOT Opp.GET("Opportunity No.") THEN
          EXIT;

        IF "Document Type" = "Document Type"::Order THEN BEGIN
          IF NOT CONFIRM(Text040,TRUE) THEN
            ERROR(Text044);

          OpportunityEntry.SETRANGE("Opportunity No.","Opportunity No.");
          OpportunityEntry.MODIFYALL(Active,FALSE);

          OpportunityEntry.INIT;
          OpportunityEntry.VALIDATE("Opportunity No.",Opp."No.");

          OpportunityEntry.LOCKTABLE;
          OpportunityEntry."Entry No." := GetOpportunityEntryNo;
          OpportunityEntry."Sales Cycle Code" := Opp."Sales Cycle Code";
          OpportunityEntry."Contact No." := Opp."Contact No.";
          OpportunityEntry."Contact Company No." := Opp."Contact Company No.";
          OpportunityEntry."Salesperson Code" := Opp."Salesperson Code";
          OpportunityEntry."Campaign No." := Opp."Campaign No.";
          OpportunityEntry."Action Taken" := OpportunityEntry."Action Taken"::Lost;
          OpportunityEntry.Active := TRUE;
          OpportunityEntry."Completed %" := 100;
          OpportunityEntry."Estimated Value (LCY)" := GetOpportunityEntryEstimatedValue;
          OpportunityEntry."Estimated Close Date" := Opp."Date Closed";
          OpportunityEntry.INSERT(TRUE);
        END;
        Opp.FIND;
        Opp."Sales Document Type" := Opp."Sales Document Type"::" ";
        Opp."Sales Document No." := '';
        Opp.MODIFY;
        "Opportunity No." := '';
    end;

    local procedure GetOpportunityEntryNo(): Integer
    var
        OpportunityEntry: Record "5093";
    begin
        IF OpportunityEntry.FINDLAST THEN
          EXIT(OpportunityEntry."Entry No." + 1);
        EXIT(1);
    end;

    local procedure GetOpportunityEntryEstimatedValue(): Decimal
    var
        OpportunityEntry: Record "5093";
    begin
        OpportunityEntry.SETRANGE("Opportunity No.","Opportunity No.");
        IF OpportunityEntry.FINDLAST THEN
          EXIT(OpportunityEntry."Estimated Value (LCY)");
    end;

    procedure InitFromSalesHeader(SourceSalesHeader: Record "36")
    begin
        //>>MIGRATION NAV 2013
        //GESTION_DATE FRGO 05/12/06 NSC1.01
        // "Document Date" := SourceSalesHeader."Document Date";
        // "Shipment Date" := SourceSalesHeader."Shipment Date";
        VALIDATE("Order Date",WORKDATE);
        VALIDATE("Posting Date",WORKDATE);
        IF "Shipment Date" < WORKDATE THEN
          VALIDATE("Shipment Date",WORKDATE)
        ELSE
          "Shipment Date" := "Shipment Date";
        //Fin GESTION_DATE FRGO 05/12/06 NSC1.01

        //GESTION_DOC_EXT FRGO 05/12/06 NSC1.01
        "External Document No." := SourceSalesHeader."External Document No." ;
        "Document description"  := SourceSalesHeader."Document description" ;
        //Fin GESTION_DOC_EXT FRGO 05/12/06 NSC1.01
        //>>FE014
        //SalesOrderHeader.VALIDATE("Customer Quote No.", "No.");
        //>>FE014
        //<<MIGRATION NAV 2013

        "Shortcut Dimension 1 Code" := SourceSalesHeader."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := SourceSalesHeader."Shortcut Dimension 2 Code";
        "Dimension Set ID" := SourceSalesHeader."Dimension Set ID";
        "Location Code" := SourceSalesHeader."Location Code";
        //>>MIGRATION NAV 2013 - 2017
        //>> CNE4.01 Bin default
        IF SourceSalesHeader."Location Code" <> '' THEN
          BEGIN
            IF Location.GET("Location Code") THEN
              IF SourceSalesHeader."Bin Code" = '' THEN
                "Bin Code":= Location."Shipment Bin Code";
        END ELSE BEGIN
            "Bin Code" := '';
        END;
        //<<MIGRATION NAV 2013 - 2017

        SetShipToAddress(
          SourceSalesHeader."Ship-to Name",SourceSalesHeader."Ship-to Name 2",SourceSalesHeader."Ship-to Address",
          SourceSalesHeader."Ship-to Address 2",SourceSalesHeader."Ship-to City",SourceSalesHeader."Ship-to Post Code",
          SourceSalesHeader."Ship-to County",SourceSalesHeader."Ship-to Country/Region Code");
        "Ship-to Contact" := SourceSalesHeader."Ship-to Contact";
    end;

    local procedure InitFromContact(ContactNo: Code[20];CustomerNo: Code[20];ContactCaption: Text): Boolean
    begin
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type","Document Type");
        SalesLine.SETRANGE("Document No.","No.");
        IF (ContactNo = '') AND (CustomerNo = '') THEN BEGIN
          IF NOT SalesLine.ISEMPTY THEN
            ERROR(Text005,ContactCaption);
          INIT;
          SalesSetup.GET;
          "No. Series" := xRec."No. Series";
          InitRecord;
          InitNoSeries;
          EXIT(TRUE);
        END;
    end;

    local procedure InitFromTemplate(TemplateCode: Code[20];TemplateCaption: Text): Boolean
    begin
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type","Document Type");
        SalesLine.SETRANGE("Document No.","No.");
        IF TemplateCode = '' THEN BEGIN
          IF NOT SalesLine.ISEMPTY THEN
            ERROR(Text005,TemplateCaption);
          INIT;
          SalesSetup.GET;
          "No. Series" := xRec."No. Series";
          InitRecord;
          InitNoSeries;
          EXIT(TRUE);
        END;
    end;

    procedure SetWorkDescription(NewWorkDescription: Text)
    var
        TempBlob: Record "99008535" temporary;
    begin
        CLEAR("Work Description");
        IF NewWorkDescription = '' THEN
          EXIT;
        TempBlob.Blob := "Work Description";
        TempBlob.WriteAsText(NewWorkDescription,TEXTENCODING::Windows);
        "Work Description" := TempBlob.Blob;
        MODIFY;
    end;

    procedure GetWorkDescription(): Text
    var
        TempBlob: Record "99008535" temporary;
        CR: Text[1];
    begin
        CALCFIELDS("Work Description");
        IF NOT "Work Description".HASVALUE THEN
          EXIT('');
        CR[1] := 10;
        TempBlob.Blob := "Work Description";
        EXIT(TempBlob.ReadAsText(CR,TEXTENCODING::Windows));
    end;

    local procedure LookupContact(CustomerNo: Code[20];ContactNo: Code[20];var Contact: Record "5050")
    var
        ContactBusinessRelation: Record "5054";
    begin
        ContactBusinessRelation.SETCURRENTKEY("Link to Table","No.");
        ContactBusinessRelation.SETRANGE("Link to Table",ContactBusinessRelation."Link to Table"::Customer);
        ContactBusinessRelation.SETRANGE("No.",CustomerNo);
        IF ContactBusinessRelation.FINDFIRST THEN
          Contact.SETRANGE("Company No.",ContactBusinessRelation."Contact No.")
        ELSE
          Contact.SETRANGE("Company No.",'');
        IF ContactNo <> '' THEN
          IF Contact.GET(ContactNo) THEN ;
    end;

    procedure SetAllowSelectNoSeries()
    begin
        SelectNoSeriesAllowed := TRUE;
    end;

    procedure "---NSC1.00---"()
    begin
    end;

    procedure UpdateIncoterm()
    begin
        IF RecGCustomer.GET("Bill-to Customer No.")THEN BEGIN
           "Transaction Type" := RecGCustomer."Transaction Type";
           "Transaction Specification" := RecGCustomer."Transaction Specification";
           "Transport Method" := RecGCustomer."Transport Method";
           "Exit Point" := RecGCustomer."Exit Point";
           Area := RecGCustomer.Area;
        END;
    end;

    procedure CreatePurchaseQuote(RecLSalesHeader: Record "36")
    var
        RecLSalesLine: Record "37";
        RecLItem: Record "27";
        RecLPurchSetup: Record "312";
        CduLNoSeriesMgt: Codeunit "396";
        TextL001: Label '%1 Purchase Quote already existfor vendor %3, the newest from %2 do you to create a new one ?';
        CduLCopyDocMgt: Codeunit "6620";
        RecLPurchLine: Record "39";
        NextLineNo: Integer;
        CodLLastVendor: Code[20];
        RecLPurchquoteHeader2: Record "38";
        RecLPurchquoteHeader: Record "38";
        BooLCreate: Boolean;
        IntLnumberofQuote: Integer;
        TextL002: Label '%1 quote created';
        RecLSalesLine2: Record "37";
    begin
        RecLSalesLine.RESET;
        RecLSalesLine.SETCURRENTKEY("Document Type",RecLSalesLine."Buy-from Vendor No.");
        RecLSalesLine.SETRANGE(RecLSalesLine."Document Type",RecLSalesHeader."Document Type");
        RecLSalesLine.SETRANGE(RecLSalesLine."Document No.",RecLSalesHeader."No.");
        RecLSalesLine.SETRANGE(RecLSalesLine.Type,RecLSalesLine.Type::Item);
        
        RecLSalesLine.SETFILTER("Special Order", '%1',FALSE);
        RecLSalesLine.SETFILTER("Drop Shipment", '%1',FALSE);
        
        RecLSalesLine2.COPYFILTERS(RecLSalesLine);
        IntLnumberofQuote := 0;
        
        IF RecLSalesLine.FIND('-') THEN
        BEGIN
          REPEAT
            IF RecLItem.GET(RecLSalesLine."No.") THEN
              //Entete devis achat
              IF CodLLastVendor <> RecLSalesLine."Buy-from Vendor No." THEN
              BEGIN
                CodLLastVendor := RecLSalesLine."Buy-from Vendor No.";
        
                BooLCreate := TRUE;
                RecLPurchquoteHeader2.RESET;
                RecLPurchquoteHeader2.SETRANGE("Document Type","Document Type"::Quote);
                RecLPurchquoteHeader2.SETFILTER("Buy-from Vendor No.", RecLSalesLine."Buy-from Vendor No.");
                IF RecLPurchquoteHeader2.FIND('+')THEN
                  IF NOT CONFIRM(TextL001,TRUE,RecLPurchquoteHeader2.COUNT, RecLPurchquoteHeader2."Document Date",
                  RecLPurchquoteHeader2."Buy-from Vendor Name") THEN
                    BooLCreate := FALSE;
        
                IF BooLCreate THEN
                BEGIN
                  IntLnumberofQuote +=1;
                  RecLPurchquoteHeader.SetHideValidationDialog(TRUE);
                  RecLPurchquoteHeader.INIT;
                  RecLPurchquoteHeader."No." := '';
                  RecLPurchquoteHeader.VALIDATE("Document Date" , WORKDATE);
                  RecLPurchquoteHeader.VALIDATE("Buy-from Vendor No.",RecLItem."Vendor No.");
                  RecLPurchquoteHeader.VALIDATE("Your Reference" , RecLSalesHeader."No.");
                  RecLPurchquoteHeader.VALIDATE("Sell-to Customer No.",RecLSalesHeader."Sell-to Customer No.") ;
                  RecLPurchquoteHeader.VALIDATE("Purchaser Code" ,RecLSalesHeader."Salesperson Code") ;
                  //FG
                  RecLPurchquoteHeader."From Sales Module" := TRUE ;
                  RecLPurchquoteHeader.INSERT(TRUE);
        
                  //Ligne Devis achat
                  NextLineNo := 10000;
        
                  RecLSalesLine2.SETFILTER("Buy-from Vendor No.",RecLPurchquoteHeader."Buy-from Vendor No.");
                  IF RecLSalesLine2.FIND('-') THEN
                  BEGIN
                    REPEAT
                      RecLPurchLine.INIT;
                      RecLPurchLine.VALIDATE("Document Type" ,RecLPurchLine."Document Type"::Quote);
                      RecLPurchLine.VALIDATE("Document No." , RecLPurchquoteHeader."No.");
                      RecLPurchLine.VALIDATE("Line No." , NextLineNo);
                      CduLCopyDocMgt.TransfldsFromSalesToPurchLine(RecLSalesLine2,RecLPurchLine);
                      RecLPurchLine.VALIDATE("Purchasing Code" ,RecLSalesLine2."Purchasing Code");
                      //>>FE004.02
                      RecLPurchLine.VALIDATE("Sales No.", RecLSalesLine2."Document No.");
                      RecLPurchLine.VALIDATE("Sales Line No.", RecLSalesLine2."Line No.");
                      RecLPurchLine.VALIDATE("Sales Document Type", RecLSalesHeader."Document Type");
                      //>>FE004.02
                      RecLPurchLine.INSERT(TRUE);
                      NextLineNo := NextLineNo + 10000;
        
                      RecLSalesLine2.VALIDATE("Purch. Order No.", RecLPurchLine."Document No.");
                      RecLSalesLine2.VALIDATE("Purch. Line No.",RecLPurchLine."Line No.");
                      RecLSalesLine2.VALIDATE("Purch. Document Type", RecLPurchLine."Document Type");
                      RecLSalesLine2.VALIDATE("Purchase cost", RecLPurchLine."Discount Direct Unit Cost");
        
                      //>>FEP-ACHAT-200706_18_A.001
                      RecLSalesLine2.VALIDATE("Purchase Receipt Date", RecLPurchLine."Expected Receipt Date");
                      //<<FEP-ACHAT-200706_18_A.001
        
                      /*RecLSalesLine2."Purch. Order No." := RecLPurchLine."Document No.";
                      RecLSalesLine2."Purch. Line No." := RecLPurchLine."Line No.";
                      RecLSalesLine2."Purch. Document Type" := RecLPurchLine."Document Type";*/
                      RecLSalesLine2.MODIFY(TRUE);
        
                    UNTIL RecLSalesLine2.NEXT = 0 ;
                  END;
                END;
              END;
           // RecLSalesLine.SETFILTER(RecLSalesLine."Buy-from Vendor No.",'');
        
          UNTIL RecLSalesLine.NEXT = 0;
          IF BooLCreate THEN
          BEGIN
            MESSAGE(TextL002 , IntLnumberofQuote);
            PAGE.RUN(49, RecLPurchquoteHeader);
          END;
        END;

    end;

    procedure verifyquotestatus(): Boolean
    var
        RecLQuotehdr: Record "36";
        RecLAccessControl: Record "2000000053";
    begin
        //>>FE015
        //>>MIGRATION NAV 2013
        //OLD
        /*
        RecLMembers.RESET ;
        RecLMembers.SETRANGE(RecLMembers."User ID",USERID) ;
        RecLMembers.SETRANGE(RecLMembers."Role ID",'SUPER') ;
        IF NOT RecLMembers.FIND('-') AND ("Document Type" = "Document Type"::Quote) THEN
        */
        //NEW
        RecLAccessControl.RESET ;
        RecLAccessControl.SETRANGE("User Security ID",USERSECURITYID) ;
        RecLAccessControl.SETRANGE("Role ID",'SUPER') ;
        IF NOT RecLAccessControl.FINDFIRST AND ("Document Type" = "Document Type"::Quote) THEN
        //<<MIGRATION NAV 2013
        
        // aucun blocage si c'est l'admin !
        BEGIN
          SalesSetup.GET;
          SalesSetup.TESTFIELD(Nbr_Devis);
          SalesSetup.TESTFIELD(Période);
          RecLQuotehdr.SETRANGE("Document Type", RecLQuotehdr."Document Type"::Quote);
          RecLQuotehdr.SETFILTER("Sell-to Customer No.", "Sell-to Customer No.");
          RecLQuotehdr.SETRANGE("Document Date" , CALCDATE('-' + FORMAT(SalesSetup.Période),WORKDATE ), WORKDATE);
          IF (RecLQuotehdr.COUNT <= SalesSetup.Nbr_Devis) OR ("Quote statut" = "Quote statut"::approved) THEN
            EXIT(TRUE)
          ELSE
          BEGIN
            "Quote statut" := "Quote statut"::locked;
            PAGE.RUN(PAGE::"Quote Blocked",Rec);
            EXIT(FALSE);
          END;
        END;
        EXIT(TRUE);

    end;

    procedure UpdateSellToFax(CodContactNo: Code[20])
    var
        RecLContact: Record "5050";
    begin
        //>>FE005
        IF RecLContact.GET(CodContactNo) THEN
          "Sell-to Fax No." := RecLContact."Fax No."
        ELSE
          "Sell-to Fax No." := '';
        //<<FE005
    end;

    procedure UpdateSellToMail(CodContactNo: Code[20])
    var
        RecLContact: Record "5050";
    begin
        //>>FE005
        IF RecLContact.GET(CodContactNo) THEN
          "Sell-to E-Mail Address" := RecLContact."E-Mail"
        ELSE
          "Sell-to E-Mail Address" := '';
        //<<FE005
    end;

    procedure CopySellToAddress(var FromCurrFieldNo: Integer)
    begin
        // CNE6.01
        IF (FromCurrFieldNo = 0) THEN
          EXIT;

        IF NOT ("Copy Sell-to Address") THEN
          EXIT;

        // Invoice To Address
        CASE FromCurrFieldNo OF
          FIELDNO("Sell-to Customer Name"):
            "Bill-to Name" := "Sell-to Customer Name";
          FIELDNO("Sell-to Customer Name 2"):
            "Bill-to Name 2" := "Sell-to Customer Name 2";
          FIELDNO("Sell-to Address"):
            "Bill-to Address" := "Sell-to Address";
          FIELDNO("Sell-to Address 2"):
            "Bill-to Address 2" := "Sell-to Address 2";
          FIELDNO("Sell-to City"):
            BEGIN
              "Bill-to City" := "Sell-to City";
              // CNE6.01A
              // VALIDATE("Bill-to City")
              "Bill-to Post Code" := "Sell-to Post Code";
              "Bill-to County" := "Sell-to County";
              "Bill-to Country/Region Code" := "Sell-to Country/Region Code";
          END;
          FIELDNO("Sell-to Post Code"):
            BEGIN
              "Bill-to Post Code" := "Sell-to Post Code";
              // CNE6.01A
              // VALIDATE("Bill-to Post Code")
              "Bill-to City" := "Sell-to City";
              "Bill-to County" := "Sell-to County";
              "Bill-to Country/Region Code" := "Sell-to Country/Region Code";
          END;
          FIELDNO("Sell-to County"):
            "Bill-to County" := "Sell-to County";
          FIELDNO("Sell-to Contact"):
            "Bill-to Contact" := "Sell-to Contact";
        END;

        // Ship-to Address
        CASE FromCurrFieldNo OF
          FIELDNO("Sell-to Customer Name"):
            "Ship-to Name" := "Sell-to Customer Name";
          FIELDNO("Sell-to Customer Name 2"):
            "Ship-to Name 2" := "Sell-to Customer Name 2";
          FIELDNO("Sell-to Address"):
            "Ship-to Address" := "Sell-to Address";
          FIELDNO("Sell-to Address 2"):
            "Ship-to Address 2" := "Sell-to Address 2";
          FIELDNO("Sell-to City"):
            BEGIN
              "Ship-to City" := "Sell-to City";
              // CNE6.01A
              // VALIDATE("Ship-to City");
              "Ship-to Post Code" := "Sell-to Post Code";
              "Ship-to County" := "Sell-to County";
              "Ship-to Country/Region Code" := "Sell-to Country/Region Code";
          END;

          FIELDNO("Sell-to Post Code"):
            BEGIN
              "Ship-to Post Code" := "Sell-to Post Code";
              // CNE6.01A
              // VALIDATE("Ship-to Post Code");
              "Ship-to City" := "Sell-to City";
              "Ship-to County" := "Sell-to County";
              "Ship-to Country/Region Code" := "Sell-to Country/Region Code";
          END;
          FIELDNO("Sell-to County"):
            "Ship-to County" := "Sell-to County";
          FIELDNO("Sell-to Contact"):
            "Ship-to Contact" := "Sell-to Contact";
        END;
    end;

    local procedure "---BCSYS---"()
    begin
    end;

    local procedure UpdateSalesLineReturnType()
    var
        L_SalesLine: Record "37";
    begin
        IF "Document Type" <> "Document Type"::"Return Order" THEN
          EXIT;

        IF xRec."Return Order Type" <> Rec."Return Order Type" THEN
          L_SalesLine.RESET;
          L_SalesLine.SETRANGE("Document Type","Document Type");
          L_SalesLine.SETRANGE("Document No.","No.");
          IF L_SalesLine.FINDFIRST THEN
              L_SalesLine.MODIFYALL("Return Order Type","Return Order Type");
    end;

    procedure IsDeleteFromReturn(NewIsDeleteFromReturnOrder: Boolean)
    begin
        IsDeleteFromReturnOrder := NewIsDeleteFromReturnOrder;
    end;

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: Brick)".


    //Unsupported feature: Deletion (VariableCollection) on "RecreateSalesLines(PROCEDURE 4).SalesLineTmp(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "HandleItemTrackingDeletion(PROCEDURE 36).ReservEntry2(Variable 1000)".


    //Unsupported feature: Property Insertion (Temporary) on "ClearItemAssgntSalesFilter(PROCEDURE 17).TempItemChargeAssgntSales(Parameter 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "Authorize(PROCEDURE 50).DOPaymentTransLogEntry(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "Void(PROCEDURE 51).DOPaymentTransLogEntry(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "Void(PROCEDURE 51).DOPaymentTransLogMgt(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "GetCreditcardNumber(PROCEDURE 44).DOPaymentCreditCard(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "IsApprovedForPosting(PROCEDURE 53).PurchaseHeader(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "IsApprovedForPostingBatch(PROCEDURE 54).PurchaseHeader(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "ShowDirectDebitMandates(PROCEDURE 58).SEPADirectDebitMandate(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "ShowDirectDebitMandates(PROCEDURE 58).SEPADirectDebitMandates(Variable 1001)".


    var
        ShipToAddr: Record "222";

    var
        WMSManagement: Codeunit "7302";
        BinCode: Code[20];
        Bin: Record "7354";
        ShipmentMethodRec: Record "10";

    var
        GenJnlLine: Record "81";
        GenJnlApply: Codeunit "225";
        ApplyCustEntries: Page "232";

    var
        BoolReclose: Boolean;

    var
        CustEntrySetApplID: Codeunit "101";

    var
        BoolReclose: Boolean;

    var
        PostSalesDelete: Codeunit "363";
        ArchiveManagement: Codeunit "5063";


        //Unsupported feature: Property Modification (Id) on "ReservEntry(Variable 1079)".

        //var
        //>>>> ORIGINAL VALUE:
        //ReservEntry : 1079;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ReservEntry : 1001;
        //Variable type has not been exported.


        //Unsupported feature: Property Modification (Id) on "TempReservEntry(Variable 1080)".

        //var
        //>>>> ORIGINAL VALUE:
        //TempReservEntry : 1080;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //TempReservEntry : 1000;
        //Variable type has not been exported.


        //Unsupported feature: Property Modification (Id) on "CompanyInfo(Variable 1094)".

        //var
        //>>>> ORIGINAL VALUE:
        //CompanyInfo : 1094;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CompanyInfo : 1002;
        //Variable type has not been exported.

    var
        ConfirmChangeQst: Label 'Do you want to change %1?', Comment = '%1 = a Field Caption like Currency Code';

    var
        ApprovalsMgmt: Codeunit "1535";

    var
        DeferralLineQst: Label 'Do you want to update the deferral schedules for the lines?';

    var
        ShippingAdviceErr: Label 'This order must be a complete shipment.';
        PostedDocsToPrintCreatedMsg: Label 'One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.';
        SellToCustomerTxt: Label 'Sell-to Customer';
        BillToCustomerTxt: Label 'Bill-to Customer';
        DocumentNotPostedClosePageQst: Label 'The document has not been posted.\Are you sure you want to exit?';
        SelectCustomerTemplateQst: Label 'Do you want to select the customer template?';
        SelectNoSeriesAllowed: Boolean;
        "-NSC1.00-": Integer;
        RecGCustomer: Record "18";
        RecGParamNavi: Record "50004";
        RecGCommentLine: Record "97";
        FrmGLignesCommentaires: Page "124";
        "---NSC1.01": ;
        TextG001: Label 'Warning, using foreign currency will generate wrong profit calculation.';
        CDUReleaseDoc: Codeunit "414";
        TextG002: Label 'Update Bill-to address ?';
        TextG003: Label 'Warning: you have already placed this order purchase.';
        UpdateSalesShipment: Codeunit "50015";
        "-BCSYS-": Integer;
        G_ReturnOrderMgt: Codeunit "50052";
        IsDeleteFromReturnOrder: Boolean;
}

