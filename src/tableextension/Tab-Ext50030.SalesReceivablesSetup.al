tableextension 50030 "BC6_SalesReceivablesSetup" extends "Sales & Receivables Setup"
{
    Caption = 'Sales & Receivables Setup';
    LookupPageID = "Sales & Receivables Setup";
    DrillDownPageID = "Sales & Receivables Setup";
    fields
    {

        field(50000; "BC6_Active Quantity Management"; Boolean)
        {
            Caption = 'Activation Quantité Modification';

        }
        field(50001; "BC6_Acti. Releas. Print. Order"; Boolean)
        {
            Caption = 'Activation Lancement de commande obligatoire';

        }
        field(50002; "BC6_Purcha. Code Grouping Line"; Code[10])
        {
            Caption = 'Purchasing Code Grouping Line';
            TableRelation = Purchasing;
        }
        field(50003; "BC6_Technicals Directory Path"; Text[250])
        {
            Caption = 'Technicals Directory Path';
        }
        field(50004; "BC6_SAV Return Order Nos."; Code[10])
        {
            AccessByPermission = TableData "Return Receipt Header" = R;
            Caption = 'SAV Return Order Nos.';
            TableRelation = "No. Series";
        }
        field(60000; BC6_Repertoire; Text[250])
        { }
        field(60001; "BC6_E-Mail Administrateur"; Text[250])
        {
            Description = 'SOBH NSC1.01';
        }
        field(60002; "BC6_Promised Delivery Date"; Boolean)
        {
            Caption = 'Promised Delivery Date';
        }
        field(60003; "BC6_Requested Delivery Date"; Boolean)
        {
            Caption = 'Requested Delivery Date';
        }
        field(60004; "Période"; DateFormula)
        {
            Caption = 'Period';
        }
        field(60005; BC6_Nbr_Devis; Integer)
        {
            Caption = 'Sales Qote';
        }
        field(60006; "BC6_PDF Mail Tag"; Text[30])
        {
            Caption = 'PDF Mail Tags';
        }
        field(60007; "BC6_Upd. Price AllowLine disc."; Boolean)
        {
            Caption = 'Update Price Allow Line disc.';
        }
        field(60008; "BC6_allow Profit% to"; Code[20])
        {
            Caption = 'Allow Profit % visualisation to ';
            TableRelation = "Permission Set"."Role ID"; //TODO: Table 'Permission Set' is marked for removal. 
        }
        field(60009; "Contact's Address on sales doc"; Boolean)
        {
            Caption = 'Contact''s Address on sales doc';
        }
        field(60010; "BC6_RTE Fax Tag"; Text[30])
        {
        }
        field(80800; "BC6_DEEE Management"; Boolean)
        {
            Caption = 'DEEE Management';
        }
    }

    procedure GetLegalStatement(): Text
    begin
        EXIT('');
    end;

    local procedure CheckGLAccPostingTypeBlockedAndGenProdPostingType(AccNo: Code[20])
    var
        GLAcc: Record "G/L Account";
    begin
        IF AccNo <> '' THEN BEGIN
            GLAcc.GET(AccNo);
            GLAcc.CheckGLAcc();
            GLAcc.TESTFIELD("Gen. Prod. Posting Group");
        END;
    end;
}

