tableextension 50004 "BC6_CustLedgerEntry" extends "Cust. Ledger Entry" //21
{
    fields
    {
        field(50000; BC6_PaymentMethodCode; Code[10])
        {
            Caption = 'Payment Method Code', Comment = 'FRA="Code mode de règlement"';
            DataClassification = CustomerContent;
            TableRelation = "Payment Method";
        }
        field(50001; "BC6_Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code', Comment = 'FRA="Code condition paiement"';
            DataClassification = CustomerContent;
            TableRelation = "Payment Terms";
        }
        field(50003; "BC6_Pay-to Customer No."; Code[20])
        {
            Caption = 'Pay-to Customer No.', Comment = 'FRA="Tiers payeur"';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(80800; "BC6_DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code', Comment = 'FRA="Code Catégorie DEEE"';
            DataClassification = CustomerContent;
            TableRelation = "BC6_Categories of item".Category;
        }
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'Montant HT DEEE', Comment = 'FRA="Montant HT DEEE"';
            DataClassification = CustomerContent;
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'Montant TVA DEEE', Comment = 'FRA="Montant TVA DEEE"';
            DataClassification = CustomerContent;
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount';
            DataClassification = CustomerContent;
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)', Comment = 'FRA="Montant Unitaire DEEE (DS)"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80807; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE', Comment = 'FRA="Eco partenaire DEEE"';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = Vendor;
        }
    }
    keys
    {
        key(Key36; "Customer No.", Open, Positive, "Customer Posting Group", "Due Date")
        {
        }
        key(Key37; "Customer Posting Group", "Customer No.")
        {
        }
        key(Key38; "Salesperson Code", "Customer No.", "Posting Date", "Document Type")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = "Sales (LCY)", "Profit (LCY)";
        }
        key(Key39; "Document Type", "Posting Date")
        {
            SumIndexFields = "Sales (LCY)";
        }
        key(Key40; "Document Type", "Customer No.", Open)
        {
        }
    }

    PROCEDURE "---NSC1.00---"();
    BEGIN
    END;

    procedure getCustomerName(CodLCustNo: Code[20]): Text[100]
    var
        RecgLCustomer: Record Customer;
    begin
        IF RecgLCustomer.GET(CodLCustNo) THEN
            EXIT(RecgLCustomer.Name)
        ELSE
            EXIT('');
    end;
}
