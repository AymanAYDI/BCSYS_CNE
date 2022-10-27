tableextension 50040 tableextension50040 extends "Detailed CV Ledg. Entry Buffer"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    //           - Add fields 80802, 80004..80007
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013 - 2017
    // //>>DEEE1.00 : write DEEE descriptions in customer ledger entry (jnp)
    LookupPageID = 573;
    DrillDownPageID = 573;
    fields
    {
        field(80802; "DEEE HT Amount"; Decimal)
        {
            Caption = 'Montant HT DEEE';
            Description = 'DEEE1.00';
        }
        field(80804; "DEEE VAT Amount"; Decimal)
        {
            Caption = 'Montant TVA DEEE';
            Description = 'DEEE1.00';
        }
        field(80805; "DEEE TTC Amount"; Decimal)
        {
            Description = 'DEEE1.00';
        }
        field(80806; "DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80807; "Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE';
            Description = 'DEEE1.00';
            Editable = false;
            TableRelation = Vendor;
        }
    }
    keys
    {

        //Unsupported feature: Property Deletion (KeyGroups) on ""CV No.,Initial Entry Due Date,Posting Date,Initial Entry Global Dim. 1,Initial Entry Global Dim. 2,Currency Code"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""CV No.,Posting Date,Entry Type,Initial Entry Global Dim. 1,Initial Entry Global Dim. 2,Currency Code"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""CV No.,Initial Document Type,Document Type,Initial Entry Global Dim. 1,Initial Entry Global Dim. 2"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Initial Document Type,CV No.,Posting Date,Currency Code,Entry Type,Initial Entry Global Dim. 1,Initial Entry Global Dim. 2"(Key)".

    }


    //Unsupported feature: Code Modification on "InsertDtldCVLedgEntry(PROCEDURE 53)".

    //procedure InsertDtldCVLedgEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF (DtldCVLedgEntryBuf.Amount = 0) AND
       (DtldCVLedgEntryBuf."Amount (LCY)" = 0) AND
       (DtldCVLedgEntryBuf."Additional-Currency Amount" = 0) AND
       (NOT InsertZeroAmout)
    THEN
    #6..67
      CVLedgEntryBuf."Original Amt. (LCY)" := NewDtldCVLedgEntryBuf."Amount (LCY)";
    END;
    DtldCVLedgEntryBuf.RESET;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF (DtldCVLedgEntryBuf.Amount = 0) AND
       (DtldCVLedgEntryBuf."Amount (LCY)" = 0) AND
       (DtldCVLedgEntryBuf."VAT Amount (LCY)" = 0) AND
    #3..70
    */
    //end;


    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 2)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Entry Type" := "Entry Type"::"Initial Entry";
    "Posting Date" := GenJnlLine."Posting Date";
    "Document Type" := GenJnlLine."Document Type";
    #4..11
    "Initial Entry Global Dim. 1" := GenJnlLine."Shortcut Dimension 1 Code";
    "Initial Entry Global Dim. 2" := GenJnlLine."Shortcut Dimension 2 Code";
    "Initial Document Type" := GenJnlLine."Document Type";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..14
    //>>MIGRATION NAV 2013 - 2017
    //>>DEEE1.00 : write DEEE descriptions in customer ledger entry (jnp)
    "DEEE HT Amount":= GenJnlLine."DEEE HT Amount" ;
    "DEEE VAT Amount":=GenJnlLine."DEEE VAT Amount" ;
    "DEEE TTC Amount":= GenJnlLine."DEEE TTC Amount" ;
    "DEEE HT Amount (LCY)":= GenJnlLine."DEEE HT Amount (LCY)" ;
    "Eco partner DEEE":= GenJnlLine."Eco partner DEEE" ;
    //<<DEEE1.00 : write DEEE descriptions in customer ledger entry (jnp)
    //<<MIGRATION NAV 2013 - 2017
    */
    //end;

    procedure FindVATEntry(var VATEntry: Record "254"; TransactionNo: Integer)
    begin
        VATEntry.RESET;
        VATEntry.SETCURRENTKEY("Transaction No.");
        VATEntry.SETRANGE("Transaction No.", TransactionNo);
        VATEntry.SETRANGE("VAT Bus. Posting Group", "VAT Bus. Posting Group");
        VATEntry.SETRANGE("VAT Prod. Posting Group", "VAT Prod. Posting Group");
        VATEntry.FINDFIRST;
    end;
}

