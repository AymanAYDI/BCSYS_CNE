tableextension 50007 "BC6_Item" extends Item //27
{
    fields
    {
        field(50000; "BC6_Creation Date"; Date)
        {
            Caption = 'Creation Date', comment = 'FRA="Date de création"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50001; BC6_User; Code[50])
        {
            Caption = 'User', comment = 'FRA="Utilisateur"';
            Editable = false;
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(50021; "BC6_Item Sales Profit Group"; Code[10])
        {
            Caption = 'Item Sales Profit Group', comment = 'FRA="Goupe Marge Vente Article"';
            TableRelation = "BC6_Item Sales Profit Group";
            DataClassification = CustomerContent;
        }
        field(50040; "BC6_Pick Qty."; Decimal)
        {
            CalcFormula = Sum("Warehouse Activity Line"."Qty. Outstanding (Base)" WHERE("Location Code" = FIELD("Location Filter"),
                                                                                         "Bin Code" = FIELD("Bin Filter"),
                                                                                         "Item No." = FIELD("No."),
                                                                                         "Variant Code" = FIELD("Variant Filter"),
                                                                                         "Action Type" = CONST(Take),
                                                                                         "Lot No." = FIELD("Lot No. Filter"),
                                                                                         "Serial No." = FIELD("Serial No. Filter")));
            Caption = 'Pick Qty.', comment = 'FRA="Prélever qté"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50041; "BC6_Unit Price Includes VAT"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price Includes VAT', comment = 'FRA="Prix Public TTC"';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(50042; "BC6_Print Unit Price Incl. VAT"; Boolean)
        {
            AutoFormatType = 2;
            Caption = 'Print Unit Price Includes VAT On Label', comment = 'FRA="Imprimer Prix Public TTC sur étiquette"';
            MinValue = false;
            DataClassification = CustomerContent;
        }
        field(50050; "BC6_Cost Increase Coeff %"; Decimal)
        {
            Caption = 'Cost Increase Coeff (%)', comment = 'FRA="Coeff majoration du coût (%)"';
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(50051; "BC6_Search Description 2"; Code[50])
        {
            Caption = 'Search Description 2', comment = 'FRA="Désignation de recherche 2"';
            DataClassification = CustomerContent;
        }
        field(50060; "BC6_Qty. Return Order SAV"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST("Return Order"),
                                                                            Type = CONST(Item),
                                                                            "No." = FIELD("No."),
                                                                            "BC6_Return Order Type" = FILTER(SAV),
                                                                            "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                            "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                            "Location Code" = FIELD("Location Filter"),
                                                                            "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                            "Variant Code" = FIELD("Variant Filter"),
                                                                            "Shipment Date" = FIELD("Date Filter")));
            Caption = ' Qty. Return Order SAV', comment = 'FRA="Qté sur retour vente SAV"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80800; "BC6_DEEE Category Code"; Code[10])
        {
            Caption = 'DEEE Category Code ', comment = 'FRA="Code tarif DEEE"';
            TableRelation = "BC6_Categories of item".Category WHERE("Eco Partner" = FIELD("BC6_Eco partner DEEE"));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF ("BC6_DEEE Category Code") = ''
                  THEN BEGIN
                    "BC6_DEEE Category Code" := '';
                    "BC6_DEEE Unit Tax" := 0;
                    "BC6_Number of Units DEEE" := 0;
                    "BC6_Eco partner DEEE" := '';
                END;
            end;
        }
        field(80801; "BC6_DEEE Unit Tax"; Decimal)
        {
            Caption = 'DEEE Unit Tax', comment = 'FRA="Coût unitaire de la taxe"';
            DataClassification = CustomerContent;
        }
        field(80802; "BC6_Number of Units DEEE"; Decimal)
        {
            Caption = 'Number of Units DEEE', comment = 'FRA="Nombre d''unités DEEE"';
            DataClassification = CustomerContent;
        }
        field(80803; "BC6_Eco partner DEEE"; Code[20])
        {
            Caption = 'Eco partner DEEE', comment = 'FRA="Eco partenaire DEEE"';
            TableRelation = Vendor;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF ("BC6_Eco partner DEEE") = ''
                  THEN BEGIN
                    "BC6_DEEE Category Code" := '';
                    "BC6_DEEE Unit Tax" := 0;
                    "BC6_Number of Units DEEE" := 0;
                    "BC6_Eco partner DEEE" := '';
                END;
            end;
        }
    }
    keys
    {
        key(Key20; "BC6_Search Description 2")
        {
        }
    }

    procedure CalcQtyAvailToPick(ExcludeQty: Decimal): Decimal
    var
    begin
        CALCFIELDS(Inventory, "BC6_Pick Qty.");
        EXIT(Inventory - ("BC6_Pick Qty." - ExcludeQty));
    end;

    LOCAL PROCEDURE GetGLSetup();
    BEGIN
        IF NOT GLSetupRead THEN
            GLSetup.GET();
        GLSetupRead := TRUE;
    END;

    var
        GLSetup: Record "General Ledger Setup";
        GLSetupRead: Boolean;
}
