tableextension 50070 "BC6_ReturnReceiptLine" extends "Return Receipt Line"
{
    fields
    {
        field(50020; "BC6_Customer Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Client';
            Description = 'GRPMARGECLT SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            TableRelation = "Customer Sales Profit Group";
        }
        field(50021; "BC6_Item Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Article';
            Description = 'GRPMARGEPROD SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            TableRelation = "BC6_Item Sales Profit Group";
        }
        field(50022; "BC6_Public Price"; Decimal)
        {
            Caption = 'Tarif Public';
            DecimalPlaces = 2 : 5;
            Description = 'TARIFPUB SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            Editable = false;
        }
        field(50023; "BC6_External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            Description = 'Pour Le Besoin De Regroupement BL par N° Doc Externe';
        }
        field(50024; "BC6_Amount(LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
            Description = 'Pour Le Besoin De l''Etat Bible';
        }
        field(50025; "BC6_Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            Description = 'FE004 pour generer demande prix';
            TableRelation = Vendor;
        }
        field(50026; "BC6_Purch. Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            Description = 'FE004';
            Editable = false;
        }
        field(50027; "BC6_Purch. Line No."; Integer)
        {
            Caption = 'Purch. Order Line No.';
            Description = 'FE004';
            Editable = false;
        }
        field(50028; "BC6_Purch. Document Type"; Option)
        {
            Caption = 'Document Type';
            Description = 'FE004';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(50029; "BC6_Ordered Quantity"; Decimal)
        {
            Caption = 'Ordered Quantity';
            Description = 'FE001.V1';
        }
        field(50030; "BC6_Qty Shipped"; Decimal)
        {
            Caption = 'Delivered Quantity';
            Description = 'FE001.V1';
            Enabled = false;
        }
        field(50031; "BC6_Discount Unit Price"; Decimal)
        {
            Caption = 'Discount unit price excluding VAT';
            Editable = false;
        }
        field(50032; "BC6_Availability Item"; Decimal)
        {
            Caption = 'Availability Item';
            Description = 'FE001.V1';
        }
        field(50033; "BC6_Outstanding Qty"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            Description = 'FE001.V1';
            Enabled = false;
        }
        field(50041; "BC6_Purchase Cost"; Decimal)
        {
            Caption = 'Purchase cost';
            DecimalPlaces = 2 : 5;
            Description = 'hors taxe';
            Editable = false;

            trigger OnValidate()
            begin
                //COUT_ACHAT FG 20/12/06 NSC1.01
                //>>Propagation CASC 18/01/2007
                //CalcProfit ;
                //<<Propagation CASC 18/01/2007
                //CalcDiscount ;
                //Fin COUT_ACHAT FG 20/12/06 NSC1.01
            end;
        }
        field(50051; "BC6_Affect Purchase Order"; Boolean)
        {
            Caption = 'Affect purchase order';
        }
        field(50052; "BC6_Order Purchase Affected"; Boolean)
        {
            Caption = 'Order purchase affected';
            Editable = false;
        }
    }
    keys
    {
        key(Key7; "No.")
        {
        }
    }
}

