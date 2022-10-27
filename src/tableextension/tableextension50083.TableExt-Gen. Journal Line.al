tableextension 50083 tableextension50083 extends "Gen. Journal Line"
{
    // <changelog>
    //   <add id="FR0001" dev="EDUBUC" date="2004-08-19" area="PAYMNG"  request="FR-START-40"
    //     releaseversion="FR4.00">Payment management system</add>
    //   <add id="FR0002" dev="EDUBUC" date="2004-08-19" area="REMIT"  request="FR-START-40"
    //     releaseversion="FR4.00">Check remittance report</add>
    //   <add id="FR0003" dev="EDUBUC" date="2004-08-19" area="SIMULATION"  request="FR-START-40"
    //     releaseversion="FR4.00">Simulation of entries</add>
    //   <change id="FR0004" dev="KCOOLS" date="2005-05-17" area="PAYMNG" feature="PS7850"
    //     baseversion="FR4.00" releaseversion="FR4.00.A">Code Optimization</change>
    //   <add id="FR0005" dev="KCOOLS" date="2005-11-18" area="BANKACC"  request="FR-START-40B"
    //     releaseversion="FR4.00.02">French Bank account number</add>
    //   <add id="FR0006" dev="KCOOLS" date="2006-04-05" area="FADD" feature="PS16097"
    //     releaseversion="FR4.00.03">Derogatory Depreciation</add>
    //   <change id="FR0007" dev="KCOOLS" date="2006-05-22" area="BANKACC" feature="PSCORS730"
    //     baseversion="FR4.00" releaseversion="FR5.00">Local Name/Address fields extended to 50 characters</change>
    //   <change id="FR0008" dev="KCOOLS" date="2008-06-18" area="PAYMNG" feature="NAVCORS25527"
    //     baseversion="FR4.00" releaseversion="FR6.00">Delayed Unrealized VAT</change>
    // </changelog>
    // 
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //REGLEMENT   STLA 01.08.2006 COR001 [13]                    Ajout du champ 50000 Mode de réglement
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ 50003
    // 
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    //           - Add fields 80800, 80802, 80804, 80805..80807
    // ------------------------------------------------------------------------

    //Unsupported feature: Property Insertion (Permissions) on ""Gen. Journal Line"(Table 81)".

    fields
    {
        modify("Account No.")
        {
            TableRelation = IF (Account Type=CONST(G/L Account)) "G/L Account" WHERE (Account Type=CONST(Posting),
                                                                                      Blocked=CONST(No))
                                                                                      ELSE IF (Account Type=CONST(Customer)) Customer
                                                                                      ELSE IF (Account Type=CONST(Vendor)) Vendor
                                                                                      ELSE IF (Account Type=CONST(Bank Account)) "Bank Account"
                                                                                      ELSE IF (Account Type=CONST(Fixed Asset)) "Fixed Asset"
                                                                                      ELSE IF (Account Type=CONST(IC Partner)) "IC Partner";
        }
        modify(Description)
        {
            Caption = 'Description';
        }
        modify("Bal. Account No.")
        {
            TableRelation = IF (Bal. Account Type=CONST(G/L Account)) "G/L Account" WHERE (Account Type=CONST(Posting),
                                                                                           Blocked=CONST(No))
                                                                                           ELSE IF (Bal. Account Type=CONST(Customer)) Customer
                                                                                           ELSE IF (Bal. Account Type=CONST(Vendor)) Vendor
                                                                                           ELSE IF (Bal. Account Type=CONST(Bank Account)) "Bank Account"
                                                                                           ELSE IF (Bal. Account Type=CONST(Fixed Asset)) "Fixed Asset"
                                                                                           ELSE IF (Bal. Account Type=CONST(IC Partner)) "IC Partner";
        }
        modify("Bill-to/Pay-to No.")
        {
            TableRelation = IF (Account Type=CONST(Customer)) Customer
                            ELSE IF (Bal. Account Type=CONST(Customer)) Customer
                            ELSE IF (Account Type=CONST(Vendor)) Vendor
                            ELSE IF (Bal. Account Type=CONST(Vendor)) Vendor;
        }
        modify("Posting Group")
        {
            TableRelation = IF (Account Type=CONST(Customer)) "Customer Posting Group"
                            ELSE IF (Account Type=CONST(Vendor)) "Vendor Posting Group"
                            ELSE IF (Account Type=CONST(Fixed Asset)) "FA Posting Group";
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

        //Unsupported feature: Property Modification (Data type) on ""Business Unit Code"(Field 50)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Allocated Amt. (LCY)"(Field 56)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Bank Payment Type"(Field 70)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Check Printed"(Field 75)".

        modify("Source No.")
        {
            TableRelation = IF (Source Type=CONST(Customer)) Customer
                            ELSE IF (Source Type=CONST(Vendor)) Vendor
                            ELSE IF (Source Type=CONST(Bank Account)) "Bank Account"
                            ELSE IF (Source Type=CONST(Fixed Asset)) "Fixed Asset";
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Source Currency Amount"(Field 100)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Source Curr. VAT Base Amount"(Field 101)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Source Curr. VAT Amount"(Field 102)".

        modify("Ship-to/Order Address Code")
        {
            TableRelation = IF (Account Type=CONST(Customer)) "Ship-to Address".Code WHERE (Customer No.=FIELD(Bill-to/Pay-to No.))
                            ELSE IF (Account Type=CONST(Vendor)) "Order Address".Code WHERE (Vendor No.=FIELD(Bill-to/Pay-to No.))
                            ELSE IF (Bal. Account Type=CONST(Customer)) "Ship-to Address".Code WHERE (Customer No.=FIELD(Bill-to/Pay-to No.))
                            ELSE IF (Bal. Account Type=CONST(Vendor)) "Order Address".Code WHERE (Vendor No.=FIELD(Bill-to/Pay-to No.));
        }
        modify("Sell-to/Buy-from No.")
        {
            TableRelation = IF (Account Type=CONST(Customer)) Customer
                            ELSE IF (Bal. Account Type=CONST(Customer)) Customer
                            ELSE IF (Account Type=CONST(Vendor)) Vendor
                            ELSE IF (Bal. Account Type=CONST(Vendor)) Vendor;
        }
        modify("Incoming Document Entry No.")
        {
            TableRelation = "Incoming Document";
        }
        modify("Recipient Bank Account")
        {
            TableRelation = IF (Account Type=CONST(Customer)) "Customer Bank Account".Code WHERE (Customer No.=FIELD(Account No.))
                            ELSE IF (Account Type=CONST(Vendor)) "Vendor Bank Account".Code WHERE (Vendor No.=FIELD(Account No.))
                            ELSE IF (Bal. Account Type=CONST(Customer)) "Customer Bank Account".Code WHERE (Customer No.=FIELD(Bal. Account No.))
                            ELSE IF (Bal. Account Type=CONST(Vendor)) "Vendor Bank Account".Code WHERE (Vendor No.=FIELD(Bal. Account No.));
        }

        //Unsupported feature: Property Modification (Data type) on ""Message to Recipient"(Field 289)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Has Payment Export Error"(Field 291)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Unit Price (LCY)"(Field 1002)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Total Price (LCY)"(Field 1003)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Quantity"(Field 1004)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Unit Cost (LCY)"(Field 1005)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Line Discount %"(Field 1006)".

        modify("Job Line Type")
        {
            OptionCaption = ' ,Budget,Billable,Both Budget and Billable';

            //Unsupported feature: Property Modification (OptionString) on ""Job Line Type"(Field 1009)".


            //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Line Type"(Field 1009)".

        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Unit Price"(Field 1010)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Total Price"(Field 1011)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Unit Cost"(Field 1012)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Total Cost"(Field 1013)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Line Discount Amount"(Field 1014)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Line Amount"(Field 1015)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Total Cost (LCY)"(Field 1016)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Line Amount (LCY)"(Field 1017)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Planning Line No."(Field 1020)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Job Remaining Qty."(Field 1030)".

        modify("Direct Debit Mandate ID")
        {
            Caption = 'Direct Debit Mandate ID';
        }
        modify("Posting Exch. Entry No.")
        {

            //Unsupported feature: Property Modification (Name) on ""Posting Exch. Entry No."(Field 1220)".

            TableRelation = "Data Exch.";
            Caption = 'Data Exch. Entry No.';
        }
        modify("Posting Exch. Line No.")
        {

            //Unsupported feature: Property Modification (Name) on ""Posting Exch. Line No."(Field 1223)".

            Caption = 'Data Exch. Line No.';
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""FA Posting Date"(Field 5600)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""FA Posting Type"(Field 5601)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Salvage Value"(Field 5603)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""No. of Depreciation Days"(Field 5604)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Depr. until FA Posting Date"(Field 5605)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Depr. Acquisition Cost"(Field 5606)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Use Duplication List"(Field 5613)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""FA Reclassification Entry"(Field 5614)".



        //Unsupported feature: Code Modification on ""Account Type"(Field 3).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Fixed Asset",
                                   "Account Type"::"IC Partner"]) AND
               ("Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Fixed Asset",
            #4..6
                Text000,
                FIELDCAPTION("Account Type"),FIELDCAPTION("Bal. Account Type"));
            VALIDATE("Account No.",'');
            VALIDATE("IC Partner G/L Acc. No.",'');
            IF "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account"] THEN BEGIN
              VALIDATE("Gen. Posting Type","Gen. Posting Type"::" ");
            #13..41
              END;
            IF "Account Type" <> "Account Type"::Customer THEN
              VALIDATE("Credit Card No.",'');
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..9
            VALIDATE(Description,'');
            #10..44

            VALIDATE("Deferral Code",'');
            */
        //end;


        //Unsupported feature: Code Modification on ""Account No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Account No." <> xRec."Account No." THEN BEGIN
              ClearAppliedAutomatically;
              VALIDATE("Job No.",'');
            END;

            IF xRec."Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"IC Partner"] THEN
              "IC Partner Code" := '';

            IF "Account No." = '' THEN BEGIN
              CleanLine;
              GetDerogatorySetup;
              EXIT;
            END;

            CASE "Account Type" OF
              "Account Type"::"G/L Account":
                BEGIN
                  GLAcc.GET("Account No.");
                  CheckGLAcc;
                  ReplaceInfo := "Bal. Account No." = '';
                  IF NOT ReplaceInfo THEN BEGIN
                    GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
                    ReplaceInfo := GenJnlBatch."Bal. Account No." <> '';
                  END;
                  IF ReplaceInfo THEN
                    UpdateDescription(GLAcc.Name);

                  IF ("Bal. Account No." = '') OR
                     ("Bal. Account Type" IN
                      ["Bal. Account Type"::"G/L Account","Bal. Account Type"::"Bank Account"])
                  THEN BEGIN
                    "Posting Group" := '';
                    "Salespers./Purch. Code" := '';
                    "Payment Terms Code" := '';
                  END;
                  IF "Bal. Account No." = '' THEN
                    "Currency Code" := '';
                  IF NOT GenJnlBatch.GET("Journal Template Name","Journal Batch Name") OR
                     GenJnlBatch."Copy VAT Setup to Jnl. Lines"
                  THEN BEGIN
                    "Gen. Posting Type" := GLAcc."Gen. Posting Type";
                    "Gen. Bus. Posting Group" := GLAcc."Gen. Bus. Posting Group";
                    "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
                    "VAT Bus. Posting Group" := GLAcc."VAT Bus. Posting Group";
                    "VAT Prod. Posting Group" := GLAcc."VAT Prod. Posting Group";
                  END;
                  "Tax Area Code" := GLAcc."Tax Area Code";
                  "Tax Liable" := GLAcc."Tax Liable";
                  "Tax Group Code" := GLAcc."Tax Group Code";
                  IF "Posting Date" <> 0D THEN
                    IF "Posting Date" = CLOSINGDATE("Posting Date") THEN
                      ClearPostingGroups;
                END;
              "Account Type"::Customer:
                BEGIN
                  Cust.GET("Account No.");
                  Cust.CheckBlockedCustOnJnls(Cust,"Document Type",FALSE);
                  IF Cust."IC Partner Code" <> '' THEN BEGIN
                    IF GenJnlTemplate.GET("Journal Template Name") THEN;
                    IF (Cust."IC Partner Code" <> '' ) AND ICPartner.GET(Cust."IC Partner Code") THEN BEGIN
                      ICPartner.CheckICPartnerIndirect(FORMAT("Account Type"),"Account No.");
                      "IC Partner Code" := Cust."IC Partner Code";
                    END;
                  END;
                  UpdateDescription(Cust.Name);
                  "Payment Method Code" := Cust."Payment Method Code";
                  VALIDATE("Recipient Bank Account",Cust."Preferred Bank Account");
                  "Posting Group" := Cust."Customer Posting Group";
                  "Salespers./Purch. Code" := Cust."Salesperson Code";
                  "Payment Terms Code" := Cust."Payment Terms Code";
                  VALIDATE("Bill-to/Pay-to No.","Account No.");
                  VALIDATE("Sell-to/Buy-from No.","Account No.");
                  IF NOT SetCurrencyCode("Bal. Account Type","Bal. Account No.") THEN
                    "Currency Code" := Cust."Currency Code";
                  ClearPostingGroups;
                  IF (Cust."Bill-to Customer No." <> '') AND (Cust."Bill-to Customer No." <> "Account No.") THEN BEGIN
                    OK := CONFIRM(Text014,FALSE,Cust.TABLECAPTION,Cust."No.",Cust.FIELDCAPTION("Bill-to Customer No."),
                        Cust."Bill-to Customer No.");
                    IF NOT OK THEN
                      ERROR('');
                  END;
                  VALIDATE("Payment Terms Code");
                  CheckPaymentTolerance;
                END;
              "Account Type"::Vendor:
                BEGIN
                  Vend.GET("Account No.");
                  Vend.CheckBlockedVendOnJnls(Vend,"Document Type",FALSE);
                  IF Vend."IC Partner Code" <> '' THEN BEGIN
                    IF GenJnlTemplate.GET("Journal Template Name") THEN;
                    IF (Vend."IC Partner Code" <> '') AND ICPartner.GET(Vend."IC Partner Code") THEN BEGIN
                      ICPartner.CheckICPartnerIndirect(FORMAT("Account Type"),"Account No.");
                      "IC Partner Code" := Vend."IC Partner Code";
                    END;
                  END;
                  UpdateDescription(Vend.Name);
                  "Payment Method Code" := Vend."Payment Method Code";
                  "Creditor No." := Vend."Creditor No.";
                  VALIDATE("Recipient Bank Account",Vend."Preferred Bank Account");
                  "Posting Group" := Vend."Vendor Posting Group";
                  "Salespers./Purch. Code" := Vend."Purchaser Code";
                  "Payment Terms Code" := Vend."Payment Terms Code";
                  VALIDATE("Bill-to/Pay-to No.","Account No.");
                  VALIDATE("Sell-to/Buy-from No.","Account No.");
                  IF NOT SetCurrencyCode("Bal. Account Type","Bal. Account No.") THEN
                    "Currency Code" := Vend."Currency Code";
                  ClearPostingGroups;
                  IF (Vend."Pay-to Vendor No." <> '') AND (Vend."Pay-to Vendor No." <> "Account No.") AND
                     NOT HideValidationDialog
                  THEN BEGIN
                    OK := CONFIRM(Text014,FALSE,Vend.TABLECAPTION,Vend."No.",Vend.FIELDCAPTION("Pay-to Vendor No."),
                        Vend."Pay-to Vendor No.");
                    IF NOT OK THEN
                      ERROR('');
                  END;
                  VALIDATE("Payment Terms Code");
                  CheckPaymentTolerance;
                END;
              "Account Type"::"Bank Account":
                BEGIN
                  BankAcc.GET("Account No.");
                  BankAcc.TESTFIELD(Blocked,FALSE);
                  ReplaceInfo := "Bal. Account No." = '';
                  IF NOT ReplaceInfo THEN BEGIN
                    GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
                    ReplaceInfo := GenJnlBatch."Bal. Account No." <> '';
                  END;
                  IF ReplaceInfo THEN
                    UpdateDescription(BankAcc.Name);
                  IF ("Bal. Account No." = '') OR
                     ("Bal. Account Type" IN
                      ["Bal. Account Type"::"G/L Account","Bal. Account Type"::"Bank Account"])
                  THEN BEGIN
                    "Posting Group" := '';
                    "Salespers./Purch. Code" := '';
                    "Payment Terms Code" := '';
                  END;
                  IF BankAcc."Currency Code" = '' THEN BEGIN
                    IF "Bal. Account No." = '' THEN
                      "Currency Code" := '';
                  END ELSE
                    IF SetCurrencyCode("Bal. Account Type","Bal. Account No.") THEN
                      BankAcc.TESTFIELD("Currency Code","Currency Code")
                    ELSE
                      "Currency Code" := BankAcc."Currency Code";
                  ClearPostingGroups;
                END;
              "Account Type"::"Fixed Asset":
                BEGIN
                  FA.GET("Account No.");
                  FA.TESTFIELD(Blocked,FALSE);
                  FA.TESTFIELD(Inactive,FALSE);
                  FA.TESTFIELD("Budgeted Asset",FALSE);
                  UpdateDescription(FA.Description);
                  IF "Depreciation Book Code" = '' THEN BEGIN
                    FASetup.GET;
                    "Depreciation Book Code" := FASetup."Default Depr. Book";
                    IF NOT FADeprBook.GET("Account No.","Depreciation Book Code") THEN
                      "Depreciation Book Code" := '';
                  END;
                  IF "Depreciation Book Code" <> '' THEN BEGIN
                    FADeprBook.GET("Account No.","Depreciation Book Code");
                    "Posting Group" := FADeprBook."FA Posting Group";
                  END;
                  GetFAVATSetup;
                  GetFAAddCurrExchRate;
                  GetDerogatorySetup;
                END;
              "Account Type"::"IC Partner":
                BEGIN
                  ICPartner.GET("Account No.");
                  ICPartner.CheckICPartner;
                  UpdateDescription(ICPartner.Name);
                  IF ("Bal. Account No." = '') OR ("Bal. Account Type" = "Bal. Account Type"::"G/L Account") THEN
                    "Currency Code" := ICPartner."Currency Code";
                  IF ("Bal. Account Type" = "Bal. Account Type"::"Bank Account") AND ("Currency Code" = '') THEN
                    "Currency Code" := ICPartner."Currency Code";
                  ClearPostingGroups;
                  "IC Partner Code" := "Account No.";
                END;
            END;

            VALIDATE("Currency Code");
            VALIDATE("VAT Prod. Posting Group");
            UpdateLineBalance;
            UpdateSource;
            CreateDim(
              DimMgt.TypeToTableID1("Account Type"),"Account No.",
              DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
              DATABASE::Job,"Job No.",
              DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
              DATABASE::Campaign,"Campaign No.");

            VALIDATE("IC Partner G/L Acc. No.",GetDefaultICPartnerGLAccNo);
            ValidateApplyRequirements(Rec);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..16
                GetGLAccount;
              "Account Type"::Customer:
                GetCustomerAccount;
              "Account Type"::Vendor:
                GetVendorAccount;
              "Account Type"::"Bank Account":
                GetBankAccount;
              "Account Type"::"Fixed Asset":
                GetFAAccount;
              "Account Type"::"IC Partner":
                GetICPartnerAccount;
            #181..195
            */
        //end;


        //Unsupported feature: Code Modification on ""Posting Date"(Field 5).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            VALIDATE("Document Date","Posting Date");
            VALIDATE("Currency Code");

            #4..8
            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine;
              UpdatePricesFromJobJnlLine;
            END
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..11
            END;

            IF "Deferral Code" <> '' THEN
              VALIDATE("Deferral Code");
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Document Type"(Field 6).OnValidate".

        //trigger (Variable: Cust)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;

        //Unsupported feature: Deletion on ""Document No."(Field 7).OnValidate".



        //Unsupported feature: Code Modification on ""VAT %"(Field 10).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            GetCurrency;
            CASE "VAT Calculation Type" OF
              "VAT Calculation Type"::"Normal VAT",
            #4..43
            "VAT Base Amount (LCY)" := "Amount (LCY)" - "VAT Amount (LCY)";

            UpdateSalesPurchLCY;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..46

            IF "Deferral Code" <> '' THEN
              VALIDATE("Deferral Code");
            */
        //end;


        //Unsupported feature: Code Modification on ""Bal. Account No."(Field 11).OnValidate".

        //trigger  Account No()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            VALIDATE("Job No.",'');

            IF xRec."Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,
                                            "Bal. Account Type"::"IC Partner"]
            THEN
              "IC Partner Code" := '';

            IF "Bal. Account No." = '' THEN BEGIN
              UpdateLineBalance;
              UpdateSource;
              CreateDim(
                DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
                DimMgt.TypeToTableID1("Account Type"),"Account No.",
                DATABASE::Job,"Job No.",
                DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
                DATABASE::Campaign,"Campaign No.");
              IF NOT ("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor]) THEN
                "Recipient Bank Account" := '';
              IF xRec."Bal. Account No." <> '' THEN BEGIN
                ClearBalancePostingGroups;
                "Bal. Tax Area Code" := '';
                "Bal. Tax Liable" := FALSE;
                "Bal. Tax Group Code" := '';
              END;
              EXIT;
            END;

            CASE "Bal. Account Type" OF
              "Bal. Account Type"::"G/L Account":
                BEGIN
                  GLAcc.GET("Bal. Account No.");
                  CheckGLAcc;
                  IF "Account No." = '' THEN BEGIN
                    Description := GLAcc.Name;
                    "Currency Code" := '';
                  END;
                  IF ("Account No." = '') OR
                     ("Account Type" IN
                      ["Account Type"::"G/L Account","Account Type"::"Bank Account"])
                  THEN BEGIN
                    "Posting Group" := '';
                    "Salespers./Purch. Code" := '';
                    "Payment Terms Code" := '';
                  END;
                  IF NOT GenJnlBatch.GET("Journal Template Name","Journal Batch Name") OR
                     GenJnlBatch."Copy VAT Setup to Jnl. Lines"
                  THEN BEGIN
                    "Bal. Gen. Posting Type" := GLAcc."Gen. Posting Type";
                    "Bal. Gen. Bus. Posting Group" := GLAcc."Gen. Bus. Posting Group";
                    "Bal. Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
                    "Bal. VAT Bus. Posting Group" := GLAcc."VAT Bus. Posting Group";
                    "Bal. VAT Prod. Posting Group" := GLAcc."VAT Prod. Posting Group";
                  END;
                  "Bal. Tax Area Code" := GLAcc."Tax Area Code";
                  "Bal. Tax Liable" := GLAcc."Tax Liable";
                  "Bal. Tax Group Code" := GLAcc."Tax Group Code";
                  IF "Posting Date" <> 0D THEN
                    IF "Posting Date" = CLOSINGDATE("Posting Date") THEN
                      ClearBalancePostingGroups;
                END;
              "Bal. Account Type"::Customer:
                BEGIN
                  Cust.GET("Bal. Account No.");
                  Cust.CheckBlockedCustOnJnls(Cust,"Document Type",FALSE);
                  IF Cust."IC Partner Code" <> '' THEN BEGIN
                    IF GenJnlTemplate.GET("Journal Template Name") THEN;
                    IF (Cust."IC Partner Code" <> '') AND ICPartner.GET(Cust."IC Partner Code") THEN BEGIN
                      ICPartner.CheckICPartnerIndirect(FORMAT("Bal. Account Type"),"Bal. Account No.");
                      "IC Partner Code" := Cust."IC Partner Code";
                    END;
                  END;

                  IF "Account No." = '' THEN
                    Description := Cust.Name;

                  VALIDATE("Recipient Bank Account",Cust."Preferred Bank Account");
                  "Posting Group" := Cust."Customer Posting Group";
                  "Salespers./Purch. Code" := Cust."Salesperson Code";
                  "Payment Terms Code" := Cust."Payment Terms Code";
                  VALIDATE("Bill-to/Pay-to No.","Bal. Account No.");
                  VALIDATE("Sell-to/Buy-from No.","Bal. Account No.");
                  IF ("Account No." = '') OR ("Account Type" = "Account Type"::"G/L Account") THEN
                    "Currency Code" := Cust."Currency Code";
                  IF ("Account Type" = "Account Type"::"Bank Account") AND ("Currency Code" = '') THEN
                    "Currency Code" := Cust."Currency Code";
                  ClearBalancePostingGroups;
                  IF (Cust."Bill-to Customer No." <> '') AND (Cust."Bill-to Customer No." <> "Bal. Account No.") THEN BEGIN
                    OK := CONFIRM(Text014,FALSE,Cust.TABLECAPTION,Cust."No.",Cust.FIELDCAPTION("Bill-to Customer No."),
                        Cust."Bill-to Customer No.");
                    IF NOT OK THEN
                      ERROR('');
                  END;
                  VALIDATE("Payment Terms Code");
                  CheckPaymentTolerance;
                END;
              "Bal. Account Type"::Vendor:
                BEGIN
                  Vend.GET("Bal. Account No.");
                  Vend.CheckBlockedVendOnJnls(Vend,"Document Type",FALSE);
                  IF Vend."IC Partner Code" <> '' THEN BEGIN
                    IF GenJnlTemplate.GET("Journal Template Name") THEN;
                    IF (Vend."IC Partner Code" <> '') AND ICPartner.GET(Vend."IC Partner Code") THEN BEGIN
                      ICPartner.CheckICPartnerIndirect(FORMAT("Bal. Account Type"),"Bal. Account No.");
                      "IC Partner Code" := Vend."IC Partner Code";
                    END;
                  END;

                  IF "Account No." = '' THEN
                    Description := Vend.Name;

                  VALIDATE("Recipient Bank Account",Vend."Preferred Bank Account");
                  "Posting Group" := Vend."Vendor Posting Group";
                  "Salespers./Purch. Code" := Vend."Purchaser Code";
                  "Payment Terms Code" := Vend."Payment Terms Code";
                  VALIDATE("Bill-to/Pay-to No.","Bal. Account No.");
                  VALIDATE("Sell-to/Buy-from No.","Bal. Account No.");
                  IF ("Account No." = '') OR ("Account Type" = "Account Type"::"G/L Account") THEN
                    "Currency Code" := Vend."Currency Code";
                  IF ("Account Type" = "Account Type"::"Bank Account") AND ("Currency Code" = '') THEN
                    "Currency Code" := Vend."Currency Code";
                  ClearBalancePostingGroups;
                  IF (Vend."Pay-to Vendor No." <> '') AND (Vend."Pay-to Vendor No." <> "Bal. Account No.") THEN BEGIN
                    OK := CONFIRM(Text014,FALSE,Vend.TABLECAPTION,Vend."No.",Vend.FIELDCAPTION("Pay-to Vendor No."),
                        Vend."Pay-to Vendor No.");
                    IF NOT OK THEN
                      ERROR('');
                  END;
                  VALIDATE("Payment Terms Code");
                  CheckPaymentTolerance;
                END;
              "Bal. Account Type"::"Bank Account":
                BEGIN
                  BankAcc.GET("Bal. Account No.");
                  BankAcc.TESTFIELD(Blocked,FALSE);
                  IF "Account No." = '' THEN
                    Description := BankAcc.Name;

                  IF ("Account No." = '') OR
                     ("Account Type" IN
                      ["Account Type"::"G/L Account","Account Type"::"Bank Account"])
                  THEN BEGIN
                    "Posting Group" := '';
                    "Salespers./Purch. Code" := '';
                    "Payment Terms Code" := '';
                  END;
                  IF BankAcc."Currency Code" = '' THEN BEGIN
                    IF "Account No." = '' THEN
                      "Currency Code" := '';
                  END ELSE
                    IF SetCurrencyCode("Bal. Account Type","Bal. Account No.") THEN
                      BankAcc.TESTFIELD("Currency Code","Currency Code")
                    ELSE
                      "Currency Code" := BankAcc."Currency Code";
                  ClearBalancePostingGroups;
                END;
              "Bal. Account Type"::"Fixed Asset":
                BEGIN
                  FA.GET("Bal. Account No.");
                  FA.TESTFIELD(Blocked,FALSE);
                  FA.TESTFIELD(Inactive,FALSE);
                  FA.TESTFIELD("Budgeted Asset",FALSE);
                  IF "Account No." = '' THEN
                    Description := FA.Description;

                  IF "Depreciation Book Code" = '' THEN BEGIN
                    FASetup.GET;
                    "Depreciation Book Code" := FASetup."Default Depr. Book";
                    IF NOT FADeprBook.GET("Bal. Account No.","Depreciation Book Code") THEN
                      "Depreciation Book Code" := '';
                  END;
                  IF "Depreciation Book Code" <> '' THEN BEGIN
                    FADeprBook.GET("Bal. Account No.","Depreciation Book Code");
                    "Posting Group" := FADeprBook."FA Posting Group";
                  END;
                  GetFAVATSetup;
                  GetFAAddCurrExchRate;
                END;
              "Bal. Account Type"::"IC Partner":
                BEGIN
                  ICPartner.GET("Bal. Account No.");
                  IF "Account No." = '' THEN
                    Description := ICPartner.Name;

                  IF ("Account No." = '') OR ("Account Type" = "Account Type"::"G/L Account") THEN
                    "Currency Code" := ICPartner."Currency Code";
                  IF ("Account Type" = "Account Type"::"Bank Account") AND ("Currency Code" = '') THEN
                    "Currency Code" := ICPartner."Currency Code";
                  ClearBalancePostingGroups;
                  "IC Partner Code" := "Bal. Account No.";
                END;
            END;

            VALIDATE("Currency Code");
            VALIDATE("Bal. VAT Prod. Posting Group");
            UpdateLineBalance;
            UpdateSource;
            CreateDim(
              DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
              DimMgt.TypeToTableID1("Account Type"),"Account No.",
              DATABASE::Job,"Job No.",
              DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
              DATABASE::Campaign,"Campaign No.");

            VALIDATE("IC Partner G/L Acc. No.",GetDefaultICPartnerGLAccNo);
            ValidateApplyRequirements(Rec);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..29
                GetGLBalAccount;
              "Bal. Account Type"::Customer:
                GetCustomerBalAccount;
              "Bal. Account Type"::Vendor:
                GetVendorBalAccount;
              "Bal. Account Type"::"Bank Account":
                GetBankBalAccount;
              "Bal. Account Type"::"Fixed Asset":
                GetFABalAccount;
              "Bal. Account Type"::"IC Partner":
                GetICPartnerBalAccount;
            #191..205
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Currency Code"(Field 12).OnValidate".

        //trigger (Variable: BankAcc)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Currency Code"(Field 12).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Bal. Account Type" = "Bal. Account Type"::"Bank Account" THEN BEGIN
              IF BankAcc3.GET("Bal. Account No.") AND (BankAcc3."Currency Code" <> '')THEN
                BankAcc3.TESTFIELD("Currency Code","Currency Code");
            END;
            IF "Account Type" = "Account Type"::"Bank Account" THEN BEGIN
              IF BankAcc3.GET("Account No.") AND (BankAcc3."Currency Code" <> '') THEN
                BankAcc3.TESTFIELD("Currency Code","Currency Code");
            END;
            IF ("Recurring Method" IN
                ["Recurring Method"::"B  Balance","Recurring Method"::"RB Reversing Balance"]) AND
            #11..29
            IF NOT CustVendAccountNosModified THEN
              IF ("Currency Code" <> xRec."Currency Code") AND (Amount <> 0) THEN
                PaymentToleranceMgt.PmtTolGenJnl(Rec);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF "Bal. Account Type" = "Bal. Account Type"::"Bank Account" THEN BEGIN
              IF BankAcc.GET("Bal. Account No.") AND (BankAcc."Currency Code" <> '')THEN
                BankAcc.TESTFIELD("Currency Code","Currency Code");
            END;
            IF "Account Type" = "Account Type"::"Bank Account" THEN BEGIN
              IF BankAcc.GET("Account No.") AND (BankAcc."Currency Code" <> '') THEN
                BankAcc.TESTFIELD("Currency Code","Currency Code");
            #8..32
            */
        //end;


        //Unsupported feature: Code Modification on "Amount(Field 13).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            GetCurrency;
            IF "Currency Code" = '' THEN
              "Amount (LCY)" := Amount
            #4..21
            VALIDATE("VAT %");
            VALIDATE("Bal. VAT %");
            UpdateLineBalance;

            IF Amount <> xRec.Amount THEN BEGIN
              IF ("Applies-to Doc. No." <> '') OR ("Applies-to ID" <> '') THEN
            #28..33
              UpdatePricesFromJobJnlLine;
            END;

            GetDerogatorySetup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..24
            IF "Deferral Code" <> '' THEN
              VALIDATE("Deferral Code");
            #25..36
            // FR0006.begin
            GetDerogatorySetup;
            // FR0006.end
            */
        //end;


        //Unsupported feature: Code Modification on ""Applies-to Doc. No."(Field 36).OnLookup".

        //trigger  No()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            xRec.Amount := Amount;
            xRec."Currency Code" := "Currency Code";
            xRec."Posting Date" := "Posting Date";

            GetAccTypeAndNo(AccType,AccNo);
            CLEAR(CustLedgEntry);
            CLEAR(VendLedgEntry);

            #9..11
              AccType::Vendor:
                LookUpAppliesToDocVend(AccNo);
            END;

            IF Amount <> 0 THEN
              IF NOT PaymentToleranceMgt.PmtTolGenJnl(Rec) THEN
                EXIT;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
            GetAccTypeAndNo(Rec,AccType,AccNo);
            #6..14
            SetJournalLineFieldsFromApplication;

            IF xRec.Amount <> 0 THEN
              IF NOT PaymentToleranceMgt.PmtTolGenJnl(Rec) THEN
                EXIT;
            */
        //end;


        //Unsupported feature: Code Modification on ""Applies-to Doc. No."(Field 36).OnValidate".

        //trigger  No()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ("Applies-to Doc. No." = '') AND (xRec."Applies-to Doc. No." <> '') THEN BEGIN
              PaymentToleranceMgt.DelPmtTolApllnDocNo(Rec,xRec."Applies-to Doc. No.");

            #4..34
                      VendLedgEntry."Amount to Apply" := 0;
                      CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",VendLedgEntry);
                    END;
                  END;
                  "Exported to Payment File" := VendLedgEntry."Exported to Payment File";
                  "Applies-to Ext. Doc. No." := '';
                END;
            END;
            #43..57

            ValidateApplyRequirements(Rec);
            SetJournalLineFieldsFromApplication;

            GetCreditCard;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF "Applies-to Doc. No." <> xRec."Applies-to Doc. No." THEN
              ClearCustVendApplnEntry;

            #1..37
                    "Exported to Payment File" := VendLedgEntry."Exported to Payment File";
                  END;
            #40..60
            */
        //end;


        //Unsupported feature: Code Modification on ""VAT Amount"(Field 44).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
            GenJnlBatch.TESTFIELD("Allow VAT Difference",TRUE);
            IF NOT ("VAT Calculation Type" IN
            #4..40
            "VAT Base Amount (LCY)" := "Amount (LCY)" - "VAT Amount (LCY)";

            UpdateSalesPurchLCY;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..43

            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine;
              UpdatePricesFromJobJnlLine;
            END;

            IF "Deferral Code" <> '' THEN
              VALIDATE("Deferral Code");
            */
        //end;


        //Unsupported feature: Code Modification on ""Gen. Posting Type"(Field 57).OnValidate".

        //trigger  Posting Type"(Field 57)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account"] THEN
              TESTFIELD("Gen. Posting Type","Gen. Posting Type"::" ");
            IF ("Gen. Posting Type" = "Gen. Posting Type"::Settlement) AND (CurrFieldNo <> 0) THEN
              ERROR(Text006,"Gen. Posting Type");
            CheckVATInAlloc;
            IF "Gen. Posting Type" > 0 THEN
              VALIDATE("VAT Prod. Posting Group");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..7
            IF "Gen. Posting Type" <> "Gen. Posting Type"::Purchase THEN
              VALIDATE("Use Tax",FALSE)
            */
        //end;


        //Unsupported feature: Code Modification on ""Bal. Gen. Posting Type"(Field 64).OnValidate".

        //trigger  Gen()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Bank Account"] THEN
              TESTFIELD("Bal. Gen. Posting Type","Bal. Gen. Posting Type"::" ");
            IF ("Bal. Gen. Posting Type" = "Gen. Posting Type"::Settlement) AND (CurrFieldNo <> 0) THEN
            #4..10
              "Depreciation Book Code" := '';
              VALIDATE("FA Posting Type","FA Posting Type"::" ");
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..13
            IF "Bal. Gen. Posting Type" <> "Bal. Gen. Posting Type"::Purchase THEN
              VALIDATE("Bal. Use Tax",FALSE);
            */
        //end;


        //Unsupported feature: Code Modification on ""Use Tax"(Field 85).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Gen. Posting Type","Gen. Posting Type"::Purchase);
            VALIDATE("VAT %");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF NOT "Use Tax" THEN
              EXIT;
            TESTFIELD("Gen. Posting Type","Gen. Posting Type"::Purchase);
            VALIDATE("VAT %");
            */
        //end;


        //Unsupported feature: Code Modification on ""Bal. Use Tax"(Field 89).OnValidate".

        //trigger  Use Tax"(Field 89)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Bal. Gen. Posting Type","Bal. Gen. Posting Type"::Purchase);
            VALIDATE("Bal. VAT %");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF NOT "Bal. Use Tax" THEN
              EXIT;
            TESTFIELD("Bal. Gen. Posting Type","Bal. Gen. Posting Type"::Purchase);
            VALIDATE("Bal. VAT %");
            */
        //end;


        //Unsupported feature: Code Modification on ""IC Partner G/L Acc. No."(Field 116).OnValidate".

        //trigger  No()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "IC Partner G/L Acc. No." <> '' THEN BEGIN
              GetTemplate;
              GenJnlTemplate.TESTFIELD(Type,GenJnlTemplate.Type::Intercompany);
              IF ICGLAccount.GET("IC Partner G/L Acc. No.") THEN
                ICGLAccount.TESTFIELD(Blocked,FALSE);
            END
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF "Journal Template Name" <> '' THEN
              IF "IC Partner G/L Acc. No." <> '' THEN BEGIN
                GetTemplate;
                GenJnlTemplate.TESTFIELD(Type,GenJnlTemplate.Type::Intercompany);
                IF ICGLAccount.GET("IC Partner G/L Acc. No.") THEN
                  ICGLAccount.TESTFIELD(Blocked,FALSE);
              END
            */
        //end;


        //Unsupported feature: Code Modification on ""Incoming Document Entry No."(Field 165).OnValidate".

        //trigger "(Field 165)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IncomingDocument.SetGenJournalLine(Rec);
            IF Description = '' THEN
              Description := COPYSTR(IncomingDocument.Description,1,MAXSTRLEN(Description));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF Description = '' THEN
              Description := COPYSTR(IncomingDocument.Description,1,MAXSTRLEN(Description));
            IF "Incoming Document Entry No." = xRec."Incoming Document Entry No." THEN
              EXIT;

            IF "Incoming Document Entry No." = 0 THEN
              IncomingDocument.RemoveReferenceToWorkingDocument(xRec."Incoming Document Entry No.")
            ELSE
              IncomingDocument.SetGenJournalLine(Rec);
            */
        //end;

        //Unsupported feature: Deletion on ""Creditor No."(Field 170).OnValidate".



        //Unsupported feature: Code Modification on ""Recipient Bank Account"(Field 288).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ("Recipient Bank Account" <> '') AND ("Creditor No." <> '') THEN
              FIELDERROR("Creditor No.",
                STRSUBSTNO(FieldIsNotEmptyErr,FIELDCAPTION("Recipient Bank Account"),FIELDCAPTION("Creditor No.")));
            IF "Account Type" = "Account Type"::Customer THEN
              IF CustBankAcc.GET("Account No.","Recipient Bank Account") THEN
                "Bank Account Name" := CustBankAcc.Name
            #7..10
                "Bank Account Name" := VendBankAcc.Name
              ELSE
                "Bank Account Name" := '';
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #4..13

            IF "Recipient Bank Account" = '' THEN
              EXIT;
            IF ("Document Type" = "Document Type"::Invoice) AND
               (("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor]) OR
                ("Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor]))
            THEN
              "Recipient Bank Account" := '';
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

        //Unsupported feature: Deletion on ""Credit Card No."(Field 827).OnValidate".


        //Unsupported feature: Property Deletion (TableRelation) on ""Credit Card No."(Field 827)".



        //Unsupported feature: Code Modification on ""Job Task No."(Field 1001).OnValidate".

        //trigger "(Field 1001)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Job Task No." <> xRec."Job Task No." THEN
              VALIDATE("Job Planning Line No.",0);
            IF "Job Task No." = '' THEN BEGIN
            #4..22

            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine;
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..25
              CopyDimensionsFromJobTaskLine;
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Job Line Discount %"(Field 1006).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine;
              JobJnlLine.VALIDATE("Line Discount %","Job Line Discount %");
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine;
              TempJobJnlLine.VALIDATE("Line Discount %","Job Line Discount %");
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Job Line Disc. Amount (LCY)"(Field 1007).OnValidate".

        //trigger  Amount (LCY)"(Field 1007)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine;
              JobJnlLine.VALIDATE("Line Discount Amount (LCY)","Job Line Disc. Amount (LCY)");
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine;
              TempJobJnlLine.VALIDATE("Line Discount Amount (LCY)","Job Line Disc. Amount (LCY)");
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Job Unit Price"(Field 1010).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine;
              JobJnlLine.VALIDATE("Unit Price","Job Unit Price");
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine;
              TempJobJnlLine.VALIDATE("Unit Price","Job Unit Price");
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Job Line Discount Amount"(Field 1014).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine;
              JobJnlLine.VALIDATE("Line Discount Amount","Job Line Discount Amount");
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine;
              TempJobJnlLine.VALIDATE("Line Discount Amount","Job Line Discount Amount");
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Job Line Amount"(Field 1015).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine;
              JobJnlLine.VALIDATE("Line Amount","Job Line Amount");
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine;
              TempJobJnlLine.VALIDATE("Line Amount","Job Line Amount");
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Job Line Amount (LCY)"(Field 1017).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine;
              JobJnlLine.VALIDATE("Line Amount (LCY)","Job Line Amount (LCY)");
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF JobTaskIsSet THEN BEGIN
              CreateTempJobJnlLine;
              TempJobJnlLine.VALIDATE("Line Amount (LCY)","Job Line Amount (LCY)");
              UpdatePricesFromJobJnlLine;
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""FA Posting Type"(Field 5601).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF  NOT (("Account Type" = "Account Type"::"Fixed Asset") OR
                     ("Bal. Account Type" = "Bal. Account Type"::"Fixed Asset")) AND
               ("FA Posting Type" = "FA Posting Type"::" ")
            #4..22
            GetFAVATSetup;
            GetFAAddCurrExchRate;

            GetDerogatorySetup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..25
            // FR0006.begin
            GetDerogatorySetup;
            // FR0006.end
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Depreciation Book Code"(Field 5602).OnValidate".

        //trigger (Variable: FADeprBook)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Budgeted FA No."(Field 5611).OnValidate".

        //trigger (Variable: FA)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;
        field(1700;"Deferral Code";Code[10])
        {
            Caption = 'Deferral Code';
            TableRelation = "Deferral Template"."Deferral Code";

            trigger OnValidate()
            var
                DeferralUtilities: Codeunit "1720";
            begin
                IF "Deferral Code" <> '' THEN
                  TESTFIELD("Account Type","Account Type"::"G/L Account");

                DeferralUtilities.DeferralCodeOnValidate("Deferral Code",DeferralDocType::"G/L","Journal Template Name","Journal Batch Name",
                  0,'',"Line No.",GetDeferralAmount,"Posting Date",Description,"Currency Code");
            end;
        }
        field(1701;"Deferral Line No.";Integer)
        {
            Caption = 'Deferral Line No.';
        }
        field(50000;PaymentMethodCode;Code[10])
        {
            Caption = 'Payment Method Code';
            Description = 'REGLEMENT STLA 01.08.2006 COR001 [13]';
            TableRelation = "Payment Method";
        }
        field(50003;"Pay-to No.";Code[20])
        {
            Caption = 'Pay-to No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
        }
        field(80800;"DEEE Category Code";Code[10])
        {
            Caption = 'DEEE Category Code';
            Description = 'DEEE1.00';
            TableRelation = "Categories of item".Category;
        }
        field(80802;"DEEE HT Amount";Decimal)
        {
            Caption = 'DEEE HT Amount';
            Description = 'DEEE1.00 onvalidate';
            Editable = false;

            trigger OnValidate()
            var
                Currency2: Record "4";
            begin
            end;
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


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CheckNoCardTransactEntryExist(Rec);

        TESTFIELD("Check Printed",FALSE);

        ClearCustVendApplnEntry;
        ClearAppliedGenJnlLine;
        DeletePaymentFileErrors;
        ClearPostExchangeEntries;

        GenJnlAlloc.SETRANGE("Journal Template Name","Journal Template Name");
        GenJnlAlloc.SETRANGE("Journal Batch Name","Journal Batch Name");
        GenJnlAlloc.SETRANGE("Journal Line No.","Line No.");
        GenJnlAlloc.DELETEALL;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ApprovalsMgmt.OnCancelGeneralJournalLineApprovalRequest(Rec);
        #2..7
        ClearDataExchangeEntries(FALSE);
        #9..13

        DeferralUtilities.DeferralCodeOnDelete(
          DeferralDocType::"G/L",
          "Journal Template Name",
          "Journal Batch Name",0,'',"Line No.");

        VALIDATE("Incoming Document Entry No.",0);
        */
    //end;


    //Unsupported feature: Code Modification on "OnRename".

    //trigger OnRename()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CheckNoCardTransactEntryExist(Rec);
        TESTFIELD("Check Printed",FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ApprovalsMgmt.RenameApprovalEntries(xRec.RECORDID,RECORDID);

        TESTFIELD("Check Printed",FALSE);
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateLineBalance(PROCEDURE 2)".

    //procedure UpdateLineBalance();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ((Amount > 0) AND (NOT Correction)) OR
           ((Amount < 0) AND Correction)
        THEN BEGIN
        #4..21
        GenJnlAlloc.UpdateAllocations(Rec);

        UpdateSalesPurchLCY;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..24

        IF ("Deferral Code" <> '') AND (Amount <> xRec.Amount) AND ((Amount <> 0) AND (xRec.Amount <> 0)) THEN
          VALIDATE("Deferral Code");
        */
    //end;


    //Unsupported feature: Code Modification on "SetUpNewLine(PROCEDURE 9)".

    //procedure SetUpNewLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GenJnlTemplate.GET("Journal Template Name");
        GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
        GenJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
        #4..9
             (Balance - LastGenJnlLine."Balance (LCY)" = 0) AND
             NOT LastGenJnlLine.EmptyLine
          THEN
            "Document No." := INCSTR("Document No.");
        END ELSE BEGIN
          "Posting Date" := WORKDATE;
          "Document Date" := WORKDATE;
        #17..20
        END;
        IF GenJnlTemplate.Recurring THEN
          "Recurring Method" := LastGenJnlLine."Recurring Method";
        "Account Type" := LastGenJnlLine."Account Type";
        "Document Type" := LastGenJnlLine."Document Type";
        "Source Code" := GenJnlTemplate."Source Code";
        "Reason Code" := GenJnlBatch."Reason Code";
        "Posting No. Series" := GenJnlBatch."Posting No. Series";
        #29..32
          "Account Type" := "Account Type"::"G/L Account";
        VALIDATE("Bal. Account No.",GenJnlBatch."Bal. Account No.");
        Description := '';
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..12
            IncrementDocumentNo;
        #14..23
        CASE GenJnlTemplate.Type OF
          GenJnlTemplate.Type::Payments:
            BEGIN
              "Account Type" := "Account Type"::Vendor;
              "Document Type" := "Document Type"::Payment;
            END;
          ELSE BEGIN
            "Account Type" := LastGenJnlLine."Account Type";
            "Document Type" := LastGenJnlLine."Document Type";
          END;
        END;
        #26..35
        IF GenJnlBatch."Suggest Balancing Amount" THEN
          SuggestBalancingAmount(LastGenJnlLine,BottomLine);
        */
    //end;


    //Unsupported feature: Code Modification on "RenumberDocumentNo(PROCEDURE 68)".

    //procedure RenumberDocumentNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
        IF GenJnlBatch."No. Series" = '' THEN
          EXIT;
        #4..25
        RenumberDocNoOnLines(DocNo,GenJnlLine2);

        GET("Journal Template Name","Journal Batch Name","Line No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TESTFIELD("Check Printed",FALSE);

        #1..28
        */
    //end;


    //Unsupported feature: Code Modification on "RenumberDocNoOnLines(PROCEDURE 69)".

    //procedure RenumberDocNoOnLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        FirstDocNo := DocNo;
        WITH GenJnlLine2 DO BEGIN
          SETCURRENTKEY("Journal Template Name","Journal Batch Name","Document No.");
        #4..8
            REPEAT
              IF "Document No." = FirstDocNo THEN
                EXIT;
              IF NOT First AND ("Document No." <> PrevDocNo) AND NOT LastGenJnlLine.EmptyLine THEN
                DocNo := INCSTR(DocNo);
              PrevDocNo := "Document No.";
              IF ("Applies-to ID" <> '') AND ("Applies-to ID" = "Document No.") THEN
                RenumberAppliesToID(GenJnlLine2,"Document No.",DocNo);
              RenumberAppliesToDocNo(GenJnlLine2,"Document No.",DocNo);
              GenJnlLine3.GET("Journal Template Name","Journal Batch Name","Line No.");
              GenJnlLine3."Document No." := DocNo;
              GenJnlLine3.MODIFY;
              First := FALSE;
              LastGenJnlLine := GenJnlLine2
            UNTIL NEXT = 0
          END
        END
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..11
              IF NOT First AND (("Document No." <> PrevDocNo) OR ("Bal. Account No." <> '')) AND NOT LastGenJnlLine.EmptyLine THEN
                DocNo := INCSTR(DocNo);
              PrevDocNo := "Document No.";
              IF "Document No." <> '' THEN BEGIN
                IF "Applies-to ID" = "Document No." THEN
                  RenumberAppliesToID(GenJnlLine2,"Document No.",DocNo);
                RenumberAppliesToDocNo(GenJnlLine2,"Document No.",DocNo);
              END;
        #18..25
        */
    //end;


    //Unsupported feature: Code Modification on "RenumberAppliesToID(PROCEDURE 70)".

    //procedure RenumberAppliesToID();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetAccTypeAndNo(AccType,AccNo);
        CASE AccType OF
          "Account Type"::Customer:
            BEGIN
        #5..26
        END;
        GenJnlLine2."Applies-to ID" := NewAppliesToID;
        GenJnlLine2.MODIFY;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetAccTypeAndNo(GenJnlLine2,AccType,AccNo);
        #2..29
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: BankAcc) (VariableCollection) on "SetCurrencyCode(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "SetCurrencyCode(PROCEDURE 4)".

    //procedure SetCurrencyCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Currency Code" := '';
        IF AccNo2 <> '' THEN
          IF AccType2 = AccType2::"Bank Account" THEN
            IF BankAcc2.GET(AccNo2) THEN
              "Currency Code" := BankAcc2."Currency Code";
        EXIT("Currency Code" <> '');
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
            IF BankAcc.GET(AccNo2) THEN
              "Currency Code" := BankAcc."Currency Code";
        EXIT("Currency Code" <> '');
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: GLAcc) (ParameterCollection) on "CheckGLAcc(PROCEDURE 7)".


    //Unsupported feature: Variable Insertion (Variable: FADeprBook) (VariableCollection) on "GetFAAddCurrExchRate(PROCEDURE 8)".



    //Unsupported feature: Code Modification on "ClearCustVendApplnEntry(PROCEDURE 11)".

    //procedure ClearCustVendApplnEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetAccTypeAndNo(AccType,AccNo);
        CASE AccType OF
          AccType::Customer:
            IF "Applies-to ID" <> '' THEN BEGIN
              IF FindFirstCustLedgEntryWithAppliesToID(AccNo) THEN BEGIN
                ClearCustApplnEntryFields;
                CustEntrySetApplID.SetApplId(CustLedgEntry,TempCustLedgEntry,'');
              END
            END ELSE
              IF "Applies-to Doc. No." <> '' THEN
                IF FindFirstCustLedgEntryWithAppliesToDocNo(AccNo) THEN BEGIN
                  ClearCustApplnEntryFields;
                  CustEntryEdit.RUN(CustLedgEntry);
                END;
          AccType::Vendor:
            IF "Applies-to ID" <> '' THEN BEGIN
              IF FindFirstVendLedgEntryWithAppliesToID(AccNo) THEN BEGIN
                ClearVendApplnEntryFields;
                VendEntrySetApplID.SetApplId(VendLedgEntry,TempVendLedgEntry,'');
              END
            END ELSE
              IF "Applies-to Doc. No." <> '' THEN
                IF FindFirstVendLedgEntryWithAppliesToDocNo(AccNo) THEN BEGIN
                  ClearVendApplnEntryFields;
                  VendEntryEdit.RUN(VendLedgEntry);
                END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetAccTypeAndNo(Rec,AccType,AccNo);
        CASE AccType OF
          AccType::Customer:
            IF xRec."Applies-to ID" <> '' THEN BEGIN
              IF FindFirstCustLedgEntryWithAppliesToID(AccNo,xRec."Applies-to ID") THEN BEGIN
                ClearCustApplnEntryFields;
                TempCustLedgEntry.DELETEALL;
        #7..9
              IF xRec."Applies-to Doc. No." <> '' THEN
                IF FindFirstCustLedgEntryWithAppliesToDocNo(AccNo,xRec."Applies-to Doc. No.") THEN BEGIN
                  ClearCustApplnEntryFields;
                  CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit",CustLedgEntry);
                END;
          AccType::Vendor:
            IF xRec."Applies-to ID" <> '' THEN BEGIN
              IF FindFirstVendLedgEntryWithAppliesToID(AccNo,xRec."Applies-to ID") THEN BEGIN
                ClearVendApplnEntryFields;
                TempVendLedgEntry.DELETEALL;
        #19..21
              IF xRec."Applies-to Doc. No." <> '' THEN
                IF FindFirstVendLedgEntryWithAppliesToDocNo(AccNo,xRec."Applies-to Doc. No.") THEN BEGIN
                  ClearVendApplnEntryFields;
                  CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",VendLedgEntry);
                END;
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "GetFAVATSetup(PROCEDURE 17)".

    //procedure GetFAVATSetup();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF CurrFieldNo = 0 THEN
          EXIT;
        IF ("Account Type" <> "Account Type"::"Fixed Asset") AND
        #4..16
        END;
        IF NOT GenJnlBatch.GET("Journal Template Name","Journal Batch Name") OR
           GenJnlBatch."Copy VAT Setup to Jnl. Lines"
        THEN BEGIN
          IF (("FA Posting Type" = "FA Posting Type"::"Acquisition Cost") OR
              ("FA Posting Type" = "FA Posting Type"::Disposal) OR
              ("FA Posting Type" = "FA Posting Type"::Maintenance)) AND
             ("Posting Group" <> '')
          THEN BEGIN
            IF FAPostingGr.GET("Posting Group") THEN BEGIN
              IF "FA Posting Type" = "FA Posting Type"::"Acquisition Cost" THEN BEGIN
                FAPostingGr.TESTFIELD("Acquisition Cost Account");
        #29..54
                VALIDATE("Bal. VAT Prod. Posting Group");
              END;
            END;
          END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..19
        THEN
        #21..24
          THEN
        #26..57
        */
    //end;


    //Unsupported feature: Code Modification on "LookUpAppliesToDocCust(PROCEDURE 35)".

    //procedure LookUpAppliesToDocCust();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEAR(CustLedgEntry);
        CustLedgEntry.SETCURRENTKEY("Customer No.",Open,Positive,"Due Date");
        IF AccNo <> '' THEN
          CustLedgEntry.SETRANGE("Customer No.",AccNo);
        CustLedgEntry.SETRANGE(Open,TRUE);
        IF "Applies-to Doc. No." <> '' THEN BEGIN
          CustLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
          CustLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
          IF CustLedgEntry.ISEMPTY THEN BEGIN
            CustLedgEntry.SETRANGE("Document Type");
            CustLedgEntry.SETRANGE("Document No.");
          END;
        END;
        IF "Applies-to ID" <> '' THEN BEGIN
          CustLedgEntry.SETRANGE("Applies-to ID","Applies-to ID");
          IF CustLedgEntry.ISEMPTY THEN
            CustLedgEntry.SETRANGE("Applies-to ID");
        END;
        IF "Applies-to Doc. Type" <> "Applies-to Doc. Type"::" " THEN BEGIN
          CustLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
          IF CustLedgEntry.ISEMPTY THEN
            CustLedgEntry.SETRANGE("Document Type");
        END;
        IF Amount <> 0 THEN BEGIN
          CustLedgEntry.SETRANGE(Positive,Amount < 0);
          IF CustLedgEntry.ISEMPTY THEN
            CustLedgEntry.SETRANGE(Positive);
        END;
        ApplyCustEntries.SetGenJnlLine(Rec,GenJnlLine.FIELDNO("Applies-to Doc. No."));
        ApplyCustEntries.SETTABLEVIEW(CustLedgEntry);
        ApplyCustEntries.SETRECORD(CustLedgEntry);
        ApplyCustEntries.LOOKUPMODE(TRUE);
        IF ApplyCustEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
          ApplyCustEntries.GETRECORD(CustLedgEntry);
          IF AccNo = '' THEN BEGIN
            AccNo := CustLedgEntry."Customer No.";
            IF "Bal. Account Type" = "Bal. Account Type"::Customer THEN
              VALIDATE("Bal. Account No.",AccNo)
            ELSE
              VALIDATE("Account No.",AccNo);
          END;
          IF "Currency Code" <> CustLedgEntry."Currency Code" THEN
            IF Amount = 0 THEN BEGIN
              FromCurrencyCode := GetShowCurrencyCode("Currency Code");
              ToCurrencyCode := GetShowCurrencyCode(CustLedgEntry."Currency Code");
              IF NOT
                 CONFIRM(
                   Text003,TRUE,FIELDCAPTION("Currency Code"),TABLECAPTION,FromCurrencyCode,ToCurrencyCode)
              THEN
                ERROR(Text005);
              VALIDATE("Currency Code",CustLedgEntry."Currency Code");
            END ELSE
              GenJnlApply.CheckAgainstApplnCurrency(
                "Currency Code",CustLedgEntry."Currency Code",
                GenJnlLine."Account Type"::Customer,TRUE);
          IF Amount = 0 THEN BEGIN
            CustLedgEntry.CALCFIELDS("Remaining Amount");
            IF CustLedgEntry."Amount to Apply" <> 0 THEN BEGIN
              IF PaymentToleranceMgt.CheckCalcPmtDiscGenJnlCust(Rec,CustLedgEntry,0,FALSE) THEN BEGIN
                IF ABS(CustLedgEntry."Amount to Apply") >=
                   ABS(CustLedgEntry."Remaining Amount" - CustLedgEntry."Remaining Pmt. Disc. Possible")
                THEN
                  Amount := -(CustLedgEntry."Remaining Amount" -
                              CustLedgEntry."Remaining Pmt. Disc. Possible")
                ELSE
                  Amount := -CustLedgEntry."Amount to Apply";
              END ELSE
                Amount := -CustLedgEntry."Amount to Apply";
            END ELSE BEGIN
              IF PaymentToleranceMgt.CheckCalcPmtDiscGenJnlCust(Rec,CustLedgEntry,0,FALSE) THEN
                Amount := -(CustLedgEntry."Remaining Amount" - CustLedgEntry."Remaining Pmt. Disc. Possible")
              ELSE
                Amount := -CustLedgEntry."Remaining Amount";
            END;
            IF "Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor] THEN
              Amount := -Amount;
            VALIDATE(Amount);
          END;
          "Applies-to Doc. Type" := CustLedgEntry."Document Type";
          "Applies-to Doc. No." := CustLedgEntry."Document No.";
          "Applies-to ID" := '';
        END;
        GetCreditCard;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..41
          SetAmountWithCustLedgEntry;
        #79..82
        */
    //end;


    //Unsupported feature: Code Modification on "LookUpAppliesToDocVend(PROCEDURE 36)".

    //procedure LookUpAppliesToDocVend();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEAR(VendLedgEntry);
        VendLedgEntry.SETCURRENTKEY("Vendor No.",Open,Positive,"Due Date");
        IF AccNo <> '' THEN
          VendLedgEntry.SETRANGE("Vendor No.",AccNo);
        VendLedgEntry.SETRANGE(Open,TRUE);
        IF "Applies-to Doc. No." <> '' THEN BEGIN
          VendLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
          VendLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
          IF VendLedgEntry.ISEMPTY THEN BEGIN
            VendLedgEntry.SETRANGE("Document Type");
            VendLedgEntry.SETRANGE("Document No.");
          END;
        END;
        IF "Applies-to ID" <> '' THEN BEGIN
          VendLedgEntry.SETRANGE("Applies-to ID","Applies-to ID");
          IF VendLedgEntry.ISEMPTY THEN
            VendLedgEntry.SETRANGE("Applies-to ID");
        END;
        IF "Applies-to Doc. Type" <> "Applies-to Doc. Type"::" " THEN BEGIN
          VendLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
          IF VendLedgEntry.ISEMPTY THEN
            VendLedgEntry.SETRANGE("Document Type");
        END;
        IF  "Applies-to Doc. No." <> ''THEN BEGIN
          VendLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
          IF VendLedgEntry.ISEMPTY THEN
            VendLedgEntry.SETRANGE("Document No.");
        END;
        IF Amount <> 0 THEN BEGIN
          VendLedgEntry.SETRANGE(Positive,Amount < 0);
          IF VendLedgEntry.ISEMPTY THEN;
          VendLedgEntry.SETRANGE(Positive);
        END;
        ApplyVendEntries.SetGenJnlLine(Rec,GenJnlLine.FIELDNO("Applies-to Doc. No."));
        ApplyVendEntries.SETTABLEVIEW(VendLedgEntry);
        ApplyVendEntries.SETRECORD(VendLedgEntry);
        ApplyVendEntries.LOOKUPMODE(TRUE);
        IF ApplyVendEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
          ApplyVendEntries.GETRECORD(VendLedgEntry);
          IF AccNo = '' THEN BEGIN
            AccNo := VendLedgEntry."Vendor No.";
            IF "Bal. Account Type" = "Bal. Account Type"::Vendor THEN
              VALIDATE("Bal. Account No.",AccNo)
            ELSE
              VALIDATE("Account No.",AccNo);
          END;
          IF "Currency Code" <> VendLedgEntry."Currency Code" THEN
            IF Amount = 0 THEN BEGIN
              FromCurrencyCode := GetShowCurrencyCode("Currency Code");
              ToCurrencyCode := GetShowCurrencyCode(VendLedgEntry."Currency Code");
              IF NOT
                 CONFIRM(
                   Text003,TRUE,FIELDCAPTION("Currency Code"),TABLECAPTION,FromCurrencyCode,ToCurrencyCode)
              THEN
                ERROR(Text005);
              VALIDATE("Currency Code",VendLedgEntry."Currency Code");
            END ELSE
              GenJnlApply.CheckAgainstApplnCurrency(
                "Currency Code",VendLedgEntry."Currency Code",GenJnlLine."Account Type"::Vendor,TRUE);
          IF Amount = 0 THEN BEGIN
            VendLedgEntry.CALCFIELDS("Remaining Amount");
            IF VendLedgEntry."Amount to Apply" <> 0 THEN BEGIN
              IF PaymentToleranceMgt.CheckCalcPmtDiscGenJnlVend(Rec,VendLedgEntry,0,FALSE) THEN BEGIN
                IF ABS(VendLedgEntry."Amount to Apply") >=
                   ABS(VendLedgEntry."Remaining Amount" - VendLedgEntry."Remaining Pmt. Disc. Possible")
                THEN
                  Amount := -(VendLedgEntry."Remaining Amount" -
                              VendLedgEntry."Remaining Pmt. Disc. Possible")
                ELSE
                  Amount := -VendLedgEntry."Amount to Apply";
              END ELSE
                Amount := -VendLedgEntry."Amount to Apply";
            END ELSE BEGIN
              IF PaymentToleranceMgt.CheckCalcPmtDiscGenJnlVend(Rec,VendLedgEntry,0,FALSE) THEN
                Amount := -(VendLedgEntry."Remaining Amount" -
                            VendLedgEntry."Remaining Pmt. Disc. Possible")
              ELSE
                Amount := -VendLedgEntry."Remaining Amount";
            END;
            IF "Bal. Account Type" IN
               ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor]
            THEN
              Amount := -Amount;
            VALIDATE(Amount);
          END;
          "Applies-to Doc. Type" := VendLedgEntry."Document Type";
          "Applies-to Doc. No." := VendLedgEntry."Document No.";
          "Applies-to ID" := '';
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..46
          SetAmountWithVendLedgEntry;
        #86..89
        */
    //end;


    //Unsupported feature: Code Modification on "ValidateApplyRequirements(PROCEDURE 21)".

    //procedure ValidateApplyRequirements();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Customer) OR
           (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Vendor)
        THEN
          ExchAccGLJnlLine.RUN(TempGenJnlLine);

        IF TempGenJnlLine."Account Type" = TempGenJnlLine."Account Type"::Customer THEN BEGIN
          IF TempGenJnlLine."Applies-to ID" <> '' THEN BEGIN
        #8..30
                    CustLedgEntry."Document Type",CustLedgEntry."Document No.");
            END;
        END ELSE
          IF TempGenJnlLine."Account Type" = TempGenJnlLine."Account Type"::Vendor THEN BEGIN
            IF TempGenJnlLine."Applies-to ID" <> '' THEN BEGIN
              VendLedgEntry.SETCURRENTKEY("Vendor No.","Applies-to ID",Open);
              VendLedgEntry.SETRANGE("Vendor No.",TempGenJnlLine."Account No.");
        #38..58
                      Text015,TempGenJnlLine."Document Type",TempGenJnlLine."Document No.",
                      VendLedgEntry."Document Type",VendLedgEntry."Document No.");
              END;
          END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
          CODEUNIT.RUN(CODEUNIT::"Exchange Acc. G/L Journal Line",TempGenJnlLine);
        #5..33
          IF TempGenJnlLine."Account Type" = TempGenJnlLine."Account Type"::Vendor THEN
        #35..61
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: Cust) (VariableCollection) on "UpdateCountryCodeAndVATRegNo(PROCEDURE 25)".


    //Unsupported feature: Variable Insertion (Variable: Vend) (VariableCollection) on "UpdateCountryCodeAndVATRegNo(PROCEDURE 25)".



    //Unsupported feature: Code Modification on "CreateTempJobJnlLine(PROCEDURE 27)".

    //procedure CreateTempJobJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TESTFIELD("Posting Date");
        CLEAR(JobJnlLine);
        JobJnlLine.DontCheckStdCost;
        JobJnlLine.VALIDATE("Job No.","Job No.");
        JobJnlLine.VALIDATE("Job Task No.","Job Task No.");
        IF CurrFieldNo <> FIELDNO("Posting Date") THEN
          JobJnlLine.VALIDATE("Posting Date","Posting Date")
        ELSE
          JobJnlLine.VALIDATE("Posting Date",xRec."Posting Date");
        JobJnlLine.VALIDATE(Type,JobJnlLine.Type::"G/L Account");
        IF "Job Currency Code" <> '' THEN BEGIN
          IF "Posting Date" = 0D THEN
            CurrencyDate := WORKDATE
          ELSE
            CurrencyDate := "Posting Date";

          IF "Currency Code" = "Job Currency Code" THEN
            "Job Currency Factor" := "Currency Factor"
          ELSE
            "Job Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate,"Job Currency Code");
          JobJnlLine.SetCurrencyFactor("Job Currency Factor");
        END;
        JobJnlLine.VALIDATE("No.","Account No.");
        JobJnlLine.VALIDATE(Quantity,"Job Quantity");

        IF "Currency Factor" = 0 THEN BEGIN
          IF "Job Currency Factor" = 0 THEN
            TmpJobJnlOverallCurrencyFactor := 1
          ELSE
            TmpJobJnlOverallCurrencyFactor := "Job Currency Factor";
        END ELSE BEGIN
          IF "Job Currency Factor" = 0 THEN
            TmpJobJnlOverallCurrencyFactor := 1 / "Currency Factor"
          ELSE
            TmpJobJnlOverallCurrencyFactor := "Job Currency Factor" / "Currency Factor"
        END;

        IF "Job Quantity" <> 0 THEN
          JobJnlLine.VALIDATE("Unit Cost",((Amount - "VAT Amount") * TmpJobJnlOverallCurrencyFactor) / "Job Quantity");

        IF (xRec."Account No." = "Account No.") AND (xRec."Job Task No." = "Job Task No.") AND ("Job Unit Price" <> 0) THEN BEGIN
          IF JobJnlLine."Cost Factor" = 0 THEN
            JobJnlLine."Unit Price" := xRec."Job Unit Price";
          JobJnlLine."Line Amount" := xRec."Job Line Amount";
          JobJnlLine."Line Discount %" := xRec."Job Line Discount %";
          JobJnlLine."Line Discount Amount" := xRec."Job Line Discount Amount";
          JobJnlLine.VALIDATE("Unit Price");
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TESTFIELD("Posting Date");
        CLEAR(TempJobJnlLine);
        TempJobJnlLine.DontCheckStdCost;
        TempJobJnlLine.VALIDATE("Job No.","Job No.");
        TempJobJnlLine.VALIDATE("Job Task No.","Job Task No.");
        IF CurrFieldNo <> FIELDNO("Posting Date") THEN
          TempJobJnlLine.VALIDATE("Posting Date","Posting Date")
        ELSE
          TempJobJnlLine.VALIDATE("Posting Date",xRec."Posting Date");
        TempJobJnlLine.VALIDATE(Type,TempJobJnlLine.Type::"G/L Account");
        #11..20
          TempJobJnlLine.SetCurrencyFactor("Job Currency Factor");
        END;
        TempJobJnlLine.VALIDATE("No.","Account No.");
        TempJobJnlLine.VALIDATE(Quantity,"Job Quantity");
        #25..38
          TempJobJnlLine.VALIDATE("Unit Cost",((Amount - "VAT Amount") * TmpJobJnlOverallCurrencyFactor) / "Job Quantity");

        IF (xRec."Account No." = "Account No.") AND (xRec."Job Task No." = "Job Task No.") AND ("Job Unit Price" <> 0) THEN BEGIN
          IF TempJobJnlLine."Cost Factor" = 0 THEN
            TempJobJnlLine."Unit Price" := xRec."Job Unit Price";
          TempJobJnlLine."Line Amount" := xRec."Job Line Amount";
          TempJobJnlLine."Line Discount %" := xRec."Job Line Discount %";
          TempJobJnlLine."Line Discount Amount" := xRec."Job Line Discount Amount";
          TempJobJnlLine.VALIDATE("Unit Price");
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "UpdatePricesFromJobJnlLine(PROCEDURE 22)".

    //procedure UpdatePricesFromJobJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Job Unit Price" := JobJnlLine."Unit Price";
        "Job Total Price" := JobJnlLine."Total Price";
        "Job Line Amount" := JobJnlLine."Line Amount";
        "Job Line Discount Amount" := JobJnlLine."Line Discount Amount";
        "Job Unit Cost" := JobJnlLine."Unit Cost";
        "Job Total Cost" := JobJnlLine."Total Cost";
        "Job Line Discount %" := JobJnlLine."Line Discount %";

        "Job Unit Price (LCY)" := JobJnlLine."Unit Price (LCY)";
        "Job Total Price (LCY)" := JobJnlLine."Total Price (LCY)";
        "Job Line Amount (LCY)" := JobJnlLine."Line Amount (LCY)";
        "Job Line Disc. Amount (LCY)" := JobJnlLine."Line Discount Amount (LCY)";
        "Job Unit Cost (LCY)" := JobJnlLine."Unit Cost (LCY)";
        "Job Total Cost (LCY)" := JobJnlLine."Total Cost (LCY)";
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        "Job Unit Price" := TempJobJnlLine."Unit Price";
        "Job Total Price" := TempJobJnlLine."Total Price";
        "Job Line Amount" := TempJobJnlLine."Line Amount";
        "Job Line Discount Amount" := TempJobJnlLine."Line Discount Amount";
        "Job Unit Cost" := TempJobJnlLine."Unit Cost";
        "Job Total Cost" := TempJobJnlLine."Total Cost";
        "Job Line Discount %" := TempJobJnlLine."Line Discount %";

        "Job Unit Price (LCY)" := TempJobJnlLine."Unit Price (LCY)";
        "Job Total Price (LCY)" := TempJobJnlLine."Total Price (LCY)";
        "Job Line Amount (LCY)" := TempJobJnlLine."Line Amount (LCY)";
        "Job Line Disc. Amount (LCY)" := TempJobJnlLine."Line Discount Amount (LCY)";
        "Job Unit Cost (LCY)" := TempJobJnlLine."Unit Cost (LCY)";
        "Job Total Cost (LCY)" := TempJobJnlLine."Total Cost (LCY)";
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: LastGenJnlLine) (ParameterCollection) on "SuggestBalancingAmount(PROCEDURE 46)".


    //Unsupported feature: Parameter Insertion (Parameter: BottomLine) (ParameterCollection) on "SuggestBalancingAmount(PROCEDURE 46)".


    //Unsupported feature: Variable Insertion (Variable: GenJournalLine) (VariableCollection) on "SuggestBalancingAmount(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Name) on "CheckNoCardTransactEntryExist(PROCEDURE 46)".



    //Unsupported feature: Code Modification on "CheckNoCardTransactEntryExist(PROCEDURE 46)".

    //procedure CheckNoCardTransactEntryExist();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE GenJnlLine."Document Type" OF
          GenJnlLine."Document Type"::Payment:
            DocumentType := DOPaymentTransLogEntry."Document Type"::Payment;
          GenJnlLine."Document Type"::Refund:
            DocumentType := DOPaymentTransLogEntry."Document Type"::Refund;
        END;
        IF DOPaymentTransLogEntry.FINDFIRST THEN
          IF DOPaymentTransLogMgt.FindPostingNotFinishedEntry(DocumentType,GenJnlLine."Document No.",DOPaymentTransLogEntry) THEN
            ERROR(Text017,DOPaymentTransLogEntry."Transaction Type",GenJnlLine."Document Type",GenJnlLine."Document No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF "Document No." = '' THEN
          EXIT;
        IF GETFILTERS <> '' THEN
          EXIT;

        GenJournalLine.SETRANGE("Journal Template Name",LastGenJnlLine."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name",LastGenJnlLine."Journal Batch Name");
        IF BottomLine THEN
          GenJournalLine.SETFILTER("Line No.",'<=%1',LastGenJnlLine."Line No.")
        ELSE
          GenJournalLine.SETFILTER("Line No.",'<%1',LastGenJnlLine."Line No.");

        IF GenJournalLine.FINDLAST THEN BEGIN
          IF BottomLine THEN BEGIN
            GenJournalLine.SETRANGE("Document No.",LastGenJnlLine."Document No.");
            GenJournalLine.SETRANGE("Posting Date",LastGenJnlLine."Posting Date");
          END ELSE BEGIN
            GenJournalLine.SETRANGE("Document No.",GenJournalLine."Document No.");
            GenJournalLine.SETRANGE("Posting Date",GenJournalLine."Posting Date");
          END;
          GenJournalLine.SETRANGE("Bal. Account No.",'');
          IF GenJournalLine.FINDFIRST THEN BEGIN
            GenJournalLine.CALCSUMS(Amount);
            "Document No." := GenJournalLine."Document No.";
            "Posting Date" := GenJournalLine."Posting Date";
            VALIDATE(Amount,-GenJournalLine.Amount);
          END;
        END;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: Cust) (VariableCollection) on "GetCustomerAccount(PROCEDURE 47)".


    //Unsupported feature: Property Modification (Name) on "GetCreditCard(PROCEDURE 47)".



    //Unsupported feature: Code Modification on "GetCreditCard(PROCEDURE 47)".

    //procedure GetCreditCard();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Applies-to Doc. No." = xRec."Applies-to Doc. No." THEN
          EXIT;
        IF NOT (("Account Type" = "Account Type"::Customer) AND
                ("Bal. Account Type" = "Bal. Account Type"::"Bank Account"))
        THEN
          EXIT;

        IF "Applies-to Doc. No." = '' THEN
          EXIT;

        IF "Document Type" <> "Document Type"::Refund THEN
          EXIT;

        DOPaymentTransLogEntry.SETRANGE("Customer No.","Account No.");
        DOPaymentTransLogEntry.SETRANGE("Transaction Type",DOPaymentTransLogEntry."Transaction Type"::Capture);
        DOPaymentTransLogEntry.SETRANGE("Document Type",DOPaymentTransLogEntry."Document Type"::Payment);
        DOPaymentTransLogEntry.SETRANGE("Document No.","Applies-to Doc. No.");

        IF DOPaymentTransLogEntry.FINDFIRST THEN
          "Credit Card No." := DOPaymentTransLogEntry."Credit Card No."
        ELSE
          "Credit Card No." := '';
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        Cust.GET("Account No.");
        Cust.CheckBlockedCustOnJnls(Cust,"Document Type",FALSE);
        CheckICPartner(Cust."IC Partner Code","Account Type","Account No.");
        UpdateDescription(Cust.Name);
        "Payment Method Code" := Cust."Payment Method Code";
        VALIDATE("Recipient Bank Account",Cust."Preferred Bank Account Code");
        "Posting Group" := Cust."Customer Posting Group";
        "Salespers./Purch. Code" := Cust."Salesperson Code";
        "Payment Terms Code" := Cust."Payment Terms Code";
        VALIDATE("Bill-to/Pay-to No.","Account No.");
        VALIDATE("Sell-to/Buy-from No.","Account No.");
        IF NOT SetCurrencyCode("Bal. Account Type","Bal. Account No.") THEN
          "Currency Code" := Cust."Currency Code";
        ClearPostingGroups;
        IF (Cust."Bill-to Customer No." <> '') AND (Cust."Bill-to Customer No." <> "Account No.") AND
           NOT HideValidationDialog
        THEN
          IF NOT CONFIRM(Text014,FALSE,Cust.TABLECAPTION,Cust."No.",Cust.FIELDCAPTION("Bill-to Customer No."),
               Cust."Bill-to Customer No.")
          THEN
            ERROR('');
        VALIDATE("Payment Terms Code");
        CheckPaymentTolerance;
        */
    //end;


    //Unsupported feature: Code Modification on "GetCustLedgerEntry(PROCEDURE 33)".

    //procedure GetCustLedgerEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ("Account Type" = "Account Type"::Customer) AND ("Account No." = '') AND
           ("Applies-to Doc. No." <> '') AND (Amount = 0)
        THEN BEGIN
          CustLedgEntry.RESET;
          CustLedgEntry.SETRANGE("Document Type","Document Type"::Invoice);
          CustLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
          CustLedgEntry.SETRANGE(Open,TRUE);
          IF NOT CustLedgEntry.FINDFIRST THEN
        #9..20
            ToCurrencyCode := GetShowCurrencyCode(CustLedgEntry."Currency Code");
            IF NOT
               CONFIRM(
                 Text003,TRUE,
                 FIELDCAPTION("Currency Code"),TABLECAPTION,FromCurrencyCode,
                 ToCurrencyCode)
            THEN
              ERROR(Text005);
            VALIDATE("Currency Code",CustLedgEntry."Currency Code");
        #30..45
          END ELSE
            VALIDATE(Amount);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        #6..23
                 STRSUBSTNO(Text003,FIELDCAPTION("Currency Code"),TABLECAPTION,FromCurrencyCode,ToCurrencyCode),
                 TRUE)
        #27..48
        */
    //end;


    //Unsupported feature: Code Modification on "GetVendLedgerEntry(PROCEDURE 37)".

    //procedure GetVendLedgerEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ("Account Type" = "Account Type"::Vendor) AND ("Account No." = '') AND
           ("Applies-to Doc. No." <> '') AND (Amount = 0)
        THEN BEGIN
          VendLedgEntry.RESET;
          VendLedgEntry.SETRANGE("Document Type","Document Type"::Invoice);
          VendLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
          VendLedgEntry.SETRANGE(Open,TRUE);
          IF NOT VendLedgEntry.FINDFIRST THEN
        #9..11
          VendLedgEntry.CALCFIELDS("Remaining Amount");

          IF "Posting Date" <= VendLedgEntry."Pmt. Discount Date" THEN
            Amount := -(CustLedgEntry."Remaining Amount" - VendLedgEntry."Remaining Pmt. Disc. Possible")
          ELSE
            Amount := -VendLedgEntry."Remaining Amount";

          IF "Currency Code" <> VendLedgEntry."Currency Code" THEN BEGIN
            FromCurrencyCode := GetShowCurrencyCode("Currency Code");
            ToCurrencyCode := GetShowCurrencyCode(CustLedgEntry."Currency Code");
            IF NOT
               CONFIRM(
                 Text003,
                 TRUE,FIELDCAPTION("Currency Code"),TABLECAPTION,FromCurrencyCode,ToCurrencyCode)
            THEN
              ERROR(Text005);
            VALIDATE("Currency Code",VendLedgEntry."Currency Code");
        #29..44
          END ELSE
            VALIDATE(Amount);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        #6..14
            Amount := -(VendLedgEntry."Remaining Amount" - VendLedgEntry."Remaining Pmt. Disc. Possible")
        #16..20
            ToCurrencyCode := GetShowCurrencyCode(VendLedgEntry."Currency Code");
            IF NOT
               CONFIRM(
                 STRSUBSTNO(Text003,FIELDCAPTION("Currency Code"),TABLECAPTION,FromCurrencyCode,ToCurrencyCode),
                 TRUE)
        #26..47
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: DeleteHeaderEntries) (ParameterCollection) on "ClearDataExchangeEntries(PROCEDURE 42)".


    //Unsupported feature: Variable Insertion (Variable: DataExchField) (VariableCollection) on "ClearDataExchangeEntries(PROCEDURE 42)".


    //Unsupported feature: Variable Insertion (Variable: GenJournalLine) (VariableCollection) on "ClearDataExchangeEntries(PROCEDURE 42)".


    //Unsupported feature: Property Deletion (Local) on "ClearPostExchangeEntries(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Name) on "ClearPostExchangeEntries(PROCEDURE 42)".



    //Unsupported feature: Code Modification on "ClearPostExchangeEntries(PROCEDURE 42)".

    //procedure ClearPostExchangeEntries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PostExchField.SETRANGE("Posting Exch. No.","Posting Exch. Entry No.");
        PostExchField.SETRANGE("Line No.","Posting Exch. Line No.");
        PostExchField.DELETEALL;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        DataExchField.DeleteRelatedRecords("Data Exch. Entry No.","Data Exch. Line No.");

        GenJournalLine.SETRANGE("Journal Template Name","Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name","Journal Batch Name");
        GenJournalLine.SETRANGE("Data Exch. Entry No.","Data Exch. Entry No.");
        GenJournalLine.SETFILTER("Line No.",'<>%1',"Line No.");
        IF GenJournalLine.ISEMPTY OR DeleteHeaderEntries THEN
          DataExchField.DeleteRelatedRecords("Data Exch. Entry No.",0);
        */
    //end;


    //Unsupported feature: Code Modification on "InsertPaymentFileError(PROCEDURE 64)".

    //procedure InsertPaymentFileError();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PaymentJnlExportErrorText.CreateNew(Rec,Text);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        PaymentJnlExportErrorText.CreateNew(Rec,Text,'','');
        */
    //end;


    //Unsupported feature: Code Modification on "GetAppliesToDocEntryNo(PROCEDURE 63)".

    //procedure GetAppliesToDocEntryNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetAccTypeAndNo(AccType,AccNo);
        CASE AccType OF
          AccType::Customer:
            BEGIN
        #5..10
              EXIT(VendLedgEntry."Entry No.");
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetAccTypeAndNo(Rec,AccType,AccNo);
        #2..13
        */
    //end;


    //Unsupported feature: Code Modification on "GetAppliesToDocDueDate(PROCEDURE 62)".

    //procedure GetAppliesToDocDueDate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GetAccTypeAndNo(AccType,AccNo);
        CASE AccType OF
          AccType::Customer:
            BEGIN
        #5..10
              EXIT(VendLedgEntry."Due Date");
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GetAccTypeAndNo(Rec,AccType,AccNo);
        #2..13
        */
    //end;


    //Unsupported feature: Code Modification on "SetJournalLineFieldsFromApplication(PROCEDURE 51)".

    //procedure SetJournalLineFieldsFromApplication();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Exported to Payment File" := FALSE;
        GetAccTypeAndNo(AccType,AccNo);
        CASE AccType OF
          AccType::Customer:
            IF "Applies-to ID" <> '' THEN BEGIN
              IF FindFirstCustLedgEntryWithAppliesToID(AccNo) THEN BEGIN
                CustLedgEntry.SETRANGE("Exported to Payment File",TRUE);
                "Exported to Payment File" := CustLedgEntry.FINDFIRST;
              END
            END ELSE
              IF "Applies-to Doc. No." <> '' THEN
                IF FindFirstCustLedgEntryWithAppliesToDocNo(AccNo) THEN BEGIN
                  "Exported to Payment File" := CustLedgEntry."Exported to Payment File";
                  "Applies-to Ext. Doc. No." := CustLedgEntry."External Document No.";
                END;
          AccType::Vendor:
            IF "Applies-to ID" <> '' THEN BEGIN
              IF FindFirstVendLedgEntryWithAppliesToID(AccNo) THEN BEGIN
                VendLedgEntry.SETRANGE("Exported to Payment File",TRUE);
                "Exported to Payment File" := VendLedgEntry.FINDFIRST;
              END
            END ELSE
              IF "Applies-to Doc. No." <> '' THEN
                IF FindFirstVendLedgEntryWithAppliesToDocNo(AccNo) THEN BEGIN
                  "Exported to Payment File" := VendLedgEntry."Exported to Payment File";
                  "Applies-to Ext. Doc. No." := VendLedgEntry."External Document No.";
                END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        "Exported to Payment File" := FALSE;
        GetAccTypeAndNo(Rec,AccType,AccNo);
        #3..5
              IF FindFirstCustLedgEntryWithAppliesToID(AccNo,"Applies-to ID") THEN BEGIN
        #7..11
                IF FindFirstCustLedgEntryWithAppliesToDocNo(AccNo,"Applies-to Doc. No.") THEN BEGIN
        #13..17
              IF FindFirstVendLedgEntryWithAppliesToID(AccNo,"Applies-to ID") THEN BEGIN
        #19..23
                IF FindFirstVendLedgEntryWithAppliesToDocNo(AccNo,"Applies-to Doc. No.") THEN BEGIN
        #25..28
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: GenJnlLine2) (ParameterCollection) on "GetAccTypeAndNo(PROCEDURE 52)".



    //Unsupported feature: Code Modification on "GetAccTypeAndNo(PROCEDURE 52)".

    //procedure GetAccTypeAndNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Bal. Account Type" IN
           ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor]
        THEN BEGIN
          AccType := "Bal. Account Type";
          AccNo := "Bal. Account No.";
        END ELSE BEGIN
          AccType := "Account Type";
          AccNo := "Account No.";
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF GenJnlLine2."Bal. Account Type" IN
           [GenJnlLine2."Bal. Account Type"::Customer,GenJnlLine2."Bal. Account Type"::Vendor]
        THEN BEGIN
          AccType := GenJnlLine2."Bal. Account Type";
          AccNo := GenJnlLine2."Bal. Account No.";
        END ELSE BEGIN
          AccType := GenJnlLine2."Account Type";
          AccNo := GenJnlLine2."Account No.";
        END;
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: AppliesToID) (ParameterCollection) on "FindFirstCustLedgEntryWithAppliesToID(PROCEDURE 54)".



    //Unsupported feature: Code Modification on "FindFirstCustLedgEntryWithAppliesToID(PROCEDURE 54)".

    //procedure FindFirstCustLedgEntryWithAppliesToID();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CustLedgEntry.RESET;
        CustLedgEntry.SETCURRENTKEY("Customer No.","Applies-to ID",Open);
        CustLedgEntry.SETRANGE("Customer No.",AccNo);
        CustLedgEntry.SETRANGE("Applies-to ID","Applies-to ID");
        CustLedgEntry.SETRANGE(Open,TRUE);
        EXIT(CustLedgEntry.FINDFIRST)
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        CustLedgEntry.SETRANGE("Applies-to ID",AppliesToID);
        CustLedgEntry.SETRANGE(Open,TRUE);
        EXIT(CustLedgEntry.FINDFIRST)
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: AppliestoDocNo) (ParameterCollection) on "FindFirstCustLedgEntryWithAppliesToDocNo(PROCEDURE 55)".



    //Unsupported feature: Code Modification on "FindFirstCustLedgEntryWithAppliesToDocNo(PROCEDURE 55)".

    //procedure FindFirstCustLedgEntryWithAppliesToDocNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CustLedgEntry.RESET;
        CustLedgEntry.SETCURRENTKEY("Document No.");
        CustLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
        CustLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
        CustLedgEntry.SETRANGE("Customer No.",AccNo);
        CustLedgEntry.SETRANGE(Open,TRUE);
        EXIT(CustLedgEntry.FINDFIRST)
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CustLedgEntry.RESET;
        CustLedgEntry.SETCURRENTKEY("Document No.");
        CustLedgEntry.SETRANGE("Document No.",AppliestoDocNo);
        #4..7
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: AppliesToID) (ParameterCollection) on "FindFirstVendLedgEntryWithAppliesToID(PROCEDURE 58)".



    //Unsupported feature: Code Modification on "FindFirstVendLedgEntryWithAppliesToID(PROCEDURE 58)".

    //procedure FindFirstVendLedgEntryWithAppliesToID();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        VendLedgEntry.RESET;
        VendLedgEntry.SETCURRENTKEY("Vendor No.","Applies-to ID",Open);
        VendLedgEntry.SETRANGE("Vendor No.",AccNo);
        VendLedgEntry.SETRANGE("Applies-to ID","Applies-to ID");
        VendLedgEntry.SETRANGE(Open,TRUE);
        EXIT(VendLedgEntry.FINDFIRST)
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        VendLedgEntry.SETRANGE("Applies-to ID",AppliesToID);
        VendLedgEntry.SETRANGE(Open,TRUE);
        EXIT(VendLedgEntry.FINDFIRST)
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: AppliestoDocNo) (ParameterCollection) on "FindFirstVendLedgEntryWithAppliesToDocNo(PROCEDURE 59)".



    //Unsupported feature: Code Modification on "FindFirstVendLedgEntryWithAppliesToDocNo(PROCEDURE 59)".

    //procedure FindFirstVendLedgEntryWithAppliesToDocNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        VendLedgEntry.RESET;
        VendLedgEntry.SETCURRENTKEY("Document No.");
        VendLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
        VendLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
        VendLedgEntry.SETRANGE("Vendor No.",AccNo);
        VendLedgEntry.SETRANGE(Open,TRUE);
        EXIT(VendLedgEntry.FINDFIRST)
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        VendLedgEntry.RESET;
        VendLedgEntry.SETCURRENTKEY("Document No.");
        VendLedgEntry.SETRANGE("Document No.",AppliestoDocNo);
        #4..7
        */
    //end;


    //Unsupported feature: Code Modification on "CleanLine(PROCEDURE 66)".

    //procedure CleanLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        UpdateLineBalance;
        UpdateSource;
        CreateDim(
        #4..12
          "Tax Area Code" := '';
          "Tax Liable" := FALSE;
          "Tax Group Code" := '';
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..15
          "Bill-to/Pay-to No." := '';
          "Ship-to/Order Address Code" := '';
          "Sell-to/Buy-from No." := '';
          UpdateCountryCodeAndVATRegNo('');
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "IsExportedToPaymentFile(PROCEDURE 1020)".

    //procedure IsExportedToPaymentFile();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        EXIT(
          PaymentExportMgt.IsPaymentJournallLineExported(Rec) OR
          PaymentExportMgt.IsAppliedToVendorLedgerEntryExported(Rec));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        EXIT(IsPaymentJournallLineExported OR IsAppliedToVendorLedgerEntryExported);
        */
    //end;

    procedure InitNewLine(PostingDate: Date;DocumentDate: Date;PostingDescription: Text[50];ShortcutDim1Code: Code[20];ShortcutDim2Code: Code[20];DimSetID: Integer;ReasonCode: Code[10])
    begin
        INIT;
        "Posting Date" := PostingDate;
        "Document Date" := DocumentDate;
        Description := PostingDescription;
        "Shortcut Dimension 1 Code" := ShortcutDim1Code;
        "Shortcut Dimension 2 Code" := ShortcutDim2Code;
        "Dimension Set ID" := DimSetID;
        "Reason Code" := ReasonCode;
    end;

    procedure CheckDocNoOnLines()
    var
        GenJnlBatch: Record "232";
        GenJnlLine: Record "81";
        LastDocNo: Code[20];
    begin
        GenJnlLine.COPYFILTERS(Rec);

        IF NOT GenJnlLine.FINDSET THEN
          EXIT;
        GenJnlBatch.GET(GenJnlLine."Journal Template Name",GenJnlLine."Journal Batch Name");
        IF GenJnlBatch."No. Series" = '' THEN
          EXIT;

        CLEAR(NoSeriesMgt);
        REPEAT
          GenJnlLine.CheckDocNoBasedOnNoSeries(LastDocNo,GenJnlBatch."No. Series",NoSeriesMgt);
          LastDocNo := GenJnlLine."Document No.";
        UNTIL GenJnlLine.NEXT = 0;
    end;

    procedure CheckDocNoBasedOnNoSeries(LastDocNo: Code[20];NoSeriesCode: Code[10];var NoSeriesMgtInstance: Codeunit "396")
    begin
        IF NoSeriesCode = '' THEN
          EXIT;

        IF (LastDocNo = '') OR ("Document No." <> LastDocNo) THEN
          TESTFIELD("Document No.",NoSeriesMgtInstance.GetNextNo(NoSeriesCode,"Posting Date",FALSE));
    end;

    procedure SetCurrencyFactor(CurrencyCode: Code[10];CurrencyFactor: Decimal)
    begin
        "Currency Code" := CurrencyCode;
        IF "Currency Code" = '' THEN
          "Currency Factor" := 1
        ELSE
          "Currency Factor" := CurrencyFactor;
    end;

    local procedure CheckICPartner(ICPartnerCode: Code[20];AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";AccountNo: Code[20])
    var
        ICPartner: Record "413";
    begin
        IF ICPartnerCode <> '' THEN BEGIN
          IF GenJnlTemplate.GET("Journal Template Name") THEN;
          IF (ICPartnerCode <> '') AND ICPartner.GET(ICPartnerCode) THEN BEGIN
            ICPartner.CheckICPartnerIndirect(FORMAT(AccountType),AccountNo);
            "IC Partner Code" := ICPartnerCode;
          END;
        END;
    end;

    local procedure GetFADeprBook()
    var
        FASetup: Record "5603";
        FADeprBook: Record "5612";
        DefaultFADeprBook: Record "5612";
    begin
        IF "Depreciation Book Code" = '' THEN BEGIN
          FASetup.GET;

          DefaultFADeprBook.SETRANGE("FA No.","Account No.");
          DefaultFADeprBook.SETRANGE("Default FA Depreciation Book",TRUE);

          CASE TRUE OF
            DefaultFADeprBook.FINDFIRST:
              "Depreciation Book Code" := DefaultFADeprBook."Depreciation Book Code";
            FADeprBook.GET("Account No.",FASetup."Default Depr. Book"):
              "Depreciation Book Code" := FASetup."Default Depr. Book";
            ELSE
              "Depreciation Book Code" := '';
          END;
        END;

        IF "Depreciation Book Code" <> '' THEN BEGIN
          FADeprBook.GET("Account No.","Depreciation Book Code");
          "Posting Group" := FADeprBook."FA Posting Group";
        END;
    end;

    procedure GetOverdueDateInteractions(var OverdueWarningText: Text): Text
    var
        DueDate: Date;
    begin
        DueDate := GetAppliesToDocDueDate;
        OverdueWarningText := '';
        IF (DueDate <> 0D) AND (DueDate < "Posting Date") THEN BEGIN
          OverdueWarningText := DueDateMsg;
          EXIT('Unfavorable');
        END;
        EXIT('');
    end;

    procedure InsertPaymentFileErrorWithDetails(ErrorText: Text;AddnlInfo: Text;ExtSupportInfo: Text)
    var
        PaymentJnlExportErrorText: Record "1228";
    begin
        PaymentJnlExportErrorText.CreateNew(Rec,ErrorText,AddnlInfo,ExtSupportInfo);
    end;

    local procedure ReplaceDescription(): Boolean
    begin
        IF "Bal. Account No." = '' THEN
          EXIT(TRUE);
        GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
        EXIT(GenJnlBatch."Bal. Account No." <> '');
    end;

    procedure IsPaymentJournallLineExported(): Boolean
    var
        GenJnlLine: Record "81";
        OldFilterGroup: Integer;
        HasExportedLines: Boolean;
    begin
        WITH GenJnlLine DO BEGIN
          COPYFILTERS(Rec);
          OldFilterGroup := FILTERGROUP;
          FILTERGROUP := 10;
          SETRANGE("Exported to Payment File",TRUE);
          HasExportedLines := NOT ISEMPTY;
          SETRANGE("Exported to Payment File");
          FILTERGROUP := OldFilterGroup;
        END;
        EXIT(HasExportedLines);
    end;

    procedure IsAppliedToVendorLedgerEntryExported(): Boolean
    var
        GenJnlLine: Record "81";
        VendLedgerEntry: Record "25";
    begin
        GenJnlLine.COPYFILTERS(Rec);

        IF GenJnlLine.FINDSET THEN
          REPEAT
            IF GenJnlLine.IsApplied THEN BEGIN
              VendLedgerEntry.SETRANGE("Vendor No.",GenJnlLine."Account No.");
              IF GenJnlLine."Applies-to Doc. No." <> '' THEN BEGIN
                VendLedgerEntry.SETRANGE("Document Type",GenJnlLine."Applies-to Doc. Type");
                VendLedgerEntry.SETRANGE("Document No.",GenJnlLine."Applies-to Doc. No.");
              END;
              IF GenJnlLine."Applies-to ID" <> '' THEN
                VendLedgerEntry.SETRANGE("Applies-to ID",GenJnlLine."Applies-to ID");
              VendLedgerEntry.SETRANGE("Exported to Payment File",TRUE);
              IF NOT VendLedgerEntry.ISEMPTY THEN
                EXIT(TRUE);
            END;

            VendLedgerEntry.RESET;
            VendLedgerEntry.SETRANGE("Vendor No.",GenJnlLine."Account No.");
            VendLedgerEntry.SETRANGE("Applies-to Doc. Type",GenJnlLine."Document Type");
            VendLedgerEntry.SETRANGE("Applies-to Doc. No.",GenJnlLine."Document No.");
            VendLedgerEntry.SETRANGE("Exported to Payment File",TRUE);
            IF NOT VendLedgerEntry.ISEMPTY THEN
              EXIT(TRUE);
          UNTIL GenJnlLine.NEXT = 0;

        EXIT(FALSE);
    end;

    procedure SetPostingDateAsDueDate(DueDate: Date;DateOffset: DateFormula): Boolean
    var
        NewPostingDate: Date;
    begin
        IF DueDate = 0D THEN
          EXIT(FALSE);

        NewPostingDate := CALCDATE(DateOffset,DueDate);
        IF NewPostingDate < WORKDATE THEN BEGIN
          VALIDATE("Posting Date",WORKDATE);
          EXIT(TRUE);
        END;

        VALIDATE("Posting Date",NewPostingDate);
        EXIT(FALSE);
    end;

    procedure CalculatePostingDate()
    var
        GenJnlLine: Record "81";
        EmptyDateFormula: DateFormula;
    begin
        GenJnlLine.COPY(Rec);
        GenJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
        GenJnlLine.SETRANGE("Journal Batch Name","Journal Batch Name");

        IF GenJnlLine.FINDSET THEN BEGIN
          Window.OPEN(CalcPostDateMsg);
          REPEAT
            EVALUATE(EmptyDateFormula,'<0D>');
            GenJnlLine.SetPostingDateAsDueDate(GenJnlLine.GetAppliesToDocDueDate,EmptyDateFormula);
            GenJnlLine.MODIFY(TRUE);
            Window.UPDATE(1,GenJnlLine."Document No.");
          UNTIL GenJnlLine.NEXT = 0;
          Window.CLOSE;
        END;
    end;

    procedure ImportBankStatement()
    var
        ProcessGenJnlLines: Codeunit "1247";
    begin
        ProcessGenJnlLines.ImportBankStatement(Rec);
    end;

    procedure ExportPaymentFile()
    var
        BankAcc: Record "270";
    begin
        IF NOT FINDSET THEN
          ERROR(NothingToExportErr);
        SETRANGE("Journal Template Name","Journal Template Name");
        SETRANGE("Journal Batch Name","Journal Batch Name");
        TESTFIELD("Check Printed",FALSE);

        GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
        GenJnlBatch.TESTFIELD("Bal. Account Type",GenJnlBatch."Bal. Account Type"::"Bank Account");
        GenJnlBatch.TESTFIELD("Bal. Account No.");

        CheckDocNoOnLines;
        IF IsExportedToPaymentFile THEN
          IF NOT CONFIRM(ExportAgainQst) THEN
            EXIT;
        BankAcc.GET(GenJnlBatch."Bal. Account No.");
        IF BankAcc.GetPaymentExportCodeunitID > 0 THEN
          CODEUNIT.RUN(BankAcc.GetPaymentExportCodeunitID,Rec)
        ELSE
          CODEUNIT.RUN(CODEUNIT::"Exp. Launcher Gen. Jnl.",Rec);
    end;

    procedure TotalExportedAmount(): Decimal
    var
        CreditTransferEntry: Record "1206";
    begin
        IF NOT ("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor]) THEN
          EXIT(0);
        GenJnlShowCTEntries.SetFiltersOnCreditTransferEntry(Rec,CreditTransferEntry);
        CreditTransferEntry.CALCSUMS("Transfer Amount");
        EXIT(CreditTransferEntry."Transfer Amount");
    end;

    procedure DrillDownExportedAmount()
    var
        CreditTransferEntry: Record "1206";
    begin
        IF NOT ("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor]) THEN
          EXIT;
        GenJnlShowCTEntries.SetFiltersOnCreditTransferEntry(Rec,CreditTransferEntry);
        PAGE.RUN(PAGE::"Credit Transfer Reg. Entries",CreditTransferEntry);
    end;

    local procedure CopyDimensionsFromJobTaskLine()
    begin
        "Dimension Set ID" := TempJobJnlLine."Dimension Set ID";
        "Shortcut Dimension 1 Code" := TempJobJnlLine."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := TempJobJnlLine."Shortcut Dimension 2 Code";
    end;

    procedure CopyDocumentFields(DocType: Option;DocNo: Code[20];ExtDocNo: Text[35];SourceCode: Code[10];NoSeriesCode: Code[10])
    begin
        "Document Type" := DocType;
        "Document No." := DocNo;
        "External Document No." := ExtDocNo;
        "Source Code" := SourceCode;
        IF NoSeriesCode <> '' THEN
          "Posting No. Series" := NoSeriesCode;
    end;

    procedure CopyCustLedgEntry(CustLedgerEntry: Record "21")
    begin
        "Document Type" := CustLedgerEntry."Document Type";
        Description := CustLedgerEntry.Description;
        "Shortcut Dimension 1 Code" := CustLedgerEntry."Global Dimension 1 Code";
        "Shortcut Dimension 2 Code" := CustLedgerEntry."Global Dimension 2 Code";
        "Dimension Set ID" := CustLedgerEntry."Dimension Set ID";
        "Posting Group" := CustLedgerEntry."Customer Posting Group";
        "Source Type" := "Source Type"::Customer;
        "Source No." := CustLedgerEntry."Customer No.";
    end;

    procedure CopyFromGenJnlAllocation(GenJnlAlloc: Record "221")
    begin
        "Account No." := GenJnlAlloc."Account No.";
        "Shortcut Dimension 1 Code" := GenJnlAlloc."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := GenJnlAlloc."Shortcut Dimension 2 Code";
        "Dimension Set ID" := GenJnlAlloc."Dimension Set ID";
        "Gen. Posting Type" := GenJnlAlloc."Gen. Posting Type";
        "Gen. Bus. Posting Group" := GenJnlAlloc."Gen. Bus. Posting Group";
        "Gen. Prod. Posting Group" := GenJnlAlloc."Gen. Prod. Posting Group";
        "VAT Bus. Posting Group" := GenJnlAlloc."VAT Bus. Posting Group";
        "VAT Prod. Posting Group" := GenJnlAlloc."VAT Prod. Posting Group";
        "Tax Area Code" := GenJnlAlloc."Tax Area Code";
        "Tax Liable" := GenJnlAlloc."Tax Liable";
        "Tax Group Code" := GenJnlAlloc."Tax Group Code";
        "Use Tax" := GenJnlAlloc."Use Tax";
        "VAT Calculation Type" := GenJnlAlloc."VAT Calculation Type";
        "VAT Amount" := GenJnlAlloc."VAT Amount";
        "VAT Base Amount" := GenJnlAlloc.Amount - GenJnlAlloc."VAT Amount";
        "VAT %" := GenJnlAlloc."VAT %";
        "Source Currency Amount" := GenJnlAlloc."Additional-Currency Amount";
        Amount := GenJnlAlloc.Amount;
        "Amount (LCY)" := GenJnlAlloc.Amount;
    end;

    procedure CopyFromInvoicePostBuffer(InvoicePostBuffer: Record "49")
    begin
        "Account No." := InvoicePostBuffer."G/L Account";
        "System-Created Entry" := InvoicePostBuffer."System-Created Entry";
        "Gen. Bus. Posting Group" := InvoicePostBuffer."Gen. Bus. Posting Group";
        "Gen. Prod. Posting Group" := InvoicePostBuffer."Gen. Prod. Posting Group";
        "VAT Bus. Posting Group" := InvoicePostBuffer."VAT Bus. Posting Group";
        "VAT Prod. Posting Group" := InvoicePostBuffer."VAT Prod. Posting Group";
        "Tax Area Code" := InvoicePostBuffer."Tax Area Code";
        "Tax Liable" := InvoicePostBuffer."Tax Liable";
        "Tax Group Code" := InvoicePostBuffer."Tax Group Code";
        "Use Tax" := InvoicePostBuffer."Use Tax";
        Quantity := InvoicePostBuffer.Quantity;
        "VAT %" := InvoicePostBuffer."VAT %";
        "VAT Calculation Type" := InvoicePostBuffer."VAT Calculation Type";
        "VAT Posting" := "VAT Posting"::"Manual VAT Entry";
        "Job No." := InvoicePostBuffer."Job No.";
        "Deferral Code" := InvoicePostBuffer."Deferral Code";
        "Deferral Line No." := InvoicePostBuffer."Deferral Line No.";
        Amount := InvoicePostBuffer.Amount;
        "Source Currency Amount" := InvoicePostBuffer."Amount (ACY)";
        "VAT Base Amount" := InvoicePostBuffer."VAT Base Amount";
        "Source Curr. VAT Base Amount" := InvoicePostBuffer."VAT Base Amount (ACY)";
        "VAT Amount" := InvoicePostBuffer."VAT Amount";
        "Source Curr. VAT Amount" := InvoicePostBuffer."VAT Amount (ACY)";
        "VAT Difference" := InvoicePostBuffer."VAT Difference";
    end;

    procedure CopyFromInvoicePostBufferFA(InvoicePostBuffer: Record "49")
    begin
        "Account Type" := "Account Type"::"Fixed Asset";
        "FA Posting Date" := InvoicePostBuffer."FA Posting Date";
        "Depreciation Book Code" := InvoicePostBuffer."Depreciation Book Code";
        "Salvage Value" := InvoicePostBuffer."Salvage Value";
        "Depr. until FA Posting Date" := InvoicePostBuffer."Depr. until FA Posting Date";
        "Depr. Acquisition Cost" := InvoicePostBuffer."Depr. Acquisition Cost";
        "Maintenance Code" := InvoicePostBuffer."Maintenance Code";
        "Insurance No." := InvoicePostBuffer."Insurance No.";
        "Budgeted FA No." := InvoicePostBuffer."Budgeted FA No.";
        "Duplicate in Depreciation Book" := InvoicePostBuffer."Duplicate in Depreciation Book";
        "Use Duplication List" := InvoicePostBuffer."Use Duplication List";
         GetDerogatorySetup;
    end;

    procedure CopyFromPrepmtInvoiceBuffer(PrepmtInvLineBuffer: Record "461")
    begin
        "Account No." := PrepmtInvLineBuffer."G/L Account No.";
        "Gen. Bus. Posting Group" := PrepmtInvLineBuffer."Gen. Bus. Posting Group";
        "Gen. Prod. Posting Group" := PrepmtInvLineBuffer."Gen. Prod. Posting Group";
        "VAT Bus. Posting Group" := PrepmtInvLineBuffer."VAT Bus. Posting Group";
        "VAT Prod. Posting Group" := PrepmtInvLineBuffer."VAT Prod. Posting Group";
        "Tax Area Code" := PrepmtInvLineBuffer."Tax Area Code";
        "Tax Liable" := PrepmtInvLineBuffer."Tax Liable";
        "Tax Group Code" := PrepmtInvLineBuffer."Tax Group Code";
        "Use Tax" := FALSE;
        "VAT Calculation Type" := PrepmtInvLineBuffer."VAT Calculation Type";
        "Job No." := PrepmtInvLineBuffer."Job No.";
        Amount := PrepmtInvLineBuffer.Amount;
        "Source Currency Amount" := PrepmtInvLineBuffer."Amount (ACY)";
        "VAT Base Amount" := PrepmtInvLineBuffer."VAT Base Amount";
        "Source Curr. VAT Base Amount" := PrepmtInvLineBuffer."VAT Base Amount (ACY)";
        "VAT Amount" := PrepmtInvLineBuffer."VAT Amount";
        "Source Curr. VAT Amount" := PrepmtInvLineBuffer."VAT Amount (ACY)";
        "VAT Difference" := PrepmtInvLineBuffer."VAT Difference";
    end;

    procedure CopyFromPurchHeader(PurchHeader: Record "38")
    begin
        "Source Currency Code" := PurchHeader."Currency Code";
        "Currency Factor" := PurchHeader."Currency Factor";
        Correction := PurchHeader.Correction;
        "VAT Base Discount %" := PurchHeader."VAT Base Discount %";
        "Sell-to/Buy-from No." := PurchHeader."Buy-from Vendor No.";
        "Bill-to/Pay-to No." := PurchHeader."Pay-to Vendor No.";
        "Country/Region Code" := PurchHeader."VAT Country/Region Code";
        "VAT Registration No." := PurchHeader."VAT Registration No.";
        "Source Type" := "Source Type"::Vendor;
        "Source No." := PurchHeader."Pay-to Vendor No.";
        "Posting No. Series" := PurchHeader."Posting No. Series";
        "IC Partner Code" := PurchHeader."Pay-to IC Partner Code";
        "Ship-to/Order Address Code" := PurchHeader."Order Address Code";
        "Salespers./Purch. Code" := PurchHeader."Purchaser Code";
        "On Hold" := PurchHeader."On Hold";
        IF "Account Type" = "Account Type"::Vendor THEN
          "Posting Group" := PurchHeader."Vendor Posting Group";
        //>>MIGRATION NAV 2013 - 2017
        //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout code pr r‚cup‚rer Tiers payeur
        "Pay-to No." := PurchHeader."Pay-to Vend. No.";
        //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout code pr r‚cup‚rer Tiers payeur
        //<<MIGRATION NAV 2013 - 2017
    end;

    procedure CopyFromPurchHeaderPrepmt(PurchHeader: Record "38")
    begin
        "Source Currency Code" := PurchHeader."Currency Code";
        "VAT Base Discount %" := PurchHeader."VAT Base Discount %";
        "Bill-to/Pay-to No." := PurchHeader."Pay-to Vendor No.";
        "Country/Region Code" := PurchHeader."VAT Country/Region Code";
        "VAT Registration No." := PurchHeader."VAT Registration No.";
        "Source Type" := "Source Type"::Vendor;
        "Source No." := PurchHeader."Pay-to Vendor No.";
        "IC Partner Code" := PurchHeader."Buy-from IC Partner Code";
        "VAT Posting" := "VAT Posting"::"Manual VAT Entry";
        "System-Created Entry" := TRUE;
        Prepayment := TRUE;
    end;

    procedure CopyFromPurchHeaderPrepmtPost(PurchHeader: Record "38";UsePmtDisc: Boolean)
    begin
        "Account Type" := "Account Type"::Vendor;
        "Account No." := PurchHeader."Pay-to Vendor No.";
        SetCurrencyFactor(PurchHeader."Currency Code",PurchHeader."Currency Factor");
        "Source Currency Code" := PurchHeader."Currency Code";
        "Bill-to/Pay-to No." := PurchHeader."Pay-to Vendor No.";
        "Sell-to/Buy-from No." := PurchHeader."Buy-from Vendor No.";
        "Salespers./Purch. Code" := PurchHeader."Purchaser Code";
        "Source Type" := "Source Type"::Customer;
        "Source No." := PurchHeader."Pay-to Vendor No.";
        "IC Partner Code" := PurchHeader."Buy-from IC Partner Code";
        "System-Created Entry" := TRUE;
        Prepayment := TRUE;
        "Due Date" := PurchHeader."Prepayment Due Date";
        "Payment Terms Code" := PurchHeader."Payment Terms Code";
        IF UsePmtDisc THEN BEGIN
          "Pmt. Discount Date" := PurchHeader."Prepmt. Pmt. Discount Date";
          "Payment Discount %" := PurchHeader."Prepmt. Payment Discount %";
        END;
    end;

    procedure CopyFromPurchHeaderApplyTo(PurchHeader: Record "38")
    begin
        "Applies-to Doc. Type" := PurchHeader."Applies-to Doc. Type";
        "Applies-to Doc. No." := PurchHeader."Applies-to Doc. No.";
        "Applies-to ID" := PurchHeader."Applies-to ID";
        "Allow Application" := PurchHeader."Bal. Account No." = '';
    end;

    procedure CopyFromPurchHeaderPayment(PurchHeader: Record "38")
    begin
        "Due Date" := PurchHeader."Due Date";
        "Payment Terms Code" := PurchHeader."Payment Terms Code";
        "Pmt. Discount Date" := PurchHeader."Pmt. Discount Date";
        "Payment Discount %" := PurchHeader."Payment Discount %";
        "Creditor No." := PurchHeader."Creditor No.";
        "Payment Reference" := PurchHeader."Payment Reference";
        "Payment Method Code" := PurchHeader."Payment Method Code";
    end;

    procedure CopyFromSalesHeader(SalesHeader: Record "36")
    begin
        "Source Currency Code" := SalesHeader."Currency Code";
        "Currency Factor" := SalesHeader."Currency Factor";
        "VAT Base Discount %" := SalesHeader."VAT Base Discount %";
        Correction := SalesHeader.Correction;
        "EU 3-Party Trade" := SalesHeader."EU 3-Party Trade";
        "Sell-to/Buy-from No." := SalesHeader."Sell-to Customer No.";
        "Bill-to/Pay-to No." := SalesHeader."Bill-to Customer No.";
        "Country/Region Code" := SalesHeader."VAT Country/Region Code";
        "VAT Registration No." := SalesHeader."VAT Registration No.";
        "Source Type" := "Source Type"::Customer;
        "Source No." := SalesHeader."Bill-to Customer No.";
        "Posting No. Series" := SalesHeader."Posting No. Series";
        "Ship-to/Order Address Code" := SalesHeader."Ship-to Code";
        "IC Partner Code" := SalesHeader."Sell-to IC Partner Code";
        "Salespers./Purch. Code" := SalesHeader."Salesperson Code";
        "On Hold" := SalesHeader."On Hold";
        IF "Account Type" = "Account Type"::Customer THEN
          "Posting Group" := SalesHeader."Customer Posting Group";
        //>>MIGRATION NAV 2013 - 2017
        //>>REGLEMENT STLA 01.08.2006 COR001 [13] Mise … jour du champ Mode de r‚glement de la feuille de saisie
        "Payment Method Code" := "Payment Method Code";
        //<<REGLEMENT STLA 01.08.2006 COR001 [13] Mise … jour du champ Mode de r‚glement de la feuille de saisie
        //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout code pr r‚cup‚rer Tiers payeur
        "Pay-to No." := SalesHeader."Pay-to Customer No.";
        //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout code pr r‚cup‚rer Tiers payeur
        //<<MIGRATION NAV 2013 - 2017
    end;

    procedure CopyFromSalesHeaderPrepmt(SalesHeader: Record "36")
    begin
        "Source Currency Code" := SalesHeader."Currency Code";
        "VAT Base Discount %" := SalesHeader."VAT Base Discount %";
        "EU 3-Party Trade" := SalesHeader."EU 3-Party Trade";
        "Bill-to/Pay-to No." := SalesHeader."Bill-to Customer No.";
        "Country/Region Code" := SalesHeader."VAT Country/Region Code";
        "VAT Registration No." := SalesHeader."VAT Registration No.";
        "Source Type" := "Source Type"::Customer;
        "Source No." := SalesHeader."Bill-to Customer No.";
        "IC Partner Code" := SalesHeader."Sell-to IC Partner Code";
        "VAT Posting" := "VAT Posting"::"Manual VAT Entry";
        "System-Created Entry" := TRUE;
        Prepayment := TRUE;
    end;

    procedure CopyFromSalesHeaderPrepmtPost(SalesHeader: Record "36";UsePmtDisc: Boolean)
    begin
        "Account Type" := "Account Type"::Customer;
        "Account No." := SalesHeader."Bill-to Customer No.";
        SetCurrencyFactor(SalesHeader."Currency Code",SalesHeader."Currency Factor");
        "Source Currency Code" := SalesHeader."Currency Code";
        "Sell-to/Buy-from No." := SalesHeader."Sell-to Customer No.";
        "Bill-to/Pay-to No." := SalesHeader."Bill-to Customer No.";
        "Salespers./Purch. Code" := SalesHeader."Salesperson Code";
        "Source Type" := "Source Type"::Customer;
        "Source No." := SalesHeader."Bill-to Customer No.";
        "IC Partner Code" := SalesHeader."Sell-to IC Partner Code";
        "System-Created Entry" := TRUE;
        Prepayment := TRUE;
        "Due Date" := SalesHeader."Prepayment Due Date";
        "Payment Terms Code" := SalesHeader."Prepmt. Payment Terms Code";
        IF UsePmtDisc THEN BEGIN
          "Pmt. Discount Date" := SalesHeader."Prepmt. Pmt. Discount Date";
          "Payment Discount %" := SalesHeader."Prepmt. Payment Discount %";
        END;
    end;

    procedure CopyFromSalesHeaderApplyTo(SalesHeader: Record "36")
    begin
        "Applies-to Doc. Type" := SalesHeader."Applies-to Doc. Type";
        "Applies-to Doc. No." := SalesHeader."Applies-to Doc. No.";
        "Applies-to ID" := SalesHeader."Applies-to ID";
        "Allow Application" := SalesHeader."Bal. Account No." = '';
    end;

    procedure CopyFromSalesHeaderPayment(SalesHeader: Record "36")
    begin
        "Due Date" := SalesHeader."Due Date";
        "Payment Terms Code" := SalesHeader."Payment Terms Code";
        "Payment Method Code" := SalesHeader."Payment Method Code";
        "Pmt. Discount Date" := SalesHeader."Pmt. Discount Date";
        "Payment Discount %" := SalesHeader."Payment Discount %";
        "Direct Debit Mandate ID" := SalesHeader."Direct Debit Mandate ID";
    end;

    procedure CopyFromServiceHeader(ServiceHeader: Record "5900")
    begin
        "Source Currency Code" := ServiceHeader."Currency Code";
        Correction := ServiceHeader.Correction;
        "VAT Base Discount %" := ServiceHeader."VAT Base Discount %";
        "Sell-to/Buy-from No." := ServiceHeader."Customer No.";
        "Bill-to/Pay-to No." := ServiceHeader."Bill-to Customer No.";
        "Country/Region Code" := ServiceHeader."VAT Country/Region Code";
        "VAT Registration No." := ServiceHeader."VAT Registration No.";
        "Source Type" := "Source Type"::Customer;
        "Source No." := ServiceHeader."Bill-to Customer No.";
        "Posting No. Series" := ServiceHeader."Posting No. Series";
        "Ship-to/Order Address Code" := ServiceHeader."Ship-to Code";
        "EU 3-Party Trade" := ServiceHeader."EU 3-Party Trade";
        "Salespers./Purch. Code" := ServiceHeader."Salesperson Code";
    end;

    procedure CopyFromServiceHeaderApplyTo(ServiceHeader: Record "5900")
    begin
        "Applies-to Doc. Type" := ServiceHeader."Applies-to Doc. Type";
        "Applies-to Doc. No." := ServiceHeader."Applies-to Doc. No.";
        "Applies-to ID" := ServiceHeader."Applies-to ID";
        "Allow Application" := ServiceHeader."Bal. Account No." = '';
    end;

    procedure CopyFromServiceHeaderPayment(ServiceHeader: Record "5900")
    begin
        "Due Date" := ServiceHeader."Due Date";
        "Payment Terms Code" := ServiceHeader."Payment Terms Code";
        "Payment Method Code" := ServiceHeader."Payment Method Code";
        "Pmt. Discount Date" := ServiceHeader."Pmt. Discount Date";
        "Payment Discount %" := ServiceHeader."Payment Discount %";
    end;

    local procedure SetAmountWithCustLedgEntry()
    begin
        IF "Currency Code" <> CustLedgEntry."Currency Code" THEN
          CheckModifyCurrencyCode(GenJnlLine."Account Type"::Customer,CustLedgEntry."Currency Code");
        IF Amount = 0 THEN BEGIN
          CustLedgEntry.CALCFIELDS("Remaining Amount");
          SetAmountWithRemaining(
            PaymentToleranceMgt.CheckCalcPmtDiscGenJnlCust(Rec,CustLedgEntry,0,FALSE),
            CustLedgEntry."Amount to Apply",CustLedgEntry."Remaining Amount",CustLedgEntry."Remaining Pmt. Disc. Possible");
        END;
    end;

    local procedure SetAmountWithVendLedgEntry()
    begin
        IF "Currency Code" <> VendLedgEntry."Currency Code" THEN
          CheckModifyCurrencyCode("Account Type"::Vendor,VendLedgEntry."Currency Code");
        IF Amount = 0 THEN BEGIN
          VendLedgEntry.CALCFIELDS("Remaining Amount");
          SetAmountWithRemaining(
            PaymentToleranceMgt.CheckCalcPmtDiscGenJnlVend(Rec,VendLedgEntry,0,FALSE),
            VendLedgEntry."Amount to Apply",VendLedgEntry."Remaining Amount",VendLedgEntry."Remaining Pmt. Disc. Possible");
        END;
    end;

    procedure CheckModifyCurrencyCode(AccountType: Option;CustVendLedgEntryCurrencyCode: Code[10])
    begin
        IF Amount = 0 THEN BEGIN
          FromCurrencyCode := GetShowCurrencyCode("Currency Code");
          ToCurrencyCode := GetShowCurrencyCode(CustVendLedgEntryCurrencyCode);
          IF NOT
             CONFIRM(
               Text003,TRUE,FIELDCAPTION("Currency Code"),TABLECAPTION,FromCurrencyCode,ToCurrencyCode)
          THEN
            ERROR(Text005);
          VALIDATE("Currency Code",CustVendLedgEntryCurrencyCode);
        END ELSE
          GenJnlApply.CheckAgainstApplnCurrency(
            "Currency Code",CustVendLedgEntryCurrencyCode,AccountType,TRUE);
    end;

    local procedure SetAmountWithRemaining(CalcPmtDisc: Boolean;AmountToApply: Decimal;RemainingAmount: Decimal;RemainingPmtDiscPossible: Decimal)
    begin
        IF AmountToApply <> 0 THEN
          IF CalcPmtDisc AND (ABS(AmountToApply) >= ABS(RemainingAmount - RemainingPmtDiscPossible)) THEN
            Amount := -(RemainingAmount - RemainingPmtDiscPossible)
          ELSE
            Amount := -AmountToApply
        ELSE
          IF CalcPmtDisc THEN
            Amount := -(RemainingAmount - RemainingPmtDiscPossible)
          ELSE
            Amount := -RemainingAmount;
        IF "Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor] THEN
          Amount := -Amount;
        VALIDATE(Amount);
    end;

    procedure IsOpenedFromBatch(): Boolean
    var
        GenJournalBatch: Record "232";
        TemplateFilter: Text;
        BatchFilter: Text;
    begin
        BatchFilter := GETFILTER("Journal Batch Name");
        IF BatchFilter <> '' THEN BEGIN
          TemplateFilter := GETFILTER("Journal Template Name");
          IF TemplateFilter <> '' THEN
            GenJournalBatch.SETFILTER("Journal Template Name",TemplateFilter);
          GenJournalBatch.SETFILTER(Name,BatchFilter);
          GenJournalBatch.FINDFIRST;
        END;

        EXIT((("Journal Batch Name" <> '') AND ("Journal Template Name" = '')) OR (BatchFilter <> ''));
    end;

    procedure GetDeferralAmount() DeferralAmount: Decimal
    begin
        IF "VAT Base Amount" <> 0 THEN
          DeferralAmount := "VAT Base Amount"
        ELSE
          DeferralAmount := Amount;
    end;

    procedure ShowDeferrals(PostingDate: Date;CurrencyCode: Code[10]): Boolean
    var
        DeferralUtilities: Codeunit "1720";
    begin
        EXIT(
          DeferralUtilities.OpenLineScheduleEdit(
            "Deferral Code",GetDeferralDocType,"Journal Template Name","Journal Batch Name",0,'',"Line No.",
            GetDeferralAmount,PostingDate,Description,CurrencyCode));
    end;

    procedure GetDeferralDocType(): Integer
    begin
        EXIT(DeferralDocType::"G/L");
    end;

    procedure IsForPurchase(): Boolean
    begin
        IF ("Account Type" = "Account Type"::Vendor) OR ("Bal. Account Type" = "Bal. Account Type"::Vendor) THEN
          EXIT(TRUE);

        EXIT(FALSE);
    end;

    procedure IsForSales(): Boolean
    begin
        IF ("Account Type" = "Account Type"::Customer) OR ("Bal. Account Type" = "Bal. Account Type"::Customer) THEN
          EXIT(TRUE);

        EXIT(FALSE);
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnCheckGenJournalLinePostRestrictions()
    begin
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnCheckGenJournalLinePrintCheckRestrictions()
    begin
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnMoveGenJournalLine(ToRecordID: RecordID)
    begin
    end;

    local procedure IncrementDocumentNo()
    var
        NoSeriesLine: Record "309";
    begin
        IF GenJnlBatch."No. Series" <> '' THEN BEGIN
          NoSeriesMgt.SetNoSeriesLineFilter(NoSeriesLine,GenJnlBatch."No. Series","Posting Date");
          IF NoSeriesLine."Increment-by No." > 1 THEN
            NoSeriesMgt.IncrementNoText("Document No.",NoSeriesLine."Increment-by No.")
          ELSE
            "Document No." := INCSTR("Document No.");
        END ELSE
          "Document No." := INCSTR("Document No.");
    end;

    procedure NeedCheckZeroAmount(): Boolean
    begin
        EXIT(
          ("Account No." <> '') AND
          NOT "System-Created Entry" AND
          NOT "Allow Zero-Amount Posting" AND
          ("Account Type" <> "Account Type"::"Fixed Asset"));
    end;

    procedure IsRecurring(): Boolean
    var
        GenJournalTemplate: Record "80";
    begin
        IF "Journal Template Name" <> '' THEN
          IF GenJournalTemplate.GET("Journal Template Name") THEN
            EXIT(GenJournalTemplate.Recurring);

        EXIT(FALSE);
    end;

    local procedure GetGLAccount()
    var
        GLAcc: Record "15";
    begin
        GLAcc.GET("Account No.");
        CheckGLAcc(GLAcc);
        IF ReplaceDescription AND (NOT GLAcc."Omit Default Descr. in Jnl.") THEN
          UpdateDescription(GLAcc.Name)
        ELSE
          IF GLAcc."Omit Default Descr. in Jnl." THEN
            Description := '';
        IF ("Bal. Account No." = '') OR
           ("Bal. Account Type" IN
            ["Bal. Account Type"::"G/L Account","Bal. Account Type"::"Bank Account"])
        THEN BEGIN
          "Posting Group" := '';
          "Salespers./Purch. Code" := '';
          "Payment Terms Code" := '';
        END;
        IF "Bal. Account No." = '' THEN
          "Currency Code" := '';
        IF NOT GenJnlBatch.GET("Journal Template Name","Journal Batch Name") OR
           GenJnlBatch."Copy VAT Setup to Jnl. Lines"
        THEN BEGIN
          "Gen. Posting Type" := GLAcc."Gen. Posting Type";
          "Gen. Bus. Posting Group" := GLAcc."Gen. Bus. Posting Group";
          "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
          "VAT Bus. Posting Group" := GLAcc."VAT Bus. Posting Group";
          "VAT Prod. Posting Group" := GLAcc."VAT Prod. Posting Group";
        END;
        "Tax Area Code" := GLAcc."Tax Area Code";
        "Tax Liable" := GLAcc."Tax Liable";
        "Tax Group Code" := GLAcc."Tax Group Code";
        IF "Posting Date" <> 0D THEN
          IF "Posting Date" = CLOSINGDATE("Posting Date") THEN
            ClearPostingGroups;
        VALIDATE("Deferral Code",GLAcc."Default Deferral Template Code");
    end;

    local procedure GetGLBalAccount()
    var
        GLAcc: Record "15";
    begin
        GLAcc.GET("Bal. Account No.");
        CheckGLAcc(GLAcc);
        IF "Account No." = '' THEN BEGIN
          Description := GLAcc.Name;
          "Currency Code" := '';
        END;
        IF ("Account No." = '') OR
           ("Account Type" IN
            ["Account Type"::"G/L Account","Account Type"::"Bank Account"])
        THEN BEGIN
          "Posting Group" := '';
          "Salespers./Purch. Code" := '';
          "Payment Terms Code" := '';
        END;
        IF NOT GenJnlBatch.GET("Journal Template Name","Journal Batch Name") OR
           GenJnlBatch."Copy VAT Setup to Jnl. Lines"
        THEN BEGIN
          "Bal. Gen. Posting Type" := GLAcc."Gen. Posting Type";
          "Bal. Gen. Bus. Posting Group" := GLAcc."Gen. Bus. Posting Group";
          "Bal. Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
          "Bal. VAT Bus. Posting Group" := GLAcc."VAT Bus. Posting Group";
          "Bal. VAT Prod. Posting Group" := GLAcc."VAT Prod. Posting Group";
        END;
        "Bal. Tax Area Code" := GLAcc."Tax Area Code";
        "Bal. Tax Liable" := GLAcc."Tax Liable";
        "Bal. Tax Group Code" := GLAcc."Tax Group Code";
        IF "Posting Date" <> 0D THEN
          IF "Posting Date" = CLOSINGDATE("Posting Date") THEN
            ClearBalancePostingGroups;
    end;

    local procedure GetCustomerBalAccount()
    var
        Cust: Record "18";
    begin
        Cust.GET("Bal. Account No.");
        Cust.CheckBlockedCustOnJnls(Cust,"Document Type",FALSE);
        CheckICPartner(Cust."IC Partner Code","Bal. Account Type","Bal. Account No.");
        IF "Account No." = '' THEN
          Description := Cust.Name;
        "Payment Method Code" := Cust."Payment Method Code";
        VALIDATE("Recipient Bank Account",Cust."Preferred Bank Account Code");
        "Posting Group" := Cust."Customer Posting Group";
        "Salespers./Purch. Code" := Cust."Salesperson Code";
        "Payment Terms Code" := Cust."Payment Terms Code";
        VALIDATE("Bill-to/Pay-to No.","Bal. Account No.");
        VALIDATE("Sell-to/Buy-from No.","Bal. Account No.");
        IF ("Account No." = '') OR ("Account Type" = "Account Type"::"G/L Account") THEN
          "Currency Code" := Cust."Currency Code";
        IF ("Account Type" = "Account Type"::"Bank Account") AND ("Currency Code" = '') THEN
          "Currency Code" := Cust."Currency Code";
        ClearBalancePostingGroups;
        IF (Cust."Bill-to Customer No." <> '') AND (Cust."Bill-to Customer No." <> "Bal. Account No.") THEN
          IF NOT CONFIRM(Text014,FALSE,Cust.TABLECAPTION,Cust."No.",Cust.FIELDCAPTION("Bill-to Customer No."),
               Cust."Bill-to Customer No.")
          THEN
            ERROR('');
        VALIDATE("Payment Terms Code");
        CheckPaymentTolerance;
    end;

    local procedure GetVendorAccount()
    var
        Vend: Record "23";
    begin
        Vend.GET("Account No.");
        Vend.CheckBlockedVendOnJnls(Vend,"Document Type",FALSE);
        CheckICPartner(Vend."IC Partner Code","Account Type","Account No.");
        UpdateDescription(Vend.Name);
        "Payment Method Code" := Vend."Payment Method Code";
        "Creditor No." := Vend."Creditor No.";
        VALIDATE("Recipient Bank Account",Vend."Preferred Bank Account Code");
        "Posting Group" := Vend."Vendor Posting Group";
        "Salespers./Purch. Code" := Vend."Purchaser Code";
        "Payment Terms Code" := Vend."Payment Terms Code";
        VALIDATE("Bill-to/Pay-to No.","Account No.");
        VALIDATE("Sell-to/Buy-from No.","Account No.");
        IF NOT SetCurrencyCode("Bal. Account Type","Bal. Account No.") THEN
          "Currency Code" := Vend."Currency Code";
        ClearPostingGroups;
        IF (Vend."Pay-to Vendor No." <> '') AND (Vend."Pay-to Vendor No." <> "Account No.") AND
           NOT HideValidationDialog
        THEN
          IF NOT CONFIRM(Text014,FALSE,Vend.TABLECAPTION,Vend."No.",Vend.FIELDCAPTION("Pay-to Vendor No."),
               Vend."Pay-to Vendor No.")
          THEN
            ERROR('');
        VALIDATE("Payment Terms Code");
        CheckPaymentTolerance;
    end;

    local procedure GetVendorBalAccount()
    var
        Vend: Record "23";
    begin
        Vend.GET("Bal. Account No.");
        Vend.CheckBlockedVendOnJnls(Vend,"Document Type",FALSE);
        CheckICPartner(Vend."IC Partner Code","Bal. Account Type","Bal. Account No.");
        IF "Account No." = '' THEN
          Description := Vend.Name;
        "Payment Method Code" := Vend."Payment Method Code";
        VALIDATE("Recipient Bank Account",Vend."Preferred Bank Account Code");
        "Posting Group" := Vend."Vendor Posting Group";
        "Salespers./Purch. Code" := Vend."Purchaser Code";
        "Payment Terms Code" := Vend."Payment Terms Code";
        VALIDATE("Bill-to/Pay-to No.","Bal. Account No.");
        VALIDATE("Sell-to/Buy-from No.","Bal. Account No.");
        IF ("Account No." = '') OR ("Account Type" = "Account Type"::"G/L Account") THEN
          "Currency Code" := Vend."Currency Code";
        IF ("Account Type" = "Account Type"::"Bank Account") AND ("Currency Code" = '') THEN
          "Currency Code" := Vend."Currency Code";
        ClearBalancePostingGroups;
        IF (Vend."Pay-to Vendor No." <> '') AND (Vend."Pay-to Vendor No." <> "Bal. Account No.") AND
           NOT HideValidationDialog
        THEN
          IF NOT CONFIRM(Text014,FALSE,Vend.TABLECAPTION,Vend."No.",Vend.FIELDCAPTION("Pay-to Vendor No."),
               Vend."Pay-to Vendor No.")
          THEN
            ERROR('');
        VALIDATE("Payment Terms Code");
        CheckPaymentTolerance;
    end;

    local procedure GetBankAccount()
    var
        BankAcc: Record "270";
    begin
        BankAcc.GET("Account No.");
        BankAcc.TESTFIELD(Blocked,FALSE);
        IF ReplaceDescription THEN
          UpdateDescription(BankAcc.Name);
        IF ("Bal. Account No." = '') OR
           ("Bal. Account Type" IN
            ["Bal. Account Type"::"G/L Account","Bal. Account Type"::"Bank Account"])
        THEN BEGIN
          "Posting Group" := '';
          "Salespers./Purch. Code" := '';
          "Payment Terms Code" := '';
        END;
        IF BankAcc."Currency Code" = '' THEN BEGIN
          IF "Bal. Account No." = '' THEN
            "Currency Code" := '';
        END ELSE
          IF SetCurrencyCode("Bal. Account Type","Bal. Account No.") THEN
            BankAcc.TESTFIELD("Currency Code","Currency Code")
          ELSE
            "Currency Code" := BankAcc."Currency Code";
        ClearPostingGroups;
    end;

    local procedure GetBankBalAccount()
    var
        BankAcc: Record "270";
    begin
        BankAcc.GET("Bal. Account No.");
        BankAcc.TESTFIELD(Blocked,FALSE);
        IF "Account No." = '' THEN
          Description := BankAcc.Name;

        IF ("Account No." = '') OR
           ("Account Type" IN
            ["Account Type"::"G/L Account","Account Type"::"Bank Account"])
        THEN BEGIN
          "Posting Group" := '';
          "Salespers./Purch. Code" := '';
          "Payment Terms Code" := '';
        END;
        IF BankAcc."Currency Code" = '' THEN BEGIN
          IF "Account No." = '' THEN
            "Currency Code" := '';
        END ELSE
          IF SetCurrencyCode("Bal. Account Type","Bal. Account No.") THEN
            BankAcc.TESTFIELD("Currency Code","Currency Code")
          ELSE
            "Currency Code" := BankAcc."Currency Code";
        ClearBalancePostingGroups;
    end;

    local procedure GetFAAccount()
    var
        FA: Record "5600";
    begin
        FA.GET("Account No.");
        FA.TESTFIELD(Blocked,FALSE);
        FA.TESTFIELD(Inactive,FALSE);
        FA.TESTFIELD("Budgeted Asset",FALSE);
        UpdateDescription(FA.Description);
        GetFADeprBook;
        GetFAVATSetup;
        GetFAAddCurrExchRate;
        GetDerogatorySetup;
    end;

    local procedure GetFABalAccount()
    var
        FA: Record "5600";
    begin
        FA.GET("Bal. Account No.");
        FA.TESTFIELD(Blocked,FALSE);
        FA.TESTFIELD(Inactive,FALSE);
        FA.TESTFIELD("Budgeted Asset",FALSE);
        IF "Account No." = '' THEN
          Description := FA.Description;
        GetFADeprBook;
        GetFAVATSetup;
        GetFAAddCurrExchRate;
    end;

    local procedure GetICPartnerAccount()
    var
        ICPartner: Record "413";
    begin
        ICPartner.GET("Account No.");
        ICPartner.CheckICPartner;
        UpdateDescription(ICPartner.Name);
        IF ("Bal. Account No." = '') OR ("Bal. Account Type" = "Bal. Account Type"::"G/L Account") THEN
          "Currency Code" := ICPartner."Currency Code";
        IF ("Bal. Account Type" = "Bal. Account Type"::"Bank Account") AND ("Currency Code" = '') THEN
          "Currency Code" := ICPartner."Currency Code";
        ClearPostingGroups;
        "IC Partner Code" := "Account No.";
    end;

    local procedure GetICPartnerBalAccount()
    var
        ICPartner: Record "413";
    begin
        ICPartner.GET("Bal. Account No.");
        IF "Account No." = '' THEN
          Description := ICPartner.Name;

        IF ("Account No." = '') OR ("Account Type" = "Account Type"::"G/L Account") THEN
          "Currency Code" := ICPartner."Currency Code";
        IF ("Account Type" = "Account Type"::"Bank Account") AND ("Currency Code" = '') THEN
          "Currency Code" := ICPartner."Currency Code";
        ClearBalancePostingGroups;
        "IC Partner Code" := "Bal. Account No.";
    end;

    procedure CreateFAAcquisitionLines(var FAGenJournalLine: Record "81")
    var
        BalancingGenJnlLine: Record "81";
        LocalGlAcc: Record "15";
        FAPostingGr: Record "5606";
    begin
        TESTFIELD("Journal Template Name");
        TESTFIELD("Journal Batch Name");
        TESTFIELD("Posting Date");
        TESTFIELD("Account Type");
        TESTFIELD("Account No.");
        TESTFIELD("Posting Date");

        // Creating Fixed Asset Line
        FAGenJournalLine.INIT;
        FAGenJournalLine.VALIDATE("Journal Template Name","Journal Template Name");
        FAGenJournalLine.VALIDATE("Journal Batch Name","Journal Batch Name");
        FAGenJournalLine.VALIDATE("Line No.",GetNewLineNo("Journal Template Name","Journal Batch Name"));
        FAGenJournalLine.VALIDATE("Document Type","Document Type");
        FAGenJournalLine.VALIDATE("Document No.",GenerateLineDocNo("Journal Batch Name","Posting Date","Journal Template Name"));
        FAGenJournalLine.VALIDATE("Account Type","Account Type");
        FAGenJournalLine.VALIDATE("Account No.","Account No.");
        FAGenJournalLine.VALIDATE(Amount,Amount);
        FAGenJournalLine.VALIDATE("Posting Date","Posting Date");
        FAGenJournalLine.VALIDATE("FA Posting Type","FA Posting Type"::"Acquisition Cost");
        FAGenJournalLine.VALIDATE("External Document No.","External Document No.");
        FAGenJournalLine.INSERT(TRUE);

        // Creating Balancing Line
        BalancingGenJnlLine.COPY(FAGenJournalLine);
        BalancingGenJnlLine.VALIDATE("Account Type","Bal. Account Type");
        BalancingGenJnlLine.VALIDATE("Account No.","Bal. Account No.");
        BalancingGenJnlLine.VALIDATE(Amount,-Amount);
        BalancingGenJnlLine.VALIDATE("Line No.",GetNewLineNo("Journal Template Name","Journal Batch Name"));
        BalancingGenJnlLine.INSERT(TRUE);

        FAGenJournalLine.TESTFIELD("Posting Group");

        // Inserting additional fields in Fixed Asset line required for acquisition
        IF FAPostingGr.GET(FAGenJournalLine."Posting Group") THEN BEGIN
          LocalGlAcc.GET(FAPostingGr."Acquisition Cost Account");
          LocalGlAcc.CheckGLAcc;
          FAGenJournalLine.VALIDATE("Gen. Posting Type",LocalGlAcc."Gen. Posting Type");
          FAGenJournalLine.VALIDATE("Gen. Bus. Posting Group",LocalGlAcc."Gen. Bus. Posting Group");
          FAGenJournalLine.VALIDATE("Gen. Prod. Posting Group",LocalGlAcc."Gen. Prod. Posting Group");
          FAGenJournalLine.VALIDATE("VAT Bus. Posting Group",LocalGlAcc."VAT Bus. Posting Group");
          FAGenJournalLine.VALIDATE("VAT Prod. Posting Group",LocalGlAcc."VAT Prod. Posting Group");
          FAGenJournalLine.VALIDATE("Tax Group Code",LocalGlAcc."Tax Group Code");
          FAGenJournalLine.VALIDATE("VAT Prod. Posting Group");
          FAGenJournalLine.MODIFY(TRUE)
        END;

        // Inserting Source Code
        IF "Source Code" = '' THEN BEGIN
          GenJnlTemplate.GET("Journal Template Name");
          FAGenJournalLine.VALIDATE("Source Code",GenJnlTemplate."Source Code");
          FAGenJournalLine.MODIFY(TRUE);
          BalancingGenJnlLine.VALIDATE("Source Code",GenJnlTemplate."Source Code");
          BalancingGenJnlLine.MODIFY(TRUE);
        END;
    end;

    local procedure GenerateLineDocNo(BatchName: Code[10];PostingDate: Date;TemplateName: Code[20]) DocumentNo: Code[20]
    var
        GenJournalBatch: Record "232";
        NoSeriesManagement: Codeunit "396";
    begin
        GenJournalBatch.GET(TemplateName,BatchName);
        IF GenJournalBatch."No. Series" <> '' THEN
          DocumentNo := NoSeriesManagement.TryGetNextNo(GenJournalBatch."No. Series",PostingDate);
    end;

    local procedure GetFilterAccountNo(): Code[20]
    begin
        IF GETFILTER("Account No.") <> '' THEN
          IF GETRANGEMIN("Account No.") = GETRANGEMAX("Account No.") THEN
            EXIT(GETRANGEMAX("Account No."));
    end;

    procedure SetAccountNoFromFilter()
    var
        AccountNo: Code[20];
    begin
        AccountNo := GetFilterAccountNo;
        IF AccountNo = '' THEN BEGIN
          FILTERGROUP(2);
          AccountNo := GetFilterAccountNo;
          FILTERGROUP(0);
        END;
        IF AccountNo <> '' THEN
          "Account No." := AccountNo;
    end;

    procedure GetNewLineNo(TemplateName: Code[10];BatchName: Code[10]): Integer
    var
        GenJournalLine: Record "81";
    begin
        GenJournalLine.VALIDATE("Journal Template Name",TemplateName);
        GenJournalLine.VALIDATE("Journal Batch Name",BatchName);
        GenJournalLine.SETRANGE("Journal Template Name",TemplateName);
        GenJournalLine.SETRANGE("Journal Batch Name",BatchName);
        IF GenJournalLine.FINDLAST THEN
          EXIT(GenJournalLine."Line No." + 10000);
        EXIT(10000);
    end;

    //Unsupported feature: Property Insertion (Temporary) on "ClearCustVendApplnEntry(PROCEDURE 11).TempCustLedgEntry(Variable 1000)".


    //Unsupported feature: Property Insertion (Temporary) on "ClearCustVendApplnEntry(PROCEDURE 11).TempVendLedgEntry(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "ClearCustVendApplnEntry(PROCEDURE 11).CustEntryEdit(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "ClearCustVendApplnEntry(PROCEDURE 11).VendEntryEdit(Variable 1003)".


    //Unsupported feature: Deletion (VariableCollection) on "ValidateApplyRequirements(PROCEDURE 21).ExchAccGLJnlLine(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "CheckNoCardTransactEntryExist(PROCEDURE 46).GenJnlLine(Parameter 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "CheckNoCardTransactEntryExist(PROCEDURE 46).DOPaymentTransLogEntry(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "CheckNoCardTransactEntryExist(PROCEDURE 46).DOPaymentTransLogMgt(Variable 1003)".


    //Unsupported feature: Deletion (VariableCollection) on "CheckNoCardTransactEntryExist(PROCEDURE 46).DocumentType(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "GetCreditCard(PROCEDURE 47).DOPaymentTransLogEntry(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "ClearPostExchangeEntries(PROCEDURE 42).PostExchField(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "IsExportedToPaymentFile(PROCEDURE 1020).PaymentExportMgt(Variable 1020)".


    var
        Cust: Record "18";
        Vend: Record "23";

    var
        BankAcc: Record "270";

    var
        FADeprBook: Record "5612";

    var
        FA: Record "5600";


    //Unsupported feature: Property Modification (TextConstString) on "Text000(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text000 : ENU=%1 or %2 must be G/L Account or Bank Account.;FRA=%1 ou %2 doit être un compte général ou un compte bancaire.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text000 : @@@="%1=Account Type,%2=Balance Account Type";ENU=%1 or %2 must be a G/L Account or Bank Account.;FRA=%1 ou %2 doit être un compte général ou un compte bancaire.;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text003(Variable 1003)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text003 : ENU=The %1 in the %2 will be changed from %3 to %4.\Do you want to continue?;FRA=Le %1 dans le %2 va passer de %3 à %4.\Voulez-vous continuer ?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text003 : @@@="%1=Caption of Currency Code field, %2=Caption of table Gen Journal, %3=FromCurrencyCode, %4=ToCurrencyCode";ENU=The %1 in the %2 will be changed from %3 to %4.\\Do you want to continue?;FRA=Le %1 dans le %2 va passer de %3 à %4.\\Voulez-vous continuer ?;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text007(Variable 1007)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text007 : ENU=%1 or %2 must be a Bank Account.;FRA=%1 ou %2 doit être un compte bancaire.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text007 : @@@="%1=Account Type,%2=Balance Account Type";ENU=%1 or %2 must be a bank account.;FRA=%1 ou %2 doit être un compte bancaire.;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text014(Variable 1054)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text014 : ENU=The %1 %2 has a %3 %4.\Do you still want to use %1 %2 in this journal line?;FRA=Le/La %1 %2 a un(e) %3 %4.\Souhaitez-vous quand même utiliser %1 %2 dans cette ligne feuille ?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text014 : @@@="%1=Caption of Table Customer, %2=Customer No, %3=Caption of field Bill-to Customer No, %4=Value of Bill-to customer no.";ENU=The %1 %2 has a %3 %4.\\Do you still want to use %1 %2 in this journal line?;FRA=La %2 %1 a un %3 %4.\\Souhaitez-vous quand même utiliser %2 %1 dans cette ligne feuille ?;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "SourceCodeSetup(Variable 1063)".

    //var
        //>>>> ORIGINAL VALUE:
        //SourceCodeSetup : 1063;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //SourceCodeSetup : 1017;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "NotExistErr(Variable 1068)".

    //var
        //>>>> ORIGINAL VALUE:
        //NotExistErr : ENU=Document No. %1 does not exist or is already closed.;FRA=Le N° document %1 n'existe pas ou est déjà fermé.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //NotExistErr : @@@="%1=Document number";ENU=Document number %1 does not exist or is already closed.;FRA=Le numéro de document %1 n'existe pas ou est déjà fermé.;
        //Variable type has not been exported.

    var
        TempJobJnlLine: Record "210" temporary;

    var
        GenJnlShowCTEntries: Codeunit "16";

    var
        DeferralUtilities: Codeunit "1720";
        ApprovalsMgmt: Codeunit "1535";
        Window: Dialog;
        DeferralDocType: Option Purchase,Sales,"G/L";

    var
        ExportAgainQst: Label 'One or more of the selected lines have already been exported. Do you want to export them again?';
        NothingToExportErr: Label 'There is nothing to export.';

    var
        DueDateMsg: Label 'This posting date will cause an overdue payment.';
        CalcPostDateMsg: Label 'Processing payment journal lines #1##########';
}

