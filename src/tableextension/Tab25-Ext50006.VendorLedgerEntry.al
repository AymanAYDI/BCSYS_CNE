tableextension 50006 "BC6_VendorLedgerEntry" extends "Vendor Ledger Entry" //25
{
    fields
    {
        field(50000; BC6_PaymentMethodCode; Code[10])
        {
            Caption = 'Payment Method Code', comment = 'FRA="Code mode de règlement"';
            DataClassification = CustomerContent;
            TableRelation = "Payment Method";
        }
        field(50001; "BC6_Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code', comment = 'FRA="Code condition paiement"';
            DataClassification = CustomerContent;
            TableRelation = "Payment Terms";
        }
        field(50003; "BC6_Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.', comment = 'FRA="Tiers payeur"';
            DataClassification = CustomerContent;
            TableRelation = Vendor;
        }
    }
    keys
    {
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
