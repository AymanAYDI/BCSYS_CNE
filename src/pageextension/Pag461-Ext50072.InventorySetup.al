pageextension 50072 "BC6_InventorySetup" extends "Inventory Setup" //461
{
    layout
    {
        addafter("Inbound Whse. Handling Time")
        {
            field("BC6_VAT Bus. Posting Gr. (Price)"; Rec."BC6_VAT Bus. Post. Gr. (Price)")
            {
                ApplicationArea = All;
            }
        }
        addafter("Location Mandatory")
        {
            field("BC6_Cross. Ref. Type No. BarCode"; Rec."BC6_Cross.Ref.Type No.BarCode")
            {
                ApplicationArea = All;
            }
            field("BC6_Int. BarCode Nos"; Rec."BC6_Int. BarCode Nos")
            {
                ApplicationArea = All;
            }
            field("BC6_Item Jnl Template Name 1"; Rec."BC6_Item Jnl Template Name 1")
            {
                ApplicationArea = All;
            }
            field("BC6_Item Jnl Template Name 2"; Rec."BC6_Item Jnl Template Name 2")
            {
                ApplicationArea = All;
            }
            field("BC6_Item Jnl Template Name 3"; Rec."BC6_Item Jnl Template Name 3")
            {
                ApplicationArea = All;
            }
        }
    }
}

