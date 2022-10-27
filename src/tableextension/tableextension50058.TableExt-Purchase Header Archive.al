tableextension 50058 tableextension50058 extends "Purchase Header Archive"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //NSC1.0 FG 04/12/06 Ajout Code Utilisateur systematiquement
    // //VERSIONNING FG 05/12/06 NSC1.01
    // //FE005 SEBC 08/01/2007 Add field
    //                         50021 Buy-from Fax No.
    // //Propagation CASC 18/01/2007 NSC1.01 : Add fields
    //                                          50003 Pay-to Vend. No.
    //                                          50020 From Sales Module
    // 
    // ------------------------------------------------------------------------
    LookupPageID = 5166;
    DrillDownPageID = 5166;
    fields
    {

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Order Date"(Field 19)".


        //Unsupported feature: Property Modification (CalcFormula) on "Comment(Field 46)".

        modify("Bal. Account No.")
        {
            TableRelation = IF (Bal. Account Type=CONST(G/L Account)) "G/L Account"
                            ELSE IF (Bal. Account Type=CONST(Bank Account)) "Bank Account";
        }

        //Unsupported feature: Property Modification (CalcFormula) on "Amount(Field 60)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Amount Including VAT"(Field 61)".

        modify(Status)
        {
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';

            //Unsupported feature: Property Modification (OptionString) on "Status(Field 120)".

        }

        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Archived Versions"(Field 145)".

        modify("Purchase Quote No.")
        {
            TableRelation = "Purchase Header".No. WHERE (Document Type=CONST(Quote),
                                                         No.=FIELD(Purchase Quote No.));
        }
        modify("Archived By")
        {
            TableRelation = User."User Name";

            //Unsupported feature: Property Insertion (TestTableRelation) on ""Archived By"(Field 5046)".


            //Unsupported feature: Property Insertion (Editable) on ""Archived By"(Field 5046)".

        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Completely Received"(Field 5752)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Requested Receipt Date"(Field 5790)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Lead Time Calculation"(Field 5792)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Inbound Whse. Handling Time"(Field 5793)".



        //Unsupported feature: Code Insertion on ""Archived By"(Field 5046)".

        //trigger OnLookup(var Text: Text): Boolean
        //var
            //UserMgt: Codeunit "418";
        //begin
            /*
            UserMgt.LookupUserID("Archived By");
            */
        //end;
        field(50003;"Pay-to Vend. No.";Code[20])
        {
            Caption = 'Pay-to Vend. No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Vendor;
        }
        field(50010;ID;Code[20])
        {
            Description = 'FE019';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(50020;"From Sales Module";Boolean)
        {
            Caption = 'From Sales Module';
            Editable = false;
        }
        field(50021;"Buy-from Fax No.";Text[30])
        {
            Caption = 'Buy-from Fax No.';
            Description = 'FE005 SEBC 08/01/2007';
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: DeferralHeaderArchive)()
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
        PurchaseLineArchive.SETRANGE("Document Type","Document Type");
        PurchaseLineArchive.SETRANGE("Document No.","No.");
        PurchaseLineArchive.SETRANGE("Doc. No. Occurrence","Doc. No. Occurrence");
        #4..8
        PurchCommentLineArch.SETRANGE("Doc. No. Occurrence","Doc. No. Occurrence");
        PurchCommentLineArch.SETRANGE("Version No.","Version No.");
        PurchCommentLineArch.DELETEALL;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..11

        DeferralHeaderArchive.SETRANGE("Deferral Doc. Type",DeferralUtilities.GetPurchDeferralDocType);
        DeferralHeaderArchive.SETRANGE("Document Type","Document Type");
        DeferralHeaderArchive.SETRANGE("Document No.","No.");
        DeferralHeaderArchive.SETRANGE("Doc. No. Occurrence","Doc. No. Occurrence");
        DeferralHeaderArchive.SETRANGE("Version No.","Version No.");
        DeferralHeaderArchive.DELETEALL(TRUE);
        */
    //end;

    procedure SetSecurityFilterOnRespCenter()
    begin
        IF UserSetupMgt.GetPurchasesFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserSetupMgt.GetPurchasesFilter);
          FILTERGROUP(0);
        END;
    end;

    var
        DeferralHeaderArchive: Record "5127";
        DeferralUtilities: Codeunit "1720";

    var
        UserSetupMgt: Codeunit "5700";
}

