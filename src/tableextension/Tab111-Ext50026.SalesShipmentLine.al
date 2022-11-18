tableextension 50026 "BC6_SalesShipmentLine" extends "Sales Shipment Line" //111
{
    fields
    {
        field(50020; "BC6_Custom. Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Client', comment = 'FRA="Goupe Marge Vente Client"';
            TableRelation = "Customer Sales Profit Group";
            DataClassification = CustomerContent;
        }
        field(50021; "BC6_Item Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Article', comment = 'FRA="Goupe Marge Vente Article"';
            TableRelation = "BC6_Item Sales Profit Group";
            DataClassification = CustomerContent;
        }
        field(50022; "BC6_Public Price"; Decimal)
        {
            Caption = 'Tarif Public', comment = 'FRA="Tarif Public"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50023; "BC6_External Document No."; Code[35])
        {
            Caption = 'External Document No.', comment = 'FRA="N° doc. externe"';
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
            Caption = 'Amount (LCY)', comment = 'FRA="Montant DS"';
            DataClassification = CustomerContent;
        }
        field(50025; "BC6_Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.', comment = 'FRA="N° preneur d''ordre"';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(50026; "BC6_Purch. Order No."; Code[20])
        {
            Caption = 'Purchase Order No.', comment = 'FRA="N° commande achat"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50027; "BC6_Purch. Line No."; Integer)
        {
            Caption = 'Purch. Order Line No.', comment = 'FRA="N° ligne commande achat"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50028; "BC6_Purch. Document Type"; enum "Purchase Document Type")
        {
            Caption = 'Document Type', comment = 'FRA="Type document"';
            DataClassification = CustomerContent;
        }
        field(50029; "BC6_Ordered Quantity"; Decimal)
        {
            Caption = 'Ordered Quantity', comment = 'FRA="Quantité commandée"';
            DataClassification = CustomerContent;
        }
        field(50030; "BC6_Qty Shipped"; Decimal)
        {
            Caption = 'Delivered Quantity', comment = 'FRA="Quantité livrée"';
            DataClassification = CustomerContent;
        }
        field(50031; "BC6_Discount Unit Price"; Decimal)
        {
            Caption = 'Discount unit price excluding VAT', comment = 'FRA="Prix unitaire remisé HT"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50032; "BC6_Availability Item"; Decimal)
        {
            Caption = 'Availability Item', comment = 'FRA="Disponibilité article"';
            DataClassification = CustomerContent;
        }
        field(50033; "BC6_Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity', comment = 'FRA="quantité restante"';
            DataClassification = CustomerContent;
        }
        field(50041; "BC6_Purchase Cost"; Decimal)
        {
            Caption = 'Purchase cost', comment = 'FRA="Coût d''achat"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50051; "BC6_Affect Purchase Order"; Boolean)
        {
            Caption = 'Affect purchase order', comment = 'FRA="Affecter commande achat"';
            DataClassification = CustomerContent;
        }
        field(50052; "BC6_Order Purchase Affected"; Boolean)
        {
            Caption = 'Order purchase affected', comment = 'FRA="Commande achat affectée"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50060; "BC6_Purchase No. Order Lien"; Code[20])
        {
            Caption = 'Purchase No. Order Lien', comment = 'FRA="N° Commande Achat Lien"';
            DataClassification = CustomerContent;
        }
        field(50061; "BC6_Purchase No. Line Lien"; Integer)
        {
            Caption = 'Purchase No. Line Lien', comment = 'FRA="N° ligne Commande Achat Lien"';
            DataClassification = CustomerContent;
        }
        field(50100; "BC6_Item Disc. Group"; Code[20])
        {
            Caption = 'Groupe remise article', comment = 'FRA="Groupe remise article"';
            TableRelation = "Item Discount Group";
            DataClassification = CustomerContent;
        }
        field(50101; "BC6_Dispensation No."; Code[20])
        {
            Caption = 'N° dérogation', comment = 'FRA="N° dérogation"';
            DataClassification = CustomerContent;
        }
        field(50102; "BC6_Additional Discount %"; Decimal)
        {
            Caption = '% remise complémentaire', comment = 'FRA="% remise complémentaire"';
            DataClassification = CustomerContent;
        }
        field(50103; "BC6_Dispensed Purchase Cost"; Decimal)
        {
            Caption = 'Coût d''achat dérogé', comment = 'FRA="Coût d''achat dérogé"';
            DataClassification = CustomerContent;
        }
        field(50104; "BC6_Standard Net Price"; Decimal)
        {
            Caption = 'Prix net standard', comment = 'FRA="Prix net standard"';
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
