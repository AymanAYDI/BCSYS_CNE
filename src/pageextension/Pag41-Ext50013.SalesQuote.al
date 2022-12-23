
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
                ApplicationArea = All;

                Importance = Additional;
                NotBlank = true;
                AboutTitle = 'Who is the quote for?';
                AboutText = 'You can choose existing customers, or add new customers when you create quotes. Quotes can automatically choose special prices and discounts that you have set for each customer.';
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
                Editable = BooGQuoteStatut;
                ApplicationArea = All;
                Caption = 'Quote status', Comment = 'FRA="Statut devis"';
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
            part(Control50028; "BC6_Sales Hist. Sellto FactBox") //TODO : Names Of Parts 
            {
                Provider = SalesLines;
                SubPageLink = "Document Type" = field("Document Type"),
                                  "Document No." = field("Document No."),
                                  "Line No." = field("Line No.");
                ApplicationArea = All;

            }

        }
    }
    actions
    {
        addafter(Dimensions)
        {
            action("BC6_Deleting Quote")
            {
                Caption = 'Deleting Quote', Comment = 'FRA="Supprimer Devis"';
                Image = Delete;
                ApplicationArea = All;

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
                Caption = 'Create Technicals Directory', Comment = 'FRA="Créer dossier technique"';
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
        addafter(Email)
        {
            action("BC6_Envoyer par Fax")
            {
                Caption = 'Envoyer par Fax';
                ApplicationArea = All;

                trigger OnAction()
                var
                    RecLSalesHeader: Record "Sales Header";
                    RptLSalesQuote: Report "BC6_Sales Quote";
                begin
                    RecLSalesHeader := Rec;
                    RecLSalesHeader.SETRECFILTER();
                    RptLSalesQuote.SETTABLEVIEW(RecLSalesHeader);
                    RptLSalesQuote.DefineTagFax("BC6_Sell-to Fax No.");
                    RptLSalesQuote.RUN;
                end;
            }
        }
        addafter(MakeOrder)
        {
            action("BC6_&Create Sales price request")
            {
                Caption = '&Create Sales price request', Comment = 'FRA="&Créer demande de prix"';
                Image = MakeAgreement;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

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
        BooGEditSalesperson: Boolean;

    begin
        RecLAccessControl.RESET();
        RecLAccessControl.SETRANGE("User Security ID", USERSECURITYID());
        RecLAccessControl.SETRANGE("Role ID", 'SUPER');
        if RecLAccessControl.FINDFIRST() then
            BooGQuoteStatut := true
        else
            BooGQuoteStatut := false;
        BooGEditSalesperson := true;
        if not RecGUserSeup.GET(USERID) then
            RecGUserSeup.INIT();
        if RecGUserSeup."BC6_Limited User" then
            BooGEditSalesperson := false;

    end;


    var
        // cust: Record Customer;
        // SalesHeader: Record "Sales Header";
        // recGCompanyInfo: Record "Company Information";
        // "Sales & Receivables Setup": Record "Sales & Receivables Setup";
        // RecGParmNavi: Record "BC6_Navi+ Setup";
        // HistMail: Record 99003;
        // ReportHelper: Codeunit 50010;
        // SalesQuotetoOrder: Codeunit "Sales-Quote to Order (Yes/No)";
        // cduMail: Codeunit Mail;
        // Mail: Codeunit Mail;
        // Form_DevisBloque: Page "BC6_Quote Blocked";
        BooGQuoteStatut: Boolean;
    // Excel: Boolean;
    // CodeUser: Code[10];
    // Format_Date: Code[10];
    // Nbr_Periode: Code[10];
    // Date_Debut: Date;
    // Date_Fin: Date;
    // Nbr_Devis: Integer;
    // Periode: Integer;
    // Unite: Integer;
    // E_Mail: Text[30];
    // FileName: Text[250];
    // nameF: Text[250];
    // Objet: Text[250];
    // ToFile: Text[250];
    // Body: Text[1024];


}


