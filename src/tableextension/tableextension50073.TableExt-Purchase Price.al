tableextension 50073 tableextension50073 extends "Purchase Price"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    //  //TARIFPUBLIC SM 15/10/06 NCS1.01 [FE024V1] Ajout du KEY   Item No.,Vendor No.,Ending Date
    // 
    // //>>CNE5.00
    // TDL.76:20131120/CSC - Add key on "Item No.,Vendor No.,Currency Code"
    // 
    // ------------------------------------------------------------------------
    LookupPageID = 7012;
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Item No."(Field 1)".


        //Unsupported feature: Property Modification (Data type) on ""Vendor No."(Field 2)".


        //Unsupported feature: Property Modification (Data type) on ""Currency Code"(Field 3)".


        //Unsupported feature: Property Insertion (DecimalPlaces) on ""Minimum Quantity"(Field 14)".

    }
    keys
    {
        key(Key1; "Item No.", "Vendor No.", "Ending Date")
        {
        }
        key(Key2; "Item No.", "Vendor No.", "Currency Code")
        {
        }
    }

    procedure CopyPurchPriceToVendorsPurchPrice(var PurchPrice: Record "7012"; VendNo: Code[20])
    var
        NewPurchasePrice: Record "7012";
    begin
        IF PurchPrice.FINDSET THEN
            REPEAT
                NewPurchasePrice := PurchPrice;
                NewPurchasePrice."Vendor No." := VendNo;
                IF NewPurchasePrice.INSERT THEN;
            UNTIL PurchPrice.NEXT = 0;
    end;
}

