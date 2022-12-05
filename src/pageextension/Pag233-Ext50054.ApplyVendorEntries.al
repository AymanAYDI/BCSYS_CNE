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
                Caption = 'Pay-to Vend. No.';
            }
        }
        modify("Vendor No.")
        {
            Style = StandardAccent;
            StyleExpr = TRUE;
            trigger OnAfterValidate()
            begin
                //Mise en couleur dynamique lorsque le Nø Tiers payeur =  Nø fournisseur
                IF "Vendor No." = "BC6_Pay-to Vend. No." THEN
                    BooGVendorNoStyle := TRUE
                ELSE
                    BooGVendorNoStyle := FALSE;
            END;
        }
        addafter("Vendor No.")
        {
            field(BC6_VendorNO; getVendorName("Vendor No."))
            {
                trigger OnValidate()
                begin
                    //Mise en couleur dynamique lorsque le Nø Tiers payeur =  Nø fournisseur
                    IF "Vendor No." = "BC6_Pay-to Vend. No." THEN
                        BooGVendorNoStyle := TRUE
                    ELSE
                        BooGVendorNoStyle := FALSE;
                END;
            }
        }
    }
    var
        [INDATASET]
        BooGVendorNoStyle: Boolean;

}
