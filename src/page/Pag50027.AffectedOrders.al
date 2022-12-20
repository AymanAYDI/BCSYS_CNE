page 50027 "BC6_Affected Orders"
{
    Caption = 'Affected Orders', Comment = 'FRA="Commandes affectées"';
    PageType = List;
    SourceTable = "Sales Line";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; RecGCustomer.Name)
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; "Outstanding Quantity")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Open Document")
            {
                Caption = 'Open Document', Comment = 'FRA="Ouvrir Document"';
                Image = OpenWorksheet;
                Promoted = true;
                PromotedCategory = Process;
                RunPageOnRec = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    DisplayOrder();
                end;
            }
            action("Imprimer bon préparation")
            {
                Caption = 'Imprimer bon préparation', Comment = 'FRA="Imprimer bon préparation"';
                Image = PrintDocument;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    RecGSalesHeader.RESET();
                    RecGSalesHeader.SETRANGE(RecGSalesHeader."Document Type", "Document Type");
                    RecGSalesHeader.SETRANGE(RecGSalesHeader."No.", "Document No.");
                    IF RecGSalesHeader.FIND('-') THEN;

                    REPORT.RUNMODAL(REPORT::"BC6_Preparation NAVIDIIGEST", TRUE, FALSE, RecGSalesHeader);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        RecGCustomer.RESET();
        RecGCustomer.SETCURRENTKEY("No.");
        IF RecGCustomer.GET("Sell-to Customer No.") THEN;
    end;

    trigger OnInit()
    begin
        CLEAR(RecGCustomer);
        CLEAR(RecGSalesHeader);
    end;

    var
        RecGCustomer: Record Customer;
        RecGSalesHeader: Record "Sales Header";
        "-FEP-ACHAT-200706_18_A-": Integer;


    procedure DisplayOrder()
    var
        RecLSalesHdr: Record "Sales Header";
    begin
        RecLSalesHdr.GET("Document Type", "Document No.");
        CASE "Document Type" OF
            "Document Type"::Quote:
                PAGE.RUNMODAL(Page::"Sales Quote", RecLSalesHdr);
            "Document Type"::Order:
                PAGE.RUNMODAL(Page::"Sales Order", RecLSalesHdr);
            "Document Type"::Invoice:
                PAGE.RUNMODAL(Page::"Sales Invoice", RecLSalesHdr);
            "Document Type"::"Credit Memo":
                PAGE.RUNMODAL(Page::"Sales Credit Memo", RecLSalesHdr);
        END;
    end;
}

