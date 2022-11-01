page 50051 "Item List MiniForm"
{
    Caption = 'Item List';
    Editable = false;
    PageType = List;
    SourceTable = Table27;
    SourceTableView = SORTING (No.);

    layout
    {
        area(content)
        {
            repeater()
            {
                field("No."; "No.")
                {
                }
                field(Blocked; Blocked)
                {
                }
                field(EAN13Code; EAN13Code)
                {
                    Caption = 'EAN13 Code';
                    Editable = false;
                }
                field(Description; Description)
                {
                }
                field("Description 2"; "Description 2")
                {
                }
                field(Inventory; Inventory)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        DistInt: Codeunit "5702";
    begin
        EAN13Code := DistInt.GetItemEAN13Code("No.")
    end;

    var
        Item: Record "27";
        EAN13Code: Code[20];

    [Scope('Internal')]
    procedure GetSelectionFilter(): Code[80]
    var
        FirstItem: Code[30];
        LastItem: Code[30];
        SelectionFilter: Code[250];
        ItemCount: Integer;
        More: Boolean;
    begin
        CurrPage.SETSELECTIONFILTER(Item);
        ItemCount := Item.COUNT;
        IF ItemCount > 0 THEN BEGIN
            Item.FIND('-');
            WHILE ItemCount > 0 DO BEGIN
                ItemCount := ItemCount - 1;
                Item.MARKEDONLY(FALSE);
                FirstItem := Item."No.";
                LastItem := FirstItem;
                More := (ItemCount > 0);
                WHILE More DO
                    IF Item.NEXT = 0 THEN
                        More := FALSE
                    ELSE
                        IF NOT Item.MARK THEN
                            More := FALSE
                        ELSE BEGIN
                            LastItem := Item."No.";
                            ItemCount := ItemCount - 1;
                            IF ItemCount = 0 THEN
                                More := FALSE;
                        END;
                IF SelectionFilter <> '' THEN
                    SelectionFilter := SelectionFilter + '|';
                IF FirstItem = LastItem THEN
                    SelectionFilter := SelectionFilter + FirstItem
                ELSE
                    SelectionFilter := SelectionFilter + FirstItem + '..' + LastItem;
                IF ItemCount > 0 THEN BEGIN
                    Item.MARKEDONLY(TRUE);
                    Item.NEXT;
                END;
            END;
        END;
        EXIT(SelectionFilter);
    end;
}

