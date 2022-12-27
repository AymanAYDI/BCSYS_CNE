page 50116 "BC6_SAV Sales Return Order"
{
    Caption = 'Sales Return Order', comment = 'FRA="Retour vente"';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval', Comment = 'FRA="Nouveau,Traitement,état,Approuver,Lancer,Comptabilisation,Préparer,Facture,Demande d''approbation"';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER("Return Order"));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General', comment = 'FRA="Général"';
                field("No."; Rec."No.")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the number of the sales document. The field can be filled automatically or manually and can be set up to be invisible.',
                     comment = 'FRA="Spécifie le numéro du document vente. Le champ peut étre rempli automatiquement ou manuellement et étre configurer pour étre invisible."';
                    Visible = DocNoVisible;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    Caption = 'Customer', comment = 'FRA="Client"';
                    Importance = Promoted;
                    QuickEntry = false;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the name of the customer who will receive the products and be billed by default.'
                     , comment = 'FRA="Spécifie le nom du client qui recevra les produits et sera facturer par défaut."';

                    trigger OnValidate()
                    begin
                        IF Rec.GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." THEN
                            IF Rec."Sell-to Customer No." <> xRec."Sell-to Customer No." THEN
                                Rec.SETRANGE("Sell-to Customer No.");

                        CurrPage.UPDATE();
                    end;
                }
                group("Sell-to")
                {
                    Caption = 'Sell-to', comment = 'FRA="Donneur d''ordre"';
                    field("Sell-to Address"; Rec."Sell-to Address")
                    {
                        Caption = 'Address', comment = 'FRA="Adresse"';
                        Importance = Additional;
                        ToolTip = 'Specifies the address where the customer is located.', comment = 'FRA="Spécifie l''adresse où se trouve le client."';
                    }
                    field("Sell-to Address 2"; Rec."Sell-to Address 2")
                    {
                        Caption = 'Address 2', comment = 'FRA="Adresse (2éme ligne)"';
                        Importance = Additional;
                        ToolTip = 'Specifies additional address information.', comment = 'FRA="Spécifie des informations d''adresse supplémentaires."';
                    }
                    field("Sell-to Post Code"; Rec."Sell-to Post Code")
                    {
                        Caption = 'Post Code', comment = 'FRA="Code postal"';
                        Importance = Additional;
                        ToolTip = 'Specifies the postal code.', comment = 'FRA="Spécifie le code postal."';
                    }
                    field("Sell-to City"; Rec."Sell-to City")
                    {
                        Caption = 'City', comment = 'FRA="Ville"';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the city where the customer is located.', comment = 'FRA="Spécifie la ville où se trouve le client."';
                    }
                    field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                    {
                        Caption = 'Contact No.', comment = 'FRA="No contact"';
                        Importance = Additional;
                        ToolTip = 'Specifies the number of the contact that the sales document will be sent to.', comment = 'FRA="Spécifie le numéro du contact auquel vous envoyez le document vente."';

                        trigger OnValidate()
                        begin
                            IF Rec.GETFILTER("Sell-to Contact No.") = xRec."Sell-to Contact No." THEN
                                IF Rec."Sell-to Contact No." <> xRec."Sell-to Contact No." THEN
                                    Rec.SETRANGE("Sell-to Contact No.");
                        end;
                    }
                }
                field(ID; Rec.ID)
                {
                }
                field("Sell-to Fax No."; Rec."BC6_Sell-to Fax No.")
                {
                }
                field("Affair No."; Rec."BC6_Affair No.")
                {
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    Caption = 'Contact', comment = 'FRA="Contact"';
                    ToolTip = 'Specifies the name of the person to contact at the customer.', comment = 'FRA="Spécifie le nom de la personn à contacter chez le client."';
                }
                field("Document Date"; Rec."Document Date")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies the date on which you created the sales document.', comment = 'FRA="Spécifie la date à laquelle  vous avez crée le document vente."';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies the date when the posting of the sales document will be recorded.', comment = 'FRA="Spécifie la date à laquelle  la validation du document vente sera validé."';
                }
                field("Order Date"; Rec."Order Date")
                {
                    Importance = Promoted;
                    QuickEntry = false;
                    ToolTip = 'Specifies the date on which the exchange rate applies to prices listed in a foreign currency on the sales order.', comment = 'FRA="Spécifie la date à laquelle  le taux de change s''applique aux prix répertoriés dans une devise étrangère de la commande vente."';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the number that the customer uses in their own system to refer to this sales document.', comment = 'FRA="Spécifie le numéro que le client doit utiliser dans son propre systéme pour faire référence à ce document vente."';
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ToolTip = 'Specifies the number of archived versions for this sales document.', comment = 'FRA="Spécifie le nombre de versions archivées pour ce document vente."';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies the name of the salesperson who is assigned to the customer.', comment = 'FRA="Spécifie le nom du vendeur affecté au client."';

                    trigger OnValidate()
                    begin
                        SalespersonCodeOnAfterValidate();
                    end;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ToolTip = 'Specifies the number of the campaign that the document is linked to.', comment = 'FRA="Spécifie le numéro de campagne auquel le document est lié."';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.', comment = 'FRA="Spécifie le code du centre de gestion qui est associé à l''utilisateur, à la société ou au fournisseur."';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.', comment = 'FRA="Spécifie le code de l''utilisateur qui est responsable du document."';
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the status of a job queue entry or task that handles the posting of sales orders.', comment = 'FRA="Spécifie le statut d''une écriture file d''attente des travaux ou d''une fiche qui gére la validation des commandes vente."';
                    Visible = JobQueueUsed;
                }
                field("Return Order Type"; Rec."BC6_Return Order Type")
                {
                }
                field(Status; Rec.Status)
                {
                    Importance = Promoted;
                    QuickEntry = false;
                    ToolTip = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.'
                    , comment = 'FRA="Spécifie si le document est ouvert, est en attente d''approbation, a été facturé pour acompte ou a été lanc‚ pour l''étape suivante du traitement."';
                }
            }
            part(SalesLines; "Sales Return Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
            group("Invoice Details")
            {
                Caption = 'Invoice Details', comment = 'FRA="Détails facture"';
                field("Currency Code"; Rec."Currency Code")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the currency of amounts on the sales document.', comment = 'FRA="Spécifie la devise des montants sur le document vente."';

                    trigger OnAssistEdit()
                    begin
                        IF Rec."Posting Date" <> 0D THEN
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date")
                        ELSE
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WORKDATE());
                        IF ChangeExchangeRate.RUNMODAL() = ACTION::OK THEN BEGIN
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter());
                            CurrPage.UPDATE();
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.SAVERECORD();
                        SalesCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ToolTip = 'Specifies whether the unit price on the line should be displayed including or excluding VAT.'
                    , comment = 'FRA="Spécifie si le prix unitaire de la ligne doit étre affiché TTC ou hors taxes."';

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid();
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ToolTip = 'Specifies the customer''s VAT specification to link transactions made for this customer to.'
                    , comment = 'FRA="Spécifie le détail TVA du client auquel associer des transactions faites pour ce client."';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the type of transaction that the sales document represents, for the purpose of reporting to INTRASTAT.'
                    , comment = 'FRA="Spécifie le type de transaction que représente le document vente, à des fins de compte rendu intracommunautaire"';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the dimension value code associated with the sales header.', comment = 'FRA="Spécifie le code section analytique associée à l''en-tête vente."';

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV();
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the dimension value code associated with the sales header.', comment = 'FRA="Spécifie le code section analytique associée à l''en-tête vente."';

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV();
                    end;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the date you expect to ship items on the sales document.', comment = 'FRA="Spécifie la date à laquelle  vous pensez expédier les articles indiqués sur le document vente."';
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.'

                    , comment = 'FRA="Spécifie le numéro du document validé avec lequel ce document ou cette ligne feuille sera lettré lorsque vous validez, par exemple pour enregistrer un paiement."';
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the number of the posted document that this document or journal line will be applied to when you post, for example to register payment.'
                    , comment = 'FRA=""';
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ToolTip = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.'
                    , comment = 'FRA="Spécifie l''ID de lettrage des écritures lorsque vous choisissez l''action Ecr. ouvertes."';
                }
            }
            group("Shipping and Billing")
            {
                Caption = 'Shipping and Billing', comment = 'FRA="Expédition et facturation"';
                group("Shipment Method")
                {
                    Caption = 'Shipment Method', comment = 'FRA="Conditions de livraison"';
                    field("Shipping Agent Code"; Rec."Shipping Agent Code")
                    {
                        Caption = 'Agent', comment = 'FRA="Transporteur"';
                        Importance = Additional;
                        ToolTip = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.', comment = 'FRA="Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente."';
                    }
                    field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                    {
                        Caption = 'Agent Service', comment = 'FRA="Prestation transporteur"';
                        Importance = Additional;
                        ToolTip = 'Specifies which shipping agent service is used to transport the items on the sales document to the customer.', comment = 'FRA="Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente."';
                    }
                    field("Package Tracking No."; Rec."Package Tracking No.")
                    {
                        Importance = Additional;
                        ToolTip = 'Specifies the shipping agent''s package number.', comment = 'FRA="Spécifie le numéro récépissé du transporteur."';
                    }
                }
                group("Ship-to")
                {
                    Caption = 'Ship-to', comment = 'FRA="Destinataire"';
                    field("Location Code"; Rec."Location Code")
                    {
                        Caption = 'Location', comment = 'FRA="Emplacement"';
                        Importance = Promoted;
                        ToolTip = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.',
                         comment = 'FRA="Spécifie le magasin … partir duquel les articles de stock doivent étre expédiés par défaut au client figurant sur le document vente."';
                    }
                    field("Ship-to Name"; Rec."Ship-to Name")
                    {
                        Caption = 'Name', comment = 'FRA="Nom"';
                        ToolTip = 'Specifies the name that products on the sales document will be shipped to.'
                        , comment = 'FRA="Spécifie le nom auquel les produits mentionnés sur le document vente seront expédiés."';
                    }
                    field("Ship-to Address"; Rec."Ship-to Address")
                    {
                        Caption = 'Address', comment = 'FRA="Adresse"';
                        ToolTip = 'Specifies the address that products on the sales document will be shipped to.'
                        , comment = 'FRA="Spécifie l''adresse à laquelle  les produits mentionnés sur le document vente seront expédiés."';
                    }
                    field("Ship-to Address 2"; Rec."Ship-to Address 2")
                    {
                        Caption = 'Address 2', comment = 'FRA="Adresse (2éme ligne)"';
                        ToolTip = 'Specifies additional address information.', comment = 'FRA="Spécifie des informations d''adresse supplémentaires."';
                    }
                    field("Ship-to Post Code"; Rec."Ship-to Post Code")
                    {
                        Caption = 'Post Code', comment = 'FRA="Code postal."';
                        ToolTip = 'Specifies the postal code.', comment = 'FRA="Spécifie le code postal."';
                    }
                    field("Ship-to City"; Rec."Ship-to City")
                    {
                        Caption = 'City', comment = 'FRA="Ville"';
                        ToolTip = 'Specifies the city that products on the sales document will be shipped to.', comment = 'FRA="Spécifie la ville vers laquelle les produits mentionnés sur le document vente seront expédiés."';
                    }
                    field("Ship-to Contact"; Rec."Ship-to Contact")
                    {
                        Caption = 'Contact', comment = 'FRA="Contact"';
                        ToolTip = 'Specifies the name of the contact person at the address that products on the sales document will be shipped to.', comment = 'FRA=""';
                    }
                }
                group("Bill-to")
                {
                    Caption = 'Bill-to', comment = 'FRA="Facturation"';
                    field("Bill-to Name"; Rec."Bill-to Name")
                    {
                        Caption = 'Name', comment = 'FRA="Nom"';
                        Importance = Promoted;
                        ToolTip = 'Specifies the customer to whom you will send the sales invoice, when different from the customer that you are selling to.', comment = 'FRA="Spécifie le client à qui vous envoyez la facture vente, s''il différe du client à qui vous vendez."';
                    }
                    field("Bill-to Address"; Rec."Bill-to Address")
                    {
                        Caption = 'Address', comment = 'FRA="Adresse"';
                        Importance = Additional;
                        ToolTip = 'Specifies the address of the customer that you will send the invoice to.', comment = 'FRA="Spécifie l''adresse du client à qui vous envoyez la facture."';
                    }
                    field("Bill-to Address 2"; Rec."Bill-to Address 2")
                    {
                        Caption = 'Address 2', comment = 'FRA="Adresse (2éme ligne)"';
                        Importance = Additional;
                        ToolTip = 'Specifies additional address information.', comment = 'FRA="Spécifie des informations d''adresse supplémentaires."';
                    }
                    field("Bill-to Post Code"; Rec."Bill-to Post Code")
                    {
                        Caption = 'Post Code', comment = 'FRA="Code postal."';
                        Importance = Additional;
                        ToolTip = 'Specifies the postal code.', comment = 'FRA="Spécifie le code postal."';
                    }
                    field("Bill-to City"; Rec."Bill-to City")
                    {
                        Caption = 'City', comment = 'FRA="Ville"';
                        Importance = Additional;
                        ToolTip = 'Specifies the city you will send the invoice to.', comment = 'FRA="Spécifie la ville du client qui sera facturé."';
                    }
                    field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                    {
                        Caption = 'Contact No.', comment = 'FRA="No. contact"';
                        Importance = Additional;
                        ToolTip = 'Specifies the number of the contact the invoice will be sent to.', comment = 'FRA="Spécifie le numéro du contact auquel vous envoyez la facture."';
                    }
                    field("Bill-to Contact"; Rec."Bill-to Contact")
                    {
                        Caption = 'Contact', comment = 'FRA="Contact"';
                        ToolTip = 'Specifies the name of the person you should contact at the customer who you are sending the invoice to.', comment = 'FRA="Spécifie le nom de la personne que vous devez contacter chez le client auquel vous envoyez la facture."';
                    }
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade', comment = 'FRA="International"';
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ToolTip = 'Specifies whether the sales document is part of a three-party trade.', comment = 'FRA="Spécifie si le document vente fait partie d''une transaction tripartite."';
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ToolTip = 'Specifies a code for the sales document''s transaction specification, for the purpose of reporting to INTRASTAT.'
                    , comment = 'FRA="Spécifie un code pour le régime du document vente, à des fins de compte-rendu intracommunautaire."';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ToolTip = 'Specifies the transport method, for the purpose of reporting to INTRASTAT.'
                    , comment = 'FRA="Spécifie le mode de transport, à des fins de compte-rendu intracommunautaire."';
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ToolTip = 'Specifies the point of exit through which you ship the items out of your country/region, for reporting to Intrastat.'
                    , comment = 'FRA="Spécifie le point de sortie par lequel les articles sortent de votre pays/région, à des fins de compte-rendu à Intrastat."';
                }
                field(BC6_Area; Rec.Area)
                {
                    ToolTip = 'Specifies the area of the customer''s address, for the purpose of reporting to INTRASTAT.'
                    , comment = 'FRA="Spécifie le point de sortie par lequel les articles sortent de votre pays/région, à des fins de compte-rendu à Intrastat."';
                }
            }
        }
        area(factboxes)
        {
            part("Pending Approval FactBox"; "Pending Approval FactBox")
            {
                SubPageLink = "Table ID" = CONST(36),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part("Sales Hist. Sell-to FactBox"; "Sales Hist. Sell-to FactBox")
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
            }
            part("Sales Hist. Bill-to FactBox"; "Sales Hist. Bill-to FactBox")
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = false;
            }
            part("Customer Statistics FactBox"; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
            }
            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
            }
            part("Sales Line FactBox"; "Sales Line FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = false;
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                Visible = false;
            }
            part("Resource Details FactBox"; "Resource Details FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Return Order")
            {
                Caption = '&Return Order', comment = 'FRA="&Retour"';
                Image = Return;
                action(Statistics)
                {
                    Caption = 'Statistics', comment = 'FRA="Statistiques"';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.', comment = 'FRA="Affichez les informations statistiques telles que la valeur des écritures validées pour l''enregistrement."';

                    trigger OnAction()
                    var
                        Handled: Boolean;
                    begin
                        OnBeforeStatisticsAction(Rec, Handled);
                        IF NOT Handled THEN BEGIN
                            Rec.OpenSalesOrderStatistics();
                            SalesCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                        END
                    end;
                }
                action(Card)
                {
                    Caption = 'Card', comment = 'FRA="Fiche"';
                    Image = EditLines;
                    Promoted = false;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the customer on the sales document.', comment = 'FRA="Afficher ou modifier des informations détaillées concernant le client sur le document vente."';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions', comment = 'FRA="Axes analytiques"';
                    Enabled = Rec."No." <> '';
                    Image = Dimensions;
                    Promoted = false;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.',
                     comment = 'FRA="Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions."';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim();
                        CurrPage.SAVERECORD();
                    end;
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    Caption = 'Approvals', comment = 'FRA="Approbations"';
                    Image = Approvals;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.',
                     comment = 'FRA="Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due."';

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.Setfilters(DATABASE::"Sales Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.RUN();
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments',
                     comment = 'FRA="Co&mmentaires"';
                    Image = ViewComments;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = CONST("Return Order"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ToolTip = 'View or add notes about the sales return order.',
                     comment = 'FRA="Affichez ou ajoutez des remarques sur le retour vente."';
                }
            }
            group(Documents)
            {
                Caption = 'Documents', comment = 'FRA="Documents"';
                Image = Documents;
                action("Return Receipts")
                {
                    Caption = 'Return Receipts', comment = 'FRA="Réceptions retour"';
                    Image = ReturnReceipt;
                    RunObject = Page "Posted Return Receipts";
                    RunPageLink = "Return Order No." = FIELD("No.");
                    RunPageView = SORTING("Return Order No.");
                }
                action("Cred&it Memos")
                {
                    Caption = 'Cred&it Memos', comment = 'FRA="A&voirs"';
                    Image = CreditMemo;
                    RunObject = Page "Posted Sales Credit Memo";
                    RunPageLink = "Return Order No." = FIELD("No.");
                    RunPageView = SORTING("Return Order No.");
                }
                separator(Sep)
                {
                }
            }
            group(Warehouses)
            {
                Caption = 'Warehouse', comment = 'FRA="Entrepot"';
                Image = Warehouse;
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines', comment = 'FRA="Lignes prélévement/rangement stock"';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Sales Return Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }
                action("Whse. Receipt Lines")
                {
                    Caption = 'Whse. Receipt Lines', comment = 'FRA="Lignes réception entrep."';
                    Image = ReceiptLines;
                    RunObject = Page "Whse. Receipt Lines";
                    RunPageLink = "Source Type" = CONST(37),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                }
            }
        }
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval', comment = 'FRA="Approbation"';
                action(Approve)
                {
                    Caption = 'Approve', comment = 'FRA="Approuver"';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.', comment = 'FRA="Approuvez les modifications demandées."';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject', comment = 'FRA="Rejeter"';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Reject the approval request.', comment = 'FRA="Rejetez la demande d''approbation."';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Delegate)
                {
                    Caption = 'Delegate', comment = 'FRA="Déléguer"';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Delegate the approval to a substitute approver.', comment = 'FRA="Déléguez l''approbation à un approbateur remplaçant."';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Comment)
                {
                    Caption = 'Co&mments',
                     comment = 'FRA="Co&mmentaires"';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'View or add comments.', comment = 'FRA="Affichez ou ajoutez des commentaires."';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print', comment = 'FRA="&Imprimer"';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    L_SalesHeader: Record "Sales Header";
                begin
                    IF Rec."BC6_Return Order Type" = Rec."BC6_Return Order Type"::Location THEN BEGIN
                        CASE STRMENU(STR3 + ',' + STR4 + ',' + STR5) OF
                            1:
                                DocPrint.PrintSalesHeader(Rec);
                            2:
                                EnvoiMail();
                        END;
                    END ELSE
                        CASE STRMENU(STR3 + ',' + STR4) OF
                            1:
                                BEGIN
                                    Rec.TESTFIELD(Status, Rec.Status::Released);
                                    L_SalesHeader.RESET();
                                    L_SalesHeader.SETRANGE("Document Type", Rec."Document Type");
                                    L_SalesHeader.SETRANGE("No.", Rec."No.");
                                    REPORT.RUNMODAL(Report::"BC6_Return Order SAV Conf.", TRUE, FALSE, L_SalesHeader);
                                END;
                            2:
                                BEGIN
                                    Rec.TESTFIELD(Status, Rec.Status::Released);
                                    EnvoiMail();
                                END;
                        END;
                end;
            }
            group(Release)
            {
                Caption = 'Release', comment = 'FRA="Lancer"';
                Image = ReleaseDoc;
                action("Re&lease")
                {
                    Caption = 'Re&lease', comment = 'FRA="&Lancer"';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                        FctSendNotification()
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Re&open', comment = 'FRA="&Reouvrir"';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed',
                     comment = 'FRA="Rouvrez le document pour le modifier aprés son approbation. Les documents approuvés ont le statut Lancé et doivent étre ouverts pour pouvoir étre modifiés"';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(Sep1)
                {
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions', comment = 'FRA="Fonction&s"';
                Image = "Action";
                action(CalculateInvoiceDiscount)
                {
                    AccessByPermission = TableData "Cust. Invoice Disc." = R;
                    Caption = 'Calculate &Invoice Discount', comment = 'FRA="C&alculer remise facture"';
                    Image = CalculateInvoiceDiscount;
                    ToolTip = 'Calculate the invoice discount that applies to the sales order.', comment = 'FRA="Calculez la remise facture qui s''applique à la commande vente."';

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc();
                        SalesCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                separator(Sep2)
                {
                }
                action("Apply Entries")
                {
                    Caption = 'Apply Entries', comment = 'FRA="Lettrer écritures"';
                    Ellipsis = true;
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+F11';
                    ToolTip = 'Select one or more ledger entries that you want to apply this record to so that the related posted documents are closed as paid or refunded.'
                    , comment = 'FRA="Sélectionnez une ou plusieurs écritures comptables que vous voulez lettrer avec cet enregistrement afin que les documents validés concernés soient fermés comme étant payés ou remboursés."';

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Sales Header Apply", Rec);
                    end;
                }
                action("Create Return-Related &Documents")
                {
                    Caption = 'Create Return-Related &Documents', comment = 'FRA="Créer documents ass&ociés retour"';
                    Ellipsis = true;
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CLEAR(CreateRetRelDocs);
                        CreateRetRelDocs.SetSalesHeader(Rec);
                        CreateRetRelDocs.RUNMODAL();
                        CreateRetRelDocs.ShowDocuments();
                    end;
                }
                separator(Sep3)
                {
                }
                action(CopyDocument)
                {
                    Caption = 'Copy Document', comment = 'FRA="Copier document"';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Copy document lines and header information from another sales document to this document. You can copy a posted sales invoice into a new sales invoice to quickly create a similar document.'
                    , comment = 'FRA="Copiez les lignes document et les informations d''en-tête d''un autre document vente vers celui-ci. Vous pouvez copier une facture vente validée dans une nouvelle facture vente pour créer rapidement un document similaire."';

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL();
                        CLEAR(CopySalesDoc);
                        IF Rec.GET(Rec."Document Type", Rec."No.") THEN;
                    end;
                }
                action(MoveNegativeLines)
                {
                    Caption = 'Move Negative Lines', comment = 'FRA="Déplacer lignes négatives"';
                    Ellipsis = true;
                    Image = MoveNegativeLines;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RUNMODAL();
                        MoveNegSalesLines.ShowDocument();
                    end;
                }
                action(GetPostedDocumentLinesToReverse)
                {
                    Caption = 'Get Posted Doc&ument Lines to Reverse', comment = 'FRA="Extraire lignes doc&ument enreg. … contrepasser"';
                    Ellipsis = true;
                    Image = ReverseLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Copy one or more posted sales document lines in order to reverse the original order.', comment = 'FRA="Copiez une ou plusieurs lignes de document vente validé afin de contrepasser la commande d''origine."';

                    trigger OnAction()
                    begin
                        GetPstdDocLinesToRevere();
                    end;
                }
                action("Archive Document")
                {
                    Caption = 'Archive Document', comment = 'FRA="Archiver Document"';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchiveSalesDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Send IC Return Order Cnfmn.")
                {
                    AccessByPermission = TableData "IC G/L Account" = R;
                    Caption = 'Send IC Return Order Cnfmn.', comment = 'FRA="Confirmation envoi retour IC"';
                    Image = IntercompanyOrder;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                    begin
                        IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
                            ICInOutboxMgt.SendSalesDoc(Rec, FALSE);
                    end;
                }
                separator(Sep4)
                {
                }
                action(DisplayRelatedDocuments)
                {
                    Caption = 'Display Related Documents', comment = 'FRA="Affichage documents associés"';
                    Image = CopyDocument;
                    trigger OnAction()
                    var
                        L_ReturnOrderMgt: Codeunit "BC6_Return Order Mgt.";
                    begin
                        L_ReturnOrderMgt.DisableRelatedDocuments("No.");
                        CurrPage.UPDATE();
                    end;
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse', comment = 'FRA="Entrepot"';
                Image = Warehouse;
                separator(Sep5)
                {
                }
                action("Create &Whse. Receipt")
                {
                    AccessByPermission = TableData "Warehouse Receipt Header" = R;
                    Caption = 'Create &Whse. Receipt', comment = 'FRA="Créer &réception entrepot"';
                    Image = NewReceipt;

                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    begin
                        GetSourceDocInbound.CreateFromSalesReturnOrder(Rec);
                    end;
                }
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData "Posted Invt. Put-away Header" = R;
                    Caption = 'Create &Whse. Receipt', comment = 'FRA="Créer prélév./rangement stoc&k"';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;

                    trigger OnAction()
                    var
                        FunctionMgt: Codeunit "BC6_Functions Mgt";
                    begin
                        FunctionMgt.BC6_CreateInvtPutAwayPick_Sales(rec);
                    end;
                }
                separator(Sep6)
                {
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting', comment = 'FRA="&Validation"';
                Image = Post;
                action(Post)
                {
                    Caption = 'P&ost', comment = 'FRA="&Valider"';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.'
                    , comment = 'FRA="Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société."';

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Sales-Post (Yes/No)");
                    end;
                }
                action("Preview Posting")
                {
                    Caption = 'Preview Posting', comment = 'FRA="Aperçu compta."';
                    Image = ViewPostedOrder;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.',
                     comment = 'FRA="Examinez les différents types d''écritures qui seront crées lorsque vous validez le document ou la feuille."';

                    trigger OnAction()
                    begin
                        ShowPreview();
                    end;
                }
                action("Test Report")
                {
                    Caption = 'Test Report', comment = 'FRA="Impression test"';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.'
                    , comment = 'FRA="Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document."';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print', comment = 'FRA="Valider et i&mprimer"';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.'
                    , comment = 'FRA="Finalisez et préparez-vous … imprimer le document ou la feuille. Les valeurs et les quantités sont validées en fonction des comptes associés. Une fenétre de demande d''état où vous pouvez spécifier ce qu''il faut inclure sur l''élément … imprimer."';

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Sales-Post + Print");
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch', comment = 'FRA="Valider par l&ot"';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Return Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Remove From Job Queue")
                {
                    Caption = 'Remove From Job Queue', comment = 'FRA="Supprimer de la file d''attente des travaux"';
                    Image = RemoveLine;
                    ToolTip = 'Remove the scheduled processing of this record from the job queue.', comment = 'FRA="Supprimez le traitement planifié de cet enregistrement … partir de la file d''attente des travaux."';
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval', comment = 'FRA="Approbation demande achat"';
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request', comment = 'FRA="Envoyer demande d''a&pprobation"';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Send an approval request.', comment = 'FRA="Envoyez une demande d''approbation."';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        IF ApprovalsMgmt.CheckSalesApprovalPossible(Rec) THEN
                            ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest', comment = 'FRA="Annuler demande d''appro&bation"';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.', comment = 'FRA="Annulez la demande d''approbation."';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RECORDID);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RECORDID);
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD();
        EXIT(Rec.ConfirmDeletion());
    end;

    trigger OnInit()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        JobQueueUsed := SalesReceivablesSetup.JobQueueActive();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF DocNoVisible THEN
            Rec.CheckCreditMaxBeforeInsert();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetSalesFilter();
        IF (NOT DocNoVisible) AND (Rec."No." = '') THEN
            Rec.SetSellToCustomerFromFilter();
        "BC6_Return Order Type" := "BC6_Return Order Type"::SAV;
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter());
            Rec.FILTERGROUP(0);
        END;

        SetDocNoVisible();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF NOT DocumentIsPosted THEN
            EXIT(Rec.ConfirmCloseUnposted());
    end;

    var
        HistMail: Record "BC6_Historique Mails Envoyés";
        cust: Record Customer;
        "Sales & Receivables Setup": Record "Sales & Receivables Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        CopySalesDoc: Report "Copy Sales Document";
        CreateRetRelDocs: Report "Create Ret.-Related Documents";
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ArchiveManagement: Codeunit ArchiveManagement;
        DocPrint: Codeunit "Document-Print";
        Mail: Codeunit Mail;
        SalesCalcDiscByType: Codeunit "Sales - Calc Discount By Type";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        ChangeExchangeRate: Page "Change Exchange Rate";
        CanCancelApprovalForRecord: Boolean;
        DocNoVisible: Boolean;
        DocumentIsPosted: Boolean;
        Excel: Boolean;
        [InDataSet]
        JobQueueUsed: Boolean;
        [InDataSet]

        JobQueueVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        ShowWorkflowStatus: Boolean;

        CstNewReturnOrder: Label 'Nouveau retour SAV';
        OpenPostedSalesReturnOrderQst: Label 'The return order has been posted and moved to the Posted Sales Credit Memos window.\\Do you want to open the posted credit memo?'
        , comment = 'FRA="Le retour vente a été enregistré et déplacé dans la fenétre Avoirs vente enregistrés.\\Voulez-vous ouvrir l''avoir enregistré?"';
        STR3: Label 'Print Document', comment = 'FRA="Imprimer le document"';
        STR4: Label 'Envoyer par Mail';
        STR5: Label 'Envoyer par Fax';
        Text001: Label '';
        nameF: Text[250];

    local procedure Post(PostingCodeunitID: Integer)
    var
        SalesHeader: Record "Sales Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        Rec.SendToPosting(PostingCodeunitID);

        DocumentIsPosted := NOT SalesHeader.GET(Rec."Document Type", Rec."No.");

        IF Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE();
        CurrPage.UPDATE(FALSE);

        IF PostingCodeunitID <> CODEUNIT::"Sales-Post (Yes/No)" THEN
            EXIT;

        IF InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) THEN
            ShowPostedConfirmationMessage();
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc();
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE();
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::"Return Order", Rec."No.");
    end;

    procedure ShowPreview()
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Preview(Rec);
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        JobQueueVisible := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
    end;

    local procedure ShowPostedConfirmationMessage()
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        ReturnOrderSalesHeader: Record "Sales Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        IF NOT ReturnOrderSalesHeader.GET(Rec."Document Type", Rec."No.") THEN BEGIN
            SalesCrMemoHeader.SETRANGE("No.", Rec."Last Posting No.");
            IF SalesCrMemoHeader.FINDFIRST() THEN
                IF InstructionMgt.ShowConfirm(OpenPostedSalesReturnOrderQst, InstructionMgt.ShowPostedConfirmationMessageCode()) THEN
                    PAGE.RUN(PAGE::"Posted Sales Credit Memo", SalesCrMemoHeader);
        END;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeStatisticsAction(var SalesHeader: Record "Sales Header"; var Handled: Boolean)
    begin
    end;

    procedure EnvoiMail()
    begin
        cust.SETRANGE(cust."No.", Rec."Sell-to Customer No.");
        IF cust.FIND('-') THEN
            cust.TESTFIELD("E-Mail");
        OpenFile();
        IF nameF <> '' THEN BEGIN
            ERASE(nameF);
        END ELSE BEGIN
            ERASE(SalesSetup.BC6_Repertoire + 'Envoi' + '\' + CurrPage.CAPTION);
            ERROR(Text001);
        END;
        HistMail."No." := cust."No.";
        HistMail.Nom := cust.Name;
        HistMail."E-Mail" := cust."E-Mail";
        HistMail."Date d'envoi" := TODAY;
        HistMail."Document envoyé" := CurrPage.CAPTION + ' ' + Rec."No.";
        HistMail.INSERT(TRUE);
    end;

    procedure OpenFile()
    begin
    end;

    local procedure FctSendNotification()    //TODO check changement de la function create notification
    var
        NotificationEntry: Record "Notification Entry";
        L_UserSetup: Record "User Setup";
        WorkflowStepArgument: Record "Workflow Step Argument";
        WorkflowStepInstance: Record "Workflow Step Instance";
        notification: Notification;
    begin
        L_UserSetup.RESET();
        L_UserSetup.SETRANGE("BC6_SAV Admin", TRUE);

        IF L_UserSetup.FINDFIRST() THEN begin
            WorkflowStepInstance.Get();
            if WorkflowStepArgument.Get(WorkflowStepInstance.Argument) then
                REPEAT

                    NotificationEntry.CreateNotificationEntry(NotificationEntry.Type::"New Record", L_UserSetup."User ID", Rec, WorkflowStepArgument."Link Target Page",
                                      WorkflowStepArgument."Custom Link", CopyStr(UserId(), 1, 50));

                UNTIL L_UserSetup.NEXT() = 0;
        end;
    end;
}
