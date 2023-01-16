pageextension 50054 "BC6_ApplyVendorEntries" extends "Apply Vendor Entries" //233
{
    layout
    {
        addafter("External Document No.")
        {
            field(BC6_PayToVend; Rec."BC6_Pay-to Vend. No.")
            {
                ApplicationArea = All;
            }
            field(BC6_GetPayToVenNo; Rec.getVendorName(Rec."BC6_Pay-to Vend. No."))
            {
                ApplicationArea = All;
                Caption = 'Pay-to Vend. No.', Comment = 'FRA="Tiers payeur"';
            }
        }
        modify("Vendor No.")
        {
            Style = StandardAccent;
            StyleExpr = TRUE;
            trigger OnAfterValidate()
            var
                GlobalFunctionMgt: Codeunit "BC6_GlobalFunctionMgt";
            begin
                IF Rec."Vendor No." = Rec."BC6_Pay-to Vend. No." THEN
                    GlobalFunctionMgt.setBooGVendorNoStyle(true)
                ELSE
                    GlobalFunctionMgt.setBooGVendorNoStyle(false);
            END;
        }
        addafter("Vendor No.")
        {
            field(BC6_VendorNO; Rec.getVendorName(Rec."Vendor No."))
            {
                ApplicationArea = All;
                trigger OnValidate()
                var
                    GlobalFunctionMgt: Codeunit "BC6_GlobalFunctionMgt";

                begin
                    //Mise en couleur dynamique lorsque le n° Tiers payeur =  n° fournisseur
                    IF Rec."Vendor No." = Rec."BC6_Pay-to Vend. No." THEN
                        GlobalFunctionMgt.setBooGVendorNoStyle(TRUE)
                    ELSE
                        GlobalFunctionMgt.setBooGVendorNoStyle(FALSE);
                END;
            }
        }
    }
}
