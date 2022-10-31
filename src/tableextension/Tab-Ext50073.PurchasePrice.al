tableextension 50073 "BC6_PurchasePrice" extends "Purchase Price"
{
    // TODO: Check "Purchase Price" Replaced by the new implementation (V16) of price calculation: table Price List Line'
    keys
    {
        key(Key3; "Item No.", "Vendor No.", "Ending Date")
        {
        }
        key(Key4; "Item No.", "Vendor No.", "Currency Code")
        {
        }
    }
}

