enum 50012 "BC6_Item Type Filter"
{
    Extensible = true;

    value(0; Item)
    {
        Caption = 'Item', Comment = 'FRA="Article"';
    }
    value(1; "Item Discount Group")
    {
        Caption = '"Item Discount Group"', Comment = 'FRA="Groupe rem. article"';
    }
    value(2; "All Items")
    {
        Caption = '"All Items"', Comment = 'FRA="Tous les articles"';
    }
    value(3; "None")
    {
        Caption = '"None"', Comment = 'FRA="Aucun"';
    }
}
