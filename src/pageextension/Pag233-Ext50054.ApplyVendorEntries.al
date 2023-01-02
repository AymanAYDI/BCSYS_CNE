pageextension 50054 "BC6_ApplyVendorEntries" extends "Apply Vendor Entries" //233
{
    layout
    {
        addafter("External Document No.")
        {
            field(BC6_PayToVend; "BC6_Pay-to Vend. No.")
            {
            }
            field(BC6_GetPayToVenNo; getVendorName("BC6_Pay-to Vend. No."))
            {
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
                IF "Vendor No." = "BC6_Pay-to Vend. No." THEN
                    GlobalFunctionMgt.setBooGVendorNoStyle(true)
                ELSE
                    GlobalFunctionMgt.setBooGVendorNoStyle(false);
            END;
        }
        addafter("Vendor No.")
        {
            field(BC6_VendorNO; getVendorName("Vendor No."))
            {
                trigger OnValidate()
                var
                    GlobalFunctionMgt: Codeunit "BC6_GlobalFunctionMgt";

                begin
                    //Mise en couleur dynamique lorsque le n° Tiers payeur =  n° fournisseur
                    IF "Vendor No." = "BC6_Pay-to Vend. No." THEN
                        GlobalFunctionMgt.setBooGVendorNoStyle(TRUE)
                    ELSE
                        GlobalFunctionMgt.setBooGVendorNoStyle(FALSE);
                END;
            }
        }
    }

}
