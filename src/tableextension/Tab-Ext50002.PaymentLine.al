tableextension 50002 "BC6_PaymentLine" extends "Payment Line"
{
    LookupPageID = "Payment Lines List";
    DrillDownPageID = "Payment Lines List";
    fields
    {
        modify("Account No.")
        {
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset";
        }
        modify("Posting Group")
        {
            TableRelation = IF ("Account Type" = CONST(Customer)) "Customer Posting Group"
            ELSE
            IF ("Account Type" = CONST(Vendor)) "Vendor Posting Group"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "FA Posting Group";
        }
        modify("Acc. No. Last Entry Debit")
        {
            TableRelation = IF ("Acc. Type Last Entry Debit" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Acc. Type Last Entry Debit" = CONST(Customer)) Customer
            ELSE
            IF ("Acc. Type Last Entry Debit" = CONST(Vendor)) Vendor
            ELSE
            IF ("Acc. Type Last Entry Debit" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Acc. Type Last Entry Debit" = CONST("Fixed Asset")) "Fixed Asset";
        }
        modify("Acc. No. Last Entry Credit")
        {
            TableRelation = IF ("Acc. Type Last Entry Credit" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Acc. Type Last Entry Credit" = CONST(Customer)) Customer
            ELSE
            IF ("Acc. Type Last Entry Credit" = CONST(Vendor)) Vendor
            ELSE
            IF ("Acc. Type Last Entry Credit" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Acc. Type Last Entry Credit" = CONST("Fixed Asset")) "Fixed Asset";
        }

        modify("Bank Account Code")
        {
            TableRelation = IF ("Account Type" = CONST(Customer)) "Customer Bank Account".Code WHERE("Customer No." = FIELD("Account No."))
            ELSE
            IF ("Account Type" = CONST(Vendor)) "Vendor Bank Account".Code WHERE("Vendor No." = FIELD("Account No."));
        }
        modify("Payment Address Code")
        {
            TableRelation = "Payment Address".Code WHERE("Account Type" = FIELD("Account Type"),
                                                          "Account No." = FIELD("Account No."));
        }
        modify(IBAN)
        {
            Caption = 'IBAN', Comment = '{Locked}';
        }

    }
    keys
    {
        key(Key6; "Due Date", "Document No.")
        {
        }
    }
}

