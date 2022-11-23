pageextension 50078 pageextension50078 extends "Sales Quote Archive"
{
    layout
    {
        modify("Control 2")
        {
            Visible = false;
        }
        modify("Control 8")
        {
            Visible = false;
        }
        modify("Control 4")
        {
            Visible = false;
        }
        modify("Control 6")
        {
            Visible = false;
        }
        modify("Control 10")
        {
            Visible = false;
        }
        modify("Control 12")
        {
            Visible = false;
        }
        modify("Control 14")
        {
            Visible = false;
        }
        modify("Control 16")
        {
            Visible = false;
        }
        modify("Control 99")
        {
            Visible = false;
        }
        modify("Control 18")
        {
            Visible = false;
        }
        modify("Control 20")
        {
            Visible = false;
        }
        modify("Control 22")
        {
            Visible = false;
        }
        modify("Control 24")
        {
            Visible = false;
        }
        modify("Control 26")
        {
            Visible = false;
        }
        modify("Control 28")
        {
            Visible = false;
        }
        modify("Control 30")
        {
            Visible = false;
        }
        modify("Control 32")
        {
            Visible = false;
        }
        modify("Control 36")
        {
            Visible = false;
        }
        modify("Control 34")
        {
            Visible = false;
        }
        modify("Control 96")
        {
            Visible = false;
        }
        modify("Control 38")
        {
            Visible = false;
        }
        modify("Control 40")
        {
            Visible = false;
        }
        modify("Control 42")
        {
            Visible = false;
        }
        modify("Control 44")
        {
            Visible = false;
        }
        modify("Control 106")
        {
            Visible = false;
        }
        modify("Control 46")
        {
            Visible = false;
        }
        modify("Control 48")
        {
            Visible = false;
        }
        modify("Control 50")
        {
            Visible = false;
        }
        modify("Control 52")
        {
            Visible = false;
        }
        modify("Control 54")
        {
            Visible = false;
        }
        modify("Control 56")
        {
            Visible = false;
        }
        modify("Control 58")
        {
            Visible = false;
        }
        modify("Control 60")
        {
            Visible = false;
        }
        modify("Control 62")
        {
            Visible = false;
        }
        modify("Control 64")
        {
            Visible = false;
        }
        modify("Control 66")
        {
            Visible = false;
        }
        modify("Control 68")
        {
            Visible = false;
        }
        modify("Control 70")
        {
            Visible = false;
        }
        modify("Control 72")
        {
            Visible = false;
        }
        modify("Control 108")
        {
            Visible = false;
        }
        modify("Control 74")
        {
            Visible = false;
        }
        modify("Control 76")
        {
            Visible = false;
        }
        modify("Control 78")
        {
            Visible = false;
        }
        modify("Control 80")
        {
            Visible = false;
        }
        modify("Control 82")
        {
            Visible = false;
        }
        modify("Control 84")
        {
            Visible = false;
        }
        modify("Control 86")
        {
            Visible = false;
        }
        modify("Control 88")
        {
            Visible = false;
        }
        modify("Control 90")
        {
            Visible = false;
        }
        modify("Control 92")
        {
            Visible = false;
        }
        modify("Control 94")
        {
            Visible = false;
        }
        addfirst("Control 1")
        {
            field("No."; "No.")
            {
                Importance = Promoted;
            }
            field("Sell-to Customer No."; "Sell-to Customer No.")
            {
                Enabled = "Sell-to Customer No.Enable";
                Importance = Promoted;
            }
            field("Sell-to Contact No."; "Sell-to Contact No.")
            {
                QuickEntry = false;
            }
            field("Sell-to Customer Template Code"; "Sell-to Customer Template Code")
            {
                Enabled = SelltoCustomerTemplateCodeEnab;
                Importance = Additional;
            }
            field("Sell-to Customer Name"; "Sell-to Customer Name")
            {
                Importance = Promoted;
                QuickEntry = false;
            }
            field("Sell-to Address"; "Sell-to Address")
            {
                Importance = Additional;
            }
            field("Sell-to Address 2"; "Sell-to Address 2")
            {
                Importance = Additional;
            }
            field("Sell-to Post Code"; "Sell-to Post Code")
            {
                Importance = Additional;
            }
            field("Sell-to City"; "Sell-to City")
            {
                QuickEntry = false;
            }
            field("Sell-to Contact"; "Sell-to Contact")
            {
                Importance = Additional;
                Visible = false;
            }
            field("Bill-to Contact"; "Bill-to Contact")
            {
                Importance = Additional;
            }
            field("Sell-to E-Mail Address"; "Sell-to E-Mail Address")
            {
            }
            field("Sell-to Fax No."; "Sell-to Fax No.")
            {
            }
            field("Your Reference"; "Your Reference")
            {
                Importance = Promoted;
            }
            field("Responsibility Center"; "Responsibility Center")
            {
                Importance = Additional;
                Visible = false;
            }
            field("No. of Archived Versions"; "No. of Archived Versions")
            {
                Importance = Additional;
            }
            field("Order Date"; "Order Date")
            {
                Importance = Promoted;
                QuickEntry = false;
            }
            field("Document Date"; "Document Date")
            {
                QuickEntry = false;
            }
            field("Requested Delivery Date"; "Requested Delivery Date")
            {
            }
            field("Posting Date"; "Posting Date")
            {
            }
            field("Salesperson Code"; "Salesperson Code")
            {
                QuickEntry = false;
            }
            field("Campaign No."; "Campaign No.")
            {
                QuickEntry = false;
                Visible = false;
            }
            field("Opportunity No."; "Opportunity No.")
            {
                QuickEntry = false;
            }
            field("Assigned User ID"; "Assigned User ID")
            {
                Importance = Additional;
            }
            field(Status; Status)
            {
                Importance = Promoted;
                QuickEntry = false;
            }
            field(ID; ID)
            {
                Editable = false;
            }
            field("Prod. Version No."; "Prod. Version No.")
            {
            }
            field("Quote statut"; "Quote statut")
            {
                Editable = BooGQuoteStatut;
            }
            field("Affair No."; "Affair No.")
            {
            }
        }
        addfirst("Control 1905885101")
        {
            field("Bill-to Customer No."; "Bill-to Customer No.")
            {
                Enabled = "Bill-to Customer No.Enable";
                Importance = Promoted;
            }
            field("Bill-to Contact No."; "Bill-to Contact No.")
            {
            }
            field("Bill-to Customer Template Code"; "Bill-to Customer Template Code")
            {
                Enabled = BilltoCustomerTemplateCodeEnab;
                Importance = Additional;
            }
            field("Bill-to Name"; "Bill-to Name")
            {
            }
            field("Bill-to Address"; "Bill-to Address")
            {
                Importance = Additional;
            }
            field("Bill-to Address 2"; "Bill-to Address 2")
            {
                Importance = Additional;
            }
            field("Bill-to Post Code"; "Bill-to Post Code")
            {
                Importance = Additional;
            }
            field("Bill-to City"; "Bill-to City")
            {
            }
            field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
            {
                Visible = false;
            }
            field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
            {
                Visible = false;
            }
            field("Payment Terms Code"; "Payment Terms Code")
            {
                Importance = Promoted;
            }
            field("Due Date"; "Due Date")
            {
                Importance = Promoted;
            }
            field("Payment Discount %"; "Payment Discount %")
            {
            }
            field("Pmt. Discount Date"; "Pmt. Discount Date")
            {
                Importance = Additional;
            }
            field("Payment Method Code"; "Payment Method Code")
            {
            }
            field("Prices Including VAT"; "Prices Including VAT")
            {
                Visible = false;
            }
            field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
            {
            }
            field("Combine Shipments"; "Combine Shipments")
            {
            }
            field("Combine Shipments by Order"; "Combine Shipments by Order")
            {
            }
        }
        addfirst("Control 1906801201")
        {
            field("Ship-to Code"; "Ship-to Code")
            {
                Importance = Promoted;
            }
            field("Ship-to Name"; "Ship-to Name")
            {
            }
            field("Ship-to Address"; "Ship-to Address")
            {
                Importance = Additional;
            }
            field("Ship-to Address 2"; "Ship-to Address 2")
            {
                Importance = Additional;
            }
            field("Ship-to Post Code"; "Ship-to Post Code")
            {
                Importance = Additional;
            }
            field("Ship-to City"; "Ship-to City")
            {
            }
            field("Ship-to Contact"; "Ship-to Contact")
            {
                Importance = Additional;
            }
            field("Location Code"; "Location Code")
            {
                Importance = Promoted;
            }
            field("Bin Code"; "Bin Code")
            {
                Importance = Promoted;
            }
            field("Shipment Method Code"; "Shipment Method Code")
            {
                Importance = Promoted;
            }
            field("Shipment Date"; "Shipment Date")
            {
                Importance = Promoted;
            }
        }
        addfirst("Control 1907468901")
        {
            field("Currency Code"; "Currency Code")
            {
                Importance = Promoted;
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
            field(Area;Area)
            {
            }
        }
    }

    var
        "//DOC ARCHIVAGE": Integer;
        [InDataSet]
        BilltoCustomerTemplateCodeEnab: Boolean;
        [InDataSet]
        SelltoCustomerTemplateCodeEnab: Boolean;
        [InDataSet]
        "Sell-to Customer No.Enable": Boolean;
        [InDataSet]
        "Bill-to Customer No.Enable": Boolean;
        "- MIGNAV2013 -": Integer;
        [InDataSet]
        BooGQuoteStatut: Boolean;


    //Unsupported feature: Code Insertion on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //begin
        /*
        "Bill-to Customer No.Enable" := TRUE;
        "Sell-to Customer No.Enable" := TRUE;
        SelltoCustomerTemplateCodeEnab := TRUE;
        BilltoCustomerTemplateCodeEnab := TRUE;
        */
    //end;
}

