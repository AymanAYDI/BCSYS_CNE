pageextension 50072 "BC6_InventorySetup" extends "Inventory Setup" //461
{
    layout
    {
        addafter("Inbound Whse. Handling Time")
        {
            field("BC6_VAT Bus. Posting Gr. (Price)"; "BC6_VAT Bus. Post. Gr. (Price)")
            {
                ApplicationArea = All;
            }
        }
        addafter("Location Mandatory")
        {
            field("BC6_Cross. Ref. Type No. BarCode"; "BC6_Cross.Ref.Type No.BarCode")
            {
                ApplicationArea = All;
            }
            field("BC6_Int. BarCode Nos"; "BC6_Int. BarCode Nos")
            {
                ApplicationArea = All;
            }
            field("BC6_Item Jnl Template Name 1"; "BC6_Item Jnl Template Name 1")
            {
                ApplicationArea = All;
            }
            field("BC6_Item Jnl Template Name 2"; "BC6_Item Jnl Template Name 2")
            {
                ApplicationArea = All;
            }
            field("BC6_Item Jnl Template Name 3"; "BC6_Item Jnl Template Name 3")
            {
                ApplicationArea = All;
            }
        }
    }
}

