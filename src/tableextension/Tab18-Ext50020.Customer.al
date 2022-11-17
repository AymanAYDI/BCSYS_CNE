tableextension 50020 "BC6_Customer" extends Customer //18
{
    fields
    {
        field(50000; "BC6_Creation Date"; Date)
        {
            Caption = 'Creation Date', Comment = 'FRA="Date de création"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50001; BC6_User; Code[20])
        {
            Caption = 'User', Comment = 'FRA="Utilisateur"';
            Editable = false;
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(50002; "BC6_Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type', Comment = 'FRA="Nature Transaction"';
            TableRelation = "Transaction Type";
            DataClassification = CustomerContent;
        }
        field(50003; "BC6_Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification', Comment = 'FRA="Régime"';
            TableRelation = "Transaction Specification";
            DataClassification = CustomerContent;
        }
        field(50004; "BC6_Transport Method"; Code[10])
        {
            Caption = 'Transport Method', Comment = 'FRA="Mode transport"';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Mode de transport';
            TableRelation = "Transport Method";
            DataClassification = CustomerContent;
        }
        field(50005; "BC6_Exit Point"; Code[10])
        {
            Caption = 'Exit Point', Comment = 'FRA="Pays Destination"';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Pays Destination';
            TableRelation = "Entry/Exit Point";
            DataClassification = CustomerContent;
        }
        field(50006; BC6_Area; Code[10])
        {
            Caption = 'Area', Comment = 'FRA="Departement Destination"';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Dep destination';
            TableRelation = Area;
            DataClassification = CustomerContent;
        }
        field(50007; "BC6_SFAC Contract Date"; Date)
        {
            Caption = 'SFAC Contract Date', Comment = 'FRA="Date contrat SFAC"';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [SFAC] Ajout du champ';
            DataClassification = CustomerContent;
        }
        field(50008; "BC6_SFAC Contract No."; Code[20])
        {
            Caption = 'SFAC Contract No.', Comment = 'FRA="N° contrat SFAC"';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [SFAC] Ajout du champ';
            DataClassification = CustomerContent;
        }
        field(50009; "BC6_Pay-to Customer No."; Code[20])
        {
            Caption = 'Pay-to Customer No.', Comment = 'FRA="Tiers payeur"';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Customer;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF CONFIRM(STRSUBSTNO(TextGestTiersPayeur001, "BC6_Pay-to Customer No.")) THEN
                    updateLedgerEntries("No.", "BC6_Pay-to Customer No.");
            end;
        }
        field(50010; "BC6_Salesperson Filter"; Text[250])
        {
            Caption = 'Salesperson Filter', Comment = 'FRA="Filtre vendeur"';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                RecLSalesHeader: Record "Sales Header";
                RecLSalesShptHeader: Record "Sales Shipment Header";
                RecLSalesInvHeader: Record "Sales Invoice Header";
                RecLSalesCrMemoHeader: Record "Sales Shipment Header";
            begin

                RecLSalesHeader.SETCURRENTKEY("Document Type", "Bill-to Customer No.");
                RecLSalesHeader.SETRANGE("Bill-to Customer No.", "No.");
                RecLSalesHeader.MODIFYALL("BC6_Salesperson Filter", "BC6_Salesperson Filter");

                RecLSalesShptHeader.SETCURRENTKEY("Bill-to Customer No.");
                RecLSalesShptHeader.SETRANGE("Bill-to Customer No.", "No.");
                RecLSalesShptHeader.MODIFYALL("BC6_Salesperson Filter", "BC6_Salesperson Filter");

                RecLSalesInvHeader.SETCURRENTKEY("Bill-to Customer No.");
                RecLSalesInvHeader.SETRANGE("Bill-to Customer No.", "No.");
                RecLSalesInvHeader.MODIFYALL("BC6_Salesperson Filter", "BC6_Salesperson Filter");

                RecLSalesCrMemoHeader.SETCURRENTKEY("Bill-to Customer No.");
                RecLSalesCrMemoHeader.SETRANGE("Bill-to Customer No.", "No.");
                RecLSalesCrMemoHeader.MODIFYALL("BC6_Salesperson Filter", "BC6_Salesperson Filter");
            end;
        }
        field(50020; "BC6_Custom. Sales Profit Group"; Code[10])
        {
            Caption = 'Goupe Marge Vente Client', Comment = 'FRA="Goupe Marge Vente Client"';
            Description = 'GRPMARGECLT SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            TableRelation = "Customer Sales Profit Group";
            DataClassification = CustomerContent;
        }
        field(50024; "BC6_Code SIREN"; Code[14])
        {
            Description = 'ImportFichiersBase RD 15/11/06 NCS1.01 [FE021] Ajout du champ Code SIREN';
            DataClassification = CustomerContent;
        }
        field(50025; "BC6_Combine Shipments by Order"; Boolean)
        {
            Caption = 'Combine Shipments by Order', Comment = 'FRA="Regrouper BL par commande"';
            Description = 'FE018 regroupement BL par CMD';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //>>FE018
                TESTFIELD("Combine Shipments", TRUE);
                //>>FE018
            end;
        }
        field(50026; "BC6_Valued Shipment"; Boolean)
        {
            Caption = 'Valued Shipment', Comment = 'FRA="BL chiffré "';
            DataClassification = CustomerContent;
        }
        field(50027; "BC6_Not Valued Shipment"; Boolean)
        {
            Caption = 'Valued Shipment', Comment = 'FRA="BL non chiffré"';
            DataClassification = CustomerContent;
        }
        field(50028; "BC6_Shipt Print All Order Line"; Boolean)
        {
            Caption = 'Shipt Print All Order Line', Comment = 'FRA="Impression B.L. toute ligne commandée"';
            DataClassification = CustomerContent;

        }
        field(50029; "BC6_Copy Sell-to Address"; Boolean)
        {
            Caption = 'Copy Sell-to Address', Comment = 'FRA="Copie adresse donneur d''ordre"';
            DataClassification = CustomerContent;

        }
        field(80800; "BC6_Submitted to DEEE"; Boolean)
        {
            Caption = 'Submitted to DEEE', Comment = 'FRA="Soumis à la DEEE"';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key23; "BC6_Pay-to Customer No.")
        {
        }
    }

    PROCEDURE "---NSC1.00---"()
    BEGIN
    END;

    procedure updateLedgerEntries(CodLCustNo: Code[20]; CodLPayToNo: Code[20])
    var
        RecLCustLedgEntry: Record "Cust. Ledger Entry";
        RecLDetCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        //Mise à jour de la Table 21 Ecriture client
        RecLCustLedgEntry.RESET();
        RecLCustLedgEntry.SETRANGE("Customer No.", CodLCustNo);
        RecLCustLedgEntry.SETRANGE(Open, TRUE);
        IF RecLCustLedgEntry.FINDSET(TRUE, FALSE) THEN
            REPEAT
                //TODO  // RecLCustLedgEntry."BC6_Pay-to Customer No." := CodLPayToNo;
                RecLCustLedgEntry.MODIFY();

                RecLDetCustLedgEntry.RESET();
                RecLDetCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", RecLCustLedgEntry."Entry No.");
                IF RecLDetCustLedgEntry.FINDSET(TRUE, FALSE) THEN
                    REPEAT
                        RecLDetCustLedgEntry."BC6_Pay-to Customer No." := CodLPayToNo;
                        RecLDetCustLedgEntry.MODIFY();
                    UNTIL RecLDetCustLedgEntry.NEXT() = 0;
            UNTIL RecLCustLedgEntry.NEXT() = 0;
    end;


    var

        TextGestTiersPayeur001: Label 'Do you want to update Open Ledger entries with new Pay-to customer No. %1?', Comment = 'FRA="Voulez-vous mettre à jour les Ecritures ouvertes avec le Nouveau N° Tiers payeur %1?"';

}

