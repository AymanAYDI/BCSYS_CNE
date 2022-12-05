report 50023 "Update IC Partner Purch. Price"
{
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // 
    // //>>CNEIC
    // CR_NouvSte_CNE_20150605: TO 02/07/2015: Create Report
    // 
    // ------------------------------------------------------------------------

    Caption = 'Update IC Partner Purch. Price';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1100267000; Table23)
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
        CstGText000: Label 'Treatment allowed only for CNE.';
        CduGUpdateICPartnerItems: Codeunit "50021";
}

