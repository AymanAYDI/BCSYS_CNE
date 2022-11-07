page 6644 "Purchase Return Order Archive"
{
    // Début Modif JX-XAD du 05/08/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)

    Caption = 'Purchase Return Order Archive';
    Editable = false;
    PageType = Document;
    SourceTable = Table5109;
    SourceTableView = WHERE (Document Type=CONST(Return Order));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                }
                field("Buy-from Vendor No."; "Buy-from Vendor No.")
                {
                }
                field("Buy-from Contact No."; "Buy-from Contact No.")
                {
                }
                field("Buy-from Vendor Name"; "Buy-from Vendor Name")
                {
                }
                field("Buy-from Address"; "Buy-from Address")
                {
                }
                field("Buy-from Address 2"; "Buy-from Address 2")
                {
                }
                field("Buy-from Post Code"; "Buy-from Post Code")
                {
                    Caption = 'Buy-from Post Code/City';
                }
                field("Buy-from City"; "Buy-from City")
                {
                }
                field("Buy-from Contact"; "Buy-from Contact")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Order Date"; "Order Date")
                {
                }
                field("Document Date"; "Document Date")
                {
                }
                field("Vendor Authorization No."; "Vendor Authorization No.")
                {
                }
                field("Vendor Cr. Memo No."; "Vendor Cr. Memo No.")
                {
                }
                field("Order Address Code"; "Order Address Code")
                {
                }
                field("Purchaser Code"; "Purchaser Code")
                {
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                }
                field("Assigned User ID"; "Assigned User ID")
                {
                }
                field(Status; Status)
                {
                }
            }
            part(PurchLinesArchive; 6645)
            {
                SubPageLink = Document No.=FIELD(No.),Doc. No. Occurrence=FIELD(Doc. No. Occurrence),Version No.=FIELD(Version No.);
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Pay-to Vendor No.";"Pay-to Vendor No.")
                {
                }
                field("Pay-to Contact No.";"Pay-to Contact No.")
                {
                }
                field("Pay-to Name";"Pay-to Name")
                {
                }
                field("Pay-to Address";"Pay-to Address")
                {
                }
                field("Pay-to Address 2";"Pay-to Address 2")
                {
                }
                field("Pay-to Post Code";"Pay-to Post Code")
                {
                    Caption = 'Pay-to Post Code/City';
                }
                field("Pay-to City";"Pay-to City")
                {
                }
                field("Pay-to Contact";"Pay-to Contact")
                {
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {
                }
                field("Applies-to Doc. Type";"Applies-to Doc. Type")
                {
                }
                field("Applies-to Doc. No.";"Applies-to Doc. No.")
                {
                }
                field("Applies-to ID";"Applies-to ID")
                {
                }
                field("Prices Including VAT";"Prices Including VAT")
                {

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("VAT Bus. Posting Group";"VAT Bus. Posting Group")
                {
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name";"Ship-to Name")
                {
                }
                field("Ship-to Address";"Ship-to Address")
                {
                }
                field("Ship-to Address 2";"Ship-to Address 2")
                {
                }
                field("Ship-to Post Code";"Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code/City';
                }
                field("Ship-to City";"Ship-to City")
                {
                }
                field("Ship-to Contact";"Ship-to Contact")
                {
                }
                field("Location Code";"Location Code")
                {
                }
                field("Expected Receipt Date";"Expected Receipt Date")
                {
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code";"Currency Code")
                {
                }
                field("Transaction Type";"Transaction Type")
                {
                }
                field("Transaction Specification";"Transaction Specification")
                {
                }
                field("Transport Method";"Transport Method")
                {
                }
                field("Entry Point";"Entry Point")
                {
                }
                field(Area;Area)
                {
                }
            }
            group(Version)
            {
                Caption = 'Version';
                field("Version No.";"Version No.")
                {
                }
                field("Archived By";"Archived By")
                {
                }
                field("Date Archived";"Date Archived")
                {
                }
                field("Time Archived";"Time Archived")
                {
                }
                field("Interaction Exist";"Interaction Exist")
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
                Caption = 'Ver&sion';
                Image = Versions;
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page 27;
                                    RunPageLink = No.=FIELD(Buy-from Vendor No.);
                    ShortCutKey = 'Shift+F7';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData 348=R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 5179;
                                    RunPageLink = Document Type=FIELD(Document Type),No.=FIELD(No.),Document Line No.=CONST(0),Doc. No. Occurrence=FIELD(Doc. No. Occurrence),Version No.=FIELD(Version No.);
                }
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;

                    trigger OnAction()
                    begin
                        DocPrint.PrintPurchHeaderArch(Rec);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Début Modif JX-XAD du 05/08/2008
        //Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
        FILTERGROUP(2);
        SETFILTER("Assigned User ID",UserMgt.jx_GetPurchasesFilter);
        FILTERGROUP(0);
        //Fin Modif JX-XAD du 05/08/2008
    end;

    var
        DocPrint: Codeunit "229";
        UserMgt: Codeunit "5700";

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;
}

