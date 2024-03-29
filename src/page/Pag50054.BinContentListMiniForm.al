page 50054 "BC6_Bin Content List MiniForm"
{
    Caption = 'Bin Content List MiniForm', Comment = 'FRA="Contenu emplacement"';
    PageType = List;
    SourceTable = "Bin Content";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Visible = false;

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
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Visible = false;

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
                field("Bin Code"; Rec."Bin Code")
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
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        EXIT;
                    end;
                }
                field("Pick Qty."; Rec."Pick Qty.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Available Qty. to Take"; CalcAvailQty())
                {
                    ApplicationArea = All;
                    Caption = 'Available Qty. to Take', Comment = 'FRA="Qté disponible pour prélèv."';
                    DecimalPlaces = 0 : 5;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        Bin: Record Bin;
        Item: Record Item;
        Location: Record Location;
        BinForm: Page "BC6_Bin List MiniForm";
        ItemForm: Page "BC6_Item List MiniForm";
        LocationForm: Page "BC6_Location List MiniForm";

    procedure CalcAvailQty(): Decimal
    begin
        EXIT(Rec.Quantity - Rec."Pick Qty." - Rec."Neg. Adjmt. Qty.");
    end;
}
