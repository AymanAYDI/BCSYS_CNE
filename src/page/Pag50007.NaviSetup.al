page 50007 "BC6_Navi+ Setup"
{
    ApplicationArea = all;
    Caption = 'Navi+ Setup', comment = 'FRA="Paramètres Navi+"';
    PageType = Card;
    SourceTable = "BC6_Navi+ Setup";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General', comment = 'FRA="Général"';
                field("Parm Msg franco de port"; Rec."Parm Msg franco de port")
                {
                    ApplicationArea = All;
                }
                field("Parm Ctrl price on order"; Rec."Parm Ctrl price on order")
                {
                    ApplicationArea = All;
                }
                field("Parm Sample Order"; Rec."Parm Sample Order")
                {
                    ApplicationArea = All;
                }
                field("Parm Eco Emballage"; Rec."Parm Eco Emballage")
                {
                    ApplicationArea = All;
                }
                field("Parm Logistique"; Rec."Parm Logistique")
                {
                    ApplicationArea = All;
                }
                field("Filing Sales Quotes"; Rec."Filing Sales Quotes")
                {
                    ApplicationArea = All;
                }
                field("Filing Sales Orders"; Rec."Filing Sales Orders")
                {
                    ApplicationArea = All;
                }
                field("Filing Purchases Orders"; Rec."Filing Purchases Orders")
                {
                    ApplicationArea = All;
                }
                field("Eclater nomenclature en auto"; Rec."Eclater nomenclature en auto")
                {
                    ApplicationArea = All;
                }
                field("Date jour en factur/livraison"; Rec."Date jour en factur/livraison")
                {
                    ApplicationArea = All;
                }
                field("Date jour ds date facture Acha"; Rec."Date jour ds date facture Acha")
                {
                    ApplicationArea = All;
                }
                field("Used Post-it"; Rec."Used Post-it")
                {
                    ApplicationArea = All;
                }
                field("Affichage du N° BL"; Rec."Affichage du N° BL")
                {
                    ApplicationArea = All;
                }
                field("Affichage du N° BR"; Rec."Affichage du N° BR")
                {
                    ApplicationArea = All;
                }
                field("Four: Date jour en Fact/recept"; Rec."Four: Date jour en Fact/recept")
                {
                    ApplicationArea = All;
                }
                field("Affichage N° facture Ventes"; Rec."Affichage N° facture Ventes")
                {
                    ApplicationArea = All;
                }
                field("Affichage N° facture Achat"; Rec."Affichage N° facture Achat")
                {
                    ApplicationArea = All;
                }
                field("Date jour - date facture Acha2"; Rec."Date jour ds date facture Acha")
                {
                    ApplicationArea = All;
                }
            }
            group(Item)
            {
                Caption = 'Item', comment = 'FRA="Article"';
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Costing Method"; Rec."Costing Method")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Replenishment System"; Rec."Replenishment System")
                {
                    ApplicationArea = All;
                }
                field("Lead Time Calculation Item"; Rec."Lead Time Calculation Item")
                {
                    ApplicationArea = All;
                }
                field("Reordering Policy"; Rec."Reordering Policy")
                {
                    ApplicationArea = All;
                }
                field("Include Inventory"; Rec."Include Inventory")
                {
                    ApplicationArea = All;
                }
                field("Reserve Item"; Rec."Reserve Item")
                {
                    ApplicationArea = All;
                }
                field("Order Tracking Policy"; Rec."Order Tracking Policy")
                {
                    ApplicationArea = All;
                }
                field("Catalog import Path"; Rec."Catalog import Path")
                {
                    ApplicationArea = All;
                }
            }
            group(Vendor)
            {
                Caption = 'Vendor', comment = 'FRA="Fournisseur"';
                field("Gen. Bus. Posting Group Vendor"; Rec."Gen. Bus. Posting Group Vendor")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group Vendor"; Rec."VAT Bus. Posting Group Vendor")
                {
                    ApplicationArea = All;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Lead Time Calculation Vendor"; Rec."Lead Time Calculation Vendor")
                {
                    ApplicationArea = All;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                }
                field("Application Method Vendor"; Rec."Application Method Vendor")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor Location Code"; Rec."Vendor Location Code")
                {
                    ApplicationArea = All;
                }
                field("Posting DEEE"; Rec."Posting DEEE")
                {
                    ApplicationArea = All;
                }
            }
            group(Customer)
            {
                Caption = 'Customer', comment = 'FRA="Client"';
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group Cust."; Rec."Gen. Bus. Posting Group Cust.")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group Cust."; Rec."VAT Bus. Posting Group Cust.")
                {
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    ApplicationArea = All;
                }
                field("Application Method Customer"; Rec."Application Method Customer")
                {
                    ApplicationArea = All;
                }
                field("Print Statements"; Rec."Print Statements")
                {
                    ApplicationArea = All;
                }
                field("Combine Shipments"; Rec."Combine Shipments")
                {
                    ApplicationArea = All;
                }
                field("Reserve Customer"; Rec."Reserve Customer")
                {
                    ApplicationArea = All;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ApplicationArea = All;
                }
                field("Invoice Copies"; Rec."Invoice Copies")
                {
                    ApplicationArea = All;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = All;
                }
                field("Customer Location Code"; Rec."Customer Location Code")
                {
                    ApplicationArea = All;
                }
                field("Submitted to DEEE"; Rec."Submitted to DEEE")
                {
                    ApplicationArea = All;
                }
            }
            group(Project)
            {
                Caption = 'Project', comment = 'FRA="Projet"';
                field("Default Directory"; Rec."Default Directory")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
