page 50027 "BC6_Affected Orders"
{
    Caption = 'Affected Orders';
    PageType = List;
    SourceTable = "Sales Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Document No."; "Document No.")
                {
                    Caption = 'Order No.';
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field("Customer Name"; RecGCustomer.Name)
                {
                    Caption = 'Customer Name';
                }
                field("No."; "No.")
                {
                    Caption = 'Item Code';
                }
                field(Description; Description)
                {
                    Caption = 'Item Description';
                }
                field("Outstanding Quantity"; "Outstanding Quantity")
                {
                }
                field("Shipment Date"; "Shipment Date")
                {
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
                Caption = 'Open Document';
                Image = OpenWorksheet;
                Promoted = true;
                PromotedCategory = Process;
                RunPageOnRec = true;

                trigger OnAction()
                begin
                    DisplayOrder();
                end;
            }
            action("Imprimer bon préparation")
            {
                Caption = 'Imprimer bon préparation';
                Image = PrintDocument;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    RecGSalesHeader.RESET();
                    RecGSalesHeader.SETRANGE(RecGSalesHeader."Document Type", "Document Type");
                    RecGSalesHeader.SETRANGE(RecGSalesHeader."No.", "Document No.");
                    IF RecGSalesHeader.FIND('-') THEN;

                    // REPORT.RUNMODAL(REPORT::"Preparation NAVIDIIGEST", TRUE, FALSE, RecGSalesHeader); TODO:
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
        "-FEP-ACHAT-200706_18_A-": Integer;
        RecGCustomer: Record Customer;
        RecGSalesHeader: Record "Sales Header";


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

