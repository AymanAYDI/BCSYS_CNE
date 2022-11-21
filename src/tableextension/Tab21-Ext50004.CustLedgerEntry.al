tableextension 50004 "BC6_CustLedgerEntry" extends "Cust. Ledger Entry" //21
{
    fields
    {
        field(50000; BC6_PaymentMethodCode; Code[10])
        {
            Caption = 'Payment Method Code', Comment = 'FRA="Code mode de règlement"';
            TableRelation = "Payment Method";
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code', Comment = 'FRA="Code condition paiement"';
            TableRelation = "Payment Terms";
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Pay-to Customer No."; Code[20])
        {
            Caption = 'Pay-to Customer No.', Comment = 'FRA="Tiers payeur"';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(80800; "BC6_DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code', Comment = 'FRA="Code Catégorie DEEE"';
            TableRelation = "BC6_Categories of item".Category;
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
            Caption = 'DEEE TTC Amount';
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)', Comment = 'FRA="Montant Unitaire DEEE (DS)"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80807; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE', Comment = 'FRA="Eco partenaire DEEE"';
            Editable = false;
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        //TODO : not from the same record
        //   key(Key2;"BC6_Pay-to Customer No.",Open,Positive,"Due Date")
        // {
        // }
        // key(Key1;"BC6_Pay-to Customer No.","Applies-to ID","Customer No.")
        // {
        // }
        // key(Key4;"BC6_Pay-to Customer No.",Open,Positive,"Customer Posting Group","Due Date")
        // {
        // }
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
