page 50007 "BC6_Navi+ Setup"
{
    Caption = 'Navi+ Setup', comment = 'FRA="Paramètres Navi+"';
    PageType = Card;
    SourceTable = "BC6_Navi+ Setup";
    ApplicationArea = all;
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
                }
                field("Parm Ctrl price on order"; Rec."Parm Ctrl price on order")
                {
                }
                field("Parm Sample Order"; Rec."Parm Sample Order")
                {
                }
                field("Parm Eco Emballage"; Rec."Parm Eco Emballage")
                {
                }
                field("Parm Logistique"; Rec."Parm Logistique")
                {
                }
                field("Filing Sales Quotes"; Rec."Filing Sales Quotes")
                {
                }
                field("Filing Sales Orders"; Rec."Filing Sales Orders")
                {
                }
                field("Filing Purchases Orders"; Rec."Filing Purchases Orders")
                {
                }
                field("Eclater nomenclature en auto"; Rec."Eclater nomenclature en auto")
                {
                }
                field("Date jour en factur/livraison"; Rec."Date jour en factur/livraison")
                {
                }
                field("Date jour ds date facture Acha"; Rec."Date jour ds date facture Acha")
                {
                }
                field("Used Post-it"; Rec."Used Post-it")
                {
                }
                field("Affichage du N° BL"; Rec."Affichage du N° BL")
                {
                }
                field("Affichage du N° BR"; Rec."Affichage du N° BR")
                {
                }
                field("Four: Date jour en Fact/recept"; Rec."Four: Date jour en Fact/recept")
                {
                }
                field("Affichage N° facture Ventes"; Rec."Affichage N° facture Ventes")
                {
                }
                field("Affichage N° facture Achat"; Rec."Affichage N° facture Achat")
                {
                }
                field("Date jour - date facture Acha2"; Rec."Date jour ds date facture Acha")
                {
                }
            }
            group(Item)
            {
                Caption = 'Item', comment = 'FRA="Article"';
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                }
                field("Costing Method"; Rec."Costing Method")
                {
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                }
                field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
                {
                }
                field("Replenishment System"; Rec."Replenishment System")
                {
                }
                field("Lead Time Calculation Item"; Rec."Lead Time Calculation Item")
                {
                }
                field("Reordering Policy"; Rec."Reordering Policy")
                {
                }
                field("Include Inventory"; Rec."Include Inventory")
                {
                }
                field("Reserve Item"; Rec."Reserve Item")
                {
                }
                field("Order Tracking Policy"; Rec."Order Tracking Policy")
                {
                }
                field("Catalog import Path"; Rec."Catalog import Path")
                {
                }
            }
            group(Vendor)
            {
                Caption = 'Vendor', comment = 'FRA="Fournisseur"';
                field("Gen. Bus. Posting Group Vendor"; Rec."Gen. Bus. Posting Group Vendor")
                {
                }
                field("VAT Bus. Posting Group Vendor"; Rec."VAT Bus. Posting Group Vendor")
                {
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                }
                field("Lead Time Calculation Vendor"; Rec."Lead Time Calculation Vendor")
                {
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                }
                field("Application Method Vendor"; Rec."Application Method Vendor")
                {
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                }
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                }
                field("Vendor Location Code"; Rec."Vendor Location Code")
                {
                }
                field("Posting DEEE"; Rec."Posting DEEE")
                {
                }
            }
            group(Customer)
            {
                Caption = 'Customer', comment = 'FRA="Client"';
                field("Country Code"; Rec."Country Code")
                {
                }
                field("Gen. Bus. Posting Group Cust."; Rec."Gen. Bus. Posting Group Cust.")
                {
                }
                field("VAT Bus. Posting Group Cust."; Rec."VAT Bus. Posting Group Cust.")
                {
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                }
                field("Application Method Customer"; Rec."Application Method Customer")
                {
                }
                field("Print Statements"; Rec."Print Statements")
                {
                }
                field("Combine Shipments"; Rec."Combine Shipments")
                {
                }
                field("Reserve Customer"; Rec."Reserve Customer")
                {
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                }
                field("Invoice Copies"; Rec."Invoice Copies")
                {
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                }
                field("Customer Location Code"; Rec."Customer Location Code")
                {
                }
                field("Submitted to DEEE"; Rec."Submitted to DEEE")
                {
                }
            }
            group(Project)
            {
                Caption = 'Project', comment = 'FRA="Projet"';
                field("Default Directory"; Rec."Default Directory")
                {
                }
            }
        }
    }

    actions
    {
    }
}
