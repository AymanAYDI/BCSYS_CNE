tableextension 50007 "BC6_SalesCrMemoHeader" extends "Sales Cr.Memo Header"
{
    LookupPageID = "Posted Sales Credit Memos";
    DrillDownPageID = "Posted Sales Credit Memos";
    fields
    {
        modify("Bal. Account No.")
        {
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";
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
            TableRelation = User;
            //TODO
            // trigger OnLookup()
            // var
            //     RecLUserMgt: Codeunit "418";
            //     CodLUserID: Code[50];
            // begin
            //     CodLUserID := ID;
            //     RecLUserMgt.LookupUserID(CodLUserID);
            // end;
        }
        field(50020; "BC6_Custom. Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Client';
            Description = 'GRPMARGECLT SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            TableRelation = "Customer Sales Profit Group";
        }
        field(50025; "BC6_Combine Shipments by Order"; Boolean)
        {
            Caption = 'Combine Shipment By Order';
            Description = 'FE018 regroupement BL par CMD';
        }
        field(50026; "BC6_Purchase cost"; Decimal)
        {
            Caption = 'Purchase Cost';
            Description = 'SM Besoin pour Etat Bible _ champ inutilisable copie flowfiled';
            Editable = false;
            FieldClass = Normal;
        }
        field(50030; "BC6_Sales LCY"; Decimal)
        {
            Caption = 'Ventes DS';
            Description = 'SM Besoin Etat Bible';
        }
        field(50031; "BC6_Profit LCY"; Decimal)
        {
            Caption = 'Marge DS';
            Description = 'SM  Besoin Etat Bible';
        }
        field(50032; "BC6_% Profit"; Decimal)
        {
            Caption = '% de marge sur vente';
            Description = 'SM  Besoin Etat Bible';
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
            Description = 'FE005 SEBC 08/01/2007';
        }
        field(50062; "BC6_Sell-to E-Mail Address"; Text[50])
        {
            Description = 'FE005 MICO 20/02/2007';
        }
        field(50100; "BC6_Salesperson Filter"; Text[250])
        {
            Caption = 'Salesperson Filter';
            Editable = false;
        }
    }
    keys
    {

        key(Key10; "Posting Date")
        {
        }
    }


}

