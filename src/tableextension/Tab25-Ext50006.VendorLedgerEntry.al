tableextension 50006 "BC6_VendorLedgerEntry" extends "Vendor Ledger Entry" //25
{
    fields
    {
        field(50000; BC6_PaymentMethodCode; Code[10])
        {
            Caption = 'Payment Method Code', comment = 'FRA="Code mode de règlement"';
            TableRelation = "Payment Method";
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code', comment = 'FRA="Code condition paiement"';
            TableRelation = "Payment Terms";
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.', comment = 'FRA="Tiers payeur"';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        //TODO:keys
        // key(Key26; "BC6_Pay-to Vend. No.", Open, Positive, "Due Date")
        // {
        // }
        // key(Key27; "BC6_Pay-to Vend. No.", "Applies-to ID", "Vendor No.")
        // {
        // }
    }

    procedure getVendorName(CodLVendNo: Code[20]): Text[100]
    var
        RecgLVendor: Record Vendor;
    begin
        IF RecgLVendor.GET(CodLVendNo) THEN
            EXIT(RecgLVendor.Name)
        ELSE
            EXIT('');
    end;
}
