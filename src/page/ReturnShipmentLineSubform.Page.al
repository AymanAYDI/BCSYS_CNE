page 50030 "Return Shipment Line Subform"
{
    // //>>CNE3.00
    //    CorrectionSOBI 30/09/08 : - Change size

    Caption = 'Return Shipment Lines';
    PageType = List;
    SourceTable = Table6651;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Document No."; "Document No.")
                {
                    HideValue = "Document No.HideValue";
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(Type; Type)
                {
                }
                field("No."; "No.")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Direct Unit Cost"; "Direct Unit Cost")
                {
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                }
                field("VAT %"; "VAT %")
                {
                }
                field("Unit Price (LCY)"; "Unit Price (LCY)")
                {
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
                Caption = '&Show';
                Image = Document;

                trigger OnAction()
                begin
                    //>>MIGRATION NAV 2013
                    //CurrForm.PurchRcptline.FORM.GETRECORD(RecGPurchPostedRcpt);
                    IF NOT RecGReturnShipmentHeader.GET("Document No.") THEN
                        EXIT;
                    PAGE.RUN(PAGE::"Posted Return Shipment", RecGReturnShipmentHeader);
                    //<<MIGRATION NAV 2013
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        "Document No.HideValue" := FALSE;
        DocumentNoOnFormat;
    end;

    trigger OnOpenPage()
    begin
        SETCURRENTKEY("No.");
    end;

    var
        TempPurchShipement: Record "6651";
        [InDataSet]
        "Document No.HideValue": Boolean;
        [InDataSet]
        "Document No.Emphasize": Boolean;
        RecGReturnShipmentHeader: Record "6650";

    [Scope('Internal')]
    procedure isFirstDocLine(): Boolean
    var
        PurchShipement: Record "6651";
    begin
        TempPurchShipement.RESET;
        TempPurchShipement.COPYFILTERS(Rec);
        TempPurchShipement.SETRANGE("Document No.", "Document No.");
        IF NOT TempPurchShipement.FIND('-') THEN BEGIN
            PurchShipement.COPYFILTERS(Rec);
            PurchShipement.SETRANGE("Document No.", "Document No.");
            PurchShipement.FIND('-');
            TempPurchShipement := PurchShipement;
            TempPurchShipement.INSERT;
        END;
        IF "Line No." = TempPurchShipement."Line No." THEN
            EXIT(TRUE);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF "Document No." <> '' THEN
            IF isFirstDocLine THEN
                "Document No.Emphasize" := TRUE
            ELSE
                "Document No.HideValue" := TRUE;
    end;
}

