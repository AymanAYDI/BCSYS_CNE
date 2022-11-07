codeunit 50021 "Update IC Partner Items"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // 
    // //>>CNEIC
    // CR_NouvSte_CNE_20150605: TO 01/07/2015: Create CU
    // 
    // //>>MODIF HL
    // TI328377 DO.GEPO 01/06/2016 : modify function FctGUpdatePurchasePriceVendor
    // 
    // //>>MODIF HL
    // TI329297 DO.GEPO 07/06/2016 : modify function FctGUpdatePurchasePriceVendor
    // 
    // //>>MODIF HL
    // TI355216 DO.GEPO 03/01/2017 : modify function FctGUpdatePurchasePriceVendor
    // 
    // ------------------------------------------------------------------------

    TableNo = 27;

    trigger OnRun()
    begin
        IF STRPOS(COMPANYNAME, 'CNE') = 0 THEN
            ERROR(CstGText000);

        RecGICPartner.RESET;
        IF RecGICPartner.FINDSET THEN
            REPEAT
                RecGItemPartner.RESET;
                RecGItemPartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                IF RecGItemPartner.GET("No.") THEN BEGIN
                    RecGItemUnitofMeasurePartner.RESET;
                    RecGItemUnitofMeasurePartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                    RecGItemUnitofMeasurePartner.SETRANGE("Item No.", "No.");
                    IF RecGItemUnitofMeasurePartner.FINDSET THEN
                        RecGItemUnitofMeasurePartner.DELETEALL;
                    RecGPurchasePricePartner.RESET;
                    RecGPurchasePricePartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                    RecGPurchasePricePartner.SETRANGE("Item No.", "No.");
                    IF RecGPurchasePricePartner.FINDSET THEN
                        RecGPurchasePricePartner.DELETEALL;
                    RecGItemPartner.DELETE;
                END;

                //* Copier l'article
                //BCSYS 10032020- skip cost increase coeff
                ItemPartnerOldCostIncreaseCoeff := RecGItemPartner."Cost Increase Coeff %";

                RecGItemPartner := Rec;
                IF RecGItemPartner.INSERT THEN BEGIN
                    //BCSYS 10032020- skip cost increase coeff
                    RecGItemPartner."Cost Increase Coeff %" := ItemPartnerOldCostIncreaseCoeff;
                    RecGItemPartner.MODIFY;
                END;
                //FIN BCSYS 10032020- skip cost increase coeff

                //* Copier les unités articles associées
                RecGItemUnitofMeasurePartner.RESET;
                RecGItemUnitofMeasurePartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                RecGItemUnitofMeasure.RESET;
                RecGItemUnitofMeasure.SETRANGE("Item No.", "No.");
                IF RecGItemUnitofMeasure.FINDSET THEN
                    REPEAT
                        RecGItemUnitofMeasurePartner := RecGItemUnitofMeasure;
                        IF RecGItemUnitofMeasurePartner.INSERT THEN;
                    UNTIL RecGItemUnitofMeasure.NEXT = 0;

                //* Copier les tarifs achat associés
                RecGICPartnerPartner.RESET;
                RecGICPartnerPartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                IF RecGICPartnerPartner.FINDFIRST THEN BEGIN
                    RecGVendorPartner.RESET;
                    RecGVendorPartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                    RecGVendorPartner.SETCURRENTKEY("IC Partner Code");
                    RecGVendorPartner.SETRANGE("IC Partner Code", RecGICPartnerPartner.Code);
                    IF NOT RecGVendorPartner.FINDFIRST THEN
                        RecGVendorPartner.INIT;
                END;
                RecGPurchasePricePartner.RESET;
                RecGPurchasePricePartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                RecGPurchasePrice.RESET;
                RecGPurchasePrice.SETRANGE("Item No.", "No.");
                IF RecGPurchasePrice.FINDSET THEN
                    REPEAT
                        RecGPurchasePricePartner := RecGPurchasePrice;
                        RecGPurchasePricePartner.VALIDATE("Vendor No.", RecGVendorPartner."No.");
                        IF RecGPurchasePricePartner.INSERT THEN;
                    UNTIL RecGPurchasePrice.NEXT = 0;

                MESSAGE(CstGText001, "No.", RecGICPartner.Name);
            UNTIL RecGICPartner.NEXT = 0;
    end;

    var
        RecGICPartner: Record "413";
        CstGText000: Label 'Treatment allowed only for CNE.';
        RecGICPartnerPartner: Record "413";
        RecGItemPartner: Record "27";
        RecGItemUnitofMeasure: Record "5404";
        RecGItemUnitofMeasurePartner: Record "5404";
        RecGPurchasePrice: Record "7012";
        RecGPurchasePricePartner: Record "7012";
        RecGVendorPartner: Record "23";
        CstGText001: Label 'Item %1 duplicate on Partner %2.';
        RecGItem: Record "27";
        Windows: Dialog;
        ItemPartnerOldCostIncreaseCoeff: Decimal;

    [Scope('Internal')]
    procedure FctGUpdatePurchasePriceVendor(RecPVendor: Record "23")
    begin
        Windows.OPEN('Partenaire #1###################### \ Fournisseur #2######################## \ Article #3#################');

        RecGICPartner.RESET;
        IF RecGICPartner.FINDSET THEN
            REPEAT
                RecGItemPartner.RESET;
                RecGItemPartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                RecGItem.RESET;
                RecGItem.SETCURRENTKEY("Vendor No.");
                RecGItem.SETRANGE("Vendor No.", RecPVendor."No.");
                IF RecGItem.FINDSET THEN
                    REPEAT
                        Windows.UPDATE(1, RecGICPartner.Name);
                        Windows.UPDATE(2, RecPVendor."No.");
                        Windows.UPDATE(3, RecGItem."No.");

                        IF RecGItemPartner.GET(RecGItem."No.") THEN BEGIN
                            //* Mise à jour de l'article
                            RecGItemPartner.Blocked := RecGItem.Blocked;
                            RecGItemPartner."Standard Cost" := RecGItem."Standard Cost";
                            //>>TI328377
                            RecGItemPartner.Description := RecGItem.Description;
                            RecGItemPartner."Price Includes VAT" := RecGItem."Price Includes VAT";
                            RecGItemPartner."Item Disc. Group" := RecGItem."Item Disc. Group";
                            RecGItemPartner."Net Weight" := RecGItem."Net Weight";
                            RecGItemPartner."DEEE Category Code" := RecGItem."DEEE Category Code";
                            RecGItemPartner."Number of Units DEEE" := RecGItem."Number of Units DEEE";
                            RecGItemPartner."DEEE Unit Tax" := RecGItem."DEEE Unit Tax";
                            //>>TI329297
                            RecGItemPartner."Vendor No." := RecGItem."Vendor No.";
                            //<<TI329297
                            //<<TI328377
                            //>>TI355216
                            RecGItemPartner."Unit Price" := RecGItem."Unit Price";
                            RecGItemPartner."Unit Price Includes VAT" := RecGItem."Unit Price Includes VAT";
                            RecGItemPartner."Last Date Modified" := TODAY;
                            //<<TI355216
                            RecGItemPartner.MODIFY;
                        END ELSE BEGIN
                            //* Copier l'article
                            //BCSYS 10032020- skip cost increase coeff
                            ItemPartnerOldCostIncreaseCoeff := RecGItemPartner."Cost Increase Coeff %";

                            RecGItemPartner := RecGItem;
                            IF RecGItemPartner.INSERT THEN BEGIN
                                //BCSYS 10032020- skip cost increase coeff
                                RecGItemPartner."Cost Increase Coeff %" := ItemPartnerOldCostIncreaseCoeff;
                                RecGItemPartner.MODIFY;
                            END;
                            //FIN BCSYS 10032020- skip cost increase coeff

                            //* Copier les unités articles associées
                            RecGItemUnitofMeasurePartner.RESET;
                            RecGItemUnitofMeasurePartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                            RecGItemUnitofMeasure.RESET;
                            RecGItemUnitofMeasure.SETRANGE("Item No.", RecGItem."No.");
                            IF RecGItemUnitofMeasure.FINDSET THEN
                                REPEAT
                                    RecGItemUnitofMeasurePartner := RecGItemUnitofMeasure;
                                    IF RecGItemUnitofMeasurePartner.INSERT THEN;
                                UNTIL RecGItemUnitofMeasure.NEXT = 0;
                        END;
                    UNTIL RecGItem.NEXT = 0;

                //* Copier les tarifs achat
                RecGICPartnerPartner.RESET;
                RecGICPartnerPartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                IF RecGICPartnerPartner.FINDFIRST THEN BEGIN
                    RecGVendorPartner.RESET;
                    RecGVendorPartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                    RecGVendorPartner.SETCURRENTKEY("IC Partner Code");
                    RecGVendorPartner.SETRANGE("IC Partner Code", RecGICPartnerPartner.Code);
                    IF NOT RecGVendorPartner.FINDFIRST THEN
                        RecGVendorPartner.INIT;
                END;
                RecGPurchasePricePartner.RESET;
                RecGPurchasePricePartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                RecGPurchasePrice.RESET;
                RecGPurchasePrice.SETCURRENTKEY("Vendor No.");
                RecGPurchasePrice.SETRANGE("Vendor No.", RecPVendor."No.");
                IF RecGPurchasePrice.FINDSET THEN
                    REPEAT
                        Windows.UPDATE(1, RecGICPartner.Name);
                        Windows.UPDATE(2, RecPVendor."No.");
                        Windows.UPDATE(3, RecGItem."No.");
                        IF RecGPurchasePricePartner.GET(RecGPurchasePrice."Item No.", RecGVendorPartner."No.", RecGPurchasePrice."Starting Date", RecGPurchasePrice."Currency Code", RecGPurchasePrice."Variant Code", RecGPurchasePrice."Unit of Measure Code",
                                                        RecGPurchasePrice."Minimum Quantity") THEN
                            RecGPurchasePricePartner.DELETE;
                        RecGPurchasePricePartner := RecGPurchasePrice;
                        RecGPurchasePricePartner.VALIDATE("Vendor No.", RecGVendorPartner."No.");
                        IF RecGPurchasePricePartner.INSERT THEN;
                    UNTIL RecGPurchasePrice.NEXT = 0;
            UNTIL RecGICPartner.NEXT = 0;
        Windows.CLOSE();
    end;
}

