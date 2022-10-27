tableextension 50038 tableextension50038 extends "Purchase Header"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm]             Mise à jour Codes INCOTERM Onglet "INTERNATIONAL"
    //                                                              sur le trigger "Buy-from Vendor No. - OnValidate()"
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Post_It]              Affiche les textes de type postit
    //                                                              sur le trigger "Sell-to Customer No. - OnValidate()"
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ 50003
    //                                                              Ajout code pr récupérer Tiers payeur dans trigger
    //                                                              Buy-from Vendor No. - OnValidate()
    // //ACHATS      BRRI 01.08.2006 COR001 [15]                    Correction perte du lien vers commande vente
    // 
    // //CONTROLEMINIMA SM 11/10/06 NCS1.01 [FE02] Ajout de la fonction ControleMinimMNTandQTE
    //                                              Contrôle Minima MNT et QTE
    // 
    // //AjoutCodeUtilisateur RD 13/11/06 NCS1.01 [FE019V1] Ajout du code utilisateur dans les documents d'achats & ventes
    //                                                      Ajout du champ 50010
    // 
    // //NSC1.0 FG 04/12/06 FE002.2 correction gestion frais de port
    // //DEMANDEPRIX 08/01/06 FE004 FLGR 08/01/2006
    // //FE005 SEBC 08/01/2007 Add field
    //                         50021 Buy-from Fax No.
    // //FE002.2 NSC1.01 CASC 12/01/2007  : Correction Freight Charge
    // //Propagation CASC 18/01/2007 NSC1.01 : Modify Field Name from field 50010 'Uder ID' => 'ID'
    // //FE002.3 NSC1.01 FLGR 23/01/2007 : Correction Freight Charge todolist point 29
    // 
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    // 
    // //>>CNE1.00
    // FEP-ADVE-200706_18_A.001:MA 14/11/2007 : gestion des appels d'offres clients
    //     - add field "Affair No."
    // ------------------------------------------------------------------------
    // 
    // //FE005 MICO 21/02/2007 : Ajout champ 50022 Buy-from E-Mail Address
    //                                 fonction UpdateBuyFromMail
    // //TODOLIST point 66 FLGR 21/02/2007 : modif libelle ecriture article
    // //VERSIONNING FG 28/02/07 suite au Merge
    // //REGIE:ARHA 29/04/2007 Correct DEEE with Purchase Quote
    // 
    // //>>CNE2.05
    // FEP-ACHAT-200706_18_A.01:LY 25/01/2008 : change field 50010 length from 10 to 20
    // 
    // MIGRATION 2013
    // Modify function CreateInvtPutAwayPick()
    // ------------------------------------------------------------------------
    // //>>CNEIC : 06/2015 : Ajout du champ 50080 pour lien avec la commande de vente
    //                       CTRL lors de la suppression, pour une filiale, qu'il n'existe pas de commande vente lien.
    // 
    // //>> CNE : 25/06 : Flux SAV
    //           Ajout du champ 50100 "Return Order Type"
    LookupPageID = 53;
    fields
    {
        modify("Pay-to Name")
        {
            TableRelation = Vendor;

            //Unsupported feature: Property Insertion (ValidateTableRelation) on ""Pay-to Name"(Field 5)".

        }
        modify("Pay-to City")
        {
            TableRelation = IF (Pay-to Country/Region Code=CONST()) "Post Code".City
                            ELSE IF (Pay-to Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Pay-to Country/Region Code));
        }
        modify("Ship-to City")
        {
            TableRelation = IF (Ship-to Country/Region Code=CONST()) "Post Code".City
                            ELSE IF (Ship-to Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Ship-to Country/Region Code));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Order Date"(Field 19)".

        modify("Expected Receipt Date")
        {
            Caption = 'Expected Receipt Date';
        }
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

        //Unsupported feature: Property Modification (CalcFormula) on "Comment(Field 46)".

        modify("Bal. Account No.")
        {
            TableRelation = IF (Bal. Account Type=CONST(G/L Account)) "G/L Account"
                            ELSE IF (Bal. Account Type=CONST(Bank Account)) "Bank Account";
        }

        //Unsupported feature: Property Modification (CalcFormula) on "Amount(Field 60)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Amount Including VAT"(Field 61)".

        modify("Buy-from Vendor Name")
        {
            TableRelation = Vendor;

            //Unsupported feature: Property Insertion (ValidateTableRelation) on ""Buy-from Vendor Name"(Field 79)".

        }
        modify("Buy-from City")
        {
            TableRelation = IF (Buy-from Country/Region Code=CONST()) "Post Code".City
                            ELSE IF (Buy-from Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Buy-from Country/Region Code));
        }
        modify("Pay-to Post Code")
        {
            TableRelation = IF (Pay-to Country/Region Code=CONST()) "Post Code"
                            ELSE IF (Pay-to Country/Region Code=FILTER(<>'')) "Post Code" WHERE (Country/Region Code=FIELD(Pay-to Country/Region Code));
        }
        modify("Buy-from Post Code")
        {
            TableRelation = IF (Buy-from Country/Region Code=CONST()) "Post Code"
                            ELSE IF (Buy-from Country/Region Code=FILTER(<>'')) "Post Code" WHERE (Country/Region Code=FIELD(Buy-from Country/Region Code));
        }
        modify("Ship-to Post Code")
        {
            TableRelation = IF (Ship-to Country/Region Code=CONST()) "Post Code"
                            ELSE IF (Ship-to Country/Region Code=FILTER(<>'')) "Post Code" WHERE (Country/Region Code=FIELD(Ship-to Country/Region Code));
        }
        modify("Incoming Document Entry No.")
        {
            TableRelation = "Incoming Document";
        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Invoice Discount Amount"(Field 1305)".


        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Archived Versions"(Field 5043)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Completely Received"(Field 5752)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Posting from Whse. Ref."(Field 5753)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Requested Receipt Date"(Field 5790)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Lead Time Calculation"(Field 5792)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Inbound Whse. Handling Time"(Field 5793)".



        //Unsupported feature: Code Modification on ""Buy-from Vendor No."(Field 2).OnValidate".

        //trigger "(Field 2)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            IF ("Buy-from Vendor No." <> xRec."Buy-from Vendor No.") AND
               (xRec."Buy-from Vendor No." <> '')
            THEN BEGIN
              IF HideValidationDialog THEN
                Confirmed := TRUE
              ELSE
                Confirmed := CONFIRM(Text004,FALSE,FIELDCAPTION("Buy-from Vendor No."));
              IF Confirmed THEN BEGIN
                PurchLine.SETRANGE("Document Type","Document Type");
                PurchLine.SETRANGE("Document No.","No.");
                IF "Buy-from Vendor No." = '' THEN BEGIN
                  IF NOT PurchLine.ISEMPTY THEN
                    ERROR(
                      Text005,
                      FIELDCAPTION("Buy-from Vendor No."));
                  INIT;
                  PurchSetup.GET;
                  "No. Series" := xRec."No. Series";
                  InitRecord;
                  IF xRec."Receiving No." <> '' THEN BEGIN
                    "Receiving No. Series" := xRec."Receiving No. Series";
                    "Receiving No." := xRec."Receiving No.";
                  END;
                  IF xRec."Posting No." <> '' THEN BEGIN
                    "Posting No. Series" := xRec."Posting No. Series";
                    "Posting No." := xRec."Posting No.";
                  END;
                  IF xRec."Return Shipment No." <> '' THEN BEGIN
                    "Return Shipment No. Series" := xRec."Return Shipment No. Series";
                    "Return Shipment No." := xRec."Return Shipment No.";
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
                  PurchLine.SETFILTER("Quantity Received",'<>0')
                ELSE
                  IF "Document Type" = "Document Type"::Invoice THEN BEGIN
                    PurchLine.SETRANGE("Buy-from Vendor No.",xRec."Buy-from Vendor No.");
                    PurchLine.SETFILTER("Receipt No.",'<>%1','');
                  END;
                IF PurchLine.FINDFIRST THEN
                  IF "Document Type" = "Document Type"::Order THEN
                    PurchLine.TESTFIELD("Quantity Received",0)
                  ELSE
                    PurchLine.TESTFIELD("Receipt No.",'');

                PurchLine.SETRANGE("Receipt No.");
                PurchLine.SETRANGE("Quantity Received");
                PurchLine.SETRANGE("Buy-from Vendor No.");

                IF "Document Type" = "Document Type"::Order THEN BEGIN
                  PurchLine.SETFILTER("Prepmt. Amt. Inv.",'<>0');
                  IF PurchLine.FIND('-') THEN
                    PurchLine.TESTFIELD("Prepmt. Amt. Inv.",0);
                  PurchLine.SETRANGE("Prepmt. Amt. Inv.");
                END;

                IF "Document Type" = "Document Type"::"Return Order" THEN
                  PurchLine.SETFILTER("Return Qty. Shipped",'<>0')
                ELSE
                  IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                    PurchLine.SETRANGE("Buy-from Vendor No.",xRec."Buy-from Vendor No.");
                    PurchLine.SETFILTER("Return Shipment No.",'<>%1','');
                  END;
                IF PurchLine.FINDFIRST THEN
                  IF "Document Type" = "Document Type"::"Return Order" THEN
                    PurchLine.TESTFIELD("Return Qty. Shipped",0)
                  ELSE
                    PurchLine.TESTFIELD("Return Shipment No.",'');

                PurchLine.RESET;
              END ELSE BEGIN
                Rec := xRec;
                EXIT;
              END;
            END;

            GetVend("Buy-from Vendor No.");
            Vend.CheckBlockedVendOnDocs(Vend,FALSE);
            Vend.TESTFIELD("Gen. Bus. Posting Group");
            "Buy-from Vendor Name" := Vend.Name;
            "Buy-from Vendor Name 2" := Vend."Name 2";
            "Buy-from Address" := Vend.Address;
            "Buy-from Address 2" := Vend."Address 2";
            "Buy-from City" := Vend.City;
            "Buy-from Post Code" := Vend."Post Code";
            "Buy-from County" := Vend.County;
            "Buy-from Country/Region Code" := Vend."Country/Region Code";
            IF NOT SkipBuyFromContact THEN
              "Buy-from Contact" := Vend.Contact;
            "Gen. Bus. Posting Group" := Vend."Gen. Bus. Posting Group";
            "VAT Bus. Posting Group" := Vend."VAT Bus. Posting Group";
            "Tax Area Code" := Vend."Tax Area Code";
            "Tax Liable" := Vend."Tax Liable";
            "VAT Country/Region Code" := Vend."Country/Region Code";
            "VAT Registration No." := Vend."VAT Registration No.";
            VALIDATE("Lead Time Calculation",Vend."Lead Time Calculation");
            "Responsibility Center" := UserSetupMgt.GetRespCenter(1,Vend."Responsibility Center");
            VALIDATE("Sell-to Customer No.",'');
            VALIDATE("Location Code",UserSetupMgt.GetLocation(1,Vend."Location Code","Responsibility Center"));

            IF "Buy-from Vendor No." = xRec."Pay-to Vendor No." THEN BEGIN
              IF ReceivedPurchLinesExist OR ReturnShipmentExist THEN BEGIN
                TESTFIELD("VAT Bus. Posting Group",xRec."VAT Bus. Posting Group");
                TESTFIELD("Gen. Bus. Posting Group",xRec."Gen. Bus. Posting Group");
              END;
            END;

            "Buy-from IC Partner Code" := Vend."IC Partner Code";
            "Send IC Document" := ("Buy-from IC Partner Code" <> '') AND ("IC Direction" = "IC Direction"::Outgoing);

            IF Vend."Pay-to Vendor No." <> '' THEN
              VALIDATE("Pay-to Vendor No.",Vend."Pay-to Vendor No.")
            ELSE BEGIN
              IF "Buy-from Vendor No." = "Pay-to Vendor No." THEN
                SkipPayToContact := TRUE;
              VALIDATE("Pay-to Vendor No.","Buy-from Vendor No.");
              SkipPayToContact := FALSE;
            END;
            "Order Address Code" := '';

            VALIDATE("Order Address Code");

            IF (xRec."Buy-from Vendor No." <> "Buy-from Vendor No.") OR
               (xRec."Currency Code" <> "Currency Code") OR
               (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group") OR
               (xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group")
            THEN
              RecreatePurchLines(FIELDCAPTION("Buy-from Vendor No."));

            IF NOT SkipBuyFromContact THEN
              UpdateBuyFromCont("Buy-from Vendor No.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF "No." = '' THEN
              InitRecord;
            #1..4
              CheckDropShipmentLineExists;
            #5..7
                Confirmed := CONFIRM(ConfirmChangeQst,FALSE,BuyFromVendorTxt);
              IF Confirmed THEN BEGIN
                IF InitFromVendor("Buy-from Vendor No.",FIELDCAPTION("Buy-from Vendor No.")) THEN
                  EXIT;

                CheckReceiptInfo(PurchLine,FALSE);
                CheckPrepmtInfo(PurchLine);
                CheckReturnInfo(PurchLine,FALSE);
            #79..86
            //>>MIGRATION NAV 2013
            //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Post_It]  Affiche les textes de type postit
            //IF NOT HideValidationDialog THEN
            IF CurrFieldNo <> 0 THEN
             IF RecGParamNavi.FIND THEN BEGIN
              IF RecGParamNavi."Used Post-it"<>'' THEN BEGIN
               RecGCommentLine.SETRANGE(Code,RecGParamNavi."Used Post-it");
               RecGCommentLine.SETRANGE("No.","Buy-from Vendor No.");
               IF RecGCommentLine.FIND('-') THEN  BEGIN
                FrmGLignesCommentaires.EDITABLE(FALSE);
                FrmGLignesCommentaires.CAPTION('Post-it');
                FrmGLignesCommentaires.SETTABLEVIEW(RecGCommentLine);
                IF FrmGLignesCommentaires.RUNMODAL = ACTION::OK THEN;
               END;
              END;
             RecGCommentLine.SETRANGE(Code,'');
            END;
            //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Post_It]  Affiche les textes de type postit
            //<<MIGRATION NAV 2013

            #87..91
            CopyBuyFromVendorAddressFieldsFromVendor(Vend);
            #98..105

            //>>MIGRATION NAV 2013
            //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout code pr récupérer Tiers payeur
            "Pay-to Vend. No." := Vend."Pay-to Vend. No.";
            //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout code pr récupérer Tiers payeur
            //<<MIGRATION NAV 2013

            #106..110
            IF "Buy-from Vendor No." = xRec."Pay-to Vendor No." THEN
            #112..115
            #117..137
              RecreatePurchLines(BuyFromVendorTxt);
            #139..141

            //>>MIGRATION NAV 2013
            //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Mise à jour Codes INCOTERM Onglet "INTERNATIONAL"
            UpdateIncoterm;
            //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Mise à jour Codes INCOTERM Onglet "INTERNATIONAL"

            //>>TODOLIST point 66
            IF "Document Type" IN ["Document Type"::Order , "Document Type"::Invoice, "Document Type"::"Credit Memo"] THEN
              "Posting Description" := COPYSTR(FORMAT("Buy-from Vendor Name") + ' : ' + FORMAT("Document Type") + ' ' + "No."
                                         , 1, MAXSTRLEN("Posting Description"));
            //<<TODOLIST point 66
            //<<MIGRATION NAV 2013
            */
        //end;


        //Unsupported feature: Code Modification on ""Pay-to Vendor No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            IF (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.") AND
               (xRec."Pay-to Vendor No." <> '')
            THEN BEGIN
              IF HideValidationDialog THEN
                Confirmed := TRUE
              ELSE
                Confirmed := CONFIRM(Text004,FALSE,FIELDCAPTION("Pay-to Vendor No."));
              IF Confirmed THEN BEGIN
                PurchLine.SETRANGE("Document Type","Document Type");
                PurchLine.SETRANGE("Document No.","No.");

                IF "Document Type" = "Document Type"::Order THEN
                  PurchLine.SETFILTER("Quantity Received",'<>0');
                IF "Document Type" = "Document Type"::Invoice THEN
                  PurchLine.SETFILTER("Receipt No.",'<>%1','');
                IF PurchLine.FINDFIRST THEN
                  IF "Document Type" = "Document Type"::Order THEN
                    PurchLine.TESTFIELD("Quantity Received",0)
                  ELSE
                    PurchLine.TESTFIELD("Receipt No.",'');

                PurchLine.SETRANGE("Receipt No.");
                PurchLine.SETRANGE("Quantity Received");

                IF "Document Type" = "Document Type"::Order THEN BEGIN
                  PurchLine.SETFILTER("Prepmt. Amt. Inv.",'<>0');
                  IF PurchLine.FIND('-') THEN
                    PurchLine.TESTFIELD("Prepmt. Amt. Inv.",0);
                  PurchLine.SETRANGE("Prepmt. Amt. Inv.");
                END;

                IF "Document Type" = "Document Type"::"Return Order" THEN
                  PurchLine.SETFILTER("Return Qty. Shipped",'<>0');
                IF "Document Type" = "Document Type"::"Credit Memo" THEN
                  PurchLine.SETFILTER("Return Shipment No.",'<>%1','');
                IF PurchLine.FINDFIRST THEN
                  IF "Document Type" = "Document Type"::"Return Order" THEN
                    PurchLine.TESTFIELD("Return Qty. Shipped",0)
                  ELSE
                    PurchLine.TESTFIELD("Return Shipment No.",'');

                PurchLine.RESET;
              END ELSE
                "Pay-to Vendor No." := xRec."Pay-to Vendor No.";
            END;

            GetVend("Pay-to Vendor No.");
            Vend.CheckBlockedVendOnDocs(Vend,FALSE);
            Vend.TESTFIELD("Vendor Posting Group");

            "Pay-to Name" := Vend.Name;
            "Pay-to Name 2" := Vend."Name 2";
            "Pay-to Address" := Vend.Address;
            "Pay-to Address 2" := Vend."Address 2";
            "Pay-to City" := Vend.City;
            "Pay-to Post Code" := Vend."Post Code";
            "Pay-to County" := Vend.County;
            "Pay-to Country/Region Code" := Vend."Country/Region Code";
            IF NOT SkipPayToContact THEN
              "Pay-to Contact" := Vend.Contact;
            "Payment Terms Code" := Vend."Payment Terms Code";
            "Prepmt. Payment Terms Code" := Vend."Payment Terms Code";

            IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
              "Payment Method Code" := '';
              IF PaymentTerms.GET("Payment Terms Code") THEN
                IF PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" THEN
                  "Payment Method Code" := Vend."Payment Method Code"
            END ELSE
              "Payment Method Code" := Vend."Payment Method Code";

            "Shipment Method Code" := Vend."Shipment Method Code";
            "Vendor Posting Group" := Vend."Vendor Posting Group";
            GLSetup.GET;
            IF GLSetup."Bill-to/Sell-to VAT Calc." = GLSetup."Bill-to/Sell-to VAT Calc."::"Bill-to/Pay-to No." THEN BEGIN
              "VAT Bus. Posting Group" := Vend."VAT Bus. Posting Group";
              "VAT Country/Region Code" := Vend."Country/Region Code";
              "VAT Registration No." := Vend."VAT Registration No.";
              "Gen. Bus. Posting Group" := Vend."Gen. Bus. Posting Group";
            END;
            "Prices Including VAT" := Vend."Prices Including VAT";
            "Currency Code" := Vend."Currency Code";
            "Invoice Disc. Code" := Vend."Invoice Disc. Code";
            "Language Code" := Vend."Language Code";
            "Purchaser Code" := Vend."Purchaser Code";
            VALIDATE("Payment Terms Code");
            VALIDATE("Prepmt. Payment Terms Code");
            VALIDATE("Payment Method Code");
            VALIDATE("Currency Code");
            VALIDATE("Creditor No.",Vend."Creditor No.");

            IF "Document Type" = "Document Type"::Order THEN
              VALIDATE("Prepayment %",Vend."Prepayment %");

            IF "Pay-to Vendor No." = xRec."Pay-to Vendor No." THEN BEGIN
              IF ReceivedPurchLinesExist THEN
                TESTFIELD("Currency Code",xRec."Currency Code");
            END;

            CreateDim(
              DATABASE::Vendor,"Pay-to Vendor No.",
              DATABASE::"Salesperson/Purchaser","Purchaser Code",
              DATABASE::Campaign,"Campaign No.",
              DATABASE::"Responsibility Center","Responsibility Center");

            IF (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") AND
               (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.")
            THEN
              RecreatePurchLines(FIELDCAPTION("Pay-to Vendor No."));

            IF NOT SkipPayToContact THEN
              UpdatePayToCont("Pay-to Vendor No.");

            "Pay-to IC Partner Code" := Vend."IC Partner Code";
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..7
                Confirmed := CONFIRM(ConfirmChangeQst,FALSE,PayToVendorTxt);
            #9..12
                CheckReceiptInfo(PurchLine,TRUE);
                CheckPrepmtInfo(PurchLine);
                CheckReturnInfo(PurchLine,TRUE);
            #42..53
            CopyPayToVendorAddressFieldsFromVendor(Vend);
            #60..109
              RecreatePurchLines(PayToVendorTxt);
            #111..115
            */
        //end;


        //Unsupported feature: Code Insertion on ""Pay-to Name"(Field 5)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //var
            //Vendor: Record "23";
        //begin
            /*
            VALIDATE("Pay-to Vendor No.",Vendor.GetVendorNo("Pay-to Name"));
            */
        //end;


        //Unsupported feature: Code Insertion on ""Pay-to Contact"(Field 10)".

        //trigger OnLookup(var Text: Text): Boolean
        //var
            //Contact: Record "5050";
        //begin
            /*
            LookupContact("Pay-to Vendor No.","Pay-to Contact No.",Contact);
            IF PAGE.RUNMODAL(0,Contact) = ACTION::LookupOK THEN
              VALIDATE("Pay-to Contact No.",Contact."No.");
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
              PurchLine.SETRANGE("Document Type",PurchLine."Document Type"::Order);
              PurchLine.SETRANGE("Document No.","No.");
              PurchLine.SETFILTER("Sales Order Line No.",'<>0');
              IF NOT PurchLine.ISEMPTY THEN
                ERROR(
                  Text006,
                  FIELDCAPTION("Ship-to Code"));
            END;

            IF "Ship-to Code" <> '' THEN BEGIN
              ShipToAddr.GET("Sell-to Customer No.","Ship-to Code");
              "Ship-to Name" := ShipToAddr.Name;
              "Ship-to Name 2" := ShipToAddr."Name 2";
              "Ship-to Address" := ShipToAddr.Address;
              "Ship-to Address 2" := ShipToAddr."Address 2";
              "Ship-to City" := ShipToAddr.City;
              "Ship-to Post Code" := ShipToAddr."Post Code";
              "Ship-to County" := ShipToAddr.County;
              "Ship-to Country/Region Code" := ShipToAddr."Country/Region Code";
              "Ship-to Contact" := ShipToAddr.Contact;
              "Shipment Method Code" := ShipToAddr."Shipment Method Code";
              IF ShipToAddr."Location Code" <> '' THEN
                VALIDATE("Location Code",ShipToAddr."Location Code");
            END ELSE BEGIN
              TESTFIELD("Sell-to Customer No.");
              Cust.GET("Sell-to Customer No.");
              "Ship-to Name" := Cust.Name;
              "Ship-to Name 2" := Cust."Name 2";
              "Ship-to Address" := Cust.Address;
              "Ship-to Address 2" := Cust."Address 2";
              "Ship-to City" := Cust.City;
              "Ship-to Post Code" := Cust."Post Code";
              "Ship-to County" := Cust.County;
              "Ship-to Country/Region Code" := Cust."Country/Region Code";
              "Ship-to Contact" := Cust.Contact;
              "Shipment Method Code" := Cust."Shipment Method Code";
              IF Cust."Location Code" <> '' THEN
                VALIDATE("Location Code",Cust."Location Code");
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..8
                  YouCannotChangeFieldErr,
            #10..14
              SetShipToAddress(
                ShipToAddr.Name,ShipToAddr."Name 2",ShipToAddr.Address,ShipToAddr."Address 2",
                ShipToAddr.City,ShipToAddr."Post Code",ShipToAddr.County,ShipToAddr."Country/Region Code");
            #23..29
              SetShipToAddress(
                Cust.Name,Cust."Name 2",Cust.Address,Cust."Address 2",
                Cust.City,Cust."Post Code",Cust.County,Cust."Country/Region Code");
            #38..42
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Posting Date"(Field 20).OnValidate".

        //trigger (Variable: SkipJobCurrFactorUpdate)()
        //Parameters and return type have not been exported.
        //begin
            /*
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
            #15..17
            IF "Currency Code" <> '' THEN BEGIN
              UpdateCurrencyFactor;
              IF "Currency Factor" <> xRec."Currency Factor" THEN
                ConfirmUpdateCurrencyFactor;
            END;
            IF PurchLinesExist THEN
              JobUpdatePurchLines;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..10
            IF "Incoming Document Entry No." = 0 THEN
              VALIDATE("Document Date","Posting Date");
            #12..20
                SkipJobCurrFactorUpdate := NOT ConfirmUpdateCurrencyFactor;
            END;

            IF "Posting Date" <> xRec."Posting Date" THEN
              IF DeferralHeadersExist THEN
                ConfirmUpdateDeferralDate;

            IF PurchLinesExist THEN
              JobUpdatePurchLines(SkipJobCurrFactorUpdate);
            */
        //end;


        //Unsupported feature: Code Modification on ""Expected Receipt Date"(Field 21).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            UpdatePurchLines(FIELDCAPTION("Expected Receipt Date"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF "Expected Receipt Date" <> 0D THEN
              UpdatePurchLines(FIELDCAPTION("Expected Receipt Date"),CurrFieldNo <> 0);
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
            #9..20
            END;
            IF xRec."Payment Terms Code" = "Prepmt. Payment Terms Code" THEN
              VALIDATE("Prepmt. Payment Terms Code","Payment Terms Code");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF ("Payment Terms Code" <> '') AND ("Document Date" <> 0D) THEN BEGIN
              PaymentTerms.GET("Payment Terms Code");
              IF IsCreditDocType AND NOT PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" THEN BEGIN
            #6..23
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
            IF (CurrFieldNo <> FIELDNO("Currency Code")) AND ("Currency Code" = xRec."Currency Code") THEN
              UpdateCurrencyFactor
            ELSE BEGIN
              IF "Currency Code" <> xRec."Currency Code" THEN BEGIN
                UpdateCurrencyFactor;
                IF PurchLinesExist THEN
            #9..17
                  IF "Currency Factor" <> xRec."Currency Factor" THEN
                    ConfirmUpdateCurrencyFactor;
                END;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
            ELSE
            #6..20

            //>>MIGRATION NAV 2013
            //>>COUT_ACHAT
            IF "Currency Code" <> '' THEN
              MESSAGE(TextG001);
            //<<COUT_ACHAT
            //<<MIGRATION NAV 2013
            */
        //end;


        //Unsupported feature: Code Modification on ""Currency Factor"(Field 33).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Currency Factor" <> xRec."Currency Factor" THEN
              UpdatePurchLines(FIELDCAPTION("Currency Factor"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF "Currency Factor" <> xRec."Currency Factor" THEN
              UpdatePurchLines(FIELDCAPTION("Currency Factor"),CurrFieldNo <> 0);
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
            #4..14
                    TRUE);
                PurchLine.SetPurchHeader(Rec);

                IF "Currency Code" = '' THEN
                  Currency.InitRoundingPrecision
                ELSE
                  Currency.GET("Currency Code");

                REPEAT
                  PurchLine.TESTFIELD("Quantity Invoiced",0);
                  PurchLine.TESTFIELD("Prepmt. Amt. Inv.",0);
                  IF NOT RecalculatePrice THEN BEGIN
                    PurchLine."VAT Difference" := 0;
                    PurchLine.InitOutstandingAmount;
                  END ELSE
                    IF "Prices Including VAT" THEN BEGIN
                      PurchLine."Direct Unit Cost" :=
            #32..61
                UNTIL PurchLine.NEXT = 0;
              END;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..17
                IF RecalculatePrice AND "Prices Including VAT" THEN
                  PurchLine.MODIFYALL(Amount,0,TRUE);

            #18..22
                PurchLine.FINDSET;
            #23..27
                    PurchLine.UpdateAmounts;
            #29..64
            */
        //end;


        //Unsupported feature: Code Modification on ""Purchaser Code"(Field 43).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ApprovalEntry.SETRANGE("Table ID",DATABASE::"Purchase Header");
            ApprovalEntry.SETRANGE("Document Type","Document Type");
            ApprovalEntry.SETRANGE("Document No.","No.");
            ApprovalEntry.SETFILTER(Status,'<>%1&<>%2',ApprovalEntry.Status::Canceled,ApprovalEntry.Status::Rejected);
            IF NOT ApprovalEntry.ISEMPTY THEN
              ERROR(Text042,FIELDCAPTION("Purchaser Code"));

            CreateDim(
              DATABASE::"Salesperson/Purchaser","Purchaser Code",
              DATABASE::Vendor,"Pay-to Vendor No.",
              DATABASE::Campaign,"Campaign No.",
              DATABASE::"Responsibility Center","Responsibility Center");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
            ApprovalEntry.SETFILTER(Status,'%1|%2',ApprovalEntry.Status::Created,ApprovalEntry.Status::Open);
            #5..12
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
            VendLedgEntry.SETCURRENTKEY("Vendor No.",Open,Positive,"Due Date");
            VendLedgEntry.SETRANGE("Vendor No.","Pay-to Vendor No.");
            #4..25
            IF ApplyVendEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
              ApplyVendEntries.GetVendLedgEntry(VendLedgEntry);
              GenJnlApply.CheckAgainstApplnCurrency(
                "Currency Code",VendLedgEntry."Currency Code",GenJnILine."Account Type"::Vendor,TRUE);
              "Applies-to Doc. Type" := VendLedgEntry."Document Type";
              "Applies-to Doc. No." := VendLedgEntry."Document No.";
            END;
            CLEAR(ApplyVendEntries);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..28
                "Currency Code",VendLedgEntry."Currency Code",GenJnlLine."Account Type"::Vendor,TRUE);
            #30..33
            */
        //end;


        //Unsupported feature: Code Modification on ""Sell-to Customer No."(Field 72).OnValidate".

        //trigger "(Field 72)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ("Document Type" = "Document Type"::Order) AND
               (xRec."Sell-to Customer No." <> "Sell-to Customer No.")
            THEN BEGIN
              PurchLine.SETRANGE("Document Type",PurchLine."Document Type"::Order);
              PurchLine.SETRANGE("Document No.","No.");
              PurchLine.SETFILTER("Sales Order Line No.",'<>0');
              IF NOT PurchLine.ISEMPTY THEN
                ERROR(
                  Text006,
                  FIELDCAPTION("Sell-to Customer No."));
            END;

            IF "Sell-to Customer No." = '' THEN
              VALIDATE("Location Code",UserSetupMgt.GetLocation(1,'',"Responsibility Center"))
            ELSE
              VALIDATE("Ship-to Code",'');
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..8
                  YouCannotChangeFieldErr,
                  FIELDCAPTION("Sell-to Customer No."));

              PurchLine.SETRANGE("Sales Order Line No.");
              PurchLine.SETFILTER("Special Order Sales Line No.",'<>0');
              IF NOT PurchLine.ISEMPTY THEN
                ERROR(
                  YouCannotChangeFieldErr,
            #10..16
            */
        //end;


        //Unsupported feature: Code Insertion on ""Reason Code"(Field 73)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //var
            //RecLReasonCode: Record "231";
            //RecLPurchLine: Record "39";
        //begin
            /*
            //>>MIGRATION NAV 2013
            //>>DEEE1.00 : Update DEEE details on puch lines
            IF xRec."Reason Code" <> Rec."Reason Code" THEN BEGIN
              RecLPurchLine.SETRANGE("Document Type","Document Type") ;
              RecLPurchLine.SETRANGE("Document No.","No.") ;
              IF RecLPurchLine.FIND('-') THEN
                REPEAT
                  RecLPurchLine."DEEE Category Code":=RecLPurchLine."DEEE Category Code";
                  RecLPurchLine.CalculateDEEE(Rec."Reason Code") ;
                  RecLPurchLine.MODIFY;
                UNTIL RecLPurchLine.NEXT=0 ;
            END ;
            //<<DEEE1.00
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
            IF (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") AND
               (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group")
            THEN
              IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") THEN BEGIN
                "VAT Bus. Posting Group" := GenBusPostingGrp."Def. VAT Bus. Posting Group";
                RecreatePurchLines(FIELDCAPTION("Gen. Bus. Posting Group"));
              END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
            THEN BEGIN
              IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") THEN
                "VAT Bus. Posting Group" := GenBusPostingGrp."Def. VAT Bus. Posting Group";
              RecreatePurchLines(FIELDCAPTION("Gen. Bus. Posting Group"));
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Transaction Type"(Field 76).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            UpdatePurchLines(FIELDCAPTION("Transaction Type"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            UpdatePurchLines(FIELDCAPTION("Transaction Type"),CurrFieldNo <> 0);
            */
        //end;


        //Unsupported feature: Code Modification on ""Transport Method"(Field 77).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            UpdatePurchLines(FIELDCAPTION("Transport Method"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            UpdatePurchLines(FIELDCAPTION("Transport Method"),CurrFieldNo <> 0);
            */
        //end;


        //Unsupported feature: Code Insertion on ""Buy-from Vendor Name"(Field 79)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //var
            //Vendor: Record "23";
        //begin
            /*
            //BC6>>
            IF xRec."Buy-from Vendor Name" = '' THEN
            //BC6<<
            VALIDATE("Buy-from Vendor No.",Vendor.GetVendorNo("Buy-from Vendor Name"));
            */
        //end;


        //Unsupported feature: Code Insertion on ""Buy-from Address"(Field 81)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            UpdatePayToAddressFromBuyFromAddress(FIELDNO("Pay-to Address"));
            */
        //end;


        //Unsupported feature: Code Insertion on ""Buy-from Address 2"(Field 82)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            UpdatePayToAddressFromBuyFromAddress(FIELDNO("Pay-to Address 2"));
            */
        //end;


        //Unsupported feature: Code Modification on ""Buy-from City"(Field 83).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            PostCode.ValidateCity(
              "Buy-from City","Buy-from Post Code","Buy-from County","Buy-from Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            PostCode.ValidateCity(
              "Buy-from City","Buy-from Post Code","Buy-from County","Buy-from Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            UpdatePayToAddressFromBuyFromAddress(FIELDNO("Pay-to City"));
            */
        //end;


        //Unsupported feature: Code Insertion on ""Buy-from Contact"(Field 84)".

        //trigger OnLookup(var Text: Text): Boolean
        //var
            //Contact: Record "5050";
        //begin
            /*
            LookupContact("Buy-from Vendor No.","Buy-from Contact No.",Contact);
            IF PAGE.RUNMODAL(0,Contact) = ACTION::LookupOK THEN
              VALIDATE("Buy-from Contact No.",Contact."No.");
            */
        //end;


        //Unsupported feature: Code Modification on ""Buy-from Post Code"(Field 88).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            PostCode.ValidatePostCode(
              "Buy-from City","Buy-from Post Code","Buy-from County","Buy-from Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            PostCode.ValidatePostCode(
              "Buy-from City","Buy-from Post Code","Buy-from County","Buy-from Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            UpdatePayToAddressFromBuyFromAddress(FIELDNO("Pay-to Post Code"));
            */
        //end;


        //Unsupported feature: Code Insertion on ""Buy-from County"(Field 89)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            UpdatePayToAddressFromBuyFromAddress(FIELDNO("Pay-to County"));
            */
        //end;


        //Unsupported feature: Code Insertion on ""Buy-from Country/Region Code"(Field 90)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            UpdatePayToAddressFromBuyFromAddress(FIELDNO("Pay-to Country/Region Code"));
            */
        //end;


        //Unsupported feature: Code Modification on ""Order Address Code"(Field 95).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Order Address Code" <> '' THEN BEGIN
              OrderAddr.GET("Buy-from Vendor No.","Order Address Code");
              "Buy-from Vendor Name" := OrderAddr.Name;
              "Buy-from Vendor Name 2" := OrderAddr."Name 2";
              "Buy-from Address" := OrderAddr.Address;
              "Buy-from Address 2" := OrderAddr."Address 2";
              "Buy-from City" := OrderAddr.City;
              "Buy-from Contact" := OrderAddr.Contact;
              "Buy-from Post Code" := OrderAddr."Post Code";
              "Buy-from County" := OrderAddr.County;
              "Buy-from Country/Region Code" := OrderAddr."Country/Region Code";

              IF ("Document Type" = "Document Type"::"Return Order") OR
                 ("Document Type" = "Document Type"::"Credit Memo")
              THEN BEGIN
                "Ship-to Name" := OrderAddr.Name;
                "Ship-to Name 2" := OrderAddr."Name 2";
                "Ship-to Address" := OrderAddr.Address;
                "Ship-to Address 2" := OrderAddr."Address 2";
                "Ship-to City" := OrderAddr.City;
                "Ship-to Post Code" := OrderAddr."Post Code";
                "Ship-to County" := OrderAddr.County;
                "Ship-to Country/Region Code" := OrderAddr."Country/Region Code";
                "Ship-to Contact" := OrderAddr.Contact;
              END
            END ELSE BEGIN
              GetVend("Buy-from Vendor No.");
              "Buy-from Vendor Name" := Vend.Name;
              "Buy-from Vendor Name 2" := Vend."Name 2";
              "Buy-from Address" := Vend.Address;
              "Buy-from Address 2" := Vend."Address 2";
              "Buy-from City" := Vend.City;
              "Buy-from Contact" := Vend.Contact;
              "Buy-from Post Code" := Vend."Post Code";
              "Buy-from County" := Vend.County;
              "Buy-from Country/Region Code" := Vend."Country/Region Code";

              IF ("Document Type" = "Document Type"::"Return Order") OR
                 ("Document Type" = "Document Type"::"Credit Memo")
              THEN BEGIN
                "Ship-to Name" := Vend.Name;
                "Ship-to Name 2" := Vend."Name 2";
                "Ship-to Address" := Vend.Address;
                "Ship-to Address 2" := Vend."Address 2";
                "Ship-to City" := Vend.City;
                "Ship-to Post Code" := Vend."Post Code";
                "Ship-to County" := Vend.County;
                "Ship-to Country/Region Code" := Vend."Country/Region Code";
                "Ship-to Contact" := Vend.Contact;
                "Shipment Method Code" := Vend."Shipment Method Code";
                IF Vend."Location Code" <> '' THEN
                  VALIDATE("Location Code",Vend."Location Code");
              END
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..12
              IF IsCreditDocType THEN BEGIN
                SetShipToAddress(
                  OrderAddr.Name,OrderAddr."Name 2",OrderAddr.Address,OrderAddr."Address 2",
                  OrderAddr.City,OrderAddr."Post Code",OrderAddr.County,OrderAddr."Country/Region Code");
            #24..29
              CopyPayToVendorAddressFieldsFromVendor(Vend);

              IF IsCreditDocType THEN BEGIN
                "Ship-to Name" := Vend.Name;
                "Ship-to Name 2" := Vend."Name 2";
                CopyShipToVendorAddressFieldsFromVendor(Vend);
            #49..54
            */
        //end;


        //Unsupported feature: Code Modification on ""Entry Point"(Field 97).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            UpdatePurchLines(FIELDCAPTION("Entry Point"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            UpdatePurchLines(FIELDCAPTION("Entry Point"),CurrFieldNo <> 0);
            */
        //end;


        //Unsupported feature: Code Modification on "Area(Field 101).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            UpdatePurchLines(FIELDCAPTION(Area));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            UpdatePurchLines(FIELDCAPTION(Area),CurrFieldNo <> 0);
            */
        //end;


        //Unsupported feature: Code Modification on ""Transaction Specification"(Field 102).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            UpdatePurchLines(FIELDCAPTION("Transaction Specification"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            UpdatePurchLines(FIELDCAPTION("Transaction Specification"),CurrFieldNo <> 0);
            */
        //end;


        //Unsupported feature: Code Modification on ""Prepayment %"(Field 134).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF CurrFieldNo <> 0 THEN
              UpdatePurchLines(FIELDCAPTION("Prepayment %"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF xRec."Prepayment %" <> "Prepayment %" THEN
              UpdatePurchLines(FIELDCAPTION("Prepayment %"),CurrFieldNo <> 0);
            */
        //end;


        //Unsupported feature: Code Modification on ""Prepmt. Payment Terms Code"(Field 143).OnValidate".

        //trigger  Payment Terms Code"(Field 143)()
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
            IncomingDocument.SetPurchDoc(Rec);
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
              IncomingDocument.SetPurchDoc(Rec);
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


        //Unsupported feature: Code Modification on ""Buy-from Contact No."(Field 5052).OnLookup".

        //trigger "(Field 5052)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Buy-from Vendor No." <> '' THEN BEGIN
              IF Cont.GET("Buy-from Contact No.") THEN
                Cont.SETRANGE("Company No.",Cont."Company No.")
              ELSE BEGIN
            #5..10
                ELSE
                  Cont.SETRANGE("No.",'');
              END;
            END;

            IF "Buy-from Contact No." <> '' THEN
              IF Cont.GET("Buy-from Contact No.") THEN ;
            IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN BEGIN
              xRec := Rec;
              VALIDATE("Buy-from Contact No.",Cont."No.");
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF "Buy-from Vendor No." <> '' THEN
            #2..13
            #15..21
            */
        //end;


        //Unsupported feature: Code Modification on ""Buy-from Contact No."(Field 5052).OnValidate".

        //trigger "(Field 5052)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);

            IF ("Buy-from Contact No." <> xRec."Buy-from Contact No.") AND
               (xRec."Buy-from Contact No." <> '')
            THEN BEGIN
              IF HideValidationDialog THEN
                Confirmed := TRUE
              ELSE
                Confirmed := CONFIRM(Text004,FALSE,FIELDCAPTION("Buy-from Contact No."));
              IF Confirmed THEN BEGIN
                PurchLine.SETRANGE("Document Type","Document Type");
                PurchLine.SETRANGE("Document No.","No.");
                IF ("Buy-from Contact No." = '') AND ("Buy-from Vendor No." = '') THEN BEGIN
                  IF NOT PurchLine.ISEMPTY THEN
                    ERROR(
                      Text005,
                      FIELDCAPTION("Buy-from Contact No."));
                  INIT;
                  PurchSetup.GET;
                  InitRecord;
                  "No. Series" := xRec."No. Series";
                  IF xRec."Receiving No." <> '' THEN BEGIN
                    "Receiving No. Series" := xRec."Receiving No. Series";
                    "Receiving No." := xRec."Receiving No.";
                  END;
                  IF xRec."Posting No." <> '' THEN BEGIN
                    "Posting No. Series" := xRec."Posting No. Series";
                    "Posting No." := xRec."Posting No.";
                  END;
                  IF xRec."Return Shipment No." <> '' THEN BEGIN
                    "Return Shipment No. Series" := xRec."Return Shipment No. Series";
                    "Return Shipment No." := xRec."Return Shipment No.";
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
                Rec := xRec;
                EXIT;
              END;
            END;

            IF ("Buy-from Vendor No." <> '') AND ("Buy-from Contact No." <> '') THEN BEGIN
              Cont.GET("Buy-from Contact No.");
              ContBusinessRelation.RESET;
              ContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
              ContBusinessRelation.SETRANGE("Link to Table",ContBusinessRelation."Link to Table"::Vendor);
              ContBusinessRelation.SETRANGE("No.","Buy-from Vendor No.");
              IF ContBusinessRelation.FINDFIRST THEN
                IF ContBusinessRelation."Contact No." <> Cont."Company No." THEN
                  ERROR(Text038,Cont."No.",Cont.Name,"Buy-from Vendor No.");
            END;

            UpdateBuyFromVend("Buy-from Contact No.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..8
                Confirmed := CONFIRM(ConfirmChangeQst,FALSE,FIELDCAPTION("Buy-from Contact No."));
              IF Confirmed THEN BEGIN
                IF InitFromContact("Buy-from Contact No.","Buy-from Vendor No.",FIELDCAPTION("Buy-from Contact No.")) THEN
                  EXIT
            #44..61
            */
        //end;


        //Unsupported feature: Code Modification on ""Pay-to Contact No."(Field 5053).OnLookup".

        //trigger "(Field 5053)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Pay-to Vendor No." <> '' THEN BEGIN
              IF Cont.GET("Pay-to Contact No.") THEN
                Cont.SETRANGE("Company No.",Cont."Company No.")
              ELSE BEGIN
            #5..10
                ELSE
                  Cont.SETRANGE("No.",'');
              END;
            END;

            IF "Pay-to Contact No." <> '' THEN
              IF Cont.GET("Pay-to Contact No.") THEN ;
            IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN BEGIN
              xRec := Rec;
              VALIDATE("Pay-to Contact No.",Cont."No.");
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF "Pay-to Vendor No." <> '' THEN
            #2..13
            #15..21
            */
        //end;


        //Unsupported feature: Code Modification on ""Pay-to Contact No."(Field 5053).OnValidate".

        //trigger "(Field 5053)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);

            IF ("Pay-to Contact No." <> xRec."Pay-to Contact No.") AND
               (xRec."Pay-to Contact No." <> '')
            THEN BEGIN
              IF HideValidationDialog THEN
                Confirmed := TRUE
              ELSE
                Confirmed := CONFIRM(Text004,FALSE,FIELDCAPTION("Pay-to Contact No."));
              IF Confirmed THEN BEGIN
                PurchLine.SETRANGE("Document Type","Document Type");
                PurchLine.SETRANGE("Document No.","No.");
                IF ("Pay-to Contact No." = '') AND ("Pay-to Vendor No." = '') THEN BEGIN
                  IF NOT PurchLine.ISEMPTY THEN
                    ERROR(
                      Text005,
                      FIELDCAPTION("Pay-to Contact No."));
                  INIT;
                  PurchSetup.GET;
                  InitRecord;
                  "No. Series" := xRec."No. Series";
                  IF xRec."Receiving No." <> '' THEN BEGIN
                    "Receiving No. Series" := xRec."Receiving No. Series";
                    "Receiving No." := xRec."Receiving No.";
                  END;
                  IF xRec."Posting No." <> '' THEN BEGIN
                    "Posting No. Series" := xRec."Posting No. Series";
                    "Posting No." := xRec."Posting No.";
                  END;
                  IF xRec."Return Shipment No." <> '' THEN BEGIN
                    "Return Shipment No. Series" := xRec."Return Shipment No. Series";
                    "Return Shipment No." := xRec."Return Shipment No.";
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
                "Pay-to Contact No." := xRec."Pay-to Contact No.";
                EXIT;
              END;
            END;

            IF ("Pay-to Vendor No." <> '') AND ("Pay-to Contact No." <> '') THEN BEGIN
              Cont.GET("Pay-to Contact No.");
              ContBusinessRelation.RESET;
              ContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
              ContBusinessRelation.SETRANGE("Link to Table",ContBusinessRelation."Link to Table"::Vendor);
              ContBusinessRelation.SETRANGE("No.","Pay-to Vendor No.");
              IF ContBusinessRelation.FINDFIRST THEN
                IF ContBusinessRelation."Contact No." <> Cont."Company No." THEN
                  ERROR(Text038,Cont."No.",Cont.Name,"Pay-to Vendor No.");
            END;

            UpdatePayToVend("Pay-to Contact No.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..8
                Confirmed := CONFIRM(ConfirmChangeQst,FALSE,FIELDCAPTION("Pay-to Contact No."));
              IF Confirmed THEN BEGIN
                IF InitFromContact("Pay-to Contact No.","Pay-to Vendor No.",FIELDCAPTION("Pay-to Contact No.")) THEN
                  EXIT
            #44..61
            */
        //end;


        //Unsupported feature: Code Modification on ""Requested Receipt Date"(Field 5790).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            IF "Promised Receipt Date" <> 0D THEN
              ERROR(
                Text034,
                FIELDCAPTION("Requested Receipt Date"),
                FIELDCAPTION("Promised Receipt Date"));

            IF "Requested Receipt Date" <> xRec."Requested Receipt Date" THEN
              UpdatePurchLines(FIELDCAPTION("Requested Receipt Date"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..8
              UpdatePurchLines(FIELDCAPTION("Requested Receipt Date"),CurrFieldNo <> 0);
            */
        //end;


        //Unsupported feature: Code Modification on ""Promised Receipt Date"(Field 5791).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            IF "Promised Receipt Date" <> xRec."Promised Receipt Date" THEN
              UpdatePurchLines(FIELDCAPTION("Promised Receipt Date"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            IF "Promised Receipt Date" <> xRec."Promised Receipt Date" THEN
              UpdatePurchLines(FIELDCAPTION("Promised Receipt Date"),CurrFieldNo <> 0);
            */
        //end;


        //Unsupported feature: Code Modification on ""Lead Time Calculation"(Field 5792).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            IF "Lead Time Calculation" <> xRec."Lead Time Calculation" THEN
              UpdatePurchLines(FIELDCAPTION("Lead Time Calculation"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            LeadTimeMgt.CheckLeadTimeIsNotNegative("Lead Time Calculation");

            IF "Lead Time Calculation" <> xRec."Lead Time Calculation" THEN
              UpdatePurchLines(FIELDCAPTION("Lead Time Calculation"),CurrFieldNo <> 0);
            */
        //end;


        //Unsupported feature: Code Modification on ""Inbound Whse. Handling Time"(Field 5793).OnValidate".

        //trigger  Handling Time"(Field 5793)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            IF "Inbound Whse. Handling Time" <> xRec."Inbound Whse. Handling Time" THEN
              UpdatePurchLines(FIELDCAPTION("Inbound Whse. Handling Time"));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            TESTFIELD(Status,Status::Open);
            IF "Inbound Whse. Handling Time" <> xRec."Inbound Whse. Handling Time" THEN
              UpdatePurchLines(FIELDCAPTION("Inbound Whse. Handling Time"),CurrFieldNo <> 0);
            */
        //end;
        field(56;"Recalculate Invoice Disc.";Boolean)
        {
            CalcFormula = Exist("Purchase Line" WHERE (Document Type=FIELD(Document Type),
                                                       Document No.=FIELD(No.),
                                                       Recalculate Invoice Disc.=CONST(Yes)));
            Caption = 'Recalculate Invoice Disc.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9001;"Pending Approvals";Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE (Table ID=CONST(38),
                                                        Document Type=FIELD(Document Type),
                                                        Document No.=FIELD(No.),
                                                        Status=FILTER(Open|Created)));
            Caption = 'Pending Approvals';
            FieldClass = FlowField;
        }
        field(50000;"Affair No.";Code[20])
        {
            Caption = 'Affair No.';
            Description = 'CNE1.00';
            TableRelation = Job.No.;
        }
        field(50003;"Pay-to Vend. No.";Code[20])
        {
            Caption = 'Pay-to Vend. No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Vendor;
        }
        field(50010;ID;Code[50])
        {
            Description = 'AjoutCodeUtilisateur RD 13/11/06 NCS1.01 [FE019V1] Ajout du code utilisateur dans les documents achats';
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
        field(50020;"From Sales Module";Boolean)
        {
            Caption = 'From Sales Module';
            Editable = false;
        }
        field(50021;"Buy-from Fax No.";Text[30])
        {
            Caption = 'Buy-from Fax No.';
            Description = 'FE005 SEBC 08/01/2007';
        }
        field(50022;"Buy-from E-Mail Address";Text[50])
        {
            Description = 'FE005 MICO 12/02/2007';
        }
        field(50080;"Sales No. Order Lien";Code[20])
        {
            Caption = 'Sales No. Order Lien';
            Description = 'CNEIC';
        }
        field(50090;"Last Related Info Date";DateTime)
        {
            CalcFormula = Max("Purch. Comment Line"."Log Date" WHERE (Document Type=FIELD(Document Type),
                                                                      No.=FIELD(No.),
                                                                      Is Log=CONST(Yes)));
            Caption = 'Last Related Info Date';
            FieldClass = FlowField;
        }
        field(50100;"Return Order Type";Option)
        {
            Caption = 'Return Order Type';
            Description = 'BC6';
            OptionCaption = 'Location,SAV';
            OptionMembers = Location,SAV;

            trigger OnValidate()
            begin
                UpdateSalesLineReturnType
            end;
        }
        field(50101;"Reminder Date";Date)
        {
            Caption = 'Reminder Date';
            Description = 'BC6';
        }
        field(50102;"Related Sales Return Order";Code[20])
        {
            CalcFormula = Lookup("Return Order Relation"."Sales Return Order" WHERE (Purchase Order No.=FIELD(No.)));
            Caption = 'N° retour vente associé';
            Description = 'BC6';
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup()
            var
                SalesHeader: Record "36";
            begin
            end;
        }
    }
    keys
    {
        key(Key1;"Document Date")
        {
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: PostPurchDelete)()
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
        IF NOT UserSetupMgt.CheckRespCenter(1,"Responsibility Center") THEN
          ERROR(
            Text023,
            RespCenter.TABLECAPTION,UserSetupMgt.GetPurchasesFilter);

        PurchPost.DeleteHeader(
          Rec,PurchRcptHeader,PurchInvHeader,PurchCrMemoHeader,
          ReturnShptHeader,PurchInvHeaderPrepmt,PurchCrMemoHeaderPrepmt);
        VALIDATE("Applies-to ID",'');

        ApprovalMgt.DeleteApprovalEntry(DATABASE::"Purchase Header","Document Type","No.");
        PurchLine.LOCKTABLE;

        WhseRequest.SETRANGE("Source Type",DATABASE::"Purchase Line");
        WhseRequest.SETRANGE("Source Subtype","Document Type");
        WhseRequest.SETRANGE("Source No.","No.");
        WhseRequest.DELETEALL(TRUE);

        PurchLine.SETRANGE("Document Type","Document Type");
        PurchLine.SETRANGE("Document No.","No.");
        PurchLine.SETRANGE(Type,PurchLine.Type::"Charge (Item)");
        DeletePurchaseLines;
        PurchLine.SETRANGE(Type);
        DeletePurchaseLines;

        PurchCommentLine.SETRANGE("Document Type","Document Type");
        PurchCommentLine.SETRANGE("No.","No.");
        PurchCommentLine.DELETEALL;

        IF (PurchRcptHeader."No." <> '') OR
           (PurchInvHeader."No." <> '') OR
           (PurchCrMemoHeader."No." <> '') OR
           (ReturnShptHeader."No." <> '') OR
           (PurchInvHeaderPrepmt."No." <> '') OR
           (PurchCrMemoHeaderPrepmt."No." <> '')
        THEN BEGIN
          COMMIT;

          IF PurchRcptHeader."No." <> '' THEN
            IF CONFIRM(
                 Text000,TRUE,
                 PurchRcptHeader."No.")
            THEN BEGIN
              PurchRcptHeader.SETRECFILTER;
              PurchRcptHeader.PrintRecords(TRUE);
            END;

          IF PurchInvHeader."No." <> '' THEN
            IF CONFIRM(
                 Text001,TRUE,
                 PurchInvHeader."No.")
            THEN BEGIN
              PurchInvHeader.SETRECFILTER;
              PurchInvHeader.PrintRecords(TRUE);
            END;

          IF PurchCrMemoHeader."No." <> '' THEN
            IF CONFIRM(
                 Text002,TRUE,
                 PurchCrMemoHeader."No.")
            THEN BEGIN
              PurchCrMemoHeader.SETRECFILTER;
              PurchCrMemoHeader.PrintRecords(TRUE);
            END;

          IF ReturnShptHeader."No." <> '' THEN
            IF CONFIRM(
                 Text024,TRUE,
                 ReturnShptHeader."No.")
            THEN BEGIN
              ReturnShptHeader.SETRECFILTER;
              ReturnShptHeader.PrintRecords(TRUE);
            END;

          IF PurchInvHeaderPrepmt."No." <> '' THEN
            IF CONFIRM(
                 Text042,TRUE,
                 PurchInvHeader."No.")
            THEN BEGIN
              PurchInvHeaderPrepmt.SETRECFILTER;
              PurchInvHeaderPrepmt.PrintRecords(TRUE);
            END;

          IF PurchCrMemoHeaderPrepmt."No." <> '' THEN
            IF CONFIRM(
                 Text043,TRUE,
                 PurchCrMemoHeaderPrepmt."No.")
            THEN BEGIN
              PurchCrMemoHeaderPrepmt.SETRECFILTER;
              PurchCrMemoHeaderPrepmt.PrintRecords(TRUE);
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5
        PostPurchDelete.DeleteHeader(
          Rec,PurchRcptHeader,PurchInvHeader,PurchCrMemoHeader,
          ReturnShptHeader,PurchInvHeaderPrepmt,PurchCrMemoHeaderPrepmt);

        ArchiveManagement.AutoArchivePurchDocument(Rec);

        VALIDATE("Applies-to ID",'');
        VALIDATE("Incoming Document Entry No.",0);

        ApprovalsMgmt.DeleteApprovalEntries(RECORDID);
        #12..35
        THEN
          MESSAGE(PostedDocsToPrintCreatedMsg);

        //>>CNEIC
        CompanyInfo.FINDFIRST;
        IF CompanyInfo."Branch Company" THEN
          BEGIN
           IF "Sales No. Order Lien" <> '' THEN
             ERROR(TextG003);
          END;
        //<<CNEIC

        //>>BCSYS 07072020
        IF "Document Type" = "Document Type"::Order THEN
          G_ReturnOrderMgt.DeleteRelatedPurchOrderNo(Rec)
        ELSE
        IF ("Document Type" ="Document Type"::"Return Order") THEN
          G_ReturnOrderMgt.DeleteRelatedPurchReturnOrderNo (Rec);
        //<<BCSYS
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

        IF GETFILTER("Buy-from Vendor No.") <> '' THEN
          IF GETRANGEMIN("Buy-from Vendor No.") = GETRANGEMAX("Buy-from Vendor No.") THEN
            VALIDATE("Buy-from Vendor No.",GETRANGEMIN("Buy-from Vendor No."));

        "Doc. No. Occurrence" := ArchiveManagement.GetNextOccurrenceNo(DATABASE::"Purchase Header","Document Type","No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF NOT SkipInitialization THEN
          InitInsert;
        #7..10
        //>>MIGRATION NAV 2013
        //AjoutCodeUtilisateur RD 13/11/06 NCS1.01 [FE019V1] Ajout du code utilisateur dans les documents d'achats & ventes
        ID := USERID
        //Fin AjoutCodeUtilisateur RD 13/11/06 NCS1.01 [FE019V1] Ajout du code utilisateur dans les documents d'achats & ventes
        //<<MIGRATION NAV 2013
        */
    //end;


    //Unsupported feature: Code Insertion on "OnModify".

    //trigger OnModify()
    //begin
        /*
        UpdateVendorAddress;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ArchiveManagement) (VariableCollection) on "InitRecord(PROCEDURE 10)".



    //Unsupported feature: Code Modification on "InitRecord(PROCEDURE 10)".

    //procedure InitRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PurchSetup.GET;

        CASE "Document Type" OF
        #4..38
            END;
        END;

        IF "Document Type" IN ["Document Type"::Order,"Document Type"::Invoice,"Document Type"::"Return Order"] THEN
          "Order Date" := WORKDATE;

        IF "Document Type" = "Document Type"::Invoice THEN
          "Expected Receipt Date" := WORKDATE;
        #47..56

        VALIDATE("Sell-to Customer No.",'');

        IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN BEGIN
          GLSetup.GET;
          Correction := GLSetup."Mark Cr. Memos as Corrections";
        END;
        #64..67
          "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";

        "Responsibility Center" := UserSetupMgt.GetRespCenter(1,"Responsibility Center");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..41
        //>>MIGRATION NAV 2013
        // STD IF "Document Type" IN ["Document Type"::Order,"Document Type"::Invoice,"Document Type"::"Return Order"] THEN
        // STD  "Order Date" := WORKDATE;
        //>>demandeprix
        //IF "Document Type" IN ["Document Type"::Order,"Document Type"::Invoice,"Document Type"::"Return Order"] THEN
        IF "Document Type" IN ["Document Type"::Quote,"Document Type"::Order,"Document Type"::Invoice,"Document Type"::"Return Order"]
        THEN BEGIN
        //<<demandeprix
          "Order Date" := WORKDATE;
          //REGIE:ARHA 29/04/2007
          "Posting Date" := WORKDATE;
        END;
        //<<MIGRATION NAV 2013

        #44..59
        IF IsCreditDocType THEN BEGIN
        #61..70
        "Doc. No. Occurrence" := ArchiveManagement.GetNextOccurrenceNo(DATABASE::"Purchase Header","Document Type","No.");

        //BC6 - MM 100119 >>
        IF "Document Type" = "Document Type"::Quote THEN
          VALIDATE("Location Code",UserSetupMgt.GetLocation(1,Vend."Location Code","Responsibility Center"));
        //BC6 - MM 100119 <<
        */
    //end;


    //Unsupported feature: Code Modification on "TestNoSeries(PROCEDURE 6)".

    //procedure TestNoSeries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PurchSetup.GET;
        CASE "Document Type" OF
          "Document Type"::Quote:
        #4..9
              PurchSetup.TESTFIELD("Posted Invoice Nos.");
            END;
          "Document Type"::"Return Order":
            PurchSetup.TESTFIELD("Return Order Nos.");
          "Document Type"::"Credit Memo":
            BEGIN
              PurchSetup.TESTFIELD("Credit Memo Nos.");
              PurchSetup.TESTFIELD("Posted Credit Memo Nos.");
            END;
          "Document Type"::"Blanket Order":
            PurchSetup.TESTFIELD("Blanket Order Nos.");
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..12
            //>>BC6
            // OLD STD PurchSetup.TESTFIELD("Return Order Nos.");
            BEGIN
              IF "Return Order Type" = "Return Order Type"::SAV THEN
                PurchSetup.TESTFIELD("SAV Return Order Nos.")
              ELSE
                PurchSetup.TESTFIELD("Return Order Nos.");
            END;
            //<<BC6
        #14..21
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
            EXIT(PurchSetup."Quote Nos.");
          "Document Type"::Order:
            EXIT(PurchSetup."Order Nos.");
          "Document Type"::Invoice:
            EXIT(PurchSetup."Invoice Nos.");
          "Document Type"::"Return Order":
            EXIT(PurchSetup."Return Order Nos.");
          "Document Type"::"Credit Memo":
            EXIT(PurchSetup."Credit Memo Nos.");
          "Document Type"::"Blanket Order":
            EXIT(PurchSetup."Blanket Order Nos.");
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CASE "Document Type" OF
          "Document Type"::Quote:
            NoSeriesCode := PurchSetup."Quote Nos.";
          "Document Type"::Order:
            NoSeriesCode := PurchSetup."Order Nos.";
          "Document Type"::Invoice:
            NoSeriesCode := PurchSetup."Invoice Nos.";
          "Document Type"::"Return Order":
            //>>BC6
            // OLD STD NoSeriesCode := PurchSetup."Return Order Nos.";
            BEGIN
              IF "Return Order Type" = "Return Order Type"::SAV THEN
                NoSeriesCode := PurchSetup."SAV Return Order Nos."
              ELSE
                NoSeriesCode := PurchSetup."Return Order Nos.";
            END;
            //<<BC6
          "Document Type"::"Credit Memo":
            NoSeriesCode := PurchSetup."Credit Memo Nos.";
          "Document Type"::"Blanket Order":
            NoSeriesCode := PurchSetup."Blanket Order Nos.";
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
          EXIT(PurchSetup."Posted Credit Memo Nos.");
        EXIT(PurchSetup."Posted Invoice Nos.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF IsCreditDocType THEN
          EXIT(PurchSetup."Posted Credit Memo Nos.");
        EXIT(PurchSetup."Posted Invoice Nos.");
        */
    //end;


    //Unsupported feature: Code Modification on "GetPostingPrepaymentNoSeriesCode(PROCEDURE 37)".

    //procedure GetPostingPrepaymentNoSeriesCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
          EXIT(PurchSetup."Posted Prepmt. Cr. Memo Nos.");
        EXIT(PurchSetup."Posted Prepmt. Inv. Nos.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF IsCreditDocType THEN
          EXIT(PurchSetup."Posted Prepmt. Cr. Memo Nos.");
        EXIT(PurchSetup."Posted Prepmt. Inv. Nos.");
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: SourceCode) (VariableCollection) on "ConfirmDeletion(PROCEDURE 11)".


    //Unsupported feature: Variable Insertion (Variable: SourceCodeSetup) (VariableCollection) on "ConfirmDeletion(PROCEDURE 11)".


    //Unsupported feature: Variable Insertion (Variable: PostPurchDelete) (VariableCollection) on "ConfirmDeletion(PROCEDURE 11)".



    //Unsupported feature: Code Modification on "ConfirmDeletion(PROCEDURE 11)".

    //procedure ConfirmDeletion();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PurchPost.TestDeleteHeader(
          Rec,PurchRcptHeader,PurchInvHeader,PurchCrMemoHeader,
          ReturnShptHeader,PurchInvHeaderPrepmt,PurchCrMemoHeaderPrepmt);
        IF PurchRcptHeader."No." <> '' THEN
          IF NOT CONFIRM(
               Text009 +
               Text010 +
               Text011,TRUE,
               PurchRcptHeader."No.")
          THEN
            EXIT;
        IF PurchInvHeader."No." <> '' THEN
          IF NOT CONFIRM(
               Text012 +
               Text013 +
               Text011,TRUE,
               PurchInvHeader."No.")
          THEN
            EXIT;
        IF PurchCrMemoHeader."No." <> '' THEN
          IF NOT CONFIRM(
               Text014 +
               Text015 +
               Text011,TRUE,
               PurchCrMemoHeader."No.")
          THEN
            EXIT;
        IF ReturnShptHeader."No." <> '' THEN
          IF NOT CONFIRM(
               Text029 +
               Text030 +
               Text011,TRUE,
               ReturnShptHeader."No.")
          THEN
            EXIT;
        IF "Prepayment No." <> '' THEN
          IF NOT CONFIRM(
               Text044 +
               Text045 +
               Text011,TRUE,
               PurchInvHeaderPrepmt."No.")
          THEN
            EXIT;
        IF "Prepmt. Cr. Memo No." <> '' THEN
          IF NOT CONFIRM(
               Text046 +
               Text047 +
               Text011,TRUE,
               PurchCrMemoHeaderPrepmt."No.")
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

        PostPurchDelete.InitDeleteHeader(
          Rec,PurchRcptHeader,PurchInvHeader,PurchCrMemoHeader,
          ReturnShptHeader,PurchInvHeaderPrepmt,PurchCrMemoHeaderPrepmt,SourceCode.Code);

        IF PurchRcptHeader."No." <> '' THEN
          IF NOT CONFIRM(Text009,TRUE,PurchRcptHeader."No.")
        #10..12
          IF NOT CONFIRM(Text012,TRUE,PurchInvHeader."No.")
        #18..20
          IF NOT CONFIRM(Text014,TRUE,PurchCrMemoHeader."No.")
        #26..28
          IF NOT CONFIRM(Text029,TRUE,ReturnShptHeader."No.")
        #34..36
          IF NOT CONFIRM(Text045,TRUE,PurchInvHeaderPrepmt."No.")
        #42..44
          IF NOT CONFIRM(Text046,TRUE,PurchCrMemoHeaderPrepmt."No.")
        #50..52
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: TempPurchLine) (VariableCollection) on "RecreatePurchLines(PROCEDURE 4)".


    //Unsupported feature: Variable Insertion (Variable: TransferExtendedText) (VariableCollection) on "RecreatePurchLines(PROCEDURE 4)".


    //Unsupported feature: Property Insertion (Local) on "RecreatePurchLines(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "RecreatePurchLines(PROCEDURE 4)".

    //procedure RecreatePurchLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF PurchLinesExist THEN BEGIN
          IF HideValidationDialog THEN
            Confirmed := TRUE
          ELSE
            Confirmed :=
              CONFIRM(
                Text016 +
                Text004,FALSE,ChangedFieldName);
          IF Confirmed THEN BEGIN
            PurchLine.LOCKTABLE;
            ItemChargeAssgntPurch.LOCKTABLE;
            MODIFY;

            PurchLine.RESET;
            PurchLine.SETRANGE("Document Type","Document Type");
            PurchLine.SETRANGE("Document No.","No.");
            IF PurchLine.FINDSET THEN BEGIN
              REPEAT
                PurchLine.TESTFIELD("Quantity Received",0);
                PurchLine.TESTFIELD("Quantity Invoiced",0);
                PurchLine.TESTFIELD("Return Qty. Shipped",0);
                PurchLine.CALCFIELDS("Reserved Qty. (Base)");
                PurchLine.TESTFIELD("Reserved Qty. (Base)",0);
                PurchLine.TESTFIELD("Receipt No.",'');
                PurchLine.TESTFIELD("Return Shipment No.",'');
                PurchLine.TESTFIELD("Blanket Order No.",'');
                IF PurchLine."Drop Shipment" OR PurchLine."Special Order" THEN BEGIN
                  CASE TRUE OF
                    PurchLine."Drop Shipment":
                      SalesHeader.GET(SalesHeader."Document Type"::Order,PurchLine."Sales Order No.");
                    PurchLine."Special Order":
                      SalesHeader.GET(SalesHeader."Document Type"::Order,PurchLine."Special Order Sales No.");
                  END;
                  TESTFIELD("Sell-to Customer No.",SalesHeader."Sell-to Customer No.");
                  TESTFIELD("Ship-to Code",SalesHeader."Ship-to Code");
                END;

                PurchLine.TESTFIELD("Prepmt. Amt. Inv.",0);
                PurchLineTmp := PurchLine;
                IF PurchLine.Nonstock THEN BEGIN
                  PurchLine.Nonstock := FALSE;
                  PurchLine.MODIFY;
                END;
                PurchLineTmp.INSERT;
              UNTIL PurchLine.NEXT = 0;

              ItemChargeAssgntPurch.SETRANGE("Document Type","Document Type");
              ItemChargeAssgntPurch.SETRANGE("Document No.","No.");
              IF ItemChargeAssgntPurch.FINDSET THEN BEGIN
                REPEAT
                  TempItemChargeAssgntPurch.INIT;
                  TempItemChargeAssgntPurch := ItemChargeAssgntPurch;
                  TempItemChargeAssgntPurch.INSERT;
                UNTIL ItemChargeAssgntPurch.NEXT = 0;
                ItemChargeAssgntPurch.DELETEALL;
              END;

              PurchLine.DELETEALL(TRUE);

              PurchLine.INIT;
              PurchLine."Line No." := 0;
              PurchLineTmp.FINDSET;
              ExtendedTextAdded := FALSE;
              REPEAT
                IF PurchLineTmp."Attached to Line No." = 0 THEN BEGIN
                  PurchLine.INIT;
                  PurchLine."Line No." := PurchLine."Line No." + 10000;
                  PurchLine.VALIDATE(Type,PurchLineTmp.Type);
                  IF PurchLineTmp."No." = '' THEN BEGIN
                    PurchLine.VALIDATE(Description,PurchLineTmp.Description);
                    PurchLine.VALIDATE("Description 2",PurchLineTmp."Description 2");
                    PurchLine.INSERT;
                  END ELSE BEGIN
                    PurchLine.VALIDATE("No.",PurchLineTmp."No.");
                    IF PurchLine.Type <> PurchLine.Type::" " THEN
                      CASE TRUE OF
                        PurchLineTmp."Drop Shipment":
                          BEGIN
                            SalesLine.GET(SalesLine."Document Type"::Order,
                              PurchLineTmp."Sales Order No.",
                              PurchLineTmp."Sales Order Line No.");
                            CopyDocMgt.TransfldsFromSalesToPurchLine(SalesLine,PurchLine);
                            PurchLine."Drop Shipment" := PurchLineTmp."Drop Shipment";
                            PurchLine."Purchasing Code" := SalesLine."Purchasing Code";
                            PurchLine."Sales Order No." := PurchLineTmp."Sales Order No.";
                            PurchLine."Sales Order Line No." := PurchLineTmp."Sales Order Line No.";
                            EVALUATE(PurchLine."Inbound Whse. Handling Time",'<0D>');
                            PurchLine.VALIDATE("Inbound Whse. Handling Time");
                            PurchLine.INSERT;

                            SalesLine.VALIDATE("Unit Cost (LCY)",PurchLine."Unit Cost (LCY)");
                            SalesLine."Purchase Order No." := PurchLine."Document No.";
                            SalesLine."Purch. Order Line No." := PurchLine."Line No.";
                            SalesLine.MODIFY;
                          END;
                        PurchLineTmp."Special Order":
                          BEGIN
                            SalesLine.GET(SalesLine."Document Type"::Order,
                              PurchLineTmp."Special Order Sales No.",
                              PurchLineTmp."Special Order Sales Line No.");
                            CopyDocMgt.TransfldsFromSalesToPurchLine(SalesLine,PurchLine);
                            PurchLine."Special Order" := PurchLineTmp."Special Order";
                            PurchLine."Purchasing Code" := SalesLine."Purchasing Code";
                            PurchLine."Special Order Sales No." := PurchLineTmp."Special Order Sales No.";
                            PurchLine."Special Order Sales Line No." := PurchLineTmp."Special Order Sales Line No.";
                            PurchLine.INSERT;

                            SalesLine.VALIDATE("Unit Cost (LCY)",PurchLine."Unit Cost (LCY)");
                            SalesLine."Special Order Purchase No." := PurchLine."Document No.";
                            SalesLine."Special Order Purch. Line No." := PurchLine."Line No.";
                            SalesLine.MODIFY;
                          END;
                        ELSE BEGIN
                          PurchLine.VALIDATE("Unit of Measure Code",PurchLineTmp."Unit of Measure Code");
                          PurchLine.VALIDATE("Variant Code",PurchLineTmp."Variant Code");
                          PurchLine."Prod. Order No." := PurchLineTmp."Prod. Order No.";
                          IF PurchLine."Prod. Order No." <> '' THEN BEGIN
                            PurchLine.Description := PurchLineTmp.Description;
                            PurchLine.VALIDATE("VAT Prod. Posting Group",PurchLineTmp."VAT Prod. Posting Group");
                            PurchLine.VALIDATE("Gen. Prod. Posting Group",PurchLineTmp."Gen. Prod. Posting Group");
                            PurchLine.VALIDATE("Expected Receipt Date",PurchLineTmp."Expected Receipt Date");
                            PurchLine.VALIDATE("Requested Receipt Date",PurchLineTmp."Requested Receipt Date");
                            PurchLine.VALIDATE("Qty. per Unit of Measure",PurchLineTmp."Qty. per Unit of Measure");
                          END;
                          IF (PurchLineTmp."Job No." <> '') AND (PurchLineTmp."Job Task No." <> '') THEN BEGIN
                            PurchLine.VALIDATE("Job No.",PurchLineTmp."Job No.");
                            PurchLine.VALIDATE("Job Task No.",PurchLineTmp."Job Task No.");
                            PurchLine."Job Line Type" := PurchLineTmp."Job Line Type";
                          END;
                          IF PurchLineTmp.Quantity <> 0 THEN
                            PurchLine.VALIDATE(Quantity,PurchLineTmp.Quantity);
                          IF "Currency Code" = xRec."Currency Code" THEN
                            PurchLine.VALIDATE("Direct Unit Cost",PurchLineTmp."Direct Unit Cost");
                          PurchLine."Routing No." := PurchLineTmp."Routing No.";
                          PurchLine."Routing Reference No." := PurchLineTmp."Routing Reference No.";
                          PurchLine."Operation No." := PurchLineTmp."Operation No.";
                          PurchLine."Work Center No." := PurchLineTmp."Work Center No.";
                          PurchLine."Prod. Order Line No." := PurchLineTmp."Prod. Order Line No.";
                          PurchLine."Overhead Rate" := PurchLineTmp."Overhead Rate";
                          PurchLine.INSERT;
                        END;
                      END;
                  END;
                  ExtendedTextAdded := FALSE;

                  IF PurchLine.Type = PurchLine.Type::Item THEN BEGIN
                    ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
                    TempItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Type",PurchLineTmp."Document Type");
                    TempItemChargeAssgntPurch.SETRANGE("Applies-to Doc. No.",PurchLineTmp."Document No.");
                    TempItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Line No.",PurchLineTmp."Line No.");
                    IF TempItemChargeAssgntPurch.FINDSET THEN
                      REPEAT
                        IF NOT TempItemChargeAssgntPurch.MARK THEN BEGIN
                          TempItemChargeAssgntPurch."Applies-to Doc. Line No." := PurchLine."Line No.";
                          TempItemChargeAssgntPurch.Description := PurchLine.Description;
                          TempItemChargeAssgntPurch.MODIFY;
                          TempItemChargeAssgntPurch.MARK(TRUE);
                        END;
                      UNTIL TempItemChargeAssgntPurch.NEXT = 0;
                  END;
                  IF PurchLine.Type = PurchLine.Type::"Charge (Item)" THEN BEGIN
                    TempInteger.INIT;
                    TempInteger.Number := PurchLine."Line No.";
                    TempInteger.INSERT;
                  END;
                END ELSE
                  IF NOT ExtendedTextAdded THEN BEGIN
                    TransferExtendedText.PurchCheckIfAnyExtText(PurchLine,TRUE);
                    TransferExtendedText.InsertPurchExtText(PurchLine);
                    PurchLine.FINDLAST;
                    ExtendedTextAdded := TRUE;
                  END;
              UNTIL PurchLineTmp.NEXT = 0;

              ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
              PurchLineTmp.SETRANGE(Type,PurchLine.Type::"Charge (Item)");
              IF PurchLineTmp.FINDSET THEN
                REPEAT
                  TempItemChargeAssgntPurch.SETRANGE("Document Line No.",PurchLineTmp."Line No.");
                  IF TempItemChargeAssgntPurch.FINDSET THEN BEGIN
                    REPEAT
                      TempInteger.FINDFIRST;
                      ItemChargeAssgntPurch.INIT;
                      ItemChargeAssgntPurch := TempItemChargeAssgntPurch;
                      ItemChargeAssgntPurch."Document Line No." := TempInteger.Number;
                      ItemChargeAssgntPurch.VALIDATE("Unit Cost",0);
                      ItemChargeAssgntPurch.INSERT;
                    UNTIL TempItemChargeAssgntPurch.NEXT = 0;
                    TempInteger.DELETE;
                  END;
                UNTIL PurchLineTmp.NEXT = 0;

              PurchLineTmp.SETRANGE(Type);
              PurchLineTmp.DELETEALL;
              ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
              TempItemChargeAssgntPurch.DELETEALL;
            END;
          END ELSE
            ERROR(
              Text018,ChangedFieldName);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
                ConfirmChangeQst,FALSE,ChangedFieldName);
        #9..38
                TempPurchLine := PurchLine;
        #40..43
                TempPurchLine.INSERT;
        #45..61
              TempPurchLine.FINDSET;
              ExtendedTextAdded := FALSE;
              REPEAT
                IF TempPurchLine."Attached to Line No." = 0 THEN BEGIN
                  PurchLine.INIT;
                  PurchLine."Line No." := PurchLine."Line No." + 10000;
                  PurchLine.VALIDATE(Type,TempPurchLine.Type);
                  IF TempPurchLine."No." = '' THEN BEGIN
                    PurchLine.VALIDATE(Description,TempPurchLine.Description);
                    PurchLine.VALIDATE("Description 2",TempPurchLine."Description 2");
                  END ELSE BEGIN
                    PurchLine.VALIDATE("No.",TempPurchLine."No.");
                    IF PurchLine.Type <> PurchLine.Type::" " THEN
                      CASE TRUE OF
                        TempPurchLine."Drop Shipment":
                          TransferSavedFieldsDropShipment(PurchLine,TempPurchLine);
                        TempPurchLine."Special Order":
                          TransferSavedFieldsSpecialOrder(PurchLine,TempPurchLine);
                        ELSE
                          TransferSavedFields(PurchLine,TempPurchLine);
                      END;
                  END;

                  PurchLine.INSERT;
        #144..147
                    TempItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Type",TempPurchLine."Document Type");
                    TempItemChargeAssgntPurch.SETRANGE("Applies-to Doc. No.",TempPurchLine."Document No.");
                    TempItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Line No.",TempPurchLine."Line No.");
        #151..172
              UNTIL TempPurchLine.NEXT = 0;

              ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
              TempPurchLine.SETRANGE(Type,PurchLine.Type::"Charge (Item)");
              IF TempPurchLine.FINDSET THEN
                REPEAT
                  TempItemChargeAssgntPurch.SETRANGE("Document Line No.",TempPurchLine."Line No.");
        #180..190
                UNTIL TempPurchLine.NEXT = 0;

              TempPurchLine.SETRANGE(Type);
              TempPurchLine.DELETEALL;
        #195..201
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "MessageIfPurchLinesExist(PROCEDURE 5)".


    //Unsupported feature: Property Insertion (Local) on "PriceMessageIfPurchLinesExist(PROCEDURE 7)".


    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "ConfirmUpdateCurrencyFactor(PROCEDURE 13)".



    //Unsupported feature: Code Modification on "ConfirmUpdateCurrencyFactor(PROCEDURE 13)".

    //procedure ConfirmUpdateCurrencyFactor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF HideValidationDialog THEN
          Confirmed := TRUE
        ELSE
          Confirmed := CONFIRM(Text022,FALSE);
        IF Confirmed THEN
          VALIDATE("Currency Factor")
        ELSE
          "Currency Factor" := xRec."Currency Factor";
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..8
        EXIT(Confirmed);
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: AskQuestion) (ParameterCollection) on "UpdatePurchLines(PROCEDURE 15)".


    //Unsupported feature: Variable Insertion (Variable: PurchLineReserve) (VariableCollection) on "UpdatePurchLines(PROCEDURE 15)".


    //Unsupported feature: Variable Insertion (Variable: Question) (VariableCollection) on "UpdatePurchLines(PROCEDURE 15)".


    //Unsupported feature: Property Insertion (Local) on "UpdatePurchLines(PROCEDURE 15)".



    //Unsupported feature: Code Modification on "UpdatePurchLines(PROCEDURE 15)".

    //procedure UpdatePurchLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT PurchLinesExist THEN
          EXIT;

        IF NOT GUIALLOWED THEN
          UpdateConfirmed := TRUE
        ELSE
          CASE ChangedFieldName OF
            FIELDCAPTION("Expected Receipt Date"):
              BEGIN
                UpdateConfirmed :=
                  CONFIRM(
                    STRSUBSTNO(
                      Text032 +
                      Text033,ChangedFieldName));
                IF UpdateConfirmed THEN
                  ConfirmResvDateConflict;
              END;
            FIELDCAPTION("Requested Receipt Date"):
              BEGIN
                UpdateConfirmed :=
                  CONFIRM(
                    STRSUBSTNO(
                      Text032 +
                      Text033,ChangedFieldName));
                IF UpdateConfirmed THEN
                  ConfirmResvDateConflict;
              END;
            FIELDCAPTION("Promised Receipt Date"):
              BEGIN
                UpdateConfirmed :=
                  CONFIRM(
                    STRSUBSTNO(
                      Text032 +
                      Text033,ChangedFieldName));
                IF UpdateConfirmed THEN
                  ConfirmResvDateConflict;
              END;
            FIELDCAPTION("Lead Time Calculation"):
              BEGIN
                UpdateConfirmed :=
                  CONFIRM(
                    STRSUBSTNO(
                      Text032 +
                      Text033,ChangedFieldName));
                IF UpdateConfirmed THEN
                  ConfirmResvDateConflict;
              END;
            FIELDCAPTION("Inbound Whse. Handling Time"):
              BEGIN
                UpdateConfirmed :=
                  CONFIRM(
                    STRSUBSTNO(
                      Text032 +
                      Text033,ChangedFieldName));
                IF UpdateConfirmed THEN
                  ConfirmResvDateConflict;
              END;
            FIELDCAPTION("Prepayment %"):
              UpdateConfirmed :=
                CONFIRM(
                  STRSUBSTNO(
                    Text032 +
                    Text033,ChangedFieldName));
          END;

        PurchLine.LOCKTABLE;
        MODIFY;

        REPEAT
          xPurchLine := PurchLine;
          CASE ChangedFieldName OF
            FIELDCAPTION("Expected Receipt Date"):
              IF UpdateConfirmed AND (PurchLine."No." <> '') THEN
                PurchLine.VALIDATE("Expected Receipt Date","Expected Receipt Date");
            FIELDCAPTION("Currency Factor"):
              IF PurchLine.Type <> PurchLine.Type::" " THEN
                PurchLine.VALIDATE("Direct Unit Cost");
            FIELDCAPTION("Transaction Type"):
              PurchLine.VALIDATE("Transaction Type","Transaction Type");
            FIELDCAPTION("Transport Method"):
              PurchLine.VALIDATE("Transport Method","Transport Method");
            FIELDCAPTION("Entry Point"):
              PurchLine.VALIDATE("Entry Point","Entry Point");
            FIELDCAPTION(Area):
              PurchLine.VALIDATE(Area,Area);
            FIELDCAPTION("Transaction Specification"):
              PurchLine.VALIDATE("Transaction Specification","Transaction Specification");
            FIELDCAPTION("Requested Receipt Date"):
              IF UpdateConfirmed AND (PurchLine."No." <> '') THEN
                PurchLine.VALIDATE("Requested Receipt Date","Requested Receipt Date");
            FIELDCAPTION("Prepayment %"):
              IF UpdateConfirmed AND (PurchLine."No." <> '') THEN
                PurchLine.VALIDATE("Prepayment %","Prepayment %");
            FIELDCAPTION("Promised Receipt Date"):
              IF UpdateConfirmed AND (PurchLine."No." <> '') THEN
                PurchLine.VALIDATE("Promised Receipt Date","Promised Receipt Date");
            FIELDCAPTION("Lead Time Calculation"):
              IF UpdateConfirmed AND (PurchLine."No." <> '') THEN
                PurchLine.VALIDATE("Lead Time Calculation","Lead Time Calculation");
            FIELDCAPTION("Inbound Whse. Handling Time"):
              IF UpdateConfirmed AND (PurchLine."No." <> '') THEN
                PurchLine.VALIDATE("Inbound Whse. Handling Time","Inbound Whse. Handling Time");
          END;
          PurchLine.MODIFY(TRUE);
          ReservePurchLine.VerifyChange(PurchLine,xPurchLine);
        UNTIL PurchLine.NEXT = 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        IF AskQuestion THEN BEGIN
          Question := STRSUBSTNO(
              Text032 +
              Text033,ChangedFieldName);
          IF GUIALLOWED THEN
            IF DIALOG.CONFIRM(Question,TRUE) THEN
              CASE ChangedFieldName OF
                FIELDCAPTION("Expected Receipt Date"),
                FIELDCAPTION("Requested Receipt Date"),
                FIELDCAPTION("Promised Receipt Date"),
                FIELDCAPTION("Lead Time Calculation"),
                FIELDCAPTION("Inbound Whse. Handling Time"):
                  ConfirmResvDateConflict;
              END
            ELSE
              EXIT;
        END;
        #65..68
        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type","Document Type");
        PurchLine.SETRANGE("Document No.","No.");
        IF PurchLine.FINDSET THEN
          REPEAT
            xPurchLine := PurchLine;
            CASE ChangedFieldName OF
              FIELDCAPTION("Expected Receipt Date"):
                IF PurchLine."No." <> '' THEN
                  PurchLine.VALIDATE("Expected Receipt Date","Expected Receipt Date");
              FIELDCAPTION("Currency Factor"):
                IF PurchLine.Type <> PurchLine.Type::" " THEN
                  PurchLine.VALIDATE("Direct Unit Cost");
              FIELDCAPTION("Transaction Type"):
                PurchLine.VALIDATE("Transaction Type","Transaction Type");
              FIELDCAPTION("Transport Method"):
                PurchLine.VALIDATE("Transport Method","Transport Method");
              FIELDCAPTION("Entry Point"):
                PurchLine.VALIDATE("Entry Point","Entry Point");
              FIELDCAPTION(Area):
                PurchLine.VALIDATE(Area,Area);
              FIELDCAPTION("Transaction Specification"):
                PurchLine.VALIDATE("Transaction Specification","Transaction Specification");
              FIELDCAPTION("Requested Receipt Date"):
                IF PurchLine."No." <> '' THEN
                  PurchLine.VALIDATE("Requested Receipt Date","Requested Receipt Date");
              FIELDCAPTION("Prepayment %"):
                IF PurchLine."No." <> '' THEN
                  PurchLine.VALIDATE("Prepayment %","Prepayment %");
              FIELDCAPTION("Promised Receipt Date"):
                IF PurchLine."No." <> '' THEN
                  PurchLine.VALIDATE("Promised Receipt Date","Promised Receipt Date");
              FIELDCAPTION("Lead Time Calculation"):
                IF PurchLine."No." <> '' THEN
                  PurchLine.VALIDATE("Lead Time Calculation","Lead Time Calculation");
              FIELDCAPTION("Inbound Whse. Handling Time"):
                IF PurchLine."No." <> '' THEN
                  PurchLine.VALIDATE("Inbound Whse. Handling Time","Inbound Whse. Handling Time");
              PurchLine.FIELDCAPTION("Deferral Code"):
                IF PurchLine."No." <> '' THEN
                  PurchLine.VALIDATE("Deferral Code");
            END;
            PurchLine.MODIFY(TRUE);
            PurchLineReserve.VerifyChange(PurchLine,xPurchLine);
          UNTIL PurchLine.NEXT = 0;
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "ConfirmResvDateConflict(PROCEDURE 31)".



    //Unsupported feature: Code Modification on "ConfirmResvDateConflict(PROCEDURE 31)".

    //procedure ConfirmResvDateConflict();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ResvEngMgt.ResvExistsForPurchHeader(Rec) THEN
          IF NOT CONFIRM(Text050 + Text011,FALSE) THEN
            ERROR('');
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF ResvEngMgt.ResvExistsForPurchHeader(Rec) THEN
          IF NOT CONFIRM(Text050,FALSE) THEN
            ERROR('');
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "ValidateShortcutDimCode(PROCEDURE 19)".


    //Unsupported feature: Property Insertion (Local) on "ReceivedPurchLinesExist(PROCEDURE 20)".


    //Unsupported feature: Property Insertion (Local) on "ReturnShipmentExist(PROCEDURE 5800)".



    //Unsupported feature: Code Modification on "UpdateShipToAddress(PROCEDURE 21)".

    //procedure UpdateShipToAddress();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
          EXIT;

        IF ("Location Code" <> '') AND
           Location.GET("Location Code") AND
           ("Sell-to Customer No." = '')
        THEN BEGIN
          "Ship-to Name" := Location.Name;
          "Ship-to Name 2" := Location."Name 2";
          "Ship-to Address" := Location.Address;
          "Ship-to Address 2" := Location."Address 2";
          "Ship-to City" := Location.City;
          "Ship-to Post Code" := Location."Post Code";
          "Ship-to County" := Location.County;
          "Ship-to Country/Region Code" := Location."Country/Region Code";
          "Ship-to Contact" := Location.Contact;
        END;

        IF ("Location Code" = '') AND
           ("Sell-to Customer No." = '')
        THEN BEGIN
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
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF IsCreditDocType THEN
          EXIT;

        IF ("Location Code" <> '') AND Location.GET("Location Code") AND ("Sell-to Customer No." = '') THEN BEGIN
          SetShipToAddress(
            Location.Name,Location."Name 2",Location.Address,Location."Address 2",
            Location.City,Location."Post Code",Location.County,Location."Country/Region Code");
        #16..18
        IF ("Location Code" = '') AND ("Sell-to Customer No." = '') THEN BEGIN
          CompanyInfo.GET;
          "Ship-to Code" := '';
          SetShipToAddress(
            CompanyInfo."Ship-to Name",CompanyInfo."Ship-to Name 2",CompanyInfo."Ship-to Address",CompanyInfo."Ship-to Address 2",
            CompanyInfo."Ship-to City",CompanyInfo."Ship-to Post Code",CompanyInfo."Ship-to County",
            CompanyInfo."Ship-to Country/Region Code");
          "Ship-to Contact" := CompanyInfo."Ship-to Contact";
        END;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ReservMgt) (VariableCollection) on "DeletePurchaseLines(PROCEDURE 17)".



    //Unsupported feature: Code Modification on "DeletePurchaseLines(PROCEDURE 17)".

    //procedure DeletePurchaseLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF PurchLine.FINDSET THEN BEGIN
          HandleItemTrackingDeletion;
          REPEAT
            PurchLine.SuspendStatusCheck(TRUE);
            PurchLine.DELETE(TRUE);
          UNTIL PurchLine.NEXT = 0;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF PurchLine.FINDSET THEN BEGIN
          ReservMgt.DeleteDocumentReservation(DATABASE::"Purchase Line","Document Type","No.",HideValidationDialog);
        #3..7
        */
    //end;

    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "IsTotalValid(PROCEDURE 36)".


    //Unsupported feature: Variable Insertion (Variable: IncomingDocument) (VariableCollection) on "IsTotalValid(PROCEDURE 36)".


    //Unsupported feature: Variable Insertion (Variable: PurchaseLine) (VariableCollection) on "IsTotalValid(PROCEDURE 36)".


    //Unsupported feature: Variable Insertion (Variable: TempTotalPurchaseLine) (VariableCollection) on "IsTotalValid(PROCEDURE 36)".


    //Unsupported feature: Variable Insertion (Variable: DocumentTotals) (VariableCollection) on "IsTotalValid(PROCEDURE 36)".


    //Unsupported feature: Variable Insertion (Variable: VATAmount) (VariableCollection) on "IsTotalValid(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Name) on "HandleItemTrackingDeletion(PROCEDURE 36)".



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
          SETRANGE("Source Type",DATABASE::"Purchase Line");
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
            Confirmed := CONFIRM(Text041,FALSE,LOWERCASE(FORMAT("Document Type")),"No.");

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
        IF NOT IncomingDocument.GET("Incoming Document Entry No.") THEN
          EXIT(TRUE);

        IF IncomingDocument."Amount Incl. VAT" = 0 THEN
          EXIT(TRUE);

        PurchaseLine.SETRANGE("Document Type","Document Type");
        PurchaseLine.SETRANGE("Document No.","No.");
        IF NOT PurchaseLine.FINDFIRST THEN
          EXIT(TRUE);

        IF IncomingDocument."Currency Code" <> PurchaseLine."Currency Code" THEN
          EXIT(TRUE);

        TempTotalPurchaseLine.INIT;
        DocumentTotals.PurchaseCalculateTotalsWithInvoiceRounding(PurchaseLine,VATAmount,TempTotalPurchaseLine);

        EXIT(IncomingDocument."Amount Incl. VAT" = TempTotalPurchaseLine."Amount Including VAT");
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: OfficeContact) (VariableCollection) on "UpdateBuyFromCont(PROCEDURE 24)".


    //Unsupported feature: Variable Insertion (Variable: OfficeMgt) (VariableCollection) on "UpdateBuyFromCont(PROCEDURE 24)".


    //Unsupported feature: Property Insertion (Local) on "UpdateBuyFromCont(PROCEDURE 24)".



    //Unsupported feature: Code Modification on "UpdateBuyFromCont(PROCEDURE 24)".

    //procedure UpdateBuyFromCont();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Vend.GET(VendorNo) THEN BEGIN
          IF Vend."Primary Contact No." <> '' THEN
            "Buy-from Contact No." := Vend."Primary Contact No."
          ELSE BEGIN
            ContBusRel.RESET;
            ContBusRel.SETCURRENTKEY("Link to Table","No.");
            ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Vendor);
            ContBusRel.SETRANGE("No.","Buy-from Vendor No.");
            IF ContBusRel.FINDFIRST THEN
              "Buy-from Contact No." := ContBusRel."Contact No."
            ELSE
              "Buy-from Contact No." := '';
          END;
          "Buy-from Contact" := Vend.Contact;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF OfficeMgt.GetContact(OfficeContact,VendorNo) THEN BEGIN
          SetHideValidationDialog(TRUE);
          UpdateBuyFromVend(OfficeContact."No.");
          SetHideValidationDialog(FALSE);
        END ELSE
          IF Vend.GET(VendorNo) THEN BEGIN
            IF Vend."Primary Contact No." <> '' THEN
              "Buy-from Contact No." := Vend."Primary Contact No."
            ELSE BEGIN
              ContBusRel.RESET;
              ContBusRel.SETCURRENTKEY("Link to Table","No.");
              ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Vendor);
              ContBusRel.SETRANGE("No.","Buy-from Vendor No.");
              IF ContBusRel.FINDFIRST THEN
                "Buy-from Contact No." := ContBusRel."Contact No."
              ELSE
                "Buy-from Contact No." := '';
            END;
            "Buy-from Contact" := Vend.Contact;
          END;

        //>>MIGRATION NAV 2013
        //>>FE005
        UpdateBuyFromFax("Buy-from Contact No.");
        UpdateBuyFromMail("Buy-from Contact No.");
        //<<FE005
        //<<MIGRATION NAV 2013
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "UpdatePayToCont(PROCEDURE 27)".


    //Unsupported feature: Property Insertion (Local) on "UpdateBuyFromVend(PROCEDURE 25)".



    //Unsupported feature: Code Modification on "UpdateBuyFromVend(PROCEDURE 25)".

    //procedure UpdateBuyFromVend();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Cont.GET(ContactNo) THEN BEGIN
          "Buy-from Contact No." := Cont."No.";
          IF Cont.Type = Cont.Type::Person THEN
        #4..28
        END ELSE
          ERROR(Text039,Cont."No.",Cont.Name);

        IF ("Buy-from Vendor No." = "Pay-to Vendor No.") OR
           ("Pay-to Vendor No." = '')
        THEN
          VALIDATE("Pay-to Contact No.","Buy-from Contact No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..31
        //>>MIGRATION NAV 2013
        //>>FE005
        UpdateBuyFromFax("Buy-from Contact No.");
        UpdateBuyFromMail("Buy-from Contact No.");
        //<<FE005
        //<<MIGRATION NAV 2013

        #32..35
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "UpdatePayToVend(PROCEDURE 26)".


    //Unsupported feature: Variable Insertion (Variable: RepLCreateInvtPutPickMvmt) (VariableCollection) on "CreateInvtPutAwayPick(PROCEDURE 29)".



    //Unsupported feature: Code Modification on "CreateInvtPutAwayPick(PROCEDURE 29)".

    //procedure CreateInvtPutAwayPick();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TESTFIELD(Status,Status::Released);

        WhseRequest.RESET;
        #4..8
            WhseRequest.SETRANGE("Source Document",WhseRequest."Source Document"::"Purchase Return Order");
        END;
        WhseRequest.SETRANGE("Source No.","No.");
        REPORT.RUNMODAL(REPORT::"Create Invt Put-away/Pick/Mvmt",TRUE,FALSE,WhseRequest);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..11

        //>>MIGRATION 2013
        RepLCreateInvtPutPickMvmt.SETTABLEVIEW(WhseRequest);
        RepLCreateInvtPutPickMvmt.InitializeRequest(TRUE,FALSE,FALSE,TRUE,FALSE);
        RepLCreateInvtPutPickMvmt.RUN;
        //REPORT.RUNMODAL(REPORT::"Create Invt Put-away/Pick/Mvmt",TRUE,FALSE,WhseRequest);
        //>>MIGRATION 2013
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: ReceivedShippedItemLineDimChangeConfirmed) (VariableCollection) on "UpdateAllLineDim(PROCEDURE 34)".



    //Unsupported feature: Code Modification on "UpdateAllLineDim(PROCEDURE 34)".

    //procedure UpdateAllLineDim();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        // Update all lines with changed dimensions.

        IF NewParentDimSetID = OldParentDimSetID THEN
        #4..13
            NewDimSetID := DimMgt.GetDeltaDimSetID(PurchLine."Dimension Set ID",NewParentDimSetID,OldParentDimSetID);
            IF PurchLine."Dimension Set ID" <> NewDimSetID THEN BEGIN
              PurchLine."Dimension Set ID" := NewDimSetID;
              DimMgt.UpdateGlobalDimFromDimSetID(
                PurchLine."Dimension Set ID",PurchLine."Shortcut Dimension 1 Code",PurchLine."Shortcut Dimension 2 Code");
              PurchLine.MODIFY;
            END;
          UNTIL PurchLine.NEXT = 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..16

              IF NOT HideValidationDialog AND GUIALLOWED THEN
                VerifyReceivedShippedItemLineDimChange(ReceivedShippedItemLineDimChangeConfirmed);

        #17..21
        */
    //end;


    //Unsupported feature: Code Modification on "SetShipToForSpecOrder(PROCEDURE 23)".

    //procedure SetShipToForSpecOrder();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Location.GET("Location Code") THEN BEGIN
          "Ship-to Code" := '';
          "Ship-to Name" := Location.Name;
          "Ship-to Name 2" := Location."Name 2";
          "Ship-to Address" := Location.Address;
          "Ship-to Address 2" := Location."Address 2";
          "Ship-to City" := Location.City;
          "Ship-to Post Code" := Location."Post Code";
          "Ship-to County" := Location.County;
          "Ship-to Country/Region Code" := Location."Country/Region Code";
          "Ship-to Contact" := Location.Contact;
          "Location Code" := Location.Code;
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
          "Location Code" := '';
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF Location.GET("Location Code") THEN BEGIN
          "Ship-to Code" := '';
          SetShipToAddress(
            Location.Name,Location."Name 2",Location.Address,Location."Address 2",
            Location.City,Location."Post Code",Location.County,Location."Country/Region Code");
        #11..15
          SetShipToAddress(
            CompanyInfo."Ship-to Name",CompanyInfo."Ship-to Name 2",CompanyInfo."Ship-to Address",CompanyInfo."Ship-to Address 2",
            CompanyInfo."Ship-to City",CompanyInfo."Ship-to Post Code",CompanyInfo."Ship-to County",
            CompanyInfo."Ship-to Country/Region Code");
        #24..26
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: SkipJobCurrFactorUpdate) (ParameterCollection) on "JobUpdatePurchLines(PROCEDURE 28)".


    //Unsupported feature: Property Insertion (Local) on "JobUpdatePurchLines(PROCEDURE 28)".



    //Unsupported feature: Code Modification on "JobUpdatePurchLines(PROCEDURE 28)".

    //procedure JobUpdatePurchLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH PurchLine DO BEGIN
          SETFILTER("Job No.",'<>%1','');
          SETFILTER("Job Task No.",'<>%1','');
          LOCKTABLE;
          IF FINDSET(TRUE,FALSE) THEN BEGIN
            SetPurchHeader(Rec);
            REPEAT
              JobSetCurrencyFactor;
              CreateTempJobJnlLine(FALSE);
              UpdatePricesFromJobJnlLine;
              MODIFY;
            UNTIL NEXT = 0;
          END;
        END
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
              IF NOT SkipJobCurrFactorUpdate THEN
                JobSetCurrencyFactor;
              CreateTempJobJnlLine(FALSE);
              UpdateJobPrices;
        #11..14
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: PrepaymentMgt) (VariableCollection) on "IsApprovedForPosting(PROCEDURE 50)".


    //Unsupported feature: Property Insertion (Local) on "IsApprovedForPosting(PROCEDURE 50)".



    //Unsupported feature: Code Modification on "IsApprovedForPosting(PROCEDURE 50)".

    //procedure IsApprovedForPosting();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesHeader.INIT;
        IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN BEGIN
          IF ApprovalMgt.TestPurchasePrepayment(Rec) THEN
            ERROR(STRSUBSTNO(Text053,"Document Type","No."));
          IF ApprovalMgt.TestPurchasePayment(Rec) THEN
            IF NOT CONFIRM(STRSUBSTNO(Text054,"Document Type","No."),TRUE) THEN
              EXIT(FALSE);
          EXIT(TRUE);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN BEGIN
          IF PrepaymentMgt.TestPurchasePrepayment(Rec) THEN
            ERROR(STRSUBSTNO(Text053,"Document Type","No."));
          IF PrepaymentMgt.TestPurchasePayment(Rec) THEN
        #6..9
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: PrepaymentMgt) (VariableCollection) on "IsApprovedForPostingBatch(PROCEDURE 51)".



    //Unsupported feature: Code Modification on "IsApprovedForPostingBatch(PROCEDURE 51)".

    //procedure IsApprovedForPostingBatch();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesHeader.INIT;
        IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN BEGIN
          IF ApprovalMgt.TestPurchasePrepayment(Rec) THEN
            EXIT(FALSE);
          IF ApprovalMgt.TestPurchasePayment(Rec) THEN
            EXIT(FALSE);
          EXIT(TRUE);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN BEGIN
          IF PrepaymentMgt.TestPurchasePrepayment(Rec) THEN
            EXIT(FALSE);
          IF PrepaymentMgt.TestPurchasePayment(Rec) THEN
        #6..8
        */
    //end;

    //Unsupported feature: Property Modification (Name) on "CheckDropShptAddressDetails(PROCEDURE 79)".



    //Unsupported feature: Code Modification on "CheckDropShptAddressDetails(PROCEDURE 79)".

    //procedure CheckDropShptAddressDetails();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        NameAddressDetails := DropShptNameAddressDetails;
        DropShptNameAddressDetails :=
          SalesHeader."Ship-to Name" + SalesHeader."Ship-to Name 2" +
          SalesHeader."Ship-to Address" + SalesHeader."Ship-to Address 2" +
          SalesHeader."Ship-to Post Code" + SalesHeader."Ship-to City" +
          SalesHeader."Ship-to Contact";
        IF NameAddressDetails = '' THEN
          NameAddressDetails := DropShptNameAddressDetails;
        EXIT(NameAddressDetails = DropShptNameAddressDetails);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SelectNoSeriesAllowed := TRUE;
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: TempPurchaseLine) (ParameterCollection) on "InsertTempPurchaseLineInBuffer(PROCEDURE 35)".


    //Unsupported feature: Parameter Insertion (Parameter: PurchaseLine) (ParameterCollection) on "InsertTempPurchaseLineInBuffer(PROCEDURE 35)".


    //Unsupported feature: Parameter Insertion (Parameter: AccountNo) (ParameterCollection) on "InsertTempPurchaseLineInBuffer(PROCEDURE 35)".


    //Unsupported feature: Parameter Insertion (Parameter: DefaultDimenstionsNotExist) (ParameterCollection) on "InsertTempPurchaseLineInBuffer(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Name) on "ZeroAmountInLines(PROCEDURE 35)".


    //Unsupported feature: Property Insertion (Local) on "ZeroAmountInLines(PROCEDURE 35)".



    //Unsupported feature: Code Modification on "ZeroAmountInLines(PROCEDURE 35)".

    //procedure ZeroAmountInLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PurchLine.SetPurchHeader(PurchHeader);
        PurchLine.SETRANGE("Document Type","Document Type");
        PurchLine.SETRANGE("Document No.","No.");
        PurchLine.SETFILTER(Type,'>0');
        PurchLine.SETFILTER(Quantity,'<>0');
        IF PurchLine.FINDSET(TRUE) THEN
          REPEAT
            PurchLine.Amount := 0;
            PurchLine."Amount Including VAT" := 0;
            PurchLine."VAT Base Amount" := 0;
            PurchLine.InitOutstandingAmount;
            PurchLine.MODIFY;
          UNTIL PurchLine.NEXT = 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TempPurchaseLine.INIT;
        TempPurchaseLine."Line No." := PurchaseLine."Line No.";
        TempPurchaseLine."No." := AccountNo;
        TempPurchaseLine."Job No." := PurchaseLine."Job No.";
        TempPurchaseLine."Responsibility Center" := PurchaseLine."Responsibility Center";
        TempPurchaseLine."Work Center No." := PurchaseLine."Work Center No.";
        TempPurchaseLine."Gen. Bus. Posting Group" := PurchaseLine."Gen. Bus. Posting Group";
        TempPurchaseLine."Gen. Prod. Posting Group" := PurchaseLine."Gen. Prod. Posting Group";
        TempPurchaseLine.MARK := DefaultDimenstionsNotExist;
        TempPurchaseLine.INSERT;
        */
    //end;

    local procedure InitInsert()
    var
        NoSeries: Record "308";
    begin
        IF "No." = '' THEN BEGIN
          TestNoSeries;
          NoSeries.GET(GetNoSeriesCode);
          IF (NOT NoSeries."Default Nos.") AND SelectNoSeriesAllowed AND NoSeriesMgt.IsSeriesSelected THEN
            NoSeriesMgt.SetSeries("No.")
          ELSE
            NoSeriesMgt.InitSeries(NoSeries.Code,xRec."No. Series","Posting Date","No.","No. Series");
        END;

        InitRecord;
    end;

    local procedure SkipInitialization(): Boolean
    begin
        IF "No." = '' THEN
          EXIT(FALSE);

        IF "Buy-from Vendor No." = '' THEN
          EXIT(FALSE);

        IF xRec."Document Type" <> "Document Type" THEN
          EXIT(FALSE);

        IF GETFILTER("Buy-from Vendor No.") <> '' THEN
          IF GETRANGEMIN("Buy-from Vendor No.") = GETRANGEMAX("Buy-from Vendor No.") THEN
            IF "Buy-from Vendor No." = GETRANGEMIN("Buy-from Vendor No.") THEN
              EXIT(FALSE);

        EXIT(TRUE);
    end;

    local procedure InitNoSeries()
    begin
        IF xRec."Receiving No." <> '' THEN BEGIN
          "Receiving No. Series" := xRec."Receiving No. Series";
          "Receiving No." := xRec."Receiving No.";
        END;
        IF xRec."Posting No." <> '' THEN BEGIN
          "Posting No. Series" := xRec."Posting No. Series";
          "Posting No." := xRec."Posting No.";
        END;
        IF xRec."Return Shipment No." <> '' THEN BEGIN
          "Return Shipment No. Series" := xRec."Return Shipment No. Series";
          "Return Shipment No." := xRec."Return Shipment No.";
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

    local procedure TransferSavedFields(var DestinationPurchaseLine: Record "39";var SourcePurchaseLine: Record "39")
    begin
        DestinationPurchaseLine.VALIDATE("Unit of Measure Code",SourcePurchaseLine."Unit of Measure Code");
        DestinationPurchaseLine.VALIDATE("Variant Code",SourcePurchaseLine."Variant Code");
        DestinationPurchaseLine."Prod. Order No." := SourcePurchaseLine."Prod. Order No.";
        IF DestinationPurchaseLine."Prod. Order No." <> '' THEN BEGIN
          DestinationPurchaseLine.Description := SourcePurchaseLine.Description;
          DestinationPurchaseLine.VALIDATE("VAT Prod. Posting Group",SourcePurchaseLine."VAT Prod. Posting Group");
          DestinationPurchaseLine.VALIDATE("Gen. Prod. Posting Group",SourcePurchaseLine."Gen. Prod. Posting Group");
          DestinationPurchaseLine.VALIDATE("Expected Receipt Date",SourcePurchaseLine."Expected Receipt Date");
          DestinationPurchaseLine.VALIDATE("Requested Receipt Date",SourcePurchaseLine."Requested Receipt Date");
          DestinationPurchaseLine.VALIDATE("Qty. per Unit of Measure",SourcePurchaseLine."Qty. per Unit of Measure");
        END;
        IF (SourcePurchaseLine."Job No." <> '') AND (SourcePurchaseLine."Job Task No." <> '') THEN BEGIN
          DestinationPurchaseLine.VALIDATE("Job No.",SourcePurchaseLine."Job No.");
          DestinationPurchaseLine.VALIDATE("Job Task No.",SourcePurchaseLine."Job Task No.");
          DestinationPurchaseLine."Job Line Type" := SourcePurchaseLine."Job Line Type";
        END;
        IF SourcePurchaseLine.Quantity <> 0 THEN
          DestinationPurchaseLine.VALIDATE(Quantity,SourcePurchaseLine.Quantity);
        IF ("Currency Code" = xRec."Currency Code") AND (PurchLine."Direct Unit Cost" = 0) THEN
          DestinationPurchaseLine.VALIDATE("Direct Unit Cost",SourcePurchaseLine."Direct Unit Cost");
        DestinationPurchaseLine."Routing No." := SourcePurchaseLine."Routing No.";
        DestinationPurchaseLine."Routing Reference No." := SourcePurchaseLine."Routing Reference No.";
        DestinationPurchaseLine."Operation No." := SourcePurchaseLine."Operation No.";
        DestinationPurchaseLine."Work Center No." := SourcePurchaseLine."Work Center No.";
        DestinationPurchaseLine."Prod. Order Line No." := SourcePurchaseLine."Prod. Order Line No.";
        DestinationPurchaseLine."Overhead Rate" := SourcePurchaseLine."Overhead Rate";
    end;

    local procedure TransferSavedFieldsDropShipment(var DestinationPurchaseLine: Record "39";var SourcePurchaseLine: Record "39")
    var
        SalesLine: Record "37";
        CopyDocMgt: Codeunit "6620";
    begin
        SalesLine.GET(SalesLine."Document Type"::Order,
          SourcePurchaseLine."Sales Order No.",
          SourcePurchaseLine."Sales Order Line No.");
        CopyDocMgt.TransfldsFromSalesToPurchLine(SalesLine,DestinationPurchaseLine);
        DestinationPurchaseLine."Drop Shipment" := SourcePurchaseLine."Drop Shipment";
        DestinationPurchaseLine."Purchasing Code" := SalesLine."Purchasing Code";
        DestinationPurchaseLine."Sales Order No." := SourcePurchaseLine."Sales Order No.";
        DestinationPurchaseLine."Sales Order Line No." := SourcePurchaseLine."Sales Order Line No.";
        EVALUATE(DestinationPurchaseLine."Inbound Whse. Handling Time",'<0D>');
        DestinationPurchaseLine.VALIDATE("Inbound Whse. Handling Time");
        SalesLine.VALIDATE("Unit Cost (LCY)",DestinationPurchaseLine."Unit Cost (LCY)");
        SalesLine."Purchase Order No." := DestinationPurchaseLine."Document No.";
        SalesLine."Purch. Order Line No." := DestinationPurchaseLine."Line No.";
        SalesLine.MODIFY;
    end;

    local procedure TransferSavedFieldsSpecialOrder(var DestinationPurchaseLine: Record "39";var SourcePurchaseLine: Record "39")
    var
        SalesLine: Record "37";
        CopyDocMgt: Codeunit "6620";
    begin
        SalesLine.GET(SalesLine."Document Type"::Order,
          SourcePurchaseLine."Special Order Sales No.",
          SourcePurchaseLine."Special Order Sales Line No.");
        CopyDocMgt.TransfldsFromSalesToPurchLine(SalesLine,DestinationPurchaseLine);
        DestinationPurchaseLine."Special Order" := SourcePurchaseLine."Special Order";
        DestinationPurchaseLine."Purchasing Code" := SalesLine."Purchasing Code";
        DestinationPurchaseLine."Special Order Sales No." := SourcePurchaseLine."Special Order Sales No.";
        DestinationPurchaseLine."Special Order Sales Line No." := SourcePurchaseLine."Special Order Sales Line No.";
        //>>MIGRATION NAV 2013
        //>>ACHATS BRRI 01.08.2006 COR001 [15] Correction perte du lien vers commande vente
        DestinationPurchaseLine."Special Order"  :=  SourcePurchaseLine."Special Order Sales Line No." <>0 ;
        //<<ACHATS BRRI 01.08.2006 COR001 [15] Correction perte du lien vers commande vente
        //<<MIGRATION NAV 2013


        DestinationPurchaseLine.VALIDATE("Unit of Measure Code",SourcePurchaseLine."Unit of Measure Code");
        IF SourcePurchaseLine.Quantity <> 0 THEN
          DestinationPurchaseLine.VALIDATE(Quantity,SourcePurchaseLine.Quantity);

        SalesLine.VALIDATE("Unit Cost (LCY)",DestinationPurchaseLine."Unit Cost (LCY)");
        SalesLine."Special Order Purchase No." := DestinationPurchaseLine."Document No.";
        SalesLine."Special Order Purch. Line No." := DestinationPurchaseLine."Line No.";
        SalesLine.MODIFY;
    end;

    local procedure CheckReceiptInfo(var PurchLine: Record "39";PayTo: Boolean)
    begin
        IF "Document Type" = "Document Type"::Order THEN
          PurchLine.SETFILTER("Quantity Received",'<>0')
        ELSE
          IF "Document Type" = "Document Type"::Invoice THEN BEGIN
            IF NOT PayTo THEN
              PurchLine.SETRANGE("Buy-from Vendor No.",xRec."Buy-from Vendor No.");
            PurchLine.SETFILTER("Receipt No.",'<>%1','');
          END;

        IF PurchLine.FINDFIRST THEN
          IF "Document Type" = "Document Type"::Order THEN
            PurchLine.TESTFIELD("Quantity Received",0)
          ELSE
            PurchLine.TESTFIELD("Receipt No.",'');
        PurchLine.SETRANGE("Receipt No.");
        PurchLine.SETRANGE("Quantity Received");
        IF NOT PayTo THEN
          PurchLine.SETRANGE("Buy-from Vendor No.");
    end;

    local procedure CheckPrepmtInfo(var PurchLine: Record "39")
    begin
        IF "Document Type" = "Document Type"::Order THEN BEGIN
          PurchLine.SETFILTER("Prepmt. Amt. Inv.",'<>0');
          IF PurchLine.FIND('-') THEN
            PurchLine.TESTFIELD("Prepmt. Amt. Inv.",0);
          PurchLine.SETRANGE("Prepmt. Amt. Inv.");
        END;
    end;

    local procedure CheckReturnInfo(var PurchLine: Record "39";PayTo: Boolean)
    begin
        IF "Document Type" = "Document Type"::"Return Order" THEN
          PurchLine.SETFILTER("Return Qty. Shipped",'<>0')
        ELSE
          IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
            IF NOT PayTo THEN
              PurchLine.SETRANGE("Buy-from Vendor No.",xRec."Buy-from Vendor No.");
            PurchLine.SETFILTER("Return Shipment No.",'<>%1','');
          END;

        IF PurchLine.FINDFIRST THEN
          IF "Document Type" = "Document Type"::"Return Order" THEN
            PurchLine.TESTFIELD("Return Qty. Shipped",0)
          ELSE
            PurchLine.TESTFIELD("Return Shipment No.",'');
    end;

    local procedure VerifyReceivedShippedItemLineDimChange(var ReceivedShippedItemLineDimChangeConfirmed: Boolean)
    begin
        IF PurchLine.IsReceivedShippedItemDimChanged THEN
          IF NOT ReceivedShippedItemLineDimChangeConfirmed THEN
            ReceivedShippedItemLineDimChangeConfirmed := PurchLine.ConfirmReceivedShippedItemDimChange;
    end;

    local procedure CheckDropShipmentLineExists()
    var
        SalesShipmentLine: Record "111";
    begin
        SalesShipmentLine.SETRANGE("Purchase Order No.","No.");
        SalesShipmentLine.SETRANGE("Drop Shipment",TRUE);
        IF NOT SalesShipmentLine.ISEMPTY THEN
          ERROR(YouCannotChangeFieldErr,FIELDCAPTION("Buy-from Vendor No."));
    end;

    procedure InvoicedLineExists(): Boolean
    var
        PurchLine: Record "39";
    begin
        PurchLine.SETRANGE("Document Type","Document Type");
        PurchLine.SETRANGE("Document No.","No.");
        PurchLine.SETFILTER(Type,'<>%1',PurchLine.Type::" ");
        PurchLine.SETFILTER("Quantity Invoiced",'<>%1',0);
        EXIT(NOT PurchLine.ISEMPTY);
    end;

    procedure CreateDimSetForPrepmtAccDefaultDim()
    var
        PurchaseLine: Record "39";
        TempPurchaseLine: Record "39" temporary;
    begin
        PurchaseLine.SETRANGE("Document Type","Document Type");
        PurchaseLine.SETRANGE("Document No.","No.");
        PurchaseLine.SETFILTER("Prepmt. Amt. Inv.",'<>%1',0);
        IF PurchaseLine.FINDSET THEN
          REPEAT
            CollectParamsInBufferForCreateDimSet(TempPurchaseLine,PurchaseLine);
          UNTIL PurchaseLine.NEXT = 0;
        TempPurchaseLine.RESET;
        TempPurchaseLine.MARKEDONLY(FALSE);
        IF TempPurchaseLine.FINDSET THEN
          REPEAT
            PurchaseLine.CreateDim(DATABASE::"G/L Account",TempPurchaseLine."No.",
              DATABASE::Job,TempPurchaseLine."Job No.",
              DATABASE::"Responsibility Center",TempPurchaseLine."Responsibility Center",
              DATABASE::"Work Center",TempPurchaseLine."Work Center No.");
          UNTIL TempPurchaseLine.NEXT = 0;
    end;

    local procedure CollectParamsInBufferForCreateDimSet(var TempPurchaseLine: Record "39" temporary;PurchaseLine: Record "39")
    var
        GenPostingSetup: Record "252";
        DefaultDimension: Record "352";
    begin
        TempPurchaseLine.SETRANGE("Gen. Bus. Posting Group",PurchaseLine."Gen. Bus. Posting Group");
        TempPurchaseLine.SETRANGE("Gen. Prod. Posting Group",PurchaseLine."Gen. Prod. Posting Group");
        IF NOT TempPurchaseLine.FINDFIRST THEN BEGIN
          GenPostingSetup.GET(PurchaseLine."Gen. Bus. Posting Group",PurchaseLine."Gen. Prod. Posting Group");
          GenPostingSetup.TESTFIELD("Purch. Prepayments Account");
          DefaultDimension.SETRANGE("Table ID",DATABASE::"G/L Account");
          DefaultDimension.SETRANGE("No.",GenPostingSetup."Purch. Prepayments Account");
          InsertTempPurchaseLineInBuffer(TempPurchaseLine,PurchaseLine,
            GenPostingSetup."Purch. Prepayments Account",DefaultDimension.ISEMPTY);
        END ELSE
          IF NOT TempPurchaseLine.MARK THEN BEGIN
            TempPurchaseLine.SETRANGE("Job No.",PurchaseLine."Job No.");
            TempPurchaseLine.SETRANGE("Responsibility Center",PurchaseLine."Responsibility Center");
            TempPurchaseLine.SETRANGE("Work Center No.",PurchaseLine."Work Center No.");
            IF TempPurchaseLine.ISEMPTY THEN
              InsertTempPurchaseLineInBuffer(TempPurchaseLine,PurchaseLine,TempPurchaseLine."No.",FALSE)
          END;
    end;

    procedure OpenPurchaseOrderStatistics()
    begin
        CalcInvDiscForHeader;
        CreateDimSetForPrepmtAccDefaultDim;
        COMMIT;
        PAGE.RUNMODAL(PAGE::"Purchase Order Statistics",Rec);
    end;

    procedure GetCardpageID(): Integer
    begin
        CASE "Document Type" OF
          "Document Type"::Quote:
            EXIT(PAGE::"Purchase Quote");
          "Document Type"::Order:
            EXIT(PAGE::"Purchase Order");
          "Document Type"::Invoice:
            EXIT(PAGE::"Purchase Invoice");
          "Document Type"::"Credit Memo":
            EXIT(PAGE::"Purchase Credit Memo");
          "Document Type"::"Blanket Order":
            EXIT(PAGE::"Blanket Purchase Order");
          "Document Type"::"Return Order":
            EXIT(PAGE::"Purchase Return Order");
        END;
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnCheckPurchasePostRestrictions()
    begin
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnCheckPurchaseReleaseRestrictions()
    begin
    end;

    procedure SetStatus(NewStatus: Option)
    begin
        Status := NewStatus;
        MODIFY;
    end;

    procedure TriggerOnAfterPostPurchaseDoc(var GenJnlPostLine: Codeunit "12";PurchRcpHdrNo: Code[20];RetShptHdrNo: Code[20];PurchInvHdrNo: Code[20];PurchCrMemoHdrNo: Code[20])
    var
        PurchPost: Codeunit "90";
    begin
        PurchPost.OnAfterPostPurchaseDoc(Rec,GenJnlPostLine,PurchRcpHdrNo,RetShptHdrNo,PurchInvHdrNo,PurchCrMemoHdrNo);
    end;

    procedure DeferralHeadersExist(): Boolean
    var
        DeferralHeader: Record "1701";
        DeferralUtilities: Codeunit "1720";
    begin
        DeferralHeader.SETRANGE("Deferral Doc. Type",DeferralUtilities.GetPurchDeferralDocType);
        DeferralHeader.SETRANGE("Gen. Jnl. Template Name",'');
        DeferralHeader.SETRANGE("Gen. Jnl. Batch Name",'');
        DeferralHeader.SETRANGE("Document Type","Document Type");
        DeferralHeader.SETRANGE("Document No.","No.");
        EXIT(NOT DeferralHeader.ISEMPTY);
    end;

    local procedure ConfirmUpdateDeferralDate()
    begin
        IF HideValidationDialog THEN
          Confirmed := TRUE
        ELSE
          Confirmed := CONFIRM(DeferralLineQst,FALSE,FIELDCAPTION("Posting Date"));
        IF Confirmed THEN
          UpdatePurchLines(PurchLine.FIELDCAPTION("Deferral Code"),FALSE);
    end;

    procedure IsCreditDocType(): Boolean
    begin
        EXIT("Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"]);
    end;

    procedure SetBuyFromVendorFromFilter()
    var
        BuyFromVendorNo: Code[20];
    begin
        BuyFromVendorNo := GetFilterVendNo;
        IF BuyFromVendorNo = '' THEN BEGIN
          FILTERGROUP(2);
          BuyFromVendorNo := GetFilterVendNo;
          FILTERGROUP(0);
        END;
        IF BuyFromVendorNo <> '' THEN
          VALIDATE("Buy-from Vendor No.",BuyFromVendorNo);
    end;

    procedure CopyBuyFromVendorFilter()
    var
        BuyFromVendorFilter: Text;
    begin
        BuyFromVendorFilter := GETFILTER("Buy-from Vendor No.");
        IF BuyFromVendorFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETFILTER("Buy-from Vendor No.",BuyFromVendorFilter);
          FILTERGROUP(0)
        END;
    end;

    local procedure GetFilterVendNo(): Code[20]
    begin
        IF GETFILTER("Buy-from Vendor No.") <> '' THEN
          IF GETRANGEMIN("Buy-from Vendor No.") = GETRANGEMAX("Buy-from Vendor No.") THEN
            EXIT(GETRANGEMAX("Buy-from Vendor No."));
    end;

    local procedure UpdateVendorAddress()
    var
        Vendor: Record "23";
    begin
        IF Vendor.GET("Buy-from Vendor No.") THEN
          IF NOT Vendor.HasAddress THEN
            CopyBuyFromVendorAddressFieldsFromPurchaseDocument(Vendor);

        IF "Pay-to Vendor No." <> "Buy-from Vendor No." THEN
          IF Vendor.GET("Pay-to Vendor No.") THEN
            IF NOT Vendor.HasAddress THEN
              CopyPayToVendorAddressFieldsFromPurchaseDocument(Vendor);
    end;

    local procedure CopyBuyFromVendorAddressFieldsFromPurchaseDocument(var Vendor: Record "23")
    begin
        Vendor.Address := "Buy-from Address";
        Vendor."Address 2" := "Buy-from Address 2";
        Vendor.City := "Buy-from City";
        Vendor.Contact := "Buy-from Contact";
        Vendor."Country/Region Code" := "Buy-from Country/Region Code";
        Vendor.County := "Buy-from County";
        Vendor."Post Code" := "Buy-from Post Code";
        Vendor.MODIFY(TRUE);
    end;

    local procedure CopyPayToVendorAddressFieldsFromPurchaseDocument(var Vendor: Record "23")
    begin
        Vendor.Address := "Pay-to Address";
        Vendor."Address 2" := "Pay-to Address 2";
        Vendor.City := "Pay-to City";
        Vendor.Contact := "Pay-to Contact";
        Vendor."Country/Region Code" := "Pay-to Country/Region Code";
        Vendor.County := "Pay-to County";
        Vendor."Post Code" := "Pay-to Post Code";
        Vendor.MODIFY(TRUE);
    end;

    procedure HasBuyFromAddress(): Boolean
    begin
        CASE TRUE OF
          "Buy-from Address" <> '':
            EXIT(TRUE);
          "Buy-from Address 2" <> '':
            EXIT(TRUE);
          "Buy-from City" <> '':
            EXIT(TRUE);
          "Buy-from Country/Region Code" <> '':
            EXIT(TRUE);
          "Buy-from County" <> '':
            EXIT(TRUE);
          "Buy-from Post Code" <> '':
            EXIT(TRUE);
          "Buy-from Contact" <> '':
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

    procedure HasPayToAddress(): Boolean
    begin
        CASE TRUE OF
          "Pay-to Address" <> '':
            EXIT(TRUE);
          "Pay-to Address 2" <> '':
            EXIT(TRUE);
          "Pay-to City" <> '':
            EXIT(TRUE);
          "Pay-to Country/Region Code" <> '':
            EXIT(TRUE);
          "Pay-to County" <> '':
            EXIT(TRUE);
          "Pay-to Post Code" <> '':
            EXIT(TRUE);
          "Pay-to Contact" <> '':
            EXIT(TRUE);
        END;

        EXIT(FALSE);
    end;

    local procedure CopyBuyFromVendorAddressFieldsFromVendor(var BuyFromVendor: Record "23")
    begin
        IF BuyFromVendorIsReplaced OR ShouldCopyAddressFromBuyFromVendor(BuyFromVendor) THEN BEGIN
          "Buy-from Address" := BuyFromVendor.Address;
          "Buy-from Address 2" := BuyFromVendor."Address 2";
          "Buy-from City" := BuyFromVendor.City;
          "Buy-from Post Code" := BuyFromVendor."Post Code";
          "Buy-from County" := BuyFromVendor.County;
          "Buy-from Country/Region Code" := BuyFromVendor."Country/Region Code";
        END;
    end;

    local procedure CopyShipToVendorAddressFieldsFromVendor(var BuyFromVendor: Record "23")
    begin
        IF BuyFromVendorIsReplaced OR ShouldCopyAddressFromBuyFromVendor(BuyFromVendor) THEN BEGIN
          "Ship-to Address" := BuyFromVendor.Address;
          "Ship-to Address 2" := BuyFromVendor."Address 2";
          "Ship-to City" := BuyFromVendor.City;
          "Ship-to Post Code" := BuyFromVendor."Post Code";
          "Ship-to County" := BuyFromVendor.County;
          VALIDATE("Ship-to Country/Region Code",BuyFromVendor."Country/Region Code");
        END;
    end;

    local procedure CopyPayToVendorAddressFieldsFromVendor(var PayToVendor: Record "23")
    begin
        IF PayToVendorIsReplaced OR ShouldCopyAddressFromPayToVendor(PayToVendor) THEN BEGIN
          "Pay-to Address" := PayToVendor.Address;
          "Pay-to Address 2" := PayToVendor."Address 2";
          "Pay-to City" := PayToVendor.City;
          "Pay-to Post Code" := PayToVendor."Post Code";
          "Pay-to County" := PayToVendor.County;
          "Pay-to Country/Region Code" := PayToVendor."Country/Region Code";
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

    local procedure ShouldCopyAddressFromBuyFromVendor(BuyFromVendor: Record "23"): Boolean
    begin
        EXIT((NOT HasBuyFromAddress) AND BuyFromVendor.HasAddress);
    end;

    local procedure ShouldCopyAddressFromPayToVendor(PayToVendor: Record "23"): Boolean
    begin
        EXIT((NOT HasPayToAddress) AND PayToVendor.HasAddress);
    end;

    local procedure BuyFromVendorIsReplaced(): Boolean
    begin
        EXIT((xRec."Buy-from Vendor No." <> '') AND (xRec."Buy-from Vendor No." <> "Buy-from Vendor No."));
    end;

    local procedure PayToVendorIsReplaced(): Boolean
    begin
        EXIT((xRec."Pay-to Vendor No." <> '') AND (xRec."Pay-to Vendor No." <> "Pay-to Vendor No."));
    end;

    local procedure UpdatePayToAddressFromBuyFromAddress(FieldNumber: Integer)
    begin
        IF ("Order Address Code" = '') AND PayToAddressEqualsOldBuyFromAddress THEN
          CASE FieldNumber OF
            FIELDNO("Pay-to Address"):
              IF xRec."Buy-from Address" = "Pay-to Address" THEN
                "Pay-to Address" := "Buy-from Address";
            FIELDNO("Pay-to Address 2"):
              IF xRec."Buy-from Address 2" = "Pay-to Address 2" THEN
                "Pay-to Address 2" := "Buy-from Address 2";
            FIELDNO("Pay-to City"), FIELDNO("Pay-to Post Code"):
              BEGIN
                IF xRec."Buy-from City" = "Pay-to City" THEN
                  "Pay-to City" := "Buy-from City";
                IF xRec."Buy-from Post Code" = "Pay-to Post Code" THEN
                  "Pay-to Post Code" := "Buy-from Post Code";
                IF xRec."Buy-from County" = "Pay-to County" THEN
                  "Pay-to County" := "Buy-from County";
                IF xRec."Buy-from Country/Region Code" = "Pay-to Country/Region Code" THEN
                  "Pay-to Country/Region Code" := "Buy-from Country/Region Code";
              END;
            FIELDNO("Pay-to County"):
              IF xRec."Buy-from County" = "Pay-to County" THEN
                "Pay-to County" := "Buy-from County";
            FIELDNO("Pay-to Country/Region Code"):
              IF  xRec."Buy-from Country/Region Code" = "Pay-to Country/Region Code" THEN
                "Pay-to Country/Region Code" := "Buy-from Country/Region Code";
          END;
    end;

    local procedure PayToAddressEqualsOldBuyFromAddress(): Boolean
    begin
        IF (xRec."Buy-from Address" = "Pay-to Address") AND
           (xRec."Buy-from Address 2" = "Pay-to Address 2") AND
           (xRec."Buy-from City" = "Pay-to City") AND
           (xRec."Buy-from County" = "Pay-to County") AND
           (xRec."Buy-from Post Code" = "Pay-to Post Code") AND
           (xRec."Buy-from Country/Region Code" = "Pay-to Country/Region Code")
        THEN
          EXIT(TRUE);
    end;

    procedure ConfirmCloseUnposted(): Boolean
    var
        InstructionMgt: Codeunit "1330";
    begin
        //BC6>>
        EXIT(TRUE);
        //BC6<<
        IF PurchLinesExist THEN
          EXIT(InstructionMgt.ShowConfirm(DocumentNotPostedClosePageQst,InstructionMgt.QueryPostOnCloseCode));
        EXIT(TRUE)
    end;

    procedure InitFromPurchHeader(SourcePurchHeader: Record "38")
    begin
        "Document Date" := SourcePurchHeader."Document Date";
        "Expected Receipt Date" := SourcePurchHeader."Expected Receipt Date";
        "Shortcut Dimension 1 Code" := SourcePurchHeader."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := SourcePurchHeader."Shortcut Dimension 2 Code";
        "Dimension Set ID" := SourcePurchHeader."Dimension Set ID";
        "Location Code" := SourcePurchHeader."Location Code";
        SetShipToAddress(
          SourcePurchHeader."Ship-to Name",SourcePurchHeader."Ship-to Name 2",SourcePurchHeader."Ship-to Address",
          SourcePurchHeader."Ship-to Address 2",SourcePurchHeader."Ship-to City",SourcePurchHeader."Ship-to Post Code",
          SourcePurchHeader."Ship-to County",SourcePurchHeader."Ship-to Country/Region Code");
        "Ship-to Contact" := SourcePurchHeader."Ship-to Contact";
    end;

    local procedure InitFromVendor(VendorNo: Code[20];VendorCaption: Text): Boolean
    begin
        PurchLine.SETRANGE("Document Type","Document Type");
        PurchLine.SETRANGE("Document No.","No.");
        IF VendorNo = '' THEN BEGIN
          IF NOT PurchLine.ISEMPTY THEN
            ERROR(Text005,VendorCaption);
          INIT;
          PurchSetup.GET;
          "No. Series" := xRec."No. Series";
          InitRecord;
          InitNoSeries;
          EXIT(TRUE);
        END;
    end;

    local procedure InitFromContact(ContactNo: Code[20];VendorNo: Code[20];ContactCaption: Text): Boolean
    begin
        PurchLine.SETRANGE("Document Type","Document Type");
        PurchLine.SETRANGE("Document No.","No.");
        IF (ContactNo = '') AND (VendorNo = '') THEN BEGIN
          IF NOT PurchLine.ISEMPTY THEN
            ERROR(Text005,ContactCaption);
          INIT;
          PurchSetup.GET;
          "No. Series" := xRec."No. Series";
          InitRecord;
          InitNoSeries;
          EXIT(TRUE);
        END;
    end;

    local procedure LookupContact(VendorNo: Code[20];ContactNo: Code[20];var Contact: Record "5050")
    var
        ContactBusinessRelation: Record "5054";
    begin
        ContactBusinessRelation.SETCURRENTKEY("Link to Table","No.");
        ContactBusinessRelation.SETRANGE("Link to Table",ContactBusinessRelation."Link to Table"::Vendor);
        ContactBusinessRelation.SETRANGE("No.",VendorNo);
        IF ContactBusinessRelation.FINDFIRST THEN
          Contact.SETRANGE("Company No.",ContactBusinessRelation."Contact No.")
        ELSE
          Contact.SETRANGE("Company No.",'');
        IF ContactNo <> '' THEN
          IF Contact.GET(ContactNo) THEN ;
    end;

    procedure SendRecords()
    var
        DocumentSendingProfile: Record "60";
        DummyReportSelections: Record "77";
    begin
        DocumentSendingProfile.SendVendorRecords(
          DummyReportSelections.Usage::"P.Order",Rec,DocTxt,"Buy-from Vendor No.","No.",
          FIELDNO("Buy-from Vendor No."),FIELDNO("No."));
    end;

    procedure PrintRecords(ShowRequestForm: Boolean)
    var
        DocumentSendingProfile: Record "60";
        DummyReportSelections: Record "77";
    begin
        DocumentSendingProfile.TrySendToPrinterVendor(
          DummyReportSelections.Usage::"P.Order",Rec,"Buy-from Vendor No.",ShowRequestForm);
    end;

    procedure SendProfile(var DocumentSendingProfile: Record "60")
    var
        DummyReportSelections: Record "77";
    begin
        DocumentSendingProfile.SendVendor(
          DummyReportSelections.Usage::"P.Order",Rec,"No.","Buy-from Vendor No.",
          DocTxt,FIELDNO("Buy-from Vendor No."),FIELDNO("No."));
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
            UpdatePurchLines(PurchLine.FIELDCAPTION("Deferral Code"),FALSE);
        END;
        COMMIT;
    end;

    procedure "---NSC1.00---"()
    begin
    end;

    procedure UpdateIncoterm()
    begin
        IF RecGVendor.GET("Buy-from Vendor No.")THEN BEGIN
           "Transaction Type" := RecGVendor."Transaction Type";
           "Transaction Specification" := RecGVendor."Transaction Specification";
           "Transport Method" := RecGVendor."Transport Method";
           "Entry Point" := RecGVendor."Entry Point";
           Area := RecGVendor.Area;
        END;
    end;

    procedure "**NSC1.01**"()
    begin
    end;

    procedure ControleMinimMNTandQTE(): Boolean
    var
        MntTot: Decimal;
        QteTot: Decimal;
        Frs: Record "23";
        Msg: Text[150];
        TextControleMinima01: Label 'Total Purchase Amount %1, lower than minimum Purchase Amount %2. Do You want add freight charge?';
        RecLPurchaseLine: Record "39";
        NumLigne: Integer;
        TxtL001: ;
    begin
        //CONTROLEMINIMA SM 11/10/06 NCS1.01 [FE02] Contrôle Minima MNT et QTE
        PurchSetup.GET;
        IF NOT PurchSetup."Minima de cde" THEN
          EXIT(FALSE)
        ELSE BEGIN
          PurchSetup.TESTFIELD(PurchSetup.Type) ;
          PurchSetup.TESTFIELD(PurchSetup."No.") ;
        END ;

        Frs.RESET;
        Frs.GET("Buy-from Vendor No.");

        CalcMntHTandMntTTCandQTE(MntTot,QteTot);

        Msg :='\';

        IF MntTot < Frs."Mini Amount" THEN BEGIN
          IF NOT Existfreightcharge THEN BEGIN
          //>>FE002.2 CASC
            IF NOT ExistFreightChargeSSAmount THEN
            BEGIN
          //<<FE002.2 CASC
              Msg :=Msg + TextControleMinima01;
              //IF NOT CONFIRM(Msg,TRUE,MntTot,Frs."Mini Amount",QteTot) THEN
                //EXIT(TRUE)
              //ELSE BEGIN
              //>> PROD 26.05.2011
              IF HideValidationDialog THEN
                Confirmed := TRUE
              ELSE
                Confirmed := CONFIRM(Msg,TRUE,MntTot,Frs."Mini Amount",QteTot);
              IF Confirmed  THEN
              BEGIN
                RecLPurchaseLine.RESET ;
                RecLPurchaseLine.SETRANGE(RecLPurchaseLine."Document Type","Document Type") ;
                RecLPurchaseLine.SETRANGE(RecLPurchaseLine."Document No.","No.") ;
                IF RecLPurchaseLine.FIND('+') THEN
                  NumLigne := RecLPurchaseLine."Line No." + 10000
                ELSE
                  NumLigne := 10000 ;

                RecLPurchaseLine.INIT ;
                RecLPurchaseLine.VALIDATE("Document Type","Document Type") ;
                RecLPurchaseLine.VALIDATE("Document No.","No.") ;
                RecLPurchaseLine.VALIDATE("Line No.",NumLigne) ;
                RecLPurchaseLine.INSERT(TRUE) ;

                RecLPurchaseLine.VALIDATE(Type,PurchSetup.Type) ;
                RecLPurchaseLine.VALIDATE("No.",PurchSetup."No.") ;
                RecLPurchaseLine.VALIDATE(Quantity,1) ;
                //>>FE002.3
                RecLPurchaseLine.VALIDATE("Location Code", "Location Code");
                RecLPurchaseLine.VALIDATE("Direct Unit Cost", Frs."Freight Amount");
                //<<FE002.3
                RecLPurchaseLine.MODIFY(TRUE) ;
                //>>FE002.3

                IF RecLPurchaseLine."Direct Unit Cost" = 0 THEN
                //<<FE002.3
                //>> PROD 26.05.2011
                IF NOT HideValidationDialog THEN
                  MESSAGE('Merci d''indiquer un coût unitaire direct pour la ligne %1, N° %2.',PurchSetup.Type,PurchSetup."No.") ;
                //EXIT(TRUE) ;
              END;

            END
            //>>FE002.2 CASC
            ELSE
            BEGIN
              //>> PROD 26.05.2011
              IF NOT HideValidationDialog THEN
                MESSAGE(TextG002,PurchSetup.Type,PurchSetup."No.");
              EXIT(TRUE);
            END;
            //<<FE002.2 CASC
          END;
        END;

        EXIT(FALSE);
        //CONTROLEMINIMA SM 11/10/06 NCS1.01 [FE02] Contrôle Minima MNT et QTE
    end;

    procedure CalcMntHTandMntTTCandQTE(var MntTot: Decimal;var QteTot: Decimal)
    var
        PurchLine: Record "39";
        TempPurchLine: Record "39" temporary;
        TotalPurchLine: Record "39";
        TotalPurchLineLCY: Record "39";
        Vend: Record "23";
        TempVATAmountLine: Record "290" temporary;
        PurchSetup: Record "312";
        PurchPost: Codeunit "90";
        TotalAmount1: Decimal;
        TotalAmount2: Decimal;
        VATAmount: Decimal;
        VATAmountText: Text[30];
        PrevNo: Code[20];
        AllowInvDisc: Boolean;
        AllowVATDifference: Boolean;
    begin
        //CALCMNTTOTAL SM 11/07/06 NCS1.01 [COMPLEMENT_ACHAT0206]  MAJ Montant Total HT Et Montant Total TTC de l'entête achat
        CLEAR(PurchLine);
        CLEAR(TotalPurchLine);
        CLEAR(TotalPurchLineLCY);
        CLEAR(PurchPost);

        PurchPost.GetPurchLines(Rec,TempPurchLine,0);
        CLEAR(PurchPost);

        //>>DEEE1.00
        //PurchPost.SumPurchLinesTemp(
        //  Rec,TempPurchLine,0,TotalPurchLine,TotalPurchLineLCY,VATAmount,VATAmountText);
        PurchPost.SumPurchLinesTemp(
          Rec,TempPurchLine,0,TotalPurchLine,TotalPurchLineLCY,VATAmount,VATAmountText,
          TotalPurchLine."DEEE HT Amount",TotalPurchLine."DEEE VAT Amount",TotalPurchLine."DEEE TTC Amount",
          TotalPurchLine."DEEE HT Amount (LCY)");
        //>>FIN DEEE1.00


        IF "Prices Including VAT" THEN BEGIN
          TotalAmount2 := TotalPurchLine.Amount;
          TotalAmount1 := TotalAmount2 + VATAmount;
          TotalPurchLine."Line Amount" := TotalAmount1 + TotalPurchLine."Inv. Discount Amount";
        END ELSE BEGIN
          TotalAmount1 := TotalPurchLine.Amount;
          TotalAmount2 := TotalPurchLine."Amount Including VAT";
        END;

        MntTot := TotalAmount1 ;
        QteTot := TotalPurchLine.Quantity;
        //FIN CALCMNTTOTAL SM 11/07/06 NCS1.01 [COMPLEMENT_ACHAT0206]  MAJ Montant Total HT Et Montant Total TTC de l'entête achat
    end;

    procedure Existfreightcharge(): Boolean
    var
        RecLSalesLine: Record "39";
    begin
        IF PurchLinesExist THEN BEGIN
          REPEAT
            IF (PurchLine.Type = PurchSetup.Type)
              AND (PurchLine."No." = PurchSetup."No." )
              AND (PurchLine."Line Amount" <> 0) THEN
                EXIT(TRUE);
          UNTIL PurchLine.NEXT = 0;
        END ELSE
          EXIT(FALSE);
    end;

    procedure UpdateBuyFromFax(CodContactNo: Code[20])
    var
        RecLContact: Record "5050";
    begin
        //>>FE005
        IF RecLContact.GET(CodContactNo) THEN
          "Buy-from Fax No." := RecLContact."Fax No."
        ELSE
          "Buy-from Fax No." := '';
        //<<FE005
    end;

    procedure UpdateBuyFromMail(CodContactNo: Code[20])
    var
        RecLContact: Record "5050";
    begin
        //>>FE005
        IF RecLContact.GET(CodContactNo) THEN
          "Buy-from E-Mail Address" := RecLContact."E-Mail"
        ELSE
          "Buy-from E-Mail Address" := '';
        //<<FE005
    end;

    procedure ExistFreightChargeSSAmount(): Boolean
    begin
        //>>FE002.2 CASC
        IF PurchLinesExist THEN BEGIN
          REPEAT
            IF (PurchLine.Type = PurchSetup.Type) AND (PurchLine."No." = PurchSetup."No." ) THEN
              //AND (PurchLine."Line Amount" <> 0)
                EXIT(TRUE);
          UNTIL PurchLine.NEXT = 0;
        END ELSE
          EXIT(FALSE);
        //<<FE002.2 CASC
    end;

    procedure AddLogComment(_Qty: Decimal;_ReceiptType: Option Colis,Palette)
    var
        L_PurchCommentLine: Record "43";
        L_PurchCommentLine2: Record "43";
    begin
        IF _Qty = 0 THEN
          ERROR(Text50000);
        L_PurchCommentLine.INIT;
        L_PurchCommentLine."Document Type" := "Document Type";
        L_PurchCommentLine."No." := "No.";
        L_PurchCommentLine.Comment := FORMAT(_Qty) + ' ' + FORMAT(_ReceiptType);
        L_PurchCommentLine."Is Log" := TRUE;

        L_PurchCommentLine2.SETRANGE("Document Type",L_PurchCommentLine."Document Type");
        L_PurchCommentLine2.SETRANGE("No.",L_PurchCommentLine."No.");
        IF L_PurchCommentLine2.FINDLAST THEN
          L_PurchCommentLine."Line No." := L_PurchCommentLine2."Line No." + 10000
        ELSE
          L_PurchCommentLine."Line No." := 10000;

        L_PurchCommentLine.INSERT(TRUE);
    end;

    local procedure "---BCSYS---"()
    begin
    end;

    local procedure UpdateSalesLineReturnType()
    var
        L_PurchaseLine: Record "39";
    begin
        IF "Document Type" <> "Document Type"::"Return Order" THEN
          EXIT;

        IF xRec."Return Order Type" <> Rec."Return Order Type" THEN
          L_PurchaseLine.RESET;
          L_PurchaseLine.SETRANGE("Document Type","Document Type");
          L_PurchaseLine.SETRANGE("Document No.","No.");
          IF L_PurchaseLine.FINDFIRST THEN
              L_PurchaseLine.MODIFYALL("Return Order Type","Return Order Type");
    end;

    //Unsupported feature: Deletion (VariableCollection) on "RecreatePurchLines(PROCEDURE 4).PurchLineTmp(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "RecreatePurchLines(PROCEDURE 4).SalesLine(Variable 1007)".


    //Unsupported feature: Deletion (VariableCollection) on "RecreatePurchLines(PROCEDURE 4).CopyDocMgt(Variable 1008)".


    //Unsupported feature: Deletion (VariableCollection) on "UpdatePurchLines(PROCEDURE 15).UpdateConfirmed(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "HandleItemTrackingDeletion(PROCEDURE 36).ReservEntry(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "HandleItemTrackingDeletion(PROCEDURE 36).ReservEntry2(Variable 1001)".


    //Unsupported feature: Property Insertion (Temporary) on "ClearItemAssgntPurchFilter(PROCEDURE 22).TempItemChargeAssgntPurch(Parameter 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "IsApprovedForPosting(PROCEDURE 50).SalesHeader(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "IsApprovedForPostingBatch(PROCEDURE 51).SalesHeader(Variable 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "CheckDropShptAddressDetails(PROCEDURE 79).SalesHeader(Parameter 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "ZeroAmountInLines(PROCEDURE 35).PurchLine(Variable 1001)".


    var
        ShipToAddr: Record "222";

    var
        SkipJobCurrFactorUpdate: Boolean;

    var
        GenJnlLine: Record "81";
        GenJnlApply: Codeunit "225";
        ApplyVendEntries: Page "233";

    var
        VendEntrySetApplID: Codeunit "111";

    var
        PostPurchDelete: Codeunit "364";
        ArchiveManagement: Codeunit "5063";


        //Unsupported feature: Property Modification (TextConstString) on "Text009(Variable 1009)".

        //var
        //>>>> ORIGINAL VALUE:
        //Text009 : ENU="Deleting this document will cause a gap in the number series for receipts. ";FRA="La suppression de ce document va provoquer une discontinuité dans la souche réception. ";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text009 : @@@="%1 = Document No.";ENU=Deleting this document will cause a gap in the number series for receipts. An empty receipt %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche des réceptions. Une réception vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
        //Variable type has not been exported.


        //Unsupported feature: Property Modification (TextConstString) on "Text012(Variable 1012)".

        //var
        //>>>> ORIGINAL VALUE:
        //Text012 : ENU="Deleting this document will cause a gap in the number series for posted invoices. ";FRA="La suppression de ce document va provoquer une discontinuité dans la souche fact. enregistrées. ";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text012 : @@@="%1 = Document No.";ENU=Deleting this document will cause a gap in the number series for posted invoices. An empty posted invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche des factures enregistrées. Une facture enregistrée vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
        //Variable type has not been exported.


        //Unsupported feature: Property Modification (TextConstString) on "Text014(Variable 1014)".

        //var
        //>>>> ORIGINAL VALUE:
        //Text014 : ENU="Deleting this document will cause a gap in the number series for posted credit memos. ";FRA="La suppression de ce document va provoquer une discontinuité dans la souche avoirs enregistrés. ";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text014 : @@@="%1 = Document No.";ENU=Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche d'avoirs enregistrés. Un avoir enregistré vide %1 va être créé pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
        //Variable type has not been exported.


        //Unsupported feature: Property Modification (TextConstString) on "Text029(Variable 1028)".

        //var
        //>>>> ORIGINAL VALUE:
        //Text029 : ENU="Deleting this document will cause a gap in the number series for return shipments. ";FRA="La suppression de ce document va provoquer une discontinuité dans la souche expédition retour. ";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text029 : @@@="%1 = Document No.";ENU=Deleting this document will cause a gap in the number series for return shipments. An empty return shipment %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche des expéditions retour. Une expédition retour vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
        //Variable type has not been exported.


        //Unsupported feature: Property Modification (TextConstString) on "Text045(Variable 1086)".

        //var
        //>>>> ORIGINAL VALUE:
        //Text045 : ENU="Deleting this document will cause a gap in the number series for prepayment invoices. ";FRA="La suppression de ce document va provoquer une discontinuité dans la souche factures acompte. ";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text045 : ENU=Deleting this document will cause a gap in the number series for prepayment invoices. An empty prepayment invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche des factures d'acompte. Une facture d'acompte vide %1 va être créée pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
        //Variable type has not been exported.


        //Unsupported feature: Property Modification (TextConstString) on "Text046(Variable 1087)".

        //var
        //>>>> ORIGINAL VALUE:
        //Text046 : ENU=An empty prepayment invoice %1 will be created to fill this gap in the number series.\\;FRA=Une facture acompte vide %1 va être créée pour éviter cette discontinuité dans les numéros.\\;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text046 : ENU=Deleting this document will cause a gap in the number series for prepayment credit memos. An empty prepayment credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?;FRA=La suppression de ce document va engendrer une discontinuité dans la souche des avoirs acompte. Un avoir acompte vide %1 va être créé pour éviter une discontinuité dans la souche de numéros.\\Voulez-vous continuer ?;
        //Variable type has not been exported.


        //Unsupported feature: Property Modification (TextConstString) on "Text050(Variable 1067)".

        //var
        //>>>> ORIGINAL VALUE:
        //Text050 : ENU=Reservations exist for this order. These reservations will be canceled if a date conflict is caused by this change.\\;FRA=Il existe des réservations pour cette commande. Ces réservations seront annulées si cette modification entraîne un conflit de dates.\\;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text050 : ENU=Reservations exist for this order. These reservations will be canceled if a date conflict is caused by this change.\\Do you want to continue?;FRA=Il existe des réservations pour cette commande. Ces réservations seront annulées si cette modification entraîne un conflit de dates.\\Voulez-vous continuer ?;
        //Variable type has not been exported.

    var
        ConfirmChangeQst: Label 'Do you want to change %1?', Comment = '%1 = a Field Caption like Currency Code';

    var
        YouCannotChangeFieldErr: Label 'You cannot change %1 because the order is associated with one or more sales orders.', Comment = '%1 - fieldcaption';

    var
        ApprovalsMgmt: Codeunit "1535";

    var
        LeadTimeMgt: Codeunit "5404";

    var
        DeferralLineQst: Label 'You have changed the %1 on the purchase header, do you want to update the deferral schedules for the lines with this date?', Comment = '%1=The posting date on the document.';

    var
        PostedDocsToPrintCreatedMsg: Label 'One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.';
        BuyFromVendorTxt: Label 'Buy-from Vendor';
        PayToVendorTxt: Label 'Pay-to Vendor';
        DocumentNotPostedClosePageQst: Label 'The document has not been posted.\Are you sure you want to exit?';
        DocTxt: Label 'Purchase Order';
        SelectNoSeriesAllowed: Boolean;
        "-NSC1.00-": Integer;
        RecGVendor: Record "23";
        RecGParamNavi: Record "50004";
        RecGCommentLine: Record "97";
        FrmGLignesCommentaires: Page "124";
        "---NSC1.01": ;
        TextG001: Label 'Warning, using foreign currency will generate wrong profit calculation.';
        TextG002: Label 'Thank to inform freight charge amount for line %1, No. %2';
        TextG003: Label 'Warning:This purchase order is linked to a sales order.';
        Text50000: Label 'Quantity cannot be 0.';
        "-BCSYS-": Integer;
        G_ReturnOrderMgt: Codeunit "50052";
}

