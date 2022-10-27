tableextension 50020 tableextension50020 extends Customer
{
    // <changelog>
    //   <add id="FR0002" dev="KCOOLS" date="2005-11-18" area="PAYMNG"  request="FR-START-40B"
    //     releaseversion="FR4.00.02">Payment management system</add>
    // </changelog>
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Champs_Suppl]         Ajout des champs 50000, 50001
    //                                                              Ajout de code dans le trigger OnInsert() pour alimenter ces champs
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm]             Ajout des champs 50002..50006
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [SFAC]                 Ajout des champs 50007, 50008
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ 50009
    //                                                              Ajout de code pour mise à jour du champ "Pay-to Customer No."
    //                                                              sur trigger "OnInsert()"
    //                                                              Mise à jour des Ecritures clients suite à la modification
    //                                                              du Client Payeur
    //                                                              Ajout de code sur le trigger "Pay-to Customer No. - OnValidate()"
    //                                                              Ajout de la fonction updateLedgerEntries()
    //                                                              Ajout de la clé: Pay-to Customer No.
    // //GRPMARGECLT SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ  50020
    // 
    // //ImportFichiersBase RD 15/11/06 NCS1.01 [FE021] Ajout du champ "Code SIREN"
    // //Regroupement BL par commande FLGR 08/12/06 Fe018 ajout champ 50025 Combine Shipments by order
    // //CASC 12/01/2007 NSC1.01 : Add Default Field On insert : 'Location Code'
    // 
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    //           - Add fields 80800
    //           - Gen. Bus. Posting Group - OnValidate()
    // ------------------------------------------------------------------------
    // 
    // //todolist point 60 FLGR 21/02/2007 Add Default Field On insert : "Submitted to DEEE"
    // //VERSIONNING FG 28/02/07 suite au Merge
    // 
    // //TDL.EC04  CNE6.01 Shipment Printed All Order Line
    //                     Add Field : Shipt Print All Order Line
    // 
    // //TDL.EC05  CNE6.01 Copy Sell-to Address in Invoice-to/Ship-to Address
    //                     Add Field : Copy Sell-to Address
    // 
    // //>>CNE7.01
    // //>>P24233_001 SOBI APA 02/02/17
    //                     Add Field 50010
    //                     Modify Salesperson Code - OnValidate

    //Unsupported feature: Property Modification (Permissions) on "Customer(Table 18)".

    LookupPageID = 22;
    DrillDownPageID = 22;
    fields
    {
        modify(City)
        {
            TableRelation = IF (Country/Region Code=CONST()) "Post Code".City
                            ELSE IF (Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Country/Region Code));
        }
        modify("Territory Code")
        {
            Caption = 'Territory Code';
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipping Agent Code"(Field 31)".


        //Unsupported feature: Property Modification (CalcFormula) on "Comment(Field 38)".


        //Unsupported feature: Property Modification (CalcFormula) on "Balance(Field 58)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Balance (LCY)"(Field 59)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Net Change"(Field 60)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Net Change (LCY)"(Field 61)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Sales (LCY)"(Field 62)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Profit (LCY)"(Field 63)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Inv. Discounts (LCY)"(Field 64)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Pmt. Discounts (LCY)"(Field 65)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Balance Due"(Field 66)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Balance Due (LCY)"(Field 67)".


        //Unsupported feature: Property Modification (CalcFormula) on "Payments(Field 69)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Invoice Amounts"(Field 70)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Cr. Memo Amounts"(Field 71)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Finance Charge Memo Amounts"(Field 72)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Payments (LCY)"(Field 74)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Inv. Amounts (LCY)"(Field 75)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Cr. Memo Amounts (LCY)"(Field 76)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Fin. Charge Memo Amounts (LCY)"(Field 77)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Outstanding Orders"(Field 78)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Outstanding Orders"(Field 78)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Shipped Not Invoiced"(Field 79)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipped Not Invoiced"(Field 79)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Combine Shipments"(Field 87)".

        modify(Picture)
        {
            Caption = 'Picture';
        }
        modify("Post Code")
        {
            TableRelation = IF (Country/Region Code=CONST()) "Post Code"
                            ELSE IF (Country/Region Code=FILTER(<>'')) "Post Code" WHERE (Country/Region Code=FIELD(Country/Region Code));
        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Debit Amount"(Field 97)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Credit Amount"(Field 98)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Debit Amount (LCY)"(Field 99)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Credit Amount (LCY)"(Field 100)".

        modify("E-Mail")
        {
            Caption = 'Email';
        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Reminder Amounts"(Field 105)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Reminder Amounts (LCY)"(Field 106)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Outstanding Orders (LCY)"(Field 113)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Outstanding Orders (LCY)"(Field 113)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Shipped Not Invoiced (LCY)"(Field 114)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipped Not Invoiced (LCY)"(Field 114)".


        //Unsupported feature: Property Insertion (AccessByPermission) on "Reserve(Field 115)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Pmt. Disc. Tolerance (LCY)"(Field 117)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Pmt. Tolerance (LCY)"(Field 118)".


        //Unsupported feature: Property Modification (CalcFormula) on "Refunds(Field 120)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Refunds (LCY)"(Field 121)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Other Amounts"(Field 122)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Other Amounts (LCY)"(Field 123)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Outstanding Invoices (LCY)"(Field 125)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Outstanding Invoices (LCY)"(Field 125)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Outstanding Invoices"(Field 126)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Outstanding Invoices"(Field 126)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Bill-to No. Of Archived Doc."(Field 130)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Sell-to No. Of Archived Doc."(Field 131)".

        modify("Preferred Bank Account")
        {

            //Unsupported feature: Property Modification (Name) on ""Preferred Bank Account"(Field 288)".

            Caption = 'Preferred Bank Account Code';
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipping Advice"(Field 5750)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipping Time"(Field 5790)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Contract Gain/Loss Amount"(Field 5902)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Outstanding Serv. Orders (LCY)"(Field 5910)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Serv Shipped Not Invoiced(LCY)"(Field 5911)".

        modify("Outstanding Serv.Invoices(LCY)")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Outstanding Serv.Invoices(LCY)"(Field 5912)".

            Caption = 'Outstanding Serv.Invoices(LCY)';
        }

        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Quotes"(Field 7171)".


        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Blanket Orders"(Field 7172)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""No. of Blanket Orders"(Field 7172)".


        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Orders"(Field 7173)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""No. of Orders"(Field 7173)".


        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Invoices"(Field 7174)".


        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Return Orders"(Field 7175)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""No. of Return Orders"(Field 7175)".


        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Credit Memos"(Field 7176)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Bill-To No. of Quotes"(Field 7182)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Bill-To No. of Blanket Orders"(Field 7183)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Bill-To No. of Blanket Orders"(Field 7183)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Bill-To No. of Orders"(Field 7184)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Bill-To No. of Orders"(Field 7184)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Bill-To No. of Invoices"(Field 7185)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Bill-To No. of Return Orders"(Field 7186)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Bill-To No. of Return Orders"(Field 7186)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Bill-To No. of Credit Memos"(Field 7187)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Copy Sell-to Addr. to Qte From"(Field 7601)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Payment in progress (LCY)"(Field 10860)".



        //Unsupported feature: Code Insertion on "Contact(Field 8)".

        //trigger OnLookup(var Text: Text): Boolean
        //var
            //ContactBusinessRelation: Record "5054";
            //Cont: Record "5050";
        //begin
            /*
            ContactBusinessRelation.SETCURRENTKEY("Link to Table","No.");
            ContactBusinessRelation.SETRANGE("Link to Table",ContactBusinessRelation."Link to Table"::Customer);
            ContactBusinessRelation.SETRANGE("No.","No.");
            IF ContactBusinessRelation.FINDFIRST THEN
              Cont.SETRANGE("Company No.",ContactBusinessRelation."Contact No.")
            ELSE
              Cont.SETRANGE("Company No.",'');

            IF "Primary Contact No." <> '' THEN
              IF Cont.GET("Primary Contact No.") THEN ;
            IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN
              VALIDATE("Primary Contact No.",Cont."No.");
            */
        //end;


        //Unsupported feature: Code Modification on "Contact(Field 8).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF RMSetup.GET THEN
              IF RMSetup."Bus. Rel. Code for Customers" <> '' THEN
                IF (xRec.Contact = '') AND (xRec."Primary Contact No." = '') THEN BEGIN
                  MODIFY;
                  UpdateContFromCust.OnModify(Rec);
                  UpdateContFromCust.InsertNewContactPerson(Rec,FALSE);
                  MODIFY(TRUE);
                END
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF RMSetup.GET THEN
              IF RMSetup."Bus. Rel. Code for Customers" <> '' THEN
                IF (xRec.Contact = '') AND (xRec."Primary Contact No." = '') AND (Contact <> '') THEN BEGIN
            #4..8
            */
        //end;


        //Unsupported feature: Code Insertion on ""Salesperson Code"(Field 29)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //var
            //RecLSalespersonAuthorized: Record "50013";
        //begin
            /*
            //>>P24233_001 SOBI
            IF "Salesperson Code" <>xRec."Salesperson Code" THEN BEGIN
               RecLSalespersonAuthorized.SETRANGE("Customer No.","No.");
               IF RecLSalespersonAuthorized.FINDFIRST THEN BEGIN
                  RecLSalespersonAuthorized.MODIFYALL(authorized,FALSE);
                  RecLSalespersonAuthorized.SETRANGE("Salesperson code","Salesperson Code");
                  IF RecLSalespersonAuthorized.FINDFIRST THEN BEGIN
                     RecLSalespersonAuthorized.authorized := TRUE;
                     RecLSalespersonAuthorized.MODIFY;
                  END;
               END;
               VALIDATE("Salesperson Filter","Salesperson Code");

            END;
            //<<P24233_001 SOBI
            */
        //end;


        //Unsupported feature: Code Insertion on ""Country/Region Code"(Field 35)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            PostCode.ValidateCountryCode(City,"Post Code",County,"Country/Region Code");
            */
        //end;


        //Unsupported feature: Code Modification on ""VAT Registration No."(Field 86).OnValidate".

        //trigger "(Field 86)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            VATRegNoFormat.Test("VAT Registration No.","Country/Region Code","No.",DATABASE::Customer);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF VATRegNoFormat.Test("VAT Registration No.","Country/Region Code","No.",DATABASE::Customer) THEN
              IF "VAT Registration No." <> xRec."VAT Registration No." THEN
                VATRegistrationLogMgt.LogCustomer(Rec);
            */
        //end;


        //Unsupported feature: Code Insertion on ""Combine Shipments"(Field 87)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            //>>MIGRATION NAV 2013
            //>>FE018
            IF "Combine Shipments" = FALSE THEN
              "Combine Shipments by Order" := FALSE;
            //<<FE018
            //<<MIGRATION NAV 2013
            */
        //end;


        //Unsupported feature: Code Modification on ""Gen. Bus. Posting Group"(Field 88).OnValidate".

        //trigger  Bus()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" THEN
              IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") THEN
                VALIDATE("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
            //>>MIGRATION NAV 2013
            //>>DEEE1.00 : update customer DEEE informations
            GenBusPostingGrp.GET("Gen. Bus. Posting Group");
            "Submitted to DEEE" := GenBusPostingGrp."Subject to DEEE";
            //<<DEEE1.00 : : update customer DEEE informations
            //<<MIGRATION NAV 2013
            */
        //end;


        //Unsupported feature: Code Modification on ""IC Partner Code"(Field 119).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF xRec."IC Partner Code" <> "IC Partner Code" THEN BEGIN
              CustLedgEntry.SETCURRENTKEY("Customer No.","Posting Date");
              CustLedgEntry.SETRANGE("Customer No.","No.");
              AccountingPeriod.SETRANGE(Closed,FALSE);
              IF AccountingPeriod.FINDFIRST THEN
                CustLedgEntry.SETFILTER("Posting Date",'>=%1',AccountingPeriod."Starting Date");
              IF CustLedgEntry.FINDFIRST THEN
                IF NOT CONFIRM(Text011,FALSE,TABLECAPTION) THEN
                  "IC Partner Code" := xRec."IC Partner Code";

              CustLedgEntry.RESET;
              IF NOT CustLedgEntry.SETCURRENTKEY("Customer No.",Open) THEN
                CustLedgEntry.SETCURRENTKEY("Customer No.");
              CustLedgEntry.SETRANGE("Customer No.","No.");
              CustLedgEntry.SETRANGE(Open,TRUE);
              IF CustLedgEntry.FINDLAST THEN
                ERROR(Text012,FIELDCAPTION("IC Partner Code"),TABLECAPTION);
            END;

            IF "IC Partner Code" <> '' THEN BEGIN
            #21..28
              ICPartner."Customer No." := '';
              ICPartner.MODIFY;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF xRec."IC Partner Code" <> "IC Partner Code" THEN BEGIN
            #12..17

              CustLedgEntry.RESET;
            #2..4
              IF AccountingPeriod.FINDFIRST THEN BEGIN
                CustLedgEntry.SETFILTER("Posting Date",'>=%1',AccountingPeriod."Starting Date");
                IF CustLedgEntry.FINDFIRST THEN
                  IF NOT CONFIRM(Text011,FALSE,TABLECAPTION) THEN
                    "IC Partner Code" := xRec."IC Partner Code";
              END;
            #18..31
            */
        //end;


        //Unsupported feature: Code Modification on ""Primary Contact No."(Field 5049).OnLookup".

        //trigger "(Field 5049)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ContBusRel.SETCURRENTKEY("Link to Table","No.");
            ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Customer);
            ContBusRel.SETRANGE("No.","No.");
            #4..7

            IF "Primary Contact No." <> '' THEN
              IF Cont.GET("Primary Contact No.") THEN ;
            IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN
              VALIDATE("Primary Contact No.",Cont."No.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..10
            IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN BEGIN
              TempCust.COPY(Rec);
              FIND;
              TRANSFERFIELDS(TempCust,FALSE);
              VALIDATE("Primary Contact No.",Cont."No.");
            END;
            */
        //end;
        field(11;"Document Sending Profile";Code[20])
        {
            Caption = 'Document Sending Profile';
            TableRelation = "Document Sending Profile".Code;
        }
        field(90;GLN;Code[13])
        {
            Caption = 'GLN';
            Numeric = true;

            trigger OnValidate()
            var
                GLNCalculator: Codeunit "1607";
            begin
                IF GLN <> '' THEN
                  GLNCalculator.AssertValidCheckDigit13(GLN);
            end;
        }
        field(140;Image;Media)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
        }
        field(50000;"Creation Date";Date)
        {
            Caption = 'Creation Date';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Champs_Suppl] Ajout du champ';
            Editable = false;
        }
        field(50001;User;Code[20])
        {
            Caption = 'User';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Champs_Suppl] Ajout du champ';
            Editable = false;
            TableRelation = User;
        }
        field(50002;"Transaction Type";Code[10])
        {
            Caption = 'Transaction Type';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Nature Transaction';
            TableRelation = "Transaction Type";
        }
        field(50003;"Transaction Specification";Code[10])
        {
            Caption = 'Transaction Specification';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Régime';
            TableRelation = "Transaction Specification";
        }
        field(50004;"Transport Method";Code[10])
        {
            Caption = 'Transport Method';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Mode de transport';
            TableRelation = "Transport Method";
        }
        field(50005;"Exit Point";Code[10])
        {
            Caption = 'Exit Point';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Pays Destination';
            TableRelation = "Entry/Exit Point";
        }
        field(50006;"Area";Code[10])
        {
            Caption = 'Area';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Dep destination';
            TableRelation = Area;
        }
        field(50007;"SFAC Contract Date";Date)
        {
            Caption = 'SFAC Contract Date';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [SFAC] Ajout du champ';
        }
        field(50008;"SFAC Contract No.";Code[20])
        {
            Caption = 'SFAC Contract No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [SFAC] Ajout du champ';
        }
        field(50009;"Pay-to Customer No.";Code[20])
        {
            Caption = 'Pay-to Customer No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur]
                //Mise à jour des Ecritures clients suite à la modification du Client Payeur
                IF CONFIRM(STRSUBSTNO(TextGestTiersPayeur001,"Pay-to Customer No.")) THEN
                   updateLedgerEntries("No.","Pay-to Customer No.");
                //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur]
            end;
        }
        field(50010;"Salesperson Filter";Text[250])
        {
            Caption = 'Salesperson Filter';
            Editable = false;

            trigger OnValidate()
            var
                RecLSalesHeader: Record "36";
                RecLSalesShptHeader: Record "110";
                RecLSalesInvHeader: Record "112";
                RecLSalesCrMemoHeader: Record "110";
            begin
                //>>P24233_001 SOBI
                RecLSalesHeader.SETCURRENTKEY("Document Type","Bill-to Customer No.");
                RecLSalesHeader.SETRANGE("Bill-to Customer No.","No.");
                RecLSalesHeader.MODIFYALL("Salesperson Filter","Salesperson Filter");

                RecLSalesShptHeader.SETCURRENTKEY("Bill-to Customer No.");
                RecLSalesShptHeader.SETRANGE("Bill-to Customer No.","No.");
                RecLSalesShptHeader.MODIFYALL("Salesperson Filter","Salesperson Filter");

                RecLSalesInvHeader.SETCURRENTKEY("Bill-to Customer No.");
                RecLSalesInvHeader.SETRANGE("Bill-to Customer No.","No.");
                RecLSalesInvHeader.MODIFYALL("Salesperson Filter","Salesperson Filter");

                RecLSalesCrMemoHeader.SETCURRENTKEY("Bill-to Customer No.");
                RecLSalesCrMemoHeader.SETRANGE("Bill-to Customer No.","No.");
                RecLSalesCrMemoHeader.MODIFYALL("Salesperson Filter","Salesperson Filter");
                //<<P24233_001 SOBI
            end;
        }
        field(50020;"Customer Sales Profit Group";Code[10])
        {
            Caption = 'Goupe Marge Vente Client';
            Description = 'GRPMARGECLT SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            TableRelation = "Customer Sales Profit Group";
        }
        field(50024;"Code SIREN";Code[14])
        {
            Description = 'ImportFichiersBase RD 15/11/06 NCS1.01 [FE021] Ajout du champ Code SIREN';
        }
        field(50025;"Combine Shipments by Order";Boolean)
        {
            Caption = 'Combine Shipments by Order';
            Description = 'FE018 regroupement BL par CMD';

            trigger OnValidate()
            begin
                //>>FE018
                TESTFIELD("Combine Shipments", TRUE);
                //>>FE018
            end;
        }
        field(50026;"Valued Shipment";Boolean)
        {
            Caption = 'Valued Shipment';
        }
        field(50027;"Not Valued Shipment";Boolean)
        {
            Caption = 'Valued Shipment';
        }
        field(50028;"Shipt Print All Order Line";Boolean)
        {
            Caption = 'Shipt Print All Order Line';
            Description = 'CNE6.01';
        }
        field(50029;"Copy Sell-to Address";Boolean)
        {
            Caption = 'Copy Sell-to Address';
            Description = 'CNE6.01';
        }
        field(80800;"Submitted to DEEE";Boolean)
        {
            Caption = 'Submitted to DEEE';
            Description = 'DEEE1.00';
        }
    }
    keys
    {

        //Unsupported feature: Property Deletion (KeyGroups) on "Name(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on "City(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Post Code"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Phone No."(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on "Contact(Key)".

        key(Key1;"Pay-to Customer No.")
        {
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: SocialListeningSearchTopic)()
    //Parameters and return type have not been exported.
    //begin
        /*
        */
    //end;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: CustomReportSelection)()
    //Parameters and return type have not been exported.
    //begin
        /*
        */
    //end;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: VATRegistrationLogMgt)()
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
        IF DOPaymentCreditCard.FINDFIRST THEN
          DOPaymentCreditCard.DeleteByCustomer(Rec);

        ServiceItem.SETRANGE("Customer No.","No.");
        IF ServiceItem.FINDFIRST THEN
        #6..14
            ERROR(Text009);

        Job.SETRANGE("Bill-to Customer No.","No.");
        IF Job.FINDFIRST THEN
          ERROR(Text015,TABLECAPTION,"No.",Job.TABLECAPTION);

        MoveEntries.MoveCustEntries(Rec);
        #22..50
        ItemCrossReference.SETRANGE("Cross-Reference Type No.","No.");
        ItemCrossReference.DELETEALL;

        SalesOrderLine.SETCURRENTKEY("Document Type","Bill-to Customer No.");
        SalesOrderLine.SETFILTER(
          "Document Type",'%1|%2',
        #57..81

        ServContract.SETFILTER(Status,'<>%1',ServContract.Status::Canceled);
        ServContract.SETRANGE("Customer No.","No.");
        IF ServContract.FINDFIRST THEN
          ERROR(
            Text007,
            TABLECAPTION,"No.");
        #89..91

        ServContract.SETFILTER(Status,'<>%1',ServContract.Status::Canceled);
        ServContract.SETRANGE("Bill-to Customer No.","No.");
        IF ServContract.FINDFIRST THEN
          ERROR(
            Text007,
            TABLECAPTION,"No.");
        #99..114

        UpdateContFromCust.OnDelete(Rec);

        DimMgt.DeleteDefaultDim(DATABASE::Customer,"No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ApprovalsMgmt.OnCancelCustomerApprovalRequest(Rec);
        #3..17
        IF NOT Job.ISEMPTY THEN
        #19..53
        IF NOT SocialListeningSearchTopic.ISEMPTY THEN BEGIN
          SocialListeningSearchTopic.FindSearchTopic(SocialListeningSearchTopic."Source Type"::Customer,"No.");
          SocialListeningSearchTopic.DELETEALL;
        END;

        #54..84
        IF NOT ServContract.ISEMPTY THEN
        #86..94
        IF NOT ServContract.ISEMPTY THEN
        #96..117
        CustomReportSelection.SETRANGE("Source Type",DATABASE::Customer);
        CustomReportSelection.SETRANGE("Source No.","No.");
        CustomReportSelection.DELETEALL;

        MyCustomer.SETRANGE("Customer No.","No.");
        MyCustomer.DELETEALL;
        VATRegistrationLogMgt.DeleteCustomerLog(Rec);

        DimMgt.DeleteDefaultDim(DATABASE::Customer,"No.");
        */
    //end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "No." = '' THEN BEGIN
          SalesSetup.GET;
          SalesSetup.TESTFIELD("Customer Nos.");
          NoSeriesMgt.InitSeries(SalesSetup."Customer Nos.",xRec."No. Series",0D,"No.","No. Series");
        END;
        IF "Invoice Disc. Code" = '' THEN
          "Invoice Disc. Code" := "No.";

        IF NOT InsertFromContact THEN
          UpdateContFromCust.OnInsert(Rec);

        DimMgt.UpdateDefaultDim(
          DATABASE::Customer,"No.",
          "Global Dimension 1 Code","Global Dimension 2 Code");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5

        #6..8
        IF NOT (InsertFromContact OR (InsertFromTemplate AND (Contact <> ''))) THEN
        #10..14

        //>>MIGRATION NAV 2013
        //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Champs_Suppl] Ajout de code pour alimenter les champs créés
        "Creation Date" := WORKDATE;
        User := USERID;
        //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Champs_Suppl] Ajout de code pour alimenter les champs créés

        //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout de code pour mise à jour du champ "Pay-to Customer No."
        "Pay-to Customer No.":="No.";
        //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout de code pour mise à jour du champ "Pay-to Customer No."

        //CHAMPS_DEFAUT FG 05/12/06 NSC1.01
        NaviSetup.GET ;
        NaviSetup.TESTFIELD(NaviSetup."Country Code") ;
        NaviSetup.TESTFIELD(NaviSetup."Gen. Bus. Posting Group Cust.") ;
        NaviSetup.TESTFIELD(NaviSetup."VAT Bus. Posting Group Cust.") ;
        NaviSetup.TESTFIELD(NaviSetup."Customer Posting Group") ;
        //NaviSetup.TESTFIELD(NaviSetup."Invoice Copies") ;
        //NaviSetup.TESTFIELD(NaviSetup."Shipping Time") ;

        VALIDATE("Country/Region Code",NaviSetup."Country Code") ;
        VALIDATE("Gen. Bus. Posting Group",NaviSetup."Gen. Bus. Posting Group Cust.") ;
        VALIDATE("VAT Bus. Posting Group",NaviSetup."VAT Bus. Posting Group Cust.") ;
        VALIDATE("Customer Posting Group",NaviSetup."Customer Posting Group") ;
        VALIDATE("Allow Line Disc.",NaviSetup."Allow Line Disc.") ;
        VALIDATE("Application Method",NaviSetup."Application Method Customer") ;
        VALIDATE("Print Statements",NaviSetup."Print Statements") ;
        VALIDATE("Combine Shipments",NaviSetup."Combine Shipments") ;
        VALIDATE(Reserve,NaviSetup."Reserve Customer") ;
        VALIDATE("Shipping Advice",NaviSetup."Shipping Advice") ;
        VALIDATE("Invoice Copies",NaviSetup."Invoice Copies") ;
        VALIDATE("Shipping Time",NaviSetup."Shipping Time") ;
        //>>CASC
        VALIDATE("Location Code",NaviSetup."Customer Location Code");
        //>>CASC
        //>>TODO point 60
        VALIDATE("Submitted to DEEE", NaviSetup."Submitted to DEEE");
        //<<TODO POINT 60
        //Fin CHAMPS_DEFAUT FG 05/12/06 NSC1.01
        //<<MIGRATION NAV 2013
        */
    //end;


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Last Date Modified" := TODAY;

        IF (Name <> xRec.Name) OR
        #4..23
        THEN BEGIN
          MODIFY;
          UpdateContFromCust.OnModify(Rec);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..26
          IF NOT FIND THEN BEGIN
            RESET;
            IF FIND THEN;
          END;
        END;
        */
    //end;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnRename".

    //trigger (Variable: CustomerTemplate)()
    //Parameters and return type have not been exported.
    //begin
        /*
        */
    //end;


    //Unsupported feature: Code Modification on "OnRename".

    //trigger OnRename()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Last Date Modified" := TODAY;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ApprovalsMgmt.RenameApprovalEntries(xRec.RECORDID,RECORDID);
        "Last Date Modified" := TODAY;
        IF xRec."Invoice Disc. Code" = xRec."No." THEN
          "Invoice Disc. Code" := "No.";
        CustomerTemplate.SETRANGE("Invoice Disc. Code",xRec."No.");
        CustomerTemplate.MODIFYALL("Invoice Disc. Code","No.");
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Variable Insertion (Variable: OfficeContact) (VariableCollection) on "ShowContact(PROCEDURE 1)".


    //Unsupported feature: Variable Insertion (Variable: OfficeMgt) (VariableCollection) on "ShowContact(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "ShowContact(PROCEDURE 1)".

    //procedure ShowContact();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "No." = '' THEN
          EXIT;

        ContBusRel.SETCURRENTKEY("Link to Table","No.");
        ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Customer);
        ContBusRel.SETRANGE("No.","No.");
        IF NOT ContBusRel.FINDFIRST THEN BEGIN
          IF NOT CONFIRM(Text002,FALSE,TABLECAPTION,"No.") THEN
            EXIT;
          UpdateContFromCust.InsertNewContact(Rec,FALSE);
          ContBusRel.FINDFIRST;
        END;
        COMMIT;

        Cont.SETCURRENTKEY("Company Name","Company No.",Type,Name);
        Cont.SETRANGE("Company No.",ContBusRel."Contact No.");
        PAGE.RUN(PAGE::"Contact List",Cont);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF OfficeMgt.GetContact(OfficeContact,"No.") AND (OfficeContact.COUNT = 1) THEN
          PAGE.RUN(PAGE::"Contact Card",OfficeContact)
        ELSE BEGIN
          IF "No." = '' THEN
            EXIT;

          ContBusRel.SETCURRENTKEY("Link to Table","No.");
          ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Customer);
          ContBusRel.SETRANGE("No.","No.");
          IF NOT ContBusRel.FINDFIRST THEN BEGIN
            IF NOT CONFIRM(Text002,FALSE,TABLECAPTION,"No.") THEN
              EXIT;
            UpdateContFromCust.InsertNewContact(Rec,FALSE);
            ContBusRel.FINDFIRST;
          END;
          COMMIT;

          Cont.SETCURRENTKEY("Company Name","Company No.",Type,Name);
          Cont.SETRANGE("Company No.",ContBusRel."Contact No.");
          PAGE.RUN(PAGE::"Contact List",Cont);
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "CheckBlockedCustOnDocs(PROCEDURE 5)".

    //procedure CheckBlockedCustOnDocs();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH Cust2 DO BEGIN
          IF ((Blocked = Blocked::All) OR
              ((Blocked = Blocked::Invoice) AND (DocType IN [DocType::Quote,DocType::Order,DocType::Invoice,DocType::"Blanket Order"])) OR
              ((Blocked = Blocked::Ship) AND (DocType IN [DocType::Quote,DocType::Order,DocType::"Blanket Order"]) AND
               (NOT Transaction)) OR
              ((Blocked = Blocked::Ship) AND (DocType IN [DocType::Quote,DocType::Order,DocType::Invoice,DocType::"Blanket Order"]) AND
               Shipment AND Transaction))
          THEN
            CustBlockedErrorMessage(Cust2,Transaction);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        WITH Cust2 DO BEGIN
          IF ((Blocked = Blocked::All) OR
              ((Blocked = Blocked::Invoice) AND
               (DocType IN [DocType::Quote,DocType::Order,DocType::Invoice,DocType::"Blanket Order"])) OR
        #4..10
        */
    //end;

    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "GetLegalEntityType(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Name) on "LookUpAdjmtValueEntries(PROCEDURE 6)".



    //Unsupported feature: Code Modification on "LookUpAdjmtValueEntries(PROCEDURE 6)".

    //procedure LookUpAdjmtValueEntries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ValueEntry.SETCURRENTKEY("Source Type","Source No.");
        ValueEntry.SETRANGE("Source Type",ValueEntry."Source Type"::Customer);
        ValueEntry.SETRANGE("Source No.","No.");
        ValueEntry.SETFILTER("Posting Date",CustDateFilter);
        ValueEntry.SETFILTER("Global Dimension 1 Code",GETFILTER("Global Dimension 1 Filter"));
        ValueEntry.SETFILTER("Global Dimension 2 Code",GETFILTER("Global Dimension 2 Filter"));
        ValueEntry.SETRANGE(Adjustment,TRUE);
        ValueEntry.SETRANGE("Expected Cost",FALSE);
        PAGE.RUNMODAL(0,ValueEntry);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        EXIT(FORMAT("Partner Type"));
        */
    //end;

    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "HasAddress(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Name) on "GetDefaultBankAcc(PROCEDURE 25)".



    //Unsupported feature: Code Modification on "GetDefaultBankAcc(PROCEDURE 25)".

    //procedure GetDefaultBankAcc();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Preferred Bank Account" <> '' THEN
          CustomerBankAccount.GET("No.","Preferred Bank Account")
        ELSE BEGIN
          CustomerBankAccount.SETRANGE("Customer No.","No.");
          IF NOT CustomerBankAccount.FINDFIRST THEN
            CLEAR(CustomerBankAccount);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CASE TRUE OF
          Address <> '':
            EXIT(TRUE);
          "Address 2" <> '':
            EXIT(TRUE);
          City <> '':
            EXIT(TRUE);
          "Country/Region Code" <> '':
            EXIT(TRUE);
          County <> '':
            EXIT(TRUE);
          "Post Code" <> '':
            EXIT(TRUE);
          Contact <> '':
            EXIT(TRUE);
        END;

        EXIT(FALSE);
        */
    //end;


    //Unsupported feature: Code Modification on "CreateAndShowNewInvoice(PROCEDURE 21)".

    //procedure CreateAndShowNewInvoice();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader.SETRANGE("Sell-to Customer No.","No.");
        SalesHeader.INSERT(TRUE);
        COMMIT;
        PAGE.RUNMODAL(PAGE::"Mini Sales Invoice",SalesHeader)
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        PAGE.RUN(PAGE::"Sales Invoice",SalesHeader)
        */
    //end;


    //Unsupported feature: Code Modification on "CreateAndShowNewCreditMemo(PROCEDURE 22)".

    //procedure CreateAndShowNewCreditMemo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesHeader."Document Type" := SalesHeader."Document Type"::"Credit Memo";
        SalesHeader.SETRANGE("Sell-to Customer No.","No.");
        SalesHeader.INSERT(TRUE);
        COMMIT;
        PAGE.RUNMODAL(PAGE::"Mini Sales Credit Memo",SalesHeader)
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        PAGE.RUN(PAGE::"Sales Credit Memo",SalesHeader)
        */
    //end;


    //Unsupported feature: Code Modification on "CreateAndShowNewQuote(PROCEDURE 24)".

    //procedure CreateAndShowNewQuote();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesHeader."Document Type" := SalesHeader."Document Type"::Quote;
        SalesHeader.SETRANGE("Sell-to Customer No.","No.");
        SalesHeader.INSERT(TRUE);
        COMMIT;
        PAGE.RUNMODAL(PAGE::"Mini Sales Quote",SalesHeader)
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        PAGE.RUN(PAGE::"Sales Quote",SalesHeader)
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "UpdatePaymentTolerance(PROCEDURE 20)".


    procedure GetLegalEntityTypeLbl(): Text
    begin
        EXIT(FIELDCAPTION("Partner Type"));
    end;

    procedure CreateAndShowNewOrder()
    var
        SalesHeader: Record "36";
    begin
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader.SETRANGE("Sell-to Customer No.","No.");
        SalesHeader.INSERT(TRUE);
        COMMIT;
        PAGE.RUN(PAGE::"Sales Order",SalesHeader)
    end;

    procedure GetBillToCustomerNo(): Code[20]
    begin
        IF "Bill-to Customer No." <> '' THEN
          EXIT("Bill-to Customer No.");
        EXIT("No.");
    end;

    procedure GetCustNo(CustomerText: Text): Text
    begin
        EXIT(GetCustNoOpenCard(CustomerText,TRUE));
    end;

    procedure GetCustNoOpenCard(CustomerText: Text;ShowCustomerCard: Boolean): Code[20]
    var
        Customer: Record "18";
        CustomerNo: Code[20];
        NoFiltersApplied: Boolean;
        CustomerWithoutQuote: Text;
        CustomerFilterFromStart: Text;
        CustomerFilterContains: Text;
    begin
        IF CustomerText = '' THEN
          EXIT('');

        IF STRLEN(CustomerText) <= MAXSTRLEN(Customer."No.") THEN
          IF Customer.GET(COPYSTR(CustomerText,1,MAXSTRLEN(Customer."No."))) THEN
            EXIT(Customer."No.");

        CustomerWithoutQuote := CONVERTSTR(CustomerText,'''','?');

        Customer.SETFILTER(Name,'''@' + CustomerWithoutQuote + '''');
        IF Customer.FINDFIRST THEN
          EXIT(Customer."No.");
        Customer.SETRANGE(Name);

        CustomerFilterFromStart := '''@' + CustomerWithoutQuote + '*''';

        Customer.FILTERGROUP := -1;
        Customer.SETFILTER("No.",CustomerFilterFromStart);

        Customer.SETFILTER(Name,CustomerFilterFromStart);

        IF Customer.FINDFIRST THEN
          EXIT(Customer."No.");

        CustomerFilterContains := '''@*' + CustomerWithoutQuote + '*''';

        Customer.SETFILTER("No.",CustomerFilterContains);
        Customer.SETFILTER(Name,CustomerFilterContains);
        Customer.SETFILTER(City,CustomerFilterContains);
        Customer.SETFILTER(Contact,CustomerFilterContains);
        Customer.SETFILTER("Phone No.",CustomerFilterContains);
        Customer.SETFILTER("Post Code",CustomerFilterContains);

        IF Customer.COUNT = 0 THEN
          MarkCustomersWithSimilarName(Customer,CustomerText);

        IF Customer.COUNT = 1 THEN BEGIN
          Customer.FINDFIRST;
          EXIT(Customer."No.");
        END;

        IF NOT GUIALLOWED THEN
          ERROR(SelectCustErr);

        IF Customer.COUNT = 0 THEN BEGIN
          IF Customer.WRITEPERMISSION THEN
            CASE STRMENU(
                   STRSUBSTNO(
                     '%1,%2',STRSUBSTNO(CreateNewCustTxt,CONVERTSTR(CustomerText,',','.')),SelectCustTxt),1,CustNotRegisteredTxt) OF
              0:
                ERROR(SelectCustErr);
              1:
                EXIT(CreateNewCustomer(COPYSTR(CustomerText,1,MAXSTRLEN(Customer.Name)),ShowCustomerCard));
            END;
          Customer.RESET;
          NoFiltersApplied := TRUE;
        END;

        IF ShowCustomerCard THEN
          CustomerNo := PickCustomer(Customer,NoFiltersApplied)
        ELSE BEGIN
          LookupRequested := TRUE;
          EXIT('');
        END;

        IF CustomerNo <> '' THEN
          EXIT(CustomerNo);

        ERROR(SelectCustErr);
    end;

    local procedure MarkCustomersWithSimilarName(var Customer: Record "18";CustomerText: Text)
    var
        TypeHelper: Codeunit "10";
        CustomerCount: Integer;
        CustomerTextLenght: Integer;
        Treshold: Integer;
    begin
        IF CustomerText = '' THEN
          EXIT;
        IF STRLEN(CustomerText) > MAXSTRLEN(Customer.Name) THEN
          EXIT;
        CustomerTextLenght := STRLEN(CustomerText);
        Treshold := CustomerTextLenght DIV 5;
        IF Treshold = 0 THEN
          EXIT;

        Customer.RESET;
        Customer.ASCENDING(FALSE); // most likely to search for newest customers
        IF Customer.FINDSET THEN
          REPEAT
            CustomerCount += 1;
            IF ABS(CustomerTextLenght - STRLEN(Customer.Name)) <= Treshold THEN
              IF TypeHelper.TextDistance(UPPERCASE(CustomerText),UPPERCASE(Customer.Name)) <= Treshold THEN
                Customer.MARK(TRUE);
          UNTIL Customer.MARK OR (Customer.NEXT = 0) OR (CustomerCount > 1000);
        Customer.MARKEDONLY(TRUE);
    end;

    local procedure CreateNewCustomer(CustomerName: Text[50];ShowCustomerCard: Boolean): Code[20]
    var
        Customer: Record "18";
        MiniCustomerTemplate: Record "1300";
        CustomerCard: Page "21";
    begin
        IF NOT MiniCustomerTemplate.NewCustomerFromTemplate(Customer) THEN
          Customer.INSERT(TRUE);

        Customer.Name := CustomerName;
        Customer.MODIFY(TRUE);
        COMMIT;
        IF NOT ShowCustomerCard THEN
          EXIT(Customer."No.");
        Customer.SETRANGE("No.",Customer."No.");
        CustomerCard.SETTABLEVIEW(Customer);
        IF NOT (CustomerCard.RUNMODAL = ACTION::OK) THEN
          ERROR(SelectCustErr);

        EXIT(Customer."No.");
    end;

    local procedure PickCustomer(var Customer: Record "18";NoFiltersApplied: Boolean): Code[20]
    var
        CustomerList: Page "22";
    begin
        IF NOT NoFiltersApplied THEN
          MarkCustomersByFilters(Customer);

        CustomerList.SETTABLEVIEW(Customer);
        CustomerList.SETRECORD(Customer);
        CustomerList.LOOKUPMODE := TRUE;
        IF CustomerList.RUNMODAL = ACTION::LookupOK THEN
          CustomerList.GETRECORD(Customer)
        ELSE
          CLEAR(Customer);

        EXIT(Customer."No.");
    end;

    local procedure MarkCustomersByFilters(var Customer: Record "18")
    begin
        IF Customer.FINDSET THEN
          REPEAT
            Customer.MARK(TRUE);
          UNTIL Customer.NEXT = 0;
        IF Customer.FINDFIRST THEN;
        Customer.MARKEDONLY := TRUE;
    end;

    procedure OpenCustomerLedgerEntries(FilterOnDueEntries: Boolean)
    var
        DetailedCustLedgEntry: Record "379";
        CustLedgerEntry: Record "21";
    begin
        DetailedCustLedgEntry.SETRANGE("Customer No.","No.");
        COPYFILTER("Global Dimension 1 Filter",DetailedCustLedgEntry."Initial Entry Global Dim. 1");
        COPYFILTER("Global Dimension 2 Filter",DetailedCustLedgEntry."Initial Entry Global Dim. 2");
        IF FilterOnDueEntries AND (GETFILTER("Date Filter") <> '') THEN BEGIN
          COPYFILTER("Date Filter",DetailedCustLedgEntry."Initial Entry Due Date");
          DetailedCustLedgEntry.SETFILTER("Posting Date",'<=%1',GETRANGEMAX("Date Filter"));
        END;
        COPYFILTER("Currency Filter",DetailedCustLedgEntry."Currency Code");
        CustLedgerEntry.DrillDownOnEntries(DetailedCustLedgEntry);
    end;

    procedure SetInsertFromTemplate(FromTemplate: Boolean)
    begin
        InsertFromTemplate := FromTemplate;
    end;

    procedure IsLookupRequested() Result: Boolean
    begin
        Result := LookupRequested;
        LookupRequested := FALSE;
    end;

    procedure "---NSC1.00---"()
    begin
    end;

    procedure updateLedgerEntries(CodLCustNo: Code[20];CodLPayToNo: Code[20])
    var
        RecLCustLedgEntry: Record "21";
        RecLDetCustLedgEntry: Record "379";
    begin
        //Mise à jour de la Table 21 Ecriture client
        RecLCustLedgEntry.RESET;
        RecLCustLedgEntry.SETRANGE("Customer No.",CodLCustNo);
        RecLCustLedgEntry.SETRANGE(Open,TRUE);
        IF RecLCustLedgEntry.FINDSET(TRUE,FALSE) THEN
        REPEAT
           RecLCustLedgEntry."Pay-to Customer No." := CodLPayToNo;
           RecLCustLedgEntry.MODIFY;

           //Mise à jour de la Table 379 Ecriture client détaillé
           RecLDetCustLedgEntry.RESET;
           RecLDetCustLedgEntry.SETRANGE("Cust. Ledger Entry No.",RecLCustLedgEntry."Entry No.");
           IF RecLDetCustLedgEntry.FINDSET(TRUE,FALSE) THEN
           REPEAT
              RecLDetCustLedgEntry."Pay-to Customer No." := CodLPayToNo;
              RecLDetCustLedgEntry.MODIFY;
           UNTIL RecLDetCustLedgEntry.NEXT = 0;
        UNTIL RecLCustLedgEntry.NEXT = 0;
    end;

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: Brick)".


    //Unsupported feature: Deletion (ParameterCollection) on "LookUpAdjmtValueEntries(PROCEDURE 6).CustDateFilter(Parameter 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "LookUpAdjmtValueEntries(PROCEDURE 6).ValueEntry(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "GetDefaultBankAcc(PROCEDURE 25).CustomerBankAccount(Parameter 1002)".


    var
        VATRegistrationLogMgt: Codeunit "249";

    var
        TempCust: Record "18" temporary;

    var
        SocialListeningSearchTopic: Record "871";

    var
        CustomReportSelection: Record "9657";
        MyCustomer: Record "9150";
        ServHeader: Record "5900";

    var
        VATRegistrationLogMgt: Codeunit "249";

    var
        CustomerTemplate: Record "5105";

    var
        ApprovalsMgmt: Codeunit "1535";

    var
        CreateNewCustTxt: Label 'Create a new customer card for %1', Comment='%1 is the name to be used to create the customer. ';
        SelectCustErr: Label 'You must select an existing customer.';
        CustNotRegisteredTxt: Label 'This customer is not registered. To continue, choose one of the following options:';
        SelectCustTxt: Label 'Select an existing customer';
        InsertFromTemplate: Boolean;
        LookupRequested: Boolean;
        "--NSC1.00--": ;
        TextGestTiersPayeur001: Label 'Do you want to update Open Ledger entries with new Pay-to customer No. %1?';
        "-NSC1.01-": Integer;
        NaviSetup: Record "50004";
}

