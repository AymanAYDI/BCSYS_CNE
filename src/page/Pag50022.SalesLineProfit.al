page 50022 "BC6_Sales Line Profit"
{
    Caption = 'Sales Line Discounts', Comment = 'FRA="Remises ligne vente"';
    DataCaptionExpression = GetCaption();
    DelayedInsert = true;
    PageType = List;
    SaveValues = true;
    UsageCategory = None;
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
                        SalesTypeFilterOnAfterValidate();
                    end;
                }
                field(SalesCodeFilterCtrl; SalesCodeFilter)
                {
                    Caption = 'Sales Code Filter', Comment = 'FRA="Filtre code vente"';
                    Enabled = SalesCodeFilterCtrlEnable;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CampaignList: Page "Campaign List";
                        CustDiscGrList: Page "Customer Disc. Groups";
                        CustList: Page "Customer List";
                        ItemList: Page "Item List";
                        "- MIGNAV2013": Integer;
                    begin
                        IF SalesTypeFilter = SalesTypeFilter::"All Customers" THEN EXIT;

                        CASE SalesTypeFilter OF
                            SalesTypeFilter::Customer:
                                BEGIN
                                    CustList.LOOKUPMODE := TRUE;
                                    IF CustList.RUNMODAL() = ACTION::LookupOK THEN
                                        Text := CustList.GetSelectionFilter()
                                    ELSE
                                        EXIT(FALSE);
                                END;
                            SalesTypeFilter::"Customer Discount Group":
                                BEGIN
                                    CustDiscGrList.LOOKUPMODE := TRUE;
                                    IF CustDiscGrList.RUNMODAL() = ACTION::LookupOK THEN
                                        Text := CustDiscGrList.GetSelectionFilter()
                                    ELSE
                                        EXIT(FALSE);
                                END;
                            SalesTypeFilter::Campaign:
                                BEGIN
                                    CampaignList.LOOKUPMODE := TRUE;
                                    IF CampaignList.RUNMODAL() = ACTION::LookupOK THEN
                                        Text := CampaignList.GetSelectionFilter()
                                    ELSE
                                        EXIT(FALSE);
                                END;
                        END;

                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        SalesCodeFilterOnAfterValidate();
                    end;
                }
                field(ItemTypeFilter; ItemTypeFilter)
                {
                    Caption = 'Type Filter', Comment = 'FRA="Filtre type"';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ItemTypeFilterOnAfterValidate();
                    end;
                }
                field(CodeFilterCtrl; CodeFilter)
                {
                    Caption = 'Code Filter', Comment = 'FRA="Filtre code"';
                    Enabled = CodeFilterCtrlEnable;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemDiscGrList: Page "Item Disc. Groups";
                        ItemList: Page "Item List";
                    begin
                        CASE Rec.Type OF
                            Rec.Type::Item:
                                BEGIN
                                    ItemList.LOOKUPMODE := TRUE;
                                    IF ItemList.RUNMODAL() = ACTION::LookupOK THEN
                                        Text := ItemList.GetSelectionFilter()
                                    ELSE
                                        EXIT(FALSE);
                                END;
                            Rec.Type::"Item Disc. Group":
                                BEGIN
                                    ItemDiscGrList.LOOKUPMODE := TRUE;
                                    IF ItemDiscGrList.RUNMODAL() = ACTION::LookupOK THEN
                                        Text := ItemDiscGrList.GetSelectionFilter()
                                    ELSE
                                        EXIT(FALSE);
                                END;
                        END;

                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        CodeFilterOnAfterValidate();
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
                        StartingDateFilterOnAfterValid();
                    end;
                }
            }
            repeater(Control1)
            {
                field("Sales Type"; Rec."Sales Type")
                {
                    ApplicationArea = All;
                }
                field("Sales Code"; Rec."Sales Code")
                {
                    Editable = "Sales CodeEditable";
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                }
                field("Profit %"; Rec."BC6_Profit %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Minimum Quantity"; Rec."Minimum Quantity")
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
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Ending Date"; Rec."Ending Date")
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
                        IF CurrencyList.RUNMODAL() = ACTION::LookupOK THEN
                            Text := CurrencyList.GetSelectionFilter()
                        ELSE
                            EXIT(FALSE);

                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        CurrencyCodeFilterOnAfterValid();
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
                PromotedOnly = true;

                trigger OnAction()
                begin
                    CODEUNIT.RUN(CODEUNIT::"Extract Item Group Discount", Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ProcOnAfterGetCurrRecord();
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
        IF (Rec."Starting Date" = 0D) OR (FORMAT(Rec."Starting Date") = '') THEN ERROR(Text004);
        //Fin DateDebutObli HJ 15/11/2006 NSC1.01 [24] Date Debut Doit Etre Obligatoire
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ProcOnAfterGetCurrRecord();
    end;

    trigger OnOpenPage()
    begin
        GetRecFilters();
        SetRecFilters();
        //SETCURRENTKEY(Code,"Sales Code","Sales Type",Type,"Starting Date","Ending Date","Profit %")
    end;

    var
        Campaign: Record Campaign;
        Cust: Record Customer;
        CustDiscGr: Record "Customer Discount Group";
        Item: Record Item;
        ItemDiscGr: Record "Item Discount Group";
        [InDataSet]
        CodeFilterCtrlEnable: Boolean;
        [InDataSet]
        "Sales CodeEditable": Boolean;
        [InDataSet]
        SalesCodeFilterCtrlEnable: Boolean;
        ItemTypeFilter: Enum "Sales Line Discount Type";
        SalesTypeFilter: Enum "Sales Price Type";
        Text000: Label 'All Customers', Comment = 'FRA="Tous les clients"';
        Text004: Label 'Start Date Obligatory', Comment = 'FRA="Date Début Obligatoire"';
        StartingDateFilter: Text[30];
        CodeFilter: Text[250];
        CurrencyCodeFilter: Text[250];
        SalesCodeFilter: Text[250];


    procedure GetRecFilters()
    begin
        IF Rec.GETFILTERS <> '' THEN BEGIN
            IF Rec.GETFILTER("Sales Type") <> '' THEN
                SalesTypeFilter := Rec."Sales Type"
            ELSE
                SalesTypeFilter := SalesTypeFilter::None;

            IF Rec.GETFILTER(Type) <> '' THEN
                ItemTypeFilter := Rec.Type
            ELSE
                ItemTypeFilter := ItemTypeFilter::None;

            SalesCodeFilter := Rec.GETFILTER("Sales Code");
            CodeFilter := Rec.GETFILTER(Code);
            CurrencyCodeFilter := Rec.GETFILTER("Currency Code");
            EVALUATE(StartingDateFilter, Rec.GETFILTER("Starting Date"));
        END;
    end;


    procedure SetRecFilters()
    begin
        SalesCodeFilterCtrlEnable := TRUE;
        CodeFilterCtrlEnable := TRUE;

        IF SalesTypeFilter <> SalesTypeFilter::None THEN
            Rec.SETRANGE("Sales Type", SalesTypeFilter)
        ELSE
            Rec.SETRANGE("Sales Type");

        IF SalesTypeFilter IN [SalesTypeFilter::"All Customers", SalesTypeFilter::None] THEN BEGIN
            SalesCodeFilterCtrlEnable := FALSE;
            SalesCodeFilter := '';
        END;

        IF SalesCodeFilter <> '' THEN
            Rec.SETFILTER("Sales Code", SalesCodeFilter)
        ELSE
            Rec.SETRANGE("Sales Code");

        IF ItemTypeFilter <> ItemTypeFilter::None THEN
            Rec.SETRANGE(Type, ItemTypeFilter)
        ELSE
            Rec.SETRANGE(Type);

        IF ItemTypeFilter = ItemTypeFilter::None THEN BEGIN
            CodeFilterCtrlEnable := FALSE;
            CodeFilter := '';
        END;

        IF CodeFilter <> '' THEN BEGIN
            Rec.SETFILTER(Code, CodeFilter);
        END ELSE
            Rec.SETRANGE(Code);

        IF CurrencyCodeFilter <> '' THEN BEGIN
            Rec.SETFILTER("Currency Code", CurrencyCodeFilter);
        END ELSE
            Rec.SETRANGE("Currency Code");

        IF StartingDateFilter <> '' THEN
            Rec.SETFILTER("Starting Date", StartingDateFilter)
        ELSE
            Rec.SETRANGE("Starting Date");

        CurrPage.UPDATE(FALSE);
    end;

    procedure GetCaption(): Text[250]
    var
        ObjTransl: Record "Object Translation";
        SalesSrcTableName: Text[100];
        SourceTableName: Text[100];
        Description: Text[250];
    begin
        GetRecFilters();
        "Sales CodeEditable" := Rec."Sales Type" <> Rec."Sales Type"::"All Customers";

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
                    IF Cust.FIND() THEN
                        Description := Cust.Name;
                END;
            SalesTypeFilter::"Customer Discount Group":
                BEGIN
                    SalesSrcTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 340);
                    CustDiscGr.Code := SalesCodeFilter;
                    IF CustDiscGr.FIND() THEN
                        Description := CustDiscGr.Description;
                END;
            SalesTypeFilter::Campaign:
                BEGIN
                    SalesSrcTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 5071);
                    Campaign."No." := SalesCodeFilter;
                    IF Campaign.FIND() THEN
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
        CurrPage.SAVERECORD();
        SetRecFilters();
    end;

    local procedure SalesTypeFilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD();
        SalesCodeFilter := '';
        SetRecFilters();
    end;

    local procedure StartingDateFilterOnAfterValid()
    begin
        CurrPage.SAVERECORD();
        SetRecFilters();
    end;

    local procedure ItemTypeFilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD();
        CodeFilter := '';
        SetRecFilters();
    end;

    local procedure CodeFilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD();
        SetRecFilters();
    end;

    local procedure CurrencyCodeFilterOnAfterValid()
    begin
        CurrPage.SAVERECORD();
        SetRecFilters();
    end;

    local procedure ProcOnAfterGetCurrRecord()
    begin
        xRec := Rec;
        "Sales CodeEditable" := Rec."Sales Type" <> Rec."Sales Type"::"All Customers";
    end;
}

