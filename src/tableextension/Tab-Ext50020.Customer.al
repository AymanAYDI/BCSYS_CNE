tableextension 50020 "BC6_Customer" extends Customer
{
    LookupPageID = "Customer List";
    DrillDownPageID = "Customer List";
    fields
    {
        modify("Salesperson Code")
        {
            trigger OnAfterValidate()
            var
                RecLSalespersonAuthorized: Record "BC6_Salesperson authorized";
            begin
                IF "Salesperson Code" <> xRec."Salesperson Code" THEN BEGIN
                    RecLSalespersonAuthorized.SETRANGE("Customer No.", "No.");
                    IF RecLSalespersonAuthorized.FINDFIRST() THEN BEGIN
                        RecLSalespersonAuthorized.MODIFYALL(authorized, FALSE);
                        RecLSalespersonAuthorized.SETRANGE("Salesperson code", "Salesperson Code");
                        IF RecLSalespersonAuthorized.FINDFIRST() THEN BEGIN
                            RecLSalespersonAuthorized.authorized := TRUE;
                            RecLSalespersonAuthorized.MODIFY();
                        END;
                    END;
                    VALIDATE("BC6_Salesperson Filter", "Salesperson Code");

                END;
            end;

        }
        modify("Combine Shipments")
        {
            trigger OnAfterValidate()
            begin
                IF "Combine Shipments" = FALSE THEN
                    "BC6_Combine Shipments by Order" := FALSE;
            end;
        }
        field(50000; "BC6_Creation Date"; Date)
        {
            Caption = 'Creation Date';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Champs_Suppl] Ajout du champ';
            Editable = false;
        }
        field(50001; BC6_User; Code[20])
        {
            Caption = 'User';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Champs_Suppl] Ajout du champ';
            Editable = false;
            TableRelation = User;
        }
        field(50002; "BC6_Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Nature Transaction';
            TableRelation = "Transaction Type";
        }
        field(50003; "BC6_Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Régime';
            TableRelation = "Transaction Specification";
        }
        field(50004; "BC6_Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Mode de transport';
            TableRelation = "Transport Method";
        }
        field(50005; "BC6_Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Pays Destination';
            TableRelation = "Entry/Exit Point";
        }
        field(50006; BC6_Area; Code[10])
        {
            Caption = 'Area';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Incoterm] Ajout du champ - Dep destination';
            TableRelation = Area;
        }
        field(50007; "BC6_SFAC Contract Date"; Date)
        {
            Caption = 'SFAC Contract Date';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [SFAC] Ajout du champ';
        }
        field(50008; "BC6_SFAC Contract No."; Code[20])
        {
            Caption = 'SFAC Contract No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [SFAC] Ajout du champ';
        }
        field(50009; "BC6_Pay-to Customer No."; Code[20])
        {
            Caption = 'Pay-to Customer No.';
            Description = 'NAVIDIIGEST BRRI 01.08.2006 NSC1.00 [Gestion_Tiers_Payeur] Ajout du champ';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                IF CONFIRM(STRSUBSTNO(TextGestTiersPayeur001, "BC6_Pay-to Customer No.")) THEN
                    updateLedgerEntries("No.", "BC6_Pay-to Customer No.");
            end;
        }
        field(50010; "BC6_Salesperson Filter"; Text[250])
        {
            Caption = 'Salesperson Filter';
            Editable = false;

            trigger OnValidate()
            var
                RecLSalesHeader: Record "Sales Header";
                RecLSalesShptHeader: Record "Sales Shipment Header";
                RecLSalesInvHeader: Record "Sales Invoice Header";
                RecLSalesCrMemoHeader: Record "Sales Shipment Header";
            begin

                RecLSalesHeader.SETCURRENTKEY("Document Type", "Bill-to Customer No.");
                RecLSalesHeader.SETRANGE("Bill-to Customer No.", "No.");
                //TODO // RecLSalesHeader.MODIFYALL("BC6_Salesperson Filter", "BC6_Salesperson Filter");

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
            Caption = 'Goupe Marge Vente Client';
            Description = 'GRPMARGECLT SM 15/10/06 NCS1.01 [FE024V1] Ajout du champ';
            TableRelation = "Customer Sales Profit Group";
        }
        field(50024; "BC6_Code SIREN"; Code[14])
        {
            Description = 'ImportFichiersBase RD 15/11/06 NCS1.01 [FE021] Ajout du champ Code SIREN';
        }
        field(50025; "BC6_Combine Shipments by Order"; Boolean)
        {
            Caption = 'Combine Shipments by Order';
            Description = 'FE018 regroupement BL par CMD';

            trigger OnValidate()
            begin
                //>>FE018
                TESTFIELD("Combine Shipments", TRUE);
                //>>FE018
            end;
        }
        field(50026; "BC6_Valued Shipment"; Boolean)
        {
            Caption = 'Valued Shipment';
        }
        field(50027; "BC6_Not Valued Shipment"; Boolean)
        {
            Caption = 'Valued Shipment';
        }
        field(50028; "BC6_Shipt Print All Order Line"; Boolean)
        {
            Caption = 'Shipt Print All Order Line';

        }
        field(50029; "BC6_Copy Sell-to Address"; Boolean)
        {
            Caption = 'Copy Sell-to Address';

        }
        field(80800; "BC6_Submitted to DEEE"; Boolean)
        {
            Caption = 'Submitted to DEEE';
        }
    }
    keys
    {
        key(Key23; "BC6_Pay-to Customer No.")
        {
        }
    }

    procedure updateLedgerEntries(CodLCustNo: Code[20]; CodLPayToNo: Code[20])
    var
        RecLCustLedgEntry: Record 21;
        RecLDetCustLedgEntry: Record 379;
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

        TextGestTiersPayeur001: Label 'Do you want to update Open Ledger entries with new Pay-to customer No. %1?';

}

