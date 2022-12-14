page 50047 "BC6_Salesperson Role Center"
{
    Caption = 'Role Center', Comment = 'FRA="Tableau de bord"';
    PageType = RoleCenter;
    UsageCategory = None;
    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                part("Salespers Processor Activities>"; "Salespers Processor Activities")
                {
                    ApplicationArea = All;
                }
                systempart(Outlook; Outlook)
                {
                    ApplicationArea = All;
                }
            }
            group(Control1900724708)
            {
                part("Trailing Sales Orders Chart>"; "Trailing Sales Orders Chart")
                {
                    ApplicationArea = All;
                }
                part("My Job Queue"; "My Job Queue")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                part("My Customers"; "My Customers")
                {
                    ApplicationArea = All;
                }
                part("My Items"; "My Items")
                {
                    ApplicationArea = All;
                }
                systempart("MyNotes"; MyNotes)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Customer - &Order Summary")
            {
                Caption = 'Customer - &Order Summary', Comment = 'FRA="Clients : Liste des c&ommandes"';
                Image = "Report";
                RunObject = Report "Customer - Order Summary";
                ApplicationArea = All;
            }
            action("Customer - &Top 10 List")
            {
                Caption = 'Customer - &Top 10 List', Comment = 'FRA="Clien&ts : Palmarès"';
                Image = "Report";
                RunObject = Report "Customer - Top 10 List";
                ApplicationArea = All;
            }
            action("Customer/&Item Sales")
            {
                Caption = 'Customer/&Item Sales', Comment = 'FRA="Client/Ventes d''art&icles"';
                Image = "Report";
                RunObject = Report "Customer/Item Sales";
                ApplicationArea = All;
            }
            separator("Action17")
            {
            }
            action("Salesperson - Sales &Statistics")
            {
                Caption = 'Salesperson - Sales &Statistics', Comment = 'FRA="Vendeurs : &Statistiques ventes"';
                Image = "Report";
                RunObject = Report "Salesperson - Sales Statistics";
                ApplicationArea = All;
            }
            action("Price &List")
            {
                Caption = 'Price &List', Comment = 'FRA="&Liste des prix"';
                Image = "Report";
                RunObject = Report "Price List";
                ApplicationArea = All;
            }
            separator("Action22")
            {
            }
            action("Inventory - Sales &Back Orders")
            {
                Caption = 'Inventory - Sales &Back Orders', Comment = 'FRA="Stoc&ks : Commandes à livrer"';
                Image = "Report";
                RunObject = Report "Inventory - Sales Back Orders";
                ApplicationArea = All;
            }
            action("Pro Forma")
            {
                Caption = 'Pro Forma', Comment = 'FRA="Pro Forma"';
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report "BC6_Facture Proforma CNE";
            }
        }
        area(embedding)
        {
            action("Sales Orders")
            {
                Caption = 'Sales Orders', Comment = 'FRA="Commandes vente"';
                Image = "Order";
                RunObject = Page "Sales Order List";
                ApplicationArea = All;
            }
            action("Shipped Not Invoiced")
            {
                Caption = 'Shipped Not Invoiced', Comment = 'FRA="Livré non facturé"';
                Image = Shipment;
                RunObject = Page "Sales Order List";
                RunPageView = WHERE("Shipped Not Invoiced" = CONST(true));
                ApplicationArea = All;
            }
            action("Completely Shipped Not Invoiced")
            {
                Caption = 'Completely Shipped Not Invoiced', Comment = 'FRA="Complètement livré non facturé"';
                RunObject = Page "Sales Order List";
                Image = Shipment;
                RunPageView = WHERE("Completely Shipped" = CONST(true),
                                    Invoice = CONST(false));
                ApplicationArea = All;
            }
            action("Sales Quotes")
            {
                Caption = 'Sales Quotes', Comment = 'FRA="Devis"';
                Image = Quote;
                RunObject = Page "Sales Quotes";
                ApplicationArea = All;
            }
            action("Blanket Sales Orders")
            {
                Caption = 'Blanket Sales Orders', Comment = 'FRA="Commandes ouvertes vente"';
                RunObject = Page "Blanket Sales Orders";
                ApplicationArea = All;
                Image = Order;
            }
            action("Sales Invoices")
            {
                Caption = 'Sales Invoices', Comment = 'FRA="Factures vente"';
                Image = Invoice;
                RunObject = Page "Sales Invoice List";
                ApplicationArea = All;
            }
            action("Sales Return Orders")
            {
                Caption = 'Sales Return Orders', Comment = 'FRA="Retours vente"';
                Image = ReturnOrder;
                RunObject = Page "Sales Return Order List";
                ApplicationArea = All;
            }
            action("Sales Credit Memos")
            {
                Caption = 'Sales Credit Memos', Comment = 'FRA="Avoirs vente"';
                RunObject = Page "Sales Credit Memos";
                ApplicationArea = All;
                Image = CreditMemo;
            }
            action(Items)
            {
                Caption = 'Items', Comment = 'FRA="Articles"';
                Image = Item;
                RunObject = Page "Item List";
                ApplicationArea = All;
            }
            action(Customers)
            {
                Caption = 'Customers', Comment = 'FRA="Clients"';
                Image = Customer;
                RunObject = Page "Customer List";
                ApplicationArea = All;
            }
            action("Item Journals")
            {
                Caption = 'Item Journals', Comment = 'FRA="Feuilles article"';
                RunObject = Page "Item Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Item),
                                    Recurring = CONST(false));
                ApplicationArea = All;
                Image = Journals;
            }
            action("Sales Journals")
            {
                Caption = 'Sales Journals', Comment = 'FRA="Feuilles vente"';
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Sales),
                                    Recurring = CONST(false));
                ApplicationArea = All;
                Image = Journals;
            }
            action("Cash Receipt Journals")
            {
                Caption = 'Cash Receipt Journals', Comment = 'FRA="Feuilles règlement"';
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                    Recurring = CONST(false));
                ApplicationArea = All;
            }
        }
        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents', Comment = 'FRA="Documents validés"';
                Image = FiledPosted;
                action("Posted Sales Shipments")
                {
                    Caption = 'Posted Sales Shipments', Comment = 'FRA="Expéditions vente enregistrées"';
                    Image = PostedShipment;
                    RunObject = Page "Posted Sales Shipments";
                    ApplicationArea = All;
                }
                action("Posted Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices', Comment = 'FRA="Factures vente enregistrées"';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                    ApplicationArea = All;
                }
                action("Posted Return Receipts")
                {
                    Caption = 'Posted Return Receipts', Comment = 'FRA="Réceptions retour enregistrées"';
                    Image = PostedReturnReceipt;
                    RunObject = Page "Posted Return Receipts";
                    ApplicationArea = All;
                }
                action("Posted Sales Credit Memos")
                {
                    Caption = 'Posted Sales Credit Memos', Comment = 'FRA="Avoirs vente enregistrés"';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                    ApplicationArea = All;
                }
                action("Posted Purchase Receipts")
                {
                    Caption = 'Posted Purchase Receipts', Comment = 'FRA="Réceptions achat enregistrées"';
                    RunObject = Page "Posted Purchase Receipts";
                    ApplicationArea = All;
                    Image = Receipt;
                }
                action("Posted Purchase Invoices")
                {
                    Caption = 'Posted Purchase Invoices', Comment = 'FRA="Factures achat enregistrées"';
                    RunObject = Page "Posted Purchase Invoices";
                    ApplicationArea = All;
                    Image = Invoice;
                }
            }
        }
        area(creation)
        {
            action("Sales &Quote")
            {
                Caption = 'Sales &Quote', Comment = 'FRA="&Devis"';
                Image = Quote;
                RunObject = Page "Sales Quote";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Sales &Invoice")
            {
                Caption = 'Sales &Invoice', Comment = 'FRA="Fac&ture vente"';
                Image = Invoice;
                RunObject = Page "Sales Invoice";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Sales &Order")
            {
                Caption = 'Sales &Order', Comment = 'FRA="&Commande vente"';
                Image = Document;
                RunObject = Page "Sales Order";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Sales &Return Order")
            {
                Caption = 'Sales &Return Order', Comment = 'FRA="&Retour vente"';
                Image = ReturnOrder;
                RunObject = Page "Sales Return Order";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Sales &Credit Memo")
            {
                Caption = 'Sales &Credit Memo', Comment = 'FRA="&Avoir vente"';
                Image = CreditMemo;
                RunObject = Page "Sales Credit Memo";
                RunPageMode = Create;
                ApplicationArea = All;
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks', Comment = 'FRA="Tâches"';
                IsHeader = true;
            }
            action("Sales &Journal")
            {
                Caption = 'Sales &Journal', Comment = 'FRA="Feuille ven&te"';
                Image = Journals;
                RunObject = Page "Sales Journal";
                ApplicationArea = All;
            }
            action("Sales Price &Worksheet")
            {
                Caption = 'Sales Price &Worksheet', Comment = 'FRA="Feuille pri&x vente"';
                Image = PriceWorksheet;
                RunObject = Page "Sales Price Worksheet";
                ApplicationArea = All;
            }
            separator(Action42)
            {
            }
            action("Sales &Prices")
            {
                Caption = 'Sales &Prices', Comment = 'FRA="&Prix vente"';
                Image = SalesPrices;
                RunObject = Page "Sales Prices";
                ApplicationArea = All;
            }
            action("Sales &Line Discounts")
            {
                Caption = 'Sales &Line Discounts', Comment = 'FRA="Re&mises ligne vente"';
                Image = SalesLineDisc;
                RunObject = Page "Sales Line Discounts";
                ApplicationArea = All;
            }
            separator(History)
            {
                Caption = 'History', Comment = 'FRA="Historique"';
                IsHeader = true;
            }
            action("Navi&gate")
            {
                Caption = 'Navi&gate', Comment = 'FRA="Navi&guer"';
                Image = Navigate;
                RunObject = Page Navigate;
                ApplicationArea = All;
            }
        }
    }
}
