pageextension 50024 "BC6_PurchInvoiceSubform" extends "Purch. Invoice Subform" //55
{
    layout
    {
        addafter("No.")
        {
            field("BC6_DEEE Category Code"; Rec."BC6_DEEE Category Code")
            {
                ApplicationArea = All;
                Caption = 'DEEE Category Code', Comment = 'FRA="Code Catégorie DEEE"';
            }
            field("BC6_Eco partner DEEE"; Rec."BC6_Eco partner DEEE")
            {
                ApplicationArea = All;
                Caption = 'Eco partner DEEE', Comment = 'FRA="Eco partenaire DEEE"';
            }
            field("BC6_DEEE Unit Price"; Rec."BC6_DEEE Unit Price")
            {
                ApplicationArea = All;
                Caption = 'DEEE Unit Price', Comment = 'FRA="Prix Unitaire DEEE"';
            }
            field("BC6_DEEE HT Amount"; Rec."BC6_DEEE HT Amount")
            {
                ApplicationArea = All;
                Caption = 'DEEE HT Amount', Comment = 'FRA="Montant HT DEEE"';
            }
            field("BC6_DEEE VAT Amount"; Rec."BC6_DEEE VAT Amount")
            {
                ApplicationArea = All;
                Caption = 'DEEE VAT Amount', Comment = 'FRA="Montant TVA DEEE"';
            }
            field("BC6_DEEE TTC Amount"; Rec."BC6_DEEE TTC Amount")
            {
                ApplicationArea = All;
                Caption = 'DEEE TTC Amount', Comment = 'FRA="Montant TTC DEEE"';
            }
            field("BC6_DEEE HT Amount (LCY)"; Rec."BC6_DEEE HT Amount (LCY)")
            {
                ApplicationArea = All;
                Caption = 'DEEE HT Amount (LCY)', Comment = 'FRA="Montant Unitaire DEEE (DS)"';
            }
        }
    }
}

