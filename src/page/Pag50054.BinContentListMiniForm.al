page 50054 "BC6_Bin Content List MiniForm"
{
    Caption = 'Bin Content List MiniForm', Comment = 'FRA="Contenu emplacement"';
    PageType = List;
    SourceTable = "Bin Content";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field("Location Code"; "Location Code")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(LocationForm);
                        Location.RESET();
                        LocationForm.SETTABLEVIEW(Location);
                        LocationForm.LOOKUPMODE(TRUE);
                        IF Location.FIND('-') THEN
                            LocationForm.SETRECORD(Location);
                        IF LocationForm.RUNMODAL() = ACTION::LookupOK THEN
                            LocationForm.GETRECORD(Location);
                    end;
                }
                field("Item No."; "Item No.")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(ItemForm);
                        Item.RESET();
                        ItemForm.SETTABLEVIEW(Item);
                        ItemForm.LOOKUPMODE(TRUE);
                        IF Item.FIND('-') THEN
                            ItemForm.SETRECORD(Item);
                        IF ItemForm.RUNMODAL() = ACTION::LookupOK THEN
                            ItemForm.GETRECORD(Item);
                    end;
                }
                field("Bin Code"; "Bin Code")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(BinForm);
                        Bin.RESET();
                        BinForm.SETTABLEVIEW(Bin);
                        BinForm.LOOKUPMODE(TRUE);
                        IF Bin.FIND('-') THEN
                            BinForm.SETRECORD(Bin);
                        IF BinForm.RUNMODAL() = ACTION::LookupOK THEN
                            BinForm.GETRECORD(Bin);
                    end;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        EXIT;
                    end;
                }
                field("Pick Qty."; "Pick Qty.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Available Qty. to Take"; CalcAvailQty())
                {
                    Caption = 'Available Qty. to Take', Comment = 'FRA="Qté disponible pour prélèv."';
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        Item: Record Item;
        Location: Record Location;
        Bin: Record Bin;
        ItemForm: Page "BC6_Item List MiniForm";
        LocationForm: Page "BC6_Location List MiniForm";
        BinForm: Page "BC6_Bin List MiniForm";
        ItemNo: Code[20];
        LocationCode: Code[20];
        BinCode: Code[20];


    procedure CalcAvailQty(): Decimal
    begin
        EXIT(Quantity - "Pick Qty." - "Neg. Adjmt. Qty.");
    end;
}

