tableextension 50001 "BC6_PaymentPostBuffer" extends "Payment Post. Buffer" //10864
{
    fields
    {
        field(50003; "BC6_Pay-to No."; Code[20])
        {
            Caption = 'Pay-to No.', comment = 'FRA="Tiers payeur"';
        }
    }
}

