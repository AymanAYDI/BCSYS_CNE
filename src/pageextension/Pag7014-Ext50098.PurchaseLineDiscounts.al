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
                ApplicationArea = All;
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
                begin
                    CASE Rec.BC6_Type OF
                        Rec.BC6_Type::Item:
                            begin
                                ItemList.LookupMode := true;
                                if ItemList.RunModal() = ACTION::LookupOK then
                                    Text := ItemList.GetSelectionFilter()
                                else
                                    exit(false);
                                EXIT(FALSE);
                            END;
                        Rec.BC6_Type::"Item Disc. Group":
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
                ApplicationArea = All;
                Caption = 'Type Filter', Comment = 'FRA="Filtre type"';

                trigger OnValidate()
                begin
                    ItemTypeFilterOnAfterValidate();
                end;
            }
        }
        addfirst(Control1)
        {
            field(BC6_Type; Rec.BC6_Type)
            {
                ApplicationArea = All;
            }
        }
    }

    var
        Item: Record Item;
        ItemDiscGr: Record "Item Discount Group";
        [InDataSet]
        BooGCodeFilterCtrl: Boolean;
        ItemTypeFilter: Enum "BC6_Item Type Filter";
        ItemNoFilter: Text;
        VendNoFilter: Text;
        StartingDateFilter: Text[30];
        CodeFilter: Text[250];

    trigger OnOpenPage()
    begin
        GetRecFilters();
        NewSetRecFilters();
    end;

    procedure GetRecFilters()
    begin
        if Rec.GetFilters <> '' then begin
            VendNoFilter := Rec.GetFilter("Vendor No.");
            ItemNoFilter := Rec.GetFilter("Item No.");
            Evaluate(StartingDateFilter, Rec.GetFilter("Starting Date"));
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
            Rec.SetRange(BC6_Type, ItemTypeFilter.AsInteger())
        ELSE
            Rec.SetRange(BC6_Type);

        IF (ItemTypeFilter = ItemTypeFilter::None) OR (ItemTypeFilter = ItemTypeFilter::"All Items") THEN BEGIN
            BooGCodeFilterCtrl := FALSE;
            CodeFilter := '';
        END;

        IF CodeFilter <> '' THEN
            Rec.SetFilter("Item No.", CodeFilter)
        ELSE
            Rec.SetRange("Item No.");

        if VendNoFilter <> '' then
            Rec.SetFilter("Vendor No.", VendNoFilter)
        else
            Rec.SetRange("Vendor No.");

        if StartingDateFilter <> '' then
            Rec.SetFilter("Starting Date", StartingDateFilter)
        else
            Rec.SetRange("Starting Date");

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
                    Item."No." := CopyStr(CodeFilter, 1, MaxStrLen(Item."No."));
                END;
            ItemTypeFilter::"Item Discount Group":
                BEGIN
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 341);
                    ItemDiscGr.Code := CopyStr(CodeFilter, 1, MaxStrLen(ItemDiscGr.Code));
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
