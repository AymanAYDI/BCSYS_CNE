report 50006 "BC6_Calcul Plan - Req. Wksh."  //699
{
    Caption = 'Calculate Plan - Req. Wksh.', Comment = 'FRA="Calculer planning - F. demande"';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("Low-Level Code")
                                WHERE(Type = CONST(Inventory),
                                      "No." = FILTER(<> 'CEL0-031819'));
            RequestFilterFields = "No.", "Search Description", "Location Filter";

            trigger OnAfterGetRecord()
            begin
                IF Counter MOD 5 = 0 THEN
                    Window.UPDATE(1, "No.");
                Counter := Counter + 1;

                IF SkipPlanningForItemOnReqWksh(Item) THEN
                    CurrReport.SKIP();

                PlanningAssignment.SETRANGE("Item No.", "No.");

                ReqLine.LOCKTABLE();
                ActionMessageEntry.LOCKTABLE();

                PurchReqLine.SETRANGE("No.", "No.");
                PurchReqLine.MODIFYALL("Accept Action Message", FALSE);
                PurchReqLine.DELETEALL(TRUE);

                ReqLineExtern.SETRANGE(Type, ReqLine.Type::Item);
                ReqLineExtern.SETRANGE("No.", "No.");
                IF ReqLineExtern.FIND('-') THEN
                    REPEAT
                        ReqLineExtern.DELETE(TRUE);
                    UNTIL ReqLineExtern.NEXT() = 0;

                InvtProfileOffsetting.SetParm(UseForecast, ExcludeForecastBefore, CurrWorksheetType);
                InvtProfileOffsetting.CalculatePlanFromWorksheet(
                  Item,
                  MfgSetup,
                  CurrTemplateName,
                  CurrWorksheetName,
                  FromDate,
                  ToDate,
                  TRUE,
                  RespectPlanningParm);

                IF PlanningAssignment.FIND('-') THEN
                    REPEAT
                        IF PlanningAssignment."Latest Date" <= ToDate THEN BEGIN
                            PlanningAssignment.Inactive := TRUE;
                            PlanningAssignment.MODIFY();
                        END;
                    UNTIL PlanningAssignment.NEXT() = 0;

                COMMIT();
            end;

            trigger OnPreDataItem()
            begin
                SKU.SETCURRENTKEY("Item No.");
                COPYFILTER("Variant Filter", SKU."Variant Code");
                COPYFILTER("Location Filter", SKU."Location Code");

                COPYFILTER("Variant Filter", PlanningAssignment."Variant Code");
                COPYFILTER("Location Filter", PlanningAssignment."Location Code");
                PlanningAssignment.SETRANGE(Inactive, FALSE);
                PlanningAssignment.SETRANGE("Net Change Planning", TRUE);

                ReqLineExtern.SETCURRENTKEY(Type, "No.", "Variant Code", "Location Code");
                COPYFILTER("Variant Filter", ReqLineExtern."Variant Code");
                COPYFILTER("Location Filter", ReqLineExtern."Location Code");

                PurchReqLine.SETCURRENTKEY(
                  Type, "No.", "Variant Code", "Location Code", "Sales Order No.", "Planning Line Origin", "Due Date");
                PurchReqLine.SETRANGE(Type, PurchReqLine.Type::Item);
                COPYFILTER("Variant Filter", PurchReqLine."Variant Code");
                COPYFILTER("Location Filter", PurchReqLine."Location Code");
                PurchReqLine.SETFILTER("Worksheet Template Name", ReqWkshTemplateFilter);
                PurchReqLine.SETFILTER("Journal Batch Name", ReqWkshFilter);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options', Comment = 'FRA="Options"';
                    field(StartingDate; FromDate)
                    {
                        Caption = 'Starting Date', Comment = 'FRA="Date début"';
                    }
                    field(EndingDate; ToDate)
                    {
                        Caption = 'Ending Date', Comment = 'FRA="Date fin"';
                    }
                    field(UseForecastF; UseForecast)
                    {
                        Caption = 'Use Forecast', Comment = 'FRA="Utiliser prévisions"';
                        TableRelation = "Production Forecast Name".Name;
                    }
                    field(ExcludeForecastBeforeF; ExcludeForecastBefore)
                    {
                        Caption = 'Exclude Forecast Before', Comment = 'FRA="Exclure prévisions avant"';
                    }
                    field(RespectPlanningParmF; RespectPlanningParm)
                    {
                        Caption = 'Respect Planning Parameters for Supply Triggered by Safety Stock', Comment = 'FRA="Respecter les paramètres de planning pour l''approvisionnement déclenché par le stock de sécurité"';
                        ToolTip = 'Specifies that planning lines triggered by safety stock will respect the following planning parameters: Reorder Point, Reorder Quantity, Reorder Point, and Maximum Inventory in addition to all order modifiers. If you do not select this check box, planning lines triggered by safety stock will only cover the exact demand quantity.', Comment = 'FRA="Spécifie que les lignes de planning déclenchées par le stock de sécurité vont respecter les paramètres de planning suivants : Point de commande, Quantité de réappro, Point de commande et Stock maximum en plus de tous les modificateurs d''ordre. Si vous n''activez pas cette case à cocher, les lignes de planning déclenchées par le stock de sécurité vont uniquement couvrir la quantité exacte demandée."';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            MfgSetup.GET();
            UseForecast := MfgSetup."Current Production Forecast";
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        ProductionForecastEntry: Record "Production Forecast Entry";
    begin
        Counter := 0;
        IF FromDate = 0D THEN
            ERROR(Text002);
        IF ToDate = 0D THEN
            ERROR(Text003);
        PeriodLength := ToDate - FromDate + 1;
        IF PeriodLength <= 0 THEN
            ERROR(Text004);

        IF (Item.GETFILTER("Variant Filter") <> '') AND
           (MfgSetup."Current Production Forecast" <> '')
        THEN BEGIN
            ProductionForecastEntry.SETRANGE("Production Forecast Name", MfgSetup."Current Production Forecast");
            Item.COPYFILTER("No.", ProductionForecastEntry."Item No.");
            IF MfgSetup."Use Forecast on Locations" THEN
                Item.COPYFILTER("Location Filter", ProductionForecastEntry."Location Code");
            IF NOT ProductionForecastEntry.ISEMPTY THEN
                ERROR(Text005);
        END;

        ReqLine.SETRANGE("Worksheet Template Name", CurrTemplateName);
        ReqLine.SETRANGE("Journal Batch Name", CurrWorksheetName);

        Window.OPEN(
          Text006 +
          Text007);
    end;

    var
        ActionMessageEntry: Record "Action Message Entry";
        MfgSetup: Record "Manufacturing Setup";
        PlanningAssignment: Record "Planning Assignment";
        PurchReqLine: Record "Requisition Line";
        ReqLine: Record "Requisition Line";
        ReqLineExtern: Record "Requisition Line";
        SKU: Record "Stockkeeping Unit";
        InvtProfileOffsetting: Codeunit "Inventory Profile Offsetting";
        RespectPlanningParm: Boolean;
        CurrTemplateName: Code[10];
        CurrWorksheetName: Code[10];
        UseForecast: Code[10];
        ReqWkshFilter: Code[50];
        ReqWkshTemplateFilter: Code[50];
        ExcludeForecastBefore: Date;
        FromDate: Date;
        ToDate: Date;
        Window: Dialog;
        Counter: Integer;
        PeriodLength: Integer;
        Text002: Label 'Enter a starting date.', Comment = 'FRA="Entrez une date de début."';
        Text003: Label 'Enter an ending date.', Comment = 'FRA="Entrez une date de fin."';
        Text004: Label 'The ending date must not be before the order date.', Comment = 'FRA="La date de fin doit être postérieure à la date de début."';
        Text005: Label 'You must not use a variant filter when calculating MPS from a forecast.', Comment = 'FRA="Vous ne devez pas utiliser de filtre variante lorsque vous calculez un PDP à partir d''une prévision."';
        Text006: Label 'Calculating the plan...\\', Comment = 'FRA="Calcul du planning...\\"';
        Text007: Label 'Item No.  #1##################', Comment = 'FRA="N° art.   #1##################"';
        CurrWorksheetType: Option Requisition,Planning;

    procedure SetTemplAndWorksheet(TemplateName: Code[10]; WorksheetName: Code[10])
    begin
        CurrTemplateName := TemplateName;
        CurrWorksheetName := WorksheetName;
    end;

    procedure InitializeRequest(StartDate: Date; EndDate: Date)
    begin
        FromDate := StartDate;
        ToDate := EndDate;
    end;

    local procedure SkipPlanningForItemOnReqWksh(Item: Record Item): Boolean
    begin
        WITH Item DO
            IF (CurrWorksheetType = CurrWorksheetType::Requisition) AND
               ("Replenishment System" = "Replenishment System"::Purchase) AND
               ("Reordering Policy" <> "Reordering Policy"::"Maximum Qty.")
            THEN
                EXIT(FALSE);

        WITH SKU DO BEGIN
            SETRANGE("Item No.", Item."No.");
            IF FIND('-') THEN
                REPEAT
                    IF (CurrWorksheetType = CurrWorksheetType::Requisition) AND
                       ("Replenishment System" IN ["Replenishment System"::Purchase,
                                                   "Replenishment System"::Transfer]) AND
                       ("Reordering Policy" <> "Reordering Policy"::" ")
                    THEN
                        EXIT(FALSE);
                UNTIL NEXT() = 0;
        END;

        EXIT(TRUE);
    end;
}

