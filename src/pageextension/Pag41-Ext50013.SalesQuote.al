pageextension 50013 "BC6_SalesQuote" extends "Sales Quote" //41
{
    layout
    {
        modify("Sell-to Customer No.")
        {
            Visible = false;
        }
        addafter("Sell-to Customer No.")
        {
            field("BC6_Sell-to Customer No."; Rec."Sell-to Customer No.")
            {
                AboutText = 'You can choose existing customers, or add new customers when you create quotes. Quotes can automatically choose special prices and discounts that you have set for each customer.';
                AboutTitle = 'Who is the quote for?';
                ApplicationArea = All;
                Importance = Additional;
                NotBlank = true;
                trigger OnValidate()
                begin
                    Rec.SelltoCustomerNoOnAfterValidate(Rec, xRec);
                    Rec.verifyquotestatus();
                    CurrPage.Update();
                end;
            }
        }
        addafter("Sell-to Contact")
        {
            field("BC6_Sell-to E-Mail Address"; Rec."BC6_Sell-to E-Mail Address")
            {
                ApplicationArea = All;
                Caption = 'Sell-to E-Mail address', Comment = 'FRA="Adresse mail donneur d''ordre"';
            }
            field("BC6_Sell-to Fax No."; Rec."BC6_Sell-to Fax No.")
            {
                ApplicationArea = All;
                Caption = 'Sell-to Fax No.', Comment = 'FRA="N° télécopie donneur d''ordre"';
            }
        }

        addafter("Responsibility Center")
        {
            field(BC6_ID; Rec.BC6_ID)
            {
                ApplicationArea = All;
                Caption = 'User ID', Comment = 'FRA="Code utilisateur"';
            }
        }
        addafter(Status)
        {
            field("BC6_Prod. Version No."; Rec."BC6_Prod. Version No.")
            {
                ApplicationArea = All;
                Caption = 'Prod. Version No.', Comment = 'FRA="N° version"';
            }
            field("BC6_Quote statut"; Rec."BC6_Quote statut")
            {
                ApplicationArea = All;
                Caption = 'Quote status', Comment = 'FRA="Statut devis"';
                Editable = BooGQuoteStatut;
            }
            field("BC6_Affair No."; Rec."BC6_Affair No.")
            {
                ApplicationArea = All;
                Caption = 'Affair No.', Comment = 'FRA="N° Affaire"';
            }
        }
        addafter("Location Code")
        {
            field("BC6_Bin Code"; Rec."BC6_Bin Code")
            {
                ApplicationArea = All;
                Caption = 'Bin Code';
            }
        }
        addafter(Control1907234507)
        {
            part("Sales Hist. Sellto FactBox"; "BC6_Sales Hist. Sellto FactBox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "Document Type" = field("Document Type"),
                                  "Document No." = field("Document No."),
                                  "Line No." = field("Line No.");
            }
        }
    }
    actions
    {
        addafter(Dimensions)
        {
            action("BC6_Deleting Quote")
            {
                ApplicationArea = All;
                Caption = 'Deleting Quote', Comment = 'FRA="Supprimer Devis"';
                Image = Delete;

                trigger OnAction()
                var
                    RecGParmNavi: Record "BC6_Navi+ Setup";
                    ArchiveManagement: Codeunit ArchiveManagement;
                    TextArchDevis001: label 'Are you sure to delete this?', comment = 'FRA="Etes-vous sûr de vouloir supprimer ce Devis?"';
                begin
                    if CONFIRM(TextArchDevis001, false) then begin
                        if RecGParmNavi.GET() then
                            if RecGParmNavi."Filing Sales Quotes" then begin
                                Rec."BC6_Cause filing" := Rec."BC6_Cause filing"::Deleted;
                                Rec.MODIFY();
                                ArchiveManagement.StoreSalesDocument(Rec, false);
                            end;
                        Rec.DELETE(true);
                    end;
                end;
            }
        }
        addfirst(processing)
        {
            action("BC6_Create Technicals Directory")
            {
                ApplicationArea = All;
                Caption = 'Create Technicals Directory', Comment = 'FRA="Créer dossier technique"';
                Image = Archive;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    CODEUNIT.RUN(Codeunit::"BC6_Create SalesDoc Directory", Rec);
                    CurrPage.UPDATE();
                end;
            }
        }
        addafter(Email)
        {
            action("BC6_Envoyer par Fax")
            {
                ApplicationArea = All;
                Caption = 'Envoyer par Fax';
                image = SendTo;
                trigger OnAction()
                var
                    RecLSalesHeader: Record "Sales Header";
                    RptLSalesQuote: Report "BC6_Sales Quote";
                begin
                    RecLSalesHeader := Rec;
                    RecLSalesHeader.SETRECFILTER();
                    RptLSalesQuote.SETTABLEVIEW(RecLSalesHeader);
                    RptLSalesQuote.DefineTagFax(Rec."BC6_Sell-to Fax No.");
                    RptLSalesQuote.RUN();
                end;
            }
        }
        addafter(MakeOrder)
        {
            action("BC6_&Create Sales price request")
            {
                ApplicationArea = All;
                Caption = '&Create Sales price request', Comment = 'FRA="&Créer demande de prix"';
                Image = MakeAgreement;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    RecLSalesHeader: Record "Sales Header";
                begin
                    RecLSalesHeader.CreatePurchaseQuote(Rec);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        RecLAccessControl: Record "Access Control";
        RecGUserSeup: Record "User Setup";

    begin
        RecLAccessControl.RESET();
        RecLAccessControl.SETRANGE("User Security ID", USERSECURITYID());
        RecLAccessControl.SETRANGE("Role ID", 'SUPER');
        if RecLAccessControl.FINDFIRST() then
            BooGQuoteStatut := true
        else
            BooGQuoteStatut := false;
        if not RecGUserSeup.GET(USERID) then
            RecGUserSeup.INIT();
    end;

    var
        BooGQuoteStatut: Boolean;
}
