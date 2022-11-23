page 50011 "BC6_Sales Quote Arch. Cde"
{
    Caption = 'Sales Quote Arch. Cde', comment = 'FRA="Archives devis Cde"';
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
                Caption = 'General', comment = 'FRA="Général"';
                field("No."; "No.")
                {
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                }
                field("Sell-to Contact No."; "Sell-to Contact No.")
                {
                }
                field("Sell-to Customer Template Code"; "Sell-to Customer Template Code")
                {
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                }
                field("Sell-to Address"; "Sell-to Address")
                {
                }
                field("Sell-to Address 2"; "Sell-to Address 2")
                {
                }
                field("Sell-to Post Code"; "Sell-to Post Code")
                {
                }
                field("Sell-to City"; "Sell-to City")
                {
                }
                field("Sell-to Contact"; "Sell-to Contact")
                {
                }
                field("Order Date"; "Order Date")
                {
                }
                field("Document Date"; "Document Date")
                {
                }
                field("Requested Delivery Date"; "Requested Delivery Date")
                {
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                }
                field("Campaign No."; "Campaign No.")
                {
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                }
                field(Status; Status)
                {
                }
                field("Version No."; "Version No.")
                {
                }
                field("Cause filing"; "Bc6_Cause filing")
                {
                }
            }
            part(SalesLinesArchive; "BC6_Sales Quote Arch. Sub. Cde")
            {
                SubPageLink = "Document No." = FIELD("No."),
                              "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"),
                              "Version No." = FIELD("Version No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing', comment = 'FRA="Facturation"';
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                }
                field("Bill-to Contact No."; "Bill-to Contact No.")
                {
                }
                field("Bill-to Customer Template Code"; "Bill-to Customer Template Code")
                {
                }
                field("Bill-to Name"; "Bill-to Name")
                {
                }
                field("Bill-to Address"; "Bill-to Address")
                {
                }
                field("Bill-to Address 2"; "Bill-to Address 2")
                {
                }
                field("Bill-to Post Code"; "Bill-to Post Code")
                {
                }
                field("Bill-to City"; "Bill-to City")
                {
                }
                field("Bill-to Contact"; "Bill-to Contact")
                {
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                }
                field("Due Date"; "Due Date")
                {
                }
                field("Payment Discount %"; "Payment Discount %")
                {
                }
                field("Pmt. Discount Date"; "Pmt. Discount Date")
                {
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                }
                field("Prices Including VAT"; "Prices Including VAT")
                {
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping', comment = 'FRA="Livraison"';
                field("Ship-to Code"; "Ship-to Code")
                {
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                }
                field("Ship-to Address"; "Ship-to Address")
                {
                }
                field("Ship-to Address 2"; "Ship-to Address 2")
                {
                }
                field("Ship-to Post Code"; "Ship-to Post Code")
                {
                }
                field("Ship-to City"; "Ship-to City")
                {
                }
                field("Ship-to Contact"; "Ship-to Contact")
                {
                }
                field("Location Code"; "Location Code")
                {
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                }
                field("Shipment Date"; "Shipment Date")
                {
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade', comment = 'FRA="International"';
                field("Currency Code"; "Currency Code")
                {
                }
                field("EU 3-Party Trade"; "EU 3-Party Trade")
                {
                }
                field("Transaction Type"; "Transaction Type")
                {
                }
                field("Transaction Specification"; "Transaction Specification")
                {
                }
                field("Transport Method"; "Transport Method")
                {
                }
                field("Exit Point"; "Exit Point")
                {
                }
                field("Area"; Area)
                {
                }
            }
            group(Version)
            {
                Caption = 'Version', comment = 'FRA="Version"';
                field("Archived By"; "Archived By")
                {
                }
                field("Date Archived"; "Date Archived")
                {
                }
                field("Time Archived"; "Time Archived")
                {
                }
                field("Interaction Exist"; "Interaction Exist")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ver&sion")
            {
                Caption = 'Ver&sion', comment = 'FRA="Ver&sion"';
                action(Card)
                {
                    Caption = 'Card', comment = 'FRA="Fiche"';
                    Image = EditLines;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F5';
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions', comment = 'FRA="A&xes analytiques"';
                    Image = Dimensions;

                    trigger OnAction()
                    begin
                        ShowDimensions();
                        CurrPage.SAVERECORD();
                    end;
                }
            }
        }
    }
}
