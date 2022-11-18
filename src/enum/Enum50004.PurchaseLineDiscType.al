enum 50004 "BC6_Purchase Line Disc. Type"
{
    Caption = 'Type';

    value(0; Item)
    {
        Caption = 'Item', comment = 'FRA="Article"';
    }
    value(1; "Item Disc. Group")
    {
        Caption = 'Item Disc. Group', comment = 'FRA="Groupe rem. article"';
    }
    value(2; "All items")
    {
        Caption = 'All items', comment = 'FRA="Tous les articles"';
    }
}
