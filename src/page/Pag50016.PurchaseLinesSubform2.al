page 50016 "BC6_Purchase Lines Subform2"
{
    Caption = 'Purchase Lines', comment = 'FRA="Lignes Achat"';
    Editable = false;
    MultipleNewLines = true;
    PageType = ListPart;
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
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    HideValue = "Document No.HideValue";
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
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Document Date flow"; Rec."BC6_Document Date flow")
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
                Caption = '&Show', comment = 'FRA="Affic&her"';
                Image = Document;

                trigger OnAction()
                begin
                    IF NOT RecGPurchaseHeader.GET(Rec."Document Type", Rec."Document No.") THEN
                        EXIT;
                    IF Rec."Document Type" = Rec."Document Type"::"Credit Memo" THEN
                        PAGE.RUN(PAGE::"Purchase Credit Memo", RecGPurchaseHeader);
                    IF Rec."Document Type" = Rec."Document Type"::Order THEN
                        PAGE.RUN(PAGE::"Purchase Order", RecGPurchaseHeader);
                    IF Rec."Document Type" = Rec."Document Type"::Quote THEN
                        PAGE.RUN(PAGE::"Purchase Quote", RecGPurchaseHeader);

                    IF Rec."Document Type" = Rec."Document Type"::Invoice THEN
                        PAGE.RUN(PAGE::"Purchase Invoice", RecGPurchaseHeader);

                    IF Rec."Document Type" = Rec."Document Type"::"Blanket Order" THEN
                        PAGE.RUN(PAGE::"Blanket Purchase Order", RecGPurchaseHeader);

                    IF Rec."Document Type" = Rec."Document Type"::"Return Order" THEN
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
        Rec.SETCURRENTKEY("Document Type", "No.");
        Rec.CALCFIELDS("BC6_Document Date flow");
        REPEAT
            Rec."BC6_Document Date" := Rec."BC6_Document Date flow";
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
        TempPurchLine.SETRANGE("Document Type", Rec."Document Type");
        TempPurchLine.SETRANGE("Document No.", Rec."Document No.");
        IF NOT TempPurchLine.FindFirst() THEN BEGIN
            PurchLine.COPYFILTERS(Rec);
            PurchLine.SETRANGE("Document Type", Rec."Document Type");
            PurchLine.SETRANGE("Document No.", Rec."Document No.");
            PurchLine.FindLast();
            TempPurchLine := PurchLine;
            TempPurchLine.INSERT();
        END;
        IF Rec."Line No." = TempPurchLine."Line No." THEN
            EXIT(TRUE);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF Rec."Document No." <> '' THEN
            IF IsFirstDocLine() THEN
                "Document No.Emphasize" := TRUE
            ELSE
                "Document No.HideValue" := TRUE;
    end;
}
