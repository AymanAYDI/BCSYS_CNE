codeunit 50021 "BC6_Update IC Partner Items"
{

    TableNo = Item;

    trigger OnRun()
    begin
        IF STRPOS(COMPANYNAME, 'CNE') = 0 THEN
            ERROR(CstGText000);

        RecGICPartner.RESET();
        IF RecGICPartner.FINDSET() THEN
            REPEAT
                RecGItemPartner.RESET();
                RecGItemPartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                IF RecGItemPartner.GET("No.") THEN BEGIN
                    RecGItemUnitofMeasurePartner.RESET();
                    RecGItemUnitofMeasurePartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                    RecGItemUnitofMeasurePartner.SETRANGE("Item No.", "No.");
                    IF RecGItemUnitofMeasurePartner.FINDSET() THEN
                        RecGItemUnitofMeasurePartner.DELETEALL();
                    RecGPurchasePricePartner.RESET();
                    RecGPurchasePricePartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                    RecGPurchasePricePartner.SETRANGE("Item No.", "No.");
                    IF RecGPurchasePricePartner.FINDSET() THEN
                        RecGPurchasePricePartner.DELETEALL();
                    RecGItemPartner.DELETE();
                END;

                //* Copier l'article
                ItemPartnerOldCostIncreaseCoeff := RecGItemPartner."BC6_Cost Increase Coeff %";

                RecGItemPartner := Rec;
                IF RecGItemPartner.INSERT() THEN BEGIN
                    RecGItemPartner."BC6_Cost Increase Coeff %" := ItemPartnerOldCostIncreaseCoeff;
                    RecGItemPartner.MODIFY();
                END;

                //* Copier les unités articles associées
                RecGItemUnitofMeasurePartner.RESET();
                RecGItemUnitofMeasurePartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                RecGItemUnitofMeasure.RESET();
                RecGItemUnitofMeasure.SETRANGE("Item No.", "No.");
                IF RecGItemUnitofMeasure.FINDSET() THEN
                    REPEAT
                        RecGItemUnitofMeasurePartner := RecGItemUnitofMeasure;
                        IF RecGItemUnitofMeasurePartner.INSERT() THEN;
                    UNTIL RecGItemUnitofMeasure.NEXT() = 0;

                //* Copier les tarifs achat associés
                RecGICPartnerPartner.RESET();
                RecGICPartnerPartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                IF RecGICPartnerPartner.FINDFIRST() THEN BEGIN
                    RecGVendorPartner.RESET();
                    RecGVendorPartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                    RecGVendorPartner.SETCURRENTKEY("IC Partner Code");
                    RecGVendorPartner.SETRANGE("IC Partner Code", RecGICPartnerPartner.Code);
                    IF NOT RecGVendorPartner.FINDFIRST() THEN
                        RecGVendorPartner.INIT();
                END;
                RecGPurchasePricePartner.RESET();
                RecGPurchasePricePartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                RecGPurchasePrice.RESET();
                RecGPurchasePrice.SETRANGE("Item No.", "No.");
                IF RecGPurchasePrice.FINDSET() THEN
                    REPEAT
                        RecGPurchasePricePartner := RecGPurchasePrice;
                        RecGPurchasePricePartner.VALIDATE("Vendor No.", RecGVendorPartner."No.");
                        IF RecGPurchasePricePartner.INSERT() THEN;
                    UNTIL RecGPurchasePrice.NEXT() = 0;

                MESSAGE(CstGText001, "No.", RecGICPartner.Name);
            UNTIL RecGICPartner.NEXT() = 0;
    end;

    var
        RecGICPartner: Record "IC Partner";
        RecGICPartnerPartner: Record "IC Partner";
        RecGItemPartner: Record Item;
        RecGItemUnitofMeasure: Record "Item Unit of Measure";
        RecGItemUnitofMeasurePartner: Record "Item Unit of Measure";
        RecGPurchasePrice: Record "Purchase Price";
        RecGPurchasePricePartner: Record "Purchase Price";
        RecGVendorPartner: Record Vendor;
        RecGItem: Record Item;
        CstGText000: Label 'Treatment allowed only for CNE.';

        CstGText001: Label 'Item %1 duplicate on Partner %2.';
        Windows: Dialog;
        ItemPartnerOldCostIncreaseCoeff: Decimal;


    procedure FctGUpdatePurchasePriceVendor(RecPVendor: Record Vendor)
    begin
        Windows.OPEN('Partenaire #1###################### \ Fournisseur #2######################## \ Article #3#################');

        RecGICPartner.RESET();
        IF RecGICPartner.FINDSET() THEN
            REPEAT
                RecGItemPartner.RESET();
                RecGItemPartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                RecGItem.RESET();
                RecGItem.SETCURRENTKEY("Vendor No.");
                RecGItem.SETRANGE("Vendor No.", RecPVendor."No.");
                IF RecGItem.FINDSET() THEN
                    REPEAT
                        Windows.UPDATE(1, RecGICPartner.Name);
                        Windows.UPDATE(2, RecPVendor."No.");
                        Windows.UPDATE(3, RecGItem."No.");

                        IF RecGItemPartner.GET(RecGItem."No.") THEN BEGIN
                            //* Mise à jour de l'article
                            RecGItemPartner.Blocked := RecGItem.Blocked;
                            RecGItemPartner."Standard Cost" := RecGItem."Standard Cost";
                            RecGItemPartner.Description := RecGItem.Description;
                            RecGItemPartner."Price Includes VAT" := RecGItem."Price Includes VAT";
                            RecGItemPartner."Item Disc. Group" := RecGItem."Item Disc. Group";
                            RecGItemPartner."Net Weight" := RecGItem."Net Weight";
                            RecGItemPartner."BC6_DEEE Category Code" := RecGItem."BC6_DEEE Category Code";
                            RecGItemPartner."BC6_Number of Units DEEE" := RecGItem."BC6_Number of Units DEEE";
                            RecGItemPartner."BC6_DEEE Unit Tax" := RecGItem."BC6_DEEE Unit Tax";
                            RecGItemPartner."Vendor No." := RecGItem."Vendor No.";
                            RecGItemPartner."Unit Price" := RecGItem."Unit Price";
                            RecGItemPartner."BC6_Unit Price Includes VAT" := RecGItem."BC6_Unit Price Includes VAT";
                            RecGItemPartner."Last Date Modified" := TODAY;
                            RecGItemPartner.MODIFY();
                        END ELSE BEGIN
                            //* Copier l'article
                            ItemPartnerOldCostIncreaseCoeff := RecGItemPartner."BC6_Cost Increase Coeff %";

                            RecGItemPartner := RecGItem;
                            IF RecGItemPartner.INSERT() THEN BEGIN
                                RecGItemPartner."BC6_Cost Increase Coeff %" := ItemPartnerOldCostIncreaseCoeff;
                                RecGItemPartner.MODIFY();
                            END;

                            //* Copier les unités articles associées
                            RecGItemUnitofMeasurePartner.RESET();
                            RecGItemUnitofMeasurePartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                            RecGItemUnitofMeasure.RESET();
                            RecGItemUnitofMeasure.SETRANGE("Item No.", RecGItem."No.");
                            IF RecGItemUnitofMeasure.FINDSET() THEN
                                REPEAT
                                    RecGItemUnitofMeasurePartner := RecGItemUnitofMeasure;
                                    IF RecGItemUnitofMeasurePartner.INSERT() THEN;
                                UNTIL RecGItemUnitofMeasure.NEXT() = 0;
                        END;
                    UNTIL RecGItem.NEXT() = 0;

                //* Copier les tarifs achat
                RecGICPartnerPartner.RESET();
                RecGICPartnerPartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                IF RecGICPartnerPartner.FINDFIRST() THEN BEGIN
                    RecGVendorPartner.RESET();
                    RecGVendorPartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                    RecGVendorPartner.SETCURRENTKEY("IC Partner Code");
                    RecGVendorPartner.SETRANGE("IC Partner Code", RecGICPartnerPartner.Code);
                    IF NOT RecGVendorPartner.FINDFIRST() THEN
                        RecGVendorPartner.INIT();
                END;
                RecGPurchasePricePartner.RESET();
                RecGPurchasePricePartner.CHANGECOMPANY(RecGICPartner."Inbox Details");
                RecGPurchasePrice.RESET();
                RecGPurchasePrice.SETCURRENTKEY("Vendor No.");
                RecGPurchasePrice.SETRANGE("Vendor No.", RecPVendor."No.");
                IF RecGPurchasePrice.FINDSET() THEN
                    REPEAT
                        Windows.UPDATE(1, RecGICPartner.Name);
                        Windows.UPDATE(2, RecPVendor."No.");
                        Windows.UPDATE(3, RecGItem."No.");
                        IF RecGPurchasePricePartner.GET(RecGPurchasePrice."Item No.", RecGVendorPartner."No.", RecGPurchasePrice."Starting Date", RecGPurchasePrice."Currency Code", RecGPurchasePrice."Variant Code", RecGPurchasePrice."Unit of Measure Code",
                                                        RecGPurchasePrice."Minimum Quantity") THEN
                            RecGPurchasePricePartner.DELETE();
                        RecGPurchasePricePartner := RecGPurchasePrice;
                        RecGPurchasePricePartner.VALIDATE("Vendor No.", RecGVendorPartner."No.");
                        IF RecGPurchasePricePartner.INSERT() THEN;
                    UNTIL RecGPurchasePrice.NEXT() = 0;
            UNTIL RecGICPartner.NEXT() = 0;
        Windows.CLOSE();
    end;
}

