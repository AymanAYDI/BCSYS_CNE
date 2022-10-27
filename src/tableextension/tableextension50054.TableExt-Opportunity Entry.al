tableextension 50054 tableextension50054 extends "Opportunity Entry"
{
    LookupPageID = 5130;
    DrillDownPageID = 5130;
    fields
    {
        modify("Close Opportunity Code")
        {
            TableRelation = IF (Action Taken=CONST(Won)) "Close Opportunity Code" WHERE (Type=CONST(Won))
                            ELSE IF (Action Taken=CONST(Lost)) "Close Opportunity Code" WHERE (Type=CONST(Lost));
        }
        modify("Sales Cycle Stage Description")
        {
            Caption = 'Sales Cycle Stage Description';
        }

        //Unsupported feature: Code Insertion on ""Sales Cycle Stage"(Field 4)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            IF SalesCycleStage.GET("Sales Cycle Code","Sales Cycle Stage") THEN
              "Sales Cycle Stage Description" := SalesCycleStage.Description;
            */
        //end;
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnInsert".

    //trigger (Variable: SalesCycleStage)()
    //Parameters and return type have not been exported.
    //begin
        /*
        */
    //end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Opp.GET("Opportunity No.");
        CASE "Action Taken" OF
          "Action Taken"::" ",
          "Action Taken"::Next,
          "Action Taken"::Previous,
          "Action Taken"::Updated,
          "Action Taken"::Jumped:
            IF Opp.Status <> Opp.Status::"In Progress" THEN BEGIN
              Opp.Status := Opp.Status::"In Progress";
              Opp.MODIFY;
            END;
          "Action Taken"::Won:
            BEGIN
              TestCust;
        #15..17
                Opp."Date Closed" := "Date of Change";
                "Date Closed" := "Date of Change";
                "Estimated Close Date" := "Date of Change";
                Opp.MODIFY;
              END;
            END;
        #24..30
              Opp.MODIFY;
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
            BEGIN
              IF SalesCycleStage.GET("Sales Cycle Code","Sales Cycle Stage") THEN
                "Sales Cycle Stage Description" := SalesCycleStage.Description;
              IF Opp.Status <> Opp.Status::"In Progress" THEN BEGIN
                Opp.Status := Opp.Status::"In Progress";
        #21..23
        #12..33
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateEstimates(PROCEDURE 2)".

    //procedure UpdateEstimates();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF SalesCycleStage.GET("Sales Cycle Code","Sales Cycle Stage") THEN BEGIN
          SalesCycle.GET("Sales Cycle Code");
          CASE SalesCycle."Probability Calculation" OF
        #4..11
          END;
          "Completed %" := SalesCycleStage."Completed %";
          "Calcd. Current Value (LCY)" := "Estimated Value (LCY)" * "Probability %" / 100;
        END;

        CASE "Action Taken" OF
          "Action Taken"::Won:
            BEGIN
              Opp.GET("Opportunity No.");
              IF SalesHeader.GET(SalesHeader."Document Type"::Quote,Opp."Sales Document No.") THEN
                "Calcd. Current Value (LCY)" := GetSalesDocValue(SalesHeader)
              ELSE
                "Calcd. Current Value (LCY)" := "Estimated Value (LCY)";

              "Completed %" := 100;
              "Chances of Success %" := 100;
        #28..35
            END;
        END;
        MODIFY;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..14
          IF ("Estimated Close Date" = "Date of Change") OR ("Estimated Close Date" = 0D) THEN
            "Estimated Close Date" := CALCDATE(SalesCycleStage."Date Formula","Date of Change");
        #15..21
                "Calcd. Current Value (LCY)" := GetSalesDocValue(SalesHeader);
        #25..38
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: TempAttendee) (VariableCollection) on "CreateToDo(PROCEDURE 3)".


    //Unsupported feature: Variable Insertion (Variable: TempAttachment) (VariableCollection) on "CreateToDo(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "CreateToDo(PROCEDURE 3)".

    //procedure CreateToDo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF CancelOldToDo THEN
          ToDo.CancelOpenTodos("Opportunity No.");

        #4..14
              ToDo.Date := "Date of Change";
              ToDo.Duration := 1440 * 1000 * 60;
              ToDo.InsertTodo(
                ToDo,RMCommentLine,AttendeeTemp,
                TodoInteractionLanguageTemp,AttachmentTemp,
                SalesCycleStage."Activity Code",FALSE);
            END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..17
                ToDo,RMCommentLine,TempAttendee,
                TodoInteractionLanguageTemp,TempAttachment,
                SalesCycleStage."Activity Code",FALSE);
            END;
        */
    //end;


    //Unsupported feature: Code Modification on "GetSalesDocValue(PROCEDURE 4)".

    //procedure GetSalesDocValue();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesPost.SumSalesLines(
          SalesHeader,0,TotalSalesLine,TotalSalesLineLCY,
          VATAmount,VATAmountText,ProfitLCY,ProfitPct,TotalAdjCostLCY);
        EXIT(TotalSalesLineLCY.Amount);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SalesPost.SumSalesLines(
          SalesHeader,0,TotalSalesLine,TotalSalesLineLCY,
          VATAmount,VATAmountText,ProfitLCY,ProfitPct,TotalAdjCostLCY,
          //>>MIGRATION NAV 2013
          //DEEE
          TotalSalesLine."DEEE HT Amount",TotalSalesLine."DEEE VAT Amount",
          TotalSalesLine."DEEE TTC Amount",TotalSalesLine."DEEE HT Amount (LCY)");
          //FIN DEEE
          //<<MIGRATION NAV 2013
        EXIT(TotalSalesLineLCY.Amount);
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "TestCust(PROCEDURE 5)".


    //Unsupported feature: Property Insertion (Local) on "StartWizard(PROCEDURE 15)".



    //Unsupported feature: Code Modification on "StartWizard(PROCEDURE 15)".

    //procedure StartWizard();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Wizard Step" := "Wizard Step"::"1";
        INSERT;
        PAGE.RUNMODAL(PAGE::"Close Opportunity",Rec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        INSERT;
        IF PAGE.RUNMODAL(PAGE::"Close Opportunity",Rec) = ACTION::OK THEN;
        */
    //end;


    //Unsupported feature: Code Modification on "CheckStatus(PROCEDURE 16)".

    //procedure CheckStatus();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE "Wizard Step" OF
          "Wizard Step"::"1":
            IF NOT ("Action Taken" IN ["Action Taken"::Won,"Action Taken"::Lost]) THEN
              ERROR(Text011);
          "Wizard Step"::"2":
            BEGIN
              IF "Close Opportunity Code" = '' THEN
                ErrorMessage(FIELDCAPTION("Close Opportunity Code"));
              IF "Date of Change" = 0D THEN
                ErrorMessage(FIELDCAPTION("Date of Change"));
              IF "Action Taken" = "Action Taken"::Won THEN
                IF "Calcd. Current Value (LCY)" <= 0 THEN
                  ERROR(Text012);
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF NOT ("Action Taken" IN ["Action Taken"::Won,"Action Taken"::Lost]) THEN
          ERROR(Text011);
        IF "Close Opportunity Code" = '' THEN
          ErrorMessage(FIELDCAPTION("Close Opportunity Code"));
        IF "Date of Change" = 0D THEN
          ErrorMessage(FIELDCAPTION("Date of Change"));
        IF "Action Taken" = "Action Taken"::Won THEN
          IF "Calcd. Current Value (LCY)" <= 0 THEN
            ERROR(Text012);
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "ErrorMessage(PROCEDURE 10)".


    //Unsupported feature: Property Insertion (Local) on "StartWizard2(PROCEDURE 20)".



    //Unsupported feature: Code Modification on "StartWizard2(PROCEDURE 20)".

    //procedure StartWizard2();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Wizard Step" := "Wizard Step"::"1";
        CreateStageList;
        INSERT;
        PAGE.RUNMODAL(PAGE::"Update Opportunity",Rec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        IF PAGE.RUNMODAL(PAGE::"Update Opportunity",Rec) = ACTION::OK THEN;
        */
    //end;

    //Unsupported feature: Property Modification (Name) on "PerformNextWizardStatus2(PROCEDURE 12)".



    //Unsupported feature: Code Modification on "PerformNextWizardStatus2(PROCEDURE 12)".

    //procedure PerformNextWizardStatus2();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE "Wizard Step" OF
          "Wizard Step"::"1":
            BEGIN
              CASE "Action Type" OF
                "Action Type"::First:
                  BEGIN
                    TempSalesCycleStageFirst.FINDFIRST;
                    "Sales Cycle Stage" := TempSalesCycleStageFirst.Stage;
                    "Sales Cycle Stage Description" := TempSalesCycleStageFirst.Description;
                    "Action Taken" := "Action Taken"::" ";
                    "Cancel Old To Do" := FALSE;
                  END;
                "Action Type"::Next:
                  BEGIN
                    TempSalesCycleStageNext.FINDFIRST;
                    "Sales Cycle Stage" := TempSalesCycleStageNext.Stage;
                    "Sales Cycle Stage Description" := TempSalesCycleStageNext.Description;
                    "Action Taken" := "Action Taken"::Next;
                  END;
                "Action Type"::Previous:
                  BEGIN
                    TempSalesCycleStagePrevious.FINDFIRST;
                    "Sales Cycle Stage" := TempSalesCycleStagePrevious.Stage;
                    "Sales Cycle Stage Description" := TempSalesCycleStagePrevious.Description;
                    "Action Taken" := "Action Taken"::Previous;
                  END;
                "Action Type"::Skip:
                  BEGIN
                    TempSalesCycleStageSkip.FINDFIRST;
                    "Sales Cycle Stage" := TempSalesCycleStageSkip.Stage;
                    "Sales Cycle Stage Description" := TempSalesCycleStageSkip.Description;
                    "Action Taken" := "Action Taken"::Jumped;
                  END;
                "Action Type"::Update:
                  BEGIN
                    TempSalesCycleStageUpdate.FINDFIRST;
                    "Sales Cycle Stage" := TempSalesCycleStageUpdate.Stage;
                    "Sales Cycle Stage Description" := TempSalesCycleStageUpdate.Description;
                    "Action Taken" := "Action Taken"::Updated;
                    "Cancel Old To Do" := FALSE;
                  END;
                "Action Type"::Jump:
                  BEGIN
                    TempSalesCycleStageJump.FINDLAST;
                    "Sales Cycle Stage" := TempSalesCycleStageJump.Stage;
                    "Sales Cycle Stage Description" := TempSalesCycleStageJump.Description;
                    "Action Taken" := "Action Taken"::Jumped;
                  END;
              END;
              ToDo.RESET;
              ToDo.SETCURRENTKEY("Opportunity No.");
              ToDo.SETRANGE("Opportunity No.","Opportunity No.");
              IF ToDo.FINDFIRST THEN
                "Cancel Old To Do" := FALSE;
              MODIFY;
            END;
          "Wizard Step"::"2":
            BEGIN
              CASE "Action Type" OF
                "Action Type"::Skip:
                  BEGIN
                    IF TempSalesCycleStageNext.GET("Sales Cycle Code","Sales Cycle Stage")THEN
                      "Action Taken" := "Action Taken"::Next;
                    MODIFY;
                  END;
                "Action Type"::Jump:
                  BEGIN
                    IF TempSalesCycleStagePrevious.GET("Sales Cycle Code","Sales Cycle Stage")THEN
                      "Action Taken" := "Action Taken"::Previous;
                    MODIFY;
                  END;
              END;
              ValidateStage;
            END;
        END;
        "Wizard Step" := "Wizard Step" + 1;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CASE "Action Type" OF
          "Action Type"::Skip:
            BEGIN
              IF TempSalesCycleStageNext.GET("Sales Cycle Code","Sales Cycle Stage")THEN
                "Action Taken" := "Action Taken"::Next;
              MODIFY;
            END;
          "Action Type"::Jump:
            BEGIN
              IF TempSalesCycleStagePrevious.GET("Sales Cycle Code","Sales Cycle Stage")THEN
                "Action Taken" := "Action Taken"::Previous;
              MODIFY;
            END;
        END;
        ValidateStage;
        */
    //end;


    //Unsupported feature: Code Modification on "CheckStatus2(PROCEDURE 11)".

    //procedure CheckStatus2();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE "Wizard Step" OF
          "Wizard Step"::"1":
            IF "Action Type" = "Action Type"::" " THEN
              ERROR(Text006,"Sales Cycle Code");
          "Wizard Step"::"2":
            BEGIN
              IF EntryExists THEN
                IF "Date of Change" < PreviousDateOfChange THEN
                  ERROR(Text007);
              IF "Date of Change" = 0D THEN
                ErrorMessage(FIELDCAPTION("Date of Change"));
              ValidateStage;
            END;
          "Wizard Step"::"3":
            BEGIN
              IF "Estimated Value (LCY)" <= 0 THEN
                ERROR(Text008,FIELDCAPTION("Estimated Value (LCY)"));
              IF "Chances of Success %" <= 0 THEN
                ERROR(Text008,FIELDCAPTION("Chances of Success %"));
              IF "Estimated Close Date" = 0D THEN
                ErrorMessage(FIELDCAPTION("Estimated Close Date"));
              IF "Estimated Close Date" < "Date of Change" THEN
                ERROR(Text009);
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF "Action Type" = "Action Type"::" " THEN
          ERROR(Text006,"Sales Cycle Code");

        IF EntryExists THEN
          IF "Date of Change" < PreviousDateOfChange THEN
            ERROR(Text007);
        IF "Date of Change" = 0D THEN
          ErrorMessage(FIELDCAPTION("Date of Change"));

        ValidateStage;

        IF "Estimated Value (LCY)" <= 0 THEN
          ERROR(Text008,FIELDCAPTION("Estimated Value (LCY)"));
        IF "Chances of Success %" <= 0 THEN
          ERROR(Text008,FIELDCAPTION("Chances of Success %"));
        IF "Estimated Close Date" = 0D THEN
          ErrorMessage(FIELDCAPTION("Estimated Close Date"));
        IF "Estimated Close Date" < "Date of Change" THEN
          ERROR(Text009);
        */
    //end;


    //Unsupported feature: Code Modification on "CreateStageList(PROCEDURE 13)".

    //procedure CreateStageList();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TempSalesCycleStageFirst.DELETEALL;
        TempSalesCycleStageNext.DELETEALL;
        TempSalesCycleStagePrevious.DELETEALL;
        #4..34
              TempSalesCycleStageNext := SalesCycleStage;
              TempSalesCycleStageNext.INSERT;
            END;
          END;

        // Option 3 Goto Previous Stage
        #41..96
            "Action Type" := "Action Type"::First;
          NoOfSalesCyclesNext > 0:
            "Action Type" := "Action Type"::Next;
          NoOfSalesCyclesPrev > 0:
            "Action Type" := "Action Type"::Previous;
          NoOfSalesCyclesUpdate > 0:
            "Action Type" := "Action Type"::Update;
          NoOfSalesCyclesSkip > 1:
            "Action Type" := "Action Type"::Skip;
          NoOfSalesCyclesJump > 1:
            "Action Type" := "Action Type"::Jump;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..37
            "Sales Cycle Stage" := SalesCycleStage.Stage;
            "Action Taken" := "Action Taken"::Next;
        #38..99
          NoOfSalesCyclesUpdate > 0:
            "Action Type" := "Action Type"::Update;
          NoOfSalesCyclesPrev > 0:
            "Action Type" := "Action Type"::Previous;
        #104..108
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "TestQuote(PROCEDURE 14)".


    procedure WizardActionTypeValidate2()
    begin
        CASE "Action Type" OF
          "Action Type"::First:
            BEGIN
              TempSalesCycleStageFirst.FINDFIRST;
              "Sales Cycle Stage" := TempSalesCycleStageFirst.Stage;
              "Sales Cycle Stage Description" := TempSalesCycleStageFirst.Description;
              "Action Taken" := "Action Taken"::" ";
              "Cancel Old To Do" := FALSE;
            END;
          "Action Type"::Next:
            BEGIN
              TempSalesCycleStageNext.FINDFIRST;
              "Sales Cycle Stage" := TempSalesCycleStageNext.Stage;
              "Sales Cycle Stage Description" := TempSalesCycleStageNext.Description;
              "Action Taken" := "Action Taken"::Next;
            END;
          "Action Type"::Previous:
            BEGIN
              TempSalesCycleStagePrevious.FINDFIRST;
              "Sales Cycle Stage" := TempSalesCycleStagePrevious.Stage;
              "Sales Cycle Stage Description" := TempSalesCycleStagePrevious.Description;
              "Action Taken" := "Action Taken"::Previous;
            END;
          "Action Type"::Skip:
            BEGIN
              TempSalesCycleStageSkip.FINDFIRST;
              "Sales Cycle Stage" := TempSalesCycleStageSkip.Stage;
              "Sales Cycle Stage Description" := TempSalesCycleStageSkip.Description;
              "Action Taken" := "Action Taken"::Jumped;
            END;
          "Action Type"::Update:
            BEGIN
              TempSalesCycleStageUpdate.FINDFIRST;
              "Sales Cycle Stage" := TempSalesCycleStageUpdate.Stage;
              "Sales Cycle Stage Description" := TempSalesCycleStageUpdate.Description;
              "Action Taken" := "Action Taken"::Updated;
              "Cancel Old To Do" := FALSE;
            END;
          "Action Type"::Jump:
            BEGIN
              TempSalesCycleStageJump.FINDLAST;
              "Sales Cycle Stage" := TempSalesCycleStageJump.Stage;
              "Sales Cycle Stage Description" := TempSalesCycleStageJump.Description;
              "Action Taken" := "Action Taken"::Jumped;
            END;
        END;
        ToDo.RESET;
        ToDo.SETCURRENTKEY("Opportunity No.");
        ToDo.SETRANGE("Opportunity No.","Opportunity No.");
        IF ToDo.FINDFIRST THEN
          "Cancel Old To Do" := FALSE;
        MODIFY;
    end;

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: Brick)".


    //Unsupported feature: Deletion (VariableCollection) on "CreateToDo(PROCEDURE 3).AttendeeTemp(Variable 1008)".


    //Unsupported feature: Deletion (VariableCollection) on "CreateToDo(PROCEDURE 3).AttachmentTemp(Variable 1006)".


    var
        SalesCycleStage: Record "5091";
}

