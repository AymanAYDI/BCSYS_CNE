tableextension 50039 tableextension50039 extends "Detailed Vendor Ledg. Entry"
{
    // <changelog>
    //   <add id="FR0001" dev="EDUBUC" date="2004-08-19" area="PAYMNG"  request="FR-START-40"
    //     releaseversion="FR4.00">Payment management system</add>
    //   <add id="FR0002" dev="KCOOLS" date="2006-09-19" area="LEGALREP" feature="NAVCORS4828"
    //     releaseversion="FR5.00">New key added used in Reports 10806 and 10808</add>
    // </changelog>
    // 
    // 
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    //  //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ 50003
    // 
    // ------------------------------------------------------------------------
    LookupPageID = 574;
    DrillDownPageID = 574;
    fields
    {
        field(43; "Ledger Entry Amount"; Boolean)
        {
            Caption = 'Ledger Entry Amount';
            Editable = false;
        }
        field(50003; "Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Vendor;
        }
    }
    keys
    {

        //Unsupported feature: Property Modification (SumIndexFields) on ""Vendor Ledger Entry No.,Entry Type,Posting Date"(Key)".


        //Unsupported feature: Property Deletion (SumIndexFields) on ""Entry No."(Key)".


        //Unsupported feature: Property Deletion (MaintainSIFTIndex) on ""Vendor Ledger Entry No.,Entry Type,Posting Date"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Vendor No.,Initial Entry Due Date,Posting Date,Currency Code"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Vendor No.,Initial Entry Due Date,Posting Date"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Vendor No.,Posting Date,Entry Type,Currency Code"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Vendor No.,Initial Document Type,Document Type,Entry Type,Posting Date"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Vendor No.,Initial Entry Due Date,Posting Date,Initial Entry Global Dim. 1,Initial Entry Global Dim. 2,Currency Code"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Vendor No.,Posting Date,Entry Type,Initial Entry Global Dim. 1,Initial Entry Global Dim. 2,Currency Code"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Vendor No.,Initial Document Type,Document Type,Entry Type,Initial Entry Global Dim. 1,Initial Entry Global Dim. 2"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Vendor No.,Document No.,Posting Date"(Key)".

        key(Key1; "Ledger Entry Amount", "Vendor Ledger Entry No.", "Posting Date")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = Amount, "Amount (LCY)", "Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)";
        }
        key(Key2; "Initial Document Type", "Entry Type", "Vendor No.", "Currency Code", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Posting Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = Amount, "Amount (LCY)";
        }
        key(Key3; "Vendor No.", "Currency Code", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Initial Entry Due Date", "Posting Date")
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
        SETCURRENTKEY("Vendor Ledger Entry No.", "Entry Type");
        SETRANGE("Vendor Ledger Entry No.", EntryNo);
        SETRANGE("Entry Type", "Entry Type"::"Unrealized Loss", "Entry Type"::"Unrealized Gain");
        CALCSUMS("Amount (LCY)");
        EXIT("Amount (LCY)");
    end;
}

