page 50022 "BC6_Sales Line Profit"
{
    Caption = 'Sales Line Discounts', Comment = 'FRA="Remises ligne vente"';
    DataCaptionExpression = GetCaption();
    DelayedInsert = true;
    PageType = List;
    SaveValues = true;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Line Discount";
    SourceTableView = SORTING(Code, "Sales Code", "Sales Type", Type, "Starting Date", "Ending Date", "BC6_Profit %")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'FRA="Général"';
                field(SalesTypeFilter; SalesTypeFilter)
                {
                    Caption = 'Sales Type Filter', Comment = 'FRA="Filtre type vente"';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SalesTypeFilterOnAfterValidate;
                    end;
                }
                field(SalesCodeFilterCtrl; SalesCodeFilter)
                {
                    Caption = 'Sales Code Filter', Comment = 'FRA="Filtre code vente"';
                    Enabled = SalesCodeFilterCtrlEnable;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        "- MIGNAV2013": Integer;
                        CustList: Page "Customer List";
                        CustDiscGrList: Page "Customer Disc. Groups";
                        CampaignList: Page "Campaign List";
                        ItemList: Page "Item List";
                    begin
                        IF SalesTypeFilter = SalesTypeFilter::"All Customers" THEN EXIT;

                        CASE SalesTypeFilter OF
                            SalesTypeFilter::Customer:
                                BEGIN
                                    CustList.LOOKUPMODE := TRUE;
                                    IF CustList.RUNMODAL = ACTION::LookupOK THEN
                                        Text := CustList.GetSelectionFilter
                                    ELSE
                                        EXIT(FALSE);
                                END;
                            SalesTypeFilter::"Customer Discount Group":
                                BEGIN
                                    CustDiscGrList.LOOKUPMODE := TRUE;
                                    IF CustDiscGrList.RUNMODAL = ACTION::LookupOK THEN
                                        Text := CustDiscGrList.GetSelectionFilter
                                    ELSE
                                        EXIT(FALSE);
                                END;
                            SalesTypeFilter::Campaign:
                                BEGIN
                                    CampaignList.LOOKUPMODE := TRUE;
                                    IF CampaignList.RUNMODAL = ACTION::LookupOK THEN
                                        Text := CampaignList.GetSelectionFilter
                                    ELSE
                                        EXIT(FALSE);
                                END;
                        END;

                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        SalesCodeFilterOnAfterValidate;
                    end;
                }
                field(ItemTypeFilter; ItemTypeFilter)
                {
                    Caption = 'Type Filter', Comment = 'FRA="Filtre type"';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ItemTypeFilterOnAfterValidate;
                    end;
                }
                field(CodeFilterCtrl; CodeFilter)
                {
                    Caption = 'Code Filter', Comment = 'FRA="Filtre code"';
                    Enabled = CodeFilterCtrlEnable;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemList: Page "Item List";
                        ItemDiscGrList: Page "Item Disc. Groups";
                    begin
                        CASE Type OF
                            Type::Item:
                                BEGIN
                                    ItemList.LOOKUPMODE := TRUE;
                                    IF ItemList.RUNMODAL = ACTION::LookupOK THEN
                                        Text := ItemList.GetSelectionFilter
                                    ELSE
                                        EXIT(FALSE);
                                END;
                            Type::"Item Disc. Group":
                                BEGIN
                                    ItemDiscGrList.LOOKUPMODE := TRUE;
                                    IF ItemDiscGrList.RUNMODAL = ACTION::LookupOK THEN
                                        Text := ItemDiscGrList.GetSelectionFilter
                                    ELSE
                                        EXIT(FALSE);
                                END;
                        END;

                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        CodeFilterOnAfterValidate;
                    end;
                }
                field(StartingDateFilter; StartingDateFilter)
                {
                    Caption = 'Starting Date Filter', Comment = 'FRA="Filtre date début"';
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ApplicationMgt: Codeunit "Filter Tokens";
                    begin
                        // IF ApplicationMgt.MakeDateFilter(StartingDateFilter) = 0 THEN; // TODO: Old code
                        ApplicationMgt.MakeDateFilter(StartingDateFilter);
                        StartingDateFilterOnAfterValid;
                    end;
                }
            }
            repeater(Control1)
            {
                field("Sales Type"; "Sales Type")
                {
                    ApplicationArea = All;
                }
                field("Sales Code"; "Sales Code")
                {
                    Editable = "Sales CodeEditable";
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("Code"; Code)
                {
                    ApplicationArea = All;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    ApplicationArea = All;
                }
                field("Profit %"; Rec."BC6_Profit %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Minimum Quantity"; "Minimum Quantity")
                {
                    ApplicationArea = All;
                }
                field("Dispensation No."; Rec."BC6_Dispensation No.")
                {
                    ApplicationArea = All;
                }
                field("Added Discount %"; Rec."BC6_Added Discount %")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; "Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Ending Date"; "Ending Date")
                {
                    ApplicationArea = All;
                }
            }
            group(Options)
            {
                Caption = 'Options';
                field(SalesCodeFilterCtrl2; CurrencyCodeFilter)
                {
                    Caption = 'Currency Code Filter';
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CurrencyList: Page Currencies;
                    begin
                        CurrencyList.LOOKUPMODE := TRUE;
                        IF CurrencyList.RUNMODAL = ACTION::LookupOK THEN
                            Text := CurrencyList.GetSelectionFilter
                        ELSE
                            EXIT(FALSE);

                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        CurrencyCodeFilterOnAfterValid;
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Extract Discount Item Group")
            {
                Caption = 'Extract Discount Item Group';
                Ellipsis = true;
                Image = Group;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //>> 29.03.2012 Extract Discount
                    CODEUNIT.RUN(CODEUNIT::"Extract Item Group Discount", Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnInit()
    begin
        CodeFilterCtrlEnable := TRUE;
        SalesCodeFilterCtrlEnable := TRUE;
        "Sales CodeEditable" := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //DateDebutObli HJ 15/11/2006 NSC1.01 [24] Date Debut Doit Etre Obligatoire
        IF ("Starting Date" = 0D) OR (FORMAT("Starting Date") = '') THEN ERROR(Text004);
        //Fin DateDebutObli HJ 15/11/2006 NSC1.01 [24] Date Debut Doit Etre Obligatoire
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnOpenPage()
    begin
        GetRecFilters;
        SetRecFilters;
        //SETCURRENTKEY(Code,"Sales Code","Sales Type",Type,"Starting Date","Ending Date","Profit %")
    end;

    var
        Cust: Record Customer;
        CustDiscGr: Record "Customer Discount Group";
        Campaign: Record Campaign;
        Item: Record Item;
        ItemDiscGr: Record "Item Discount Group";
        SalesTypeFilter: Enum "Sales Price Type";
        SalesCodeFilter: Text[250];
        ItemTypeFilter: Enum "Sales Line Discount Type";
        CodeFilter: Text[250];
        StartingDateFilter: Text[30];
        Text000: Label 'All Customers', Comment = 'FRA="Tous les clients"';
        CurrencyCodeFilter: Text[250];
        Text004: Label 'Start Date Obligatory', Comment = 'FRA="Date Début Obligatoire"';
        [InDataSet]
        "Sales CodeEditable": Boolean;
        [InDataSet]
        SalesCodeFilterCtrlEnable: Boolean;
        [InDataSet]
        CodeFilterCtrlEnable: Boolean;


    procedure GetRecFilters()
    begin
        IF GETFILTERS <> '' THEN BEGIN
            IF GETFILTER("Sales Type") <> '' THEN
                SalesTypeFilter := "Sales Type"
            ELSE
                SalesTypeFilter := SalesTypeFilter::None;

            IF GETFILTER(Type) <> '' THEN
                ItemTypeFilter := Type
            ELSE
                ItemTypeFilter := ItemTypeFilter::None;

            SalesCodeFilter := GETFILTER("Sales Code");
            CodeFilter := GETFILTER(Code);
            CurrencyCodeFilter := GETFILTER("Currency Code");
            EVALUATE(StartingDateFilter, GETFILTER("Starting Date"));
        END;
    end;


    procedure SetRecFilters()
    begin
        SalesCodeFilterCtrlEnable := TRUE;
        CodeFilterCtrlEnable := TRUE;

        IF SalesTypeFilter <> SalesTypeFilter::None THEN
            SETRANGE("Sales Type", SalesTypeFilter)
        ELSE
            SETRANGE("Sales Type");

        IF SalesTypeFilter IN [SalesTypeFilter::"All Customers", SalesTypeFilter::None] THEN BEGIN
            SalesCodeFilterCtrlEnable := FALSE;
            SalesCodeFilter := '';
        END;

        IF SalesCodeFilter <> '' THEN
            SETFILTER("Sales Code", SalesCodeFilter)
        ELSE
            SETRANGE("Sales Code");

        IF ItemTypeFilter <> ItemTypeFilter::None THEN
            SETRANGE(Type, ItemTypeFilter)
        ELSE
            SETRANGE(Type);

        IF ItemTypeFilter = ItemTypeFilter::None THEN BEGIN
            CodeFilterCtrlEnable := FALSE;
            CodeFilter := '';
        END;

        IF CodeFilter <> '' THEN BEGIN
            SETFILTER(Code, CodeFilter);
        END ELSE
            SETRANGE(Code);

        IF CurrencyCodeFilter <> '' THEN BEGIN
            SETFILTER("Currency Code", CurrencyCodeFilter);
        END ELSE
            SETRANGE("Currency Code");

        IF StartingDateFilter <> '' THEN
            SETFILTER("Starting Date", StartingDateFilter)
        ELSE
            SETRANGE("Starting Date");

        CurrPage.UPDATE(FALSE);
    end;

    procedure GetCaption(): Text[250]
    var
        ObjTransl: Record "Object Translation";
        SourceTableName: Text[100];
        SalesSrcTableName: Text[100];
        Description: Text[250];
    begin
        GetRecFilters;
        "Sales CodeEditable" := "Sales Type" <> "Sales Type"::"All Customers";

        SourceTableName := '';
        CASE ItemTypeFilter OF
            ItemTypeFilter::Item:
                BEGIN
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 27);
                    Item."No." := CodeFilter;
                END;
            ItemTypeFilter::"Item Disc. Group":
                BEGIN
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 341);
                    ItemDiscGr.Code := CodeFilter;
                END;
        END;

        SalesSrcTableName := '';
        CASE SalesTypeFilter OF
            SalesTypeFilter::Customer:
                BEGIN
                    SalesSrcTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 18);
                    Cust."No." := SalesCodeFilter;
                    IF Cust.FIND THEN
                        Description := Cust.Name;
                END;
            SalesTypeFilter::"Customer Discount Group":
                BEGIN
                    SalesSrcTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 340);
                    CustDiscGr.Code := SalesCodeFilter;
                    IF CustDiscGr.FIND THEN
                        Description := CustDiscGr.Description;
                END;
            SalesTypeFilter::Campaign:
                BEGIN
                    SalesSrcTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 5071);
                    Campaign."No." := SalesCodeFilter;
                    IF Campaign.FIND THEN
                        Description := Campaign.Description;
                END;

            SalesTypeFilter::"All Customers":
                BEGIN
                    SalesSrcTableName := Text000;
                    Description := '';
                END;
        END;

        IF SalesSrcTableName = Text000 THEN
            EXIT(STRSUBSTNO('%1 %2 %3 %4 %5', SalesSrcTableName, SalesCodeFilter, Description, SourceTableName, CodeFilter));
        EXIT(STRSUBSTNO('%1 %2 %3 %4 %5', SalesSrcTableName, SalesCodeFilter, Description, SourceTableName, CodeFilter));
    end;

    local procedure SalesCodeFilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;
    end;

    local procedure SalesTypeFilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        SalesCodeFilter := '';
        SetRecFilters;
    end;

    local procedure StartingDateFilterOnAfterValid()
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;
    end;

    local procedure ItemTypeFilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        CodeFilter := '';
        SetRecFilters;
    end;

    local procedure CodeFilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;
    end;

    local procedure CurrencyCodeFilterOnAfterValid()
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        "Sales CodeEditable" := "Sales Type" <> "Sales Type"::"All Customers";
    end;
}

