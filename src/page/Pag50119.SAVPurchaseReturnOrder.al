page 50119 "BC6_SAV Purchase Return Order"
{
    Caption = 'Purchase Return Order', Comment = 'FRA="Retour achat"';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval', Comment = 'FRA="Nouveau,Traitement,État,Approuver,Lancer,Comptabilisation,Préparer,Facture,Demande d''approbation"';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER("Return Order"));
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'FRA="Général"';
                field("No."; Rec."No.")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the number of the purchase document. The field is only visible if you have not set up a number series for the type of purchase document, or if the Manual Nos. field is selected for the number series.', Comment = 'FRA="Spécifie le numéro du document achat. Le champ n''est visible que si vous n''avez défini aucune souche de numéros pour ce type de document achat, ou si le champ N° manuels est sélectionné pour la souche de numéros."';
                    Visible = DocNoVisible;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    Caption = 'Vendor', Comment = 'FRA="Fournisseur"';
                    Importance = Promoted;
                    QuickEntry = false;
                    ToolTip = 'Specifies the name of the vendor who sends the items. The field is filled automatically when you fill the Buy-from Vendor No. field.', Comment = 'FRA="Spécifie le nom du fournisseur qui envoie les articles. Le champ est rempli automatiquement lorsque vous remplissez le champ N° fournisseur."';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
                            IF Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
                                Rec.SETRANGE("Buy-from Vendor No.");

                        CurrPage.UPDATE;
                    end;
                }
                group("Buy-from")
                {
                    Caption = 'Buy-from', Comment = 'FRA="Fournisseur"';
                    field("Buy-from Address"; Rec."Buy-from Address")
                    {
                        Caption = 'Address', Comment = 'FRA="Adresse"';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the address of the vendor who ships the items.', Comment = 'FRA="Spécifie l''adresse du fournisseur qui expédie les articles."';
                        ApplicationArea = All;
                    }
                    field("Buy-from Address 2"; Rec."Buy-from Address 2")
                    {
                        Caption = 'Address 2', Comment = 'FRA="Adresse (2ème ligne)"';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies additional address information.', Comment = 'FRA="Spécifie des informations d''adresse supplémentaires."';
                        ApplicationArea = All;
                    }
                    field("Buy-from Post Code"; Rec."Buy-from Post Code")
                    {
                        Caption = 'Post Code', Comment = 'FRA="Code postal"';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the postal code.', Comment = 'FRA="Spécifie le code postal."';
                        ApplicationArea = All;
                    }
                    field("Buy-from City"; Rec."Buy-from City")
                    {
                        Caption = 'City', Comment = 'FRA="Ville"';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the city of the vendor who ships the items.', Comment = 'FRA="Spécifie la ville du fournisseur qui expédie les articles."';
                        ApplicationArea = All;
                    }
                    field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                    {
                        Caption = 'Contact No.', Comment = 'FRA="N° contact"';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the number of your contact at the vendor.', Comment = 'FRA="Spécifie le numéro de votre contact au fournisseur."';
                        ApplicationArea = All;
                    }
                }
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                }
                field("Buy-from Fax No."; Rec."BC6_Buy-from Fax No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    Caption = 'Contact', Comment = 'FRA="Contact"';
                    QuickEntry = false;
                    ToolTip = 'Specifies the name of the person to contact about shipment of the item from this vendor.', Comment = 'FRA="Spécifie le nom de la personne à contacter à propos de l''expédition de l''article chez le fournisseur."';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies the date on which the vendor created the purchase document.', Comment = 'FRA="Spécifie la date à laquelle le vendeur a créé le document achat."';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies the date when the posting of the purchase document will be recorded.', Comment = 'FRA="Spécifie la date à laquelle la validation du document achat sera validée."';
                    ApplicationArea = All;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    QuickEntry = false;
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    Importance = Promoted;
                    QuickEntry = false;
                    ApplicationArea = All;
                }
                field("Vendor Authorization No."; Rec."Vendor Authorization No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies the order address code linked to the relevant vendor''s order address.', Comment = 'FRA="Spécifie le code adresse commande lié à l''adresse de commande du fournisseur concerné."';
                    ApplicationArea = All;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.', Comment = 'FRA="Spécifie l''acheteur affecté au fournisseur."';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PurchaserCodeOnAfterValidate;
                    end;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies the campaign number the document is linked to.', Comment = 'FRA="Spécifie le numéro de campagne auquel le document est lié."';
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.', Comment = 'FRA="Spécifie le code du centre de gestion qui est associé à l''utilisateur, à la société ou au fournisseur."';
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.', Comment = 'FRA="Spécifie le code de l''utilisateur qui est responsable du document."';
                    ApplicationArea = All;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    Importance = Additional;
                    QuickEntry = false;
                    Visible = JobQueueUsed;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Importance = Promoted;
                    QuickEntry = false;
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.', Comment = 'FRA="Spécifie si l''enregistrement est ouvert, en attente d''approbation, a été facturé pour acompte ou a été lancé pour l''étape suivante du traitement."';
                    ApplicationArea = All;
                }
                field("Return Order Type"; Rec."BC6_Return Order Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec."BC6_Return Order Type" = Rec."BC6_Return Order Type"::SAV THEN
                            BooGReminderDateVisible := TRUE
                        ELSE
                            BooGReminderDateVisible := FALSE
                    end;
                }
                field("Reminder Date"; Rec."BC6_Reminder Date")
                {
                    Editable = BooGReminderDateVisible;
                    ApplicationArea = All;
                }
            }
            part(PurchLines; "Purchase Return Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
                ApplicationArea = All;
            }
            group("Invoice Details")
            {
                Caption = 'Invoice Details', Comment = 'FRA="Détails facture"';
                field("Currency Code"; Rec."Currency Code")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the currency code for amounts on the purchase lines.', Comment = 'FRA="Spécifie le code devise des montants des lignes achat."';
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec."Posting Date" <> 0D THEN
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date")
                        ELSE
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WORKDATE);
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.SAVERECORD;
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the date you expect to receive the items on the purchase document.', Comment = 'FRA="Spécifie la date à laquelle vous pensez recevoir les articles indiqués sur le document achat."';
                    ApplicationArea = All;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ToolTip = 'Specifies whether the unit price on the line should be displayed including or excluding VAT.', Comment = 'FRA="Spécifie si le prix unitaire de la ligne doit être affiché TTC ou hors taxes."';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ToolTip = 'Specifies the vendor''s VAT specification to link transactions made for this vendor with the appropriate general ledger account according to the VAT posting setup.', Comment = 'FRA="Spécifie le détail TVA du fournisseur pour lier les transactions effectuées pour ce fournisseur au compte général approprié en fonction des paramètres de comptabilisation TVA."';
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the number for the transaction type, for the purpose of reporting to INTRASTAT.', Comment = 'FRA="Spécifie le numéro du type de transaction, à des fins de compte rendu à INTRASTAT."';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the dimension value code associated with the purchase header.', Comment = 'FRA="Spécifie le code de la section analytique associée à l''en-tête achat."';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the dimension value code associated with the purchase header.', Comment = 'FRA="Spécifie le code de la section analytique associée à l''en-tête achat."';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.', Comment = 'FRA="Spécifie un code pour le magasin dans lequel vous souhaitez que les articles soient stockés lorsqu''ils sont réceptionnés."';
                    ApplicationArea = All;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = All;
                }
            }
            group("Shipping and Payment")
            {
                Caption = 'Shipping and Payment', Comment = 'FRA="Expédition et paiement"';
                group("Ship-to")
                {
                    Caption = 'Ship-to', Comment = 'FRA="Destinataire"';
                    field("Ship-to Name"; Rec."Ship-to Name")
                    {
                        Caption = 'Name', Comment = 'FRA="Nom"';
                        Importance = Additional;
                        ToolTip = 'Specifies the name of the company at the address to which you want the items in the purchase order to be shipped.', Comment = 'FRA="Spécifie le nom de la société située à l''adresse à laquelle vous voulez que les articles de la commande achat soient livrés."';
                        ApplicationArea = All;
                    }
                    field("Ship-to Address"; Rec."Ship-to Address")
                    {
                        Caption = 'Address', Comment = 'FRA="Adresse"';
                        Importance = Additional;
                        ToolTip = 'Specifies the address that you want the items in the purchase order to be shipped to.', Comment = 'FRA="Spécifie l''adresse à laquelle vous voulez que les articles de la commande achat soient expédiés."';
                        ApplicationArea = All;
                    }
                    field("Ship-to Address 2"; Rec."Ship-to Address 2")
                    {
                        Caption = 'Address 2', Comment = 'FRA="Adresse (2ème ligne)"';
                        Importance = Additional;
                        ToolTip = 'Specifies additional address information.', Comment = 'FRA="Spécifie des informations d''adresse supplémentaires."';
                        ApplicationArea = All;
                    }
                    field("Ship-to Post Code"; Rec."Ship-to Post Code")
                    {
                        Caption = 'Post Code', Comment = 'FRA="Code postal"';
                        Importance = Additional;
                        ToolTip = 'Specifies the postal code.', Comment = 'FRA="Spécifie le code postal."';
                        ApplicationArea = All;
                    }
                    field("Ship-to City"; Rec."Ship-to City")
                    {
                        Caption = 'City', Comment = 'FRA="Ville"';
                        Importance = Additional;
                        ToolTip = 'Specifies the city the items in the purchase order will be shipped to.', Comment = 'FRA="Spécifie la ville vers laquelle les articles de la commande achat seront expédiés."';
                        ApplicationArea = All;
                    }
                    field("Ship-to Contact"; Rec."Ship-to Contact")
                    {
                        Caption = 'Contact', Comment = 'FRA="Contact"';
                        Importance = Additional;
                        ToolTip = 'Specifies the name of a contact person for the address where the items in the purchase order should be shipped.', Comment = 'FRA="Spécifie le nom d''un contact pour l''adresse à laquelle les articles de la commande achat devraient être expédiés."';
                        ApplicationArea = All;
                    }
                }
                group("Pay-to")
                {
                    Caption = 'Pay-to', Comment = 'FRA="Paiement"';
                    field("Pay-to Name"; Rec."Pay-to Name")
                    {
                        Caption = 'Name', Comment = 'FRA="Nom"';
                        Importance = Promoted;
                        ToolTip = 'Specifies the name of the vendor sending the invoice.', Comment = 'FRA="Spécifie le nom du fournisseur envoyant la facture."';
                        ApplicationArea = All;
                    }
                    field("Pay-to Address"; Rec."Pay-to Address")
                    {
                        Caption = 'Address', Comment = 'FRA="Adresse"';
                        Importance = Additional;
                        ToolTip = 'Specifies the address of the vendor sending the invoice.', Comment = 'FRA="Spécifie l''adresse du fournisseur envoyant la facture."';
                        ApplicationArea = All;
                    }
                    field("Pay-to Address 2"; Rec."Pay-to Address 2")
                    {
                        Caption = 'Address 2', Comment = 'FRA="Adresse (2ème ligne)"';
                        Importance = Additional;
                        ToolTip = 'Specifies additional address information.', Comment = 'FRA="Spécifie des informations d''adresse supplémentaires."';
                        ApplicationArea = All;
                    }
                    field("Pay-to Post Code"; Rec."Pay-to Post Code")
                    {
                        Caption = 'Post Code', Comment = 'FRA="Code postal"';
                        Importance = Additional;
                        ToolTip = 'Specifies the postal code.', Comment = 'FRA="Spécifie le code postal."';
                        ApplicationArea = All;
                    }
                    field("Pay-to City"; Rec."Pay-to City")
                    {
                        Caption = 'City', Comment = 'FRA="Ville"';
                        Importance = Additional;
                        ToolTip = 'Specifies the city of the vendor sending the invoice.', Comment = 'FRA="Spécifie la ville du fournisseur envoyant la facture."';
                        ApplicationArea = All;
                    }
                    field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                    {
                        Caption = 'Contact No.', Comment = 'FRA="N° contact"';
                        Importance = Additional;
                        ToolTip = 'Specifies the number of the contact who sends the invoice.', Comment = 'FRA="Spécifie le numéro du contact qui envoie la facture."';
                        ApplicationArea = All;
                    }
                    field("Pay-to Contact"; Rec."Pay-to Contact")
                    {
                        Caption = 'Contact', Comment = 'FRA="Contact"';
                        Importance = Additional;
                        ToolTip = 'Specifies the name of the person to contact about an invoice from this vendor.', Comment = 'FRA="Spécifie le nom de la personne à contacter au sujet d''une facture émise par ce fournisseur."';
                        ApplicationArea = All;
                    }
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade', Comment = 'FRA="International"';
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ToolTip = 'Specifies a code for the purchase header''s transaction specification here.', Comment = 'FRA="Spécifie un code pour le régime de l''en-tête achat ici."';
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ToolTip = 'Specifies the code for the transport method to be used with this purchase header.', Comment = 'FRA="Spécifie le code mode de transport à utiliser avec cet en-tête achat."';
                    ApplicationArea = All;
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ToolTip = 'Specifies the code of the port of entry where the items pass into your country/region.', Comment = 'FRA="Spécifie le code du point d''entrée par lequel les articles ont pénétré dans votre pays/région."';
                    ApplicationArea = All;
                }
                field("Area"; Rec.Area)
                {
                    ToolTip = 'Specifies the code for the area of the vendor''s address.', Comment = 'FRA="Spécifie le code de la zone de l''adresse du fournisseur."';
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part("Pending Approval FactBox"; "Pending Approval FactBox")
            {
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
                ApplicationArea = All;
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                Visible = false;
                ApplicationArea = All;
            }
            part("Vendor Details FactBox"; "Vendor Details FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                ApplicationArea = All;
            }
            part("Vendor Statistics FactBox"; "Vendor Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
                ApplicationArea = All;
            }
            part("Vendor Hist. Buy-from FactBox"; "Vendor Hist. Buy-from FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                ApplicationArea = All;
            }
            part("Vendor Hist. Pay-to FactBox"; "Vendor Hist. Pay-to FactBox")
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
                ApplicationArea = All;
            }
            part("Purchase Line FactBox"; "Purchase Line FactBox")
            {
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Return Order")
            {
                Caption = '&Return Order', Comment = 'FRA="&Retour"';
                Image = Return;
                action(Statistics)
                {
                    Caption = 'Statistics', Comment = 'FRA="Statistiques"';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.', Comment = 'FRA="Affichez les informations statistiques telles que la valeur des écritures validées pour l''enregistrement."';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.OpenPurchaseOrderStatistics;
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(Vendor)
                {
                    Caption = 'Vendor', Comment = 'FRA="Fournisseur"';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions', Comment = 'FRA="Axes analytiques"';
                    Enabled = Rec."No." <> '';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', Comment = 'FRA="Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions."';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    Caption = 'Approvals', Comment = 'FRA="Approbations"';
                    Image = Approvals;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', Comment = 'FRA="Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due."';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.Setfilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.RUN;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments', Comment = 'FRA="Co&mmentaires"';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ToolTip = 'View or add notes about the purchase return order.', Comment = 'FRA="Affichez ou ajoutez des remarques sur le retour commande achat."';
                    ApplicationArea = All;
                }
            }
            group(Documents)
            {
                Caption = 'Documents', Comment = 'FRA="Documents"';
                Image = Documents;
                action("Return Shipments")
                {
                    Caption = 'Return Shipments', Comment = 'FRA="Expéditions retour"';
                    Image = Shipment;
                    RunObject = Page "Posted Return Shipments";
                    RunPageLink = "Return Order No." = FIELD("No.");
                    RunPageView = SORTING("Return Order No.");
                    ApplicationArea = All;
                }
                action("Cred&it Memos")
                {
                    Caption = 'Cred&it Memos', Comment = 'FRA="A&voirs"';
                    Image = CreditMemo;
                    RunObject = Page "Posted Purchase Credit Memos";
                    RunPageLink = "Return Order No." = FIELD("No.");
                    RunPageView = SORTING("Return Order No.");
                    ApplicationArea = All;
                }
                separator(sep)
                {
                }
            }
            group(Warehouses)
            {
                Caption = 'Warehouse', Comment = 'FRA="Entrepôt"';
                Image = Warehouse;
                action("Whse. Shipment Lines")
                {
                    Caption = 'Whse. Shipment Lines', Comment = 'FRA="Lignes expédition entrep."';
                    Image = ShipmentLines;
                    RunObject = Page "Whse. Shipment Lines";
                    RunPageLink = "Source Type" = CONST(39),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    ApplicationArea = All;
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines', Comment = 'FRA="Lignes prélè&v./rangement stock"';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Purchase Return Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval', Comment = 'FRA="Approbation"';
                action(Approve)
                {
                    Caption = 'Approve', Comment = 'FRA="Approuver"';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.', Comment = 'FRA="Approuvez les modifications demandées."';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject', Comment = 'FRA="Rejeter"';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Reject the approval request.', Comment = 'FRA="Rejetez la demande d''approbation."';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Delegate)
                {
                    Caption = 'Delegate', Comment = 'FRA="Déléguer"';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Delegate the approval to a substitute approver.', Comment = 'FRA="Déléguez l''approbation à un approbateur remplaçant."';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Comment)
                {
                    Caption = 'Comments', Comment = 'FRA="Commentaires"';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'View or add comments.', Comment = 'FRA="Affichez ou ajoutez des commentaires."';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = All;

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
                Caption = '&Print', Comment = 'FRA="&Imprimer"';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    L_PurchaseHeader: Record "Purchase Header";
                begin
                    IF Rec."BC6_Return Order Type" = Rec."BC6_Return Order Type"::Location THEN
                        DocPrint.PrintPurchHeader(Rec)
                    ELSE BEGIN
                        L_PurchaseHeader.RESET;
                        L_PurchaseHeader.SETRANGE("Document Type", Rec."Document Type");
                        L_PurchaseHeader.SETRANGE("No.", Rec."No.");
                        REPORT.RUNMODAL(Report::"Purchase Return Order - SAV", TRUE, FALSE, L_PurchaseHeader);
                    END;
                    //<<BCSYS
                end;
            }
            group(Release)
            {
                Caption = 'Release', Comment = 'FRA="Lancer"';
                Image = ReleaseDoc;
                action("Re&lease")
                {
                    Caption = 'Re&lease', Comment = 'FRA="&Lancer"';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Re&open', Comment = 'FRA="R&ouvrir"';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed', Comment = 'FRA="Rouvrez le document pour le modifier après son approbation. Les documents approuvés ont le statut Lancé et doivent être ouverts pour pouvoir être modifiés."';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(sep1)
                {
                }
            }
            group("F                &unctions")
            {
                Caption = 'F&unctions', Comment = 'FRA="Fonction&s"';
                Image = "Action";
                action(GetPostedDocumentLinesToReverse)
                {
                    Caption = 'Get Posted Doc&ument Lines to Reverse', Comment = 'FRA="Extraire lignes doc&ument enreg. à contrepasser"';
                    Ellipsis = true;
                    Image = ReverseLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.GetPstdDocLinesToReverse;
                    end;
                }
                action("Apply Entries")
                {
                    Caption = 'Apply Entries', Comment = 'FRA="Lettrer écritures"';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+F11';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Purchase Header Apply", Rec);
                    end;
                }
                separator(sep2)
                {
                }
                action(CalculateInvoiceDiscount)
                {
                    AccessByPermission = TableData "Vendor Invoice Disc." = R;
                    Caption = 'Calculate &Invoice Discount', Comment = 'FRA="C&alculer remise facture"';
                    Image = CalculateInvoiceDiscount;
                    ToolTip = 'Calculate the invoice discount for the entire purchase invoice.', Comment = 'FRA="Calculez la remise facture pour l''ensemble de la facture achat."';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                separator(sep3)
                {
                }
                action(CopyDocument)
                {
                    Caption = 'Copy Document', Comment = 'FRA="Copier document"';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL;
                        CLEAR(CopyPurchDoc);
                        IF Rec.GET(Rec."Document Type", Rec."No.") THEN;
                    end;
                }
                action("Move Negative Lines")
                {
                    Caption = 'Move Negative Lines', Comment = 'FRA="Déplacer lignes négatives"';
                    Ellipsis = true;
                    Image = MoveNegativeLines;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RUNMODAL;
                        MoveNegPurchLines.ShowDocument;
                    end;
                }
                action("Archive Document")
                {
                    Caption = 'Archive Document', Comment = 'FRA="Archiver document"';
                    Image = Archive;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Send IC Return Order")
                {
                    AccessByPermission = TableData "IC G/L Account" = R;
                    Caption = 'Send IC Return Order', Comment = 'FRA="Envoyer retour IC"';
                    Image = IntercompanyOrder;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ICInOutMgt: Codeunit ICInboxOutboxMgt;
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
                            ICInOutMgt.SendPurchDoc(Rec, FALSE);
                    end;
                }
                separator(sep4)
                {
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval', Comment = 'FRA="Approbation demande achat"';
                Image = Approval;
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request', Comment = 'FRA="Envoyer demande d''a&pprobation"';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Send an approval request.', Comment = 'FRA="Envoyez une demande d''approbation."';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        IF ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) THEN
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest', Comment = 'FRA="Annuler demande d''appro&bation"';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.', Comment = 'FRA="Annulez la demande d''approbation."';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
                separator(sep5)
                {
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse', Comment = 'FRA="Entrepôt"';
                Image = Warehouse;
                action("Create &Whse. Shipment")
                {
                    AccessByPermission = TableData "Warehouse Shipment Header" = R;
                    Caption = 'Create &Whse. Shipment', Comment = 'FRA="Créer e&xpédition entrepôt"';
                    Image = NewShipment;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        GetSourceDocOutbound.CreateFromPurchaseReturnOrder(Rec);
                    end;
                }
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData "Posted Invt. Pick Header" = R;
                    Caption = 'Create Inventor&y Put-away/Pick', Comment = 'FRA="Créer prélèv./rangement stoc&k"';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CreateInvtPutAwayPick;
                    end;
                }
                separator(sep6)
                {
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting', Comment = 'FRA="&Validation"';
                Image = Post;
                action(Post)
                {
                    Caption = 'P&ost', Comment = 'FRA="&Valider"';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                }
                action("Preview")
                {
                    Caption = 'Preview Posting', Comment = 'FRA="Aperçu compta."';
                    Image = ViewPostedOrder;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.', Comment = 'FRA="Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille."';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                    begin
                        PurchPostYesNo.Preview(Rec);
                    end;
                }
                action(TestReport)
                {
                    Caption = 'Test Report', Comment = 'FRA="Impression test"';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', Comment = 'FRA="Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document."';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(PostAndPrint)
                {
                    Caption = 'Post and &Print', Comment = 'FRA="Valider et i&mprimer"';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action(PostBatch)
                {
                    Caption = 'Post &Batch', Comment = 'FRA="Valider par l&ot"';
                    Ellipsis = true;
                    Image = PostBatch;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purch. Ret. Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action(RemoveFromJobQueue)
                {
                    Caption = 'Remove From Job Queue', Comment = 'FRA="Supprimer de la file d''attente des travaux"';
                    Image = RemoveLine;
                    Visible = JobQueueVisible;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting;
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
        SetControlAppearance;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(Rec.ConfirmDeletion);
    end;

    trigger OnInit()
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        JobQueueUsed := PurchasesPayablesSetup.JobQueueActive;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
        IF (NOT DocNoVisible) AND (Rec."No." = '') THEN
            Rec.SetBuyFromVendorFromFilter;

        Rec."BC6_Return Order Type" := Rec."BC6_Return Order Type"::SAV;
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter);
            Rec.FILTERGROUP(0);
        END;

        SetDocNoVisible;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF NOT DocumentIsPosted THEN
            EXIT(Rec.ConfirmCloseUnposted);
    end;

    var
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        DocPrint: Codeunit "Document-Print";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        ChangeExchangeRate: Page "Change Exchange Rate";
        [InDataSet]

        JobQueueVisible: Boolean;
        [InDataSet]
        JobQueueUsed: Boolean;
        DocNoVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        ShowWorkflowStatus: Boolean;
        CanCancelApprovalForRecord: Boolean;
        DocumentIsPosted: Boolean;
        OpenPostedPurchaseReturnOrderQst: Label 'The return order has been posted and moved to the Posted Purchase Credit Memos window.\\Do you want to open the posted credit memo?', Comment = 'FRA="Le retour vente a été enregistré et déplacé dans la fenêtre Avoirs achat enregistrés.\\Voulez-vous ouvrir l''avoir enregistré ?"';
        "-BCSYS-": Integer;
        BooGReminderDateVisible: Boolean;

    local procedure Post(PostingCodeunitID: Integer)
    var
        PurchaseHeader: Record "Purchase Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        Rec.SendToPosting(PostingCodeunitID);

        DocumentIsPosted := NOT PurchaseHeader.GET(Rec."Document Type", Rec."No.");

        IF Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);

        IF PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" THEN
            EXIT;

        IF InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) THEN
            ShowPostedConfirmationMessage;
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::"Return Order", Rec."No.");
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        JobQueueVisible := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);

        IF "BC6_Return Order Type" = "BC6_Return Order Type"::SAV THEN
            BooGReminderDateVisible := TRUE;
    end;

    local procedure ShowPostedConfirmationMessage()
    var
        ReturnOrderPurchaseHeader: Record "Purchase Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        IF NOT ReturnOrderPurchaseHeader.GET(Rec."Document Type", Rec."No.") THEN BEGIN
            PurchCrMemoHdr.SETRANGE("No.", Rec."Last Posting No.");
            IF PurchCrMemoHdr.FINDFIRST THEN
                IF InstructionMgt.ShowConfirm(OpenPostedPurchaseReturnOrderQst, InstructionMgt.ShowPostedConfirmationMessageCode) THEN
                    PAGE.RUN(PAGE::"Posted Purchase Credit Memo", PurchCrMemoHdr);
        END;
    end;
}


