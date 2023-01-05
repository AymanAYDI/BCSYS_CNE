pageextension 50082 "BC6_SalesQuoteArchive" extends "Sales Quote Archive" //5162
{
    layout
    {
        modify("No.")
        {
            Visible = false;
        }
        modify("Sell-to Customer No.")
        {
            Visible = false;
        }
        modify("Sell-to Contact No.")
        {
            Visible = false;
        }
        modify("Sell-to Customer Templ. Code")
        {
            Visible = false;
        }
        modify("Sell-to Customer Name")
        {
            Visible = false;
        }
        modify("Sell-to Address")
        {
            Visible = false;
        }
        modify("Sell-to Address 2")
        {
            Visible = false;
        }
        modify("Sell-to Post Code")
        {
            Visible = false;
        }
        modify("Sell-to City")
        {
            Visible = false;
        }
        modify("Sell-to Contact")
        {
            Visible = false;
        }
        modify("Order Date")
        {
            Visible = false;
        }
        modify("Document Date")
        {
            Visible = false;
        }
        modify("Requested Delivery Date")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Status")
        {
            Visible = false;
        }
        modify("Bill-to Customer No.")
        {
            Visible = false;
        }
        modify("Bill-to Contact No.")
        {
            Visible = false;
        }
        modify("Bill-to Customer Template Code")
        {
            Visible = false;
        }
        modify("Bill-to Name")
        {
            Visible = false;
        }
        modify("Bill-to Address")
        {
            Visible = false;
        }
        modify("Bill-to Address 2")
        {
            Visible = false;
        }
        modify("Bill-to Post Code")
        {
            Visible = false;
        }
        modify("Bill-to City")
        {
            Visible = false;
        }
        modify("Bill-to Contact")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Payment Terms Code")
        {
            Visible = false;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        modify("Payment Discount %")
        {
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Payment Method Code")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }
        modify("Ship-to Code")
        {
            Visible = false;
        }
        modify("Ship-to Name")
        {
            Visible = false;
        }
        modify("Ship-to Address")
        {
            Visible = false;
        }
        modify("Ship-to Address 2")
        {
            Visible = false;
        }
        modify("Ship-to Post Code")
        {
            Visible = false;
        }
        modify("Ship-to City")
        {
            Visible = false;
        }
        modify("Ship-to Contact")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Transaction Type")
        {
            Visible = false;
        }
        modify("Transaction Specification")
        {
            Visible = false;
        }
        modify("Transport Method")
        {
            Visible = false;
        }
        modify("Exit Point")
        {
            Visible = false;
        }
        modify("Area")
        {
            Visible = false;
        }
        addfirst("General")
        {
            field("BC6_No."; Rec."No.")
            {
                Importance = Promoted;
            }
            field("BC6_Sell-to Customer No."; Rec."Sell-to Customer No.")
            {
                Enabled = true; //"Sell-to Customer No.Enable"
                Importance = Promoted;
            }
            field("BC6_Sell-to Contact No."; Rec."Sell-to Contact No.")
            {
                QuickEntry = false;
            }
            field("BC6_Sell-to Customer Template Code"; Rec."Sell-to Customer Templ. Code")
            {
                Enabled = true; //SelltoCustomerTemplateCodeEnab
                Importance = Additional;
            }
            field("BC6_Sell-to Customer Name"; Rec."Sell-to Customer Name")
            {
                Importance = Promoted;
                QuickEntry = false;
            }
            field("BC6_Sell-to Address"; Rec."Sell-to Address")
            {
                Importance = Additional;
            }
            field("BC6_Sell-to Address 2"; Rec."Sell-to Address 2")
            {
                Importance = Additional;
            }
            field("BC6_Sell-to Post Code"; Rec."Sell-to Post Code")
            {
                Importance = Additional;
            }
            field("BC6_Sell-to City"; Rec."Sell-to City")
            {
                QuickEntry = false;
            }
            field("BC6_Sell-to Contact"; Rec."Sell-to Contact")
            {
                Importance = Additional;
                Visible = false;
            }
            field("BC6_Bill-to Contact"; Rec."Bill-to Contact")
            {
                Importance = Additional;
            }
            field("BC6_Sell-to E-Mail Address"; Rec."BC6_Sell-to E-Mail Address")
            {
            }
            field("BC6_Sell-to Fax No."; Rec."BC6_Sell-to Fax No.")
            {
            }
            field("BC6_Your Reference"; Rec."Your Reference")
            {
                Importance = Promoted;
            }
            field("BC6_Responsibility Center"; Rec."Responsibility Center")
            {
                Importance = Additional;
                Visible = false;
            }
            field("BC6_No. of Archived Versions"; Rec."No. of Archived Versions")
            {
                Importance = Additional;
            }
            field("BC6_Order Date"; Rec."Order Date")
            {
                Importance = Promoted;
                QuickEntry = false;
            }
            field("BC6_Document Date"; Rec."Document Date")
            {
                QuickEntry = false;
            }
            field("BC6_Requested Delivery Date"; Rec."Requested Delivery Date")
            {
            }
            field("BC6_Posting Date"; Rec."Posting Date")
            {
            }
            field("BC6_Salesperson Code"; Rec."Salesperson Code")
            {
                QuickEntry = false;
            }
            field("BC6_Campaign No."; Rec."Campaign No.")
            {
                QuickEntry = false;
                Visible = false;
            }
            field("BC6_Opportunity No."; Rec."Opportunity No.")
            {
                QuickEntry = false;
            }
            field("BC6_Assigned User ID"; Rec."Assigned User ID")
            {
                Importance = Additional;
            }
            field(BC6_Status; Rec.Status)
            {
                Importance = Promoted;
                QuickEntry = false;
            }
            field(BC6_ID; Rec."BC6_ID")
            {
                Editable = false;
            }
            field("BC6_Prod. Version No."; Rec."BC6_Prod. Version No.")
            {
            }
            field("BC6_Quote statut"; Rec."BC6_Quote statut")
            {
                Editable = BooGQuoteStatut;
            }
            field("BC6_Affair No."; Rec."BC6_Affair No.")
            {
            }
        }
        addfirst("Invoicing")
        {
            field("BC6_Bill-to Customer No."; Rec."Bill-to Customer No.")
            {
                Enabled = true; //"Bill-to Customer No.Enable"
                Importance = Promoted;
            }
            field("BC6_Bill-to Contact No."; Rec."Bill-to Contact No.")
            {
            }
            field("BC6_Bill-to Customer Template Code"; Rec."Bill-to Customer Template Code")
            {
                Enabled = true; //BilltoCustomerTemplateCodeEnab
                Importance = Additional;
            }
            field("BC6_Bill-to Name"; Rec."Bill-to Name")
            {
            }
            field("BC6_Bill-to Address"; Rec."Bill-to Address")
            {
                Importance = Additional;
            }
            field("BC6_Bill-to Address 2"; Rec."Bill-to Address 2")
            {
                Importance = Additional;
            }
            field("BC6_Bill-to Post Code"; Rec."Bill-to Post Code")
            {
                Importance = Additional;
            }
            field("BC6_Bill-to City"; Rec."Bill-to City")
            {
            }
            field("BC6_Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
            {
                Visible = false;
            }
            field("BC6_Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
            {
                Visible = false;
            }
            field("BC6_Payment Terms Code"; Rec."Payment Terms Code")
            {
                Importance = Promoted;
            }
            field("BC6_Due Date"; Rec."Due Date")
            {
                Importance = Promoted;
            }
            field("BC6_Payment Discount %"; Rec."Payment Discount %")
            {
            }
            field("BC6_Pmt. Discount Date"; Rec."Pmt. Discount Date")
            {
                Importance = Additional;
            }
            field("BC6_Payment Method Code"; Rec."Payment Method Code")
            {
            }
            field("BC6_Prices Including VAT"; Rec."Prices Including VAT")
            {
                Visible = false;
            }
            field("BC6_VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
            }
            field("BC6_Combine Shipments"; Rec."Combine Shipments")
            {
            }
            field("BC6_Combine Shipments by Order"; Rec."BC6_Combine Shipments by Order")
            {
            }
        }
        addfirst("Shipping")
        {
            field("BC6_Ship-to Code"; Rec."Ship-to Code")
            {
                Importance = Promoted;
            }
            field("BC6_Ship-to Name"; Rec."Ship-to Name")
            {
            }
            field("BC6_Ship-to Address"; Rec."Ship-to Address")
            {
                Importance = Additional;
            }
            field("BC6_Ship-to Address 2"; Rec."Ship-to Address 2")
            {
                Importance = Additional;
            }
            field("BC6_Ship-to Post Code"; Rec."Ship-to Post Code")
            {
                Importance = Additional;
            }
            field("BC6_Ship-to City"; Rec."Ship-to City")
            {
            }
            field("BC6_Ship-to Contact"; Rec."Ship-to Contact")
            {
                Importance = Additional;
            }
            field("BC6_Location Code"; Rec."Location Code")
            {
                Importance = Promoted;
            }
            field("BC6_Bin Code"; Rec."BC6_Bin Code")
            {
                Importance = Promoted;
            }
            field("BC6_Shipment Method Code"; Rec."Shipment Method Code")
            {
                Importance = Promoted;
            }
            field("BC6_Shipment Date"; Rec."Shipment Date")
            {
                Importance = Promoted;
            }
        }
        addfirst("Foreign Trade")
        {
            field("BC6_Currency Code"; Rec."Currency Code")
            {
                Importance = Promoted;
            }
            field("BC6_EU 3-Party Trade"; Rec."EU 3-Party Trade")
            {
            }
            field("BC6_Transaction Type"; Rec."Transaction Type")
            {
            }
            field("BC6_Transaction Specification"; Rec."Transaction Specification")
            {
            }
            field("BC6_Transport Method"; Rec."Transport Method")
            {
            }
            field("BC6_Exit Point"; Rec."Exit Point")
            {
            }
            field(BC6_Area; Rec.Area)
            {
            }
        }
    }

    var
        [InDataSet]
        BooGQuoteStatut: Boolean;
}
