table 50005 "BC6_Temporary import catalogue"
{
    //   TODO: Page 
    // LookupPageID = 50023;

    fields
    {
        field(1; "key"; Integer)
        {
            Caption = 'key';
        }
        field(2; Ref_externe; Code[20])
        {
            Caption = 'External Ref.';
        }
        field(3; Ref_Interne; Code[20])
        {
            Caption = 'Internal Ref.';

            trigger OnValidate()
            begin
                //>> 05.01.2011
                IF (Ref_Interne <> '') THEN BEGIN
                    CLEAR(DistInt);
                    "Item BarCode" := DistInt.GetItemEAN13Code(Ref_Interne);
                END ELSE BEGIN
                    "Item BarCode" := '';
                END;
                VALIDATE("Item BarCode");
            end;
        }
        field(4; designation; Text[250])
        {
            Caption = 'Description';
        }
        field(5; Prix_public; Decimal)
        {
            Caption = 'Public Price';
            DecimalPlaces = 0 : 5;
        }
        field(6; famille; Code[10])
        {
            Caption = 'Item Disc. Group';
        }
        field(7; remise; Decimal)
        {
            Caption = 'Rebate';
            DecimalPlaces = 0 : 5;
        }
        field(8; prix_net; Decimal)
        {
            Caption = 'Purch. Price';
            DecimalPlaces = 0 : 5;
        }
        field(9; "date debut"; Date)
        {
            Caption = 'Starting date';
        }
        field(10; "date fin"; Date)
        {
            Caption = 'Ending date';
        }
        field(11; Vendor; Code[20])
        {
            Caption = 'Vendor';
            TableRelation = Vendor;
        }
        field(13; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(14; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(15; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
        }
        field(16; BarCode; Code[30])
        {
            Caption = 'Bar Code';

            trigger OnValidate()
            begin

                ReplaceItemBarCode();
            end;
        }
        field(17; "DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code ';
            Description = 'DEEE1.00';
            TableRelation = "Categories of item".Category;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                LRecDEEECategory: Record 50006;
            begin
            end;
        }
        field(18; "Number of Units DEEE"; Decimal)
        {
            Caption = 'Number of Units DEEE';
            Description = 'DEEE1.00';
        }
        field(19; "DEEE Unit Amount"; Decimal)
        {
            Caption = 'DEEE Unit Amount';
            DecimalPlaces = 0 : 2;
            Description = 'DEEE1.00';
        }
        field(30; "Item BarCode"; Code[20])
        {
            Caption = 'Item BarCode';
            Editable = false;

            trigger OnValidate()
            begin
                //>> 05.01.2011
                ReplaceItemBarCode();
            end;
        }
        field(31; "Replace Item BarCode"; Boolean)
        {
            Caption = 'Replace Item BarCode';
        }
        field(50000; "Emplacement par défaut"; Code[20])
        {
            CalcFormula = Lookup("Bin Content"."Bin Code" WHERE(Default = CONST(true),
                                                                 "Item No." = FIELD(Ref_Interne)));
            FieldClass = FlowField;
        }
        field(50001; Stocks; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No".=FIELD(Ref_Interne)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"key",Ref_externe,Ref_Interne,Vendor)
        {
            Clustered = true;
        }
        key(Key2;Ref_Interne)
        {
        }
    }

    fieldgroups
    {
    }

    var
        recgItem: Record 27;
        RecGDiscount: Record 7014;
        RecGPurchPrice: Record 7012;
        RecGItemCrossRef: Record 5717;
        Txt001: Label 'The fields external Reference and Public price should not be empty ';
        Txt002: Label 'Finished treatment';
        "---DEEE1.00---": Integer;
        DEEETariffs: Record 50007;
        GeneralLedgerSetup: Record 98;
        CategoriesOfItem: Record 50006;
        Textg001: Label 'No DEEE category matching for item %1';
        Textg002: Label '%1 %2 created.';
        DistInt: Codeunit 5702;

  
    procedure importdata()
    var
        IntLCounter: Integer;
        i: Integer;
        DiaLWindow: Dialog;
    begin
        FINDFIRST;
        GeneralLedgerSetup.GET;
        IF GeneralLedgerSetup."DEEE Management" THEN
          GeneralLedgerSetup.TESTFIELD("Defaut Eco partner DEEE");
        
        //>>MICO point68
        IntLCounter := COUNT;
        i := 0;
        
        DiaLWindow.OPEN('Import @1@@@@@@@@@@');
        //<<MICO point68
        
        REPEAT
          //>>MICO point68
          i := i + 1;
          DiaLWindow.UPDATE(1,ROUND(i/IntLCounter * 10000,1)) ;
          //<<MICO
        
          TESTFIELD(Ref_externe);
          TESTFIELD(Prix_public);
          TESTFIELD(Vendor);
          TESTFIELD("date debut");
        
          IF Ref_Interne <> '' THEN
          BEGIN
            create_disc_familly;
            IF NOT recgItem.GET(Ref_Interne) THEN
            BEGIN
              recgItem.INIT;
              recgItem.VALIDATE("No." , Ref_Interne);
              recgItem.VALIDATE("Vendor No." , Vendor);
              recgItem.VALIDATE("Vendor Item No." , Ref_externe);
              recgItem.VALIDATE("Item Category Code","Item Category Code");
              recgItem.VALIDATE("Product Group Code" ,"Product Group Code");
               recgItem.VALIDATE(Description,COPYSTR(designation,1,MAXSTRLEN(recgItem.Description)));
              recgItem.VALIDATE("Item Disc. Group",famille);
              recgItem.VALIDATE(recgItem."Unit Price", Prix_public);
              IF "Net Weight" <> 0 THEN
                recgItem.VALIDATE("Net Weight","Net Weight");
                IF ("Number of Units DEEE" <> 0) THEN //AND ("DEEE Category Code" <> '') THEN
                InsertDEEE;
              recgItem.INSERT(TRUE);
        
              recgItem.VALIDATE("Number of Units DEEE" , Rec."Number of Units DEEE");
              recgItem.MODIFY(TRUE) ;
            insertlongdescription;
              //<<Item import FLGR FE06.V2 NSC1.01 : For long description
        
              //<<TODOLIST point 62
              insertitemcrossref;
            END
            ELSE
            BEGIN
              recgItem.Blocked := FALSE;
              recgItem.VALIDATE("Vendor No." , Vendor);
              recgItem.VALIDATE("Vendor Item No." ,Ref_externe);
              recgItem.VALIDATE("Item Category Code","Item Category Code");
              recgItem.VALIDATE(Description,COPYSTR(designation,1,MAXSTRLEN(recgItem.Description)));
              IF famille <> '' THEN
                recgItem.VALIDATE("Item Disc. Group" , famille);
              recgItem.VALIDATE(recgItem."Unit Price", Prix_public);
              recgItem.VALIDATE("Item Category Code","Item Category Code");
              recgItem.VALIDATE("Item Disc. Group",famille);
              recgItem.VALIDATE(recgItem."Net Weight","Net Weight");
            IF ("Number of Units DEEE" <> 0) THEN  InsertDEEE;
               recgItem.VALIDATE("Number of Units DEEE" , Rec."Number of Units DEEE");
              recgItem.MODIFY(TRUE) ;
               recgItem.MODIFY(TRUE);
              insertlongdescription;
                insertitemcrossref;
            END;
        
            IF remise <>0 THEN
            InsertDiscount;
            IF prix_net <> 0 THEN
              //>>POINT 56 08/02/2007
              InsertpurchPrice;
          END;
        UNTIL NEXT = 0;
        
        //>>MICO point 68
        DiaLWindow.CLOSE ;
        //<<MICO
        
        //>>Item import CASC 18/01/2007 FE06.V2 NSC1.01
        MESSAGE(Txt002);
        //<<Item import CASC 18/01/2007 FE06.V2 NSC1.01

    end;

  
    procedure create_disc_familly()
    var
        RecLItemDiscGrp: Record "341";
    begin
        IF NOT RecLItemDiscGrp.GET(famille) THEN
        BEGIN
          RecLItemDiscGrp.INIT;
          RecLItemDiscGrp.Code := famille;
          RecLItemDiscGrp.INSERT(TRUE);
        END;
    end;

  
    procedure insertitemcrossref()
    begin
        RecGItemCrossRef.RESET;
        RecGItemCrossRef.SETFILTER("Item No.", recgItem."No.");
        RecGItemCrossRef.SETFILTER("Cross-Reference Type", '%1', RecGItemCrossRef."Cross-Reference Type"::Vendor);
        RecGItemCrossRef.SETFILTER("Cross-Reference Type No.", recgItem."Vendor No.");
        //>>TDL.76
        //IF RecGItemCrossRef.FIND('-') THEN
        IF NOT RecGItemCrossRef.ISEMPTY THEN
        //<<TDL.76
          RecGItemCrossRef.DELETEALL;

        RecGItemCrossRef.INIT;
        RecGItemCrossRef.VALIDATE("Item No.", recgItem."No.");
        RecGItemCrossRef.VALIDATE("Unit of Measure", recgItem."Base Unit of Measure");
        RecGItemCrossRef.VALIDATE(Description, recgItem.Description);
        RecGItemCrossRef.VALIDATE("Cross-Reference Type", RecGItemCrossRef."Cross-Reference Type"::Vendor);
        RecGItemCrossRef.VALIDATE("Cross-Reference Type No.", recgItem."Vendor No.");
        RecGItemCrossRef.VALIDATE("Cross-Reference No.", recgItem."Vendor Item No.");
        RecGItemCrossRef.INSERT(TRUE);

        //>>Item import FLGR 24/01/2007 FE06.V2 NSC1.01

        //>> A:FE02 Begin
        IF (BarCode <> '') THEN
          BEGIN
            RecGItemCrossRef.RESET;
            RecGItemCrossRef.SETFILTER("Item No.", recgItem."No.");
            RecGItemCrossRef.SETFILTER("Unit of Measure", recgItem."Base Unit of Measure");
            RecGItemCrossRef.SETFILTER("Cross-Reference Type",'%1',RecGItemCrossRef."Cross-Reference Type"::"Bar Code");
            // IF (BarCode = '') THEN
            // RecGItemCrossRef.SETRANGE("Internal Bar Code",FALSE);
            //>>TDL.76
            //IF RecGItemCrossRef.FIND('-') THEN
            IF NOT RecGItemCrossRef.ISEMPTY THEN
            //<<TDL.76
              RecGItemCrossRef.DELETEALL;

            RecGItemCrossRef.INIT;
            RecGItemCrossRef.VALIDATE("Item No.",recgItem."No.");
            RecGItemCrossRef.VALIDATE("Cross-Reference Type",RecGItemCrossRef."Cross-Reference Type"::"Bar Code");
            //>> CNE4.01 Begin Update EAN13 Code
            RecGItemCrossRef.VALIDATE("Cross-Reference Type No.",'EAN13');
            RecGItemCrossRef.VALIDATE("Cross-Reference No.",BarCode);
            //<< End
            RecGItemCrossRef.VALIDATE("Unit of Measure", recgItem."Base Unit of Measure");
            RecGItemCrossRef.VALIDATE(Description,recgItem.Description);
            RecGItemCrossRef.INSERT(TRUE);
        END;
        //<<Item import FLGR 24/01/2007 FE06.V2 NSC1.01
    end;

  
    procedure insertlongdescription()
    var
        RecLExtTextHeader: Record "279";
        RecLExtTextLine: Record "280";
        TxtLExtendedtext: Text[250];
        "--point55": Integer;
        intLstartpos: Integer;
        intlLineno: Integer;
    begin
        // =>Add End Of Description field In Extended Textes

        //>>TODOLIST point 55 FLGR 07/02/2007
        TxtLExtendedtext := COPYSTR(designation,MAXSTRLEN(recgItem.Description) + 1);
        // IF TxtLExtendedtext <> '' THEN BEGIN
          IF MAXSTRLEN(recgItem.Description) < STRLEN(designation) THEN BEGIN
        //<<TODOLIST point 55 FLGR 07/02/2007
          RecLExtTextHeader.SETFILTER("Table Name", '%1',RecLExtTextHeader."Table Name"::Item );
          RecLExtTextHeader.SETFILTER("No.", recgItem."No.");
          IF RecLExtTextHeader.FIND('-') THEN
            RecLExtTextHeader.DELETE(TRUE);
        //>>MODIFHL1.05
          recgItem."Automatic Ext. Texts" := TRUE;
          recgItem.MODIFY;
        //<<MODIFHL1.05
          RecLExtTextHeader.INIT;
          RecLExtTextLine.INIT;
          RecLExtTextHeader.VALIDATE("Table Name", RecLExtTextHeader."Table Name"::Item );
          RecLExtTextHeader.VALIDATE("No.", recgItem."No.");
          RecLExtTextHeader.VALIDATE("All Language Codes", TRUE);
          RecLExtTextHeader.VALIDATE("Sales Quote", TRUE);
          RecLExtTextHeader.VALIDATE("Sales Invoice", TRUE);
          RecLExtTextHeader.VALIDATE("Sales Order", TRUE);
          RecLExtTextHeader.VALIDATE("Sales Credit Memo", TRUE);
          RecLExtTextHeader.VALIDATE("Purchase Quote", TRUE);
          RecLExtTextHeader.VALIDATE("Purchase Invoice", TRUE);
          RecLExtTextHeader.VALIDATE("Purchase Order", TRUE);
          RecLExtTextHeader.VALIDATE("Purchase Credit Memo", TRUE);
          RecLExtTextHeader.VALIDATE(Reminder, TRUE);
          RecLExtTextHeader.VALIDATE("Finance Charge Memo", TRUE);
          RecLExtTextHeader.VALIDATE("Sales Blanket Order", TRUE);
          RecLExtTextHeader.VALIDATE("Purchase Blanket Order", TRUE);
          RecLExtTextHeader.VALIDATE("Service Order", TRUE);
          RecLExtTextHeader.VALIDATE("Service Quote", TRUE);
          RecLExtTextHeader.VALIDATE("Sales Return Order", TRUE);
          RecLExtTextHeader.VALIDATE("Purchase Return Order", TRUE);
          RecLExtTextHeader.INSERT(TRUE);
          //>>TODOLIST point 55 FLGR 07/02/2007
          intLstartpos := 1;
          REPEAT
            intlLineno += 10000;
          //<<TODOLIST point 55 FLGR 07/02/2007
            RecLExtTextLine.INIT;
            RecLExtTextLine.VALIDATE("Table Name", RecLExtTextHeader."Table Name");
            RecLExtTextLine.VALIDATE("No.", RecLExtTextHeader."No.");
            RecLExtTextLine.VALIDATE("Text No.",RecLExtTextHeader."Text No.");
            RecLExtTextLine.VALIDATE("Line No.",intlLineno);
            //>>TODOLIST point 55 FLGR 07/02/2007
            //RecLExtTextLine.VALIDATE(Text,TxtLExtendedtext);
            RecLExtTextLine.VALIDATE(Text, COPYSTR(TxtLExtendedtext,intLstartpos,MAXSTRLEN(RecLExtTextLine.Text)));
            //<<TODOLIST point 55 FLGR 07/02/2007
            RecLExtTextLine.INSERT(TRUE);
            //>>TODOLIST point 55 FLGR 07/02/2007
            intLstartpos += MAXSTRLEN(RecLExtTextLine.Text);
          UNTIL intLstartpos >= STRLEN(TxtLExtendedtext) ;
          //<<TODOLIST point 55 FLGR 07/02/2007
        END;
        //>>Item import CASC FE06.V2 NSC1.01 : For long description
    end;

  
    procedure InsertpurchPrice()
    begin
        RecGPurchPrice.RESET;
        //>>TDL.76
        RecGPurchPrice.SETCURRENTKEY("Item No.","Vendor No.","Currency Code");
        //<<TDL.76
        RecGPurchPrice.SETRANGE("Item No.",Ref_Interne);
        RecGPurchPrice.SETRANGE("Vendor No.",Vendor);
        RecGPurchPrice.SETFILTER("Currency Code", '%1', '');
        RecGPurchPrice.SETFILTER("Ending Date", '%1', 0D);
        //CLOSING all active purch price
        //>>TDL.76
        //IF RecGPurchPrice.FINDFIRST THEN
        IF NOT RecGPurchPrice.ISEMPTY THEN
          IF RecGPurchPrice.FINDSET(TRUE,FALSE) THEN
        //<<TDL.76
            REPEAT
              RecGPurchPrice.VALIDATE("Ending Date" , CALCDATE('<-1D>' , "date debut"));
              RecGPurchPrice.MODIFY(TRUE);
            UNTIL RecGPurchPrice.NEXT = 0;
        //creating new purch price
        RecGPurchPrice.INIT;
        RecGPurchPrice.VALIDATE("Item No.",Ref_Interne);
        RecGPurchPrice.VALIDATE("Direct Unit Cost" , prix_net) ;
        RecGPurchPrice.VALIDATE("Vendor No.",Vendor);
        RecGPurchPrice.VALIDATE("Starting Date","date debut");
        RecGPurchPrice.VALIDATE("Ending Date","date fin");
        RecGPurchPrice.INSERT(TRUE);
    end;

  
    procedure InsertDEEE()
    var
        reclitem: Record "27";
    begin
        //>>TODOLIST point 62
        IF GeneralLedgerSetup."DEEE Management" THEN BEGIN
          IF reclitem.GET(recgItem."No.") THEN BEGIN
            IF reclitem."Eco partner DEEE" = '' THEN
              recgItem.VALIDATE("Eco partner DEEE",GeneralLedgerSetup."Defaut Eco partner DEEE");
          END ELSE
            recgItem.VALIDATE("Eco partner DEEE",GeneralLedgerSetup."Defaut Eco partner DEEE");
        
          recgItem.VALIDATE("Number of Units DEEE" , Rec."Number of Units DEEE");
          IF ("DEEE Category Code" = '') THEN BEGIN
            IF "DEEE Unit Amount" <> 0 THEN BEGIN
              //search (based on "DEEE Unit Amount") for a category to affect
              DEEETariffs.RESET;
              DEEETariffs.SETRANGE(DEEETariffs."HT Unit Tax (LCY)","DEEE Unit Amount");
              DEEETariffs.SETRANGE(DEEETariffs."Eco Partner",recgItem."Eco partner DEEE");
              DEEETariffs.SETFILTER(DEEETariffs."Date beginning",'<= %1',"date debut");
              IF "date fin" <> 0D THEN
                DEEETariffs.SETFILTER(DEEETariffs."Date beginning",'<= %1',"date fin");
              IF DEEETariffs.FINDLAST THEN
              BEGIN
                recgItem.VALIDATE("DEEE Category Code" , DEEETariffs."DEEE Code");
              END
              ELSE
                ERROR(Textg001, recgItem."No.");
            END
            ELSE
                ERROR(Textg001, recgItem."No.");
          END
          ELSE BEGIN
            recgItem.VALIDATE("DEEE Category Code" , "DEEE Category Code");
          END;
        
        /*  IF "DEEE Category Code" <> '' THEN BEGIN
            IF NOT CategoriesOfItem.GET("DEEE Category Code",GeneralLedgerSetup."Defaut Eco partner DEEE") THEN BEGIN
              //create category if it doesn't exist
              CategoriesOfItem.INIT;
              CategoriesOfItem.Category := "DEEE Category Code";
              CategoriesOfItem."Eco Partner" := GeneralLedgerSetup."Defaut Eco partner DEEE";
              CategoriesOfItem."DEEE Product Group ID" := recgItem."Gen. Prod. Posting Group";
              CategoriesOfItem.INSERT(TRUE);
              MESSAGE(Textg002, FIELDCAPTION("DEEE Category Code") , "DEEE Category Code");
            END;
          END;
        */
        END;
        
        
        //<<TODOLIST point 62

    end;

  
    procedure InsertDiscount()
    begin
        RecGDiscount.RESET;
        //>>TDL.76
        RecGDiscount.SETCURRENTKEY("Item No.","Vendor No.",Type);
        //<<TDL.76
        RecGDiscount.SETFILTER(Type,'%1',RecGDiscount.Type::Item);
        RecGDiscount.SETFILTER(RecGDiscount."Ending Date",FORMAT(0D));
        RecGDiscount.SETRANGE("Item No.",Ref_Interne);
        RecGDiscount.SETRANGE("Vendor No.",Vendor);
        //>>TDL.76
        //IF RecGDiscount.FIND('-') THEN
        IF NOT RecGDiscount.ISEMPTY THEN
          IF RecGDiscount.FINDSET(TRUE,FALSE) THEN
        //<<TDL.76
            REPEAT
              RecGDiscount.VALIDATE("Ending Date" , CALCDATE('<-1D>' , "date debut"));
              RecGDiscount.MODIFY(TRUE);
            UNTIL RecGDiscount.NEXT = 0;
        RecGDiscount.INIT;
        RecGDiscount.VALIDATE(Type,RecGDiscount.Type::Item);
        RecGDiscount.VALIDATE("Item No.",Ref_Interne);
        RecGDiscount.VALIDATE("Vendor No.",Vendor);
        RecGDiscount.VALIDATE("Line Discount %",remise);
        RecGDiscount.VALIDATE("Starting Date","date debut");
        RecGDiscount.VALIDATE("Ending Date","date fin");
        RecGDiscount.INSERT(TRUE);
    end;

  
    procedure ReplaceItemBarCode()
    begin
        IF BarCode = '' THEN
          BEGIN
            "Replace Item BarCode" := FALSE;
            EXIT;
        END;

        "Replace Item BarCode" := (BarCode <> "Item BarCode");
    end;
}

