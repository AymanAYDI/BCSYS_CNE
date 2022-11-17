tableextension 50019 "BC6_StandardVendorPurchaseCode" extends "Standard Vendor Purchase Code" //175
{
    fields
    {

        field(50000; BC6_TextautoReport; Boolean)
        {
            Caption = 'Text Auto Report', comment = 'FRA="Texte Auto Etat"';
            DataClassification = CustomerContent;
        }
    }
}

