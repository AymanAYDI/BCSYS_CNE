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
            field("BC6_Eco partner DEEE"; "BC6_Eco partner DEEE")
            {
                Visible = false;
            }
        }
        addafter(Quantity)
        {
            field("BC6_Outstanding Quantity"; "Outstanding Quantity")
            {
            }
            field("BC6_Reserved Quantity"; "Reserved Quantity")
            {
                BlankZero = true;
                Visible = false;
            }
            field("BC6_Sales Order Qty (Base)"; "BC6_Sales Order Qty (Base)")
            {
                Visible = false;
            }
            field("BC6_Location Code"; "Location Code")
            {
            }
            field("BC6_Bin Code"; "Bin Code")
            {
                Visible = false;
            }
        }
        addafter("Line Discount %")
        {
            field("BC6_Discount Direct Unit Cost"; "BC6_Discount Direct Unit Cost")
            {
            }
        }
        addafter(ShortcutDimCode8)
        {
            field("BC6_Sales Document Type"; "BC6_Sales Document Type")
            {
            }
            field("BC6_Sales No."; "BC6_Sales No.")
            {
            }
            field("BC6_Sales Line No."; "BC6_Sales Line No.")
            {
            }
            field("BC6_DEEE Category Code"; "BC6_DEEE Category Code")
            {
            }
            field("BC6_DEEE Unit Price"; "BC6_DEEE Unit Price")
            {
            }
            field("BC6_DEEE HT Amount"; "BC6_DEEE HT Amount")
            {
            }
            field("BC6_DEEE Unit Price (LCY)"; "BC6_DEEE Unit Price (LCY)")
            {
            }
            field("BC6_DEEE VAT Amount"; "BC6_DEEE VAT Amount")
            {
            }
            field("BC6_DEEE TTC Amount"; "BC6_DEEE TTC Amount")
            {
            }
            field("BC6_DEEE HT Amount (LCY)"; "BC6_DEEE HT Amount (LCY)")
            {
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
                Caption = 'Affected Orders';
                RunObject = Page "BC6_Affected Orders";
                RunPageLink = "BC6_Purch. Document Type" = CONST(Order),
                                  "BC6_Purch. Order No." = FIELD("Document No."),
                                  "BC6_Purch. Line No." = FIELD("Line No.");
                RunPageMode = View;
                RunPageView = SORTING("BC6_Purch. Document Type", "BC6_Purch. Order No.", "BC6_Purch. Line No.");
            }
            action("BC6_Affecter commande")
            {
                Caption = 'Affecter commande';

                trigger OnAction()
                var
                    RecLPurchaseHeader: Record "Purchase Header";
                begin
                    RecLPurchaseHeader.GET("Document Type", "Document No.");
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
            Type := Type::Item;
    end;

    var
        ApplicationAreaSetup: Record "Application Area Setup";
        CstG001: Label 'This Purchase Order is already linked with a sales document \ You can''t affect a new one', comment = 'FRA="Cette commande d''achat est déja lié a un document \ Vous ne pouvez pas l''affecter à un autre"';

    procedure ChooseSalesLineOrderToAffect()
    begin
        ChooseSalesLineOrderToAffect();
    end;

}

