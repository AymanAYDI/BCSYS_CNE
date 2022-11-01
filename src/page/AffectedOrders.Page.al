page 50027 "Affected Orders"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // 
    // //>>CNE1.00
    // FEP-ACHAT-200706_18_A.001:MA 16/11/2007 : Achats groupés
    //                                           - Creation
    // 
    // //>>CNE2.05
    // FEP-ACHAT-200706_18_A.002:LY 23/01/2008 : add function Displayorder
    // ------------------------------------------------------------------------

    Caption = 'Affected Orders';
    PageType = List;
    SourceTable = Table37;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Document No."; "Document No.")
                {
                    Caption = 'Order No.';
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(RecGCustomer.Name;
                    RecGCustomer.Name)
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
                    DisplayOrder;
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
                    RecGSalesHeader.RESET;
                    RecGSalesHeader.SETRANGE(RecGSalesHeader."Document Type", "Document Type");
                    RecGSalesHeader.SETRANGE(RecGSalesHeader."No.", "Document No.");
                    IF RecGSalesHeader.FIND('-') THEN;

                    REPORT.RUNMODAL(REPORT::"Preparation NAVIDIIGEST", TRUE, FALSE, RecGSalesHeader);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        RecGCustomer.RESET;
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
        RecGCustomer: Record "18";
        RecGSalesHeader: Record "36";

    [Scope('Internal')]
    procedure DisplayOrder()
    var
        RecLSalesHdr: Record "36";
    begin
        RecLSalesHdr.GET("Document Type", "Document No.");
        CASE "Document Type" OF
            "Document Type"::Quote:
                PAGE.RUNMODAL(41, RecLSalesHdr);
            "Document Type"::Order:
                PAGE.RUNMODAL(42, RecLSalesHdr);
            "Document Type"::Invoice:
                PAGE.RUNMODAL(43, RecLSalesHdr);
            "Document Type"::"Credit Memo":
                PAGE.RUNMODAL(44, RecLSalesHdr);
        END;
    end;
}

