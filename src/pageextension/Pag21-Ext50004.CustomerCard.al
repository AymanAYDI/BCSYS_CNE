pageextension 50004 "BC6_CustomerCard" extends "Customer Card" //21
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("BC6_Creation Date"; Rec."BC6_Creation Date")
            {
                ApplicationArea = All;
                Caption = 'Creation Date', Comment = 'FRA="Date de création"';
            }
            field("BC6_Territory Code"; Rec."Territory Code")
            {
                ApplicationArea = All;
            }
            field("BC6_Copy Sell-to Address"; Rec."BC6_Copy Sell-to Address")
            {
                ApplicationArea = All;
                Caption = 'Copy Sell-to Address', Comment = 'FRA="Copie adresse donneur d''ordre"';
            }
            field("BC6_Salesperson Filter"; Rec."BC6_Salesperson Filter")
            {
                Importance = Additional;
                ApplicationArea = All;
                Caption = 'Salesperson Filter', Comment = 'FRA="Filtre vendeur"';
            }
        }
        addafter("Copy Sell-to Addr. to Qte From")
        {
            field("BC6_Customer Sales Profit Group"; Rec."BC6_Custom. Sales Profit Group")
            {
                ApplicationArea = All;
                Caption = 'Customer Sales Profit Group', Comment = 'FRA="Goupe Marge Vente Client"';
            }
            field("BC6_Submitted to DEEE"; Rec."BC6_Submitted to DEEE")
            {
                ApplicationArea = All;
                Caption = 'Submitted to DEEE', Comment = 'FRA="Soumis à la DEEE"';
            }
        }
        addafter("Payment in progress (LCY)")
        {
            field("BC6_Pay-to Customer No."; Rec."BC6_Pay-to Customer No.")
            {
                Editable = false;
                ApplicationArea = All;
                Caption = 'Pay-to Customer No.', Comment = 'FRA="Tiers payeur"';
            }
            field("BC6_Shipping Advice"; Rec."Shipping Advice")
            {
                ApplicationArea = All;
            }
        }
        addafter("Customized Calendar")
        {
            field("BC6_Combine Shipments by Order"; Rec."BC6_Combine Shipments by Order")
            {
                ApplicationArea = All;
                Caption = 'Combine Shipments by Order', Comment = 'FRA="Regrouper BL par commande"';
            }
            field("BC6_Not Valued Shipment"; Rec."BC6_Not Valued Shipment")
            {
                ApplicationArea = All;
                Caption = 'Valued Shipment', Comment = 'FRA="BL non chiffré"';
            }
            field("BC6_Shipt Print All Order Line"; Rec."BC6_Shipt Print All Order Line")
            {
                ApplicationArea = All;
                Caption = 'Shipt Print All Order Line', Comment = 'FRA="Impression B.L. toute ligne commandée"';
            }
        }
        addafter("Sales This Year")
        {
            group(BC6_Group)
            {
                caption = 'Group';
                field("BC6_Transaction Type"; Rec."BC6_Transaction Type")
                {
                    ApplicationArea = All;
                    Caption = 'Transaction Type', Comment = 'FRA="Nature Transaction"';

                    trigger OnValidate()
                    begin
                        Incoterm();
                    end;
                }
                field(BC6_TxtGTransType; TxtGTransType)
                {
                    Editable = false;
                    ApplicationArea = All;
                    Caption = 'TxtGTransType';
                }
            }
            group(BC6_Group2)
            {
                caption = 'Group2';
                field("BC6_Transaction Specification"; Rec."BC6_Transaction Specification")
                {
                    ApplicationArea = All;
                    Caption = 'Transaction Specification', Comment = 'FRA="Régime"';

                    trigger OnValidate()
                    begin
                        Incoterm();
                    end;
                }
                field(BC6_TxtGTransSpe; TxtGTransSpe)
                {
                    Editable = false;
                    ApplicationArea = All;
                    Caption = 'TxtGTransSpe';
                }
            }
            group(BC6_Group3)
            {
                caption = 'Group3';
                field("BC6_Transport Method"; Rec."BC6_Transport Method")
                {
                    ApplicationArea = All;
                    Caption = 'Transport Method', Comment = 'FRA="Mode transport"';

                    trigger OnValidate()
                    begin
                        Incoterm();
                    end;
                }
                field(BC6_TxtGTransMeth; TxtGTransMeth)
                {
                    Editable = false;
                    ApplicationArea = All;
                    Caption = 'TxtGTransMeth';
                }
            }
            group(BC6_Group4)
            {
                caption = 'Group4';
                field("BC6_Exit Point"; Rec."BC6_Exit Point")
                {
                    ApplicationArea = All;
                    Caption = 'Exit Point', Comment = 'FRA="Pays Destination"';

                    trigger OnValidate()
                    begin
                        Incoterm();
                    end;
                }
                field(BC6_TxtGESPoint; TxtGESPoint)
                {
                    Editable = false;
                    ApplicationArea = All;
                    Caption = 'TxtGESPoint';
                }
            }
            group(BC6_Group5)
            {
                caption = 'Group5';
                field(BC6_Area; Rec.BC6_Area)
                {
                    ApplicationArea = All;
                    Caption = 'Area', Comment = 'FRA="Departement Destination"';

                    trigger OnValidate()
                    begin
                        Incoterm();
                    end;
                }
                field(BC6_TxtGArea; TxtGArea)
                {
                    Editable = false;
                    ApplicationArea = All;
                    Caption = 'TxtGArea';
                }
            }
        }
    }
    actions
    {

        addafter(Contact)
        {
            separator(Sep)
            {
            }
            action("BC6_Pay-to Custom. No.")
            {
                Caption = 'Pay-to Customer No.', Comment = 'FRA="Tiers payeur"';
                Image = Vendor;
                RunObject = Page "Customer List";
                RunPageLink = "BC6_Pay-to Customer No." = FIELD("No.");
                ApplicationArea = All;
            }
            action(BC6_SFAC)
            {
                Caption = 'SFAC';
                Image = Customer;
                RunObject = Page "BC6_SFAC Client";
                ApplicationArea = All;
            }
        }
        addafter("Co&mments")
        {
            action("BC6_Salesperson authorized")
            {
                Caption = 'Salesperson authorized', Comment = 'FRA="Vendeurs Autorisés"';
                Image = SalesPerson;
                RunObject = Page "BC6_Salesperson authorized";
                RunPageLink = "Customer No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
        addafter(NewSalesReturnOrder)
        {
            separator(Sep1)
            {
            }
            action("BC6_Associated Document")
            {
                Caption = 'Associated Document', Comment = 'FRA="Document Associé"';
                Image = Document;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Doc: Record "BC6_Navi+ Documents";
                    TableInformation: Record "Table Information";
                begin
                    Doc.SETRANGE(Doc."Table No.", 18);
                    Doc.SETRANGE(Doc."Reference No. 1", Rec."No.");
                    TableInformation.SETRANGE(TableInformation."Table No.", 18);
                    IF TableInformation.FindFirst() THEN
                        Doc.SETRANGE(Doc."Table Name", TableInformation."Table Name");
                    PAGE.RUNMODAL(Page::"BC6_Documents Managment", Doc);
                end;
            }
        }
    }

    var

        RecGArea: Record "Area";
        RecGTransESPoint: Record "Entry/Exit Point";
        RecGTransSpe: Record "Transaction Specification";
        RecGTransType: Record "Transaction Type";
        RecGTransMeth: Record "Transport Method";
        TxtGArea: Text[100];
        TxtGESPoint: Text[100];
        TxtGTransMeth: Text[100];
        TxtGTransSpe: Text[100];
        TxtGTransType: Text[100];

    procedure "---NSC1.00---"()
    begin
    end;

    procedure Incoterm()
    begin
        IF RecGTransSpe.GET(Rec."BC6_Transaction Specification") THEN
            TxtGTransSpe := RecGTransSpe.Text
        ELSE
            TxtGTransSpe := '';


        IF RecGTransType.GET(Rec."BC6_Transaction Type") THEN
            TxtGTransType := RecGTransType.Description
        ELSE
            TxtGTransType := '';


        IF RecGTransMeth.GET(Rec."BC6_Transport Method") THEN
            TxtGTransMeth := RecGTransMeth.Description
        ELSE
            TxtGTransMeth := '';


        IF RecGTransESPoint.GET(Rec."BC6_Exit Point") THEN
            TxtGESPoint := RecGTransESPoint.Description
        ELSE
            TxtGESPoint := '';


        IF RecGArea.GET(Rec.BC6_Area) THEN
            TxtGArea := RecGArea.Text
        ELSE
            TxtGArea := '';
    end;
}

