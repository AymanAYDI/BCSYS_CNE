pageextension 50102 "BC6_PurchaseLineDiscounts" extends "Purchase Line Discounts" //7014
{

    //Unsupported feature: Property Insertion (SaveValues) on ""Purchase Line Discounts"(Page 7014)". TODO:

    layout
    {
        modify(ItemNoFilterCtrl)
        {

            //Unsupported feature: Property Modification (Name) on "ItemNoFilterCtrl(Control 32)". TODO:

            Caption = 'Code Filter';

            //Unsupported feature: Property Modification (SourceExpr) on "ItemNoFilterCtrl(Control 32)". TODO:

            Enabled = BooGCodeFilterCtrl;

            trigger OnBeforeValidate()
            begin
                BooGCodeFilterCtrl := TRUE;

                IF ItemTypeFilter <> ItemTypeFilter::None THEN
                    SETRANGE(BC6_Type, ItemTypeFilter.AsInteger())
                ELSE
                    SETRANGE(BC6_Type);

                IF (ItemTypeFilter = ItemTypeFilter::None) OR (ItemTypeFilter = ItemTypeFilter::"All Items") THEN BEGIN
                    BooGCodeFilterCtrl := FALSE;
                    CodeFilter := '';
                END;

                IF CodeFilter <> '' THEN
                    SETFILTER("Item No.", CodeFilter)
                ELSE
                    SETRANGE("Item No.");
            end;

            trigger OnLookup(var Text: Text): Boolean
            var
                ItemList: Page "Item List";
                "- MIGNAV2013 -": Integer;
                ItemDiscGrList: Page "Item Disc. Groups";
                VendorList: Page "Vendor List";
            begin
                CASE BC6_Type OF
                    BC6_Type::Item:
                        begin
                            ItemList.LookupMode := true;
                            if ItemList.RunModal = ACTION::LookupOK then
                                Text := ItemList.GetSelectionFilter
                            else
                                exit(false);
                            EXIT(FALSE);
                        END;
                    BC6_Type::"Item Disc. Group":
                        BEGIN
                            ItemDiscGrList.LOOKUPMODE := TRUE;
                            IF ItemDiscGrList.RUNMODAL = ACTION::LookupOK THEN
                                Text := ItemDiscGrList.GetSelectionFilter
                            ELSE
                                EXIT(FALSE);
                        END;
                END;

                exit(true);
            end;
        }

        modify(VendNoFilterCtrl)
        {
            trigger OnBeforeValidate()
            begin
                BooGCodeFilterCtrl := TRUE;

                IF ItemTypeFilter <> ItemTypeFilter::None THEN
                    SETRANGE(BC6_Type, ItemTypeFilter.AsInteger())
                ELSE
                    SETRANGE(BC6_Type);

                IF (ItemTypeFilter = ItemTypeFilter::None) OR (ItemTypeFilter = ItemTypeFilter::"All Items") THEN BEGIN
                    BooGCodeFilterCtrl := FALSE;
                    CodeFilter := '';
                END;

                IF CodeFilter <> '' THEN
                    SETFILTER("Item No.", CodeFilter)
                ELSE
                    SETRANGE("Item No.");
            end;
        }

        modify(StartingDateFilter)
        {
            trigger OnBeforeValidate()
            begin
                BooGCodeFilterCtrl := TRUE;

                IF ItemTypeFilter <> ItemTypeFilter::None THEN
                    SETRANGE(BC6_Type, ItemTypeFilter.AsInteger())
                ELSE
                    SETRANGE(BC6_Type);

                IF (ItemTypeFilter = ItemTypeFilter::None) OR (ItemTypeFilter = ItemTypeFilter::"All Items") THEN BEGIN
                    BooGCodeFilterCtrl := FALSE;
                    CodeFilter := '';
                END;

                IF CodeFilter <> '' THEN
                    SETFILTER("Item No.", CodeFilter)
                ELSE
                    SETRANGE("Item No.");
            end;
        }

        addafter(VendNoFilterCtrl)
        {
            field(BC6_ItemTypeFilter; ItemTypeFilter)
            {
                Caption = 'Type Filter', Comment = 'FRA="Filtre type"';
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    ItemTypeFilterOnAfterValidate();
                end;
            }
        }
        addfirst(Control1)
        {
            field(BC6_Type; BC6_Type)
            {
                ApplicationArea = All;
            }
        }
    }

    var
        "- MIGNAV2013 -": Integer;
        ItemDiscGrList: Page "Item Disc. Groups";
        VendorList: Page "Vendor List";

    var
        "-NSC1.01-": Integer;
        ItemTypeFilter: Enum "BC6_Item Type Filter";
        CodeFilter: Text[250];
        Item: Record Item;
        ItemDiscGr: Record "Item Discount Group";
        [InDataSet]
        BooGCodeFilterCtrl: Boolean;
        VendNoFilter: Text;
        ItemNoFilter: Text;
        StartingDateFilter: Text[30];




    trigger OnOpenPage()
    begin
        GetRecFilters();
        SetRecFilters();
    end;

    procedure GetRecFilters() //TODO: Check
    begin
        if GetFilters <> '' then begin
            VendNoFilter := GetFilter("Vendor No.");
            ItemNoFilter := GetFilter("Item No.");
            Evaluate(StartingDateFilter, GetFilter("Starting Date"));
        end;
    end;

    procedure ItemTypeFilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD();
        CodeFilter := '';
        SetRecFilters();
    end;
}

