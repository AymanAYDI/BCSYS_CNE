tableextension 50021 "BC6_CustLedgerEntry" extends "Cust. Ledger Entry"
{
    LookupPageID = "Customer Ledger Entries";
    DrillDownPageID = "Customer Ledger Entries";
    fields
    {

        field(50000; BC6_PaymentMethodCode; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(50001; "BC6_Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(50003; "BC6_Pay-to Customer No."; Code[20])
        {
            Caption = 'Pay-to Customer No.';
            TableRelation = Customer;
        }
        field(80800; "BC6_DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code';

            TableRelation = "BC6_Categories of item".Category;
        }
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'Montant HT DEEE';

        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'Montant TVA DEEE';

        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {

        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)';

            Editable = false;
        }
        field(80807; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE';

            Editable = false;
            TableRelation = Vendor;
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

