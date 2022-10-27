tableextension 50021 tableextension50021 extends "Cust. Ledger Entry"
{
    // <changelog>
    //   <add id="FR0001" dev="EDUBUC" date="2004-08-19" area="LEGALREP"  request="FR-START-40"
    //     releaseversion="FR4.00">Legal general ledger reports (France)</add>
    //   <change id="FR0002" dev="KCOOLS" date="2005-11-18" area="LEGALREP" feature="10824"
    //     baseversion="FR4.00" releaseversion="FR4.00.02">Non-existing KeyGroup removed</change>
    // </changelog>
    // //REGLEMENT   STLA 01.08.2006 COR001 [13]                    Ajout des champs 50000 Mode de réglement et 50001 Condition de paiement
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ 50003
    //                                                              Ajout du Fonction getCustomerName()
    //                                                              => permet de renvoyer le Nom du N° client passé en paramètre
    //                                                              Ajout des clés:
    //                                                              => Pay-to Customer No.,Open,Positive,Due Date
    //                                                                 Pay-to Customer No.,Applies-to ID,Customer No.
    // 
    // 
    // EnabledField No.Field NameData TypeLengthDescription
    // Yes80800DEEE Category CodeCode10DEEE1.00
    // Yes80802DEEE HT AmountDecimalDEEE1.00
    // Yes80804DEEE VAT AmountDecimalDEEE1.00
    // Yes80805DEEE TTC AmountDecimalDEEE1.00
    // Yes80806DEEE HT Amount (LCY)DecimalDEEE1.00
    // Yes80807Eco partner DEEECode20DEEE1.00
    // 
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    //           - Add fields 80800, 80802, 80804, 80805..80807
    // 
    // //>>CNE1.00
    // FEP-ADVE-200706_18_D:MA 13/11/2007:Statistiques vente
    //                                   -Add key  "Customer No.,Posting Date,Document Type,Salesperson Code"
    // //>>CNE2.05
    // FEP-ADVE-200706_18_D:MA 19/02/2008:Statistiques vente
    //                                   - add key "Salesperson Code,Customer No.,Posting Date"
    //                                   -disable key "Customer No.,Posting Date,Document Type,Salesperson Code"
    // 
    // //>> 21/01/2014 SU-DADE cf appel TI204250
    // //   enlarge return var fct :  getCustomerName()
    // //<< 21/01/2014 SU-DADE cf appel TI204250
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013 - 2017
    // //>>DEEE1.00 : write DEEE descriptions in customer ledger entry (jnp)
    // //>>REGLEMENT STLA 01.08.2006 COR001 [13]
    // //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout code pr recuperer Tiers payeur
    LookupPageID = 25;
    DrillDownPageID = 25;
    fields
    {
        modify(Description)
        {
            Caption = 'Description';
        }

        //Unsupported feature: Property Modification (CalcFormula) on "Amount(Field 13)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Remaining Amount"(Field 14)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Original Amt. (LCY)"(Field 15)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Remaining Amt. (LCY)"(Field 16)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Amount (LCY)"(Field 17)".

        modify("Bal. Account No.")
        {
            TableRelation = IF (Bal. Account Type=CONST(G/L Account)) "G/L Account"
                            ELSE IF (Bal. Account Type=CONST(Customer)) Customer
                            ELSE IF (Bal. Account Type=CONST(Vendor)) Vendor
                            ELSE IF (Bal. Account Type=CONST(Bank Account)) "Bank Account"
                            ELSE IF (Bal. Account Type=CONST(Fixed Asset)) "Fixed Asset";
        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Debit Amount"(Field 58)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Credit Amount"(Field 59)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Debit Amount (LCY)"(Field 60)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Credit Amount (LCY)"(Field 61)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Closed by Currency Amount"(Field 68)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Original Amount"(Field 75)".


        //Unsupported feature: Property Modification (Data type) on ""Message to Recipient"(Field 289)".

        modify("Direct Debit Mandate ID")
        {
            Caption = 'Direct Debit Mandate ID';
        }


        //Unsupported feature: Code Insertion on ""Payment Method Code"(Field 172)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            TESTFIELD(Open,TRUE);
            */
        //end;

        //Unsupported feature: Property Deletion (Editable) on ""Dimension Set ID"(Field 480)".

        field(50000;PaymentMethodCode;Code[10])
        {
            Caption = 'Payment Method Code';
            Description = 'REGLEMENT STLA 01.08.2006 COR001 [13]';
            TableRelation = "Payment Method";
        }
        field(50001;"Payment Terms Code";Code[10])
        {
            Caption = 'Payment Terms Code';
            Description = 'REGLEMENT STLA 01.08.2006 COR001 [13]';
            TableRelation = "Payment Terms";
        }
        field(50003;"Pay-to Customer No.";Code[20])
        {
            Caption = 'Pay-to Customer No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Customer;
        }
        field(80800;"DEEE Category Code";Code[10])
        {
            Caption = 'DEEE Category Code';
            Description = 'DEEE1.00';
            TableRelation = "Categories of item".Category;
        }
        field(80802;"DEEE HT Amount";Decimal)
        {
            Caption = 'Montant HT DEEE';
            Description = 'DEEE1.00';
        }
        field(80804;"DEEE VAT Amount";Decimal)
        {
            Caption = 'Montant TVA DEEE';
            Description = 'DEEE1.00';
        }
        field(80805;"DEEE TTC Amount";Decimal)
        {
            Description = 'DEEE1.00';
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

        //Unsupported feature: Property Deletion (SIFTLevelsToMaintain) on ""Customer No.,Posting Date,Currency Code"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Customer No.,Currency Code,Posting Date"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Salesperson Code,Posting Date"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Customer No.,Open,Positive,Calculate Interest,Due Date"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Customer No.,Global Dimension 1 Code,Global Dimension 2 Code,Posting Date,Currency Code"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Customer No.,Open,Global Dimension 1 Code,Global Dimension 2 Code,Positive,Due Date,Currency Code"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Open,Global Dimension 1 Code,Global Dimension 2 Code,Due Date"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Document Type,Customer No.,Global Dimension 1 Code,Global Dimension 2 Code,Posting Date,Currency Code"(Key)".

        key(Key1;"Pay-to Customer No.",Open,Positive,"Due Date")
        {
        }
        key(Key2;"Pay-to Customer No.","Applies-to ID","Customer No.")
        {
        }
        key(Key3;"Customer No.",Open,Positive,"Customer Posting Group","Due Date")
        {
        }
        key(Key4;"Pay-to Customer No.",Open,Positive,"Customer Posting Group","Due Date")
        {
        }
        key(Key5;"Customer Posting Group","Customer No.")
        {
        }
        key(Key6;"Salesperson Code","Customer No.","Posting Date","Document Type")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = "Sales (LCY)","Profit (LCY)";
        }
        key(Key7;"Document Type","Posting Date")
        {
            SumIndexFields = "Sales (LCY)";
        }
        key(Key8;"Document Type","Customer No.",Open)
        {
        }
    }


    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 6)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Customer No." := GenJnlLine."Account No.";
        "Posting Date" := GenJnlLine."Posting Date";
        "Document Date" := GenJnlLine."Document Date";
        #4..30
        "No. Series" := GenJnlLine."Posting No. Series";
        "IC Partner Code" := GenJnlLine."IC Partner Code";
        Prepayment := GenJnlLine.Prepayment;
        "Recipient Bank Account" := GenJnlLine."Recipient Bank Account";
        "Message to Recipient" := GenJnlLine."Message to Recipient";
        "Applies-to Ext. Doc. No." := GenJnlLine."Applies-to Ext. Doc. No.";
        "Payment Method Code" := GenJnlLine."Payment Method Code";
        "Exported to Payment File" := GenJnlLine."Exported to Payment File";
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..33

        //>>MIGRATION NAV 2013 - 2017
        //>>DEEE1.00 : write DEEE descriptions in customer ledger entry (jnp)
        "DEEE HT Amount"  := GenJnlLine."DEEE HT Amount" ;
        "DEEE VAT Amount" := GenJnlLine."DEEE VAT Amount" ;
        "DEEE TTC Amount" := GenJnlLine."DEEE TTC Amount" ;
        "DEEE HT Amount (LCY)":= GenJnlLine."DEEE HT Amount (LCY)" ;
        "Eco partner DEEE":= GenJnlLine."Eco partner DEEE" ;
        //<<DEEE1.00 : write DEEE descriptions in customer ledger entry (jnp)


        //>>REGLEMENT STLA 01.08.2006 COR001 [13]
        "Payment Method Code" := GenJnlLine."Payment Method Code";
        "Payment Terms Code"  := GenJnlLine."Payment Terms Code";
        //<<REGLEMENT STLA 01.08.2006 COR001 [13]

        //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout code pr r‚cup‚rer Tiers payeur
        "Pay-to Customer No." := GenJnlLine."Pay-to No.";
        //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout code pr r‚cup‚rer Tiers payeur
        //<<MIGRATION NAV 2013 - 2017

        #34..38

        OnAfterCopyCustLedgerEntryFromGenJnlLine(Rec,GenJnlLine);
        */
    //end;

    procedure ShowDoc(): Boolean
    var
        SalesInvoiceHdr: Record "112";
        SalesCrMemoHdr: Record "114";
        ServiceInvoiceHeader: Record "5992";
        ServiceCrMemoHeader: Record "5994";
    begin
        CASE "Document Type" OF
          "Document Type"::Invoice:
            BEGIN
              IF SalesInvoiceHdr.GET("Document No.") THEN BEGIN
                PAGE.RUN(PAGE::"Posted Sales Invoice",SalesInvoiceHdr);
                EXIT(TRUE);
              END;
              IF ServiceInvoiceHeader.GET("Document No.") THEN BEGIN
                PAGE.RUN(PAGE::"Posted Service Invoice",ServiceInvoiceHeader);
                EXIT(TRUE);
              END;
            END;
          "Document Type"::"Credit Memo":
            BEGIN
              IF SalesCrMemoHdr.GET("Document No.") THEN BEGIN
                PAGE.RUN(PAGE::"Posted Sales Credit Memo",SalesCrMemoHdr);
                EXIT(TRUE);
              END;
              IF ServiceCrMemoHeader.GET("Document No.") THEN BEGIN
                PAGE.RUN(PAGE::"Posted Service Credit Memo",ServiceCrMemoHeader);
                EXIT(TRUE);
              END;
            END;
        END;
    end;

    procedure "---NSC1.00---"()
    begin
    end;

    procedure getCustomerName(CodLCustNo: Code[20]): Text[50]
    var
        RecgLCustomer: Record "18";
    begin
        IF RecgLCustomer.GET(CodLCustNo) THEN EXIT(RecgLCustomer.Name)
        ELSE EXIT('');
    end;

    procedure CopyFromCVLedgEntryBuffer(var CVLedgerEntryBuffer: Record "382")
    begin
        TRANSFERFIELDS(CVLedgerEntryBuffer);
        Amount := CVLedgerEntryBuffer.Amount;
        "Amount (LCY)" := CVLedgerEntryBuffer."Amount (LCY)";
        "Remaining Amount" := CVLedgerEntryBuffer."Remaining Amount";
        "Remaining Amt. (LCY)" := CVLedgerEntryBuffer."Remaining Amt. (LCY)";
        "Original Amount" := CVLedgerEntryBuffer."Original Amount";
        "Original Amt. (LCY)" := CVLedgerEntryBuffer."Original Amt. (LCY)";
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "21";var GenJournalLine: Record "81")
    begin
    end;

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: Brick)".

}

