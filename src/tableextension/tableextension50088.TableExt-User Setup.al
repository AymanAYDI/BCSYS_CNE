tableextension 50088 tableextension50088 extends "User Setup"
{
    // <changelog>
    //   <add id="FR0001" dev="KCOOLS" date="2006-05-18" area="FISCYEAR" feature="PS17000"
    //     releaseversion="FR4.00.03">Fiscal Year Closing</add>
    // </changelog>
    // 
    // -----------------------------------------------
    // Prodware - www.prodware.fr
    // -----------------------------------------------
    // //>>MIGRATION NAV 2013
    // //>>CNE3.01
    //   FE-Emailsuiviaffaires-20090818:SOBI 12/11/09 : - add field 50000 E-mail Business Reminder
    // 
    // //>> CNE4.01
    // B:FE04 01.09.2011 : MiniForm Menu User
    //                        - Add Field : 50040 Min. Forms Menu
    // 
    // //>>CNE5.00
    // TDL.71/CSC 02/12/2013 : Add field "Autorize Qty. to Handle Change"
    // 
    // //>> CNE6.01
    // TDL:EC01 29.12.2014 : Add Field Aut. Qty. to Han. Test PickQty
    // 
    // //>>CNE7.01
    // //>>P24233_001 SOBI APA 02/02/17
    //                     Add Field 50004
    LookupPageID = 119;
    DrillDownPageID = 119;
    fields
    {
        modify(Substitute)
        {
            TableRelation = "User Setup"."User ID";
        }

        //Unsupported feature: Property Deletion (TestTableRelation) on ""User ID"(Field 1)".


        //Unsupported feature: Property Deletion (ValidateTableRelation) on ""Salespers./Purch. Code"(Field 10)".


        //Unsupported feature: Property Deletion (TestTableRelation) on ""Salespers./Purch. Code"(Field 10)".



        //Unsupported feature: Code Insertion on ""Approver ID"(Field 11)".

        //trigger OnLookup(var Text: Text): Boolean
        //var
        //UserSetup: Record "91";
        //begin
        /*
        UserSetup.SETFILTER("User ID",'<>%1',"User ID");
        IF PAGE.RUNMODAL(PAGE::"Approval User Setup",UserSetup) = ACTION::LookupOK THEN
          VALIDATE("Approver ID",UserSetup."User ID");
        */
        //end;


        //Unsupported feature: Code Insertion on ""Approver ID"(Field 11)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        IF "Approver ID" = "User ID" THEN
          FIELDERROR("Approver ID");
        */
        //end;

        //Unsupported feature: Property Deletion (ValidateTableRelation) on ""Approver ID"(Field 11)".


        //Unsupported feature: Property Deletion (TestTableRelation) on ""Approver ID"(Field 11)".



        //Unsupported feature: Code Insertion on "Substitute(Field 16)".

        //trigger OnLookup(var Text: Text): Boolean
        //var
        //UserSetup: Record "91";
        //begin
        /*
        UserSetup.SETFILTER("User ID",'<>%1',"User ID");
        IF PAGE.RUNMODAL(PAGE::"Approval User Setup",UserSetup) = ACTION::LookupOK THEN
          VALIDATE(Substitute,UserSetup."User ID");
        */
        //end;


        //Unsupported feature: Code Insertion on "Substitute(Field 16)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        IF Substitute = "User ID" THEN
          FIELDERROR(Substitute);
        */
        //end;
        field(21; "Approval Administrator"; Boolean)
        {
            Caption = 'Approval Administrator';

            trigger OnValidate()
            var
                UserSetup: Record "91";
            begin
                IF "Approval Administrator" THEN BEGIN
                    UserSetup.SETRANGE("Approval Administrator", TRUE);
                    IF NOT UserSetup.ISEMPTY THEN
                        FIELDERROR("Approval Administrator");
                END;
            end;
        }
        field(31; "License Type"; Option)
        {
            CalcFormula = Lookup (User."License Type" WHERE (User Name=FIELD(User ID)));
            Caption = 'License Type';
            FieldClass = FlowField;
            OptionCaption = 'Full User,Limited User,Device Only User,Windows Group,External User';
            OptionMembers = "Full User","Limited User","Device Only User","Windows Group","External User";
        }
        field(50000;"E-mail Business Reminder";Text[150])
        {
            Caption = 'E-mail Business Reminder';
            Description = 'CNE3.01';
        }
        field(50001;"Min. Forms Menu";Boolean)
        {
            Caption = 'Portable Terminal Menu';
            Description = 'CNE4.01';
        }
        field(50002;"Autorize Qty. to Handle Change";Boolean)
        {
            Caption = 'Autorize Qty. to Handle Change';
            Description = 'CNE5.00';
        }
        field(50003;"Aut. Qty. to Han. Test PickQty";Boolean)
        {
            Caption = 'Aut. Qty. to Hand. withPickQty';
            Description = 'CNE6.01';
        }
        field(50004;"Limited User";Boolean)
        {
            Caption = 'Limited User';
        }
        field(50005;"Aut. Real Sales Profit %";Boolean)
        {
            Caption = 'Aut. Real Sales Profit %';
        }
        field(50006;"Activ. Mini Margin Control";Boolean)
        {
            Caption = 'Activate Mini Margin / Blocked Price Control';
        }
        field(50007;"SAV Admin";Boolean)
        {
            Caption = 'SAV Admin';
            Description = 'BCSYS';
        }
    }


    //Unsupported feature: Code Insertion on "OnDelete".

    //trigger OnDelete()
    //var
        //NotificationSetup: Record "1512";
    //begin
        /*
        NotificationSetup.SETRANGE("User ID","User ID");
        NotificationSetup.DELETEALL(TRUE);
        */
    //end;

    procedure CreateApprovalUserSetup(User: Record "2000000120")
    var
        UserSetup: Record "91";
        ApprovalUserSetup: Record "91";
    begin
        ApprovalUserSetup.INIT;
        ApprovalUserSetup.VALIDATE("User ID",User."User Name");
        ApprovalUserSetup.VALIDATE("Sales Amount Approval Limit",GetDefaultSalesAmountApprovalLimit);
        ApprovalUserSetup.VALIDATE("Purchase Amount Approval Limit",GetDefaultPurchaseAmountApprovalLimit);
        ApprovalUserSetup.VALIDATE("E-Mail",User."Contact Email");
        UserSetup.SETRANGE("Sales Amount Approval Limit",UserSetup.GetDefaultSalesAmountApprovalLimit);
        IF UserSetup.FINDFIRST THEN
          ApprovalUserSetup.VALIDATE("Approver ID",UserSetup."Approver ID");
        IF ApprovalUserSetup.INSERT THEN;
    end;

    procedure GetDefaultSalesAmountApprovalLimit(): Integer
    var
        UserSetup: Record "91";
        DefaultApprovalLimit: Integer;
        LimitedApprovers: Integer;
    begin
        UserSetup.SETRANGE("Unlimited Sales Approval",FALSE);

        IF UserSetup.FINDFIRST THEN BEGIN
          DefaultApprovalLimit := UserSetup."Sales Amount Approval Limit";
          LimitedApprovers := UserSetup.COUNT;
          UserSetup.SETRANGE("Sales Amount Approval Limit",DefaultApprovalLimit);
          IF LimitedApprovers = UserSetup.COUNT THEN
            EXIT(DefaultApprovalLimit);
        END;

        // Return 0 if no user setup exists or no default value is found
        EXIT(0);
    end;

    procedure GetDefaultPurchaseAmountApprovalLimit(): Integer
    var
        UserSetup: Record "91";
        DefaultApprovalLimit: Integer;
        LimitedApprovers: Integer;
    begin
        UserSetup.SETRANGE("Unlimited Purchase Approval",FALSE);

        IF UserSetup.FINDFIRST THEN BEGIN
          DefaultApprovalLimit := UserSetup."Purchase Amount Approval Limit";
          LimitedApprovers := UserSetup.COUNT;
          UserSetup.SETRANGE("Purchase Amount Approval Limit",DefaultApprovalLimit);
          IF LimitedApprovers = UserSetup.COUNT THEN
            EXIT(DefaultApprovalLimit);
        END;

        // Return 0 if no user setup exists or no default value is found
        EXIT(0);
    end;

    procedure HideExternalUsers()
    var
        PermissionManager: Codeunit "9002";
        OriginalFilterGroup: Integer;
    begin
        IF NOT PermissionManager.SoftwareAsAService THEN
          EXIT;

        OriginalFilterGroup := FILTERGROUP;
        FILTERGROUP := 2;
        CALCFIELDS("License Type");
        SETFILTER("License Type",'<>%1',"License Type"::"External User");
        FILTERGROUP := OriginalFilterGroup;
    end;
}

