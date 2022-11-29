pageextension 50078 "BC6_SalesQuoteArchive" extends "Sales Quote Archive" //5162
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
        modify("Sell-to Customer Template Code")
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
            field("BC6_No."; "No.")
            {
                Importance = Promoted;
            }
            field("BC6_Sell-to Customer No."; "Sell-to Customer No.")
            {
                Enabled = true; //"Sell-to Customer No.Enable"
                Importance = Promoted;
            }
            field("BC6_Sell-to Contact No."; "Sell-to Contact No.")
            {
                QuickEntry = false;
            }
            field("BC6_Sell-to Customer Template Code"; "Sell-to Customer Template Code")
            {
                Enabled = true; //SelltoCustomerTemplateCodeEnab
                Importance = Additional;
            }
            field("BC6_Sell-to Customer Name"; "Sell-to Customer Name")
            {
                Importance = Promoted;
                QuickEntry = false;
            }
            field("BC6_Sell-to Address"; "Sell-to Address")
            {
                Importance = Additional;
            }
            field("BC6_Sell-to Address 2"; "Sell-to Address 2")
            {
                Importance = Additional;
            }
            field("BC6_Sell-to Post Code"; "Sell-to Post Code")
            {
                Importance = Additional;
            }
            field("BC6_Sell-to City"; "Sell-to City")
            {
                QuickEntry = false;
            }
            field("BC6_Sell-to Contact"; "Sell-to Contact")
            {
                Importance = Additional;
                Visible = false;
            }
            field("BC6_Bill-to Contact"; "Bill-to Contact")
            {
                Importance = Additional;
            }
            field("BC6_Sell-to E-Mail Address"; "BC6_Sell-to E-Mail Address")
            {
            }
            field("BC6_Sell-to Fax No."; "BC6_Sell-to Fax No.")
            {
            }
            field("BC6_Your Reference"; "Your Reference")
            {
                Importance = Promoted;
            }
            field("BC6_Responsibility Center"; "Responsibility Center")
            {
                Importance = Additional;
                Visible = false;
            }
            field("BC6_No. of Archived Versions"; "No. of Archived Versions")
            {
                Importance = Additional;
            }
            field("BC6_Order Date"; "Order Date")
            {
                Importance = Promoted;
                QuickEntry = false;
            }
            field("BC6_Document Date"; "Document Date")
            {
                QuickEntry = false;
            }
            field("BC6_Requested Delivery Date"; "Requested Delivery Date")
            {
            }
            field("BC6_Posting Date"; "Posting Date")
            {
            }
            field("BC6_Salesperson Code"; "Salesperson Code")
            {
                QuickEntry = false;
            }
            field("BC6_Campaign No."; "Campaign No.")
            {
                QuickEntry = false;
                Visible = false;
            }
            field("BC6_Opportunity No."; "Opportunity No.")
            {
                QuickEntry = false;
            }
            field("BC6_Assigned User ID"; "Assigned User ID")
            {
                Importance = Additional;
            }
            field(BC6_Status; Status)
            {
                Importance = Promoted;
                QuickEntry = false;
            }
            field(BC6_ID; "BC6_ID")
            {
                Editable = false;
            }
            field("BC6_Prod. Version No."; "BC6_Prod. Version No.")
            {
            }
            field("BC6_Quote statut"; "BC6_Quote statut")
            {
                Editable = BooGQuoteStatut;
            }
            field("BC6_Affair No."; "BC6_Affair No.")
            {
            }
        }
        addfirst("Invoicing")
        {
            field("BC6_Bill-to Customer No."; "Bill-to Customer No.")
            {
                Enabled = true; //"Bill-to Customer No.Enable"
                Importance = Promoted;
            }
            field("BC6_Bill-to Contact No."; "Bill-to Contact No.")
            {
            }
            field("BC6_Bill-to Customer Template Code"; "Bill-to Customer Template Code")
            {
                Enabled = true; //BilltoCustomerTemplateCodeEnab
                Importance = Additional;
            }
            field("BC6_Bill-to Name"; "Bill-to Name")
            {
            }
            field("BC6_Bill-to Address"; "Bill-to Address")
            {
                Importance = Additional;
            }
            field("BC6_Bill-to Address 2"; "Bill-to Address 2")
            {
                Importance = Additional;
            }
            field("BC6_Bill-to Post Code"; "Bill-to Post Code")
            {
                Importance = Additional;
            }
            field("BC6_Bill-to City"; "Bill-to City")
            {
            }
            field("BC6_Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
            {
                Visible = false;
            }
            field("BC6_Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
            {
                Visible = false;
            }
            field("BC6_Payment Terms Code"; "Payment Terms Code")
            {
                Importance = Promoted;
            }
            field("BC6_Due Date"; "Due Date")
            {
                Importance = Promoted;
            }
            field("BC6_Payment Discount %"; "Payment Discount %")
            {
            }
            field("BC6_Pmt. Discount Date"; "Pmt. Discount Date")
            {
                Importance = Additional;
            }
            field("BC6_Payment Method Code"; "Payment Method Code")
            {
            }
            field("BC6_Prices Including VAT"; "Prices Including VAT")
            {
                Visible = false;
            }
            field("BC6_VAT Bus. Posting Group"; "VAT Bus. Posting Group")
            {
            }
            field("BC6_Combine Shipments"; "Combine Shipments")
            {
            }
            field("BC6_Combine Shipments by Order"; "BC6_Combine Shipments by Order")
            {
            }
        }
        addfirst("Shipping")
        {
            field("BC6_Ship-to Code"; "Ship-to Code")
            {
                Importance = Promoted;
            }
            field("BC6_Ship-to Name"; "Ship-to Name")
            {
            }
            field("BC6_Ship-to Address"; "Ship-to Address")
            {
                Importance = Additional;
            }
            field("BC6_Ship-to Address 2"; "Ship-to Address 2")
            {
                Importance = Additional;
            }
            field("BC6_Ship-to Post Code"; "Ship-to Post Code")
            {
                Importance = Additional;
            }
            field("BC6_Ship-to City"; "Ship-to City")
            {
            }
            field("BC6_Ship-to Contact"; "Ship-to Contact")
            {
                Importance = Additional;
            }
            field("BC6_Location Code"; "Location Code")
            {
                Importance = Promoted;
            }
            field("BC6_Bin Code"; "BC6_Bin Code")
            {
                Importance = Promoted;
            }
            field("BC6_Shipment Method Code"; "Shipment Method Code")
            {
                Importance = Promoted;
            }
            field("BC6_Shipment Date"; "Shipment Date")
            {
                Importance = Promoted;
            }
        }
        addfirst("Foreign Trade")
        {
            field("BC6_Currency Code"; "Currency Code")
            {
                Importance = Promoted;
            }
            field("BC6_EU 3-Party Trade"; "EU 3-Party Trade")
            {
            }
            field("BC6_Transaction Type"; "Transaction Type")
            {
            }
            field("BC6_Transaction Specification"; "Transaction Specification")
            {
            }
            field("BC6_Transport Method"; "Transport Method")
            {
            }
            field("BC6_Exit Point"; "Exit Point")
            {
            }
            field(BC6_Area; Area)
            {
            }
        }
    }

    var
        //TODO: checkme [InDataSet]
        // BilltoCustomerTemplateCodeEnab: Boolean;
        // [InDataSet]
        // SelltoCustomerTemplateCodeEnab: Boolean;
        // [InDataSet]
        // "Sell-to Customer No.Enable": Boolean;
        // [InDataSet]
        // "Bill-to Customer No.Enable": Boolean;
        [InDataSet]
        BooGQuoteStatut: Boolean;
}
