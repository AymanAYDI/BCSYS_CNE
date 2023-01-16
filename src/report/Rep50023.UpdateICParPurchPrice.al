report 50023 "BC6_Update IC Par Purch. Price"
{
    ApplicationArea = all;
    Caption = 'Update IC Partner Purch. Price', comment = 'FRA="Màj tarif fournisseur partnaire"';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                IF STRPOS(COMPANYNAME, 'CNE') = 0 THEN
                    ERROR(CstGText000);

                CduGUpdateICPartnerItems.FctGUpdatePurchasePriceVendor(Vendor);
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CduGUpdateICPartnerItems: Codeunit "BC6_Update IC Partner Items";
        CstGText000: Label 'Treatment allowed only for CNE.', comment = 'FRA="Traitement autorisé seulement sur CNE."';
}
