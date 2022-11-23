page 50007 "BC6_Navi+ Setup"
{
    Caption = 'Navi+ Setup', comment = 'FRA="Paramètres Navi+"';
    PageType = Card;
    SourceTable = "BC6_Navi+ Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General', comment = 'FRA="Général"';
                field("Parm Msg franco de port"; "Parm Msg franco de port")
                {
                }
                field("Parm Ctrl price on order"; "Parm Ctrl price on order")
                {
                }
                field("Parm Sample Order"; "Parm Sample Order")
                {
                }
                field("Parm Eco Emballage"; "Parm Eco Emballage")
                {
                }
                field("Parm Logistique"; "Parm Logistique")
                {
                }
                field("Filing Sales Quotes"; "Filing Sales Quotes")
                {
                }
                field("Filing Sales Orders"; "Filing Sales Orders")
                {
                }
                field("Filing Purchases Orders"; "Filing Purchases Orders")
                {
                }
                field("Eclater nomenclature en auto"; "Eclater nomenclature en auto")
                {
                }
                field("Date jour en factur/livraison"; "Date jour en factur/livraison")
                {
                }
                field("Date jour ds date facture Acha"; "Date jour ds date facture Acha")
                {
                }
                field("Used Post-it"; "Used Post-it")
                {
                }
                field("Affichage du N° BL"; "Affichage du N° BL")
                {
                }
                field("Affichage du N° BR"; "Affichage du N° BR")
                {
                }
                field("Four: Date jour en Fact/recept"; "Four: Date jour en Fact/recept")
                {
                }
                field("Affichage N° facture Ventes"; "Affichage N° facture Ventes")
                {
                }
                field("Affichage N° facture Achat"; "Affichage N° facture Achat")
                {
                }
                field("Date jour - date facture Acha2"; "Date jour ds date facture Acha")
                {
                }
            }
            group(Item)
            {
                Caption = 'Item', comment = 'FRA="Article"';
                field("Base Unit of Measure"; "Base Unit of Measure")
                {
                }
                field("Costing Method"; "Costing Method")
                {
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                }
                field("Inventory Posting Group"; "Inventory Posting Group")
                {
                }
                field("Sales Unit of Measure"; "Sales Unit of Measure")
                {
                }
                field("Replenishment System"; "Replenishment System")
                {
                }
                field("Lead Time Calculation Item"; "Lead Time Calculation Item")
                {
                }
                field("Reordering Policy"; "Reordering Policy")
                {
                }
                field("Include Inventory"; "Include Inventory")
                {
                }
                field("Reserve Item"; "Reserve Item")
                {
                }
                field("Order Tracking Policy"; "Order Tracking Policy")
                {
                }
                field("Catalog import Path"; "Catalog import Path")
                {
                }
            }
            group(Vendor)
            {
                Caption = 'Vendor', comment = 'FRA="Fournisseur"';
                field("Gen. Bus. Posting Group Vendor"; "Gen. Bus. Posting Group Vendor")
                {
                }
                field("VAT Bus. Posting Group Vendor"; "VAT Bus. Posting Group Vendor")
                {
                }
                field("Vendor Posting Group"; "Vendor Posting Group")
                {
                }
                field("Lead Time Calculation Vendor"; "Lead Time Calculation Vendor")
                {
                }
                field("Purchaser Code"; "Purchaser Code")
                {
                }
                field("Application Method Vendor"; "Application Method Vendor")
                {
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                }
                field("Base Calendar Code"; "Base Calendar Code")
                {
                }
                field("Vendor Location Code"; "Vendor Location Code")
                {
                }
                field("Posting DEEE"; "Posting DEEE")
                {
                }
            }
            group(Customer)
            {
                Caption = 'Customer', comment = 'FRA="Client"';
                field("Country Code"; "Country Code")
                {
                }
                field("Gen. Bus. Posting Group Cust."; "Gen. Bus. Posting Group Cust.")
                {
                }
                field("VAT Bus. Posting Group Cust."; "VAT Bus. Posting Group Cust.")
                {
                }
                field("Customer Posting Group"; "Customer Posting Group")
                {
                }
                field("Allow Line Disc."; "Allow Line Disc.")
                {
                }
                field("Application Method Customer"; "Application Method Customer")
                {
                }
                field("Print Statements"; "Print Statements")
                {
                }
                field("Combine Shipments"; "Combine Shipments")
                {
                }
                field("Reserve Customer"; "Reserve Customer")
                {
                }
                field("Shipping Advice"; "Shipping Advice")
                {
                }
                field("Invoice Copies"; "Invoice Copies")
                {
                }
                field("Shipping Time"; "Shipping Time")
                {
                }
                field("Customer Location Code"; "Customer Location Code")
                {
                }
                field("Submitted to DEEE"; "Submitted to DEEE")
                {
                }
            }
            group(Project)
            {
                Caption = 'Project', comment = 'FRA="Projet"';
                field("Default Directory"; "Default Directory")
                {
                }
            }
        }
    }

    actions
    {
    }
}
