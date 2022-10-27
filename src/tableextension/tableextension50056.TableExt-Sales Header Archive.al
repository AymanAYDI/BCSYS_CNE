tableextension 50056 tableextension50056 extends "Sales Header Archive"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Archivage_Devis] Ajout du champ 50000
    // //NSC1.0 FG 04/12/06 Ajout Code Utilisateur 50010
    // //VERSIONNING FG 05/12/06 NSC1.01
    // //FE005 SEBC 08/01/2007 Add field
    //                         50061 Sell-to Fax No.
    // //Propagation CASC 18/01/2007 NSC1.01 : Add fields
    //                                          50003 Pay-to Customer No.
    //                                          50004 Advance Payment
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
    // ------------------------------------------------------------------------
    // 
    // //>>CNE ARCHIVAGE
    //   ARCHIVAGE-DEVIS 29/01/16 : - add field 50001, 50002, 50005, 50029, 50062,  50070, 50403
    LookupPageID = 5161;
    DrillDownPageID = 5161;
    fields
    {

        //Unsupported feature: Property Modification (CalcFormula) on "Comment(Field 46)".

        modify("Bal. Account No.")
        {
            TableRelation = IF (Bal. Account Type=CONST(G/L Account)) "G/L Account"
                            ELSE IF (Bal. Account Type=CONST(Bank Account)) "Bank Account";
        }

        //Unsupported feature: Property Modification (CalcFormula) on "Amount(Field 60)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Amount Including VAT"(Field 61)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipping Agent Code"(Field 105)".

        modify(Status)
        {
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';

            //Unsupported feature: Property Modification (OptionString) on "Status(Field 120)".

        }

        //Unsupported feature: Property Modification (CalcFormula) on ""No. of Archived Versions"(Field 145)".

        modify("Sales Quote No.")
        {
            TableRelation = "Sales Header".No. WHERE (Document Type=CONST(Quote),
                                                      No.=FIELD(Sales Quote No.));
        }
        modify("Archived By")
        {
            TableRelation = User."User Name";

            //Unsupported feature: Property Insertion (TestTableRelation) on ""Archived By"(Field 5046)".


            //Unsupported feature: Property Insertion (Editable) on ""Archived By"(Field 5046)".

        }
        modify("Opportunity No.")
        {
            TableRelation = Opportunity.No. WHERE (Contact No.=FIELD(Sell-to Contact No.),
                                                   Closed=CONST(No));
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipping Advice"(Field 5750)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Completely Shipped"(Field 5752)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Requested Delivery Date"(Field 5790)".


        //Unsupported feature: Property Insertion (AccessByPermission) on ""Outbound Whse. Handling Time"(Field 5793)".


        //Unsupported feature: Property Modification (CalcFormula) on ""Late Order Shipping"(Field 5795)".


        //Unsupported feature: Property Deletion (TableRelation) on ""Credit Card No."(Field 827)".



        //Unsupported feature: Code Insertion on ""Archived By"(Field 5046)".

        //trigger OnLookup(var Text: Text): Boolean
        //var
            //UserMgt: Codeunit "418";
        //begin
            /*
            UserMgt.LookupUserID("Archived By");
            */
        //end;
        field(200;"Work Description";BLOB)
        {
            Caption = 'Work Description';
        }
        field(50000;"Cause filing";Option)
        {
            Caption = 'Cause filing';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Archivage_Devis] Ajout du champ';
            OptionCaption = 'No proceeded,Deleted,Change in Order';
            OptionMembers = "No proceeded",Deleted,"Change in Order";
        }
        field(50001;"Purchaser Comments";Text[50])
        {
            Caption = 'Purchaser Comments';
            Description = 'CNE1.00';
        }
        field(50002;"Warehouse Comments";Text[50])
        {
            Caption = 'Warehouse Comments';
            Description = 'CNE1.00';
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
            Description = 'FE019';
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
        field(50026;"Purchase cost";Decimal)
        {
            CalcFormula = Sum("Sales Line"."Purchase cost" WHERE (Document Type=FIELD(Document Type),
                                                                  Document No.=FIELD(No.)));
            Caption = 'Purchase Cost';
            Description = 'SM Besoin pour Etat Bible';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50029;"Copy Sell-to Address";Boolean)
        {
            Caption = 'Copy Sell-to Address';
            Description = 'CNE6.01';
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
        field(50062;"Sell-to E-Mail Address";Text[50])
        {
            Caption = 'Sell-to E-Mail address';
            Description = 'FE005 MICO 12/02/07';
        }
        field(50070;"Sales Counter";Boolean)
        {
            Caption = 'Sales Counter';
        }
        field(50080;"Purchase No. Order Lien";Code[20])
        {
            Caption = 'Purchase No. Order Lien';
            Description = 'CNEIC';

            trigger OnLookup()
            var
                reclPurchHdr: Record "38";
            begin
            end;
        }
        field(50403;"Bin Code";Code[20])
        {

            trigger OnLookup()
            var
                WMSManagement: Codeunit "7302";
                BinCode: Code[20];
            begin
            end;

            trigger OnValidate()
            var
                WMSManagement: Codeunit "7302";
            begin
            end;
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: DeferralHeaderArchive)()
    //Parameters and return type have not been exported.
    //begin
        /*
        */
    //end;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: DeferralUtilities)()
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
        SalesLineArchive.SETRANGE("Document Type","Document Type");
        SalesLineArchive.SETRANGE("Document No.","No.");
        SalesLineArchive.SETRANGE("Doc. No. Occurrence","Doc. No. Occurrence");
        #4..14
        SalesCommentLineArch.SETRANGE("Doc. No. Occurrence","Doc. No. Occurrence");
        SalesCommentLineArch.SETRANGE("Version No.","Version No.");
        SalesCommentLineArch.DELETEALL;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..17

        DeferralHeaderArchive.SETRANGE("Deferral Doc. Type",DeferralUtilities.GetSalesDeferralDocType);
        DeferralHeaderArchive.SETRANGE("Document Type","Document Type");
        DeferralHeaderArchive.SETRANGE("Document No.","No.");
        DeferralHeaderArchive.SETRANGE("Doc. No. Occurrence","Doc. No. Occurrence");
        DeferralHeaderArchive.SETRANGE("Version No.","Version No.");
        DeferralHeaderArchive.DELETEALL(TRUE);
        */
    //end;

    procedure SetSecurityFilterOnRespCenter()
    begin
        IF UserSetupMgt.GetSalesFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserSetupMgt.GetSalesFilter);
          FILTERGROUP(0);
        END;
    end;

    var
        DeferralHeaderArchive: Record "5127";

    var
        DeferralUtilities: Codeunit "1720";

    var
        UserSetupMgt: Codeunit "5700";
}

