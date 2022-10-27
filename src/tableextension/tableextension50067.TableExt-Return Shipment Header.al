tableextension 50067 tableextension50067 extends "Return Shipment Header"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // //FE005 SEBC 08/01/2007 Add field
    //                         50021 Buy-from Fax No.
    // //Propagation CASC 18/01/2007 NSC1.01 : Add fields
    //                                          50003 Pay-to Vend. No.
    //                                          50010 ID
    //                                          50020 From Sales Module
    // 
    // ------------------------------------------------------------------------
    LookupPageID = 6652;
    fields
    {
        modify("Pay-to City")
        {
            TableRelation = IF (Pay-to Country/Region Code=CONST()) "Post Code".City
                            ELSE IF (Pay-to Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Pay-to Country/Region Code));
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
        modify("Buy-from City")
        {
            TableRelation = IF (Buy-from Country/Region Code=CONST()) "Post Code".City
                            ELSE IF (Buy-from Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Buy-from Country/Region Code));
        }
        modify("Pay-to Post Code")
        {
            TableRelation = IF (Pay-to Country/Region Code=CONST()) "Post Code"
                            ELSE IF (Pay-to Country/Region Code=FILTER(<>'')) "Post Code" WHERE (Country/Region Code=FIELD(Pay-to Country/Region Code));
        }
        modify("Buy-from Post Code")
        {
            TableRelation = IF (Buy-from Country/Region Code=CONST()) "Post Code"
                            ELSE IF (Buy-from Country/Region Code=FILTER(<>'')) "Post Code" WHERE (Country/Region Code=FIELD(Buy-from Country/Region Code));
        }
        modify("Ship-to Post Code")
        {
            TableRelation = IF (Ship-to Country/Region Code=CONST()) "Post Code"
                            ELSE IF (Ship-to Country/Region Code=FILTER(<>'')) "Post Code" WHERE (Country/Region Code=FIELD(Ship-to Country/Region Code));
        }

        //Unsupported feature: Property Insertion (Editable) on ""User ID"(Field 112)".

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
        LOCKTABLE;
        PostPurchLinesDelete.DeletePurchShptLines(Rec);

        PurchCommentLine.SETRANGE("Document Type",PurchCommentLine."Document Type"::"Posted Return Shipment");
        PurchCommentLine.SETRANGE("No.","No.");
        PurchCommentLine.DELETEALL;

        ApprovalsMgt.DeletePostedApprovalEntry(DATABASE::"Return Shipment Header","No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        LOCKTABLE;
        PostPurchDelete.DeletePurchShptLines(Rec);
        #3..7
        ApprovalsMgmt.DeletePostedApprovalEntries(RECORDID);

        IF CertificateOfSupply.GET(CertificateOfSupply."Document Type"::"Return Shipment","No.") THEN
          CertificateOfSupply.DELETE(TRUE);
        */
    //end;


    //Unsupported feature: Code Modification on "PrintRecords(PROCEDURE 1)".

    //procedure PrintRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH ReturnShptHeader DO BEGIN
          COPY(Rec);
          ReportSelection.SETRANGE(Usage,ReportSelection.Usage::"P.Ret.Shpt.");
          ReportSelection.SETFILTER("Report ID",'<>0');
          ReportSelection.FIND('-');
          REPEAT
            REPORT.RUNMODAL(ReportSelection."Report ID",ShowRequestForm,FALSE,ReturnShptHeader);
          UNTIL ReportSelection.NEXT = 0;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        WITH ReturnShptHeader DO BEGIN
          COPY(Rec);
          ReportSelection.PrintWithGUIYesNo(ReportSelection.Usage::"P.Ret.Shpt.",ReturnShptHeader,ShowRequestForm,'');
        END;
        */
    //end;

    var
        CertificateOfSupply: Record "780";
        PostPurchDelete: Codeunit "364";

    var
        ApprovalsMgmt: Codeunit "1535";
}

