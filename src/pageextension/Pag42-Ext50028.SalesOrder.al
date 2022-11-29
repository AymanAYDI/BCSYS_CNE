pageextension 50028 "BC6_SalesOrder" extends "Sales Order" //42
{

    layout
    {
        addafter("No.")
        {
            field("BC6_Sell-to Customer No."; "Sell-to Customer No.")
            {
                ApplicationArea = All;
                Caption = 'Sell-to Customer No.';
            }

        }
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
                Caption = 'Your Reference';
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
                Caption = 'Reason Code';

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
                Caption = 'Bill-to Customer No.';
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
                Caption = 'BC6_Creer demande de prix';
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
                    CODEUNIT.RUN(50013, Rec);
                    CurrPage.UPDATE();
                end;
            }
        }
        addafter(Post)
        {
            action(BC6_PostAndPrint)
            {
                Caption = 'Post and &Print';
                Ellipsis = true;
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PostSalesOrder(CODEUNIT::"Sales-Post + Print", NavigateAfterPost::Nowhere);
                end;
            }
        }
        addafter(PreviewPosting)
        {
            action("BC6_Work Order")
            {
                Caption = 'Work Order';
                Image = Print;
                ApplicationArea = All;

                trigger OnAction()
                var
                    RecGSalesHeader: Record "Sales Header";
                    "-MIGNAV2013-": Integer;
                begin
                    CheckIfReleased();
                    RecGSalesHeader.RESET();
                    RecGSalesHeader.SETRANGE(RecGSalesHeader."Document Type", "Document Type");
                    RecGSalesHeader.SETRANGE(RecGSalesHeader."No.", "No.");
                    RecGSalesHeader.FIND('-');
                    //TODO // REPORT.RUNMODAL(REPORT::"Preparation NAVIDIIGEST", TRUE, FALSE, RecGSalesHeader);
                end;
            }
        }
        addafter(ProformaInvoice)
        {
            action(BC6_Imprimer)
            {
                Caption = 'Print';
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
        CstL0001: Label 'Your order isn''t released, Do You want release it ?';
        CstL0002: Label 'Aborted Operation';

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
