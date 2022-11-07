page 5164 "Purchase Quote Archive"
{
    // Début Modif JX-XAD du 05/08/2008
    // Filtrer sur le (ou les) utilisateur(s) liés au droit de l'utilisateur courant (voir table des paramètres utilisateur)
    // 
    // ------------------------------ V1.2 ---------------------------
    // Modif JX-XAD du 26/02/2010
    // Accès au contrat depuis le bouton "Dem. Prix"
    // 
    // //Modif JX-AUD du 17/02/2012
    // //Ajout du Champs "Matricule" et traitement de celui-ci

    Caption = 'Purchase Quote Archive';
    Editable = false;
    PageType = Document;
    SourceTable = Table5109;
    SourceTableView = WHERE (Document Type=CONST(Quote));

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
                }
                field("Buy-from City"; "Buy-from City")
                {
                }
                field("Buy-from Contact"; "Buy-from Contact")
                {
                }
                field("Matricule No."; "Matricule No.")
                {
                    Editable = false;
                }
                field("Order Date"; "Order Date")
                {
                }
                field("Document Date"; "Document Date")
                {
                }
                field("Requested Receipt Date"; "Requested Receipt Date")
                {
                }
                field("Vendor Order No."; "Vendor Order No.")
                {
                }
                field("Vendor Shipment No."; "Vendor Shipment No.")
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
                field(Status; Status)
                {
                }
            }
            part(PurchLinesArchive; 5165)
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
                field("Payment Terms Code";"Payment Terms Code")
                {
                }
                field("Due Date";"Due Date")
                {
                }
                field("Payment Discount %";"Payment Discount %")
                {
                }
                field("Pmt. Discount Date";"Pmt. Discount Date")
                {
                }
                field("Payment Method Code";"Payment Method Code")
                {
                }
                field("On Hold";"On Hold")
                {
                }
                field("Prices Including VAT";"Prices Including VAT")
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
                field("Shipment Method Code";"Shipment Method Code")
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
        area(factboxes)
        {
            systempart(;Links)
            {
                Visible = false;
            }
            systempart(;Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Quote")
            {
                Caption = '&Quote';
                action(Contract)
                {
                    Caption = 'Contract';
                    RunObject = Page 50019;
                                    RunPageLink = Initial quote No=FIELD(No.);
                    RunPageView = SORTING(Initial quote No);
                }
            }
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
                        CurrPage.SAVERECORD;
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
                action(Approbations)
                {
                    Caption = 'Approbations';

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "658";
                    begin
                        ApprovalEntries.Setfilters(DATABASE::"Purchase Header","Document Type","No.");
                        ApprovalEntries.RUN;
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
}

