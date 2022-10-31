tableextension 50083 "BC6_GenJournalLine" extends "Gen. Journal Line"
{

    //Unsupported feature: Property Insertion (Permissions) on ""Gen. Journal Line"(Table 81)".

    fields
    {

        field(50000; BC6_PaymentMethodCode; Code[10])
        {
            Caption = 'Payment Method Code';
            Description = 'REGLEMENT STLA 01.08.2006 COR001 [13]';
            TableRelation = "Payment Method";
        }
        field(50003; "BC6_Pay-to No."; Code[20])
        {
            Caption = 'Pay-to No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
        }
        field(80800; "BC6_DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code';
            Description = 'DEEE1.00';
            TableRelation = "BC6_Categories of item".Category;
        }
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'DEEE HT Amount';
            Description = 'DEEE1.00 onvalidate';
            Editable = false;

            trigger OnValidate()
            var
                Currency2: Record Currency;
            begin
            end;
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'DEEE VAT Amount';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)';
            Description = 'DEEE1.00';
            Editable = false;
        }
        field(80807; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE';
            Description = 'DEEE1.00';
            Editable = false;
            TableRelation = Vendor;
        }
    }
}

