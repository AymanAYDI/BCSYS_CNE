tableextension 50019 "BC6_StandardVendorPurchaseCode" extends "Standard Vendor Purchase Code"
{
    Caption = 'Standard Vendor Purchase Code';
    fields
    {
        modify("Vendor No.")
        {
            Caption = 'Vendor No.';
        }
        modify("Code")
        {
            Caption = 'Code';
        }
        modify(Description)
        {
            Caption = 'Description';
        }
        field(50000; BC6_TextautoReport; Boolean)
        {
            Caption = 'Text Auto Report';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Text_Automatiques] Ajout du champ';
        }
    }
}

