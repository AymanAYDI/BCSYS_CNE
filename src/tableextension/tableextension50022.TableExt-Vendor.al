tableextension 50022 tableextension50022 extends Vendor
{
    // <changelog>
    //   <add id="FR0001" dev="EDUBUC" date="2004-08-19" area="BANKACC"  request="FR-START-40"
    //     releaseversion="FR4.00">French Bank account number</add>
    //   <add id="FR0002" dev="KCOOLS" date="2005-11-18" area="PAYMNG"  request="FR-START-40B"
    //     releaseversion="FR4.00.02">Payment management system</add>
    // </changelog>
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Champs_Suppl]         Ajout des champs 50000, 50001
    //                                                              Ajout de code dans le trigger OnInsert() pour alimenter ces champs
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm]             Ajout des champs 50002..50006
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ 50007 "Pay-to Vend. No."
    //                                                              Ajout de code pour mise à jour du champ "Pay-to Vend. No."
    //                                                              Ajout de la clé: "Pay-to Vend. No."
    //                                                              Mise à jour des Ecritures fournisseurs suite à la modification
    //                                                              du Fournisseur Payeur
    //                                                              Ajout de code sur le trigger "Pay-to Vend. No. - OnValidate()"
    //                                                              Ajout de la fonction updateLedgerEntries()
    // //MNTMINI SM 13/10/06 NSC1.01 [FE002] Ajout du champ Mini Montant 50010
    // 
    // //ImportFichiersBase RD 15/11/06 NCS1.01 [FE021] Ajout du champ "Min Franco"
    // //CASC 12/01/2007 NSC1.01 : Add Default Field On insert : Locatin Code
    // 
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    //           - Add fields 80800
    //           - Gen. Bus. Posting Group - OnValidate()
    // 
    // //todolist point 60 FLGR 21/02/2007 Add Default Field On insert : "Posting DEEE"
    // //VERSIONNING FG 28/02/07 suite au Merge
    // 
    // //>>CNEIC
    // CR_NouvSte_CNE_20150605: TO 01/07/2015: Add Key "IC Partner Code"
    // 
    // ------------------------------------------------------------------------
    LookupPageID = 27;
    DrillDownPageID = 27;
    fields
    {
        modify(City)
        {
            TableRelation = IF (Country/Region Code=CONST()) "Post Code".City
                            ELSE IF (Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Country/Region Code));
        }

        //Unsupported feature: Property Modification (CalcFormula) on "Comment(Field 38)".


        //Unsupported feature: Property Modification (CalcFormula) on "Balance(Field 58)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Balance (LCY)"(Field 59)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Net Change"(Field 60)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Net Change (LCY)"(Field 61)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Purchases (LCY)"(Field 62)".


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


        //Unsupported feature: Property Modification (CalcFormula) on ""Amt. Rcd. Not Invoiced"(Field 79)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Amt. Rcd. Not Invoiced"(Field 79)".

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

        //Unsupported feature: Property Modification (CalcFormula) on ""Reminder Amounts"(Field 104)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Reminder Amounts (LCY)"(Field 105)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Outstanding Orders (LCY)"(Field 113)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Outstanding Orders (LCY)"(Field 113)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Amt. Rcd. Not Invoiced (LCY)"(Field 114)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Amt. Rcd. Not Invoiced (LCY)"(Field 114)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Pmt. Disc. Tolerance (LCY)"(Field 117)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Pmt. Tolerance (LCY)"(Field 118)".


        //Unsupported feature: Property Modification (CalcFormula) on "Refunds(Field 120)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Refunds (LCY)"(Field 121)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Other Amounts"(Field 122)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Other Amounts (LCY)"(Field 123)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Outstanding Invoices"(Field 125)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Outstanding Invoices"(Field 125)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Outstanding Invoices (LCY)"(Field 126)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Outstanding Invoices (LCY)"(Field 126)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Pay-to No. Of Archived Doc."(Field 130)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Buy-from No. Of Archived Doc."(Field 131)".

        modify("Preferred Bank Account")
        {

            //Unsupported feature: Property Modification (Name) on ""Preferred Bank Account"(Field 288)".

            Caption = 'Preferred Bank Account Code';
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Lead Time Calculation"(Field 5790)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Pay-to No. of Orders"(Field 7181)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Pay-to No. of Orders"(Field 7181)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Pay-to No. of Invoices"(Field 7182)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Pay-to No. of Return Orders"(Field 7183)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Pay-to No. of Return Orders"(Field 7183)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Pay-to No. of Credit Memos"(Field 7184)".


        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Quotes"(Field 7189)".


        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Blanket Orders"(Field 7190)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""No. of Blanket Orders"(Field 7190)".


        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Orders"(Field 7191)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""No. of Orders"(Field 7191)".


        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Invoices"(Field 7192)".


        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Return Orders"(Field 7193)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""No. of Return Orders"(Field 7193)".


        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Credit Memos"(Field 7194)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Pay-to No. of Quotes"(Field 7196)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Pay-to No. of Blanket Orders"(Field 7197)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Pay-to No. of Blanket Orders"(Field 7197)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Payment in progress (LCY)"(Field 10860)".



        //Unsupported feature: Code Insertion on "Contact(Field 8)".

        //trigger OnLookup(var Text: Text): Boolean
        //var
            //ContactBusinessRelation: Record "5054";
            //Cont: Record "5050";
        //begin
            /*
            ContactBusinessRelation.SETCURRENTKEY("Link to Table","No.");
            ContactBusinessRelation.SETRANGE("Link to Table",ContactBusinessRelation."Link to Table"::Vendor);
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
              IF RMSetup."Bus. Rel. Code for Vendors" <> '' THEN
                IF (xRec.Contact = '') AND (xRec."Primary Contact No." = '') THEN BEGIN
                  MODIFY;
                  UpdateContFromVend.OnModify(Rec);
                  UpdateContFromVend.InsertNewContactPerson(Rec,FALSE);
                  MODIFY(TRUE);
                END
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF RMSetup.GET THEN
              IF RMSetup."Bus. Rel. Code for Vendors" <> '' THEN BEGIN
                IF (xRec.Contact = '') AND (xRec."Primary Contact No." = '') AND (Contact <> '') THEN BEGIN
            #4..7
                END;
                EXIT;
              END;
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
            VATRegNoFormat.Test("VAT Registration No.","Country/Region Code","No.",DATABASE::Vendor);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF VATRegNoFormat.Test("VAT Registration No.","Country/Region Code","No.",DATABASE::Vendor) THEN
              IF "VAT Registration No." <> xRec."VAT Registration No." THEN
                VATRegistrationLogMgt.LogVendor(Rec);
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
            //>>DEEE1.00 : update vendor DEEE informations
            GenBusPostingGrp.GET("Gen. Bus. Posting Group");
            "Posting DEEE" := GenBusPostingGrp."Subject to DEEE";
            //<<DEEE1.00 : : update vendor DEEE informations
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
              VendLedgEntry.SETCURRENTKEY("Vendor No.","Posting Date");
              VendLedgEntry.SETRANGE("Vendor No.","No.");
              AccountingPeriod.SETRANGE(Closed,FALSE);
              IF AccountingPeriod.FINDFIRST THEN
                VendLedgEntry.SETFILTER("Posting Date",'>=%1',AccountingPeriod."Starting Date");
              IF VendLedgEntry.FINDFIRST THEN
                IF NOT CONFIRM(Text009,FALSE,TABLECAPTION) THEN
                  "IC Partner Code" := xRec."IC Partner Code";

              VendLedgEntry.RESET;
              IF NOT VendLedgEntry.SETCURRENTKEY("Vendor No.",Open) THEN
                VendLedgEntry.SETCURRENTKEY("Vendor No.");
              VendLedgEntry.SETRANGE("Vendor No.","No.");
              VendLedgEntry.SETRANGE(Open,TRUE);
              IF VendLedgEntry.FINDLAST THEN
                ERROR(Text010,FIELDCAPTION("IC Partner Code"),TABLECAPTION);
            END;

            IF "IC Partner Code" <> '' THEN BEGIN
            #21..28
              ICPartner."Vendor No." := '';
              ICPartner.MODIFY;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF xRec."IC Partner Code" <> "IC Partner Code" THEN BEGIN
            #12..17

              VendLedgEntry.RESET;
            #2..4
              IF AccountingPeriod.FINDFIRST THEN BEGIN
                VendLedgEntry.SETFILTER("Posting Date",'>=%1',AccountingPeriod."Starting Date");
                IF VendLedgEntry.FINDFIRST THEN
                  IF NOT CONFIRM(Text009,FALSE,TABLECAPTION) THEN
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
            ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Vendor);
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
              TempVend.COPY(Rec);
              FIND;
              TRANSFERFIELDS(TempVend,FALSE);
              VALIDATE("Primary Contact No.",Cont."No.");
            END;
            */
        //end;


        //Unsupported feature: Code Insertion on ""Lead Time Calculation"(Field 5790)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            LeadTimeMgt.CheckLeadTimeIsNotNegative("Lead Time Calculation");
            */
        //end;
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
        field(7601;"Document Sending Profile";Code[20])
        {
            Caption = 'Document Sending Profile';
            TableRelation = "Document Sending Profile".Code;
        }
        field(8000;Id;Guid)
        {
            Caption = 'Id';
        }
        field(50000;"Creation Date";Date)
        {
            Caption = 'Creation Date';
            Description = 'NAVIDIIGEST BR 01.08.2006 NSC1.00 [Champs_Suppl] Ajout du champ';
            Editable = false;
        }
        field(50001;User;Code[20])
        {
            Caption = 'User';
            Description = 'NAVIDIIGEST BR 01.08.2006 NSC1.00 [Champs_Suppl] Ajout du champ';
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
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Mode transport';
            TableRelation = "Transport Method";
        }
        field(50005;"Entry Point";Code[10])
        {
            Caption = 'Entry  Point';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Pays';
            TableRelation = "Entry/Exit Point";
        }
        field(50006;"Area";Code[10])
        {
            Caption = 'Area';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Département';
            TableRelation = Area;
        }
        field(50007;"Pay-to Vend. No.";Code[20])
        {
            Caption = 'Pay-to Vend. No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur]
                //Mise à jour des Ecritures clients suite à la modification du Fns Payeur
                IF CONFIRM(STRSUBSTNO(TextGestTiersPayeur001,"Pay-to Vend. No.")) THEN
                   updateLedgerEntries("No.","Pay-to Vend. No.");
                //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur]
            end;
        }
        field(50010;"Mini Amount";Decimal)
        {
            Caption = 'Montant mini franco ';
            Description = 'MNTMINI SM 13/10/06 NSC1.01 [FE002] Ajout du champ Mini Montant';
        }
        field(50012;MinFranco;Decimal)
        {
            Description = 'ImportFichiersBase RD 15/11/06 NCS1.01 [FE021] Ajout du champ Minimum Franco';
            Enabled = false;
        }
        field(50013;"Order Minimum";Decimal)
        {
            Caption = 'Order Minimum';
        }
        field(50014;"Freight Amount";Decimal)
        {
            Caption = 'Freight Amount';
        }
        field(50015;"Blocked Prices";Boolean)
        {
            Caption = 'Blocked Prices';
        }
        field(50016;"% Mini Margin";Decimal)
        {
            Caption = '% Mini Margin';
            MaxValue = 100;
            MinValue = 0;
        }
        field(80800;"Posting DEEE";Boolean)
        {
            Caption = 'Posting DEEE';
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

        key(Key1;"Pay-to Vend. No.")
        {
        }
        key(Key2;"IC Partner Code")
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


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        MoveEntries.MoveVendorEntries(Rec);

        CommentLine.SETRANGE("Table Name",CommentLine."Table Name"::Vendor);
        #4..28

        PurchOrderLine.SETRANGE("Pay-to Vendor No.");
        PurchOrderLine.SETRANGE("Buy-from Vendor No.","No.");
        IF PurchOrderLine.FINDFIRST THEN
          ERROR(
            Text000,
            TABLECAPTION,"No.");
        #36..43
        ItemVendor.SETRANGE("Vendor No.","No.");
        ItemVendor.DELETEALL(TRUE);

        PurchPrice.SETCURRENTKEY("Vendor No.");
        PurchPrice.SETRANGE("Vendor No.","No.");
        PurchPrice.DELETEALL(TRUE);

        PurchLineDiscount.SETCURRENTKEY("Vendor No.");
        PurchLineDiscount.SETRANGE("Vendor No.","No.");
        PurchLineDiscount.DELETEALL(TRUE);

        PurchPrepmtPct.SETCURRENTKEY("Vendor No.");
        PurchPrepmtPct.SETRANGE("Vendor No.","No.");
        PurchPrepmtPct.DELETEALL(TRUE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ApprovalsMgmt.OnCancelVendorApprovalRequest(Rec);

        #1..31
        IF NOT PurchOrderLine.ISEMPTY THEN
        #33..46
        IF NOT SocialListeningSearchTopic.ISEMPTY THEN BEGIN
          SocialListeningSearchTopic.FindSearchTopic(SocialListeningSearchTopic."Source Type"::Vendor,"No.");
          SocialListeningSearchTopic.DELETEALL;
        END;

        #47..54
        CustomReportSelection.SETRANGE("Source Type",DATABASE::Vendor);
        CustomReportSelection.SETRANGE("Source No.","No.");
        CustomReportSelection.DELETEALL;

        #55..57

        VATRegistrationLogMgt.DeleteVendorLog(Rec);
        */
    //end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "No." = '' THEN BEGIN
          PurchSetup.GET;
          PurchSetup.TESTFIELD("Vendor Nos.");
          NoSeriesMgt.InitSeries(PurchSetup."Vendor Nos.",xRec."No. Series",0D,"No.","No. Series");
        END;
        IF "Invoice Disc. Code" = '' THEN
          "Invoice Disc. Code" := "No.";

        IF NOT InsertFromContact THEN
          UpdateContFromVend.OnInsert(Rec);

        DimMgt.UpdateDefaultDim(
          DATABASE::Vendor,"No.",
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

        //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout de code pour mise à jour du champ "Pay-to Vend. No."
        "Pay-to Vend. No.":="No.";
        //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout de code pour mise à jour du champ "Pay-to Vend. No."

        //CHAMPS_DEFAUT FG 05/12/06 NSC1.01
        NaviSetup.GET ;
        NaviSetup.TESTFIELD(NaviSetup."Gen. Bus. Posting Group Vendor") ;
        NaviSetup.TESTFIELD(NaviSetup."VAT Bus. Posting Group Vendor") ;
        NaviSetup.TESTFIELD(NaviSetup."Vendor Posting Group") ;
        //NaviSetup.TESTFIELD(NaviSetup."Lead Time Calculation Vendor") ;
        NaviSetup.TESTFIELD(NaviSetup."Purchaser Code") ;
        NaviSetup.TESTFIELD(NaviSetup."Payment Terms Code") ;
        NaviSetup.TESTFIELD(NaviSetup."Payment Method Code") ;
        NaviSetup.TESTFIELD(NaviSetup."Base Calendar Code") ;

        VALIDATE("Gen. Bus. Posting Group",NaviSetup."Gen. Bus. Posting Group Vendor") ;
        VALIDATE("VAT Bus. Posting Group",NaviSetup."VAT Bus. Posting Group Vendor") ;
        VALIDATE("Vendor Posting Group",NaviSetup."Vendor Posting Group") ;
        VALIDATE("Lead Time Calculation",NaviSetup."Lead Time Calculation Vendor") ;
        VALIDATE("Purchaser Code",NaviSetup."Purchaser Code") ;
        VALIDATE("Application Method",NaviSetup."Application Method Vendor") ;
        VALIDATE("Payment Terms Code",NaviSetup."Payment Terms Code") ;
        VALIDATE("Payment Method Code",NaviSetup."Payment Method Code") ;
        VALIDATE("Base Calendar Code",NaviSetup."Base Calendar Code") ;
        //>>CASC NSC1.01
        VALIDATE("Location Code",NaviSetup."Vendor Location Code");
        //<<CASC NSC1.01
        //>>TODOLIST point 60
        VALIDATE("Posting DEEE",NaviSetup."Posting DEEE");
        //<<TODOLIST point 60
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
        #4..22
        THEN BEGIN
          MODIFY;
          UpdateContFromVend.OnModify(Rec);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..25
          IF NOT FIND THEN BEGIN
            RESET;
            IF FIND THEN;
          END;
        END;
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
        ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Vendor);
        ContBusRel.SETRANGE("No.","No.");
        IF NOT ContBusRel.FINDFIRST THEN BEGIN
          IF NOT CONFIRM(Text003,FALSE,TABLECAPTION,"No.") THEN
            EXIT;
          UpdateContFromVend.InsertNewContact(Rec,FALSE);
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
          ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Vendor);
          ContBusRel.SETRANGE("No.","No.");
          IF NOT ContBusRel.FINDFIRST THEN BEGIN
            IF NOT CONFIRM(Text003,FALSE,TABLECAPTION,"No.") THEN
              EXIT;
            UpdateContFromVend.InsertNewContact(Rec,FALSE);
            ContBusRel.FINDFIRST;
          END;
          COMMIT;

          Cont.SETCURRENTKEY("Company Name","Company No.",Type,Name);
          Cont.SETRANGE("Company No.",ContBusRel."Contact No.");
          PAGE.RUN(PAGE::"Contact List",Cont);
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "CreateAndShowNewInvoice(PROCEDURE 21)".

    //procedure CreateAndShowNewInvoice();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Invoice;
        PurchaseHeader.SETRANGE("Buy-from Vendor No.","No.");
        PurchaseHeader.INSERT(TRUE);
        COMMIT;
        PAGE.RUNMODAL(PAGE::"Mini Purchase Invoice",PurchaseHeader)
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        PAGE.RUN(PAGE::"Purchase Invoice",PurchaseHeader)
        */
    //end;


    //Unsupported feature: Code Modification on "CreateAndShowNewCreditMemo(PROCEDURE 22)".

    //procedure CreateAndShowNewCreditMemo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::"Credit Memo";
        PurchaseHeader.SETRANGE("Buy-from Vendor No.","No.");
        PurchaseHeader.INSERT(TRUE);
        COMMIT;
        PAGE.RUNMODAL(PAGE::"Mini Purchase Credit Memo",PurchaseHeader)
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        PAGE.RUN(PAGE::"Purchase Credit Memo",PurchaseHeader)
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
          VendorBankAccount.GET("No.","Preferred Bank Account")
        ELSE BEGIN
          VendorBankAccount.SETRANGE("Vendor No.","No.");
          IF NOT VendorBankAccount.FINDFIRST THEN
            CLEAR(VendorBankAccount);
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

    //Unsupported feature: Variable Insertion (Variable: VendLedgEntryRemainAmtQuery) (VariableCollection) on "CalcOverDueBalance(PROCEDURE 8)".



    //Unsupported feature: Code Modification on "CalcOverDueBalance(PROCEDURE 8)".

    //procedure CalcOverDueBalance();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        VendLedgerEntry.SETCURRENTKEY("Vendor No.",Open,Positive,"Due Date","Currency Code");
        VendLedgerEntry.SETRANGE("Vendor No.","No.");
        VendLedgerEntry.SETRANGE(Open,TRUE);
        VendLedgerEntry.SETFILTER("Due Date",'<%1',WORKDATE);
        VendLedgerEntry.SETAUTOCALCFIELDS("Remaining Amt. (LCY)");
        IF VendLedgerEntry.FINDSET THEN
          REPEAT
            OverDueBalance += VendLedgerEntry."Remaining Amt. (LCY)";
          UNTIL VendLedgerEntry.NEXT = 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        VendLedgEntryRemainAmtQuery.SETRANGE(Vendor_No,"No.");
        VendLedgEntryRemainAmtQuery.SETRANGE(IsOpen,TRUE);
        VendLedgEntryRemainAmtQuery.SETFILTER(Due_Date,'<%1',WORKDATE);
        VendLedgEntryRemainAmtQuery.OPEN;

        IF VendLedgEntryRemainAmtQuery.READ THEN
          OverDueBalance := -VendLedgEntryRemainAmtQuery.Sum_Remaining_Amt_LCY;
        */
    //end;

    procedure CreateAndShowNewPurchaseOrder()
    var
        PurchaseHeader: Record "38";
    begin
        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
        PurchaseHeader.SETRANGE("Buy-from Vendor No.","No.");
        PurchaseHeader.INSERT(TRUE);
        COMMIT;
        PAGE.RUN(PAGE::"Purchase Order",PurchaseHeader);
    end;

    procedure "---NSC1.00---"()
    begin
    end;

    procedure updateLedgerEntries(CodLVendNo: Code[20];CodLPayToNo: Code[20])
    var
        RecLVendLedgEntry: Record "25";
        RecLDetVendLedgEntry: Record "380";
    begin
        //Mise à jour de la Table 25 Ecriture Fournisseur
        RecLVendLedgEntry.RESET;
        RecLVendLedgEntry.SETRANGE("Vendor No.",CodLVendNo);
        RecLVendLedgEntry.SETRANGE(Open,TRUE);
        IF RecLVendLedgEntry.FINDSET(TRUE,FALSE) THEN
        REPEAT
           RecLVendLedgEntry."Pay-to Vend. No." := CodLPayToNo;
           RecLVendLedgEntry.MODIFY;

           //Mise à jour de la Table 380 Ecriture Forunisseur détaillé
           RecLDetVendLedgEntry.RESET;
           RecLDetVendLedgEntry.SETRANGE("Vendor Ledger Entry No.",RecLVendLedgEntry."Entry No.");
           IF RecLDetVendLedgEntry.FINDSET(TRUE,FALSE) THEN
           REPEAT
              RecLDetVendLedgEntry."Pay-to Vend. No." := CodLPayToNo;
              RecLDetVendLedgEntry.MODIFY;
           UNTIL RecLDetVendLedgEntry.NEXT = 0;
        UNTIL RecLVendLedgEntry.NEXT = 0;
    end;

    procedure GetVendorNo(VendorText: Text[50]): Code[20]
    var
        Vendor: Record "23";
        VendorNo: Code[20];
        NoFiltersApplied: Boolean;
        VendorWithoutQuote: Text;
        VendorFilterFromStart: Text;
        VendorFilterContains: Text;
    begin
        IF VendorText = '' THEN
          EXIT('');

        IF STRLEN(VendorText) <= MAXSTRLEN(Vendor."No.") THEN
          IF Vendor.GET(VendorText) THEN
            EXIT(Vendor."No.");

        VendorWithoutQuote := CONVERTSTR(VendorText,'''','?');

        Vendor.SETFILTER(Name,'''@' + VendorWithoutQuote + '''');
        IF Vendor.FINDFIRST THEN
          EXIT(Vendor."No.");
        Vendor.SETRANGE(Name);

        VendorFilterFromStart := '''@' + VendorWithoutQuote + '*''';

        Vendor.FILTERGROUP := -1;
        Vendor.SETFILTER("No.",VendorFilterFromStart);
        Vendor.SETFILTER(Name,VendorFilterFromStart);
        IF Vendor.FINDFIRST THEN
          EXIT(Vendor."No.");

        VendorFilterContains := '''@*' + VendorWithoutQuote + '*''';

        Vendor.SETFILTER("No.",VendorFilterContains);
        Vendor.SETFILTER(Name,VendorFilterContains);
        Vendor.SETFILTER(City,VendorFilterContains);
        Vendor.SETFILTER(Contact,VendorFilterContains);
        Vendor.SETFILTER("Phone No.",VendorFilterContains);
        Vendor.SETFILTER("Post Code",VendorFilterContains);

        IF Vendor.COUNT = 0 THEN
          MarkVendorsWithSimilarName(Vendor,VendorText);

        IF Vendor.COUNT = 1 THEN BEGIN
          Vendor.FINDFIRST;
          EXIT(Vendor."No.");
        END;

        IF NOT GUIALLOWED THEN
          ERROR(SelectVendorErr);

        IF Vendor.COUNT = 0 THEN BEGIN
          IF Vendor.WRITEPERMISSION THEN
            CASE STRMENU(STRSUBSTNO('%1,%2',STRSUBSTNO(CreateNewVendTxt,VendorText),SelectVendTxt),1,VendNotRegisteredTxt) OF
              0:
                ERROR(SelectVendorErr);
              1:
                EXIT(CreateNewVendor(COPYSTR(VendorText,1,MAXSTRLEN(Vendor.Name))));
            END;
          Vendor.RESET;
          NoFiltersApplied := TRUE;
        END;

        VendorNo := PickVendor(Vendor,NoFiltersApplied);
        IF VendorNo <> '' THEN
          EXIT(VendorNo);

        ERROR(SelectVendorErr);
    end;

    local procedure MarkVendorsWithSimilarName(var Vendor: Record "23";VendorText: Text)
    var
        TypeHelper: Codeunit "10";
        VendorCount: Integer;
        VendorTextLenght: Integer;
        Treshold: Integer;
    begin
        IF VendorText = '' THEN
          EXIT;
        IF STRLEN(VendorText) > MAXSTRLEN(Vendor.Name) THEN
          EXIT;
        VendorTextLenght := STRLEN(VendorText);
        Treshold := VendorTextLenght DIV 5;
        IF Treshold = 0 THEN
          EXIT;
        Vendor.RESET;
        Vendor.ASCENDING(FALSE); // most likely to search for newest Vendors
        IF Vendor.FINDSET THEN
          REPEAT
            VendorCount += 1;
            IF ABS(VendorTextLenght - STRLEN(Vendor.Name)) <= Treshold THEN
              IF TypeHelper.TextDistance(UPPERCASE(VendorText),UPPERCASE(Vendor.Name)) <= Treshold THEN
                Vendor.MARK(TRUE);
          UNTIL Vendor.MARK OR (Vendor.NEXT = 0) OR (VendorCount > 1000);
        Vendor.MARKEDONLY(TRUE);
    end;

    local procedure CreateNewVendor(VendorName: Text[50]): Code[20]
    var
        Vendor: Record "23";
        MiniVendorTemplate: Record "1303";
        VendorCard: Page "26";
    begin
        IF NOT MiniVendorTemplate.NewVendorFromTemplate(Vendor) THEN
          ERROR(SelectVendorErr);

        Vendor.Name := VendorName;
        Vendor.MODIFY(TRUE);
        COMMIT;
        Vendor.SETRANGE("No.",Vendor."No.");
        VendorCard.SETTABLEVIEW(Vendor);
        IF NOT (VendorCard.RUNMODAL = ACTION::OK) THEN
          ERROR(SelectVendorErr);

        EXIT(Vendor."No.");
    end;

    local procedure PickVendor(var Vendor: Record "23";NoFiltersApplied: Boolean): Code[20]
    var
        VendorList: Page "27";
    begin
        IF NOT NoFiltersApplied THEN
          MarkVendorsByFilters(Vendor);

        VendorList.SETTABLEVIEW(Vendor);
        VendorList.SETRECORD(Vendor);
        VendorList.LOOKUPMODE := TRUE;
        IF VendorList.RUNMODAL = ACTION::LookupOK THEN
          VendorList.GETRECORD(Vendor)
        ELSE
          CLEAR(Vendor);

        EXIT(Vendor."No.");
    end;

    local procedure MarkVendorsByFilters(var Vendor: Record "23")
    begin
        IF Vendor.FINDSET THEN
          REPEAT
            Vendor.MARK(TRUE);
          UNTIL Vendor.NEXT = 0;
        IF Vendor.FINDFIRST THEN;
        Vendor.MARKEDONLY := TRUE;
    end;

    procedure OpenVendorLedgerEntries(FilterOnDueEntries: Boolean)
    var
        DetailedVendorLedgEntry: Record "380";
        VendorLedgerEntry: Record "25";
    begin
        DetailedVendorLedgEntry.SETRANGE("Vendor No.","No.");
        COPYFILTER("Global Dimension 1 Filter",DetailedVendorLedgEntry."Initial Entry Global Dim. 1");
        COPYFILTER("Global Dimension 2 Filter",DetailedVendorLedgEntry."Initial Entry Global Dim. 2");
        IF FilterOnDueEntries AND (GETFILTER("Date Filter") <> '') THEN BEGIN
          COPYFILTER("Date Filter",DetailedVendorLedgEntry."Initial Entry Due Date");
          DetailedVendorLedgEntry.SETFILTER("Posting Date",'<=%1',GETRANGEMAX("Date Filter"));
        END;
        COPYFILTER("Currency Filter",DetailedVendorLedgEntry."Currency Code");
        VendorLedgerEntry.DrillDownOnEntries(DetailedVendorLedgEntry);
    end;

    procedure SetInsertFromTemplate(FromTemplate: Boolean)
    begin
        InsertFromTemplate := FromTemplate;
    end;

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: Brick)".


    //Unsupported feature: Deletion (ParameterCollection) on "GetDefaultBankAcc(PROCEDURE 25).VendorBankAccount(Parameter 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "CalcOverDueBalance(PROCEDURE 8).VendLedgerEntry(Variable 1000)".


    var
        VATRegistrationLogMgt: Codeunit "249";

    var
        TempVend: Record "23" temporary;

    var
        SocialListeningSearchTopic: Record "871";
        CustomReportSelection: Record "9657";
        PurchOrderLine: Record "39";
        VATRegistrationLogMgt: Codeunit "249";

    var
        LeadTimeMgt: Codeunit "5404";
        ApprovalsMgmt: Codeunit "1535";

    var
        "--NSC1.00--": ;
        TextGestTiersPayeur001: Label 'Do you want to update Open Ledger entries with new Pay-to customer No. %1?';
        "-NSC1.01-": Integer;
        NaviSetup: Record "50004";
        SelectVendorErr: Label 'You must select an existing vendor.';
        CreateNewVendTxt: Label 'Create a new vendor card for %1.', Comment='%1 is the name to be used to create the customer. ';
        VendNotRegisteredTxt: Label 'This vendor is not registered. To continue, choose one of the following options:';
        SelectVendTxt: Label 'Select an existing vendor.';
        InsertFromTemplate: Boolean;
}

