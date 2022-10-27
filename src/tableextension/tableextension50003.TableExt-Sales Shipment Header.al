tableextension 50003 tableextension50003 extends "Sales Shipment Header"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //NSC1.0 FG 04/12/06 FE019 Ajout Code Utilisateur systematiquement
    // //VERSIONNING FG 05/12/06 NSC1.01
    // //FE005 SEBC 08/01/2007 Add field
    //                         50061 Sell-to Fax No.
    // 
    // 
    // //Propagation CASC 18/01/2007 NSC1.01 : Add fields
    //                                          50000 Cause filing
    //                                          50003 Pay-to Customer No.
    //                                          50004 Advance Payment
    //                                          50010 ID
    //                                          50020 Customer Sales Profit Group
    //                                          50025 Combine Shipments by Order
    //                                          50026 Puchase Cost
    //                                          50040 Prod. Version No.
    //                                          50060 Quote Statut
    // 
    // //FE005 MICO 12/02/2007 : Ajout champ 50062 Sell-to E-Mail Address
    // //VERSIONNING FG 28/02/07 suite au Merge
    // //>>CNE1.00
    // FEP-ADVE-200706_18_A.001:MA 14/11/2007 : Gestion des appels d'offres clients
    //   - add field 50005
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
    LookupPageID = 142;
    DrillDownPageID = 142;
    fields
    {

        //Unsupported feature: Property Modification (CalcFormula) on "Comment(Field 46)".

        modify("Bal. Account No.")
        {
            TableRelation = IF (Bal. Account Type=CONST(G/L Account)) "G/L Account"
                            ELSE IF (Bal. Account Type=CONST(Bank Account)) "Bank Account";
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipping Agent Code"(Field 105)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Requested Delivery Date"(Field 5790)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipping Time"(Field 5792)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Outbound Whse. Handling Time"(Field 5793)".



        //Unsupported feature: Code Insertion on ""Order No."(Field 44)".

        //trigger OnLookup(var Text: Text): Boolean
        //var
        //recLSalesOrder: Record "36";
        //begin
        /*
        //>>FE004.4
        recLSalesOrder.SETRANGE("Document Type",recLSalesOrder."Document Type"::Order);
        recLSalesOrder.SETFILTER("No.","Order No.");
        PAGE.RUNMODAL(PAGE::"Sales Order", recLSalesOrder) ;
        //<<FE004.4
        */
        //end;
        field(5055; "Opportunity No."; Code[20])
        {
            Caption = 'Opportunity No.';
            TableRelation = Opportunity;
        }
        field(50000; "Cause filing"; Option)
        {
            Caption = 'Cause filing';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Archivage_Devis] Ajout du champ';
            OptionCaption = 'No proceeded,Deleted,Change in Order';
            OptionMembers = "No proceeded",Deleted,"Change in Order";
        }
        field(50003; "Pay-to Customer No."; Code[20])
        {
            Caption = 'Pay-to Customer No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Customer;
        }
        field(50004; "Advance Payment"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            Caption = 'Advance Payment';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Champs_Suppl] Ajout du champ';
        }
        field(50005; "Affair No."; Code[20])
        {
            Caption = 'Affair No.';
            Description = 'CNE1.00';
            TableRelation = Job.No.;
        }
        field(50010;ID;Code[50])
        {
            Caption = 'User ID';
            Description = 'AjoutCodeUtilisateur RD 13/11/06 NCS1.01 [FE019V1] Ajout du code utilisateur dans les documents d''achats & ventes';
            Editable = false;

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
            Description = 'SM Besoin pour Etat Bible _ champ inutilisable copie flowfield';
            Editable = false;
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
            Editable = true;
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
        field(65000;"Assigned User ID";Code[50])
        {
            CalcFormula = Lookup("Sales Header"."Assigned User ID" WHERE (Document Type=CONST(Order),
                                                                          No.=FIELD(Order No.)));
            Caption = 'Assigned User ID';
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Sell-to Customer No.,External Document No."(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Sell-to Customer No.,No."(Key)".

        key(Key1;"Sell-to Customer No.")
        {
        }
        key(Key2;"Posting Date")
        {
        }
        key(Key3;"External Document No.","No.")
        {
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: CertificateOfSupply)()
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
        PostSalesLinesDelete.DeleteSalesShptLines(Rec);

        SalesCommentLine.SETRANGE("Document Type",SalesCommentLine."Document Type"::Shipment);
        SalesCommentLine.SETRANGE("No.","No.");
        SalesCommentLine.DELETEALL;

        ApprovalsMgt.DeletePostedApprovalEntry(DATABASE::"Sales Shipment Header","No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TESTFIELD("No. Printed");
        LOCKTABLE;
        PostSalesDelete.DeleteSalesShptLines(Rec);
        #4..8
        ApprovalsMgmt.DeletePostedApprovalEntries(RECORDID);

        IF CertificateOfSupply.GET(CertificateOfSupply."Document Type"::"Sales Shipment","No.") THEN
          CertificateOfSupply.DELETE(TRUE);
        */
    //end;


    //Unsupported feature: Code Modification on "PrintRecords(PROCEDURE 3)".

    //procedure PrintRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH SalesShptHeader DO BEGIN
          COPY(Rec);
          ReportSelection.SETRANGE(Usage,ReportSelection.Usage::"S.Shipment");
          ReportSelection.SETFILTER("Report ID",'<>0');
          ReportSelection.FIND('-');
          REPEAT
            REPORT.RUNMODAL(ReportSelection."Report ID",ShowRequestForm,FALSE,SalesShptHeader);
          UNTIL ReportSelection.NEXT = 0;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        WITH SalesShptHeader DO BEGIN
          COPY(Rec);
          ReportSelection.PrintWithGUIYesNo(ReportSelection.Usage::"S.Shipment",SalesShptHeader,ShowRequestForm,"Bill-to Customer No.");
        END;
        */
    //end;

    procedure SendProfile(var DocumentSendingProfile: Record "60")
    var
        DummyReportSelections: Record "77";
    begin
        DocumentSendingProfile.Send(
          DummyReportSelections.Usage::"S.Shipment",Rec,"No.","Sell-to Customer No.",
          DocTxt,FIELDNO("Sell-to Customer No."),FIELDNO("No."));
    end;

    procedure EmailRecords(ShowDialog: Boolean)
    var
        DocumentSendingProfile: Record "60";
        DummyReportSelections: Record "77";
    begin
        DocumentSendingProfile.TrySendToEMail(
          DummyReportSelections.Usage::"S.Shipment",Rec,FIELDNO("No."),DocTxt,FIELDNO("Bill-to Customer No."),ShowDialog);
    end;

    var
        CertificateOfSupply: Record "780";
        PostSalesDelete: Codeunit "363";

    var
        ApprovalsMgmt: Codeunit "1535";

    var
        DocTxt: Label 'Shipment';
}

