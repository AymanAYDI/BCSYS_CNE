page 50011 "BC6_Sales Quote Arch. Cde"
{
    Caption = 'Sales Quote Arch. Cde', comment = 'FRA="Archives devis Cde"';
    Editable = false;
    PageType = Document;
    SourceTable = "Sales Header Archive";
    SourceTableView = WHERE("Document Type" = CONST(Quote));
    ApplicationArea = all;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General', comment = 'FRA="Général"';
                field("No."; Rec."No.")
                {
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                }
                field("Sell-to Customer Template Code"; Rec."Sell-to Customer Templ. Code")
                {
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                }
                field("Order Date"; Rec."Order Date")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Version No."; Rec."Version No.")
                {
                }
                field("Cause filing"; Rec."Bc6_Cause filing")
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
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                }
                field("Bill-to Customer Template Code"; Rec."Bill-to Customer Template Code")
                {
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                }
                field("Due Date"; Rec."Due Date")
                {
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping', comment = 'FRA="Livraison"';
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade', comment = 'FRA="International"';
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                }
                field("Transport Method"; Rec."Transport Method")
                {
                }
                field("Exit Point"; Rec."Exit Point")
                {
                }
                field("Area"; Rec.Area)
                {
                }
            }
            group(Version)
            {
                Caption = 'Version', comment = 'FRA="Version"';
                field("Archived By"; Rec."Archived By")
                {
                }
                field("Date Archived"; Rec."Date Archived")
                {
                }
                field("Time Archived"; Rec."Time Archived")
                {
                }
                field("Interaction Exist"; Rec."Interaction Exist")
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
                        Rec.ShowDimensions();
                        CurrPage.SAVERECORD();
                    end;
                }
            }
        }
    }
}
