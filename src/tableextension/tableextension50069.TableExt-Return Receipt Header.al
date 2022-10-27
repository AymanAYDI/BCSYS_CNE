tableextension 50069 tableextension50069 extends "Return Receipt Header"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // //FE005 SEBC 08/01/2007 Add field
    //                         50061 Sell-to Fax No.
    // //Propagation CASC 18/01/2007 NSC1.01 : Add fields
    //                                          50000 Cause filing
    //                                          50003 Pay-to Customer No.
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
    //                                          50050 Document description
    //                                          50060 Quote Statut
    // 
    //  ------------------------------------------------------------------------
    LookupPageID = 6662;
    fields
    {
        modify("Bill-to City")
        {
            TableRelation = IF (Bill-to Country/Region Code=CONST()) "Post Code".City
                            ELSE IF (Bill-to Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Bill-to Country/Region Code));
        }
        modify("Ship-to City")
        {
            TableRelation = IF (Ship-to Country/Region Code=CONST()) "Post Code".City
                            ELSE IF (Ship-to Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Ship-to Country/Region Code));
        }

        //Unsupported feature: Property Modification (CalcFormula) on "Comment(Field 46)".

        modify("Bal. Account No.")
        {
            TableRelation = IF (Bal. Account Type=CONST(G/L Account)) "G/L Account"
                            ELSE IF (Bal. Account Type=CONST(Bank Account)) "Bank Account";
        }
        modify("Sell-to City")
        {
            TableRelation = IF (Sell-to Country/Region Code=CONST()) "Post Code".City
                            ELSE IF (Sell-to Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Sell-to Country/Region Code));
        }
        modify("Bill-to Post Code")
        {
            TableRelation = IF (Bill-to Country/Region Code=CONST()) "Post Code"
                            ELSE IF (Bill-to Country/Region Code=FILTER(<>'')) "Post Code" WHERE (Country/Region Code=FIELD(Bill-to Country/Region Code));
        }
        modify("Sell-to Post Code")
        {
            TableRelation = IF (Sell-to Country/Region Code=CONST()) "Post Code"
                            ELSE IF (Sell-to Country/Region Code=FILTER(<>'')) "Post Code" WHERE (Country/Region Code=FIELD(Sell-to Country/Region Code));
        }
        modify("Ship-to Post Code")
        {
            TableRelation = IF (Ship-to Country/Region Code=CONST()) "Post Code"
                            ELSE IF (Ship-to Country/Region Code=FILTER(<>'')) "Post Code" WHERE (Country/Region Code=FIELD(Ship-to Country/Region Code));
        }

        //Unsupported feature: Property Insertion (Editable) on ""User ID"(Field 112)".

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
        field(50010;ID;Code[50])
        {
            Caption = 'User ID';
            Description = 'AjoutCodeUtilisateur RD 13/11/06 NCS1.01 [FE019V1] Ajout du code utilisateur dans les documents d''achats & ventes';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
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
        field(50026;"Purchase Cost";Decimal)
        {
            Description = 'SM Besoin pour Etat Bible';
            Editable = false;
        }
        field(50030;"Sales LCY";Decimal)
        {
            Caption = 'Ventes DS';
            Description = 'SM Besoin pour Etat Bible';
        }
        field(50031;"Profit LCY";Decimal)
        {
            Caption = 'Marge DS';
            Description = 'SM  Besoin Etat Bible';
            Editable = true;
        }
        field(50032;"% Profit";Decimal)
        {
            Caption = '% de marge sur vente';
            Description = 'SM Besoin pour Etat Bible';
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
    }
    keys
    {
        key(Key1;"Posting Date")
        {
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: PostSalesDelete)()
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
        PostSalesLinesDelete.DeleteSalesRcptLines(Rec);

        SalesCommentLine.SETRANGE("Document Type",SalesCommentLine."Document Type"::"Posted Return Receipt");
        SalesCommentLine.SETRANGE("No.","No.");
        SalesCommentLine.DELETEALL;

        ApprovalsMgt.DeletePostedApprovalEntry(DATABASE::"Return Receipt Header","No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TESTFIELD("No. Printed");
        LOCKTABLE;
        PostSalesDelete.DeleteSalesRcptLines(Rec);
        #4..8
        ApprovalsMgmt.DeletePostedApprovalEntries(RECORDID);
        */
    //end;


    //Unsupported feature: Code Modification on "PrintRecords(PROCEDURE 3)".

    //procedure PrintRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH ReturnRcptHeader DO BEGIN
          COPY(Rec);
          ReportSelection.SETRANGE(Usage,ReportSelection.Usage::"S.Ret.Rcpt.");
          ReportSelection.SETFILTER("Report ID",'<>0');
          ReportSelection.FIND('-');
          REPEAT
            REPORT.RUNMODAL(ReportSelection."Report ID",ShowRequestForm,FALSE,ReturnRcptHeader);
          UNTIL ReportSelection.NEXT = 0;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        WITH ReturnRcptHeader DO BEGIN
          COPY(Rec);
          ReportSelection.PrintWithGUIYesNo(
            ReportSelection.Usage::"S.Ret.Rcpt.",ReturnRcptHeader,ShowRequestForm,"Bill-to Customer No.");
        END;
        */
    //end;

    procedure EmailRecords(ShowDialog: Boolean)
    var
        DocumentSendingProfile: Record "60";
        DummyReportSelections: Record "77";
    begin
        DocumentSendingProfile.TrySendToEMail(
          DummyReportSelections.Usage::"S.Ret.Rcpt.",Rec,FIELDNO("No."),DocTxt,FIELDNO("Bill-to Customer No."),ShowDialog);
    end;

    var
        PostSalesDelete: Codeunit "363";

    var
        ApprovalsMgmt: Codeunit "1535";

    var
        DocTxt: Label 'Receipt';
}

