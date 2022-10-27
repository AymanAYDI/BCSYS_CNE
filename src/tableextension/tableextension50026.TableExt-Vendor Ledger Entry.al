tableextension 50026 tableextension50026 extends "Vendor Ledger Entry"
{
    // <changelog>
    //   <add id="FR0001" dev="EDUBUC" date="2004-08-19" area="LEGALREP"  request="FR-START-40"
    //     releaseversion="FR4.00">Legal general ledger reports (France)</add>
    //   <change id="FR0002" dev="KCOOLS" date="2005-11-18" area="LEGALREP" feature="10824"
    //     baseversion="FR4.00" releaseversion="FR4.00.02">Non-existing KeyGroup removed</change>
    // </changelog>
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //REGLEMENT   STLA 01.08.2006 COR001 [13]                    Ajout des champs 60000 Mode de réglement et 60001 Condition de paiement
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ 50003
    //                                                              Ajout du Fonction getVendorName()
    //                                                              => permet de renvoyer le Nom du N° fournisseur passé en paramètre
    //                                                              Ajout des clés:
    //                                                              => Pay-to Vend. No.,Open,Positive,Due Date
    //                                                              => Pay-to Vend. No.,Applies-to ID,Vendor No.
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //>>REGLEMENT STLA 01.08.2006 COR001 [13]
    // //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout code pr r‚cup‚rer Tiers payeur
    LookupPageID = 29;
    DrillDownPageID = 29;
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


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Closed by Currency Amount"(Field 66)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Original Amount"(Field 75)".


        //Unsupported feature: Property Modification (Data type) on ""Message to Recipient"(Field 289)".



        //Unsupported feature: Code Insertion on ""Payment Method Code"(Field 172)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            TESTFIELD(Open,TRUE);
            */
        //end;
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
        field(50003;"Pay-to Vend. No.";Code[20])
        {
            Caption = 'Pay-to Vend. No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Vendor;
        }
    }
    keys
    {

        //Unsupported feature: Property Deletion (SIFTLevelsToMaintain) on ""Vendor No.,Posting Date,Currency Code"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Vendor No.,Currency Code,Posting Date"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Vendor No.,Global Dimension 1 Code,Global Dimension 2 Code,Posting Date,Currency Code"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Vendor No.,Open,Global Dimension 1 Code,Global Dimension 2 Code,Positive,Due Date,Currency Code"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Open,Global Dimension 1 Code,Global Dimension 2 Code,Due Date"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Document Type,Vendor No.,Global Dimension 1 Code,Global Dimension 2 Code,Posting Date,Currency Code"(Key)".

        key(Key1;"Pay-to Vend. No.",Open,Positive,"Due Date")
        {
        }
        key(Key2;"Pay-to Vend. No.","Applies-to ID","Vendor No.")
        {
        }
    }


    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 6)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Vendor No." := GenJnlLine."Account No.";
        "Posting Date" := GenJnlLine."Posting Date";
        "Document Date" := GenJnlLine."Document Date";
        #4..28
        "No. Series" := GenJnlLine."Posting No. Series";
        "IC Partner Code" := GenJnlLine."IC Partner Code";
        Prepayment := GenJnlLine.Prepayment;
        "Recipient Bank Account" := GenJnlLine."Recipient Bank Account";
        "Message to Recipient" := GenJnlLine."Message to Recipient";
        "Applies-to Ext. Doc. No." := GenJnlLine."Applies-to Ext. Doc. No.";
        "Creditor No." := GenJnlLine."Creditor No.";
        "Payment Reference" := GenJnlLine."Payment Reference";
        "Payment Method Code" := GenJnlLine."Payment Method Code";
        "Exported to Payment File" := GenJnlLine."Exported to Payment File";
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..31
        //>>MIGRATION NAV 2013
        //>>REGLEMENT STLA 01.08.2006 COR001 [13]
        "Payment Method Code" :=  GenJnlLine."Payment Method Code";
        "Payment Terms Code"  := GenJnlLine."Payment Terms Code";
        //<<REGLEMENT STLA 01.08.2006 COR001 [13]

        //>>NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout code pr r‚cup‚rer Tiers payeur
        "Pay-to Vend. No." := GenJnlLine."Pay-to No.";
        //<<NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout code pr r‚cup‚rer Tiers payeur
        //<<MIGRATION NAV 2013

        #32..38

        OnAfterCopyVendLedgerEntryFromGenJnlLine(Rec,GenJnlLine);
        */
    //end;

    procedure ShowDoc(): Boolean
    var
        PurchInvHeader: Record "122";
        PurchCrMemoHdr: Record "124";
    begin
        CASE "Document Type" OF
          "Document Type"::Invoice:
            IF PurchInvHeader.GET("Document No.") THEN BEGIN
              PAGE.RUN(PAGE::"Posted Purchase Invoice",PurchInvHeader);
              EXIT(TRUE);
            END;
          "Document Type"::"Credit Memo":
            IF PurchCrMemoHdr.GET("Document No.") THEN BEGIN
              PAGE.RUN(PAGE::"Posted Purchase Credit Memo",PurchCrMemoHdr);
              EXIT(TRUE);
            END
        END;
    end;

    procedure "---NSC1.00---"()
    begin
    end;

    procedure getVendorName(CodLVendNo: Code[20]): Text[30]
    var
        RecgLVendor: Record "23";
    begin
        IF RecgLVendor.GET(CodLVendNo) THEN EXIT(RecgLVendor.Name)
        ELSE EXIT('');
    end;

    procedure CopyFromCVLedgEntryBuffer(var CVLedgerEntryBuffer: Record "382")
    begin
        "Entry No." := CVLedgerEntryBuffer."Entry No.";
        "Vendor No." := CVLedgerEntryBuffer."CV No.";
        "Posting Date" := CVLedgerEntryBuffer."Posting Date";
        "Document Type" := CVLedgerEntryBuffer."Document Type";
        "Document No." := CVLedgerEntryBuffer."Document No.";
        Description := CVLedgerEntryBuffer.Description;
        "Currency Code" := CVLedgerEntryBuffer."Currency Code";
        Amount := CVLedgerEntryBuffer.Amount;
        "Remaining Amount" := CVLedgerEntryBuffer."Remaining Amount";
        "Original Amount" := CVLedgerEntryBuffer."Original Amount";
        "Original Amt. (LCY)" := CVLedgerEntryBuffer."Original Amt. (LCY)";
        "Remaining Amt. (LCY)" := CVLedgerEntryBuffer."Remaining Amt. (LCY)";
        "Amount (LCY)" := CVLedgerEntryBuffer."Amount (LCY)";
        "Purchase (LCY)" := CVLedgerEntryBuffer."Sales/Purchase (LCY)";
        "Inv. Discount (LCY)" := CVLedgerEntryBuffer."Inv. Discount (LCY)";
        "Buy-from Vendor No." := CVLedgerEntryBuffer."Bill-to/Pay-to CV No.";
        "Vendor Posting Group" := CVLedgerEntryBuffer."CV Posting Group";
        "Global Dimension 1 Code" := CVLedgerEntryBuffer."Global Dimension 1 Code";
        "Global Dimension 2 Code" := CVLedgerEntryBuffer."Global Dimension 2 Code";
        "Dimension Set ID" := CVLedgerEntryBuffer."Dimension Set ID";
        "Purchaser Code" := CVLedgerEntryBuffer."Salesperson Code";
        "User ID" := CVLedgerEntryBuffer."User ID";
        "Source Code" := CVLedgerEntryBuffer."Source Code";
        "On Hold" := CVLedgerEntryBuffer."On Hold";
        "Applies-to Doc. Type" := CVLedgerEntryBuffer."Applies-to Doc. Type";
        "Applies-to Doc. No." := CVLedgerEntryBuffer."Applies-to Doc. No.";
        Open := CVLedgerEntryBuffer.Open;
        "Due Date" := CVLedgerEntryBuffer."Due Date" ;
        "Pmt. Discount Date" := CVLedgerEntryBuffer."Pmt. Discount Date";
        "Original Pmt. Disc. Possible" := CVLedgerEntryBuffer."Original Pmt. Disc. Possible";
        "Remaining Pmt. Disc. Possible" := CVLedgerEntryBuffer."Remaining Pmt. Disc. Possible";
        "Pmt. Disc. Rcd.(LCY)" := CVLedgerEntryBuffer."Pmt. Disc. Given (LCY)";
        Positive := CVLedgerEntryBuffer.Positive;
        "Closed by Entry No." := CVLedgerEntryBuffer."Closed by Entry No.";
        "Closed at Date" := CVLedgerEntryBuffer."Closed at Date";
        "Closed by Amount" := CVLedgerEntryBuffer."Closed by Amount";
        "Applies-to ID" := CVLedgerEntryBuffer."Applies-to ID";
        "Journal Batch Name" := CVLedgerEntryBuffer."Journal Batch Name";
        "Reason Code" := CVLedgerEntryBuffer."Reason Code";
        "Bal. Account Type" := CVLedgerEntryBuffer."Bal. Account Type";
        "Bal. Account No." := CVLedgerEntryBuffer."Bal. Account No.";
        "Transaction No." := CVLedgerEntryBuffer."Transaction No.";
        "Closed by Amount (LCY)" := CVLedgerEntryBuffer."Closed by Amount (LCY)";
        "Debit Amount" := CVLedgerEntryBuffer."Debit Amount";
        "Credit Amount" := CVLedgerEntryBuffer."Credit Amount";
        "Debit Amount (LCY)" := CVLedgerEntryBuffer."Debit Amount (LCY)";
        "Credit Amount (LCY)" := CVLedgerEntryBuffer."Credit Amount (LCY)";
        "Document Date" := CVLedgerEntryBuffer."Document Date";
        "External Document No." := CVLedgerEntryBuffer."External Document No.";
        "No. Series" := CVLedgerEntryBuffer."No. Series";
        "Closed by Currency Code" := CVLedgerEntryBuffer."Closed by Currency Code";
        "Closed by Currency Amount" := CVLedgerEntryBuffer."Closed by Currency Amount";
        "Adjusted Currency Factor" := CVLedgerEntryBuffer."Adjusted Currency Factor";
        "Original Currency Factor" := CVLedgerEntryBuffer."Original Currency Factor";
        "Pmt. Disc. Tolerance Date" := CVLedgerEntryBuffer."Pmt. Disc. Tolerance Date";
        "Max. Payment Tolerance" := CVLedgerEntryBuffer."Max. Payment Tolerance";
        "Accepted Payment Tolerance" := CVLedgerEntryBuffer."Accepted Payment Tolerance";
        "Accepted Pmt. Disc. Tolerance" := CVLedgerEntryBuffer."Accepted Pmt. Disc. Tolerance";
        "Pmt. Tolerance (LCY)" := CVLedgerEntryBuffer."Pmt. Tolerance (LCY)";
        "Amount to Apply" := CVLedgerEntryBuffer."Amount to Apply";
        Prepayment := CVLedgerEntryBuffer.Prepayment;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCopyVendLedgerEntryFromGenJnlLine(var VendorLedgerEntry: Record "25";var GenJournalLine: Record "81")
    begin
    end;

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: Brick)".

}

