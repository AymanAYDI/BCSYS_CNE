#pragma warning disable AL0432
tableextension 50082 "BC6_PurchasePrice" extends "Purchase Price" //7012
{
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
#pragma warning restore AL0432