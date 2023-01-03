page 50016 "BC6_Purchase Lines Subform2"
{
    Caption = 'Purchase Lines', comment = 'FRA="Lignes Achat"';
    Editable = false;
    MultipleNewLines = true;
    PageType = List;
    SaveValues = true;
    SourceTable = "Purchase Line";
    SourceTableView = SORTING("BC6_Document Date", "Document Type", "No.");
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Document No."; "Document No.")
                {
                    HideValue = "Document No.HideValue";
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
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                }
                field(Amount; Amount)
                {
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                }
                field("Document Date flow"; "BC6_Document Date flow")
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
                Caption = '&Show', comment = 'FRA="Affic&her"';
                Image = Document;

                trigger OnAction()
                begin
                    IF NOT RecGPurchaseHeader.GET("Document Type", "Document No.") THEN
                        EXIT;
                    IF "Document Type" = "Document Type"::"Credit Memo" THEN
                        PAGE.RUN(PAGE::"Purchase Credit Memo", RecGPurchaseHeader);
                    IF "Document Type" = "Document Type"::Order THEN
                        PAGE.RUN(PAGE::"Purchase Order", RecGPurchaseHeader);
                    IF "Document Type" = "Document Type"::Quote THEN
                        PAGE.RUN(PAGE::"Purchase Quote", RecGPurchaseHeader);

                    IF "Document Type" = "Document Type"::Invoice THEN
                        PAGE.RUN(PAGE::"Purchase Invoice", RecGPurchaseHeader);

                    IF "Document Type" = "Document Type"::"Blanket Order" THEN
                        PAGE.RUN(PAGE::"Blanket Purchase Order", RecGPurchaseHeader);

                    IF "Document Type" = "Document Type"::"Return Order" THEN
                        PAGE.RUN(PAGE::"Purchase Return Order", RecGPurchaseHeader);

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
        SETCURRENTKEY("Document Type", "No.");
        CALCFIELDS("BC6_Document Date flow");
        REPEAT
            "BC6_Document Date" := "BC6_Document Date flow";
        UNTIL Rec.NEXT() = 0;
    end;

    var
        RecGPurchaseHeader: Record "Purchase Header";
        TempPurchLine: Record "Purchase Line" temporary; //TODO CHECK IF IS IT TEMPORARY
        [InDataSet]
        "Document No.Emphasize": Boolean;
        [InDataSet]
        "Document No.HideValue": Boolean;


    procedure IsFirstDocLine(): Boolean
    var
        PurchLine: Record "Purchase Line";
    begin
        TempPurchLine.RESET();
        TempPurchLine.COPYFILTERS(Rec);
        TempPurchLine.SETRANGE("Document Type", "Document Type");
        TempPurchLine.SETRANGE("Document No.", "Document No.");
        IF NOT TempPurchLine.FindFirst() THEN BEGIN
            PurchLine.COPYFILTERS(Rec);
            PurchLine.SETRANGE("Document Type", "Document Type");
            PurchLine.SETRANGE("Document No.", "Document No.");
            PurchLine.FindLast();
            TempPurchLine := PurchLine;
            TempPurchLine.INSERT();
        END;
        IF "Line No." = TempPurchLine."Line No." THEN
            EXIT(TRUE);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF "Document No." <> '' THEN
            IF IsFirstDocLine() THEN
                "Document No.Emphasize" := TRUE
            ELSE
                "Document No.HideValue" := TRUE;
    end;
}

