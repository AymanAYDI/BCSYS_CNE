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
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; RecGCustomer.Name)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
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
                    RecGSalesHeader.SETRANGE(RecGSalesHeader."Document Type", Rec."Document Type");
                    RecGSalesHeader.SETRANGE(RecGSalesHeader."No.", Rec."Document No.");
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
        IF RecGCustomer.GET(Rec."Sell-to Customer No.") THEN;
    end;

    trigger OnInit()
    begin
        CLEAR(RecGCustomer);
        CLEAR(RecGSalesHeader);
    end;

    var
        RecGCustomer: Record Customer;
        RecGSalesHeader: Record "Sales Header";


    procedure DisplayOrder()
    var
        RecLSalesHdr: Record "Sales Header";
    begin
        RecLSalesHdr.GET(Rec."Document Type", Rec."Document No.");
        CASE Rec."Document Type" OF
            Rec."Document Type"::Quote:
                PAGE.RUNMODAL(Page::"Sales Quote", RecLSalesHdr);
            Rec."Document Type"::Order:
                PAGE.RUNMODAL(Page::"Sales Order", RecLSalesHdr);
            Rec."Document Type"::Invoice:
                PAGE.RUNMODAL(Page::"Sales Invoice", RecLSalesHdr);
            Rec."Document Type"::"Credit Memo":
                PAGE.RUNMODAL(Page::"Sales Credit Memo", RecLSalesHdr);
        END;
    end;
}

