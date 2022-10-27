tableextension 50052 tableextension50052 extends Contact
{
    // <changelog>
    //   <add id="FR0001" dev="EDUBUC" date="2004-08-19" area="COMPANY"  request="FR-START-40"
    //     releaseversion="FR4.00">Extra company information fields</add>
    //   <change id="FR0002" dev="KCOOLS" date="2006-08-21" area="COMPANY" feature="PSCORS1072"
    //     baseversion="FR4.00" releaseversion="FR5.00">Renamed field 10801</change>
    //   <change id="FR0003" dev="KCOOLS" date="2006-10-02" area="COMPANY" feature="PSCORS1073"
    //     baseversion="FR4.00" releaseversion="FR5.00">Field Authorized Capital renamed to Stock Capital</change>
    // </changelog>
    // 
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //>>DEEE1.01:FLGR 19/02/2007 correct bug in quotes with customer template
    //     propagate "Submitted to DEEE" from customer template to customer
    // 
    // ------------------------------------------------------------------------

    //Unsupported feature: Property Modification (Permissions) on "Contact(Table 5050)".

    LookupPageID = 5052;
    DrillDownPageID = 5052;
    fields
    {
        modify(City)
        {
            TableRelation = IF (Country/Region Code=CONST()) "Post Code".City
                            ELSE IF (Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Country/Region Code));
        }

        //Unsupported feature: Property Modification (CalcFormula) on "Comment(Field 38)".

        modify(Picture)
        {
            Caption = 'Picture';
        }
        modify("Post Code")
        {
            TableRelation = IF (Country/Region Code=CONST()) "Post Code"
                            ELSE IF (Country/Region Code=FILTER(<>'')) "Post Code" WHERE (Country/Region Code=FIELD(Country/Region Code));
        }
        modify("E-Mail")
        {
            Caption = 'Email';
        }
        modify("Company Name")
        {
            TableRelation = Contact WHERE (Type=CONST(Company));

            //Unsupported feature: Property Insertion (ValidateTableRelation) on ""Company Name"(Field 5052)".

        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Next To-do Date"(Field 5066)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Last Date Attempted"(Field 5067)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Date of Last Interaction"(Field 5068)".


        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Interactions"(Field 5074)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Cost (LCY)"(Field 5076)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Duration (Min.)"(Field 5077)".


        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Opportunities"(Field 5078)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Estimated Value (LCY)"(Field 5079)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Calcd. Current Value (LCY)"(Field 5080)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Opportunity Entry Exists"(Field 5082)".


        //Unsupported feature: Property Modification (CalcFormula) on ""To-do Entry Exists"(Field 5083)".

        modify("Correspondence Type")
        {
            OptionCaption = ' ,Hard Copy,Email,Fax';

            //Unsupported feature: Property Modification (OptionString) on ""Correspondence Type"(Field 5100)".

        }
        modify("Search E-Mail")
        {
            Caption = 'Search Email';
        }
        modify("E-Mail 2")
        {
            Caption = 'Email 2';
        }


        //Unsupported feature: Code Insertion on ""Country/Region Code"(Field 35)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            PostCode.ValidateCountryCode(City,"Post Code",County,"Country/Region Code");
            */
        //end;


        //Unsupported feature: Code Modification on ""VAT Registration No."(Field 86).OnValidate".

        //trigger "(Field 86)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            VATRegNoFormat.Test("VAT Registration No.","Country/Region Code","No.",DATABASE::Contact);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF VATRegNoFormat.Test("VAT Registration No.","Country/Region Code","No.",DATABASE::Contact) THEN
              IF "VAT Registration No." <> xRec."VAT Registration No." THEN
                VATRegistrationLogMgt.LogContact(Rec);
            */
        //end;


        //Unsupported feature: Code Modification on "Type(Field 5050).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF CurrFieldNo <> 0 THEN BEGIN
              TypeChange;
              MODIFY;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF (CurrFieldNo <> 0) AND ("No." <> '') THEN BEGIN
            #2..4
            */
        //end;


        //Unsupported feature: Code Modification on ""Company No."(Field 5051).OnValidate".

        //trigger "(Field 5051)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF "Company No." = xRec."Company No." THEN
              EXIT;

            TESTFIELD(Type,Type::Person);

            SegLine.SETCURRENTKEY("Contact No.");
            SegLine.SETRANGE("Contact No.","No.");
            IF SegLine.FINDFIRST THEN
              ERROR(Text012,FIELDCAPTION("Company No."));

            IF Cont.GET("Company No.") THEN
              InheritCompanyToPersonData(Cont,xRec."Company No." = '')
            ELSE
              CLEAR("Company Name");

            IF Cont.GET("No.") THEN BEGIN
              IF xRec."Company No." <> '' THEN BEGIN
                Opp.SETCURRENTKEY("Contact Company No.","Contact No.");
            #19..69
                InteractLogEntry.SETRANGE("Contact No.","No.");
                InteractLogEntry.MODIFYALL("Contact Company No.","Company No.");
              END;
              IF CurrFieldNo <> 0 THEN
                MODIFY;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF Cont.GET("Company No.") THEN
              InheritCompanyToPersonData(Cont)
            #13..15
            #1..5
            SegLine.SETRANGE("Contact No.","No.");
            IF NOT SegLine.ISEMPTY THEN
              ERROR(Text012,FIELDCAPTION("Company No."));

            #16..72

            #73..75
            */
        //end;


        //Unsupported feature: Code Insertion on ""Company Name"(Field 5052)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            VALIDATE("Company No.",GetCompNo("Company Name"));
            */
        //end;

        //Unsupported feature: Property Deletion (Editable) on ""Company Name"(Field 5052)".

        field(140;Image;Media)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
        }
    }
    keys
    {

        //Unsupported feature: Property Deletion (KeyGroups) on "Name(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on "City(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Post Code"(Key)".


        //Unsupported feature: Property Deletion (KeyGroups) on ""Phone No."(Key)".

    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: VATRegistrationLogMgt)()
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
        DOPaymentCreditCard.DeleteByContact(Rec);

        Todo.SETCURRENTKEY("Contact Company No.","Contact No.",Closed,Date);
        Todo.SETRANGE("Contact Company No.","Company No.");
        Todo.SETRANGE("Contact No.","No.");
        Todo.SETRANGE(Closed,FALSE);
        IF Todo.FIND('-') THEN
          ERROR(Text000,TABLECAPTION,"No.");

        SegLine.SETCURRENTKEY("Contact No.");
        SegLine.SETRANGE("Contact No.","No.");
        IF SegLine.FINDFIRST THEN
          ERROR(Text001,TABLECAPTION,"No.");

        Opp.SETCURRENTKEY("Contact Company No.","Contact No.");
        #16..18
        IF Opp.FIND('-') THEN
          ERROR(Text002,TABLECAPTION,"No.");

        CASE Type OF
          Type::Company:
            BEGIN
              ContBusRel.SETRANGE("Contact No.","No.");
              ContBusRel.DELETEALL;
              ContIndustGrp.SETRANGE("Contact No.","No.");
              ContIndustGrp.DELETEALL;
              ContactWebSource.SETRANGE("Contact No.","No.");
        #30..108

        ContAltAddrDateRange.SETRANGE("Contact No.","No.");
        ContAltAddrDateRange.DELETEALL;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #3..9
        SegLine.SETRANGE("Contact No.","No.");
        IF NOT SegLine.ISEMPTY THEN
        #13..21
        ContBusRel.SETRANGE("Contact No.","No.");
        ContBusRel.DELETEALL;
        #22..24
        #27..111

        VATRegistrationLogMgt.DeleteContactLog(Rec);
        */
    //end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        RMSetup.GET;

        IF "No." = '' THEN BEGIN
        #4..23
        END;

        TypeChange;

        "Last Date Modified" := TODAY;
        "Last Time Modified" := TIME;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..26
        SetLastDateTimeModified;
        */
    //end;


    //Unsupported feature: Code Modification on "OnModify(PROCEDURE 4)".

    //procedure OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Last Date Modified" := TODAY;
        "Last Time Modified" := TIME;

        IF Type = Type::Company THEN BEGIN
          IF (Name <> xRec.Name) OR
             ("Search Name" <> xRec."Search Name") OR
             ("Name 2" <> xRec."Name 2") OR
        #8..65
                Cont."Language Code" := "Language Code";
                ContChanged := TRUE;
              END;
              IF RMSetup."Inherit Address Details" THEN BEGIN
                IF xRec.IdenticalAddress(Cont) THEN BEGIN
                  IF xRec.Address <> Address THEN BEGIN
                    Cont.Address := Address;
        #73..88
                    ContChanged := TRUE;
                  END;
                END;
              END;
              IF RMSetup."Inherit Communication Details" THEN BEGIN
                IF (xRec."Phone No." <> "Phone No.") AND (xRec."Phone No." = Cont."Phone No.") THEN BEGIN
                  Cont."Phone No." := "Phone No.";
        #96..144
          THEN
            CheckDupl;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SetLastDateTimeModified;

        IF (Type = Type::Company) AND ("No." <> '') THEN BEGIN
        #5..68
              IF RMSetup."Inherit Address Details" THEN
        #70..91
        #93..147
        */
    //end;


    //Unsupported feature: Code Modification on "TypeChange(PROCEDURE 1)".

    //procedure TypeChange();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        RMSetup.GET;

        InteractLogEntry.LOCKTABLE;
        Todo.LOCKTABLE;
        Opp.LOCKTABLE;
        Cont.LOCKTABLE;
        InteractLogEntry.SETCURRENTKEY("Contact Company No.","Contact No.");
        InteractLogEntry.SETRANGE("Contact Company No.","Company No.");
        InteractLogEntry.SETRANGE("Contact No.","No.");
        IF InteractLogEntry.FINDFIRST THEN
          ERROR(Text003,FIELDCAPTION(Type));
        Todo.SETCURRENTKEY("Contact Company No.","Contact No.");
        Todo.SETRANGE("Contact Company No.","Company No.");
        Todo.SETRANGE("Contact No.","No.");
        IF Todo.FINDFIRST THEN
          ERROR(Text005,FIELDCAPTION(Type));
        Opp.SETCURRENTKEY("Contact Company No.","Contact No.");
        Opp.SETRANGE("Contact Company No.","Company No.");
        Opp.SETRANGE("Contact No.","No.");
        IF Opp.FINDFIRST THEN
          ERROR(Text006,FIELDCAPTION(Type));

        CASE Type OF
          Type::Company:
            BEGIN
              IF Type <> xRec.Type THEN BEGIN
                TESTFIELD("Organizational Level Code",'');
                TESTFIELD("No. of Job Responsibilities",0);
              END;
              "First Name" := '';
              "Middle Name" := '';
              Surname := '';
              "Job Title" := '';
              "Company No." := "No.";
              "Company Name" := Name;
              "Salutation Code" := RMSetup."Def. Company Salutation Code";
            END;
          Type::Person:
            BEGIN
              CampaignTargetGrMgt.DeleteContfromTargetGr(InteractLogEntry);
              Cont.RESET;
              Cont.SETCURRENTKEY("Company No.");
              Cont.SETRANGE("Company No.","No.");
              Cont.SETRANGE(Type,Type::Person);
              IF Cont.FIND('-') THEN
                ERROR(Text007,FIELDCAPTION(Type));
              IF Type <> xRec.Type THEN BEGIN
                TESTFIELD("No. of Business Relations",0);
                TESTFIELD("No. of Industry Groups",0);
                TESTFIELD("Currency Code",'');
                TESTFIELD("VAT Registration No.",'');
              END;
              IF "Company No." = "No." THEN BEGIN
                "Company No." := '';
                "Company Name" := '';
                "Salutation Code" := RMSetup."Default Person Salutation Code";
                NameBreakdown;
              END;
            END;
        END;
        VALIDATE("Lookup Contact No.");

        IF Cont.GET("No.") THEN BEGIN
          IF Type = Type::Company THEN
            CheckDupl
          ELSE
            DuplMgt.RemoveContIndex(Rec,FALSE);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        #6..11
        Todo.SETRANGE("Contact Company No.","Company No.");
        Todo.SETRANGE("Contact No.","No.");
        IF NOT Todo.ISEMPTY THEN
          ERROR(Text005,FIELDCAPTION(Type));
        Opp.SETRANGE("Contact Company No.","Company No.");
        Opp.SETRANGE("Contact No.","No.");
        IF NOT Opp.ISEMPTY THEN
        #21..68
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: OfficeMgt) (VariableCollection) on "CreateCustomer(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "CreateCustomer(PROCEDURE 3)".

    //procedure CreateCustomer();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TESTFIELD("Company No.");
        RMSetup.GET;
        RMSetup.TESTFIELD("Bus. Rel. Code for Customers");
        #4..35
        Cust.MODIFY;

        IF CustTemplate.Code <> '' THEN BEGIN
          Cust."Territory Code" := "Territory Code";
          Cust."Currency Code" := ContComp."Currency Code";
          Cust."Country/Region Code" := "Country/Region Code";
          Cust."Customer Posting Group" := CustTemplate."Customer Posting Group";
          Cust."Customer Price Group" := CustTemplate."Customer Price Group";
          Cust."Invoice Disc. Code" := CustTemplate."Invoice Disc. Code";
          Cust."Customer Disc. Group" := CustTemplate."Customer Disc. Group";
          Cust."Allow Line Disc." := CustTemplate."Allow Line Disc.";
          Cust."Gen. Bus. Posting Group" := CustTemplate."Gen. Bus. Posting Group";
          Cust."VAT Bus. Posting Group" := CustTemplate."VAT Bus. Posting Group";
          Cust."Payment Terms Code" := CustTemplate."Payment Terms Code";
          Cust."Payment Method Code" := CustTemplate."Payment Method Code";
          Cust."Shipment Method Code" := CustTemplate."Shipment Method Code";
          Cust.MODIFY;

          DefaultDim.SETRANGE("Table ID",DATABASE::"Customer Template");
        #55..67

        UpdateQuotes(Cust);
        CampaignMgt.ConverttoCustomer(Rec,Cust);
        MESSAGE(Text009,Cust.TABLECAPTION,Cust."No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CheckForExistingRelationships(ContBusRel."Link to Table"::Customer);
        #1..38
          IF "Territory Code" = '' THEN
            Cust."Territory Code" := CustTemplate."Territory Code"
          ELSE
            Cust."Territory Code" := "Territory Code";
          IF "Currency Code" = '' THEN
            Cust."Currency Code" := CustTemplate."Currency Code"
          ELSE
            Cust."Currency Code" := "Currency Code";
          IF "Country/Region Code" = '' THEN
            Cust."Country/Region Code" := CustTemplate."Country/Region Code"
          ELSE
            Cust."Country/Region Code" := "Country/Region Code";
          Cust."Customer Posting Group" := CustTemplate."Customer Posting Group";
          Cust."Customer Price Group" := CustTemplate."Customer Price Group";
          IF CustTemplate."Invoice Disc. Code" <> '' THEN
            Cust."Invoice Disc. Code" := CustTemplate."Invoice Disc. Code";
        #45..51

          //>>MIGRATION NAv 2013
          //>>DEEE1.01
          Cust."Submitted to DEEE" := CustTemplate."Submitted to DEEE";
          //<<DEEE1.01
          //<<MIGRATION NAv 2013

        #52..70
        IF OfficeMgt.IsAvailable THEN
          PAGE.RUN(PAGE::"Customer Card",Cust)
        ELSE
          IF NOT HideValidationDialog THEN
            MESSAGE(Text009,Cust.TABLECAPTION,Cust."No.");
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: OfficeMgt) (VariableCollection) on "CreateVendor(PROCEDURE 7)".



    //Unsupported feature: Code Modification on "CreateVendor(PROCEDURE 7)".

    //procedure CreateVendor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TESTFIELD("Company No.");
        RMSetup.GET;
        RMSetup.TESTFIELD("Bus. Rel. Code for Vendors");
        #4..19

        UpdateCustVendBank.UpdateVendor(ContComp,ContBusRel);

        MESSAGE(Text009,Vend.TABLECAPTION,Vend."No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CheckForExistingRelationships(ContBusRel."Link to Table"::Vendor);
        #1..22
        IF OfficeMgt.IsAvailable THEN
          PAGE.RUN(PAGE::"Vendor Card",Vend)
        ELSE
          MESSAGE(Text009,Vend.TABLECAPTION,Vend."No.");
        */
    //end;


    //Unsupported feature: Code Modification on "CreateCustomerLink(PROCEDURE 5)".

    //procedure CreateCustomerLink();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TESTFIELD("Company No.");
        RMSetup.GET;
        RMSetup.TESTFIELD("Bus. Rel. Code for Customers");
        #4..11
        IF ContBusRel.FINDFIRST THEN
          IF Cust.GET(ContBusRel."No.") THEN
            UpdateQuotes(Cust);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CheckForExistingRelationships(ContBusRel."Link to Table"::Customer);
        #1..14
        */
    //end;


    //Unsupported feature: Code Modification on "CreateVendorLink(PROCEDURE 6)".

    //procedure CreateVendorLink();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TESTFIELD("Company No.");
        RMSetup.GET;
        RMSetup.TESTFIELD("Bus. Rel. Code for Vendors");
        CreateLink(
          PAGE::"Vendor Link",
          RMSetup."Bus. Rel. Code for Vendors",
          ContBusRel."Link to Table"::Vendor);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CheckForExistingRelationships(ContBusRel."Link to Table"::Vendor);
        #1..7
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "CreateLink(PROCEDURE 11)".



    //Unsupported feature: Code Modification on "CreateLink(PROCEDURE 11)".

    //procedure CreateLink();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TempContBusRel."Contact No." := "Company No.";
        TempContBusRel."Business Relation Code" := BusRelCode;
        TempContBusRel."Link to Table" := Table;
        TempContBusRel.INSERT;
        PAGE.RUNMODAL(CreateForm,TempContBusRel);
        TempContBusRel.DELETEALL;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        IF PAGE.RUNMODAL(CreateForm,TempContBusRel) = ACTION::LookupOK THEN; // enforce look up mode dialog
        TempContBusRel.DELETEALL;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: TempSegmentLine) (VariableCollection) on "CreateInteraction(PROCEDURE 10)".



    //Unsupported feature: Code Modification on "CreateInteraction(PROCEDURE 10)".

    //procedure CreateInteraction();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SegmentLine.CreateInteractionFromContact(Rec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TempSegmentLine.CreateInteractionFromContact(Rec);
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "NameBreakdown(PROCEDURE 13)".



    //Unsupported feature: Code Modification on "NameBreakdown(PROCEDURE 13)".

    //procedure NameBreakdown();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Type = Type::Company THEN
          EXIT;

        #4..15
        "First Name" := '';
        "Middle Name" := '';
        Surname := '';
        FOR i := 1 TO NoOfParts DO BEGIN
          IF (i = NoOfParts) AND (NoOfParts > 1) THEN BEGIN
            IF STRLEN(NamePart[i]) > MAXSTRLEN(Surname) THEN
              ERROR(Text032,FIELDCAPTION(Surname),STRLEN(NamePart[i]) - MAXSTRLEN(Surname));
        #23..31
                ERROR(Text032,FIELDCAPTION("First Name"),STRLEN(FirstName250) - MAXSTRLEN("First Name"));
              "First Name" := FirstName250;
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..18
        FOR i := 1 TO NoOfParts DO
        #20..34
        */
    //end;


    //Unsupported feature: Code Modification on "SetSkipDefault(PROCEDURE 15)".

    //procedure SetSkipDefault();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SkipDefaults := NOT Defaults;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SkipDefaults := TRUE;
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "CalculatedName(PROCEDURE 14)".


    //Unsupported feature: Property Insertion (Local) on "UpdateSearchName(PROCEDURE 22)".


    //Unsupported feature: Variable Insertion (Variable: Contact) (VariableCollection) on "CheckForExistingRelationships(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Name) on "AddText(PROCEDURE 20)".


    //Unsupported feature: Property Insertion (Local) on "AddText(PROCEDURE 20)".



    //Unsupported feature: Code Modification on "AddText(PROCEDURE 20)".

    //procedure AddText();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Text <> '' THEN
          EXIT(Text + ' ');
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TESTFIELD("Company No.");
        IF Type = Type::Company THEN
          Contact := Rec
        ELSE
          IF NOT Contact.GET("Company No.") THEN
            EXIT;

        IF "No." <> '' THEN BEGIN
          ContBusRel.SETRANGE("Contact No.",Contact."No.");
          ContBusRel.SETRANGE("Link to Table",LinkToTable);
          IF ContBusRel.FINDFIRST THEN
            ERROR(
              Text034Err,
              Contact.TABLECAPTION,"No.",ContBusRel.TABLECAPTION,LinkToTable,ContBusRel."No.");

          ContBusRel.RESET;
          ContBusRel.SETCURRENTKEY("Link to Table","No.");
          ContBusRel.SETRANGE("Link to Table",LinkToTable);
          ContBusRel.SETRANGE("No.","No.");
          IF ContBusRel.FINDFIRST THEN
            ERROR(
              Text034Err,
              LinkToTable,"No.",TABLECAPTION,Contact.TABLECAPTION,ContBusRel."Contact No.");
        END;
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "CheckDupl(PROCEDURE 21)".


    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "FindCustomerTemplate(PROCEDURE 23)".


    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "ChooseCustomerTemplate(PROCEDURE 27)".



    //Unsupported feature: Code Modification on "ChooseCustomerTemplate(PROCEDURE 27)".

    //procedure ChooseCustomerTemplate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ContBusRel.RESET;
        ContBusRel.SETRANGE("Contact No.","No.");
        ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Customer);
        #4..11

          ERROR(Text022);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CheckForExistingRelationships(ContBusRel."Link to Table"::Customer);
        #1..14
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "UpdateQuotes(PROCEDURE 29)".



    //Unsupported feature: Code Modification on "InheritCompanyToPersonData(PROCEDURE 24)".

    //procedure InheritCompanyToPersonData();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Company Name" := Cont.Name;

        RMSetup.GET;
        IF RMSetup."Inherit Salesperson Code" THEN
          "Salesperson Code" := Cont."Salesperson Code";
        IF RMSetup."Inherit Territory Code" THEN
          "Territory Code" := Cont."Territory Code";
        IF RMSetup."Inherit Country/Region Code" THEN
          "Country/Region Code" := Cont."Country/Region Code";
        IF RMSetup."Inherit Language Code" THEN
          "Language Code" := Cont."Language Code";
        IF RMSetup."Inherit Address Details" AND
           ((NOT KeepPersonalData) OR
            (Cont.Address + Cont."Address 2" + Cont.County + Cont."Post Code" + Cont.City <> ''))
        THEN BEGIN
          Address := Cont.Address;
          "Address 2" := Cont."Address 2";
          "Post Code" := Cont."Post Code";
          City := Cont.City;
          County := Cont.County;
        END;
        IF RMSetup."Inherit Communication Details" THEN BEGIN
          IF (Cont."Phone No." <> '') OR NOT KeepPersonalData THEN
            "Phone No." := Cont."Phone No.";
          IF (Cont."Telex No." <> '') OR NOT KeepPersonalData THEN
            "Telex No." := Cont."Telex No.";
          IF (Cont."Fax No." <> '') OR NOT KeepPersonalData THEN
            "Fax No." := Cont."Fax No.";
          IF (Cont."Telex Answer Back" <> '') OR NOT KeepPersonalData THEN
            "Telex Answer Back" := Cont."Telex Answer Back";
          IF (Cont."E-Mail" <> '') OR NOT KeepPersonalData THEN
            VALIDATE("E-Mail",Cont."E-Mail");
          IF (Cont."Home Page" <> '') OR NOT KeepPersonalData THEN
            "Home Page" := Cont."Home Page";
          IF (Cont."Extension No." <> '') OR NOT KeepPersonalData THEN
            "Extension No." := Cont."Extension No.";
          IF (Cont."Mobile Phone No." <> '') OR NOT KeepPersonalData THEN
            "Mobile Phone No." := Cont."Mobile Phone No.";
          IF (Cont.Pager <> '') OR NOT KeepPersonalData THEN
            Pager := Cont.Pager;
          IF (Cont."Correspondence Type" <> "Correspondence Type"::" ") OR NOT KeepPersonalData THEN
            "Correspondence Type" := Cont."Correspondence Type";
        END;
        CALCFIELDS("No. of Industry Groups","No. of Business Relations");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        "Company Name" := NewCompanyContact.Name;
        #2..4
          "Salesperson Code" := NewCompanyContact."Salesperson Code";
        IF RMSetup."Inherit Territory Code" THEN
          "Territory Code" := NewCompanyContact."Territory Code";
        IF RMSetup."Inherit Country/Region Code" THEN
          "Country/Region Code" := NewCompanyContact."Country/Region Code";
        IF RMSetup."Inherit Language Code" THEN
          "Language Code" := NewCompanyContact."Language Code";
        IF RMSetup."Inherit Address Details" AND StaleAddress THEN BEGIN
          Address := NewCompanyContact.Address;
          "Address 2" := NewCompanyContact."Address 2";
          "Post Code" := NewCompanyContact."Post Code";
          City := NewCompanyContact.City;
          County := NewCompanyContact.County;
        END;
        IF RMSetup."Inherit Communication Details" THEN BEGIN
          UpdateFieldForNewCompany(FIELDNO("Phone No."));
          UpdateFieldForNewCompany(FIELDNO("Telex No."));
          UpdateFieldForNewCompany(FIELDNO("Fax No."));
          UpdateFieldForNewCompany(FIELDNO("Telex Answer Back"));
          UpdateFieldForNewCompany(FIELDNO("E-Mail"));
          UpdateFieldForNewCompany(FIELDNO("Home Page"));
          UpdateFieldForNewCompany(FIELDNO("Extension No."));
          UpdateFieldForNewCompany(FIELDNO("Mobile Phone No."));
          UpdateFieldForNewCompany(FIELDNO(Pager));
          UpdateFieldForNewCompany(FIELDNO("Correspondence Type"));
        END;
        CALCFIELDS("No. of Industry Groups","No. of Business Relations");
        */
    //end;

    //Unsupported feature: Property Insertion (Local) on "ProcessNameChange(PROCEDURE 37)".


    procedure GetDefaultPhoneNo(): Text[30]
    var
        ClientTypeManagement: Codeunit "4";
    begin
        IF ClientTypeManagement.IsClientType(CLIENTTYPE::Phone) THEN BEGIN
          IF "Mobile Phone No." = '' THEN
            EXIT("Phone No.");
          EXIT("Mobile Phone No.");
        END;
        IF "Phone No." = '' THEN
          EXIT("Mobile Phone No.");
        EXIT("Phone No.");
    end;

    local procedure StaleAddress() Stale: Boolean
    var
        OldCompanyContact: Record "5050";
        DummyContact: Record "5050";
    begin
        IF OldCompanyContact.GET(xRec."Company No.") THEN
          Stale := IdenticalAddress(OldCompanyContact);
        Stale := Stale OR IdenticalAddress(DummyContact);
    end;

    local procedure UpdateFieldForNewCompany(FieldNo: Integer)
    var
        OldCompanyContact: Record "5050";
        NewCompanyContact: Record "5050";
        OldCompanyRecRef: RecordRef;
        NewCompanyRecRef: RecordRef;
        ContactRecRef: RecordRef;
        ContactFieldRef: FieldRef;
        OldCompanyFieldValue: Text;
        ContactFieldValue: Text;
        Stale: Boolean;
    begin
        ContactRecRef.GETTABLE(Rec);
        ContactFieldRef := ContactRecRef.FIELD(FieldNo);
        ContactFieldValue := FORMAT(ContactFieldRef.VALUE);

        IF NewCompanyContact.GET("Company No.") THEN BEGIN
          NewCompanyRecRef.GETTABLE(NewCompanyContact);
          IF OldCompanyContact.GET(xRec."Company No.") THEN BEGIN
            OldCompanyRecRef.GETTABLE(OldCompanyContact);
            OldCompanyFieldValue := FORMAT(OldCompanyRecRef.FIELD(FieldNo).VALUE);
            Stale := ContactFieldValue = OldCompanyFieldValue;
          END;
          IF Stale OR (ContactFieldValue = '') THEN BEGIN
            ContactFieldRef.VALIDATE(NewCompanyRecRef.FIELD(FieldNo).VALUE);
            ContactRecRef.SETTABLE(Rec);
          END;
        END;
    end;

    local procedure GetCompNo(ContactText: Text): Text
    var
        Contact: Record "5050";
        ContactWithoutQuote: Text;
        ContactFilterFromStart: Text;
        ContactFilterContains: Text;
        ContactNo: Code[20];
    begin
        IF ContactText = '' THEN
          EXIT('');

        IF STRLEN(ContactText) <= MAXSTRLEN(Contact."Company No.") THEN
          IF Contact.GET(COPYSTR(ContactText,1,MAXSTRLEN(Contact."Company No."))) THEN
            EXIT(Contact."No.");

        ContactWithoutQuote := CONVERTSTR(ContactText,'''','?');

        Contact.SETRANGE(Type,Contact.Type::Company);

        Contact.SETFILTER(Name,'''@' + ContactWithoutQuote + '''');
        IF Contact.FINDFIRST THEN
          EXIT(Contact."No.");
        Contact.SETRANGE(Name);
        ContactFilterFromStart := '''@' + ContactWithoutQuote + '*''';
        Contact.FILTERGROUP := -1;
        Contact.SETFILTER("No.",ContactFilterFromStart);
        Contact.SETFILTER(Name,ContactFilterFromStart);
        IF Contact.FINDFIRST THEN
          EXIT(Contact."No.");
        ContactFilterContains := '''@*' + ContactWithoutQuote + '*''';
        Contact.SETFILTER("No.",ContactFilterContains);
        Contact.SETFILTER(Name,ContactFilterContains);
        Contact.SETFILTER(City,ContactFilterContains);
        Contact.SETFILTER("Phone No.",ContactFilterContains);
        Contact.SETFILTER("Post Code",ContactFilterContains);
        CASE Contact.COUNT OF
          1:
            BEGIN
              Contact.FINDFIRST;
              EXIT(Contact."No.");
            END;
          ELSE BEGIN
            IF NOT GUIALLOWED THEN
              ERROR(SelectContactErr);
            ContactNo := SelectContact(Contact);
            IF ContactNo <> '' THEN
              EXIT(ContactNo);
          END;
        END;
        ERROR(SelectContactErr);
    end;

    local procedure SelectContact(var Contact: Record "5050"): Code[20]
    var
        ContactList: Page "5052";
    begin
        IF Contact.FINDSET THEN
          REPEAT
            Contact.MARK(TRUE);
          UNTIL Contact.NEXT = 0;
        IF Contact.FINDFIRST THEN;
        Contact.MARKEDONLY := TRUE;

        ContactList.SETTABLEVIEW(Contact);
        ContactList.SETRECORD(Contact);
        ContactList.LOOKUPMODE := TRUE;
        IF ContactList.RUNMODAL = ACTION::LookupOK THEN
          ContactList.GETRECORD(Contact)
        ELSE
          CLEAR(Contact);

        EXIT(Contact."No.");
    end;

    procedure LookupCompany()
    var
        Contact: Record "5050";
        CompanyDetails: Page "5054";
    begin
        Contact.SETRANGE("No.","Company No.");
        CompanyDetails.SETTABLEVIEW(Contact);
        CompanyDetails.SETRECORD(Contact);
        IF Type = Type::Person THEN
          CompanyDetails.EDITABLE := FALSE;
        CompanyDetails.RUNMODAL;
    end;

    local procedure SetLastDateTimeModified()
    var
        DateFilterCalc: Codeunit "358";
        UtcNow: DateTime;
    begin
        UtcNow := DateFilterCalc.ConvertToUtcDateTime(CURRENTDATETIME);
        "Last Date Modified" := DT2DATE(UtcNow);
        "Last Time Modified" := DT2TIME(UtcNow);
    end;

    procedure CreateSalesQuoteFromContact()
    var
        SalesHeader: Record "36";
    begin
        SalesHeader.INIT;
        SalesHeader.VALIDATE("Document Type",SalesHeader."Document Type"::Quote);
        SalesHeader.INSERT(TRUE);
        SalesHeader.VALIDATE("Document Date",WORKDATE);
        SalesHeader.VALIDATE("Sell-to Contact No.","No.");
        SalesHeader.MODIFY(TRUE);
        COMMIT;
        PAGE.RUNMODAL(PAGE::"Sales Quote",SalesHeader);
    end;

    procedure ContactToCustBusinessRelationExist(): Boolean
    var
        ContBusRel: Record "5054";
    begin
        ContBusRel.RESET;
        ContBusRel.SETRANGE("Contact No.","No.");
        ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Customer);
        EXIT(NOT ContBusRel.ISEMPTY);
    end;

    procedure SetLastDateTimeFilter(DateFilter: DateTime)
    var
        DateFilterCalc: Codeunit "358";
        SyncDateTimeUtc: DateTime;
        CurrentFilterGroup: Integer;
    begin
        SyncDateTimeUtc := DateFilterCalc.ConvertToUtcDateTime(DateFilter);
        CurrentFilterGroup := FILTERGROUP;
        SETFILTER("Last Date Modified",'>=%1',DT2DATE(SyncDateTimeUtc));
        FILTERGROUP(-1);
        SETFILTER("Last Date Modified",'>%1',DT2DATE(SyncDateTimeUtc));
        SETFILTER("Last Time Modified",'>%1',DT2TIME(SyncDateTimeUtc));
        FILTERGROUP(CurrentFilterGroup);
    end;

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: Brick)".


    //Unsupported feature: Deletion (VariableCollection) on "CreateInteraction(PROCEDURE 10).SegmentLine(Variable 1000)".


    //Unsupported feature: Move on "ShowCustVendBank(PROCEDURE 12).Cust(Variable 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "SetSkipDefault(PROCEDURE 15).Defaults(Parameter 1000)".


    //Unsupported feature: Property Modification (Name) on "AddText(PROCEDURE 20).Text(Parameter 1000)".


    //Unsupported feature: Property Deletion (Length) on "AddText(PROCEDURE 20).Text(Parameter 1000)".


    //Unsupported feature: Property Modification (Data type) on "AddText(PROCEDURE 20).Text(Parameter 1000)".


    //Unsupported feature: Property Insertion (OptionString) on "AddText(PROCEDURE 20).Text(Parameter 1000)".


    //Unsupported feature: Deletion (ReturnValueCollection) on "FindCustomerTemplate(PROCEDURE 23).FindCustTemplate(ReturnValue 1001)".


    //Unsupported feature: Deletion (ReturnValueCollection) on "ChooseCustomerTemplate(PROCEDURE 27).ChooseCustTemplate(ReturnValue 1001)".


    //Unsupported feature: Property Modification (Name) on "InheritCompanyToPersonData(PROCEDURE 24).Cont(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "InheritCompanyToPersonData(PROCEDURE 24).KeepPersonalData(Parameter 1001)".


    var
        VATRegistrationLogMgt: Codeunit "249";

    var
        VATRegistrationLogMgt: Codeunit "249";


    //Unsupported feature: Property Modification (Id) on "HideValidationDialog(Variable 1032)".

    //var
        //>>>> ORIGINAL VALUE:
        //HideValidationDialog : 1032;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //HideValidationDialog : 1025;
        //Variable type has not been exported.

    var
        SelectContactErr: Label 'You must select an existing contact.';
        Text034Err: Label '%1 %2 already has a %3 with %4 %5.', Comment='%1=Contact table caption;%2=Contact number;%3=Contact Business Relation table caption;%4=Contact Business Relation Link to Table value;%5=Contact Business Relation number';
}

