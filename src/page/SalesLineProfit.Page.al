page 50022 "Sales Line Profit"
{
    // //MARGEVENTE SM 15/10/06 NCS1.01 [FE024V1]  Création basé sur F7004 + Ajout du champ 50000 Profit %
    // 
    // //>>CN1.04
    //   FEP_ADVE_200711_21_1-DEROGATOIRE:SOBI  24/07/08 : - design

    Caption = 'Sales Line Discounts';
    DataCaptionExpression = GetCaption;
    DelayedInsert = true;
    PageType = List;
    SaveValues = true;
    SourceTable = Table7004;
    SourceTableView = SORTING (Code, Sales Code, Sales Type, Type, Starting Date, Ending Date, Profit %)
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(SalesTypeFilter; SalesTypeFilter)
                {
                    Caption = 'Sales Type Filter';
                    OptionCaption = 'Customer,Customer Discount Group,All Customers,Campaign,None';

                    trigger OnValidate()
                    begin
                        SalesTypeFilterOnAfterValidate;
                    end;
                }
                field(SalesCodeFilterCtrl; SalesCodeFilter)
                {
                    Caption = 'Sales Code Filter';
                    Enabled = SalesCodeFilterCtrlEnable;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        "- MIGNAV2013": Integer;
                        CustList: Page "22";
                        CustDiscGrList: Page "512";
                        CampaignList: Page "5087";
                        ItemList: Page "31";
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
                    Caption = 'Type Filter';
                    OptionCaption = 'Item,Item Discount Group,None';

                    trigger OnValidate()
                    begin
                        ItemTypeFilterOnAfterValidate;
                    end;
                }
                field(CodeFilterCtrl; CodeFilter)
                {
                    Caption = 'Code Filter';
                    Enabled = CodeFilterCtrlEnable;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemList: Page "31";
                        ItemDiscGrList: Page "513";
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
                    Caption = 'Starting Date Filter';

                    trigger OnValidate()
                    var
                        ApplicationMgt: Codeunit "1";
                    begin
                        IF ApplicationMgt.MakeDateFilter(StartingDateFilter) = 0 THEN;
                        StartingDateFilterOnAfterValid;
                    end;
                }
            }
            repeater()
            {
                field("Sales Type"; "Sales Type")
                {
                }
                field("Sales Code"; "Sales Code")
                {
                    Editable = "Sales CodeEditable";
                }
                field(Type; Type)
                {
                }
                field(Code; Code)
                {
                }
                field("Line Discount %"; "Line Discount %")
                {
                }
                field("Profit %"; "Profit %")
                {
                    Visible = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    Visible = false;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field("Minimum Quantity"; "Minimum Quantity")
                {
                }
                field("Dispensation No."; "Dispensation No.")
                {
                }
                field("Added Discount %"; "Added Discount %")
                {
                }
                field("Starting Date"; "Starting Date")
                {
                }
                field("Ending Date"; "Ending Date")
                {
                }
            }
            group(Options)
            {
                Caption = 'Options';
                field(SalesCodeFilterCtrl2; CurrencyCodeFilter)
                {
                    Caption = 'Currency Code Filter';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CurrencyList: Page "5";
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
        OnAfterGetCurrRecord;
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
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        GetRecFilters;
        SetRecFilters;
        //SETCURRENTKEY(Code,"Sales Code","Sales Type",Type,"Starting Date","Ending Date","Profit %")
    end;

    var
        Cust: Record "18";
        CustDiscGr: Record "340";
        Campaign: Record "5071";
        Item: Record "27";
        ItemDiscGr: Record "341";
        SalesTypeFilter: Option Customer,"Customer Discount Group","All Customers",Campaign,"None";
        SalesCodeFilter: Text[250];
        ItemTypeFilter: Option Item,"Item Discount Group","None";
        CodeFilter: Text[250];
        StartingDateFilter: Text[30];
        Text000: Label 'All Customers';
        CurrencyCodeFilter: Text[250];
        "-NSC1.01--": ;
        Text004: Label 'Start Date Obligatory';
        [InDataSet]
        "Sales CodeEditable": Boolean;
        [InDataSet]
        SalesCodeFilterCtrlEnable: Boolean;
        [InDataSet]
        CodeFilterCtrlEnable: Boolean;

    [Scope('Internal')]
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

    [Scope('Internal')]
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

    [Scope('Internal')]
    procedure GetCaption(): Text[250]
    var
        ObjTransl: Record "377";
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
            ItemTypeFilter::"Item Discount Group":
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

