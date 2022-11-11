tableextension 50004 "BC6_SalesShipmentLine" extends "Sales Shipment Line" //111
{
    fields
    {
        field(50020; "BC6_Custom. Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Client', comment = 'FRA=""';
            Description = 'GRPMARGECLT SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            TableRelation = "Customer Sales Profit Group";
            DataClassification = CustomerContent;
        }
        field(50021; "BC6_Item Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Article', comment = 'FRA=""';
            Description = 'GRPMARGEPROD SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            TableRelation = "BC6_Item Sales Profit Group";
            DataClassification = CustomerContent;
        }
        field(50022; "BC6_Public Price"; Decimal)
        {
            Caption = 'Tarif Public', comment = 'FRA=""';
            Description = 'TARIFPUB SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50023; "BC6_External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            Description = 'Pour Le Besoin De Regroupement BL par N° Doc Externe';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                Rec_ShptHeader: Record "Sales Shipment Header";
                PagLSalesShipments: Page "Posted Sales Shipments";
            begin
                Rec_ShptHeader.RESET();
                Rec_ShptHeader.SETFILTER(Rec_ShptHeader."External Document No.", "BC6_External Document No.");
                if Rec_ShptHeader.FIND('-') then begin
                    PagLSalesShipments.SETRECORD(Rec_ShptHeader);
                    PagLSalesShipments.RUN();
                end;
            end;
        }
        field(50024; "BC6_Amount(LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
            Description = 'Pour Le Besoin De l''Etat Bible';
            DataClassification = CustomerContent;
        }
        field(50025; "BC6_Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            Description = 'FE004 pour generer demande prix';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(50026; "BC6_Purch. Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            Description = 'FE004';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50027; "BC6_Purch. Line No."; Integer)
        {
            Caption = 'Purch. Order Line No.';
            Description = 'FE004';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50028; "BC6_Purch. Document Type"; enum "Purchase Document Type")
        {
            Caption = 'Document Type';
            Description = 'FE004';
            DataClassification = CustomerContent;
        }
        field(50029; "BC6_Ordered Quantity"; Decimal)
        {
            Caption = 'Ordered Quantity';
            Description = 'FE001.V1';
            DataClassification = CustomerContent;
        }
        field(50030; "BC6_Qty Shipped"; Decimal)
        {
            Caption = 'Delivered Quantity';
            Description = 'FE001.V1';
            DataClassification = CustomerContent;
        }
        field(50031; "BC6_Discount Unit Price"; Decimal)
        {
            Caption = 'Discount unit price excluding VAT';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50032; "BC6_Availability Item"; Decimal)
        {
            Caption = 'Availability Item';
            Description = 'FE001.V1';
            DataClassification = CustomerContent;
        }
        field(50033; "BC6_Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            Description = 'FE001.V1';
            DataClassification = CustomerContent;
        }
        field(50041; "BC6_Purchase Cost"; Decimal)
        {
            Caption = 'Purchase cost';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50051; "BC6_Affect Purchase Order"; Boolean)
        {
            Caption = 'Affect purchase order';
            DataClassification = CustomerContent;
        }
        field(50052; "BC6_Order Purchase Affected"; Boolean)
        {
            Caption = 'Order purchase affected';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50060; "BC6_Purchase No. Order Lien"; Code[20])
        {
            Caption = 'Purchase No. Order Lien';
            Description = 'CNEIC';
            DataClassification = CustomerContent;
        }
        field(50061; "BC6_Purchase No. Line Lien"; Integer)
        {
            Caption = 'Purchase No. Line Lien';
            Description = 'CNEIC';
            DataClassification = CustomerContent;
        }
        field(50100; "BC6_Item Disc. Group"; Code[20])
        {
            Caption = 'Groupe remise article';
            Description = 'CNE1.02';
            TableRelation = "Item Discount Group";
            DataClassification = CustomerContent;
        }
        field(50101; "BC6_Dispensation No."; Code[20])
        {
            Caption = 'N° dérogation';
            Description = 'CNE1.02';
            DataClassification = CustomerContent;
        }
        field(50102; "BC6_Additional Discount %"; Decimal)
        {
            Caption = '% remise complémentaire';
            Description = 'CNE1.02';
            DataClassification = CustomerContent;
        }
        field(50103; "BC6_Dispensed Purchase Cost"; Decimal)
        {
            Caption = 'Coût d''achat dérogé';
            Description = 'CNE1.02';
            DataClassification = CustomerContent;
        }
        field(50104; "BC6_Standard Net Price"; Decimal)
        {
            Caption = 'Prix net standard';
            Description = 'CNE1.02';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key8; "Document No.", "Sell-to Customer No.", "No.")
        {
        }
        key(Key9; "No.")
        {
        }
        key(Key10; Type, "No.")
        {
        }
    }
}
