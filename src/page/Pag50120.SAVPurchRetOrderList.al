page 50120 "BC6_SAV Purch. Ret. Order List"
{
    Caption = 'Purchase Return Orders', Comment = 'FRA="Retours achat"';
    CardPageID = "BC6_SAV Purchase Return Order";
    DataCaptionFields = "Buy-from Vendor No.";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Request Approval', Comment = 'FRA="Nouveau,Traitement,État,Approbation demande achat"';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = CONST("Return Order"),
                            "BC6_Return Order Type" = CONST(SAV));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the purchase document. The field is only visible if you have not set up a number series for the type of purchase document, or if the Manual Nos. field is selected for the number series.', Comment = 'FRA="Spécifie le numéro du document achat. Le champ n''est visible que si vous n''avez défini aucune souche de numéros pour ce type de document achat, ou si le champ N° manuels est sélectionné pour la souche de numéros."';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'Specifies the nubmer of the vendor that you bought the items from.', Comment = 'FRA="Indique le numéro du fournisseur auprès duquel vous avez acheté les articles."';
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ToolTip = 'Specifies the order address code linked to the relevant vendor''s order address.', Comment = 'FRA="Spécifie le code adresse commande lié à l''adresse de commande du fournisseur concerné."';
                    Visible = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ToolTip = 'Specifies the name of the vendor who sends the items. The field is filled automatically when you fill the Buy-from Vendor No. field.', Comment = 'FRA="Spécifie le nom du fournisseur qui envoie les articles. Le champ est rempli automatiquement lorsque vous remplissez le champ N° fournisseur."';
                }
                field("Vendor Authorization No."; Rec."Vendor Authorization No.")
                {
                    ToolTip = 'Specifies the compensation agreement identification number, sometimes referred to as the RMA No. (Returns Materials Authorization).', Comment = 'FRA="Spécifie le numéro d''identification d''un accord de compensation. Ce numéro est parfois appelé numéro d''autorisation de retour de matériel (RMA)."';
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ToolTip = 'Specifies the postal code.', Comment = 'FRA="Spécifie le code postal."';
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address.', Comment = 'FRA="Spécifie le code pays/la région de l''adresse."';
                    Visible = false;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ToolTip = 'Specifies the name of the person to contact about shipment of the item from this vendor.', Comment = 'FRA="Spécifie le nom de la personne à contacter à propos de l''expédition de l''article chez le fournisseur."';
                    Visible = false;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ToolTip = 'Specifies the number of the vendor''s buy-from.', Comment = 'FRA="Spécifie le numéro du fournisseur auprès duquel vous effectuez vos achats."';
                    Visible = false;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ToolTip = 'Specifies the name of the vendor''s buy-from.', Comment = 'FRA="Spécifie le nom du fournisseur auprès duquel vous effectuez vos achats."';
                    Visible = false;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ToolTip = 'Specifies the post code of the vendor''s buy-from.', Comment = 'FRA="Spécifie le code postal du fournisseur auprès duquel vous effectuez vos achats."';
                    Visible = false;
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address.', Comment = 'FRA="Spécifie le code pays/la région de l''adresse."';
                    Visible = false;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ToolTip = 'Specifies the contact person of the vendor''s buy-from.', Comment = 'FRA="Spécifie le numéro de la personne à contacter chez le fournisseur auprès duquel vous effectuez vos achats."';
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies a ship-to code if you want a different shipment address from the one that has been automatically entered.', Comment = 'FRA="Spécifie un code destinataire si vous souhaitez utiliser une adresse destinataire différente de celle automatiquement renseignée."';
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name of the vendor''s buy-from.', Comment = 'FRA="Spécifie le nom du fournisseur auprès duquel vous effectuez vos achats."';
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the postal code.', Comment = 'FRA="Spécifie le code postal."';
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region of the address.', Comment = 'FRA="Spécifie le pays/la région de l''adresse."';
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the name of a contact person for the address where the items in the purchase order should be shipped.', Comment = 'FRA="Spécifie le nom d''un contact pour l''adresse à laquelle les articles de la commande achat devraient être expédiés."';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the date when the posting of the purchase document will be recorded.', Comment = 'FRA="Spécifie la date à laquelle la validation du document achat sera validée."';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the dimension value code associated with the purchase header.', Comment = 'FRA="Spécifie le code de la section analytique associée à l''en-tête achat."';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the dimension value code associated with the purchase header.', Comment = 'FRA="Spécifie le code de la section analytique associée à l''en-tête achat."';
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.', Comment = 'FRA="Spécifie un code pour le magasin dans lequel vous souhaitez que les articles soient stockés lorsqu''ils sont réceptionnés."';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.', Comment = 'FRA="Spécifie l''acheteur affecté au fournisseur."';
                    Visible = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.', Comment = 'FRA="Spécifie le code de l''utilisateur qui est responsable du document."';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency code for amounts on the purchase lines.', Comment = 'FRA="Spécifie le code devise des montants des lignes achat."';
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the date of the vendor''s invoice.', Comment = 'FRA="Spécifie la date de la facture du fournisseur."';
                    Visible = false;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ToolTip = 'Specifies the campaign number the document is linked to.', Comment = 'FRA="Spécifie le numéro de campagne auquel le document est lié."';
                    Visible = false;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    Visible = false;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ToolTip = 'Specifies the date you expect to receive the items on the purchase document.', Comment = 'FRA="Spécifie la date à laquelle vous pensez recevoir les articles indiqués sur le document achat."';
                    Visible = false;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    Visible = JobQueueActive;
                }
                field("Affair No."; Rec."BC6_Affair No.")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Return Order Type"; Rec."BC6_Return Order Type")
                {
                }
            }
        }
        area(factboxes)
        {
            part("Vendor Details FactBox"; "Vendor Details FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No."),
                              "Date Filter" = FIELD("Date Filter");
            }
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
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

                    trigger OnAction()
                    begin
                        Rec.OpenPurchaseOrderStatistics;
                    end;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions', Comment = 'FRA="Axes analytiques"';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', Comment = 'FRA="Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions."';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    Caption = 'Approvals', Comment = 'FRA="Approbations"';
                    Image = Approvals;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', Comment = 'FRA="Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due."';

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
                }
                action("Cred&it Memos")
                {
                    Caption = 'Cred&it Memos', Comment = 'FRA="A&voirs"';
                    Image = CreditMemo;
                    RunObject = Page "Posted Purchase Credit Memos";
                    RunPageLink = "Return Order No." = FIELD("No.");
                    RunPageView = SORTING("Return Order No.");
                }
                separator(sep)
                {
                }
            }
            group(Warehouses)
            {
                Caption = 'Warehouse', Comment = 'FRA="Entrepôt"';
                Image = Warehouse;
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines', Comment = 'FRA="Lignes prélè&v./rangement stock"';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Purchase Return Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }
                action("Whse. Shipment Lines")
                {
                    Caption = 'Whse. Shipment Lines', Comment = 'FRA="Lignes expédition entrepôt"';
                    Image = ShipmentLines;
                    RunObject = Page "Whse. Shipment Lines";
                    RunPageLink = "Source Type" = CONST(39),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                }
            }
        }
        area(processing)
        {
            action(Print)
            {
                Caption = '&Print', Comment = 'FRA="&Imprimer"';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

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
                        REPORT.RUNMODAL(50061, TRUE, FALSE, L_PurchaseHeader);
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
                    ShortCutKey = 'Ctrl+F9';

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
                    Image = ReOpen;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed', Comment = 'FRA="Rouvrez le document pour le modifier après son approbation. Les documents approuvés ont le statut Lancé et doivent être ouverts pour pouvoir être modifiés"';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(sep3)
                {
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions', Comment = 'FRA="Fonction&s"';
                Image = "Action";
                action("Get Posted Doc&ument Lines to Reverse")
                {
                    Caption = 'Get Posted Doc&ument Lines to Reverse', Comment = 'FRA="Extraire lignes doc&ument enreg. à contrepasser"';
                    Ellipsis = true;
                    Image = ReverseLines;

                    trigger OnAction()
                    begin
                        Rec.GetPstdDocLinesToReverse;
                    end;
                }
                separator(sep2)
                {
                }
                action("Send IC Return Order")
                {
                    AccessByPermission = TableData "IC G/L Account" = R;
                    Caption = 'Send IC Return Order', Comment = 'FRA="Envoyer retour IC"';
                    Image = IntercompanyOrder;

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
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request', Comment = 'FRA="Envoyer demande d''a&pprobation"';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Send an approval request.', Comment = 'FRA="Envoyez une demande d''approbation."';

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
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.', Comment = 'FRA="Annulez la demande d''approbation."';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse', Comment = 'FRA="Entrepôt"';
                Image = Warehouse;
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData "Posted Invt. Pick Header" = R;
                    Caption = 'Create Inventor&y Put-away/Pick', Comment = 'FRA="Créer prélèv./rangement stoc&k"';
                    Ellipsis = true;
                    Image = CreatePutawayPick;

                    trigger OnAction()
                    begin
                        Rec.CreateInvtPutAwayPick;
                    end;
                }
                action("Create &Whse. Shipment")
                {
                    AccessByPermission = TableData "Warehouse Shipment Header" = R;
                    Caption = 'Create &Whse. Shipment', Comment = 'FRA="Créer e&xpédition entrepôt"';
                    Image = NewShipment;

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        GetSourceDocOutbound.CreateFromPurchaseReturnOrder(Rec);
                    end;
                }
                separator(sep5)
                {
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting', Comment = 'FRA="&Validation"';
                Image = Post;
                action(TestReport)
                {
                    Caption = 'Test Report', Comment = 'FRA="Impression test"';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', Comment = 'FRA="Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document."';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(Post)
                {
                    Caption = 'P&ost', Comment = 'FRA="&Valider"';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        Rec.SendToPosting(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                }
                action("Preview")
                {
                    Caption = 'Preview Posting', Comment = 'FRA="Aperçu compta."';
                    Image = ViewPostedOrder;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.', Comment = 'FRA="Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille."';

                    trigger OnAction()
                    var
                        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                    begin
                        PurchPostYesNo.Preview(Rec);
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

                    trigger OnAction()
                    begin
                        Rec.SendToPosting(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action(PostBatch)
                {
                    Caption = 'Post &Batch', Comment = 'FRA="Valider par l&ot"';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;

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
                    Visible = JobQueueActive;

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
        SetControlAppearance;
    end;

    trigger OnOpenPage()
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        Rec.SetSecurityFilterOnRespCenter;

        JobQueueActive := PurchasesPayablesSetup.JobQueueActive;

        Rec.CopyBuyFromVendorFilter;
    end;

    var
        DocPrint: Codeunit "Document-Print";
        ReportPrint: Codeunit "Test Report-Print";
        [InDataSet]
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
    end;
}

