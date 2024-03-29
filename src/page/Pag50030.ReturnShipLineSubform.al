page 50030 "BC6_Return Ship. Line Subform"
{
    ApplicationArea = All;
    Caption = 'Return Shipment Lines', Comment = 'FRA="Lignes éxpidition retour"';
    PageType = ListPart;
    SourceTable = "Return Shipment Line";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    HideValue = "Document No.HideValue";
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = All;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Show)
            {
                ApplicationArea = All;
                Caption = '&Show', Comment = 'FRA="Affic&her"';
                Image = Document;

                trigger OnAction()
                begin
                    IF NOT RecGReturnShipmentHeader.GET(Rec."Document No.") THEN
                        EXIT;
                    PAGE.RUN(PAGE::"Posted Return Shipment", RecGReturnShipmentHeader);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        "Document No.HideValue" := FALSE;
        DocumentNoOnFormat();
    end;

    trigger OnOpenPage()
    begin
        Rec.SETCURRENTKEY("No.");
    end;

    var
        RecGReturnShipmentHeader: Record "Return Shipment Header";
        [InDataSet]
        "Document No.Emphasize": Boolean;
        [InDataSet]
        "Document No.HideValue": Boolean;

    procedure isFirstDocLine(): Boolean
    var
        LPurchShipement: Record "Return Shipment Line";
    begin
        LPurchShipement.RESET();
        LPurchShipement.COPYFILTERS(Rec);
        LPurchShipement.SETRANGE("Document No.", Rec."Document No.");
        IF NOT LPurchShipement.FIND('-') THEN BEGIN
            LPurchShipement.COPYFILTERS(Rec);
            LPurchShipement.SETRANGE("Document No.", Rec."Document No.");
            LPurchShipement.FindFirst();
            LPurchShipement := LPurchShipement;
            LPurchShipement.INSERT();
        END;
        IF Rec."Line No." = LPurchShipement."Line No." THEN
            EXIT(TRUE);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF Rec."Document No." <> '' THEN
            IF isFirstDocLine() THEN
                "Document No.Emphasize" := TRUE
            ELSE
                "Document No.HideValue" := TRUE;
    end;
}
