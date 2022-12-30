page 50062 "BC6_Order Processor RC Admin"
{
    Caption = 'Role Center', Comment = 'FRA="Tableau de bord"';
    PageType = RoleCenter;
    layout
    {
        area(rolecenter)
        {
            group(Control1)
            {
                part("SO Processor Activities"; "SO Processor Activities")
                {
                    AccessByPermission = TableData "Sales Shipment Header" = R;
                    ApplicationArea = Basic, Suite;
                }
                part("Purchase Return Order Cue"; "BC6_Purchase Return Order Cue")
                {
                    Description = 'BCSYS';
                    ApplicationArea = All;
                }
                part("Team Member Activities"; "Team Member Activities")
                {
                    ApplicationArea = Suite;
                }
                part("My Customers"; "My Customers")
                {
                    ApplicationArea = Basic, Suite;
                }
                part("Power BI Report Spinner Part"; "Power BI Report Spinner Part")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Control2)
            {
                part("Trailing Sales Orders Chart"; "Trailing Sales Orders Chart")
                {
                    AccessByPermission = TableData "Sales Shipment Header" = R;
                    ApplicationArea = Basic, Suite;
                }
                part("My Job Queue"; "My Job Queue")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                part("My Items"; "My Items")
                {
                    AccessByPermission = TableData "My Item" = R;
                    ApplicationArea = Basic, Suite;
                }
                part("Report Inbox Part"; "Report Inbox Part")
                {
                    AccessByPermission = TableData "Report Inbox" = R;
                    ApplicationArea = Suite;
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
        area(embedding)
        {
            ToolTip = 'Manage sales processes. See KPIs and your favorite items and customers.', Comment = 'FRA="Gérez les processus de vente. Examinez les KPI et vos articles et clients favoris."';
            action(SalesOrders)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Orders', Comment = 'FRA="Commandes vente"';
                Image = "Order";
                RunObject = Page "Sales Order List";
                ToolTip = 'Open the list of sales orders where you can sell items and services.', Comment = 'FRA="Ouvrez la liste des commandes vente où vous pouvez vendre des articles et des services."';
            }
            action(SalesOrdersShptNotInv)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Shipped Not Invoiced', Comment = 'FRA="Livré non facturé"';
                RunObject = Page "Sales Order List";
                RunPageView = WHERE("Shipped Not Invoiced" = CONST(true));
                ToolTip = 'View sales that are shipped but not yet invoiced.', Comment = 'FRA="Affichez les ventes qui sont expédiées, mais pas encore facturées."';
            }
            action(SalesOrdersComplShtNotInv)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Completely Shipped Not Invoiced', Comment = 'FRA="Complètement livré non facturé"';
                RunObject = Page "Sales Order List";
                RunPageView = WHERE("Completely Shipped" = CONST(true),
                                    Invoice = CONST(false));
                ToolTip = 'View sales documents that are fully shipped but not fully invoiced.', Comment = 'FRA="Affichez les documents vente qui sont intégralement expédiés, mais pas totalement facturés."';
            }
            action("Dynamics CRM Sales Orders")
            {
                ApplicationArea = Suite;
                Caption = 'Dynamics CRM Sales Orders', Comment = 'FRA="Commandes vente Dynamics CRM"';
                RunObject = Page "CRM Sales Order List";
                RunPageView = WHERE(StateCode = FILTER(Submitted),
                                    LastBackofficeSubmit = FILTER(''));
                ToolTip = 'View sales orders in Dynamics CRM that are coupled with sales orders in Dynamics NAV.', Comment = 'FRA="Affichez les commandes vente dans Dynamics CRM qui sont couplées avec les commandes vente dans Dynamics NAV."';
            }
            action("Sales Quotes")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Quotes', Comment = 'FRA="Devis"';
                Image = Quote;
                RunObject = Page "Sales Quotes";
                ToolTip = 'Open the list of sales quotes where you offer items or services to customers.', Comment = 'FRA="Ouvrez la liste des devis où vous proposez des articles ou des services aux clients."';
            }
            action("Blanket Sales Orders")
            {
                Caption = 'Blanket Sales Orders', Comment = 'FRA="Commandes ouvertes vente"';
                RunObject = Page "Blanket Sales Orders";
                ApplicationArea = All;
            }
            action("Sales Invoices")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Invoices', Comment = 'FRA="Factures vente"';
                Image = Invoice;
                RunObject = Page "Sales Invoice List";
                ToolTip = 'Open the list of sales invoices where you can invoice items or services.', Comment = 'FRA="Ouvrez la liste des factures vente où vous pouvez facturer des articles ou des services."';
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
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Credit Memos', Comment = 'FRA="Avoirs vente"';
                RunObject = Page "Sales Credit Memos";
                ToolTip = 'Open the list of sales credit memos where you can revert posted sales invoices.', Comment = 'FRA="Ouvrez la liste des avoirs vente où vous pouvez annuler les factures vente validées."';
            }
            action(Items)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Items', Comment = 'FRA="Articles"';
                Image = Item;
                RunObject = Page "Item List";
                ToolTip = 'Open the list of items that you trade in.', Comment = 'FRA="Ouvrez la liste des articles que vous commercialisez."';
            }
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customers', Comment = 'FRA="Clients"';
                Image = Customer;
                RunObject = Page "Customer List";
                ToolTip = 'Open the list of customers.', Comment = 'FRA="Ouvrez la liste des clients."';
            }
            action("Item Journals")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Journals', Comment = 'FRA="Feuilles article"';
                RunObject = Page "Item Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Item),
                                    Recurring = CONST(false));
                ToolTip = 'Open a list of journals where you can adjust the physical quantity of items on inventory.', Comment = 'FRA="Ouvrez une liste de feuilles où vous pouvez ajuster la quantité physique des articles en stock."';
            }
            action(SalesJournals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Journals', Comment = 'FRA="Feuilles vente"';
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Sales),
                                    Recurring = CONST(false));
                ToolTip = 'Open the list of sales journals where you can batch post sales transactions to G/L, bank, customer, vendor and fixed assets accounts.', Comment = 'FRA="Ouvrez la liste des feuilles vente où vous pouvez valider par groupe les transactions vente vers les comptes généraux, bancaires, client, fournisseur et immobilisations."';
            }
            action(CashReceiptJournals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cash Receipt Journals', Comment = 'FRA="Feuilles règlement"';
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                    Recurring = CONST(false));
                ToolTip = 'Register received payments by applying them to the related customer, vendor, or bank ledger entries.', Comment = 'FRA="Enregistrez les paiements reçus en les lettrant avec les écritures comptables bancaires, fournisseur ou client concernées."';
            }
        }
        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents', Comment = 'FRA="Documents validés"';
                Image = FiledPosted;
                ToolTip = 'View history for sales, shipments, and inventory.', Comment = 'FRA="Affichez l''historique des ventes, des expéditions et du stock."';
                action("Posted Sales Shipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Shipments', Comment = 'FRA="Expéditions vente enregistrées"';
                    Image = PostedShipment;
                    RunObject = Page "Posted Sales Shipments";
                    ToolTip = 'View the posted sales shipments.', Comment = 'FRA="Affichez les expéditions vente validées."';
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices', Comment = 'FRA="Factures vente enregistrées"';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'View the posted sales invoices.', Comment = 'FRA="Affichez les factures vente validées."';
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
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos', Comment = 'FRA="Avoirs vente enregistrés"';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'View the posted sales credit memos.', Comment = 'FRA="Affichez les avoirs vente validés."';
                }
                action("Posted Purchase Receipts")
                {
                    Caption = 'Posted Purchase Receipts', Comment = 'FRA="Réceptions achat enregistrées"';
                    RunObject = Page "Posted Purchase Receipts";
                    ApplicationArea = All;
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices', Comment = 'FRA="Factures achat enregistrées"';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'View the posted purchase invoices.', Comment = 'FRA="Affichez les factures achat enregistrées."';
                }
            }
            group("Self-Service")
            {
                Caption = 'Self-Service', Comment = 'FRA="Libre-service"';
                Image = HumanResources;
                ToolTip = 'Manage your time sheets and assignments.', Comment = 'FRA="Gérez vos feuilles de temps et affectations."';
                action("Time Sheets")
                {
                    ApplicationArea = Suite;
                    Caption = 'Time Sheets', Comment = 'FRA="Feuilles de temps"';
                    Gesture = None;
                    RunObject = Page "Time Sheet List";
                    ToolTip = 'View all time sheets.', Comment = 'FRA="Affichez toutes les feuilles de temps."';
                }
            }
        }
        area(creation)
        {
            action("Sales &Quote")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Quote', Comment = 'FRA="&Devis"';
                Image = NewSalesQuote;
                Promoted = false;
                RunObject = Page "Sales Quote";
                RunPageMode = Create;
                ToolTip = 'Offer items or services to a customer.', Comment = 'FRA="Proposez des articles ou des services à un client."';
            }
            action("Sales &Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Invoice', Comment = 'FRA="Fac&ture vente"';
                Image = NewSalesInvoice;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Sales Invoice";
                RunPageMode = Create;
                ToolTip = 'Create a new invoice for items or services. Invoice quantities cannot be posted partially.', Comment = 'FRA="Créez une facture pour des articles ou des services. Il est impossible de valider partiellement les quantités facturées."';
            }
            action("Sales &Order")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Order', Comment = 'FRA="&Commande vente"';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Sales Order";
                RunPageMode = Create;
                ToolTip = 'Create a new sales order for items or services that require partial posting.', Comment = 'FRA="Créez une commande vente pour les articles ou les services nécessitant une validation partielle."';
            }
            action("Sales &Return Order")
            {
                Caption = 'Sales &Return Order', Comment = 'FRA="&Retour vente"';
                Image = ReturnOrder;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Sales Return Order";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Sales &Credit Memo")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Credit Memo', Comment = 'FRA="&Avoir vente"';
                Image = CreditMemo;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Sales Credit Memo";
                RunPageMode = Create;
                ToolTip = 'Create a new sales credit memo to revert a posted sales invoice.', Comment = 'FRA="Créez un avoir vente pour annuler une facture vente validée."';
            }
        }
        area(processing)
        {
            group(Administration)
            {
                Caption = 'Administration', Comment = 'FRA="Administration"';
                Image = Administration;
                action(IntItem)
                {
                    Caption = 'Item intégration', Comment = 'FRA="Intégration article"';
                    Image = ImportCodes;
                    RunObject = Page "BC6_Intégration article";
                    ApplicationArea = All;
                }
                action(UpdatePartner)
                {
                    Caption = 'Update IC Partner Purch. Price', Comment = 'FRA="Màj tarif fournisseur partnaire"';
                    Image = UpdateUnitCost;
                    ApplicationArea = All;
                    RunObject = Report "BC6_Update IC Par Purch. Price";
                }
                action(ExportTarif)
                {
                    Caption = 'Export Purchase Price', Comment = 'FRA="Export tarif fournisseur"';
                    Image = Export;
                    ApplicationArea = All;
                    RunObject = XMLport "BC6_Export Purchase Price";
                }
                action(BlockItem)
                {
                    Caption = 'Batch Traitement Article', Comment = 'FRA="Traitement blocage article"';
                    Image = Reject;
                    ApplicationArea = All;
                    RunObject = Report "BC6_Batch Traitement Article";
                }
            }
            group(Tasks)
            {
                Caption = 'Tasks', Comment = 'FRA="Tâches"';
                action("Sales &Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales &Journal', Comment = 'FRA="Feuille ven&te"';
                    Image = Journals;
                    RunObject = Page "Sales Journal";
                    ToolTip = 'Open a sales journal where you can batch post sales transactions to G/L, bank, customer, vendor and fixed assets accounts.', Comment = 'FRA="Ouvrez une feuille vente où vous pouvez valider par groupe les transactions vente vers les comptes généraux, bancaires, client, fournisseur et immobilisations."';
                }
                action("Sales Price &Worksheet")
                {
                    Caption = 'Sales Price &Worksheet', Comment = 'FRA="Feuille pri&x vente"';
                    Image = PriceWorksheet;
                    RunObject = Page "Sales Price Worksheet";
                    ApplicationArea = All;
                }
            }
            group(Sales)
            {
                Caption = 'Sales', Comment = 'FRA="Ventes"';
                action("&Prices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Prices', Comment = 'FRA="Pri&x"';
                    Image = SalesPrices;
                    RunObject = Page "Sales Prices";
                    ToolTip = 'Set up different prices for items that you sell to the customer. An item price is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.', Comment = 'FRA="Paramétrez des prix différents pour les articles que vous vendez au client. Un prix article est automatiquement affecté sur les lignes facture lorsque les critères spécifiés sont satisfaits, par exemple le client, la quantité ou la date de fin."';
                }
                action("&Line Discounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Line Discounts', Comment = 'FRA="&Remises ligne"';
                    Image = SalesLineDisc;
                    RunObject = Page "Sales Line Discounts";
                    ToolTip = 'Set up different discounts for items that you sell to the customer. An item discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.', Comment = 'FRA="Paramétrez des remises différentes pour les articles que vous vendez au client. Une remise article est automatiquement affectée sur les lignes facture lorsque les critères spécifiés sont satisfaits, par exemple le client, la quantité ou la date de fin."';
                }
            }
            group(Reports)
            {
                Caption = 'Reports', Comment = 'FRA="États"';
                group(Customer)
                {
                    Caption = 'Customer', Comment = 'FRA="Client"';
                    Image = Customer;
                    action("Customer - &Order Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - &Order Summary', Comment = 'FRA="Clients : &Liste des commandes"';
                        Image = "Report";
                        RunObject = Report "Customer - Order Summary";
                        ToolTip = 'View the quantity not yet shipped for each customer in three periods of 30 days each, starting from a selected date. There are also columns with orders to be shipped before and after the three periods and a column with the total order detail for each customer. The report can be used to analyze a company''s expected sales volume.', Comment = 'FRA="Affichez la quantité pas encore expédiée pour chaque client sur 3 périodes de 30 jours, chacune commençant à une date sélectionnée. Il contient également des colonnes avec les commandes à livrer avant et après les 3 périodes et une colonne avec le détail de la commande totale de chaque client. Cet état sert à analyser le volume de vente attendu d''une société."';
                    }
                    action("Customer - &Top 10 List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - &Top 10 List', Comment = 'FRA="Clien&ts : Palmarès"';
                        Image = "Report";
                        RunObject = Report "Customer - Top 10 List";
                        ToolTip = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.', Comment = 'FRA="Affichez les clients qui achètent le plus ou qui doivent le plus d''argent au cours d''une période sélectionnée. Seuls les clients qui ont des achats pour cette période ou un solde à la fin de la période seront inclus."';
                    }
                    action("Customer/&Item Sales")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer/&Item Sales', Comment = 'FRA="Client/&Ventes d''articles"';
                        Image = "Report";
                        RunObject = Report "Customer/Item Sales";
                        ToolTip = 'View a list of item sales for each customer during a selected time period. The report contains information on quantity, sales amount, profit, and possible discounts. It can be used, for example, to analyze a company''s customer groups.', Comment = 'FRA="Affichez une liste des ventes article de chaque client pendant la période choisie. L''état donne des informations sur la quantité, le montant des ventes, la marge et les remises possibles. Il peut servir, par exemple, à l''analyse des groupes clients d''une société."';
                    }
                }
                group(Sales2)
                {
                    Caption = 'Sales', Comment = 'FRA="Ventes"';
                    Image = Sales;
                    action("Salesperson - Sales &Statistics")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Salesperson - Sales &Statistics', Comment = 'FRA="Vendeurs : &Statistiques ventes"';
                        Image = "Report";
                        RunObject = Report "Salesperson - Sales Statistics";
                        ToolTip = 'View amounts for sales, profit, invoice discount, and payment discount, as well as profit percentage, for each salesperson for a selected period. The report also shows the adjusted profit and adjusted profit percentage, which reflect any changes to the original costs of the items in the sales.', Comment = 'FRA="Affichez les montants des ventes, de la marge, de la remise facture et de l''escompte, ainsi que le pourcentage marge sur vente, pour chaque vendeur et pour la période sélectionnée. L''état indique également le profit ajusté et le pourcentage marge ajustée, qui reflètent tous les changements des coûts d''origine des articles des ventes."';
                    }
                    action("Price &List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Price &List', Comment = 'FRA="&Liste des prix"';
                        Image = "Report";
                        RunObject = Report "Price List";
                        ToolTip = 'View a list of your items and their prices, for example, to send to customers. You can create the list for specific customers, campaigns, currencies, or other criteria.', Comment = 'FRA="Affichez une liste de vos articles ainsi que leur prix à envoyer, par exemple, aux clients. Vous pouvez créer la liste pour des clients, des campagnes ou des devises spécifiques ou encore pour d''autres critères."';
                    }
                    action("Inventory - Sales &Back Orders")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Sales &Back Orders', Comment = 'FRA="Stocks : Commandes &à livrer"';
                        Image = "Report";
                        RunObject = Report "Inventory - Sales Back Orders";
                        ToolTip = 'View a list with the order lines whose shipment date has been exceeded. The following information is shown for the individual orders for each item: number, customer name, customer''s telephone number, shipment date, order quantity and quantity on back order. The report also shows whether there are other items for the customer on back order.', Comment = 'FRA="Affichez une liste qui comprend les lignes commande dont la date d''expédition est dépassée. Les informations suivantes sont données pour chaque article d''une commande : numéro, nom du client, numéro de téléphone du client, date d''expédition, quantité commandée et quantité sur commande en attente. L''état indique aussi s''il y a d''autres articles en commande en attente pour le client."';
                    }
                }
            }
            group(History)
            {
                Caption = 'History', Comment = 'FRA="Historique"';
                action("Navi&gate")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Navi&gate', Comment = 'FRA="Navi&guer"';
                    Image = Navigate;
                    RunObject = Page Navigate;
                    ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.', Comment = 'FRA="Recherchez toutes les écritures et tous les documents qui existent pour le numéro de document et la date comptabilisation sur l''écriture ou le document."';
                }
            }
        }
    }
}
