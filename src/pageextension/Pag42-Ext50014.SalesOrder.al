pageextension 50014 "BC6_SalesOrder" extends "Sales Order" //42
{

    layout
    {
        addafter(Status)
        {
            field(BC6_ID; BC6_ID)
            {
                Editable = false;
                ApplicationArea = All;
                Caption = 'User ID', Comment = 'FRA="Code utilisateur"';
            }
            field("BC6_Your Reference"; "Your Reference")
            {
                Importance = Promoted;
                ApplicationArea = All;
                Caption = 'Your Reference', Comment = 'FRA="Votre référence"';
            }
            field("BC6_Sell-to Fax No."; "BC6_Sell-to Fax No.")
            {
                ApplicationArea = All;
                Caption = 'Sell-to Fax No.', Comment = 'FRA="N° télécopie donneur d''ordre"';
            }
            field("BC6_Purchaser Comments"; "BC6_Purchaser Comments")
            {
                ApplicationArea = All;
                Caption = 'Purchaser Comments', Comment = 'FRA="Commentaires acheteur"';
            }
            field("BC6_Warehouse Comments"; "BC6_Warehouse Comments")
            {
                ApplicationArea = All;
                Caption = 'Warehouse Comments', Comment = 'FRA="Commentaires magasins"';
            }
            field("BC6_Affair No."; "BC6_Affair No.")
            {
                ApplicationArea = All;
                Caption = 'Affair No.', Comment = 'FRA="N° Affaire"';
            }
            field("BC6_Shipment Method Code"; "Shipment Method Code")
            {
                Importance = Promoted;
                ApplicationArea = All;
                Caption = 'Shipment Method Code';
            }
            field("BC6_Bin Code"; "BC6_Bin Code")
            {
                Importance = Promoted;
                ApplicationArea = All;
                Caption = 'Bin Code';
            }
            field("BC6_Purchase No. Order Lien"; "BC6_Purchase No. Order Lien")
            {
                ApplicationArea = All;
                Caption = 'Purchase No. Order Lien', Comment = 'FRA="N° Commande Achat Lien"';
            }
        }
        addafter("Direct Debit Mandate ID")
        {
            field("BC6_Reason Code"; "Reason Code")
            {
                ApplicationArea = All;
                Caption = 'Reason Code', Comment = 'FRA="Code motif"';

                trigger OnValidate()
                begin
                    CurrPage.UPDATE(TRUE);
                end;
            }
            field("BC6_Advance Payment"; "BC6_Advance Payment")
            {
                ApplicationArea = All;
                Caption = 'Advance Payment', Comment = 'FRA="Acompte payé"';
            }
        }
        addafter(BillToOptions)
        {
            field("BC6_Bill-to Customer No."; "Bill-to Customer No.")
            {
                Caption = 'Bill-to Customer No.', Comment = 'FRA="N° client facturé"';
            }
        }
        addafter(Control1903720907)
        {
            part(ControlSpec1; "BC6_Sales Hist. Sellto FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
            }
        }


    }
    actions
    {
        modify("Create Inventor&y Put-away/Pick")
        {
            Visible = false;

        }
        addfirst(Action3)
        {
            action("BC6_Create Inventor&y Put-away/Pick2")
            {
                AccessByPermission = TableData "Posted Invt. Pick Header" = R;
                ApplicationArea = Warehouse;
                Caption = 'Create Inventor&y Put-away/Pick', Comment = 'FRA="Créer prélèv./rangement stoc&k"';
                Ellipsis = true;
                Image = CreateInventoryPickup;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    FunctionMgt: Codeunit "BC6_Functions Mgt";

                begin
                    FunctionMgt.BC6_CreateInvtPutAwayPick_Sales(rec);

                    if not Find('=><') then
                        Init();
                end;
            }
        }

        addfirst(processing)
        {
            action("BC6_Create Inventory Put-away")
            {
                Caption = 'Create Inventor&y Put-away / Pick', comment = 'FRA="Créer prélèv./rangement stoc&k"';
                Image = Create;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CreateInvtPutAwayPick();
                end;
            }
            action("BC6_Creer demande de prix")
            {
                ApplicationArea = All;
                Caption = 'Créer demande de prix';
                trigger OnAction()
                var
                    RecLSalesHeader: Record "Sales Header";
                begin
                    RecLSalesHeader.CreatePurchaseQuote(Rec);
                end;
            }
            action("BC6_Create Technicals Directory")
            {
                Caption = 'Create Technicals Directory', comment = 'FRA="Créer dossier technique"';
                Image = Archive;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CODEUNIT.RUN(Codeunit::"BC6_Create SalesDoc Directory", Rec);
                    CurrPage.UPDATE();
                end;
            }
        }
        addafter(Post)
        {
            action(BC6_PostAndPrint)
            {
                Caption = 'Post and &Print', Comment = 'FRA="Valider et i&mprimer"';
                Ellipsis = true;
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PostSalesOrder(CODEUNIT::"Sales-Post + Print", "Navigate After Posting"::Nowhere);
                end;
            }
        }
        addafter(PreviewPosting)
        {
            action("BC6_Work Order")
            {
                Caption = 'Work Order', Comment = 'FRA="Edition Bon Prépa"';
                Image = Print;
                ApplicationArea = All;

                trigger OnAction()
                var
                    RecGSalesHeader: Record "Sales Header";
                begin
                    CheckIfReleased();
                    RecGSalesHeader.RESET();
                    RecGSalesHeader.SETRANGE(RecGSalesHeader."Document Type", "Document Type");
                    RecGSalesHeader.SETRANGE(RecGSalesHeader."No.", "No.");
                    RecGSalesHeader.FIND('-');
                    REPORT.RUNMODAL(REPORT::"BC6_Preparation NAVIDIIGEST", TRUE, FALSE, RecGSalesHeader);
                end;
            }
        }
        addafter(ProformaInvoice)
        {
            action(BC6_Imprimer)
            {
                Caption = 'Print', Comment = 'FRA="Imprimer"';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CheckIfReleased();
                    DocPrint.PrintSalesHeader(Rec);
                end;
            }
            action("BC6_Envoyer par Fax")
            {
                Caption = 'Envoyer par Fax';
                Image = SendTo;
                ApplicationArea = All;
            }
        }


    }


    var
        DocPrint: Codeunit "Document-Print";


    procedure CheckIfReleased()
    var
        SalesSetup: Record "Sales & Receivables Setup";
        CstL0001: Label 'Your order isn''t released, Do You want release it ?', Comment = 'FRA="Votre commande n''est pas lancée, souhaitez-vous la lancer ?"';
        CstL0002: Label 'Aborted Operation', Comment = 'FRA="Opération interrompue"';

    begin
        SalesSetup.GET();
        IF SalesSetup."BC6_Acti. Releas. Print. Order" THEN
            IF Status <> Status::Released THEN
                IF CONFIRM(CstL0001) THEN BEGIN
                    CODEUNIT.RUN(Codeunit::"Release Sales Document", Rec);
                    COMMIT();
                END ELSE
                    ERROR(CstL0002);
    end;

}
