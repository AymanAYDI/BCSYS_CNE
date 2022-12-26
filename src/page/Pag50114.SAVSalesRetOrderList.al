page 50114 "BC6_SAV Sales Ret. Order List"
{
    Caption = 'Sales Return Orders', comment = 'FRA="Retours vente"';
    CardPageID = "BC6_SAV Sales Return Order";
    DataCaptionFields = "Sell-to Customer No.";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Request Approval';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = CONST("Return Order"),
                            "BC6_Return Order Type" = CONST(SAV));
  
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; "No.")
                {
                    ToolTip = 'Specifies the number of the sales document. The field can be filled automatically or manually and can be set up to be invisible.',
                     comment = 'FRA="Spécifie le numéro du document vente. Le champ peut étre rempli automatiquement ou manuellement et étre configurer pour étre invisible."';
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the customer number associated with the return order.',
                     comment = 'FRA="Spécifie le numéro client associé au retour vente."';
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                    ToolTip = 'Specifies the name of the customer who will receive the products and be billed by default.',
                     comment = 'FRA="Spécifie le nom du client qui recevra les produits et sera facturer par défaut."';
                }
                field("External Document No."; "External Document No.")
                {
                    ToolTip = 'Specifies the number that the customer uses in their own system to refer to this sales document.',
                     comment = 'FRA="Spécifie le numéro que le client doit utiliser dans son propre système pour faire référence … ce document vente."';
                }
                field("Sell-to Post Code"; "Sell-to Post Code")
                {
                    ToolTip = 'Specifies the postal code.', comment = 'FRA="Spécifie le code postal."';
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; "Sell-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region of the address.', comment = 'FRA="Spécifie le pays/la région de l''adresse."';
                    Visible = false;
                }
                field("Sell-to Contact"; "Sell-to Contact")
                {
                    ToolTip = 'Specifies the name of the person to contact at the customer that the items were sold to.',
                    comment = 'FRA="Spécifie le nom de la personne … contacter chez le client à qui les articles ont ‚t‚ vendus."';
                    Visible = false;
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer you sent the invoice for the shipment to.',
                     comment = 'FRA="Spécifie le numéro du client auquel la facture liée … l''expédition a été envoyé."';
                    Visible = false;
                }
                field("Bill-to Name"; "Bill-to Name")
                {
                    ToolTip = 'Specifies the name of the customer that you sent the invoice to.',
                    comment = 'FRA="Spécifie le nom du client auquel la facture a été envoyé."';
                    Visible = false;
                }
                field("Bill-to Post Code"; "Bill-to Post Code")
                {
                    ToolTip = 'Specifies the postal code.',
                     comment = 'FRA="Spécifie le code postal."';
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; "Bill-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region of the address.',
                     comment = 'FRA="Spécifie le pays/la région de l''adresse."';
                    Visible = false;
                }
                field("Bill-to Contact"; "Bill-to Contact")
                {
                    ToolTip = 'Specifies the name of the person you regularly contact when you communicate with the customer to whom you sent the invoice.',
                     comment = 'FRA="Spécifie le nom de la personne que vous contactez régulièrement lorsque vous communiquez avec le client auquel vous avez envoyé la facture."';
                    Visible = false;
                }
                field("Ship-to Code"; "Ship-to Code")
                {
                    ToolTip = 'Specifies the code for the customers additional shipment address.',
                    comment = 'FRA="Spécifie le code de l''adresse complémentaire d''expédition du client."';
                    Visible = false;
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                    ToolTip = 'Specifies the name of the customer that the items were shipped to.',
                     comment = 'FRA="Spécifie le nom du client auquel les articles ont été expédiis."';
                    Visible = false;
                }
                field("Ship-to Post Code"; "Ship-to Post Code")
                {
                    ToolTip = 'Specifies the postal code.',
                     comment = 'FRA="Spécifie le code postal."';
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; "Ship-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region of the address.',
                     comment = 'FRA="Spécifie le pays/la région de l''adresse."';
                    Visible = false;
                }
                field("Ship-to Contact"; "Ship-to Contact")
                {
                    ToolTip = 'Specifies the name of the person you regularly contact at the address that the items were shipped to.',
                     comment = 'FRA="Spécifie le nom de la personne que vous contactez régulièrement à l''adresse à laquelle  les articles ont été livrés."';
                    Visible = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    ToolTip = 'Specifies the date on which the shipment was posted.',
                     comment = 'FRA="Spécifie la date de validation de l''expédition."';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1.',
                    comment = 'FRA="Spécifie le code pour Raccourci axe 1."';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2.',
                    comment = 'FRA="Spécifie le code pour Raccourci axe 2"';
                    Visible = false;
                }
                field("Location Code"; "Location Code")
                {
                    ToolTip = 'Specifies the location from which the items were shipped.',
                     comment = 'FRA="Spécifie le lieu … partir duquel les articles ont été expédis."';
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    ToolTip = 'Specifies which salesperson is associated with the shipment.',
                     comment = 'FRA="Spécifie le nom du vendeur associé à l''expédition."';
                    Visible = false;
                }
                field("Assigned User ID"; "Assigned User ID")
                {
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.',
                    comment = 'FRA="Spécifie le code de l''utilisateur qui est responsable du document."';
                }
                field("Currency Code"; "Currency Code")
                {
                    ToolTip = 'Specifies the currency of amounts on the sales document.',
                    comment = 'FRA="Spécifie la devise des montants sur le document vente."';
                    Visible = false;
                }
                field("Document Date"; "Document Date")
                {
                    ToolTip = 'Specifies the date on which you created the sales document.',
                     comment = 'FRA="Spécifie la date à laquelle  vous avez crée le document vente."';
                    Visible = false;
                }
                field("Campaign No."; "Campaign No.")
                {
                    ToolTip = 'Specifies the number of the campaign that the document is linked to.',
                     comment = 'FRA="Spécifie le numéro de campagne auquel le document est liée."';
                    Visible = false;
                }
                field("Applies-to Doc. Type"; "Applies-to Doc. Type")
                {
                    ToolTip = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.',
                     comment = 'FRA="Spécifie le type du document validé avec lequel ce document ou cette ligne feuille sera lettré lorsque vous validez, par exemple pour enregistrer un paiement."';
                    Visible = false;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ToolTip = 'Specifies the date you expect to ship items on the sales document.',
                     comment = 'FRA="Spécifie la date à laquelle  vous pensez expédier les articles indiqués sur le document vente."';
                    Visible = false;
                }
                field("Job Queue Status"; "Job Queue Status")
                {
                    ToolTip = 'Specifies the status of a job queue entry or task that handles the posting of sales orders.',
                     comment = 'FRA="Spécifie le statut d''une écriture file d''attente des travaux ou d''une tâche qui gére la validation des commandes vente."';
                    Visible = JobQueueActive;
                }
                field(ID; ID)
                {
                }
                field("Your Reference"; "Your Reference")
                {
                }
                field("Affair No."; "BC6_Affair No.")
                {
                }
                field("Return Order Type"; "BC6_Return Order Type")
                {
                }
                field("Purchase No. Order Lien"; "BC6_Purchase No. Order Lien")
                {
                    Caption = 'Purchase No. Order Link', comment = 'FRA="No. Commande Achat Lien"';
                }
                field(Amount; Amount)
                {
                }
            }
        }
        area(factboxes)
        {
            part("Customer Statistics FactBox"; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
            }
            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
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
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.',
                    comment = 'FRA="Affichez les informations statistiques telles que la valeur des écritures validées pour l''enregistrement."';

                    trigger OnAction()
                    begin
                        OpenSalesOrderStatistics;
                    end;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions', comment = 'FRA="Axes analytiques"';
                    Image = Dimensions;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.',
                     comment = 'FRA="Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions."';

                    trigger OnAction()
                    begin
                        ShowDocDim;
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
                        ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");
                        ApprovalEntries.RUN;
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
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Return Order No." = FIELD("No.");
                    RunPageView = SORTING("Return Order No.");
                }
            }
            group(Warehouse1)
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
                    IF "BC6_Return Order Type" = "BC6_Return Order Type"::Location THEN
                        DocPrint.PrintSalesHeader(Rec)
                    ELSE BEGIN
                        L_SalesHeader.RESET;
                        L_SalesHeader.SETRANGE("Document Type", "Document Type");
                        L_SalesHeader.SETRANGE("No.", "No.");
                        REPORT.RUNMODAL(Report::"BC6_Return Order SAV Conf.", TRUE, FALSE, L_SalesHeader);
                    END;
                end;
            }
            group(Release)
            {
                Caption = 'Release', comment = 'FRA="Lancer"';
                Image = ReleaseDoc;
                action(ReleaseAction)
                {
                    Caption = 'Re&lease', comment = 'FRA=""';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Re&open', comment = 'FRA="&Reouvrir"';
                    Image = ReOpen;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed',
                     comment = 'FRA="Rouvrez le document pour le modifier aprés son approbation. Les documents approuvés ont le statut Lancé et doivent étre ouverts pour pouvoir étre modifiés"';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions', comment = 'FRA="Fonction&s"';
                Image = "Action";
                action("Get Posted Doc&ument Lines to Reverse")
                {
                    Caption = 'Get Posted Doc&ument Lines to Reverse', comment = 'FRA="Extraire lignes doc&ument enreg. à contrepasser"';
                    Ellipsis = true;
                    Image = ReverseLines;
                    ToolTip = 'Copy one or more posted sales document lines in order to reverse the original order.', comment = 'FRA="Copiez une ou plusieurs lignes de document vente validé afin de contrepasser la commande d''origine."';

                    trigger OnAction()
                    begin
                        GetPstdDocLinesToRevere;
                    end;
                }
                separator(Action1)
                {
                }
                action("Send IC Return Order Cnfmn.")
                {
                    AccessByPermission = TableData "IC G/L Account" = R;
                    Caption = 'Send IC Return Order Cnfmn.', comment = 'FRA="Confirmation envoi retour IC"';
                    Image = IntercompanyOrder;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        ICInboxOutboxMgt: Codeunit ICInboxOutboxMgt;
                    begin
                        IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
                            ICInboxOutboxMgt.SendSalesDoc(Rec, FALSE);
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
                    PromotedCategory = Category4;
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
                    PromotedCategory = Category4;
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
            group(Warehouse2)
            {
                Caption = 'Warehouse', comment = 'FRA="Entrepot"';
                Image = Warehouse;
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData "Posted Invt. Put-away Header" = R;
                    Caption = 'Create Inventor&y Put-away/Pick', comment = 'FRA="Créer prélévement/rangement stoc&k"';
                    Ellipsis = true;
                    Image = CreatePutawayPick;

                    trigger OnAction()
                    var
                        FunctionMgt: Codeunit "BC6_Functions Mgt";
                    begin
                        FunctionMgt.BC6_CreateInvtPutAwayPick;
                    end;
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
            }
            group("P&osting")
            {
                Caption = 'P&osting', comment = 'FRA="&Validation"';
                Image = Post;
                action("Test Report")
                {
                    Caption = 'Test Report', comment = 'FRA="Impression test"';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.',
                     comment = 'FRA="Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document."';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action(Post)
                {
                    Caption = 'P&ost', comment = 'FRA="&Valider"';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        SendToPosting(CODEUNIT::"Sales-Post (Yes/No)");
                    end;
                }
                action("Preview Posting")
                {
                    Caption = 'Preview Posting', comment = 'FRA="Aperçu compta."';
                    Image = ViewPostedOrder;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.',
                     comment = 'FRA="Examinez les différents types d''écritures qui seront crées lorsque vous validez le document ou la feuille."';

                    trigger OnAction()
                    var
                        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
                    begin
                        SalesPostYesNo.Preview(Rec);
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

                    trigger OnAction()
                    begin
                        SendToPosting(CODEUNIT::"Sales-Post + Print");
                    end;
                }
                action("Post and Email")
                {
                    Caption = 'Post and Email', comment = 'FRA="Valider et envoyer par e-mail"';
                    Ellipsis = true;
                    Image = PostMail;

                    trigger OnAction()
                    var
                        SalesPostPrint: Codeunit "Sales-Post + Print";
                    begin
                        SalesPostPrint.PostAndEmail(Rec);
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch', comment = 'FRA="Valider par l&ot"';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;

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
                    Visible = JobQueueActive;

                    trigger OnAction()
                    begin
                        CancelBackgroundPosting;
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
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        SetSecurityFilterOnRespCenter;

        IF NOT RecGUserSeup.GET(USERID) THEN
            RecGUserSeup.INIT;
        IF RecGUserSeup."BC6_Limited User" THEN BEGIN
            FILTERGROUP(2);
            SETFILTER("BC6_Salesperson Filter", '*' + RecGUserSeup."Salespers./Purch. Code" + '*');
            FILTERGROUP(0);
        END;

        JobQueueActive := SalesSetup.JobQueueActive;

        CopySellToCustomerFilter;
    end;

    var
        RecGUserSeup: Record "User Setup";
        DocPrint: Codeunit "Document-Print";
        ReportPrint: Codeunit "Test Report-Print";
        CanCancelApprovalForRecord: Boolean;
        [InDataSet]
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
    end;
}

