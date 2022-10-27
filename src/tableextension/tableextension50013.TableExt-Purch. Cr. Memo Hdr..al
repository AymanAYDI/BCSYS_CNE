tableextension 50013 tableextension50013 extends "Purch. Cr. Memo Hdr."
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ 50003
    // //NSC1.0 FG 04/12/06 FE019 Ajout Code Utilisateur systematiquement
    // //VERSIONNING FG 05/12/06 NSC1.01
    // //FE005 SEBC 08/01/2007 Add field
    //                         50021 Buy-from Fax No.
    // //Propagation CASC 18/01/2007 NSC1.01 : Add fields
    //                                          50010 ID
    //                                          50020 From Sales Module
    // //>>CNE1.00
    // FEP-ADVE-200706_18_A.001:MA 14/11/2007 : gestion des appeles d'offres clients
    //   - Add field "Affair No."
    // ------------------------------------------------------------------------
    LookupPageID = 147;
    DrillDownPageID = 147;
    fields
    {

        //Unsupported feature: Property Modification (CalcFormula) on "Comment(Field 46)".

        modify("Bal. Account No.")
        {
            TableRelation = IF (Bal. Account Type=CONST(G/L Account)) "G/L Account"
                            ELSE IF (Bal. Account Type=CONST(Bank Account)) "Bank Account";
        }

        //Unsupported feature: Property Insertion (Editable) on ""User ID"(Field 112)".


        //Unsupported feature: Property Modification (CalcFormula) on "Paid(Field 1302)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Return Order No."(Field 6601)".


        //Unsupported feature: Deletion (FieldCollection) on "Canceled(Field 1300)".

        field(1310; Cancelled; Boolean)
        {
            CalcFormula = Exist ("Cancelled Document" WHERE (Source ID=CONST(124),
                                                            Cancelled Doc. No.=FIELD(No.)));
            Caption = 'Cancelled';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1311;Corrective;Boolean)
        {
            CalcFormula = Exist("Cancelled Document" WHERE (Source ID=CONST(122),
                                                            Cancelled By Doc. No.=FIELD(No.)));
            Caption = 'Corrective';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000;"Affair No.";Code[20])
        {
            Caption = 'Affair No.';
            Description = 'CNE1.00';
            TableRelation = Job.No.;
        }
        field(50003;"Pay-to Vend. No.";Code[20])
        {
            Caption = 'Pay-to Vend. No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Vendor;
        }
        field(50010;ID;Code[50])
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
    keys
    {

        //Unsupported feature: Property Deletion (KeyGroups) on ""Prepayment Order No."(Key)".

        key(Key1;"Posting Date")
        {
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: PostedDeferralHeader)()
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
        PostPurchLinesDelete.DeletePurchCrMemoLines(Rec);

        PurchCommentLine.SETRANGE("Document Type",PurchCommentLine."Document Type"::"Posted Credit Memo");
        PurchCommentLine.SETRANGE("No.","No.");
        PurchCommentLine.DELETEALL;

        ApprovalsMgt.DeletePostedApprovalEntry(DATABASE::"Purch. Cr. Memo Hdr.","No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        PostPurchDelete.IsDocumentDeletionAllowed("Posting Date");
        LOCKTABLE;
        PostPurchDelete.DeletePurchCrMemoLines(Rec);
        #3..7
        ApprovalsMgmt.DeletePostedApprovalEntries(RECORDID);
        PostedDeferralHeader.DeleteForDoc(DeferralUtilities.GetPurchDeferralDocType,'','',
          PurchCommentLine."Document Type"::"Posted Credit Memo","No.");
        */
    //end;


    //Unsupported feature: Code Modification on "PrintRecords(PROCEDURE 1)".

    //procedure PrintRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH PurchCrMemoHeader DO BEGIN
          COPY(Rec);
          ReportSelection.SETRANGE(Usage,ReportSelection.Usage::"P.Cr.Memo");
          ReportSelection.SETFILTER("Report ID",'<>0');
          ReportSelection.FIND('-');
          REPEAT
            REPORT.RUNMODAL(ReportSelection."Report ID",ShowRequestForm,FALSE,PurchCrMemoHeader);
          UNTIL ReportSelection.NEXT = 0;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        WITH PurchCrMemoHeader DO BEGIN
          COPY(Rec);
          ReportSelection.PrintWithGUIYesNo(ReportSelection.Usage::"P.Cr.Memo",PurchCrMemoHeader,ShowRequestForm,'');
        END;
        */
    //end;

    procedure ShowCanceledOrCorrInvoice()
    begin
        CALCFIELDS(Cancelled,Corrective);
        CASE TRUE OF
          Cancelled:
            ShowCorrectiveInvoice;
          Corrective:
            ShowCancelledInvoice;
        END;
    end;

    procedure ShowCorrectiveInvoice()
    var
        CancelledDocument: Record "1900";
        PurchInvHeader: Record "122";
    begin
        CALCFIELDS(Cancelled);
        IF NOT Cancelled THEN
          EXIT;

        IF CancelledDocument.FindPurchCancelledCrMemo("No.") THEN BEGIN
          PurchInvHeader.GET(CancelledDocument."Cancelled By Doc. No.");
          PAGE.RUN(PAGE::"Posted Purchase Invoice",PurchInvHeader);
        END;
    end;

    procedure ShowCancelledInvoice()
    var
        CancelledDocument: Record "1900";
        PurchInvHeader: Record "122";
    begin
        CALCFIELDS(Corrective);
        IF NOT Corrective THEN
          EXIT;

        IF CancelledDocument.FindPurchCorrectiveCrMemo("No.") THEN BEGIN
          PurchInvHeader.GET(CancelledDocument."Cancelled Doc. No.");
          PAGE.RUN(PAGE::"Posted Purchase Invoice",PurchInvHeader);
        END;
    end;

    var
        PostedDeferralHeader: Record "1704";
        PostPurchDelete: Codeunit "364";
        DeferralUtilities: Codeunit "1720";

    var
        ApprovalsMgmt: Codeunit "1535";
}

