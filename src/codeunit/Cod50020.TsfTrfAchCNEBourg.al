codeunit 50020 "BC6_Tsf Trf Ach CNE ==> Bourg"
{


    trigger OnRun()
    begin
    end;

    var
        PurchPrice_Source: Record "Purchase Price";
        PurchPrice_Cible: Record "Purchase Price";
        Item_Source: Record Item;
        Item_Cible: Record Item;
        ItemU_Source: Record "Item Unit of Measure";
        ItemU_Cible: Record "Item Unit of Measure";

        Dialog_D: Dialog;
        Text001: Label 'FORBIDDEN treatment in this company';


    procedure Transfert(CodeFourn: Code[20])
    begin
        // Traitement uniquement de CNE vers les autres stés.
        IF COMPANYNAME <> 'CNE 2007' THEN ERROR(Text001);

        Dialog_D.OPEN('Article #1###################### \ #3######################## \ #2#################');

        PurchPrice_Cible.RESET();
        PurchPrice_Cible.CHANGECOMPANY('SCENEO_Bourgogne');
        Item_Cible.RESET();
        Item_Cible.CHANGECOMPANY('SCENEO_Bourgogne');
        ItemU_Cible.RESET();
        ItemU_Cible.CHANGECOMPANY('SCENEO_Bourgogne');

        // Recherche Article si Existe
        // No.
        Item_Source.RESET();
        Item_Source.SETRANGE("Vendor No.", CodeFourn);
        IF Item_Source.FIND('-') THEN
            REPEAT
                Dialog_D.UPDATE(1, Item_Source."No.");
                Dialog_D.UPDATE(3, CodeFourn);

                IF NOT (Item_Cible.GET(PurchPrice_Source."Item No.")) THEN BEGIN
                    Item_Cible.TRANSFERFIELDS(Item_Source);
                    IF Item_Cible.INSERT(FALSE) THEN;

                    // Recherche Unité Article si Existe
                    // Item No.,Code
                    ItemU_Source.RESET();
                    ItemU_Source.SETRANGE("Item No.", Item_Source."No.");
                    IF ItemU_Source.FIND('-') THEN
                        REPEAT
                            IF NOT (ItemU_Cible.GET(PurchPrice_Source."Item No.", ItemU_Source.Code)) THEN BEGIN
                                ItemU_Cible.TRANSFERFIELDS(ItemU_Source);
                                IF ItemU_Cible.INSERT(FALSE) THEN;
                            END;
                        UNTIL ItemU_Source.NEXT() <= 0;

                END
                ELSE BEGIN
                    Item_Cible.Blocked := Item_Source.Blocked;
                    Item_Cible."Standard Cost" := Item_Source."Standard Cost";
                    Item_Cible.MODIFY();
                END;
            UNTIL Item_Source.NEXT() <= 0;

        // Suppression des tarifs achat de ce fournisseur dans la sté Cible.

        PurchPrice_Source.RESET();
        PurchPrice_Source.SETRANGE("Vendor No.", CodeFourn);
        IF PurchPrice_Source.FIND('-') THEN
            REPEAT
                Dialog_D.UPDATE(1, PurchPrice_Source."Item No.");
                Dialog_D.UPDATE(2, PurchPrice_Source."Starting Date");

                // Recherche si Existe
                IF PurchPrice_Cible.GET(PurchPrice_Source."Item No.", 'CNE', PurchPrice_Source."Starting Date", PurchPrice_Source."Currency Code", PurchPrice_Source."Variant Code", PurchPrice_Source."Unit of Measure Code",
                                          PurchPrice_Source."Minimum Quantity") THEN
                    PurchPrice_Cible.DELETE();

                //Item No.,Vendor No.,Starting Date,Currency Code,Variant Code,Unit of Measure Code,Minimum Quantity
                IF NOT (PurchPrice_Cible.GET(PurchPrice_Source."Item No.", 'CNE', PurchPrice_Source."Starting Date", PurchPrice_Source."Currency Code", PurchPrice_Source."Variant Code", PurchPrice_Source."Unit of Measure Code",
                                          PurchPrice_Source."Minimum Quantity")) THEN BEGIN
                    PurchPrice_Cible.TRANSFERFIELDS(PurchPrice_Source);
                    PurchPrice_Cible.VALIDATE("Vendor No.", 'CNE');
                    IF PurchPrice_Cible.INSERT(TRUE) THEN;
                END;
            UNTIL PurchPrice_Source.NEXT() <= 0;

        Dialog_D.CLOSE();
    end;
}

