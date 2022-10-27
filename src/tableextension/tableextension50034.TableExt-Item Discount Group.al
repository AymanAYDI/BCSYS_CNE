tableextension 50034 tableextension50034 extends "Item Discount Group"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // //GESTION_REMISE FG 06/12/06 NSC1.01
    // 
    // ------------------------------------------------------------------------
    LookupPageID = 513;
    fields
    {
        modify(Description)
        {
            Caption = 'Description';
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger 01-)()
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesLineDiscount.SETRANGE(Type,SalesLineDiscount.Type::"Item Disc. Group");
    SalesLineDiscount.SETRANGE(Code,Code);
    SalesLineDiscount.DELETEALL(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3

    //>>MIGRATION NAv 2013
    //GESTION_REMISE FG 06/12/06 NSC1.01
    PurchaseLineDiscount.SETRANGE(Type,PurchaseLineDiscount.Type::"Item Disc. Group") ;
    PurchaseLineDiscount.SETRANGE("Item No.",Code);
    PurchaseLineDiscount.DELETEALL(TRUE);
    //Fin GESTION_REMISE FG 06/12/06 NSC1.01
    //<<MIGRATION NAv 2013
    */
    //end;

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: Brick)".


    var
        "-NSC1.01-": Integer;
        PurchaseLineDiscount: Record "7014";
}

