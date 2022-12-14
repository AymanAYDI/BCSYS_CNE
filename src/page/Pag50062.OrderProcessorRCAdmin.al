page 50062 "BC6_Order Processor RC Admin"
{
    Caption = 'Role Center', Comment = 'FRA="Tableau de bord"';
    PageType = RoleCenter;
    UsageCategory = None;
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
            ToolTip = 'Manage sales processes. See KPIs and your favorite items and customers.', Comment = 'FRA="G??rez les processus de vente. Examinez les KPI et vos articles et clients favoris."';
            action(SalesOrders)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Orders', Comment = 'FRA="Commandes vente"';
                Image = "Order";
                RunObject = Page "Sales Order List";
                ToolTip = 'Open the list of sales orders where you can sell items and services.', Comment = 'FRA="Ouvrez la liste des commandes vente o?? vous pouvez vendre des articles et des services."';
            }
            action(SalesOrdersShptNotInv)
            {
                ApplicationArea = Basic, Suite;
                image = Shipment;
                Caption = 'Shipped Not Invoiced', Comment = 'FRA="Livr?? non factur??"';
                RunObject = Page "Sales Order List";
                RunPageView = WHERE("Shipped Not Invoiced" = CONST(true));
                ToolTip = 'View sales that are shipped but not yet invoiced.', Comment = 'FRA="Affichez les ventes qui sont exp??di??es, mais pas encore factur??es."';
            }
            action(SalesOrdersComplShtNotInv)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Completely Shipped Not Invoiced', Comment = 'FRA="Compl??tement livr?? non factur??"';
                RunObject = Page "Sales Order List";
                Image = Shipment;
                RunPageView = WHERE("Completely Shipped" = CONST(true),
                                    Invoice = CONST(false));
                ToolTip = 'View sales documents that are fully shipped but not fully invoiced.', Comment = 'FRA="Affichez les documents vente qui sont int??gralement exp??di??s, mais pas totalement factur??s."';
            }
            action("Dynamics CRM Sales Orders")
            {
                ApplicationArea = Suite;
                Caption = 'Dynamics CRM Sales Orders', Comment = 'FRA="Commandes vente Dynamics CRM"';
                RunObject = Page "CRM Sales Order List";
                Image = Sales;
                RunPageView = WHERE(StateCode = FILTER(Submitted),
                                    LastBackofficeSubmit = FILTER(''));
                ToolTip = 'View sales orders in Dynamics CRM that are coupled with sales orders in Dynamics NAV.', Comment = 'FRA="Affichez les commandes vente dans Dynamics CRM qui sont coupl??es avec les commandes vente dans Dynamics NAV."';
            }
            action("Sales Quotes")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Quotes', Comment = 'FRA="Devis"';
                Image = Quote;
                RunObject = Page "Sales Quotes";
                ToolTip = 'Open the list of sales quotes where you offer items or services to customers.', Comment = 'FRA="Ouvrez la liste des devis o?? vous proposez des articles ou des services aux clients."';
            }
            action("Blanket Sales Orders")
            {
                Caption = 'Blanket Sales Orders', Comment = 'FRA="Commandes ouvertes vente"';
                RunObject = Page "Blanket Sales Orders";
                Image = BlanketOrder;
                ApplicationArea = All;
            }
            action("Sales Invoices")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Invoices', Comment = 'FRA="Factures vente"';
                Image = Invoice;
                RunObject = Page "Sales Invoice List";
                ToolTip = 'Open the list of sales invoices where you can invoice items or services.', Comment = 'FRA="Ouvrez la liste des factures vente o?? vous pouvez facturer des articles ou des services."';
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
                Image = CreditMemo;
                ToolTip = 'Open the list of sales credit memos where you can revert posted sales invoices.', Comment = 'FRA="Ouvrez la liste des avoirs vente o?? vous pouvez annuler les factures vente valid??es."';
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
                image = Journal;
                RunPageView = WHERE("Template Type" = CONST(Item),
                                    Recurring = CONST(false));
                ToolTip = 'Open a list of journals where you can adjust the physical quantity of items on inventory.', Comment = 'FRA="Ouvrez une liste de feuilles o?? vous pouvez ajuster la quantit?? physique des articles en stock."';
            }
            action(SalesJournals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Journals', Comment = 'FRA="Feuilles vente"';
                RunObject = Page "General Journal Batches";
                image = PaymentJournal;
                RunPageView = WHERE("Template Type" = CONST(Sales),
                                    Recurring = CONST(false));
                ToolTip = 'Open the list of sales journals where you can batch post sales transactions to G/L, bank, customer, vendor and fixed assets accounts.', Comment = 'FRA="Ouvrez la liste des feuilles vente o?? vous pouvez valider par groupe les transactions vente vers les comptes g??n??raux, bancaires, client, fournisseur et immobilisations."';
            }
            action(CashReceiptJournals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cash Receipt Journals', Comment = 'FRA="Feuilles r??glement"';
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                    Recurring = CONST(false));
                ToolTip = 'Register received payments by applying them to the related customer, vendor, or bank ledger entries.', Comment = 'FRA="Enregistrez les paiements re??us en les lettrant avec les ??critures comptables bancaires, fournisseur ou client concern??es."';
            }
        }
        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents', Comment = 'FRA="Documents valid??s"';
                Image = FiledPosted;
                ToolTip = 'View history for sales, shipments, and inventory.', Comment = 'FRA="Affichez l''historique des ventes, des exp??ditions et du stock."';
                action("Posted Sales Shipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Shipments', Comment = 'FRA="Exp??ditions vente enregistr??es"';
                    Image = PostedShipment;
                    RunObject = Page "Posted Sales Shipments";
                    ToolTip = 'View the posted sales shipments.', Comment = 'FRA="Affichez les exp??ditions vente valid??es."';
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices', Comment = 'FRA="Factures vente enregistr??es"';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'View the posted sales invoices.', Comment = 'FRA="Affichez les factures vente valid??es."';
                }
                action("Posted Return Receipts")
                {
                    Caption = 'Posted Return Receipts', Comment = 'FRA="R??ceptions retour enregistr??es"';
                    Image = PostedReturnReceipt;
                    RunObject = Page "Posted Return Receipts";
                    ApplicationArea = All;
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos', Comment = 'FRA="Avoirs vente enregistr??s"';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'View the posted sales credit memos.', Comment = 'FRA="Affichez les avoirs vente valid??s."';
                }
                action("Posted Purchase Receipts")
                {
                    Caption = 'Posted Purchase Receipts', Comment = 'FRA="R??ceptions achat enregistr??es"';
                    RunObject = Page "Posted Purchase Receipts";
                    ApplicationArea = All;
                    Image = Receipt;
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices', Comment = 'FRA="Factures achat enregistr??es"';
                    RunObject = Page "Posted Purchase Invoices";
                    Image = InventoryPick;
                    ToolTip = 'View the posted purchase invoices.', Comment = 'FRA="Affichez les factures achat enregistr??es."';
                }
            }
            group("Self-Service")
            {
                Caption = 'Self-Service', Comment = 'FRA="Libre-service"';
                Image = HumanResources;
                ToolTip = 'Manage your time sheets and assignments.', Comment = 'FRA="G??rez vos feuilles de temps et affectations."';
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
                RunObject = Page "Sales Quote";
                RunPageMode = Create;
                ToolTip = 'Offer items or services to a customer.', Comment = 'FRA="Proposez des articles ou des services ?? un client."';
            }
            action("Sales &Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Invoice', Comment = 'FRA="Fac&ture vente"';
                Image = NewSalesInvoice;
                RunObject = Page "Sales Invoice";
                RunPageMode = Create;
                ToolTip = 'Create a new invoice for items or services. Invoice quantities cannot be posted partially.', Comment = 'FRA="Cr??ez une facture pour des articles ou des services. Il est impossible de valider partiellement les quantit??s factur??es."';
            }
            action("Sales &Order")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Order', Comment = 'FRA="&Commande vente"';
                Image = Document;
                RunObject = Page "Sales Order";
                RunPageMode = Create;
                ToolTip = 'Create a new sales order for items or services that require partial posting.', Comment = 'FRA="Cr??ez une commande vente pour les articles ou les services n??cessitant une validation partielle."';
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
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Credit Memo', Comment = 'FRA="&Avoir vente"';
                Image = CreditMemo;
                RunObject = Page "Sales Credit Memo";
                RunPageMode = Create;
                ToolTip = 'Create a new sales credit memo to revert a posted sales invoice.', Comment = 'FRA="Cr??ez un avoir vente pour annuler une facture vente valid??e."';
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
                    Caption = 'Item int??gration', Comment = 'FRA="Int??gration article"';
                    Image = ImportCodes;
                    RunObject = Page "BC6_Int??gration article";
                    ApplicationArea = All;
                }
                action(UpdatePartner)
                {
                    Caption = 'Update IC Partner Purch. Price', Comment = 'FRA="M??j tarif fournisseur partnaire"';
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
                Caption = 'Tasks', Comment = 'FRA="T??ches"';
                action("Sales &Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales &Journal', Comment = 'FRA="Feuille ven&te"';
                    Image = Journals;
                    RunObject = Page "Sales Journal";
                    ToolTip = 'Open a sales journal where you can batch post sales transactions to G/L, bank, customer, vendor and fixed assets accounts.', Comment = 'FRA="Ouvrez une feuille vente o?? vous pouvez valider par groupe les transactions vente vers les comptes g??n??raux, bancaires, client, fournisseur et immobilisations."';
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
                    ToolTip = 'Set up different prices for items that you sell to the customer. An item price is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.', Comment = 'FRA="Param??trez des prix diff??rents pour les articles que vous vendez au client. Un prix article est automatiquement affect?? sur les lignes facture lorsque les crit??res sp??cifi??s sont satisfaits, par exemple le client, la quantit?? ou la date de fin."';
                }
                action("&Line Discounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Line Discounts', Comment = 'FRA="&Remises ligne"';
                    Image = SalesLineDisc;
                    RunObject = Page "Sales Line Discounts";
                    ToolTip = 'Set up different discounts for items that you sell to the customer. An item discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.', Comment = 'FRA="Param??trez des remises diff??rentes pour les articles que vous vendez au client. Une remise article est automatiquement affect??e sur les lignes facture lorsque les crit??res sp??cifi??s sont satisfaits, par exemple le client, la quantit?? ou la date de fin."';
                }
            }
            group(Reports)
            {
                Caption = 'Reports', Comment = 'FRA="??tats"';
                group(Customer)
                {
                    Caption = 'Customer', Comment = 'FRA="Client"';
                    Image = Customer;
                    action("Customer - &Order Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - &Order Summary', Comment = 'FRA="Clients: &Liste des commandes"';
                        Image = "Report";
                        RunObject = Report "Customer - Order Summary";
                        ToolTip = 'View the quantity not yet shipped for each customer in three periods of 30 days each, starting from a selected date. There are also columns with orders to be shipped before and after the three periods and a column with the total order detail for each customer. The report can be used to analyze a company''s expected sales volume.', Comment = 'FRA="Affichez la quantit?? pas encore exp??di??e pour chaque client sur 3 p??riodes de 30??jours, chacune commen??ant ?? une date s??lectionn??e. Il contient ??galement des colonnes avec les commandes ?? livrer avant et apr??s les 3??p??riodes et une colonne avec le d??tail de la commande totale de chaque client. Cet ??tat sert ?? analyser le volume de vente attendu d''une soci??t??."';
                    }
                    action("Customer - &Top 10 List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - &Top 10 List', Comment = 'FRA="Clien&ts: Palmar??s"';
                        Image = "Report";
                        RunObject = Report "Customer - Top 10 List";
                        ToolTip = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.', Comment = 'FRA="Affichez les clients qui ach??tent le plus ou qui doivent le plus d''argent au cours d''une p??riode s??lectionn??e. Seuls les clients qui ont des achats pour cette p??riode ou un solde ?? la fin de la p??riode seront inclus."';
                    }
                    action("Customer/&Item Sales")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer/&Item Sales', Comment = 'FRA="Client/&Ventes d''articles"';
                        Image = "Report";
                        RunObject = Report "Customer/Item Sales";
                        ToolTip = 'View a list of item sales for each customer during a selected time period. The report contains information on quantity, sales amount, profit, and possible discounts. It can be used, for example, to analyze a company''s customer groups.', Comment = 'FRA="Affichez une liste des ventes article de chaque client pendant la p??riode choisie. L''??tat donne des informations sur la quantit??, le montant des ventes, la marge et les remises possibles. Il peut servir, par exemple, ?? l''analyse des groupes clients d''une soci??t??."';
                    }
                }
                group(Sales2)
                {
                    Caption = 'Sales', Comment = 'FRA="Ventes"';
                    Image = Sales;
                    action("Salesperson - Sales &Statistics")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Salesperson - Sales &Statistics', Comment = 'FRA="Vendeurs: &Statistiques ventes"';
                        Image = "Report";
                        RunObject = Report "Salesperson - Sales Statistics";
                        ToolTip = 'View amounts for sales, profit, invoice discount, and payment discount, as well as profit percentage, for each salesperson for a selected period. The report also shows the adjusted profit and adjusted profit percentage, which reflect any changes to the original costs of the items in the sales.', Comment = 'FRA="Affichez les montants des ventes, de la marge, de la remise facture et de l''escompte, ainsi que le pourcentage marge sur vente, pour chaque vendeur et pour la p??riode s??lectionn??e. L''??tat indique ??galement le profit ajust?? et le pourcentage marge ajust??e, qui refl??tent tous les changements des co??ts d''origine des articles des ventes."';
                    }
                    action("Price &List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Price &List', Comment = 'FRA="&Liste des prix"';
                        Image = "Report";
                        RunObject = Report "Price List";
                        ToolTip = 'View a list of your items and their prices, for example, to send to customers. You can create the list for specific customers, campaigns, currencies, or other criteria.', Comment = 'FRA="Affichez une liste de vos articles ainsi que leur prix ?? envoyer, par exemple, aux clients. Vous pouvez cr??er la liste pour des clients, des campagnes ou des devises sp??cifiques ou encore pour d''autres crit??res."';
                    }
                    action("Inventory - Sales &Back Orders")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Sales &Back Orders', Comment = 'FRA="Stocks: Commandes &?? livrer"';
                        Image = "Report";
                        RunObject = Report "Inventory - Sales Back Orders";
                        ToolTip = 'View a list with the order lines whose shipment date has been exceeded. The following information is shown for the individual orders for each item: number, customer name, customer''s telephone number, shipment date, order quantity and quantity on back order. The report also shows whether there are other items for the customer on back order.', Comment = 'FRA="Affichez une liste qui comprend les lignes commande dont la date d''exp??dition est d??pass??e. Les informations suivantes sont donn??es pour chaque article d''une commande: num??ro, nom du client, num??ro de t??l??phone du client, date d''exp??dition, quantit?? command??e et quantit?? sur commande en attente. L''??tat indique aussi s''il y a d''autres articles en commande en attente pour le client."';
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
                    ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.', Comment = 'FRA="Recherchez toutes les ??critures et tous les documents qui existent pour le num??ro de document et la date comptabilisation sur l''??criture ou le document."';
                }
            }
        }
    }
}
