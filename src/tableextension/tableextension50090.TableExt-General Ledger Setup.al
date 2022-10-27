tableextension 50090 tableextension50090 extends "General Ledger Setup"
{
    // <changelog>
    //   <add id="FR0001" dev="EDUBUC" date="2004-08-19" area="ADDRFORMAT"  request="FR-START-40"
    //     releaseversion="FR4.00">Misc : New local address format option</add>
    //   <add id="FR0002" dev="KCOOLS" date="2006-05-18" area="FISCYEAR" feature="PS17000"
    //     releaseversion="FR4.00.03">Fiscal Year Closing</add>
    //   <change id="FR0003" dev="KCOOLS" date="2007-09-07" area="FISCYEAR" feature="PSCORS1898"
    //     baseversion="FR4.00.03" releaseversion="FR6.00">Fiscal Year Closing Update</change>
    //   <add id="FR0004" dev="KCOOLS" date="2008-06-18" area="PAYMNG" feature="NAVCORS25527"
    //     releaseversion="FR6.00">Delayed Unrealized VAT</add>
    //   <add id="FR0005" dev="ALL-E" date="2011-02-15" area="SEPA" feature="VSTF254101"
    //     releaseversion="FR7.00">Changes needed to support SEPA CT</add>
    // </changelog>
    // 
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    //           - Add fields 80800, 80810, 80811, 80820 and 80840
    // ------------------------------------------------------------------------
    // 
    // //CATALOG_FOURN LD 09.02.2007 DEEE1.00
    //           - Add field 80841
    fields
    {

        //Unsupported feature: Property Modification (CalcFormula) on ""Cust. Balances Due"(Field 44)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Vendor Balances Due"(Field 45)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Bank Account Nos."(Field 63)".


        //Unsupported feature: Property Modification (InitValue) on ""Amount Rounding Precision"(Field 73)".


        //Unsupported feature: Property Modification (InitValue) on ""Unit-Amount Rounding Precision"(Field 74)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shortcut Dimension 3 Code"(Field 83)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shortcut Dimension 4 Code"(Field 84)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shortcut Dimension 5 Code"(Field 85)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shortcut Dimension 6 Code"(Field 86)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shortcut Dimension 7 Code"(Field 87)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shortcut Dimension 8 Code"(Field 88)".

        modify("Payroll Trans. Import Format")
        {
            TableRelation = "Data Exch. Def" WHERE (Type = CONST (Payroll Import));
            Caption = 'Payroll Trans. Import Format';
        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Posting Allowed To"(Field 10801)".



        //Unsupported feature: Code Insertion on ""LCY Code"(Field 71)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //var
        //Currency: Record "4";
        //begin
        /*
        IF "Local Currency Symbol" = '' THEN
          "Local Currency Symbol" := Currency.ResolveCurrencySymbol("LCY Code");
        */
        //end;


        //Unsupported feature: Code Modification on ""Shortcut Dimension 3 Code"(Field 83).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Dim.CheckIfDimUsed("Shortcut Dimension 3 Code",3,'','',0) THEN
          ERROR(Text023,Dim.GetCheckDimErr);
        MODIFY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdateDimValueGlobalDimNo(xRec."Shortcut Dimension 3 Code","Shortcut Dimension 3 Code",3);
        */
        //end;


        //Unsupported feature: Code Modification on ""Shortcut Dimension 4 Code"(Field 84).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Dim.CheckIfDimUsed("Shortcut Dimension 4 Code",4,'','',0) THEN
          ERROR(Text023,Dim.GetCheckDimErr);
        MODIFY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdateDimValueGlobalDimNo(xRec."Shortcut Dimension 4 Code","Shortcut Dimension 4 Code",4);
        */
        //end;


        //Unsupported feature: Code Modification on ""Shortcut Dimension 5 Code"(Field 85).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Dim.CheckIfDimUsed("Shortcut Dimension 5 Code",5,'','',0) THEN
          ERROR(Text023,Dim.GetCheckDimErr);
        MODIFY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdateDimValueGlobalDimNo(xRec."Shortcut Dimension 5 Code","Shortcut Dimension 5 Code",5);
        */
        //end;


        //Unsupported feature: Code Modification on ""Shortcut Dimension 6 Code"(Field 86).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Dim.CheckIfDimUsed("Shortcut Dimension 6 Code",6,'','',0) THEN
          ERROR(Text023,Dim.GetCheckDimErr);
        MODIFY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdateDimValueGlobalDimNo(xRec."Shortcut Dimension 6 Code","Shortcut Dimension 6 Code",6);
        */
        //end;


        //Unsupported feature: Code Modification on ""Shortcut Dimension 7 Code"(Field 87).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Dim.CheckIfDimUsed("Shortcut Dimension 7 Code",7,'','',0) THEN
          ERROR(Text023,Dim.GetCheckDimErr);
        MODIFY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdateDimValueGlobalDimNo(xRec."Shortcut Dimension 7 Code","Shortcut Dimension 7 Code",7);
        */
        //end;


        //Unsupported feature: Code Modification on ""Shortcut Dimension 8 Code"(Field 88).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Dim.CheckIfDimUsed("Shortcut Dimension 8 Code",8,'','',0) THEN
          ERROR(Text023,Dim.GetCheckDimErr);
        MODIFY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdateDimValueGlobalDimNo(xRec."Shortcut Dimension 8 Code","Shortcut Dimension 8 Code",8);
        */
        //end;


        //Unsupported feature: Code Modification on ""Prepayment Unrealized VAT"(Field 151).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Unrealized VAT" AND xRec."Prepayment Unrealized VAT" THEN
          ERROR(Text024,FIELDCAPTION("Prepayment Unrealized VAT"),FIELDCAPTION("Unrealized VAT"));

        IF NOT "Prepayment Unrealized VAT" THEN BEGIN
          VATPostingSetup.SETFILTER(
        #6..16
              TaxJurisdiction.Code,TaxJurisdiction.FIELDCAPTION("Unrealized VAT Type"),
              TaxJurisdiction."Unrealized VAT Type");
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Unrealized VAT" AND xRec."Prepayment Unrealized VAT" THEN
          ERROR(DependentFieldActivatedErr,FIELDCAPTION("Prepayment Unrealized VAT"),FIELDCAPTION("Unrealized VAT"));
        #3..19
        */
        //end;
        field(110; "Acc. Sched. for Balance Sheet"; Code[10])
        {
            Caption = 'Acc. Sched. for Balance Sheet';
            TableRelation = "Acc. Schedule Name";
        }
        field(111; "Acc. Sched. for Income Stmt."; Code[10])
        {
            Caption = 'Acc. Sched. for Income Stmt.';
            TableRelation = "Acc. Schedule Name";
        }
        field(112; "Acc. Sched. for Cash Flow Stmt"; Code[10])
        {
            Caption = 'Acc. Sched. for Cash Flow Stmt';
            TableRelation = "Acc. Schedule Name";
        }
        field(113; "Acc. Sched. for Retained Earn."; Code[10])
        {
            Caption = 'Acc. Sched. for Retained Earn.';
            TableRelation = "Acc. Schedule Name";
        }
        field(161; "VAT Reg. No. Validation URL"; Text[250])
        {
            Caption = 'VAT Reg. No. Validation URL';
        }
        field(162; "Local Currency Symbol"; Text[10])
        {
            Caption = 'Local Currency Symbol';
        }
        field(80800; "DEEE Management"; Boolean)
        {
            Caption = 'DEEE Management';
            Description = 'DEEE1.00';
        }
        field(80810; "DEEE Sales line prefix"; Text[30])
        {
            Caption = 'DEEE Sales line prefix';
            Description = 'DEEE1.00';
        }
        field(80811; "DEEE Purchases line prefix"; Text[30])
        {
            Caption = 'DEEE Purchases line prefix';
            Description = 'DEEE1.00';
        }
        field(80820; "Sales Tax Recalcul"; Boolean)
        {
            Caption = 'Sales Tax Recalcul';
            Description = 'DEEE1.00';
        }
        field(80840; "DEEE Business Group ID"; Code[10])
        {
            Caption = 'DEEE Business Group ID';
            Description = 'DEEE1.00';
            TableRelation = "Gen. Business Posting Group".Code;
        }
        field(80841; "Defaut Eco partner DEEE"; Code[20])
        {
            Caption = 'Defaut Eco partnaire';
            Description = 'DEEE1.00';
            TableRelation = Vendor;
        }
    }

    //Unsupported feature: Property Insertion (Local) on "RoundingErrorCheck(PROCEDURE 2)".


    //Unsupported feature: Property Insertion (Local) on "DeleteIntrastatJnl(PROCEDURE 3)".


    //Unsupported feature: Property Insertion (Local) on "DeleteAnalysisView(PROCEDURE 33)".


    procedure GetCurrencySymbol(): Text[10]
    begin
        IF "Local Currency Symbol" <> '' THEN
            EXIT("Local Currency Symbol");

        EXIT("LCY Code");
    end;

    procedure UpdateDimValueGlobalDimNo(xDimCode: Code[20]; DimCode: Code[20]; ShortcutDimNo: Integer)
    var
        DimensionValue: Record "349";
    begin
        IF Dim.CheckIfDimUsed(DimCode, ShortcutDimNo, '', '', 0) THEN
            ERROR(Text023, Dim.GetCheckDimErr);
        IF xDimCode <> '' THEN BEGIN
            DimensionValue.SETRANGE("Dimension Code", xDimCode);
            DimensionValue.MODIFYALL("Global Dimension No.", 0);
        END;
        IF DimCode <> '' THEN BEGIN
            DimensionValue.SETRANGE("Dimension Code", DimCode);
            DimensionValue.MODIFYALL("Global Dimension No.", ShortcutDimNo);
        END;
        MODIFY;
    end;


    //Unsupported feature: Property Modification (Id) on "AdjAddReportingCurr(Variable 1031)".

    //var
    //>>>> ORIGINAL VALUE:
    //AdjAddReportingCurr : 1031;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AdjAddReportingCurr : 1005;
    //Variable type has not been exported.

    var
        DependentFieldActivatedErr: Label 'You cannot change %1 because %2 is selected.';
}

