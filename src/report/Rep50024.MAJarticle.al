report 50024 "BC6_MAJ article"
{
    Caption = 'MAJ article';
    ProcessingOnly = true;
    UsageCategory = None;
    dataset
    {
        dataitem(Item; 27)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("No." = CONST('AWG114110090122'));

            trigger OnAfterGetRecord()
            begin
                IF Item."Vendor No." = 'CNE' THEN BEGIN
                    Item."Vendor No." := 'AWG';
                    Item.MODIFY();
                END;
            end;
        }
    }
}
