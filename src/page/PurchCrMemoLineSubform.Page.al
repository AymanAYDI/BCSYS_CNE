page 50019 "Purch. Cr. Memo Line Subform"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>CNE1.00
    // FEP-ADVE-200706_18_B.001:MA 10/11/2007 : suivi historique
    //             - Form Created
    // ------------------------------------------------------------------------

    Caption = 'Purch. Credit Memo Lines';
    PageType = List;
    SourceTable = Table125;

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
                field("Amount Including VAT"; "Amount Including VAT")
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
                    IF NOT RecGPurchCrMemoHdr.GET("Document No.") THEN
                        EXIT;
                    PAGE.RUN(PAGE::"Posted Purchase Credit Memo", RecGPurchCrMemoHdr);
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
        TempPurchCrdMemo: Record "125";
        [InDataSet]
        "Document No.HideValue": Boolean;
        [InDataSet]
        "Document No.Emphasize": Boolean;
        RecGPurchCrMemoHdr: Record "124";

    [Scope('Internal')]
    procedure isFirstDocLine(): Boolean
    var
        PurchCrdMemo: Record "125";
    begin
        TempPurchCrdMemo.RESET;
        TempPurchCrdMemo.COPYFILTERS(Rec);
        TempPurchCrdMemo.SETRANGE("Document No.", "Document No.");
        IF NOT TempPurchCrdMemo.FIND('-') THEN BEGIN
            PurchCrdMemo.COPYFILTERS(Rec);
            PurchCrdMemo.SETRANGE("Document No.", "Document No.");
            PurchCrdMemo.FIND('-');
            TempPurchCrdMemo := PurchCrdMemo;
            TempPurchCrdMemo.INSERT;
        END;
        IF "Line No." = TempPurchCrdMemo."Line No." THEN
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

