tableextension 50017 tableextension50017 extends Job
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //>>CNE1.00
    // FEP-ADVE-200706_18_A.001:MA 14/11/2007 : gestion des appeles d'offres clients
    //   - add fields 50000..50006
    // 
    // //>>CNE2.05
    // FEP-ADVE-200706_18_A.002:LY 28/01/2007 : manage post-code and delete
    // 
    // ------------------------------------------------------------------------
    LookupPageID = 89;
    DrillDownPageID = 89;
    fields
    {
        modify("Search Description")
        {
            Caption = 'Search Description';
        }
        modify(Description)
        {
            Caption = 'Description';
        }
        modify("Description 2")
        {
            Caption = 'Description 2';
        }
        modify(Status)
        {

            //Unsupported feature: Property Modification (InitValue) on "Status(Field 19)".

            OptionCaption = 'Planning,Quote,Open,Completed';

            //Unsupported feature: Property Modification (OptionString) on "Status(Field 19)".

        }

        //Unsupported feature: Property Modification (CalcFormula) on "Comment(Field 30)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Scheduled Res. Qty."(Field 49)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Scheduled Res. Gr. Qty."(Field 56)".

        modify(Picture)
        {
            Caption = 'Picture';
        }
        modify("Bill-to City")
        {
            TableRelation = IF (Bill-to Country/Region Code=CONST()) "Post Code".City
                            ELSE IF (Bill-to Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Bill-to Country/Region Code));
        }
        modify("Bill-to Post Code")
        {
            TableRelation = IF (Bill-to Country/Region Code=CONST()) "Post Code"
                            ELSE IF (Bill-to Country/Region Code=FILTER(<>'')) "Post Code" WHERE (Country/Region Code=FIELD(Bill-to Country/Region Code));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on "Reserve(Field 117)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Bill-to Contact No."(Field 1002)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Total WIP Cost Amount"(Field 1005)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Total WIP Cost G/L Amount"(Field 1006)".


        //Unsupported feature: Property Modification (CalcFormula) on ""WIP G/L Posting Date"(Field 1009)".

        modify("Allow Schedule/Contract Lines")
        {
            Caption = 'Allow Budget/Billable Lines';
        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Recog. Sales Amount"(Field 1017)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Recog. Sales G/L Amount"(Field 1018)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Recog. Costs Amount"(Field 1019)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Recog. Costs G/L Amount"(Field 1020)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Total WIP Sales Amount"(Field 1021)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Total WIP Sales G/L Amount"(Field 1022)".


        //Unsupported feature: Property Modification (CalcFormula) on ""WIP Completion Calculated"(Field 1023)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Next Invoice Date"(Field 1024)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Applied Costs G/L Amount"(Field 1028)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Applied Sales G/L Amount"(Field 1029)".


        //Unsupported feature: Property Modification (CalcFormula) on ""WIP Completion Posted"(Field 1034)".



        //Unsupported feature: Code Modification on ""Bill-to Customer No."(Field 5).OnValidate".

        //trigger "(Field 5)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ("Bill-to Customer No." = '') OR ("Bill-to Customer No." <> xRec."Bill-to Customer No.") THEN
              IF JobLedgEntryExist OR JobPlanningLineExist THEN
                ERROR(Text000,FIELDCAPTION("Bill-to Customer No."),TABLECAPTION);
            UpdateCust;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF ("Bill-to Customer No." = '') OR ("Bill-to Customer No." <> xRec."Bill-to Customer No.") THEN
              IF JobLedgEntryExist OR JobPlanningLineExist THEN
                ERROR(AssociatedEntriesExistErr,FIELDCAPTION("Bill-to Customer No."),TABLECAPTION);
            UpdateCust;
            */
        //end;


        //Unsupported feature: Code Modification on "Status(Field 19).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF xRec.Status <> Status THEN BEGIN
              IF Status = Status::Completed THEN
                VALIDATE(Complete,TRUE);
              IF xRec.Status = xRec.Status::Completed THEN BEGIN
                IF DIALOG.CONFIRM(Text004) THEN
                  VALIDATE(Complete,FALSE)
                ELSE
                  Status := xRec.Status;
              END;
              JobPlanningLine.SETCURRENTKEY("Job No.");
              JobPlanningLine.SETRANGE("Job No.","No.");
              JobPlanningLine.MODIFYALL(Status,Status);
              MODIFY;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              IF xRec.Status = xRec.Status::Completed THEN
                IF DIALOG.CONFIRM(StatusChangeQst) THEN
            #6..8
              MODIFY;
            #10..12
            END;
            */
        //end;


        //Unsupported feature: Code Modification on ""Global Dimension 1 Code"(Field 21).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            MODIFY;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            */
        //end;


        //Unsupported feature: Code Modification on ""Global Dimension 2 Code"(Field 22).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            MODIFY;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            */
        //end;


        //Unsupported feature: Code Modification on ""WIP Method"(Field 1000).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "WIP Posting Method" = "WIP Posting Method"::"Per Job Ledger Entry" THEN BEGIN
              JobWIPMethod.GET("WIP Method");
              IF NOT JobWIPMethod."WIP Cost" THEN
                ERROR(Text017,FIELDCAPTION("WIP Posting Method"),FIELDCAPTION("WIP Method"),JobWIPMethod.FIELDCAPTION("WIP Cost"));
              IF NOT JobWIPMethod."WIP Sales" THEN
                ERROR(Text017,FIELDCAPTION("WIP Posting Method"),FIELDCAPTION("WIP Method"),JobWIPMethod.FIELDCAPTION("WIP Sales"));
            END;

            JobTask.SETRANGE("Job No.","No.");
            JobTask.SETRANGE("WIP-Total",JobTask."WIP-Total"::Total);
            IF JobTask.FINDFIRST THEN
              IF CONFIRM(Text014,TRUE,JobTask.FIELDCAPTION("WIP Method"),JobTask.TABLECAPTION,JobTask."WIP-Total") THEN
                JobTask.MODIFYALL("WIP Method","WIP Method",TRUE);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
                ERROR(WIPPostMethodErr,FIELDCAPTION("WIP Posting Method"),FIELDCAPTION("WIP Method"),JobWIPMethod.FIELDCAPTION("WIP Cost"));
              IF NOT JobWIPMethod."WIP Sales" THEN
                ERROR(WIPPostMethodErr,FIELDCAPTION("WIP Posting Method"),FIELDCAPTION("WIP Method"),JobWIPMethod.FIELDCAPTION("WIP Sales"));
            #7..11
              IF CONFIRM(WIPMethodQst,TRUE,JobTask.FIELDCAPTION("WIP Method"),JobTask.TABLECAPTION,JobTask."WIP-Total") THEN
                JobTask.MODIFYALL("WIP Method","WIP Method",TRUE);
            */
        //end;


        //Unsupported feature: Code Modification on ""Currency Code"(Field 1001).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Currency Code" <> xRec."Currency Code" THEN
              IF NOT JobLedgEntryExist THEN BEGIN
                CurrencyUpdatePlanningLines;
                CurrencyUpdatePurchLines;
              END ELSE
                ERROR(Text000,FIELDCAPTION("Currency Code"),TABLECAPTION);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..5
                ERROR(AssociatedEntriesExistErr,FIELDCAPTION("Currency Code"),TABLECAPTION);
            CurrencyCheck;
            */
        //end;


        //Unsupported feature: Code Modification on ""Bill-to Contact No."(Field 1002).OnValidate".

        //trigger "(Field 1002)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ("Bill-to Contact No." <> xRec."Bill-to Contact No.") AND
               (xRec."Bill-to Contact No." <> '')
            THEN BEGIN
              IF ("Bill-to Contact No." = '') AND ("Bill-to Customer No." = '') THEN BEGIN
                INIT;
                "No. Series" := xRec."No. Series";
                VALIDATE(Description,xRec.Description);
              END;
            END;

            IF ("Bill-to Customer No." <> '') AND ("Bill-to Contact No." <> '') THEN BEGIN
              Cont.GET("Bill-to Contact No.");
            #13..15
              ContBusinessRelation.SETRANGE("No.","Bill-to Customer No.");
              IF ContBusinessRelation.FINDFIRST THEN
                IF ContBusinessRelation."Contact No." <> Cont."Company No." THEN
                  ERROR(Text005,Cont."No.",Cont.Name,"Bill-to Customer No.");
            END;
            UpdateBillToCust("Bill-to Contact No.");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF ("Bill-to Contact No." <> xRec."Bill-to Contact No.") AND
               (xRec."Bill-to Contact No." <> '')
            THEN
            #4..8
            #10..18
                  ERROR(ContactBusRelDiffCompErr,Cont."No.",Cont.Name,"Bill-to Customer No.");
            END;
            UpdateBillToCust("Bill-to Contact No.");
            */
        //end;


        //Unsupported feature: Code Insertion on ""Invoice Currency Code"(Field 1011)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            CurrencyCheck;
            */
        //end;


        //Unsupported feature: Code Modification on ""Apply Usage Link"(Field 1025).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Apply Usage Link" THEN BEGIN
              JobLedgerEntry.SETCURRENTKEY("Job No.");
              JobLedgerEntry.SETRANGE("Job No.","No.");
              JobLedgerEntry.SETRANGE("Entry Type",JobLedgerEntry."Entry Type"::Usage);
              IF JobLedgerEntry.FINDFIRST THEN BEGIN
                JobUsageLink.SETRANGE("Entry No.",JobLedgerEntry."Entry No.");
                IF NOT JobUsageLink.FINDFIRST THEN
                  ERROR(Text013,TABLECAPTION);
              END;

              JobPlanningLine.SETCURRENTKEY("Job No.");
            #12..18
                  JobPlanningLine.MODIFY(TRUE);
                UNTIL JobPlanningLine.NEXT = 0;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..6
                IF JobUsageLink.ISEMPTY THEN
                  ERROR(ApplyUsageLinkErr,TABLECAPTION);
            #9..21
            */
        //end;


        //Unsupported feature: Code Modification on ""WIP Posting Method"(Field 1027).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF xRec."WIP Posting Method" = "WIP Posting Method"::"Per Job Ledger Entry" THEN BEGIN
              JobLedgerEntry.SETRANGE("Job No.","No.");
              JobLedgerEntry.SETFILTER("Amt. Posted to G/L",'<>%1',0);
              IF JobLedgerEntry.FINDFIRST THEN
                ERROR(Text015,FIELDCAPTION("WIP Posting Method"),xRec."WIP Posting Method");
            END;

            JobWIPEntry.SETRANGE("Job No.","No.");
            IF JobWIPEntry.FINDFIRST THEN
              ERROR(Text016,FIELDCAPTION("WIP Posting Method"));

            IF "WIP Posting Method" = "WIP Posting Method"::"Per Job Ledger Entry" THEN BEGIN
              JobWIPMethod.GET("WIP Method");
              IF NOT JobWIPMethod."WIP Cost" THEN
                ERROR(Text017,FIELDCAPTION("WIP Posting Method"),FIELDCAPTION("WIP Method"),JobWIPMethod.FIELDCAPTION("WIP Cost"));
              IF NOT JobWIPMethod."WIP Sales" THEN
                ERROR(Text017,FIELDCAPTION("WIP Posting Method"),FIELDCAPTION("WIP Method"),JobWIPMethod.FIELDCAPTION("WIP Sales"));
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
              IF NOT JobLedgerEntry.ISEMPTY THEN
                ERROR(WIPAlreadyPostedErr,FIELDCAPTION("WIP Posting Method"),xRec."WIP Posting Method");
            #6..8
            IF NOT JobWIPEntry.ISEMPTY THEN
              ERROR(WIPAlreadyAssociatedErr,FIELDCAPTION("WIP Posting Method"));
            #11..14
                ERROR(WIPPostMethodErr,FIELDCAPTION("WIP Posting Method"),FIELDCAPTION("WIP Method"),JobWIPMethod.FIELDCAPTION("WIP Cost"));
              IF NOT JobWIPMethod."WIP Sales" THEN
                ERROR(WIPPostMethodErr,FIELDCAPTION("WIP Posting Method"),FIELDCAPTION("WIP Method"),JobWIPMethod.FIELDCAPTION("WIP Sales"));
            END;
            */
        //end;
        field(140;Image;Media)
        {
            Caption = 'Image';
        }
        field(1035;"Over Budget";Boolean)
        {
            Caption = 'Over Budget';
        }
        field(1036;"Project Manager";Code[50])
        {
            Caption = 'Project Manager';
            TableRelation = "User Setup";
        }
        field(50000;"Affair Responsible";Code[20])
        {
            Caption = 'Affair Responsible';
            Description = 'CNE1.00';
        }
        field(50001;Statut;Option)
        {
            Description = 'CNE1.00';
            OptionCaption = 'Outstanding,Lost,Won';
            OptionMembers = Outstanding,Lost,Won;
        }
        field(50002;Address;Text[30])
        {
            Caption = 'Address';
            Description = 'CNE1.00';
        }
        field(50003;"Address 2";Text[30])
        {
            Caption = 'Address';
            Description = 'CNE1.00';
        }
        field(50004;"Post Code";Code[20])
        {
            Caption = 'Post Code';
            Description = 'CNE1.00';
            TableRelation = "Post Code".Code;

            trigger OnValidate()
            var
                "- MIGNAV2013 -": Integer;
                TxtLCounty: Text[30];
            begin
                //>>MIGRATION NAV 2013
                //>FEP-ADVE-200706_18_A.002
                //OLD PostCode.ValidatePostCode(City,"Post Code");
                PostCode.ValidatePostCode(City,"Post Code",TxtLCounty,Country,(CurrFieldNo <> 0) AND GUIALLOWED);
                //<FEP-ADVE-200706_18_A.002
                //<<MIGRATION NAV 2013
            end;
        }
        field(50005;City;Text[30])
        {
            Caption = 'Ville';
            Description = 'CNE1.00';
        }
        field(50006;Country;Code[20])
        {
            Caption = 'Country';
            Description = 'CNE1.00';
            TableRelation = Country/Region.Code;
        }
        field(50010;Awarder;Boolean)
        {
            CalcFormula = Lookup("Contact Project Relation".Awarder WHERE (Affair No.=FIELD(No.),
                                                                           Awarder=CONST(Yes)));
            Caption = 'Awarder';
            Description = 'CNE3.01';
            FieldClass = FlowField;

            trigger OnValidate()
            var
                RecLAffairStep: Record "50010";
            begin
            end;
        }
        field(50011;"Awarder Contact Name";Text[30])
        {
            CalcFormula = Lookup("Contact Project Relation"."Contact Name" WHERE (Affair No.=FIELD(No.),
                                                                                  Awarder=CONST(Yes)));
            Caption = 'Nom contact adjudicataire';
            FieldClass = FlowField;
        }
    }
    keys
    {

        //Unsupported feature: Property Deletion (KeyGroups) on "Description(Key)".

    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: RecLAffairStep)()
    //Parameters and return type have not been exported.
    //begin
        /*
        */
    //end;


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        MoveEntries.MoveJobEntries(Rec);

        JobTask.SETCURRENTKEY("Job No.");
        #4..17
        CommentLine.DELETEALL;

        DimMgt.DeleteDefaultDim(DATABASE::Job,"No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..20

        IF "Project Manager" <> '' THEN
          RemoveFromMyJobs;
        //>>MIGRATION NAV 2013
        //>FEP-ADVE-200706_18_A.002
        RecLAffairStep.SETRANGE("Affair No.", "No.");
        RecLAffairStep.DELETEALL;
        //<FEP-ADVE-200706_18_A.002
        //<<MIGRATION NAV 2013
        */
    //end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        JobsSetup.GET;

        IF "No." = '' THEN BEGIN
        #4..10

        IF NOT "Apply Usage Link" THEN
          VALIDATE("Apply Usage Link",JobsSetup."Apply Usage Link by Default");
        IF "WIP Method" = '' THEN
          VALIDATE("WIP Method",JobsSetup."Default WIP Method");
        IF "Job Posting Group" = '' THEN
        #17..23

        "Creation Date" := TODAY;
        "Last Date Modified" := "Creation Date";
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..13
        IF NOT "Allow Schedule/Contract Lines" THEN
          VALIDATE("Allow Schedule/Contract Lines",JobsSetup."Allow Sched/Contract Lines Def");
        #14..26

        IF ("Project Manager" <> '') AND (Status = Status::Open) THEN
          AddToMyJobs("Project Manager");
        */
    //end;


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Last Date Modified" := TODAY;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        "Last Date Modified" := TODAY;

        IF (("Project Manager" <> xRec."Project Manager") AND (xRec."Project Manager" <> '')) OR (Status <> Status::Open) THEN
          RemoveFromMyJobs;

        IF ("Project Manager" <> '') AND (xRec."Project Manager" <> "Project Manager") THEN
          IF Status = Status::Open THEN
            AddToMyJobs("Project Manager");
        */
    //end;


    //Unsupported feature: Code Modification on "OnRename".

    //trigger OnRename()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Last Date Modified" := TODAY;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        UpdateJobNoInReservationEntries;
        "Last Date Modified" := TODAY;
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "ValidateShortcutDimCode(PROCEDURE 29)".



    //Unsupported feature: Code Modification on "ValidateShortcutDimCode(PROCEDURE 29)".

    //procedure ValidateShortcutDimCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::Job,"No.",FieldNumber,ShortcutDimCode);
        MODIFY;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::Job,"No.",FieldNumber,ShortcutDimCode);
        UpdateJobTaskDimension(FieldNumber,ShortcutDimCode);
        MODIFY;
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "UpdateBillToCont(PROCEDURE 27)".


    //Unsupported feature: Property Insertion (Local) on "UpdateBillToCust(PROCEDURE 26)".



    //Unsupported feature: Code Modification on "UpdateBillToCust(PROCEDURE 26)".

    //procedure UpdateBillToCust();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Cont.GET(ContactNo) THEN BEGIN
          "Bill-to Contact No." := Cont."No.";
          IF Cont.Type = Cont.Type::Person THEN
        #4..20
            VALIDATE("Bill-to Customer No.",ContBusinessRelation."No.")
          ELSE
            IF "Bill-to Customer No." <> ContBusinessRelation."No." THEN
              ERROR(Text006,Cont."No.",Cont.Name,"Bill-to Customer No.");
        END ELSE
          ERROR(Text007,Cont."No.",Cont.Name);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..23
              ERROR(ContactBusRelErr,Cont."No.",Cont.Name,"Bill-to Customer No.");
        END ELSE
          ERROR(ContactBusRelMissingErr,Cont."No.",Cont.Name);
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "UpdateCust(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "UpdateCust(PROCEDURE 4)".

    //procedure UpdateCust();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Bill-to Customer No." <> '' THEN BEGIN
          Cust.GET("Bill-to Customer No.");
          Cust.TESTFIELD("Customer Posting Group");
          Cust.TESTFIELD("Bill-to Customer No.",'');
          IF Cust.Blocked = Cust.Blocked::All THEN
            ERROR(
              Text012,
              FIELDCAPTION("Bill-to Customer No."),
              "Bill-to Customer No.",
              Cust.TABLECAPTION,
        #11..17
          "Bill-to Post Code" := Cust."Post Code";
          "Bill-to Country/Region Code" := Cust."Country/Region Code";
          "Invoice Currency Code" := Cust."Currency Code";
          "Customer Disc. Group" := Cust."Customer Disc. Group";
          "Customer Price Group" := Cust."Customer Price Group";
          "Language Code" := Cust."Language Code";
        #24..38
          "Bill-to County" := '';
          VALIDATE("Bill-to Contact No.",'');
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
              BlockedCustErr,
        #8..20
          IF "Invoice Currency Code" <> '' THEN
            IF "Currency Code" <> "Invoice Currency Code" THEN
              "Currency Code" := '';
        #21..41
        */
    //end;


    //Unsupported feature: Code Modification on "TestBlocked(PROCEDURE 6)".

    //procedure TestBlocked();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Blocked = Blocked::" " THEN
          EXIT;
        ERROR(Text008,TABLECAPTION,"No.",Blocked);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF Blocked = Blocked::" " THEN
          EXIT;
        ERROR(TestBlockedErr,TABLECAPTION,"No.",Blocked);
        */
    //end;


    //Unsupported feature: Code Modification on "CurrencyUpdatePlanningLines(PROCEDURE 10)".

    //procedure CurrencyUpdatePlanningLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        JobPlanningLine.SETRANGE("Job No.","No.");
        IF JobPlanningLine.FIND('-') THEN
          REPEAT
            JobPlanningLine.CALCFIELDS("Qty. Transferred to Invoice");
            IF JobPlanningLine."Qty. Transferred to Invoice" <> 0 THEN
              ERROR(Text000,FIELDCAPTION("Currency Code"),TABLECAPTION);
            JobPlanningLine.VALIDATE("Currency Code","Currency Code");
            JobPlanningLine.VALIDATE("Currency Date");
            JobPlanningLine.MODIFY;
          UNTIL JobPlanningLine.NEXT = 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5
              ERROR(AssociatedEntriesExistErr,FIELDCAPTION("Currency Code"),TABLECAPTION);
        #7..10
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "CurrencyUpdatePurchLines(PROCEDURE 17)".


    //Unsupported feature: Property Insertion (Local) on "ChangeJobCompletionStatus(PROCEDURE 7)".



    //Unsupported feature: Code Modification on "ChangeJobCompletionStatus(PROCEDURE 7)".

    //procedure ChangeJobCompletionStatus();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        AllObjwithCaption.GET(AllObjwithCaption."Object Type"::Report,REPORT::"Job Calculate WIP");
        ReportCaption1 := AllObjwithCaption."Object Caption";
        AllObjwithCaption.GET(AllObjwithCaption."Object Type"::Report,REPORT::"Job Post WIP to G/L");
        ReportCaption2 := AllObjwithCaption."Object Caption";

        IF Complete THEN BEGIN
          IF "Ending Date" = 0D THEN
            EndingDate := WORKDATE
          ELSE
            EndingDate := "Ending Date";

          JobLedgerEntry.SETRANGE("Job No.","No.");
          REPEAT
            IF JobLedgerEntry."Posting Date" > EndingDate THEN
              EndingDate := JobLedgerEntry."Posting Date";
          UNTIL JobLedgerEntry.NEXT = 0;

          IF "Ending Date" < EndingDate THEN
            VALIDATE("Ending Date",EndingDate);
          MESSAGE(Text018,FIELDCAPTION("Ending Date"),"Ending Date");

          MESSAGE(Text003,ReportCaption1,ReportCaption2);
        END ELSE BEGIN
          JobCalcWIP.ReOpenJob("No.");
          "WIP Posting Date" := 0D;
          MESSAGE(Text009,ReportCaption2);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF Complete THEN BEGIN
          VALIDATE("Ending Date",CalcEndingDate);
          MESSAGE(EndingDateChangedMsg,FIELDCAPTION("Ending Date"),"Ending Date");
        #23..25
          MESSAGE(ReverseCompletionEntriesMsg,GetReportCaption(REPORT::"Job Post WIP to G/L"));
        END;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: OnlineMapSetup) (VariableCollection) on "DisplayMap(PROCEDURE 8)".


    //Unsupported feature: Variable Insertion (Variable: OnlineMapManagement) (VariableCollection) on "DisplayMap(PROCEDURE 8)".



    //Unsupported feature: Code Modification on "DisplayMap(PROCEDURE 8)".

    //procedure DisplayMap();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF MapPoint.FINDFIRST THEN
          MapMgt.MakeSelection(DATABASE::Job,GETPOSITION)
        ELSE
          MESSAGE(Text010);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF OnlineMapSetup.FINDFIRST THEN
          OnlineMapManagement.MakeSelection(DATABASE::Job,GETPOSITION)
        ELSE
          MESSAGE(OnlineMapMsg);
        */
    //end;


    //Unsupported feature: Code Modification on "CheckDate(PROCEDURE 30)".

    //procedure CheckDate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ("Starting Date" > "Ending Date") AND ("Ending Date" <> 0D) THEN
          ERROR(Text011,FIELDCAPTION("Starting Date"),FIELDCAPTION("Ending Date"));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF ("Starting Date" > "Ending Date") AND ("Ending Date" <> 0D) THEN
          ERROR(CheckDateErr,FIELDCAPTION("Starting Date"),FIELDCAPTION("Ending Date"));
        */
    //end;


    //Unsupported feature: Code Modification on "PercentOverdue(PROCEDURE 18)".

    //procedure PercentOverdue();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        JobPlanningLine.SETRANGE("Job No.","No.");
        IF JobPlanningLine.FINDSET THEN
          REPEAT
            BEGIN
              IF (JobPlanningLine."Planning Date" < WORKDATE) AND (JobPlanningLine."Remaining Qty." > 0) THEN
                QtyOverdue += 1
              ELSE
                QtyOnSchedule += 1;
            END;
          UNTIL JobPlanningLine.NEXT = 0;
        QtyTotal := QtyOverdue + QtyOnSchedule;
        IF QtyTotal <> 0 THEN
          EXIT((QtyOverdue / QtyTotal) * 100);
        EXIT(0);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
            IF (JobPlanningLine."Planning Date" < WORKDATE) AND (JobPlanningLine."Remaining Qty." > 0) THEN
              QtyOverdue += 1
            ELSE
              QtyOnSchedule += 1;
        #10..14
        */
    //end;

    procedure CurrencyCheck()
    begin
        IF ("Invoice Currency Code" <> "Currency Code") AND ("Invoice Currency Code" <> '') AND ("Currency Code" <> '') THEN
          ERROR(DifferentCurrenciesErr);
    end;

    local procedure UpdateJobNoInReservationEntries()
    var
        ReservEntry: Record "337";
    begin
        ReservEntry.SETFILTER("Source Type",'%1|%2',DATABASE::"Job Planning Line",DATABASE::"Job Journal Line");
        ReservEntry.SETRANGE("Source ID",xRec."No.");
        ReservEntry.MODIFYALL("Source ID","No.",TRUE);
    end;

    local procedure UpdateJobTaskDimension(FieldNumber: Integer;ShortcutDimCode: Code[20])
    var
        JobTask: Record "1001";
    begin
        IF GUIALLOWED THEN
          IF NOT CONFIRM(UpdateJobTaskDimQst,FALSE) THEN
            EXIT;

        JobTask.SETRANGE("Job No.","No.");
        IF JobTask.FINDSET(TRUE) THEN
          REPEAT
            CASE FieldNumber OF
              1:
                JobTask.VALIDATE("Global Dimension 1 Code",ShortcutDimCode);
              2:
                JobTask.VALIDATE("Global Dimension 2 Code",ShortcutDimCode);
            END;
            JobTask.MODIFY(TRUE);
          UNTIL JobTask.NEXT = 0;
    end;

    procedure UpdateOverBudgetValue(JobNo: Code[20];Usage: Boolean;Cost: Decimal)
    var
        JobLedgerEntry: Record "169";
        JobPlanningLine: Record "1003";
        UsageCost: Decimal;
        ScheduleCost: Decimal;
    begin
        IF "No." <> JobNo THEN
          IF NOT GET(JobNo) THEN
            EXIT;

        JobLedgerEntry.SETRANGE("Job No.",JobNo);
        JobLedgerEntry.CALCSUMS("Total Cost (LCY)");
        IF JobLedgerEntry."Total Cost (LCY)" = 0 THEN
          EXIT;

        UsageCost := JobLedgerEntry."Total Cost (LCY)";

        JobPlanningLine.SETRANGE("Job No.",JobNo);
        JobPlanningLine.SETRANGE("Schedule Line",TRUE);
        JobPlanningLine.CALCSUMS("Total Cost (LCY)");
        ScheduleCost := JobPlanningLine."Total Cost (LCY)";

        IF Usage THEN
          UsageCost += Cost
        ELSE
          ScheduleCost += Cost;
        "Over Budget" := UsageCost > ScheduleCost;
        MODIFY;
    end;

    procedure IsJobSimplificationAvailable(): Boolean
    begin
        EXIT(TRUE);
    end;

    local procedure AddToMyJobs(ProjectManager: Code[50])
    var
        MyJob: Record "9154";
    begin
        IF Status = Status::Open THEN BEGIN
          MyJob.INIT;
          MyJob."User ID" := ProjectManager;
          MyJob."Job No." := "No.";
          MyJob.Description := Description;
          MyJob.Status := Status;
          MyJob."Bill-to Name" := "Bill-to Name";
          MyJob."Percent Completed" := PercentCompleted;
          MyJob."Percent Invoiced" := PercentInvoiced;
          MyJob."Exclude from Business Chart" := FALSE;
          MyJob.INSERT;
        END;
    end;

    local procedure RemoveFromMyJobs()
    var
        MyJob: Record "9154";
    begin
        MyJob.SETFILTER("Job No.",'=%1',"No.");
        IF MyJob.FINDSET THEN
          REPEAT
            MyJob.DELETE;
          UNTIL MyJob.NEXT = 0;
    end;

    procedure SendRecords()
    var
        DocumentSendingProfile: Record "60";
        DummyReportSelections: Record "77";
    begin
        DocumentSendingProfile.SendCustomerRecords(
          DummyReportSelections.Usage::JQ,Rec,DocTxt,"Bill-to Customer No.","No.",
          FIELDNO("Bill-to Customer No."),FIELDNO("No."));
    end;

    procedure SendProfile(var DocumentSendingProfile: Record "60")
    var
        ReportSelections: Record "77";
    begin
        DocumentSendingProfile.Send(
          ReportSelections.Usage::JQ,Rec,"No.","Bill-to Customer No.",
          DocTxt,FIELDNO("Bill-to Customer No."),FIELDNO("No."));
    end;

    procedure PrintRecords(ShowRequestForm: Boolean)
    var
        DocumentSendingProfile: Record "60";
        ReportSelections: Record "77";
    begin
        DocumentSendingProfile.TrySendToPrinter(
          ReportSelections.Usage::JQ,Rec,"Bill-to Customer No.",ShowRequestForm);
    end;

    procedure EmailRecords(ShowDialog: Boolean)
    var
        DocumentSendingProfile: Record "60";
        ReportSelections: Record "77";
    begin
        DocumentSendingProfile.TrySendToEMail(
          ReportSelections.Usage::JQ,Rec,FIELDNO("No."),DocTxt,FIELDNO("Bill-to Customer No."),ShowDialog);
    end;

    procedure RecalculateJobWIP()
    var
        Job: Record "167";
        Confirmed: Boolean;
        WIPQst: Text;
    begin
        Job.GET("No.");
        IF Job."WIP Method" = '' THEN
          EXIT;

        Job.SETRECFILTER;
        WIPQst := STRSUBSTNO(RunWIPFunctionsQst,GetReportCaption(REPORT::"Job Calculate WIP"));
        Confirmed := CONFIRM(WIPQst);
        COMMIT;
        REPORT.RUNMODAL(REPORT::"Job Calculate WIP",NOT Confirmed,FALSE,Job);
    end;

    local procedure GetReportCaption(ReportID: Integer): Text
    var
        AllObjWithCaption: Record "2000000058";
    begin
        AllObjWithCaption.GET(AllObjWithCaption."Object Type"::Report,ReportID);
        EXIT(AllObjWithCaption."Object Caption");
    end;

    local procedure CalcEndingDate() EndingDate: Date
    var
        JobLedgerEntry: Record "169";
    begin
        IF "Ending Date" = 0D THEN
          EndingDate := WORKDATE
        ELSE
          EndingDate := "Ending Date";

        JobLedgerEntry.SETRANGE("Job No.","No.");
        REPEAT
          IF JobLedgerEntry."Posting Date" > EndingDate THEN
            EndingDate := JobLedgerEntry."Posting Date";
        UNTIL JobLedgerEntry.NEXT = 0;

        IF "Ending Date" >= EndingDate THEN
          EndingDate := "Ending Date";
    end;

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: Brick)".


    //Unsupported feature: Deletion (VariableCollection) on "ChangeJobCompletionStatus(PROCEDURE 7).AllObjwithCaption(Variable 1003)".


    //Unsupported feature: Deletion (VariableCollection) on "ChangeJobCompletionStatus(PROCEDURE 7).JobLedgerEntry(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "ChangeJobCompletionStatus(PROCEDURE 7).ReportCaption1(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "ChangeJobCompletionStatus(PROCEDURE 7).ReportCaption2(Variable 1004)".


    //Unsupported feature: Deletion (VariableCollection) on "ChangeJobCompletionStatus(PROCEDURE 7).EndingDate(Variable 1005)".


    //Unsupported feature: Deletion (VariableCollection) on "DisplayMap(PROCEDURE 8).MapPoint(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "DisplayMap(PROCEDURE 8).MapMgt(Variable 1000)".


    var
        RecLAffairStep: Record "50010";

    var
        AssociatedEntriesExistErr: Label 'You cannot change %1 because one or more entries are associated with this %2.', Comment='%1 = Name of field used in the error; %2 = The name of the Job table';

    var
        StatusChangeQst: Label 'This will delete any unposted WIP entries for this job and allow you to reverse the completion postings for this job.\\Do you wish to continue?';
        ContactBusRelDiffCompErr: Label 'Contact %1 %2 is related to a different company than customer %3.', Comment='%1 = The contact number; %2 = The contact''s name; %3 = The Bill-To Customer Number associated with this job';
        ContactBusRelErr: Label 'Contact %1 %2 is not related to customer %3.', Comment='%1 = The contact number; %2 = The contact''s name; %3 = The Bill-To Customer Number associated with this job';
        ContactBusRelMissingErr: Label 'Contact %1 %2 is not related to a customer.', Comment='%1 = The contact number; %2 = The contact''s name';
        TestBlockedErr: Label '%1 %2 must not be blocked with type %3.', Comment='%1 = The Job table name; %2 = The Job number; %3 = The value of the Blocked field';
        ReverseCompletionEntriesMsg: Label 'You must run the %1 function to reverse the completion entries that have already been posted for this job.', Comment='%1 = The name of the Job Post WIP to G/L report';

    var
        OnlineMapMsg: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        CheckDateErr: Label '%1 must be equal to or earlier than %2.', Comment='%1 = The job''s starting date; %2 = The job''s ending date';
        BlockedCustErr: Label 'You cannot set %1 to %2, as this %3 has set %4 to %5.', Comment='%1 = The Bill-to Customer No. field name; %2 = The job''s Bill-to Customer No. value; %3 = The Customer table name; %4 = The Blocked field name; %5 = The job''s customer''s Blocked value';
        ApplyUsageLinkErr: Label 'A usage link cannot be enabled for the entire %1 because usage without the usage link already has been posted.', Comment='%1 = The name of the Job table';
        WIPMethodQst: Label 'Do you want to set the %1 on every %2 of type %3?', Comment='%1 = The WIP Method field name; %2 = The name of the Job Task table; %3 = The current job task''s WIP Total type';
        WIPAlreadyPostedErr: Label '%1 must be %2 because job WIP general ledger entries already were posted with this setting.', Comment='%1 = The name of the WIP Posting Method field; %2 = The previous WIP Posting Method value of this job';
        WIPAlreadyAssociatedErr: Label '%1 cannot be modified because the job has associated job WIP entries.', Comment='%1 = The name of the WIP Posting Method field';
        WIPPostMethodErr: Label 'The selected %1 requires the %2 to have %3 enabled.', Comment='%1 = The name of the WIP Posting Method field; %2 = The name of the WIP Method field; %3 = The field caption represented by the value of this job''s WIP method';
        EndingDateChangedMsg: Label '%1 is set to %2.', Comment='%1 = The name of the Ending Date field; %2 = This job''s Ending Date value';
        UpdateJobTaskDimQst: Label 'You have changed a dimension.\\Do you want to update the lines?';
        DocTxt: Label 'Job Quote';
        RunWIPFunctionsQst: Label 'You must run the %1 function to create completion entries for this job. \Do you want to run this function now?', Comment='%1 = The name of the Job Calculate WIP report';
        DifferentCurrenciesErr: Label 'You cannot plan and invoice a job in different currencies.';
}

