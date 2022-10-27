tableextension 50030 tableextension50030 extends "Sales & Receivables Setup"
{
    // //?? SOBH NSC1.01 Ajout du champ 60000
    // 
    // ------------------------------------------------------------------------
    // www.Prodware.Fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // //>>NSC1.01
    // 
    // FE005.001:SEBC 05/01/2007 : - PDF Mail Management
    //                             - Add field
    //                               60006 PDF Mail Tag
    // FE25-26.001:SEBC 08/01/2007 : - Price management
    //                               - Add field
    //                                 60007 Update Price Allow Line disc.
    // 
    // 
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>DEEE1.00
    // DEEE:JNPA 01/01/2007 : eco taxe
    //           - Add fields 80800
    // ------------------------------------------------------------------------
    // 
    // FE019 point todo 48 :FLGR 07/02/2007  add field "allow Profit% to"
    // //todolist point 47  FLGR 09/02/2007  : modif adresse client, facturation et livraison pour celle du contact selectionné.
    //                 add field 60009 "Contact's Address on sales doc"
    // //VERSIONNING FG 28/02/07 suite au Merge
    // 
    // 
    // //>>NSC2.01
    // FE032.001:PA 21/05/2007 : Quantity Modification
    //                           - Add field 50000 Active Quantity Management
    // 
    // FE033.001:PA 21/05/2007 : Released Order when Printing
    //                           - Add field 50001 Active Released Printing Order
    // 
    // ACHAT-200706_18_A:GR 11/01/2008 : - Add Field
    //                                     "Purchasing Code Type"
    // 
    // //>> CNE6.01
    // TDL:EC07 15.12.2014 : Create Technicals Sales Directory
    //                       Add Field : Technicals Directory Path
    // 
    // ---------------------------------------------------------------
    Caption = 'Sales & Receivables Setup';
    LookupPageID = 459;
    DrillDownPageID = 459;
    fields
    {
        modify("Primary Key")
        {
            Caption = 'Primary Key';
        }
        modify("Discount Posting")
        {
            Caption = 'Discount Posting';
            OptionCaption = 'No Discounts,Invoice Discounts,Line Discounts,All Discounts';
        }
        modify("Credit Warnings")
        {
            Caption = 'Credit Warnings';
            OptionCaption = 'Both Warnings,Credit Limit,Overdue Balance,No Warning';
        }
        modify("Stockout Warning")
        {
            Caption = 'Stockout Warning';
        }
        modify("Shipment on Invoice")
        {
            Caption = 'Shipment on Invoice';

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Shipment on Invoice"(Field 6)".

        }
        modify("Invoice Rounding")
        {
            Caption = 'Invoice Rounding';
        }
        modify("Ext. Doc. No. Mandatory")
        {
            Caption = 'Ext. Doc. No. Mandatory';
        }
        modify("Customer Nos.")
        {
            Caption = 'Customer Nos.';
        }
        modify("Quote Nos.")
        {
            Caption = 'Quote Nos.';
        }
        modify("Order Nos.")
        {
            Caption = 'Order Nos.';

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Order Nos."(Field 11)".

        }
        modify("Invoice Nos.")
        {
            Caption = 'Invoice Nos.';
        }
        modify("Posted Invoice Nos.")
        {
            Caption = 'Posted Invoice Nos.';
        }
        modify("Credit Memo Nos.")
        {
            Caption = 'Credit Memo Nos.';
        }
        modify("Posted Credit Memo Nos.")
        {
            Caption = 'Posted Credit Memo Nos.';
        }
        modify("Posted Shipment Nos.")
        {
            Caption = 'Posted Shipment Nos.';

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Posted Shipment Nos."(Field 16)".

        }
        modify("Reminder Nos.")
        {
            Caption = 'Reminder Nos.';
        }
        modify("Issued Reminder Nos.")
        {
            Caption = 'Issued Reminder Nos.';
        }
        modify("Fin. Chrg. Memo Nos.")
        {
            Caption = 'Fin. Chrg. Memo Nos.';
        }
        modify("Issued Fin. Chrg. M. Nos.")
        {
            Caption = 'Issued Fin. Chrg. M. Nos.';
        }
        modify("Blanket Order Nos.")
        {
            Caption = 'Blanket Order Nos.';

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Blanket Order Nos."(Field 23)".

        }
        modify("Calc. Inv. Discount")
        {
            Caption = 'Calc. Inv. Discount';
        }
        modify("Appln. between Currencies")
        {
            Caption = 'Appln. between Currencies';
            OptionCaption = 'None,EMU,All';

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Appln. between Currencies"(Field 25)".

        }
        modify("Copy Comments Blanket to Order")
        {
            Caption = 'Copy Comments Blanket to Order';

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Copy Comments Blanket to Order"(Field 26)".

        }
        modify("Copy Comments Order to Invoice")
        {
            Caption = 'Copy Comments Order to Invoice';

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Copy Comments Order to Invoice"(Field 27)".

        }
        modify("Copy Comments Order to Shpt.")
        {
            Caption = 'Copy Comments Order to Shpt.';

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Copy Comments Order to Shpt."(Field 28)".

        }
        modify("Allow VAT Difference")
        {
            Caption = 'Allow VAT Difference';
        }
        modify("Calc. Inv. Disc. per VAT ID")
        {
            Caption = 'Calc. Inv. Disc. per VAT ID';
        }

        //Unsupported feature: Property Insertion (AccessByPermission) on ""Default Quantity to Ship"(Field 36)".

        modify("Job Q. Prio. for Post & Print")
        {
            Caption = 'Job Q. Prio. for Post & Print';
        }
        modify("Direct Debit Mandate Nos.")
        {
            Caption = 'Direct Debit Mandate Nos.';
        }
        modify("Posted Return Receipt Nos.")
        {
            Caption = 'Posted Return Receipt Nos.';

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Posted Return Receipt Nos."(Field 5800)".

        }
        modify("Copy Cmts Ret.Ord. to Ret.Rcpt")
        {
            Caption = 'Copy Cmts Ret.Ord. to Ret.Rcpt';

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Copy Cmts Ret.Ord. to Ret.Rcpt"(Field 5801)".

        }
        modify("Copy Cmts Ret.Ord. to Cr. Memo")
        {
            Caption = 'Copy Cmts Ret.Ord. to Cr. Memo';

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Copy Cmts Ret.Ord. to Cr. Memo"(Field 5802)".

        }
        modify("Return Order Nos.")
        {
            Caption = 'Return Order Nos.';

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Return Order Nos."(Field 6600)".

        }
        modify("Return Receipt on Credit Memo")
        {
            Caption = 'Return Receipt on Credit Memo';

            //Unsupported feature: Property Insertion (AccessByPermission) on ""Return Receipt on Credit Memo"(Field 6601)".

        }
        modify("Exact Cost Reversing Mandatory")
        {
            Caption = 'Exact Cost Reversing Mandatory';
        }
        modify("Customer Group Dimension Code")
        {
            Caption = 'Customer Group Dimension Code';
        }
        modify("Salesperson Dimension Code")
        {
            Caption = 'Salesperson Dimension Code';
        }
        field(46; "Allow Document Deletion Before"; Date)
        {
            Caption = 'Allow Document Deletion Before';
        }
        field(50; "Default Item Quantity"; Boolean)
        {
            Caption = 'Default Item Quantity';
        }
        field(51; "Create Item from Description"; Boolean)
        {
            Caption = 'Create Item from Description';
        }
        field(7103; "Freight G/L Acc. No."; Code[20])
        {
            Caption = 'Freight G/L Acc. No.';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                CheckGLAccPostingTypeBlockedAndGenProdPostingType("Freight G/L Acc. No.");
            end;
        }
        field(50000; "Active Quantity Management"; Boolean)
        {
            Caption = 'Activation Quantité Modification';
            Description = 'NSC1.02';
        }
        field(50001; "Active Released Printing Order"; Boolean)
        {
            Caption = 'Activation Lancement de commande obligatoire';
            Description = 'NSC1.02';
        }
        field(50002; "Purchasing Code Grouping Line"; Code[10])
        {
            Caption = 'Purchasing Code Grouping Line';
            Description = 'NSC2.03';
            TableRelation = Purchasing;
        }
        field(50003; "Technicals Directory Path"; Text[250])
        {
            Caption = 'Technicals Directory Path';
            Description = 'CNE6.01';
        }
        field(50004; "SAV Return Order Nos."; Code[10])
        {
            AccessByPermission = TableData 6660 = R;
            Caption = 'SAV Return Order Nos.';
            Description = 'BC6';
            TableRelation = "No. Series";
        }
        field(60000; Repertoire; Text[250])
        {
            Description = 'SOBH NSC1.01';
        }
        field(60001; "E-Mail Administrateur"; Text[250])
        {
            Description = 'SOBH NSC1.01';
        }
        field(60002; "Promised Delivery Date"; Boolean)
        {
            Caption = 'Promised Delivery Date';
            Description = 'JH NSC1.01';
        }
        field(60003; "Requested Delivery Date"; Boolean)
        {
            Caption = 'Requested Delivery Date';
            Description = 'JH NSC1.01';
        }
        field(60004; "Période"; DateFormula)
        {
            Caption = 'Period';
        }
        field(60005; Nbr_Devis; Integer)
        {
            Caption = 'Sales Qote';
        }
        field(60006; "PDF Mail Tag"; Text[30])
        {
            Caption = 'PDF Mail Tags';
            Description = 'SEBC NSC1.01';
        }
        field(60007; "Update Price Allow Line disc."; Boolean)
        {
            Caption = 'Update Price Allow Line disc.';
            Description = 'SEBC NSC1.01';
        }
        field(60008; "allow Profit% to"; Code[20])
        {
            Caption = 'Allow Profit % visualisation to ';
            TableRelation = "Permission Set"."Role ID";
        }
        field(60009; "Contact's Address on sales doc"; Boolean)
        {
            Caption = 'Contact''s Address on sales doc';
        }
        field(60010; "RTE Fax Tag"; Text[30])
        {
            Description = 'MICO NSC';
        }
        field(80800; "DEEE Management"; Boolean)
        {
            Caption = 'DEEE Management';
            Description = 'DEEE1.00';
        }
    }

    procedure GetLegalStatement(): Text
    begin
        EXIT('');
    end;

    local procedure CheckGLAccPostingTypeBlockedAndGenProdPostingType(AccNo: Code[20])
    var
        GLAcc: Record "15";
    begin
        IF AccNo <> '' THEN BEGIN
            GLAcc.GET(AccNo);
            GLAcc.CheckGLAcc;
            GLAcc.TESTFIELD("Gen. Prod. Posting Group");
        END;
    end;
}

