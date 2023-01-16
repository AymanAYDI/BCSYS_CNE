tableextension 50066 "BC6_SalesLineArchive" extends "Sales Line Archive" //5108
{
    fields
    {
        field(50000; "BC6_Document Date flow"; Date)
        {
            CalcFormula = Lookup("Sales Header"."Document Date" WHERE("No." = FIELD("Document No."), "Document Type" = FIELD("Document Type")));
            Caption = 'Document Date', Comment = 'FRA="Date document"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "BC6_To Prepare"; Boolean)
        {
            Caption = 'To Prepare', Comment = 'FRA="A préparer"';
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Purchase Receipt Date"; Date)
        {
            Caption = 'Purchase Receipt Date', Comment = 'FRA="Date réception achat"';
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Qty. To Order"; Decimal)
        {
            Caption = 'Qty. To Order', Comment = 'FRA="Qté à commander"';
            DataClassification = CustomerContent;
        }
        field(50004; "BC6_Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;
        }
        field(50005; "BC6_Forecast Inventory"; Integer)
        {
            Caption = 'Forecast Inventory', Comment = 'FRA="Stock prévisionnel"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50007; "BC6_To Order"; Boolean)
        {
            Caption = 'To Order', Comment = 'FRA="A commander"';
            DataClassification = CustomerContent;
        }
        field(50008; "BC6_Promised Pur. Receipt Date"; Boolean)
        {
            Caption = 'Purchase Receipt Date', Comment = 'FRA="Date réception achat confirmée"';
            DataClassification = CustomerContent;
        }
        field(50020; "BC6_Cust. Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Client', Comment = 'FRA="Goupe Marge Vente Client"';
            DataClassification = CustomerContent;
            TableRelation = "Customer Sales Profit Group";
        }
        field(50021; "BC6_Item Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Article', Comment = 'FRA="Goupe Marge Vente Article"';
            DataClassification = CustomerContent;
            TableRelation = "BC6_Item Sales Profit Group";
        }
        field(50022; "BC6_Public Price"; Decimal)
        {
            Caption = 'Tarif Public', Comment = 'FRA="Tarif Public"';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
            Editable = false;
        }
        field(50023; "BC6_External Document No."; Code[35])
        {
            Caption = 'External Document No.', Comment = 'FRA="N° doc. externe"';
            DataClassification = CustomerContent;
        }
        field(50024; "BC6_Amount(LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)', Comment = 'FRA="Montant DS"';
            DataClassification = CustomerContent;
        }
        field(50025; "BC6_Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.', Comment = 'FRA="N° preneur d''ordre"';
            DataClassification = CustomerContent;
            TableRelation = Vendor;
        }
        field(50026; "BC6_Purch. Order No."; Code[20])
        {
            Caption = 'Purchase Order No.', Comment = 'FRA="N° commande achat"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50027; "BC6_Purch. Line No."; Integer)
        {
            Caption = 'Purch. Order Line No.', Comment = 'FRA="N° ligne commande achat"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50028; "BC6_Purch. Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type', Comment = 'FRA="Type document"';
            DataClassification = CustomerContent;
        }
        field(50029; "BC6_Ordered Quantity"; Decimal)
        {
            Caption = 'Ordered Quantity', Comment = 'FRA="Quantité commandée"';
            DataClassification = CustomerContent;
        }
        field(50030; "BC6_Qty Shipped"; Decimal)
        {
            Caption = 'Delivered Quantity', Comment = 'FRA="Quantité livrée"';
            DataClassification = CustomerContent;
            Enabled = false;
        }
        field(50031; "BC6_Discount Unit Price"; Decimal)
        {
            Caption = 'Discount unit price excluding VAT', Comment = 'FRA="Prix unitaire remisé HT"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50032; "BC6_Availability Item"; Decimal)
        {
            Caption = 'Availability Item', Comment = 'FRA="Disponibilité article"';
            DataClassification = CustomerContent;
        }
        field(50033; "BC6_Outstanding Qty"; Decimal)
        {
            Caption = 'Outstanding Quantity', Comment = 'FRA="quantité restante"';
            DataClassification = CustomerContent;
            Enabled = false;
        }
        field(50040; "BC6_Pick Qty."; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding (Base)" WHERE("Source Type" = CONST(37),
                                                                                         "Source Subtype" = CONST(1),
                                                                                         "Source No." = FIELD("Document No."),
                                                                                         "Source Line No." = FIELD("Line No."),
                                                                                         "Action Type" = CONST(Take)));
            Caption = 'Pick Qty.', Comment = 'FRA="Prélever qté"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50041; "BC6_Purchase Cost"; Decimal)
        {
            Caption = 'Purchase cost', Comment = 'FRA="Coût d''achat"';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
            Editable = false;

            trigger OnValidate()
            begin
                //COUT_ACHAT FG 20/12/06 NSC1.01
                //>>Propoagation CASC 18/01/2007
                //CalcProfit ;
                //<<propagation CASC 18/01/2007
                //CalcDiscount ;
                //Fin COUT_ACHAT FG 20/12/06 NSC1.01
            end;
        }
        field(50051; "BC6_Affect Purchase Order"; Boolean)
        {
            Caption = 'Affect purchase order', Comment = 'FRA="Affecter commande achat"';
            DataClassification = CustomerContent;
        }
        field(50052; "BC6_Order Purchase Affected"; Boolean)
        {
            Caption = 'Order purchase affected', Comment = 'FRA="Commande achat affectée"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50060; "BC6_Purchase No. Order Lien"; Code[20])
        {
            Caption = 'Purchase No. Order Lien', Comment = 'FRA="N° Commande Achat Lien"';
            DataClassification = CustomerContent;
        }
        field(50061; "BC6_Purchase No. Line Lien"; Integer)
        {
            Caption = 'Purchase No. Line Lien', Comment = 'FRA="N° ligne Commande Achat Lien"';
            DataClassification = CustomerContent;
        }
        field(50100; "BC6_Item Disc. Group"; Code[10])
        {
            Caption = 'Groupe remise article', Comment = 'FRA="Groupe remise article"';
            DataClassification = CustomerContent;
            TableRelation = "Item Discount Group";
        }
        field(50101; "BC6_Dispensation No."; Code[20])
        {
            Caption = 'N° dérogation', Comment = 'FRA="N° dérogation"';
            DataClassification = CustomerContent;
        }
        field(50102; "BC6_Additional Discount %"; Decimal)
        {
            Caption = '% remise complémentaire', Comment = 'FRA="% remise complémentaire"';
            DataClassification = CustomerContent;
        }
        field(50103; "BC6_Dispensed Purchase Cost"; Decimal)
        {
            Caption = 'Coût d''achat dérogé', Comment = 'FRA="Coût d''achat dérogé"';
            DataClassification = CustomerContent;
        }
        field(50104; "BC6_Standard Net Price"; Decimal)
        {
            Caption = 'Prix net standard', Comment = 'FRA="Prix net standard"';
            DataClassification = CustomerContent;
        }
        field(80800; "BC6_DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code', Comment = 'FRA="Code Catégorie DEEE"';
            DataClassification = CustomerContent;
            TableRelation = "BC6_Categories of item".Category;
        }
        field(80801; "BC6_DEEE Unit Price"; Decimal)
        {
            Caption = 'DEEE Unit Price', Comment = 'FRA="Prix Unitaire DEEE"';
            DataClassification = CustomerContent;
        }
        field(80802; "BC6_DEEE HT Amount"; Decimal)
        {
            Caption = 'DEEE HT Amount', Comment = 'FRA="Montant HT DEEE"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80803; "BC6_DEEE Unit Price (LCY)"; Decimal)
        {
            Caption = 'DEEE Unit Price (LCY)', Comment = 'FRA="Prix Unitaire DEEE (DS)"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80804; "BC6_DEEE VAT Amount"; Decimal)
        {
            Caption = 'DEEE VAT Amount', Comment = 'FRA="Montant TVA DEEE"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80805; "BC6_DEEE TTC Amount"; Decimal)
        {
            Caption = 'DEEE TTC Amount', Comment = 'FRA="Montant TTC DEEE"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80806; "BC6_DEEE HT Amount (LCY)"; Decimal)
        {
            Caption = 'DEEE HT Amount (LCY)', Comment = 'FRA="Montant Unitaire DEEE (DS)"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80807; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE', Comment = 'FRA="Montant Unitaire DEEE (DS)"';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = Vendor;
        }
        field(80808; "BC6_DEEE Amount (LCY) for Stat"; Decimal)
        {
            Caption = 'DEEE Amount (LCY) for Stat';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key7; "Document Type", Type, "No.")
        {
        }
    }
}
