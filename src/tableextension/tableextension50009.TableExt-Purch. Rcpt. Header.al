tableextension 50009 tableextension50009 extends "Purch. Rcpt. Header"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //NSC1.0 FG 04/12/06 FE019 Ajout Code Utilisateur systematiquement
    // //VERSIONNING FG 05/12/06 NSC1.01
    // //FE005 SEBC 08/01/2007 Add field
    //                         50021 Buy-from Fax No.
    // //Propagation CASC 18/01/2007 NSC1.01 : Add fields
    //                                          50003 Pay-to Vend. No.
    //                                          50010 ID
    //                                          50020 From Sales Module
    // 
    // ------------------------------------------------------------------------
    LookupPageID = 145;
    DrillDownPageID = 145;
    fields
    {

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Order No."(Field 44)".


        //Unsupported feature: Property Modification (CalcFormula) on "Comment(Field 46)".

        modify("Bal. Account No.")
        {
            TableRelation = IF (Bal. Account Type=CONST(G/L Account)) "G/L Account"
                            ELSE IF (Bal. Account Type=CONST(Bank Account)) "Bank Account";
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Requested Receipt Date"(Field 5790)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Lead Time Calculation"(Field 5792)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Inbound Whse. Handling Time"(Field 5793)".

        field(50003; "Pay-to Vend. No."; Code[20])
        {
            Caption = 'Pay-to Vend. No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Vendor;
        }
        field(50010; ID; Code[50])
        {
            Description = 'AjoutCodeUtilisateur RD 13/11/06 NCS1.01 [FE019V1] Ajout du code utilisateur dans les documents achats';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                RecLUserMgt: Codeunit "418";
                CodLUserID: Code[50];
            begin
                //>>MIGRATION NAV 2013
                CodLUserID := ID;
                RecLUserMgt.LookupUserID(CodLUserID);
                //<<MIGRATION NAV 2013
            end;
        }
        field(50020; "From Sales Module"; Boolean)
        {
            Caption = 'From Sales Module';
            Editable = false;
        }
        field(50021; "Buy-from Fax No."; Text[30])
        {
            Caption = 'Buy-from Fax No.';
            Description = 'FE005 SEBC 08/01/2007';
        }
    }
    keys
    {
        key(Key1; "Posting Date")
        {
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: PostPurchDelete)()
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
    LOCKTABLE;
    PostPurchLinesDelete.DeletePurchRcptLines(Rec);

    PurchCommentLine.SETRANGE("Document Type",PurchCommentLine."Document Type"::Receipt);
    PurchCommentLine.SETRANGE("No.","No.");
    PurchCommentLine.DELETEALL;
    ApprovalsMgt.DeletePostedApprovalEntry(DATABASE::"Purch. Rcpt. Header","No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    LOCKTABLE;
    PostPurchDelete.DeletePurchRcptLines(Rec);
    #3..6
    ApprovalsMgmt.DeletePostedApprovalEntries(RECORDID);
    */
    //end;


    //Unsupported feature: Code Modification on "PrintRecords(PROCEDURE 1)".

    //procedure PrintRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH PurchRcptHeader DO BEGIN
      COPY(Rec);
      ReportSelection.SETRANGE(Usage,ReportSelection.Usage::"P.Receipt");
      ReportSelection.SETFILTER("Report ID",'<>0');
      ReportSelection.FIND('-');
      REPEAT
        REPORT.RUNMODAL(ReportSelection."Report ID",ShowRequestForm,FALSE,PurchRcptHeader);
      UNTIL ReportSelection.NEXT = 0;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    WITH PurchRcptHeader DO BEGIN
      COPY(Rec);
      ReportSelection.PrintWithGUIYesNo(ReportSelection.Usage::"P.Receipt",PurchRcptHeader,ShowRequestForm,'');
    END;
    */
    //end;

    var
        PostPurchDelete: Codeunit "364";

    var
        ApprovalsMgmt: Codeunit "1535";
}

