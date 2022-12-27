pageextension 50098 "BC6_PurchaseLineDiscounts" extends "Purchase Line Discounts" //7014
{
    DataCaptionExpression = NewGetCaption();
    //Unsupported feature: Property Insertion (SaveValues) on ""Purchase Line Discounts"(Page 7014)". TODO:

    layout
    {

        modify(ItemNoFilterCtrl)
        {
            Visible = false;
        }
        addafter(ItemNoFilterCtrl)
        {
            field(BC6_CodeFilterCtrl; CodeFilter)
            {
                Caption = 'Code Filter', Comment = 'FRA="Filtre code"';
                Enabled = BooGCodeFilterCtrl;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                    NewSetRecFilters();
                end;

                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemDiscGrList: Page "Item Disc. Groups";
                    ItemList: Page "Item List";
                    VendorList: Page "Vendor List";
                begin
                    CASE BC6_Type OF
                        BC6_Type::Item:
                            begin
                                ItemList.LookupMode := true;
                                if ItemList.RunModal() = ACTION::LookupOK then
                                    Text := ItemList.GetSelectionFilter()
                                else
                                    exit(false);
                                EXIT(FALSE);
                            END;
                        BC6_Type::"Item Disc. Group":
                            BEGIN
                                ItemDiscGrList.LOOKUPMODE := TRUE;
                                IF ItemDiscGrList.RUNMODAL() = ACTION::LookupOK THEN
                                    Text := ItemDiscGrList.GetSelectionFilter()
                                ELSE
                                    EXIT(FALSE);
                            END;
                    END;

                    exit(true);
                end;
            }
        }


        modify(VendNoFilterCtrl)
        {
            trigger OnBeforeValidate()
            begin
                NewSetRecFilters();
            end;
        }

        modify(StartingDateFilter)
        {
            trigger OnBeforeValidate()
            begin
                NewSetRecFilters();
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
        Item: Record Item;
        ItemDiscGr: Record "Item Discount Group";
        ItemDiscGrList: Page "Item Disc. Groups";
        VendorList: Page "Vendor List";
        [InDataSet]
        BooGCodeFilterCtrl: Boolean;
        ItemTypeFilter: Enum "BC6_Item Type Filter";
        "-NSC1.01-": Integer;
        ItemNoFilter: Text;
        VendNoFilter: Text;
        StartingDateFilter: Text[30];
        CodeFilter: Text[250];




    trigger OnOpenPage()
    begin
        GetRecFilters();
        NewSetRecFilters();
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
        NewSetRecFilters();
    end;

    local procedure NewSetRecFilters()
    begin
        BooGCodeFilterCtrl := TRUE;

        IF ItemTypeFilter <> ItemTypeFilter::None THEN
            SetRange(BC6_Type, ItemTypeFilter.AsInteger())
        ELSE
            SetRange(BC6_Type);

        IF (ItemTypeFilter = ItemTypeFilter::None) OR (ItemTypeFilter = ItemTypeFilter::"All Items") THEN BEGIN
            BooGCodeFilterCtrl := FALSE;
            CodeFilter := '';
        END;

        IF CodeFilter <> '' THEN
            SetFilter("Item No.", CodeFilter)
        ELSE
            SetRange("Item No.");

        if VendNoFilter <> '' then
            SetFilter("Vendor No.", VendNoFilter)
        else
            SetRange("Vendor No.");

        if StartingDateFilter <> '' then
            SetFilter("Starting Date", StartingDateFilter)
        else
            SetRange("Starting Date");

        CurrPage.Update(false);
    end;

    local procedure NewGetCaption(): Text[250]
    var
        ObjTransl: Record "Object Translation";
        Vendor: Record Vendor;
        Description: Text[250];
        SourceTableName: Text[250];
    begin
        GetRecFilters();

        if ItemNoFilter <> '' then
            SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, DATABASE::Item)
        else
            SourceTableName := '';

        SourceTableName := '';
        CASE ItemTypeFilter OF
            ItemTypeFilter::Item:
                BEGIN
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 27);
                    Item."No." := CodeFilter;
                END;
            ItemTypeFilter::"Item Discount Group":
                BEGIN
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 341);
                    ItemDiscGr.Code := CodeFilter;
                END;
        END;

        if VendNoFilter = '' then
            Description := ''
        else begin
            Vendor.SetFilter("No.", VendNoFilter);
            if Vendor.FindFirst() then
                Description := Vendor.Name;
        end;


    end;
}

