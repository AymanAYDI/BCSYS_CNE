tableextension 50007 tableextension50007 extends "Sales Cr.Memo Header"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ 50003
    // //NSC1.0 FG 04/12/06 FE019 Ajout Code Utilisateur systematiquement
    // //VERSIONNING FG 05/12/06 NSC1.01
    // //FE005 SEBC 08/01/2007 Add field
    //                         50061 Sell-to Fax No.
    // //Propagation CASC 18/01/2007 NSC1.01 : Add fields
    //                                          50000 Cause filing
    //                                          50004 Advance Payment
    //                                          50010 ID
    //                                          50020 Customer Sales Profit Group
    //                                          50025 Combine Shipments by Order
    //                                          50026 Purchase Cost
    //                                          50030 Sales LCY
    //                                          50031 Profit LCY
    //                                          50032 % Profit
    //                                          50033 Invoiced
    //                                          50040 Prod. Version No.
    //                                          50060 Quote Statut
    // 
    // //FE005 MICO 12/02/2007 : Ajout champ 50062 Sell-to E-Mail Address
    // //VERSIONNING FG 28/02/07 suite au Merge
    // //>>CNE1.00
    // FEP-ADVE-200706_18_A.001:MA 14/11/2007 : Gestion des apples d'offres clients
    //    - Add field 50005
    // 
    // //>>CNE5.00
    // TDL.79:20131120/CSC
    // - Add a new key on "Posting Date"
    // 
    // //>>CNE7.01
    // //>>P24233_001 SOBI APA 02/02/17
    //                     Add Field 50100
    // 
    // ------------------------------------------------------------------------
    LookupPageID = 144;
    DrillDownPageID = 144;
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


        //Unsupported feature: Deletion (FieldCollection) on ""Credit Card No."(Field 827)".


        //Unsupported feature: Deletion (FieldCollection) on "Canceled(Field 1300)".

        field(710; "Document Exchange Identifier"; Text[50])
        {
            Caption = 'Document Exchange Identifier';
        }
        field(711; "Document Exchange Status"; Option)
        {
            Caption = 'Document Exchange Status';
            OptionCaption = 'Not Sent,Sent to Document Exchange Service,Delivered to Recipient,Delivery Failed,Pending Connection to Recipient';
            OptionMembers = "Not Sent","Sent to Document Exchange Service","Delivered to Recipient","Delivery Failed","Pending Connection to Recipient";
        }
        field(712; "Doc. Exch. Original Identifier"; Text[50])
        {
            Caption = 'Doc. Exch. Original Identifier';
        }
        field(1310; Cancelled; Boolean)
        {
            CalcFormula = Exist ("Cancelled Document" WHERE (Source ID=CONST(114),
                                                            Cancelled Doc. No.=FIELD(No.)));
            Caption = 'Cancelled';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1311;Corrective;Boolean)
        {
            CalcFormula = Exist("Cancelled Document" WHERE (Source ID=CONST(112),
                                                            Cancelled By Doc. No.=FIELD(No.)));
            Caption = 'Corrective';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5055;"Opportunity No.";Code[20])
        {
            Caption = 'Opportunity No.';
            TableRelation = Opportunity;
        }
        field(50000;"Cause filing";Option)
        {
            Caption = 'Cause filing';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Archivage_Devis] Ajout du champ';
            OptionCaption = 'No proceeded,Deleted,Change in Order';
            OptionMembers = "No proceeded",Deleted,"Change in Order";
        }
        field(50003;"Pay-to Customer No.";Code[20])
        {
            Caption = 'Pay-to Customer No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Customer;
        }
        field(50004;"Advance Payment";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            Caption = 'Advance Payment';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Champs_Suppl] Ajout du champ';
        }
        field(50005;"Affair No.";Code[20])
        {
            Caption = 'Affair No.';
            Description = 'CNE1.00';
            TableRelation = Job.No.;
        }
        field(50010;ID;Code[50])
        {
            Caption = 'User ID';
            Description = 'AjoutCodeUtilisateur RD 13/11/06 NCS1.01 [FE019V1] Ajout du code utilisateur dans les documents d''achats & ventes';
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
        field(50020;"Customer Sales Profit Group";Code[10])
        {
            Caption = 'Goupe Marge Vente Client';
            Description = 'GRPMARGECLT SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            TableRelation = "Customer Sales Profit Group";
        }
        field(50025;"Combine Shipments by Order";Boolean)
        {
            Caption = 'Combine Shipment By Order';
            Description = 'FE018 regroupement BL par CMD';
        }
        field(50026;"Purchase cost";Decimal)
        {
            Caption = 'Purchase Cost';
            Description = 'SM Besoin pour Etat Bible _ champ inutilisable copie flowfiled';
            Editable = false;
            FieldClass = Normal;
        }
        field(50030;"Sales LCY";Decimal)
        {
            Caption = 'Ventes DS';
            Description = 'SM Besoin Etat Bible';
        }
        field(50031;"Profit LCY";Decimal)
        {
            Caption = 'Marge DS';
            Description = 'SM  Besoin Etat Bible';
        }
        field(50032;"% Profit";Decimal)
        {
            Caption = '% de marge sur vente';
            Description = 'SM  Besoin Etat Bible';
        }
        field(50033;Invoiced;Boolean)
        {
            Caption = 'Invoiced';
        }
        field(50040;"Prod. Version No.";Integer)
        {
            Caption = 'Version No.';
        }
        field(50050;"Document description";Text[50])
        {
            Caption = 'Document description';
        }
        field(50060;"Quote statut";Option)
        {
            Caption = 'Quote status';
            OptionCaption = ' ,Approved,Locked';
            OptionMembers = " ",approved,locked;
        }
        field(50061;"Sell-to Fax No.";Text[30])
        {
            Caption = 'Sell-to Fax No.';
            Description = 'FE005 SEBC 08/01/2007';
        }
        field(50062;"Sell-to E-Mail Address";Text[50])
        {
            Description = 'FE005 MICO 20/02/2007';
        }
        field(50100;"Salesperson Filter";Text[250])
        {
            Caption = 'Salesperson Filter';
            Editable = false;
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Sell-to Customer No.,External Document No."(Key)".


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
        TESTFIELD("No. Printed");
        LOCKTABLE;
        PostSalesLinesDelete.DeleteSalesCrMemoLines(Rec);

        SalesCommentLine.SETRANGE("Document Type",SalesCommentLine."Document Type"::"Posted Credit Memo");
        SalesCommentLine.SETRANGE("No.","No.");
        SalesCommentLine.DELETEALL;

        ApprovalsMgt.DeletePostedApprovalEntry(DATABASE::"Sales Cr.Memo Header","No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        PostSalesDelete.IsDocumentDeletionAllowed("Posting Date");
        TESTFIELD("No. Printed");
        LOCKTABLE;
        PostSalesDelete.DeleteSalesCrMemoLines(Rec);
        #4..8
        ApprovalsMgmt.DeletePostedApprovalEntries(RECORDID);
        PostedDeferralHeader.DeleteForDoc(DeferralUtilities.GetSalesDeferralDocType,'','',
          SalesCommentLine."Document Type"::"Posted Credit Memo","No.");
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: DocumentSendingProfile) (VariableCollection) on "PrintRecords(PROCEDURE 1)".


    //Unsupported feature: Variable Insertion (Variable: DummyReportSelections) (VariableCollection) on "PrintRecords(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "PrintRecords(PROCEDURE 1)".

    //procedure PrintRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH SalesCrMemoHeader DO BEGIN
          COPY(Rec);
          FIND('-');
          ReportSelection.SETRANGE(Usage,ReportSelection.Usage::"S.Cr.Memo");
          ReportSelection.SETFILTER("Report ID",'<>0');
          ReportSelection.FIND('-');
          REPEAT
            REPORT.RUNMODAL(ReportSelection."Report ID",ShowRequestForm,FALSE,SalesCrMemoHeader);
          UNTIL ReportSelection.NEXT = 0;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        DocumentSendingProfile.TrySendToPrinter(
          DummyReportSelections.Usage::"S.Cr.Memo",Rec,"Bill-to Customer No.",ShowRequestForm);
        */
    //end;

    procedure SendRecords()
    var
        DocumentSendingProfile: Record "60";
        DummyReportSelections: Record "77";
    begin
        DocumentSendingProfile.SendCustomerRecords(
          DummyReportSelections.Usage::"S.Cr.Memo",Rec,DocTxt,"Bill-to Customer No.","No.",
          FIELDNO("Bill-to Customer No."),FIELDNO("No."));
    end;

    procedure SendProfile(var DocumentSendingProfile: Record "60")
    var
        DummyReportSelections: Record "77";
    begin
        DocumentSendingProfile.Send(
          DummyReportSelections.Usage::"S.Cr.Memo",Rec,"No.","Bill-to Customer No.",
          DocTxt,FIELDNO("Bill-to Customer No."),FIELDNO("No."));
    end;

    procedure EmailRecords(ShowRequestForm: Boolean)
    var
        DocumentSendingProfile: Record "60";
        DummyReportSelections: Record "77";
    begin
        DocumentSendingProfile.TrySendToEMail(
          DummyReportSelections.Usage::"S.Cr.Memo",Rec,FIELDNO("No."),DocTxt,FIELDNO("Bill-to Customer No."),ShowRequestForm);
    end;

    procedure GetCustomerVATRegistrationNumber(): Text
    begin
        EXIT("VAT Registration No.");
    end;

    procedure GetCustomerVATRegistrationNumberLbl(): Text
    begin
        EXIT(FIELDCAPTION("VAT Registration No."));
    end;

    procedure GetCustomerGlobalLocationNumber(): Text
    begin
        EXIT('');
    end;

    procedure GetCustomerGlobalLocationNumberLbl(): Text
    begin
        EXIT('');
    end;

    procedure GetLegalStatement(): Text
    var
        SalesSetup: Record "311";
    begin
        SalesSetup.GET;
        EXIT(SalesSetup.GetLegalStatement);
    end;

    procedure GetDocExchStatusStyle(): Text
    begin
        CASE "Document Exchange Status" OF
          "Document Exchange Status"::"Not Sent":
            EXIT('Standard');
          "Document Exchange Status"::"Sent to Document Exchange Service":
            EXIT('Ambiguous');
          "Document Exchange Status"::"Delivered to Recipient":
            EXIT('Favorable');
          ELSE
            EXIT('Unfavorable');
        END;
    end;

    procedure ShowActivityLog()
    var
        ActivityLog: Record "710";
    begin
        ActivityLog.ShowEntries(RECORDID);
    end;

    procedure DocExchangeStatusIsSent(): Boolean
    begin
        EXIT("Document Exchange Status" <> "Document Exchange Status"::"Not Sent");
    end;

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
        SalesInvHeader: Record "112";
    begin
        CALCFIELDS(Cancelled);
        IF NOT Cancelled THEN
          EXIT;

        IF CancelledDocument.FindSalesCancelledCrMemo("No.") THEN BEGIN
          SalesInvHeader.GET(CancelledDocument."Cancelled By Doc. No.");
          PAGE.RUN(PAGE::"Posted Sales Invoice",SalesInvHeader);
        END;
    end;

    procedure ShowCancelledInvoice()
    var
        CancelledDocument: Record "1900";
        SalesInvHeader: Record "112";
    begin
        CALCFIELDS(Corrective);
        IF NOT Corrective THEN
          EXIT;

        IF CancelledDocument.FindSalesCorrectiveCrMemo("No.") THEN BEGIN
          SalesInvHeader.GET(CancelledDocument."Cancelled Doc. No.");
          PAGE.RUN(PAGE::"Posted Sales Invoice",SalesInvHeader);
        END;
    end;

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: Brick)".


    //Unsupported feature: Deletion (VariableCollection) on "PrintRecords(PROCEDURE 1).ReportSelection(Variable 1001)".


    var
        PostedDeferralHeader: Record "1704";
        PostSalesDelete: Codeunit "363";
        DeferralUtilities: Codeunit "1720";

    var
        ApprovalsMgmt: Codeunit "1535";

    var
        DocTxt: Label 'Credit Memo';
}

