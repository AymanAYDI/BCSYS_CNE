tableextension 50005 "BC6_SalesInvoiceHeader" extends "Sales Invoice Header"
{
    LookupPageID = "Posted Sales Invoices";
    DrillDownPageID = "Posted Sales Invoices";
    fields
    {
        modify("Bal. Account No.")
        {
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";
        }
        modify("Direct Debit Mandate ID")
        {
            TableRelation = "SEPA Direct Debit Mandate" WHERE("Customer No." = FIELD("Bill-to Customer No."));
            Caption = 'Direct Debit Mandate ID';
        }
        field(50000; "BC6_Cause filing"; Option)
        {
            Caption = 'Cause filing';
            OptionCaption = 'No proceeded,Deleted,Change in Order';
            OptionMembers = "No proceeded",Deleted,"Change in Order";
        }
        field(50003; "BC6_Pay-to Customer No."; Code[20])
        {
            Caption = 'Pay-to Customer No.';
            TableRelation = Customer;
        }
        field(50004; "BC6_Advance Payment"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            Caption = 'Advance Payment';
        }
        field(50005; "BC6_Affair No."; Code[20])
        {
            Caption = 'Affair No.';
            TableRelation = Job."No.";
        }
        field(50010; BC6_ID; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            //TODO
            // trigger OnLookup()
            // var
            //     RecLUserMgt: Codeunit "418";
            //     CodLUserID: Code[50];
            // begin
            //     //>>MIGRATION NAV 2013
            //     CodLUserID := ID;
            //     RecLUserMgt.LookupUserID(CodLUserID);
            //     //<<MIGRATION NAV 2013
            // end;
        }
        field(50020; "BC6_Custom. Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Client';
            TableRelation = "Customer Sales Profit Group";
        }
        field(50025; "BC6_Combine Shipments by Order"; Boolean)
        {
            Caption = 'Combine Shipment By Order';
        }
        field(50026; "BC6_Purchase cost"; Decimal)
        {
            Caption = 'Purchase Cost';
            Editable = false;
            FieldClass = Normal;
        }
        field(50030; "BC6_Sales LCY"; Decimal)
        {
            Caption = 'Ventes DS';

        }
        field(50031; "BC6_Profit LCY"; Decimal)
        {
            Caption = 'Marge DS';
            Editable = true;
        }
        field(50032; "BC6_% Profit"; Decimal)
        {
            Caption = '% de marge sur vente';
            Editable = false;
        }
        field(50033; BC6_Invoiced; Boolean)
        {
            Caption = 'Invoiced';
        }
        field(50040; "BC6_Prod. Version No."; Integer)
        {
            Caption = 'Version No.';
        }
        field(50050; "BC6_Document description"; Text[50])
        {
            Caption = 'Document description';
        }
        field(50060; "BC6_Quote statut"; Option)
        {
            Caption = 'Quote status';
            OptionCaption = ' ,Approved,Locked';
            OptionMembers = " ",approved,locked;
        }
        field(50061; "BC6_Sell-to Fax No."; Text[30])
        {
            Caption = 'Sell-to Fax No.';
        }
        field(50062; "BC6_Sell-to E-Mail Address"; Text[50])
        {
        }
        field(50071; "BC6_Shipment Invoiced"; Text[250])
        {
            Caption = 'Shipment Invoiced';
            Editable = false;
        }
        field(50100; "BC6_Salesperson Filter"; Text[250])
        {
            Caption = 'Salesperson Filter';
            Editable = false;
        }
    }
    keys
    {

        key(Key14; "Prepayment Invoice", "Document Exchange Status")
        {
        }
    }
    var
        SalesSetup: Record "Sales & Receivables Setup";
}

