page 50054 "Bin Content List MiniForm"
{
    Caption = 'Bin Content List MiniForm';
    PageType = List;
    SourceTable = Table7302;

    layout
    {
        area(content)
        {
            repeater()
            {
                Editable = false;
                field("Location Code"; "Location Code")
                {
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(LocationForm);
                        Location.RESET;
                        LocationForm.SETTABLEVIEW(Location);
                        LocationForm.LOOKUPMODE(TRUE);
                        IF Location.FIND('-') THEN
                            LocationForm.SETRECORD(Location);
                        IF LocationForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            LocationForm.GETRECORD(Location);
                        END;
                    end;
                }
                field("Item No."; "Item No.")
                {
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(ItemForm);
                        Item.RESET;
                        ItemForm.SETTABLEVIEW(Item);
                        ItemForm.LOOKUPMODE(TRUE);
                        IF Item.FIND('-') THEN
                            ItemForm.SETRECORD(Item);
                        IF ItemForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            ItemForm.GETRECORD(Item);
                        END;
                    end;
                }
                field("Bin Code"; "Bin Code")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(BinForm);
                        Bin.RESET;
                        BinForm.SETTABLEVIEW(Bin);
                        BinForm.LOOKUPMODE(TRUE);
                        IF Bin.FIND('-') THEN
                            BinForm.SETRECORD(Bin);
                        IF BinForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            BinForm.GETRECORD(Bin);
                        END;
                    end;
                }
                field(Quantity; Quantity)
                {

                    trigger OnDrillDown()
                    begin
                        EXIT;
                    end;
                }
                field("Pick Qty."; "Pick Qty.")
                {
                    Visible = false;
                }
                field(CalcAvailQty; CalcAvailQty)
                {
                    Caption = 'Available Qty. to Take';
                    DecimalPlaces = 0 : 5;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        Item: Record "27";
        Location: Record "14";
        Bin: Record "7354";
        ItemNo: Code[20];
        LocationCode: Code[20];
        BinCode: Code[20];
        ItemForm: Page "50051";
        LocationForm: Page "50053";
        BinForm: Page "50052";

    [Scope('Internal')]
    procedure CalcAvailQty(): Decimal
    begin
        EXIT(Quantity - "Pick Qty." - "Neg. Adjmt. Qty.");
    end;
}

