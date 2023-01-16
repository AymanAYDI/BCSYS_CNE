tableextension 50032 "BC6_PurchRcptLine" extends "Purch. Rcpt. Line" //121
{
    fields
    {
        field(50000; "BC6_Sales No."; Code[20])
        {
            Caption = 'Sales Order No.', comment = 'FRA="N° commande vente"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50001; "BC6_Sales Line No."; Integer)
        {
            Caption = 'Sales Order Line No.', comment = 'FRA="N° ligne commande vente"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50002; "BC6_Sales Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type', comment = 'FRA="Type document"';
            DataClassification = CustomerContent;
        }
        field(50022; "BC6_Public Price"; Decimal)
        {
            Caption = 'Public Price', comment = 'FRA="Tarif Public"';
            DataClassification = CustomerContent;
        }
        field(50031; "BC6_Discount Direct Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Discount Direct Unit Cost excluding VAT', comment = 'FRA="Coût unitaire direct remisé HT"';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                VALIDATE("Line Discount %");
            end;
        }
    }
    keys
    {
        key(Key8; "No.")
        {
        }
        key(Key9; Type, "No.")
        {
        }
        key(Key10; "No.", "Buy-from Vendor No.", "Document No.", "Line No.")
        {
        }
    }
}
