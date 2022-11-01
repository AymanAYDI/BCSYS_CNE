tableextension 50031 "BC6_PurchasesPayablesSetup" extends "Purchases & Payables Setup"
{
    LookupPageID = "Purchases & Payables Setup";
    DrillDownPageID = "Purchases & Payables Setup";
    fields
    {
        field(50000; "BC6_SAV Return Order Nos."; Code[10])
        {
            AccessByPermission = TableData "Return Shipment Header" = R;
            Caption = 'SAV Return Order Nos.';
            TableRelation = "No. Series";
        }
        field(60000; "BC6_Minima de cde"; Boolean)
        {
            Caption = 'Montant mini pour franco';
        }
        field(60001; BC6_Type; enum "Purchase Line Type")
        {
            Caption = 'Type';
        }
        field(60002; "BC6_No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (BC6_Type = CONST(" ")) "Standard Text"
            ELSE
            IF (BC6_Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (BC6_Type = CONST(Item)) Item
            ELSE
            IF (BC6_Type = CONST(Resource)) Resource
            ELSE
            IF (BC6_Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (BC6_Type = CONST("Charge (Item)")) "Item Charge";

        }
        field(60003; "BC6_Ask custom purch price"; Boolean)
        {
            Caption = 'Ask For custom Purchase Price';
        }
        field(80800; "BC6_DEEE Management"; Boolean)
        {
            Caption = 'DEEE Management';
        }
    }
}

