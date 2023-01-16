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
                part("Salespers Processor Activities>"; "BC6_Salespers Proc Activities")
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
                    ApplicationArea = All;
                    Visible = false;
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
                ApplicationArea = All;
                Caption = 'Customer - &Order Summary', Comment = 'FRA="Clients : Liste des c&ommandes"';
                Image = "Report";
                RunObject = Report "Customer - Order Summary";
            }
            action("Customer - &Top 10 List")
            {
                ApplicationArea = All;
                Caption = 'Customer - &Top 10 List', Comment = 'FRA="Clien&ts : Palmarès"';
                Image = "Report";
                RunObject = Report "Customer - Top 10 List";
            }
            action("Customer/&Item Sales")
            {
                ApplicationArea = All;
                Caption = 'Customer/&Item Sales', Comment = 'FRA="Client/Ventes d''art&icles"';
                Image = "Report";
                RunObject = Report "Customer/Item Sales";
            }
            separator("Action17")
            {
            }
            action("Salesperson - Sales &Statistics")
            {
                ApplicationArea = All;
                Caption = 'Salesperson - Sales &Statistics', Comment = 'FRA="Vendeurs : &Statistiques ventes"';
                Image = "Report";
                RunObject = Report "Salesperson - Sales Statistics";
            }
            action("Price &List")
            {
                ApplicationArea = All;
                Caption = 'Price &List', Comment = 'FRA="&Liste des prix"';
                Image = "Report";
                RunObject = Report "Price List";
            }
            separator("Action22")
            {
            }
            action("Inventory - Sales &Back Orders")
            {
                ApplicationArea = All;
                Caption = 'Inventory - Sales &Back Orders', Comment = 'FRA="Stoc&ks : Commandes à livrer"';
                Image = "Report";
                RunObject = Report "Inventory - Sales Back Orders";
            }
            action("Pro Forma")
            {
                ApplicationArea = All;
                Caption = 'Pro Forma', Comment = 'FRA="Pro Forma"';
                Image = "Report";
                RunObject = Report "BC6_Facture Proforma CNE";
            }
        }
        area(embedding)
        {
            action("Sales Orders")
            {
                ApplicationArea = All;
                Caption = 'Sales Orders', Comment = 'FRA="Commandes vente"';
                Image = "Order";
                RunObject = Page "Sales Order List";
            }
            action("Shipped Not Invoiced")
            {
                ApplicationArea = All;
                Caption = 'Shipped Not Invoiced', Comment = 'FRA="Livré non facturé"';
                Image = Shipment;
                RunObject = Page "Sales Order List";
                RunPageView = WHERE("Shipped Not Invoiced" = CONST(true));
            }
            action("Completely Shipped Not Invoiced")
            {
                ApplicationArea = All;
                Caption = 'Completely Shipped Not Invoiced', Comment = 'FRA="Complètement livré non facturé"';
                Image = Shipment;
                RunObject = Page "Sales Order List";
                RunPageView = WHERE("Completely Shipped" = CONST(true),
                                    Invoice = CONST(false));
            }
            action("Sales Quotes")
            {
                ApplicationArea = All;
                Caption = 'Sales Quotes', Comment = 'FRA="Devis"';
                Image = Quote;
                RunObject = Page "Sales Quotes";
            }
            action("Blanket Sales Orders")
            {
                ApplicationArea = All;
                Caption = 'Blanket Sales Orders', Comment = 'FRA="Commandes ouvertes vente"';
                Image = Order;
                RunObject = Page "Blanket Sales Orders";
            }
            action("Sales Invoices")
            {
                ApplicationArea = All;
                Caption = 'Sales Invoices', Comment = 'FRA="Factures vente"';
                Image = Invoice;
                RunObject = Page "Sales Invoice List";
            }
            action("Sales Return Orders")
            {
                ApplicationArea = All;
                Caption = 'Sales Return Orders', Comment = 'FRA="Retours vente"';
                Image = ReturnOrder;
                RunObject = Page "Sales Return Order List";
            }
            action("Sales Credit Memos")
            {
                ApplicationArea = All;
                Caption = 'Sales Credit Memos', Comment = 'FRA="Avoirs vente"';
                Image = CreditMemo;
                RunObject = Page "Sales Credit Memos";
            }
            action(Items)
            {
                ApplicationArea = All;
                Caption = 'Items', Comment = 'FRA="Articles"';
                Image = Item;
                RunObject = Page "Item List";
            }
            action(Customers)
            {
                ApplicationArea = All;
                Caption = 'Customers', Comment = 'FRA="Clients"';
                Image = Customer;
                RunObject = Page "Customer List";
            }
            action("Item Journals")
            {
                ApplicationArea = All;
                Caption = 'Item Journals', Comment = 'FRA="Feuilles article"';
                Image = Journals;
                RunObject = Page "Item Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Item),
                                    Recurring = CONST(false));
            }
            action("Sales Journals")
            {
                ApplicationArea = All;
                Caption = 'Sales Journals', Comment = 'FRA="Feuilles vente"';
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Sales),
                                    Recurring = CONST(false));
            }
            action("Cash Receipt Journals")
            {
                ApplicationArea = All;
                Caption = 'Cash Receipt Journals', Comment = 'FRA="Feuilles règlement"';
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                    Recurring = CONST(false));
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
                    ApplicationArea = All;
                    Caption = 'Posted Sales Shipments', Comment = 'FRA="Expéditions vente enregistrées"';
                    Image = PostedShipment;
                    RunObject = Page "Posted Sales Shipments";
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Invoices', Comment = 'FRA="Factures vente enregistrées"';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                }
                action("Posted Return Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Return Receipts', Comment = 'FRA="Réceptions retour enregistrées"';
                    Image = PostedReturnReceipt;
                    RunObject = Page "Posted Return Receipts";
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Credit Memos', Comment = 'FRA="Avoirs vente enregistrés"';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                }
                action("Posted Purchase Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Receipts', Comment = 'FRA="Réceptions achat enregistrées"';
                    Image = Receipt;
                    RunObject = Page "Posted Purchase Receipts";
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Invoices', Comment = 'FRA="Factures achat enregistrées"';
                    Image = Invoice;
                    RunObject = Page "Posted Purchase Invoices";
                }
            }
        }
        area(creation)
        {
            action("Sales &Quote")
            {
                ApplicationArea = All;
                Caption = 'Sales &Quote', Comment = 'FRA="&Devis"';
                Image = Quote;
                RunObject = Page "Sales Quote";
                RunPageMode = Create;
            }
            action("Sales &Invoice")
            {
                ApplicationArea = All;
                Caption = 'Sales &Invoice', Comment = 'FRA="Fac&ture vente"';
                Image = Invoice;
                RunObject = Page "Sales Invoice";
                RunPageMode = Create;
            }
            action("Sales &Order")
            {
                ApplicationArea = All;
                Caption = 'Sales &Order', Comment = 'FRA="&Commande vente"';
                Image = Document;
                RunObject = Page "Sales Order";
                RunPageMode = Create;
            }
            action("Sales &Return Order")
            {
                ApplicationArea = All;
                Caption = 'Sales &Return Order', Comment = 'FRA="&Retour vente"';
                Image = ReturnOrder;
                RunObject = Page "Sales Return Order";
                RunPageMode = Create;
            }
            action("Sales &Credit Memo")
            {
                ApplicationArea = All;
                Caption = 'Sales &Credit Memo', Comment = 'FRA="&Avoir vente"';
                Image = CreditMemo;
                RunObject = Page "Sales Credit Memo";
                RunPageMode = Create;
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
                ApplicationArea = All;
                Caption = 'Sales &Journal', Comment = 'FRA="Feuille ven&te"';
                Image = Journals;
                RunObject = Page "Sales Journal";
            }
            action("Sales Price &Worksheet")
            {
                ApplicationArea = All;
                Caption = 'Sales Price &Worksheet', Comment = 'FRA="Feuille pri&x vente"';
                Image = PriceWorksheet;
                RunObject = Page "Sales Price Worksheet";
            }
            separator(Action42)
            {
            }
            action("Sales &Prices")
            {
                ApplicationArea = All;
                Caption = 'Sales &Prices', Comment = 'FRA="&Prix vente"';
                Image = SalesPrices;
                RunObject = Page "Sales Prices";
            }
            action("Sales &Line Discounts")
            {
                ApplicationArea = All;
                Caption = 'Sales &Line Discounts', Comment = 'FRA="Re&mises ligne vente"';
                Image = SalesLineDisc;
                RunObject = Page "Sales Line Discounts";
            }
            separator(History)
            {
                Caption = 'History', Comment = 'FRA="Historique"';
                IsHeader = true;
            }
            action("Navi&gate")
            {
                ApplicationArea = All;
                Caption = 'Navi&gate', Comment = 'FRA="Navi&guer"';
                Image = Navigate;
                RunObject = Page Navigate;
            }
        }
    }
}
