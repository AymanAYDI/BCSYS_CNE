report 50003 "BC6_Copy Sales Document" //292
{
    Caption = 'Copy Sales Document', Comment = 'FRA="Extraire document vente"';
    ProcessingOnly = true;
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options', Comment = 'FRA="Options"';
                    field(DocumentType; FromDocType)
                    {
                        ApplicationArea = All;
                        Caption = 'Document Type', Comment = 'FRA="Type document"';

                        trigger OnValidate()
                        begin
                            FromDocNo := '';
                            ValidateDocNo();
                        end;
                    }
                    field(DocumentNo; FromDocNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Document No.', Comment = 'FRA="N° document"';
                        ShowMandatory = true;
                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            LookupDocNo();
                        end;

                        trigger OnValidate()
                        begin
                            ValidateDocNo();
                        end;
                    }
                    field(FromDocNoOccurrence; FromDocNoOccurrenceG)
                    {
                        ApplicationArea = All;
                        BlankZero = true;
                        Caption = 'Doc. No. Occurrence', Comment = 'FRA="Doc. N° Occurrence"';
                        Editable = false;
                    }
                    field(FromDocVersionNo; FromDocVersionNoG)
                    {
                        ApplicationArea = All;
                        BlankZero = true;
                        Caption = 'Version No.', Comment = 'FRA="N° version"';
                        Editable = false;
                    }
                    field(SellToCustNo; FromSalesHeader."Sell-to Customer No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Sell-to Customer No.', Comment = 'FRA="N° donneur d''ordre"';
                        Editable = false;
                    }
                    field(SellToCustName; FromSalesHeader."Sell-to Customer Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Sell-to Customer Name', Comment = 'FRA="Nom du donneur d''ordre"';
                        Editable = false;
                    }
                    field(IncludeHeader_Options; IncludeHeader)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Header', Comment = 'FRA="Inclure en-tête"';

                        trigger OnValidate()
                        begin
                            ValidateIncludeHeader();
                        end;
                    }
                    field(RecalculateLines; RecalculateLinesG)
                    {
                        ApplicationArea = All;
                        Caption = 'Recalculate Lines', Comment = 'FRA="Recalculer lignes"';
                        trigger OnValidate()
                        begin
                            if (FromDocType = FromDocType::"Posted Shipment") or (FromDocType = FromDocType::"Posted Return Receipt") then
                                RecalculateLinesG := true;
                        end;
                    }
                    field(BoolGCopyLinesExactly; BoolGCopyLinesExactlyG)
                    {
                        ApplicationArea = all;
                        Caption = 'Copy lines exactly', Comment = 'FRA="Copier exactement les lignes"';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            if FromDocNo <> '' then begin
                case FromDocType of
                    FromDocType::Quote:
                        if FromSalesHeader.Get(FromSalesHeader."Document Type"::Quote, FromDocNo) then
                            ;
                    FromDocType::"Blanket Order":
                        if FromSalesHeader.Get(FromSalesHeader."Document Type"::"Blanket Order", FromDocNo) then
                            ;
                    FromDocType::Order:
                        if FromSalesHeader.Get(FromSalesHeader."Document Type"::Order, FromDocNo) then
                            ;
                    FromDocType::Invoice:
                        if FromSalesHeader.Get(FromSalesHeader."Document Type"::Invoice, FromDocNo) then
                            ;
                    FromDocType::"Return Order":
                        if FromSalesHeader.Get(FromSalesHeader."Document Type"::"Return Order", FromDocNo) then
                            ;
                    FromDocType::"Credit Memo":
                        if FromSalesHeader.Get(FromSalesHeader."Document Type"::"Credit Memo", FromDocNo) then
                            ;
                    FromDocType::"Posted Shipment":
                        if FromSalesShptHeader.Get(FromDocNo) then
                            FromSalesHeader.TransferFields(FromSalesShptHeader);
                    FromDocType::"Posted Invoice":
                        if FromSalesInvHeader.Get(FromDocNo) then
                            FromSalesHeader.TransferFields(FromSalesInvHeader);
                    FromDocType::"Posted Return Receipt":
                        if FromReturnRcptHeader.Get(FromDocNo) then
                            FromSalesHeader.TransferFields(FromReturnRcptHeader);
                    FromDocType::"Posted Credit Memo":
                        if FromSalesCrMemoHeader.Get(FromDocNo) then
                            FromSalesHeader.TransferFields(FromSalesCrMemoHeader);
                    FromDocType::"Arch. Order":
                        if FromSalesHeaderArchive.Get(FromSalesHeaderArchive."Document Type"::Order, FromDocNo, FromDocNoOccurrenceG, FromDocVersionNoG) then
                            FromSalesHeader.TransferFields(FromSalesHeaderArchive);
                    FromDocType::"Arch. Quote":
                        if FromSalesHeaderArchive.Get(FromSalesHeaderArchive."Document Type"::Quote, FromDocNo, FromDocNoOccurrenceG, FromDocVersionNoG) then
                            FromSalesHeader.TransferFields(FromSalesHeaderArchive);
                    FromDocType::"Arch. Blanket Order":
                        if FromSalesHeaderArchive.Get(FromSalesHeaderArchive."Document Type"::"Blanket Order", FromDocNo, FromDocNoOccurrenceG, FromDocVersionNoG) then
                            FromSalesHeader.TransferFields(FromSalesHeaderArchive);
                    FromDocType::"Arch. Return Order":
                        if FromSalesHeaderArchive.Get(FromSalesHeaderArchive."Document Type"::"Return Order", FromDocNo, FromDocNoOccurrenceG, FromDocVersionNoG) then
                            FromSalesHeader.TransferFields(FromSalesHeaderArchive);
                end;
                if FromSalesHeader."No." = '' then
                    FromDocNo := '';
            end;
            ValidateDocNo();
        end;

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            if CloseAction = ACTION::OK then
                if FromDocNo = '' then
                    Error(DocNoNotSerErr)
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        FunctionsMgt: Codeunit "BC6_Functions Mgt";
        ExactCostReversingMandatory: Boolean;
    begin
        SalesSetup.Get();
        ExactCostReversingMandatory := SalesSetup."Exact Cost Reversing Mandatory";

        CopyDocMgt.SetProperties(
          IncludeHeader, RecalculateLinesG, false, false, false, ExactCostReversingMandatory, false);
        CopyDocMgt.SetArchDocVal(FromDocNoOccurrenceG, FromDocVersionNoG);
        FunctionsMgt.Fct_SetProperties(BoolGCopyLinesExactlyG);
        CopyDocMgt.CopySalesDoc(FromDocType, FromDocNo, SalesHeader);
    end;

    var
        DocNoNotSerErr: Label 'Select a document number to continue, or choose Cancel to close the page.', Comment = 'FRA="Sélectionnez un numéro de document pour continuer ou choisissez Annuler pour fermer la page."';
        Text000: Label 'The price information may not be reversed correctly, if you copy a %1. If possible copy a %2 instead or use %3 functionality.', Comment = 'FRA="Les informations de prix risquent de ne pas être annulées correctement si vous copiez un(e) %1. Si possible, copiez plutôt un(e) %2 ou utilisez la fonctionnalité %3."';
        Text001: Label 'Undo Shipment', Comment = 'FRA="Annuler expédition"';
        Text002: Label 'Undo Return Receipt', Comment = 'FRA="Annuler réception retour"';

    protected var
        FromReturnRcptHeader: Record "Return Receipt Header";
        SalesSetup: Record "Sales & Receivables Setup";
        FromSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        FromSalesHeader: Record "Sales Header";
        SalesHeader: Record "Sales Header";
        FromSalesHeaderArchive: Record "Sales Header Archive";
        FromSalesInvHeader: Record "Sales Invoice Header";
        FromSalesShptHeader: Record "Sales Shipment Header";
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        BoolGCopyLinesExactlyG: Boolean;
        IncludeHeader: Boolean;
        RecalculateLinesG: Boolean;
        FromDocNo: Code[20];
        FromDocType: Enum "Sales Document Type From";
        FromDocNoOccurrenceG: Integer;
        FromDocVersionNoG: Integer;

    procedure SetSalesHeader(var NewSalesHeader: Record "Sales Header")
    begin
        NewSalesHeader.TestField("No.");
        SalesHeader := NewSalesHeader;
    end;

    local procedure ValidateDocNo()
    var
        FromDocType2: Enum "Sales Document Type From";
    begin
        if FromDocNo = '' then begin
            FromSalesHeader.Init();
            FromDocNoOccurrenceG := 0;
            FromDocVersionNoG := 0;
        end else
            if FromSalesHeader."No." = '' then begin
                FromSalesHeader.Init();
                case FromDocType of
                    FromDocType::Quote,
                    FromDocType::Order,
                    FromDocType::Invoice,
                    FromDocType::"Credit Memo",
                    FromDocType::"Blanket Order",
                    FromDocType::"Return Order":
                        FromSalesHeader.Get(CopyDocMgt.GetSalesDocumentType(FromDocType), FromDocNo);
                    FromDocType::"Posted Shipment":
                        begin
                            FromSalesShptHeader.Get(FromDocNo);
                            FromSalesHeader.TransferFields(FromSalesShptHeader);
                            if SalesHeader."Document Type" in
                               [SalesHeader."Document Type"::"Return Order", SalesHeader."Document Type"::"Credit Memo"]
                            then begin
                                FromDocType2 := FromDocType2::"Posted Invoice";
                                Message(Text000, FromDocType, FromDocType2, Text001);
                            end;
                        end;
                    FromDocType::"Posted Invoice":
                        begin
                            FromSalesInvHeader.Get(FromDocNo);
                            FromSalesHeader.TransferFields(FromSalesInvHeader);
                        end;
                    FromDocType::"Posted Return Receipt":
                        begin
                            FromReturnRcptHeader.Get(FromDocNo);
                            FromSalesHeader.TransferFields(FromReturnRcptHeader);
                            if SalesHeader."Document Type" in
                               [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice]
                            then begin
                                FromDocType2 := FromDocType2::"Posted Credit Memo";
                                Message(Text000, FromDocType, FromDocType2, Text002);
                            end;
                        end;
                    FromDocType::"Posted Credit Memo":
                        begin
                            FromSalesCrMemoHeader.Get(FromDocNo);
                            FromSalesHeader.TransferFields(FromSalesCrMemoHeader);
                        end;
                    FromDocType::"Arch. Quote",
                    FromDocType::"Arch. Order",
                    FromDocType::"Arch. Blanket Order",
                    FromDocType::"Arch. Return Order":
                        begin
                            FindFromSalesHeaderArchive();
                            FromSalesHeader.TransferFields(FromSalesHeaderArchive);
                        end;
                end;
            end;
        FromSalesHeader."No." := '';

        IncludeHeader :=
          (FromDocType in [FromDocType::"Posted Invoice", FromDocType::"Posted Credit Memo"]) and
          ((FromDocType = FromDocType::"Posted Credit Memo") <>
           (SalesHeader."Document Type" in
            [SalesHeader."Document Type"::"Return Order", SalesHeader."Document Type"::"Credit Memo"])) and
          (SalesHeader."Bill-to Customer No." in [FromSalesHeader."Bill-to Customer No.", '']);
        ValidateIncludeHeader();
    end;

    local procedure FindFromSalesHeaderArchive()
    begin

        if not FromSalesHeaderArchive.Get(
             CopyDocMgt.GetSalesDocumentType(FromDocType), FromDocNo, FromDocNoOccurrenceG, FromDocVersionNoG)
        then begin
            FromSalesHeaderArchive.SetRange("No.", FromDocNo);
            if FromSalesHeaderArchive.FindLast() then begin
                FromDocNoOccurrenceG := FromSalesHeaderArchive."Doc. No. Occurrence";
                FromDocVersionNoG := FromSalesHeaderArchive."Version No.";
            end;
        end;
    end;

    local procedure LookupDocNo()
    begin
        case FromDocType of
            FromDocType::Quote,
            FromDocType::Order,
            FromDocType::Invoice,
            FromDocType::"Credit Memo",
            FromDocType::"Blanket Order",
            FromDocType::"Return Order":
                LookupSalesDoc();
            FromDocType::"Posted Shipment":
                LookupPostedShipment();
            FromDocType::"Posted Invoice":
                LookupPostedInvoice();
            FromDocType::"Posted Return Receipt":
                LookupPostedReturn();
            FromDocType::"Posted Credit Memo":
                LookupPostedCrMemo();
            FromDocType::"Arch. Quote",
            FromDocType::"Arch. Order",
            FromDocType::"Arch. Blanket Order",
            FromDocType::"Arch. Return Order":
                LookupSalesArchive();
        end;

        ValidateDocNo();
    end;

    local procedure LookupSalesDoc()
    begin
        FromSalesHeader.FilterGroup := 0;
        FromSalesHeader.SetRange("Document Type", CopyDocMgt.GetSalesDocumentType(FromDocType));
        if SalesHeader."Document Type" = CopyDocMgt.GetSalesDocumentType(FromDocType) then
            FromSalesHeader.SetFilter("No.", '<>%1', SalesHeader."No.");
        FromSalesHeader.FilterGroup := 2;
        FromSalesHeader."Document Type" := CopyDocMgt.GetSalesDocumentType(FromDocType);
        FromSalesHeader."No." := FromDocNo;
        if (FromDocNo = '') and (SalesHeader."Sell-to Customer No." <> '') then
            if FromSalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.") then begin
                FromSalesHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                if FromSalesHeader.Find('=><') then;
            end;
        if PAGE.RunModal(0, FromSalesHeader) = ACTION::LookupOK then
            FromDocNo := FromSalesHeader."No.";
    end;

    local procedure LookupSalesArchive()
    begin
        FromSalesHeaderArchive.Reset();
        FromSalesHeaderArchive.FilterGroup := 0;
        FromSalesHeaderArchive.SetRange("Document Type", CopyDocMgt.GetSalesDocumentType(FromDocType));
        FromSalesHeaderArchive.FilterGroup := 2;
        FromSalesHeaderArchive."Document Type" := CopyDocMgt.GetSalesDocumentType(FromDocType);
        FromSalesHeaderArchive."No." := FromDocNo;
        FromSalesHeaderArchive."Doc. No. Occurrence" := FromDocNoOccurrenceG;
        FromSalesHeaderArchive."Version No." := FromDocVersionNoG;
        if (FromDocNo = '') and (SalesHeader."Sell-to Customer No." <> '') then
            if FromSalesHeaderArchive.SetCurrentKey("Document Type", "Sell-to Customer No.") then begin
                FromSalesHeaderArchive."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                if FromSalesHeaderArchive.Find('=><') then;
            end;
        if PAGE.RunModal(0, FromSalesHeaderArchive) = ACTION::LookupOK then begin
            FromDocNo := FromSalesHeaderArchive."No.";
            FromDocNoOccurrenceG := FromSalesHeaderArchive."Doc. No. Occurrence";
            FromDocVersionNoG := FromSalesHeaderArchive."Version No.";
            RequestOptionsPage.Update(false);
        end;
    end;

    local procedure LookupPostedShipment()
    begin
        FromSalesShptHeader."No." := FromDocNo;
        if (FromDocNo = '') and (SalesHeader."Sell-to Customer No." <> '') then
            if FromSalesShptHeader.SetCurrentKey("Sell-to Customer No.") then begin
                FromSalesShptHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                if FromSalesShptHeader.Find('=><') then;
            end;
        if PAGE.RunModal(0, FromSalesShptHeader) = ACTION::LookupOK then
            FromDocNo := FromSalesShptHeader."No.";
    end;

    local procedure LookupPostedInvoice()
    begin
        FromSalesInvHeader."No." := FromDocNo;
        if (FromDocNo = '') and (SalesHeader."Sell-to Customer No." <> '') then
            if FromSalesInvHeader.SetCurrentKey("Sell-to Customer No.") then begin
                FromSalesInvHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                if FromSalesInvHeader.Find('=><') then;
            end;
        FromSalesInvHeader.FilterGroup(2);
        FromSalesInvHeader.SetRange("Prepayment Invoice", false);
        FromSalesInvHeader.FilterGroup(0);
        if PAGE.RunModal(0, FromSalesInvHeader) = ACTION::LookupOK then
            FromDocNo := FromSalesInvHeader."No.";
    end;

    local procedure LookupPostedCrMemo()
    begin
        FromSalesCrMemoHeader."No." := FromDocNo;
        if (FromDocNo = '') and (SalesHeader."Sell-to Customer No." <> '') then
            if FromSalesCrMemoHeader.SetCurrentKey("Sell-to Customer No.") then begin
                FromSalesCrMemoHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                if FromSalesCrMemoHeader.Find('=><') then;
            end;
        FromSalesCrMemoHeader.FilterGroup(2);
        FromSalesCrMemoHeader.SetRange("Prepayment Credit Memo", false);
        FromSalesCrMemoHeader.FilterGroup(0);
        if PAGE.RunModal(0, FromSalesCrMemoHeader) = ACTION::LookupOK then
            FromDocNo := FromSalesCrMemoHeader."No.";
    end;

    local procedure LookupPostedReturn()
    begin
        FromReturnRcptHeader."No." := FromDocNo;
        if (FromDocNo = '') and (SalesHeader."Sell-to Customer No." <> '') then
            if FromReturnRcptHeader.SetCurrentKey("Sell-to Customer No.") then begin
                FromReturnRcptHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                if FromReturnRcptHeader.Find('=><') then;
            end;
        if PAGE.RunModal(0, FromReturnRcptHeader) = ACTION::LookupOK then
            FromDocNo := FromReturnRcptHeader."No.";
    end;

    local procedure ValidateIncludeHeader()
    begin
        RecalculateLinesG :=
          (FromDocType in [FromDocType::"Posted Shipment", FromDocType::"Posted Return Receipt"]) or not IncludeHeader;
        IF BoolGCopyLinesExactlyG THEN
            RecalculateLinesG := FALSE;
    end;

    procedure SetParameters(NewFromDocType: Enum "Sales Document Type From"; NewFromDocNo: Code[20]; NewIncludeHeader: Boolean; NewRecalcLines: Boolean)
    begin
        FromDocType := NewFromDocType;
        FromDocNo := NewFromDocNo;
        IncludeHeader := NewIncludeHeader;
        RecalculateLinesG := NewRecalcLines;
    end;
}
