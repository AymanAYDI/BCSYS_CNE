pageextension 50102 pageextension50102 extends "Purchase Line Discounts"
{

    //Unsupported feature: Property Insertion (SaveValues) on ""Purchase Line Discounts"(Page 7014)".

    layout
    {
        modify(ItemNoFilterCtrl)
        {

            //Unsupported feature: Property Modification (Name) on "ItemNoFilterCtrl(Control 32)".

            Caption = 'Code Filter';

            //Unsupported feature: Property Modification (SourceExpr) on "ItemNoFilterCtrl(Control 32)".

            Enabled = BooGCodeFilterCtrl;
        }

        //Unsupported feature: Code Modification on "ItemNoFilterCtrl(Control 32).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ItemList.LOOKUPMODE := TRUE;
        IF ItemList.RUNMODAL = ACTION::LookupOK THEN
          Text := ItemList.GetSelectionFilter
        ELSE
          EXIT(FALSE);

        EXIT(TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CASE Type OF
          Type::Item:
            BEGIN
              ItemList.LOOKUPMODE := TRUE;
              IF ItemList.RUNMODAL = ACTION::LookupOK THEN
                Text := ItemList.GetSelectionFilter
              ELSE
                EXIT(FALSE);
            END;
        //>>MIGRATION NAV 2013
            Type::"Item Disc. Group":
            BEGIN
              ItemDiscGrList.LOOKUPMODE := TRUE;
              IF ItemDiscGrList.RUNMODAL = ACTION::LookupOK THEN
                Text := ItemDiscGrList.GetSelectionFilter
              ELSE
                EXIT(FALSE);
            END;
        //<<MIGRATION NAV 2013
        END;

        EXIT(TRUE);
        */
        //end;
        addafter(VendNoFilterCtrl)
        {
            field(ItemTypeFilter; ItemTypeFilter)
            {
                Caption = 'Type Filter';
                OptionCaption = 'Item,Item Discount Group,All Items,None';

                trigger OnValidate()
                begin
                    ItemTypeFilterOnAfterValidate;
                end;
            }
        }
        addfirst("Control 1")
        {
            field(Type; Type)
            {
            }
        }
    }

    var
        "- MIGNAV2013 -": Integer;
        ItemDiscGrList: Page "513";
        VendorList: Page "27";

    var
        "-NSC1.01-": Integer;
        ItemTypeFilter: Option Item,"Item Discount Group","All Items","None";
        CodeFilter: Text[250];
        Item: Record "27";
        ItemDiscGr: Record "341";
        [InDataSet]
        BooGCodeFilterCtrl: Boolean;


        //Unsupported feature: Code Insertion on "OnOpenPage".

        //trigger OnOpenPage()
        //begin
        /*
        //GESTION_REMISE FG 06/12/06 NSC1.01
        GetRecFilters;
        SetRecFilters;
        //Fin GESTION_REMISE FG 06/12/06 NSC1.01
        */
        //end;


        //Unsupported feature: Code Modification on "GetRecFilters(PROCEDURE 2)".

        //procedure GetRecFilters();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF GETFILTERS <> '' THEN BEGIN
          VendNoFilter := GETFILTER("Vendor No.");
          ItemNoFilter := GETFILTER("Item No.");
          EVALUATE(StartingDateFilter,GETFILTER("Starting Date"));
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF GETFILTERS <> '' THEN BEGIN
          VendNoFilter := GETFILTER("Vendor No.");

          //GESTION_REMISE FG 06/12/06 NSC1.01
          IF GETFILTER(Type) <> '' THEN
            ItemTypeFilter := Type
          ELSE
            ItemTypeFilter := ItemTypeFilter::None;

          //>>CODE_FILTER CASC 12/01/2007
          //ItemNoFilter := GETFILTER(Code);
          //<<CODE_FILTER CASC 12/01/2007

          //Fin GESTION_REMISE FG 06/12/06 NSC1.01
          EVALUATE(StartingDateFilter,GETFILTER("Starting Date"));
        END;
        */
        //end;


        //Unsupported feature: Code Modification on "SetRecFilters(PROCEDURE 1)".

        //procedure SetRecFilters();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF VendNoFilter <> '' THEN
          SETFILTER("Vendor No.",VendNoFilter)
        ELSE
          SETRANGE("Vendor No.");

        IF StartingDateFilter <> '' THEN
          SETFILTER("Starting Date",StartingDateFilter)
        ELSE
          SETRANGE("Starting Date");

        IF ItemNoFilter <> '' THEN
          SETFILTER("Item No.",ItemNoFilter)
        ELSE
          SETRANGE("Item No.");

        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //GESTION_REMISE FG 06/12/06 NSC1.01
        BooGCodeFilterCtrl := TRUE;

        IF ItemTypeFilter <> ItemTypeFilter::None THEN
          SETRANGE(Type,ItemTypeFilter)
        ELSE
          SETRANGE(Type);

        IF (ItemTypeFilter = ItemTypeFilter::None) OR (ItemTypeFilter = ItemTypeFilter::"All Items") THEN BEGIN
          BooGCodeFilterCtrl := FALSE;
          CodeFilter := '';
        END;

        IF CodeFilter <> '' THEN BEGIN
          SETFILTER("Item No.",CodeFilter);
        END ELSE
          SETRANGE("Item No.");
        //Fin GESTION_REMISE FG 06/12/06 NSC1.01

        #1..10
        //IF ItemNoFilter <> '' THEN
        //  SETFILTER(Code,ItemNoFilter)
        //ELSE
        //  SETRANGE(Code);

        CurrPage.UPDATE(FALSE);
        */
        //end;


        //Unsupported feature: Code Modification on "GetCaption(PROCEDURE 3)".

        //procedure GetCaption();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetRecFilters;

        IF ItemNoFilter <> '' THEN
          SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,DATABASE::Item)
        ELSE
          SourceTableName := '';

        IF VendNoFilter = '' THEN
          Description := ''
        ELSE BEGIN
          Vendor.SETFILTER("No.",VendNoFilter);
          IF Vendor.FINDFIRST THEN
            Description := Vendor.Name;
        END;

        EXIT(STRSUBSTNO('%1 %2 %3 %4 ',VendNoFilter,Description,SourceTableName,ItemNoFilter));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6
        //>>MIGRATION NAV 2013
        SourceTableName := '';
        CASE ItemTypeFilter OF
          ItemTypeFilter::Item:
            BEGIN
              SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,27);
              Item."No." := CodeFilter;
            END;
          ItemTypeFilter::"Item Discount Group":
            BEGIN
              SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,341);
              ItemDiscGr.Code := CodeFilter;
            END;
        END;
        //<<MIGRATION NAV 2013
        #7..15
        //EXIT(STRSUBSTNO('%1 %2 %3 %4 ',VendNoFilter,Description,SourceTableName,CodeFilter));
        */
        //end;

    procedure "--- MIGNAV2013 ---"()
    begin
    end;

    procedure ItemTypeFilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        CodeFilter := '';
        SetRecFilters;
    end;
}

