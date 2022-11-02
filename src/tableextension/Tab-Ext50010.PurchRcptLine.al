tableextension 50010 "BC6_PurchRcptLine" extends "Purch. Rcpt. Line"
{
    LookupPageID = "Posted Purchase Receipt Lines";
    DrillDownPageID = "Posted Purchase Receipt Lines";
    fields
    {
        field(50000; "BC6_Sales No."; Code[20])
        {
            Caption = 'Sales Order No.';
            Editable = false;
        }
        field(50001; "BC6_Sales Line No."; Integer)
        {
            Caption = 'Sales Order Line No.';
            Editable = false;
        }
        field(50002; "BC6_Sales Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(50022; "BC6_Public Price"; Decimal)
        {
            Caption = 'Tarif Public';
            Description = 'TARIFPUB SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
        }
        field(50031; "BC6_Discount Direct Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Discount Direct Unit Cost excluding VAT';
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
