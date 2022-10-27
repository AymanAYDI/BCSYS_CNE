tableextension 50032 tableextension50032 extends "Inventory Setup"
{
    // -----------------------------------------------
    // Prodware -www.prodware.fr
    // -----------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // //>> CNE4.01
    // A:FE02 01.09.2011 : Assign Internal Item Code
    //                   - Add Field 50000 Cross. Ref. Type No. BarCode
    //                   - Add Field 50001 Int. BarCode Nos
    // 
    // B:FE04 01.09.2011 : MiniForm Menu User
    //                   - Add Field 50005 Item Jnl Template Name 1
    //                   - Add Field 50006 Item Jnl Template Name 2
    //                   - Add Field 500047 Item Jnl Template Name 3
    // 
    // //>> CNE4.03 Calc. Price Include VAT
    //   - Add Field 50010 VAT Bus. Posting Gr. (Price)
    fields
    {

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Location Mandatory"(Field 3)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Transfer Order Nos."(Field 5700)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Posted Transfer Shpt. Nos."(Field 5701)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Posted Transfer Rcpt. Nos."(Field 5702)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Copy Comments Order to Shpt."(Field 5703)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Copy Comments Order to Rcpt."(Field 5704)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Nonstock Item Nos."(Field 5718)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Outbound Whse. Handling Time"(Field 5790)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Inbound Whse. Handling Time"(Field 5791)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Inventory Put-away Nos."(Field 7300)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Inventory Pick Nos."(Field 7301)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Posted Invt. Put-away Nos."(Field 7302)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Posted Invt. Pick Nos."(Field 7303)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Inventory Movement Nos."(Field 7304)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Registered Invt. Movement Nos."(Field 7305)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Internal Movement Nos."(Field 7306)".



        //Unsupported feature: Code Modification on ""Expected Cost Posting to G/L"(Field 5800).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Expected Cost Posting to G/L" <> xRec."Expected Cost Posting to G/L" THEN BEGIN
          IF ItemLedgEntry.FINDFIRST THEN BEGIN
            ChangeExpCostPostToGL.ChangeExpCostPostingToGL(Rec,"Expected Cost Posting to G/L");
            FIND;
          END;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Expected Cost Posting to G/L" <> xRec."Expected Cost Posting to G/L" THEN
        #2..5
        */
        //end;
        field(50000; "Cross. Ref. Type No. BarCode"; Code[10])
        {
            Caption = 'Cross. Ref. Type No. BarCode';
            Description = 'CNE4.01';
        }
        field(50001; "Int. BarCode Nos"; Code[10])
        {
            Caption = 'Int. BarCode Nos';
            Description = 'CNE4.01';
            TableRelation = "No. Series";
        }
        field(50005; "Item Jnl Template Name 1"; Code[10])
        {
            Caption = 'Item Journal Template Name';
            Description = 'CNE4.01';
            TableRelation = "Item Journal Template";

            trigger OnValidate()
            begin
                ItemJnlTemplate.GET("Item Jnl Template Name 1");
                ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::Transfer);
            end;
        }
        field(50006; "Item Jnl Template Name 2"; Code[10])
        {
            Caption = 'Item Journal Template Name';
            Description = 'CNE4.01';
            TableRelation = "Item Journal Template";

            trigger OnValidate()
            begin
                ItemJnlTemplate.GET("Item Jnl Template Name 2");
                ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::Transfer);
            end;
        }
        field(50007; "Item Jnl Template Name 3"; Code[10])
        {
            Caption = 'Item Journal Template Name';
            Description = 'CNE4.01';
            TableRelation = "Item Journal Template";

            trigger OnValidate()
            begin
                ItemJnlTemplate.GET("Item Jnl Template Name 3");
                ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::"Phys. Inventory");
            end;
        }
        field(50010; "VAT Bus. Posting Gr. (Price)"; Code[10])
        {
            Caption = 'VAT Bus. Posting Gr. (Price)';
            Description = 'CNE4.03';
            TableRelation = "VAT Business Posting Group";
        }
    }

    //Unsupported feature: Property Insertion (Local) on "UpdateAvgCostItemSettings(PROCEDURE 1)".


    var
        ItemJnlTemplate: Record "82";
}

