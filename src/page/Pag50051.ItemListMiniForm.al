page 50051 "BC6_Item List MiniForm"
{
    Caption = 'Item List', Comment = 'FRA="Liste articles"';
    Editable = false;
    PageType = List;
    SourceTable = Item;
    SourceTableView = SORTING("No.");

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = All;
                }
                field(EAN13Code; EAN13Code)
                {
                    Caption = 'EAN13 Code', Comment = 'FRA="Code EAN13"';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = All;
                }
                field(Inventory; Inventory)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        DistInt: Codeunit "Dist. Integration";
    begin
        // EAN13Code := DistInt.GetItemEAN13Code("No.") // TODO: function GetItemEAN13Code missing in codeunit "Dist. Integration"
    end;

    var
        Item: Record Item;
        EAN13Code: Code[20];

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
                    IF Item.NEXT() = 0 THEN
                        More := FALSE
                    ELSE
                        IF NOT Item.MARK() THEN
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
                    Item.NEXT();
                END;
            END;
        END;
        EXIT(SelectionFilter);
    end;
}

