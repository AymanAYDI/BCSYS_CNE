page 50092 "BC6_Sales Quote Archive STD"
{
    Caption = 'Sales Quote Archive', Comment = 'FRA="Archives devis"';
    Editable = false;
    PageType = Document;
    SourceTable = "Sales Header Archive";
    SourceTableView = WHERE("Document Type" = CONST(Quote));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'FRA="Général"';
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Contact No."; "Sell-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Template Code"; Rec."Sell-to Customer Template Code")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address"; "Sell-to Address")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address 2"; "Sell-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; "Sell-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Sell-to City"; "Sell-to City")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; "Sell-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; "Order Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; "Requested Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Campaign No."; "Campaign No.")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
            }
            part(SalesLinesArchive; "Sales Quote Archive Subform")
            {
                SubPageLink = "Document No." = FIELD("No."),
                              "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"),
                              "Version No." = FIELD("Version No.");
                ApplicationArea = All;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing', Comment = 'FRA="Facturation"';
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Contact No."; "Bill-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer Template Code"; "Bill-to Customer Template Code")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Name"; "Bill-to Name")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address"; "Bill-to Address")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address 2"; "Bill-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; "Bill-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Bill-to City"; "Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; "Bill-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Discount %"; "Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; "Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Prices Including VAT"; "Prices Including VAT")
                {
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping', Comment = 'FRA="Livraison"';
                field("Ship-to Code"; "Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; "Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; "Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; "Ship-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to City"; "Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; "Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade', Comment = 'FRA="International"';
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field("EU 3-Party Trade"; "EU 3-Party Trade")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; "Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; "Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; "Exit Point")
                {
                    ApplicationArea = All;
                }
                field("Area"; Area)
                {
                    ApplicationArea = All;
                }
            }
            group(Version)
            {
                Caption = 'Version', Comment = 'FRA="Version"';
                field("Version No."; "Version No.")
                {
                    ApplicationArea = All;
                }
                field("Archived By"; "Archived By")
                {
                    ApplicationArea = All;
                }
                field("Date Archived"; "Date Archived")
                {
                    ApplicationArea = All;
                }
                field("Time Archived"; "Time Archived")
                {
                    ApplicationArea = All;
                }
                field("Interaction Exist"; "Interaction Exist")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Recordlinks; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ver&sion")
            {
                Caption = 'Ver&sion', Comment = 'FRA="Ver&sion"';
                Image = Versions;
                action(Card)
                {
                    Caption = 'Card', Comment = 'FRA="Fiche"';
                    Image = EditLines;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions', Comment = 'FRA="Axes analytiques"';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ShowDimensions;
                        CurrPage.SAVERECORD;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments', Comment = 'FRA="Co&mmentaires"';
                    Image = ViewComments;
                    RunObject = Page "Sales Archive Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0),
                                  "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"),
                                  "Version No." = FIELD("Version No.");
                    ApplicationArea = All;
                }
                action(Print)
                {
                    Caption = 'Print', Comment = 'FRA="Imprimer"';
                    Image = Print;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesHeaderArch(Rec);
                    end;
                }
            }
        }
        area(processing)
        {
            action(Restore)
            {
                Caption = '&Restore', Comment = 'FRA="&Restaurer"';
                Ellipsis = true;
                Image = Restore;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ArchiveManagement: Codeunit ArchiveManagement;
                begin
                    ArchiveManagement.RestoreSalesDocument(Rec);
                end;
            }
        }
    }

    var
        DocPrint: Codeunit "Document-Print";
}

