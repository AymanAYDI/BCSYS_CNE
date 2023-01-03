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
        FunctionsMgt: Codeunit "BC6_Functions Mgt";
    begin
        EAN13Code := FunctionsMgt.GetItemEAN13Code(Rec."No.");
    end;

    var
        EAN13Code: Code[20];

    //TODO: this function is not used (source GDT)
    // procedure GetSelectionFilter(): Code[80]  //  // var
    //     More: Boolean;
    //     FirstItem: Code[30];
    //     LastItem: Code[30];
    //     SelectionFilter: Code[80];
    //     ItemCount: Integer;
    // begin
    //     CurrPage.SETSELECTIONFILTER(Item);
    //     ItemCount := Item.COUNT;
    //     IF ItemCount > 0 THEN BEGIN
    //         Item.FIND('-');
    //         WHILE ItemCount > 0 DO BEGIN
    //             ItemCount := ItemCount - 1;
    //             Item.MARKEDONLY(FALSE);
    //             FirstItem := Item."No.";
    //             LastItem := FirstItem;
    //             More := (ItemCount > 0);
    //             WHILE More DO
    //                 IF Item.NEXT() = 0 THEN
    //                     More := FALSE
    //                 ELSE
    //                     IF NOT Item.MARK() THEN
    //                         More := FALSE
    //                     ELSE BEGIN
    //                         LastItem := Item."No.";
    //                         ItemCount := ItemCount - 1;
    //                         IF ItemCount = 0 THEN
    //                             More := FALSE;
    //                     END;
    //             IF SelectionFilter <> '' THEN
    //                 SelectionFilter := CopyStr(SelectionFilter + '|', 1, MaxStrLen(SelectionFilter));
    //             IF FirstItem = LastItem THEN
    //                 SelectionFilter := CopyStr(SelectionFilter + FirstItem, 1, MaxStrLen(SelectionFilter))
    //             ELSE
    //                 SelectionFilter := CopyStr(SelectionFilter + FirstItem + '..' + LastItem, 1, MaxStrLen(SelectionFilter));
    //             IF ItemCount > 0 THEN BEGIN
    //                 Item.MARKEDONLY(TRUE);
    //                 Item.NEXT();
    //             END;
    //         END;
    //     END;
    //     EXIT(SelectionFilter);
    // end;
}

