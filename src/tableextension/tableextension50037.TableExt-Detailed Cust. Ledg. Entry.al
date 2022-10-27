tableextension 50037 tableextension50037 extends "Detailed Cust. Ledg. Entry"
{
    // <changelog>
    //   <add id="FR0001" dev="EDUBUC" date="2004-08-19" area="PAYMNG"  request="FR-START-40"
    //     releaseversion="FR4.00">Payment management system</add>
    //   <add id="FR0002" dev="KCOOLS" date="2006-09-19" area="LEGALREP" feature="NAVCORS4828"
    //     releaseversion="FR5.00">New key added used in Reports 10806 and 10808</add>
    // </changelog>
    // 
    // 
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ 50003
    // 
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    //      - Add Fields 80802 and 80804..80807
    // ------------------------------------------------------------------------
    LookupPageID = 573;
    DrillDownPageID = 573;
    fields
    {

        //Unsupported feature: Property Deletion (Editable) on ""Application No."(Field 42)".

        field(43; "Ledger Entry Amount"; Boolean)
        {
            Caption = 'Ledger Entry Amount';
            Editable = false;
        }
        field(50003; "Pay-to Customer No."; Code[20])
        {
            Caption = 'Pay-to Customer No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Customer;
        }
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

        //Unsupported feature: Property Modification (SumIndexFields) on ""Cust. Ledger Entry No.,Entry Type,Posting Date"(Key)".


        //Unsupported feature: Property Deletion (MaintainSIFTIndex) on ""Cust. Ledger Entry No.,Entry Type,Posting Date"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Customer No.,Initial Entry Due Date,Posting Date,Currency Code"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Customer No.,Initial Entry Due Date,Posting Date"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Customer No.,Posting Date,Entry Type,Currency Code"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Customer No.,Initial Document Type,Document Type,Entry Type,Posting Date"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Customer No.,Initial Entry Due Date,Posting Date,Initial Entry Global Dim. 1,Initial Entry Global Dim. 2,Currency Code"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Customer No.,Posting Date,Entry Type,Initial Entry Global Dim. 1,Initial Entry Global Dim. 2,Currency Code"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Customer No.,Initial Document Type,Document Type,Entry Type,Initial Entry Global Dim. 1,Initial Entry Global Dim. 2"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Customer No.,Document No.,Posting Date"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Cust. Ledger Entry No."(Key)".

        key(Key1; "Ledger Entry Amount", "Cust. Ledger Entry No.", "Posting Date")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = Amount, "Amount (LCY)", "Debit Amount", "Debit Amount (LCY)", "Credit Amount", "Credit Amount (LCY)";
        }
        key(Key2; "Initial Document Type", "Entry Type", "Customer No.", "Currency Code", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Posting Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = Amount, "Amount (LCY)";
        }
        key(Key3; "Customer No.", "Currency Code", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Initial Entry Due Date", "Posting Date")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }
    }


    //Unsupported feature: Code Insertion on "OnInsert".

    //trigger OnInsert()
    //begin
    /*
    SetLedgerEntryAmount;
    */
    //end;

    local procedure SetLedgerEntryAmount()
    begin
        "Ledger Entry Amount" :=
          NOT (("Entry Type" = "Entry Type"::Application) OR ("Entry Type" = "Entry Type"::"Appln. Rounding"));
    end;

    procedure GetUnrealizedGainLossAmount(EntryNo: Integer): Decimal
    begin
        SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type");
        SETRANGE("Cust. Ledger Entry No.", EntryNo);
        SETRANGE("Entry Type", "Entry Type"::"Unrealized Loss", "Entry Type"::"Unrealized Gain");
        CALCSUMS("Amount (LCY)");
        EXIT("Amount (LCY)");
    end;
}

