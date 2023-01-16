pageextension 50023 "BC6_PurchaseOrderSubform" extends "Purchase Order Subform" //54
{
    layout
    {
        modify("Bin Code")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Planned Receipt Date")
        {
            Visible = false;
        }
        modify("Requested Receipt Date")
        {
            Visible = true;
        }

        addafter("No.")
        {
            field("BC6_Eco partner DEEE"; Rec."BC6_Eco partner DEEE")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        addafter(Quantity)
        {
            field("BC6_Outstanding Quantity"; Rec."Outstanding Quantity")
            {
                ApplicationArea = All;
            }
            field("BC6_Reserved Quantity"; Rec."Reserved Quantity")
            {
                ApplicationArea = All;
                BlankZero = true;
                Visible = false;
            }
            field("BC6_Sales Order Qty (Base)"; Rec."BC6_Sales Order Qty (Base)")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("BC6_Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
            field("BC6_Bin Code"; Rec."Bin Code")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        addafter("Line Discount %")
        {
            field("BC6_Discount Direct Unit Cost"; Rec."BC6_Discount Direct Unit Cost")
            {
                ApplicationArea = All;
            }
        }
        addafter(ShortcutDimCode8)
        {
            field("BC6_Sales Document Type"; Rec."BC6_Sales Document Type")
            {
                ApplicationArea = All;
            }
            field("BC6_Sales No."; Rec."BC6_Sales No.")
            {
                ApplicationArea = All;
            }
            field("BC6_Sales Line No."; Rec."BC6_Sales Line No.")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE Category Code"; Rec."BC6_DEEE Category Code")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE Unit Price"; Rec."BC6_DEEE Unit Price")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE HT Amount"; Rec."BC6_DEEE HT Amount")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE Unit Price (LCY)"; Rec."BC6_DEEE Unit Price (LCY)")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE VAT Amount"; Rec."BC6_DEEE VAT Amount")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE TTC Amount"; Rec."BC6_DEEE TTC Amount")
            {
                ApplicationArea = All;
            }
            field("BC6_DEEE HT Amount (LCY)"; Rec."BC6_DEEE HT Amount (LCY)")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter(ItemChargeAssignment)
        {
            separator(sp)
            {
            }
            action("BC6_Affected Orders")
            {
                ApplicationArea = All;
                Caption = 'Affected Orders', Comment = 'FRA="Commandes affectées"';
                Image = Order;
                RunObject = Page "BC6_Affected Orders";
                RunPageLink = "BC6_Purch. Document Type" = CONST(Order),
                                  "BC6_Purch. Order No." = FIELD("Document No."),
                                  "BC6_Purch. Line No." = FIELD("Line No.");
                RunPageMode = View;
                RunPageView = SORTING("BC6_Purch. Document Type", "BC6_Purch. Order No.", "BC6_Purch. Line No.");
            }
            action("BC6_Affecter commande")
            {
                ApplicationArea = All;
                Caption = 'Affecter commande';
                image = ValidateEmailLoggingSetup;
                trigger OnAction()
                var
                    RecLPurchaseHeader: Record "Purchase Header";
                begin
                    RecLPurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
                    IF NOT RecLPurchaseHeader."BC6_From Sales Module" THEN
                        ChooseSalesLineOrderToAffect()
                    ELSE
                        MESSAGE(CstG001);
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF ApplicationAreaSetup.IsFoundationEnabled() THEN
            Rec.Type := Rec.Type::Item;
    end;

    var
        ApplicationAreaSetup: Record "Application Area Setup";
        CstG001: Label 'This Purchase Order is already linked with a sales document \ You can''t affect a new one', comment = 'FRA="Cette commande d''achat est déja lié a un document \ Vous ne pouvez pas l''affecter à un autre"';

    procedure ChooseSalesLineOrderToAffect()
    begin
        ChooseSalesLineOrderToAffect();
    end;
}
