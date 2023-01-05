report 50007 "BC6_Price List" //715 
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDL/PriceList.rdl';
    Caption = 'Price List', Comment = 'FRA="Liste des prix"';

    dataset
    {
        dataitem(Item; Item)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Description", "Assembly BOM", "Inventory Posting Group";
            column(CompanyAddr1; CompanyAddr[1])
            {
            }
            column(CompanyAddr2; CompanyAddr[2])
            {
            }
            column(CompanyAddr3; CompanyAddr[3])
            {
            }
            column(CompanyAddr4; CompanyAddr[4])
            {
            }
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
            {
            }
            column(CompanyInfoBankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
            {
            }
            column(ReqDateFormatted; STRSUBSTNO(Text003, FORMAT(DateReq, 0, 4)))
            {
            }
            column(CompanyAddr5; CompanyAddr[5])
            {
            }
            column(CompanyAddr6; CompanyAddr[6])
            {
            }
            column(SalesType; SalesType)
            {
            }
            column(SalesCode; SalesCode)
            {
            }
            column(PageCaption; STRSUBSTNO(Text002, ''))
            {
            }
            column(SalesDesc; SalesDesc)
            {
            }
            column(UnitPriceFieldCaption; TempSalesPrice.FIELDCAPTION("Unit Price") + CurrencyText)
            {
            }
            column(LineDiscountFieldCaption; TempSalesLineDisc.FIELDCAPTION("Line Discount %") + CurrencyText)
            {
            }
            column(No_Item; "No.")
            {
            }
            column(PriceListCaption; PriceListCaptionLbl)
            {
            }
            column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
            {
            }
            column(CompanyInfoFaxNoCaption; CompanyInfoFaxNoCaptionLbl)
            {
            }
            column(CompanyInfoVATRegNoCaption; CompanyInfoVATRegNoCaptionLbl)
            {
            }
            column(CompanyInfoGiroNoCaption; CompanyInfoGiroNoCaptionLbl)
            {
            }
            column(CompanyInfoBankNameCaption; CompanyInfoBankNameCaptionLbl)
            {
            }
            column(CompanyInfoBankAccNoCaption; CompanyInfoBankAccNoCaptionLbl)
            {
            }
            column(ItemNoCaption; ItemNoCaptionLbl)
            {
            }
            column(ItemDescCaption; ItemDescCaptionLbl)
            {
            }
            column(UnitOfMeasureCaption; UnitOfMeasureCaptionLbl)
            {
            }
            column(MinimumQuantityCaption; MinimumQuantityCaptionLbl)
            {
            }
            column(VATTextCaption; VATTextCaptionLbl)
            {
            }
            dataitem(SalesPrices; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = FILTER(1 ..));
                column(VATText_SalesPrices; VATText)
                {
                }
                column(SalesPriceUnitPrice; TempSalesPrice."Unit Price")
                {
                    AutoFormatExpression = Currency.Code;
                    AutoFormatType = 2;
                }
                column(UOM_SalesPrices; UnitOfMeasure)
                {
                }
                column(ItemNo_SalesPrices; ItemNo)
                {
                }
                column(ItemDesc_SalesPrices; ItemDesc)
                {
                    // OptionCaption = 'Description';
                }
                column(MinimumQty_SalesPrices; TempSalesPrice."Minimum Quantity")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PrintSalesPrice(FALSE);
                end;

                trigger OnPreDataItem()
                begin
                    PreparePrintSalesPrice(FALSE);
                end;
            }
            dataitem(SalesLineDiscs; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = FILTER(1 ..));
                column(LineDisc_SalesLineDisc; TempSalesLineDisc."Line Discount %")
                {
                    AutoFormatExpression = Currency.Code;
                    AutoFormatType = 2;
                }
                column(MinimumQty_SalesLineDiscs; TempSalesLineDisc."Minimum Quantity")
                {
                }
                column(UOM_SalesLineDiscs; UnitOfMeasure)
                {
                }
                column(ItemDesc_SalesLineDiscs; ItemDesc)
                {
                }
                column(ItemNo_SalesLineDiscs; ItemNo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PrintSalesDisc();
                end;

                trigger OnPreDataItem()
                begin
                    PreparePrintSalesDisc(FALSE);
                end;
            }
            dataitem(DataItem7031; "Item Variant")
            {
                DataItemLink = "Item No." = FIELD("No.");
                dataitem(VariantSalesPrices; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    column(ItemNo_Variant_SalesPrices; ItemNo)
                    {
                    }
                    column(ItemDesc_Variant_SalesPrices; ItemDesc)
                    {
                    }
                    column(UOM_Variant_SalesPrices; UnitOfMeasure)
                    {
                    }
                    column(MinimumQty_Variant_SalesPrices; TempSalesPrice."Minimum Quantity")
                    {
                    }
                    column(UnitPrince_Variant_SalesPrices; TempSalesPrice."Unit Price")
                    {
                    }
                    column(VATText_Variant_SalesPrices; VATText)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        PrintSalesPrice(TRUE);
                    end;

                    trigger OnPreDataItem()
                    begin
                        PreparePrintSalesPrice(TRUE);
                    end;
                }
                dataitem(VariantSalesLineDiscs; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    column(ItemNo_Variant_SalesLineDescs; ItemNo)
                    {
                    }
                    column(ItemDesc_Variant_SalesLineDescs; ItemDesc)
                    {
                    }
                    column(UOM_Variant_SalesLineDescs; UnitOfMeasure)
                    {
                    }
                    column(MinimumQty_Variant_SalesLineDescs; TempSalesLineDisc."Minimum Quantity")
                    {
                    }
                    column(LineDisc_Variant_SalesLineDescs; TempSalesLineDisc."Line Discount %")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        PrintSalesDisc();
                    end;

                    trigger OnPreDataItem()
                    begin
                        PreparePrintSalesDisc(TRUE);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    ItemNo := Code;
                    ItemDesc := Description;

                    SalesPriceCalcMgt.FindSalesPrice(
                      TempSalesPrice, CustNo, ContNo, CustPriceGrCode, CampaignNo, Item."No.", Code, '', Currency.Code, DateReq, FALSE);
                    SalesPriceCalcMgt.FindSalesLineDisc(
                      TempSalesLineDisc, CustNo, ContNo, CustDiscGrCode, CampaignNo, Item."No.",
                        Item."Item Disc. Group", '', '', Currency.Code, DateReq, FALSE);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ItemNo := "No.";
                ItemDesc := Description;

                SalesPriceCalcMgt.FindSalesPrice(
                  TempSalesPrice, CustNo, ContNo, CustPriceGrCode, CampaignNo, "No.", '', '', Currency.Code, DateReq, FALSE);
                SalesPriceCalcMgt.FindSalesLineDisc(
                  TempSalesLineDisc, CustNo, ContNo, CustDiscGrCode, CampaignNo, "No.",
                    "Item Disc. Group", '', '', Currency.Code, DateReq, FALSE);
            end;

            trigger OnPreDataItem()
            begin
                CustNo := '';
                ContNo := '';
                CustPriceGrCode := '';
                CustDiscGrCode := '';
                SalesDesc := '';

                CASE SalesType OF
                    SalesType::Customer:
                        BEGIN
                            Cust.GET(SalesCode);
                            CustNo := Cust."No.";
                            CustPriceGrCode := Cust."Customer Price Group";
                            CustDiscGrCode := Cust."Customer Disc. Group";
                            SalesDesc := Cust.Name;
                        END;
                    SalesType::"Customer Price Group":
                        BEGIN
                            CustPriceGr.GET(SalesCode);
                            CustPriceGrCode := SalesCode;
                        END;
                    SalesType::Campaign:
                        BEGIN
                            Campaign.GET(SalesCode);
                            CampaignNo := SalesCode;
                            SalesDesc := Campaign.Description;
                        END;
                END;

                ContBusRel.SETRANGE("Link to Table", ContBusRel."Link to Table"::Customer);
                ContBusRel.SETRANGE("No.", CustNo);
                IF ContBusRel.FINDFIRST() THEN
                    ContNo := ContBusRel."Contact No.";
            end;
        }
    }

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
                    field("Date"; DateReq)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Date', Comment = 'FRA="Date"';
                        ToolTip = 'Specifies the period for which the prices apply, such as 10/01/96...12/31/96.', Comment = 'FRA="Spécifie la période à laquelle les prix s''appliquent, telle que du 01/10/96 au 31/12/96."';
                    }
                    field(SalesType; SalesType)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Type', Comment = 'FRA="Type vente"';
                        ToolTip = 'Specifies the sales type for which the price list should be valid.', Comment = 'FRA="Spécifie le type vente pour lequel la liste des prix doit être valide."';

                        trigger OnValidate()
                        begin
                            SalesCodeCtrlEnable := SalesType <> SalesType::"All Customers";
                            SalesCode := '';
                        end;
                    }
                    field(SalesCodeCtrl; SalesCode)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Code', Comment = 'FRA="Code vente"';
                        Enabled = SalesCodeCtrlEnable;
                        ToolTip = 'Specifies code for the sales type for which the price list should be valid.', Comment = 'FRA="Spécifie le code du type vente pour lequel la liste des prix doit être valide."';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            CampaignList: Page "Campaign List";
                            CustList: Page "Customer List";
                            CustPriceGrList: Page "Customer Price Groups";
                        begin
                            CASE SalesType OF
                                SalesType::Customer:
                                    BEGIN
                                        CustList.LOOKUPMODE := TRUE;
                                        CustList.SETRECORD(Cust);
                                        IF CustList.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                                            CustList.GETRECORD(Cust);
                                            SalesCode := Cust."No.";
                                        END;
                                    END;
                                SalesType::"Customer Price Group":
                                    BEGIN
                                        CustPriceGrList.LOOKUPMODE := TRUE;
                                        CustPriceGrList.SETRECORD(CustPriceGr);
                                        IF CustPriceGrList.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                                            CustPriceGrList.GETRECORD(CustPriceGr);
                                            SalesCode := CustPriceGr.Code;
                                        END;
                                    END;
                                SalesType::Campaign:
                                    BEGIN
                                        CampaignList.LOOKUPMODE := TRUE;
                                        CampaignList.SETRECORD(Campaign);
                                        IF CampaignList.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                                            CampaignList.GETRECORD(Campaign);
                                            SalesCode := Campaign."No.";
                                        END;
                                    END;
                            END;
                        end;

                        trigger OnValidate()
                        begin
                            ValidateSalesCode();
                        end;
                    }
                    field("Currency.Code";
                    Currency.Code)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Currency Code', Comment = 'FRA="Code devise"';
                        TableRelation = Currency;
                        ToolTip = 'Specifies the code for the currency that amounts are shown in.', Comment = 'FRA="Spécifie le code pour la devise utilisée pour l''affichage des montants."';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            SalesCodeCtrlEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            IF DateReq = 0D THEN
                DateReq := WORKDATE();

            SalesCodeCtrlEnable := TRUE;
            IF SalesType = SalesType::"All Customers" THEN
                SalesCodeCtrlEnable := FALSE;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        ValidateSalesCode();

        CompanyInfo.GET();
        FormatAddr.Company(CompanyAddr, CompanyInfo);

        IF CustPriceGr.Code <> '' THEN
            CustPriceGr.FIND();

        SetCurrency();
    end;

    var
        Campaign: Record Campaign;
        CompanyInfo: Record "Company Information";
        ContBusRel: Record "Contact Business Relation";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        Cust: Record Customer;
        CustPriceGr: Record "Customer Price Group";
        GLSetup: Record "General Ledger Setup";
        TempSalesLineDisc: Record "Sales Line Discount" temporary;
        TempSalesPrice: Record "Sales Price" temporary;
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        FormatAddr: Codeunit "Format Address";
        IsFirstSalesLineDisc: Boolean;
        IsFirstSalesPrice: Boolean;
        PricesInCurrency: Boolean;
        [InDataSet]
        SalesCodeCtrlEnable: Boolean;
        CustPriceGrCode: Code[10];
        UnitOfMeasure: Code[10];
        CampaignNo: Code[20];
        ContNo: Code[20];
        CustDiscGrCode: Code[20];
        CustNo: Code[20];
        ItemNo: Code[20];
        SalesCode: Code[20];
        DateReq: Date;
        CurrencyFactor: Decimal;
        SalesType: Enum "Sales Price Type";
        CompanyInfoBankAccNoCaptionLbl: Label 'Account No.', Comment = 'FRA="N° compte"';
        CompanyInfoBankNameCaptionLbl: Label 'Bank', Comment = 'FRA="Banque"';
        CompanyInfoFaxNoCaptionLbl: Label 'Fax No.', Comment = 'FRA="N° télécopie"';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.', Comment = 'FRA="N° CCP"';
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.', Comment = 'FRA="N° téléphone"';
        CompanyInfoVATRegNoCaptionLbl: Label 'VAT Reg. No.', Comment = 'FRA="N° id. intracomm."';
        ItemDescCaptionLbl: Label 'Description', Comment = 'FRA="Description"';
        ItemNoCaptionLbl: Label 'Item No.', Comment = 'FRA="N° article"';
        MinimumQuantityCaptionLbl: Label 'Minimum Quantity', Comment = 'FRA="Quantité minimum"';
        PriceListCaptionLbl: Label 'Price List', Comment = 'FRA="Liste des prix"';
        Text000: Label 'Incl.', Comment = 'FRA="TTC"';
        Text001: Label 'Excl.', Comment = 'FRA="HT"';
        Text002: Label 'Page %1', Comment = 'FRA="Page %1"';
        Text003: Label 'As of %1', Comment = 'FRA="Au %1"';
        Text004: Label 'You must specify a sales code, if the sales type is different from All Customers.', Comment = 'FRA="Vous devez spécifier un code vente, si le type vente est différent de Tous les clients."';
        UnitOfMeasureCaptionLbl: Label 'Unit of Measure', Comment = 'FRA="Unité"';
        VATTextCaptionLbl: Label 'VAT', Comment = 'FRA="TVA"';
        VATText: Text[20];
        CurrencyText: Text[30];
        CompanyAddr: array[8] of Text[50];
        ItemDesc: Text[50];
        SalesDesc: Text[50];

    local procedure SetCurrency()
    begin
        PricesInCurrency := Currency.Code <> '';
        IF PricesInCurrency THEN BEGIN
            Currency.FIND();
            CurrencyText := ' (' + Currency.Code + ')';
            CurrencyFactor := 0;
        END ELSE
            GLSetup.GET();
    end;

    local procedure ConvertPricetoUoM(var UOMCode: Code[10]; var UnitPrice: Decimal)
    var
        UOMMgt: Codeunit "Unit of Measure Management";
    begin
        IF UOMCode = '' THEN BEGIN
            UnitPrice :=
              UnitPrice * UOMMgt.GetQtyPerUnitOfMeasure(Item, Item."Sales Unit of Measure");
            IF UOMCode = '' THEN
                UOMCode := Item."Sales Unit of Measure"
            ELSE
                UOMCode := Item."Base Unit of Measure";
        END;
    end;

    local procedure ConvertPriceLCYToFCY(CurrencyCode: Code[10]; var UnitPrice: Decimal)
    begin
        IF PricesInCurrency THEN BEGIN
            IF CurrencyCode = '' THEN BEGIN
                IF CurrencyFactor = 0 THEN BEGIN
                    Currency.TESTFIELD("Unit-Amount Rounding Precision");
                    CurrencyFactor := CurrExchRate.ExchangeRate(DateReq, Currency.Code);
                END;
                UnitPrice := CurrExchRate.ExchangeAmtLCYToFCY(DateReq, Currency.Code, UnitPrice, CurrencyFactor);
            END;
            UnitPrice := ROUND(UnitPrice, Currency."Unit-Amount Rounding Precision");
        END ELSE
            UnitPrice := ROUND(UnitPrice, GLSetup."Unit-Amount Rounding Precision");
    end;

    local procedure PreparePrintSalesPrice(IsVariant: Boolean)
    begin
        IF PricesInCurrency THEN BEGIN
            TempSalesPrice.SETRANGE("Currency Code", Currency.Code);
            IF TempSalesPrice.FIND('-') THEN BEGIN
                TempSalesPrice.SETRANGE("Currency Code", '');
                TempSalesPrice.DELETEALL();
            END;
            TempSalesPrice.SETRANGE("Currency Code");
        END;

        TempSalesPrice.SETRANGE("Sales Type", SalesType);
        TempSalesPrice.SETRANGE("Sales Code", SalesCode);

        IF IsVariant THEN BEGIN
            TempSalesPrice.SETRANGE("Variant Code", '');
            TempSalesPrice.DELETEALL();
            TempSalesPrice.SETRANGE("Variant Code");
        END;

        IsFirstSalesPrice := TRUE;
    end;

    local procedure PrintSalesPrice(IsVariant: Boolean)
    begin
        IF IsFirstSalesPrice THEN BEGIN
            IsFirstSalesPrice := FALSE;
            IF NOT TempSalesPrice.FIND('-') THEN BEGIN
                IF NOT IsVariant THEN BEGIN
                    IF SalesType = SalesType::Campaign THEN
                        CurrReport.SKIP();

                    TempSalesPrice."Currency Code" := '';
                    TempSalesPrice."Price Includes VAT" := Item."Price Includes VAT";
                    TempSalesPrice."Unit Price" := Item."Unit Price";
                    TempSalesPrice."Unit of Measure Code" := Item."Base Unit of Measure";
                    TempSalesPrice."Minimum Quantity" := 0;
                END ELSE
                    CurrReport.SKIP();
            END;
        END ELSE
            IF TempSalesPrice.NEXT() = 0 THEN
                CurrReport.BREAK();

        IF (SalesType = SalesType::Campaign) AND (TempSalesPrice."Sales Type" <> TempSalesPrice."Sales Type"::Campaign) THEN
            CurrReport.SKIP();

        IF TempSalesPrice."Price Includes VAT" THEN
            VATText := Text000
        ELSE
            VATText := Text001;
        UnitOfMeasure := TempSalesPrice."Unit of Measure Code";
        ConvertPricetoUoM(UnitOfMeasure, TempSalesPrice."Unit Price");
        ConvertPriceLCYToFCY(TempSalesPrice."Currency Code", TempSalesPrice."Unit Price");
    end;

    local procedure PreparePrintSalesDisc(IsVariant: Boolean)
    begin
        IF PricesInCurrency THEN BEGIN
            TempSalesLineDisc.SETRANGE("Currency Code", Currency.Code);
            IF TempSalesLineDisc.FIND('-') THEN BEGIN
                TempSalesLineDisc.SETRANGE("Currency Code", '');
                TempSalesLineDisc.DELETEALL();
            END;
            TempSalesLineDisc.SETRANGE("Currency Code");
        END;

        IF IsVariant THEN BEGIN
            TempSalesLineDisc.SETRANGE("Variant Code", '');
            TempSalesLineDisc.DELETEALL();
            TempSalesLineDisc.SETRANGE("Variant Code");
        END;

        IsFirstSalesLineDisc := TRUE;
    end;

    local procedure PrintSalesDisc()
    begin
        IF IsFirstSalesLineDisc THEN BEGIN
            IsFirstSalesLineDisc := FALSE;
            IF NOT TempSalesLineDisc.FIND('-') THEN
                CurrReport.BREAK();
        END ELSE
            IF TempSalesLineDisc.NEXT() = 0 THEN
                CurrReport.BREAK();

        IF (SalesType = SalesType::Campaign) AND (TempSalesLineDisc."Sales Type" <> TempSalesLineDisc."Sales Type"::Campaign) THEN
            CurrReport.SKIP();

        IF TempSalesLineDisc."Unit of Measure Code" = '' THEN
            UnitOfMeasure := Item."Base Unit of Measure"
        ELSE
            UnitOfMeasure := TempSalesLineDisc."Unit of Measure Code";
    end;

    procedure InitializeRequest(NewDateReq: Date; NewSalesType: Option; NewSalesCode: Code[20]; NewCurrencyCode: Code[10])
    begin
        DateReq := NewDateReq;
        SalesType := NewSalesType;
        SalesCode := NewSalesCode;
        Currency.Code := NewCurrencyCode;
    end;

    local procedure ValidateSalesCode()
    begin
        IF (SalesType <> SalesType::"All Customers") AND (SalesCode = '') THEN
            ERROR(Text004);

        CASE SalesType OF
            SalesType::Customer:
                Cust.GET(SalesCode);
            SalesType::"Customer Price Group":
                CustPriceGr.GET(SalesCode);
            SalesType::Campaign:
                Campaign.GET(SalesCode);
        END;
    end;
}

