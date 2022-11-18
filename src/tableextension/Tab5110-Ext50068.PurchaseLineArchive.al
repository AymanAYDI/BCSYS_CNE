tableextension 50068 "BC6_PurchaseLineArchive" extends "Purchase Line Archive" //5110
{
    fields
    {
        field(50000; "BC6_Sales No."; Code[20])
        {
            Caption = 'Sales Order No.', Comment = 'FRA="N° commande vente"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50001; "BC6_Sales Line No."; Integer)
        {
            Caption = 'Sales Order Line No.', Comment = 'FRA="N° ligne commande vente"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Sales Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type', Comment = 'FRA="Type document"';
            DataClassification = CustomerContent;
        }
        field(50022; "BC6_Public Price"; Decimal)
        {
            Caption = 'Tarif Public', Comment = 'FRA="Tarif Public"';
            DataClassification = CustomerContent;
        }
        field(50031; "BC6_Discount Direct Unit Cost"; Decimal)
        {
            Caption = 'Discount Direct Unit Cost', Comment = 'FRA="Coût unitaire direct remisé HT"';
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                VALIDATE("Line Discount %");
            end;
        }
    }
    keys
    {
        key(Key6; Type, "No.")
        {
        }
    }
}

