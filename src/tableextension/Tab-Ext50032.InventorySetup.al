tableextension 50032 "BC6_InventorySetup" extends "Inventory Setup"
{
    fields
    {
        field(50000; "BC6_Cross. Ref. Type No. BarCode"; Code[10])
        {
            Caption = 'Cross. Ref. Type No. BarCode';
        }
        field(50001; "BC6_Int. BarCode Nos"; Code[10])
        {
            Caption = 'Int. BarCode Nos';
            TableRelation = "No. Series";
        }
        field(50005; "BC6_Item Jnl Template Name 1"; Code[10])
        {
            Caption = 'Item Journal Template Name';
            TableRelation = "Item Journal Template";

            trigger OnValidate()
            begin
                ItemJnlTemplate.GET("BC6_Item Jnl Template Name 1");
                ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::Transfer);
            end;
        }
        field(50006; "BC6_Item Jnl Template Name 2"; Code[10])
        {
            Caption = 'Item Journal Template Name';
            TableRelation = "Item Journal Template";

            trigger OnValidate()
            begin
                ItemJnlTemplate.GET("BC6_Item Jnl Template Name 2");
                ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::Transfer);
            end;
        }
        field(50007; "BC6_Item Jnl Template Name 3"; Code[10])
        {
            Caption = 'Item Journal Template Name';
            TableRelation = "Item Journal Template";

            trigger OnValidate()
            begin
                ItemJnlTemplate.GET("BC6_Item Jnl Template Name 3");
                ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::"Phys. Inventory");
            end;
        }
        field(50010; "BC6_VAT Bus. Post. Gr. (Price)"; Code[10])
        {
            Caption = 'VAT Bus. Posting Gr. (Price)';
            TableRelation = "VAT Business Posting Group";
        }
    }



    var
        ItemJnlTemplate: Record "Item Journal Template";
}

