report 50097 "BC6_Preparation NAVIDIIGEST1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/PreparationNAVIDIIGEST1.rdl';

    Caption = 'Preparation', Comment = 'FRA="Préparation (orig 205)"';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Sales Order', Comment = 'FRA="Commande vente"';
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                PrintOnlyIfDetail = true;
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    PrintOnlyIfDetail = true;
                    column(CompanyInfo1Picture; CompanyInfo.Picture)
                    {
                    }
                    column(CompanyInfo2Picture; CompanyInfo."BC6_Alt Picture")
                    {
                    }
                    column(STRSUBSTNO_Text005_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text005, FORMAT(CurrReport.PAGENO)))
                    {
                    }
                    column(ShipToAddr_1_; ShipToAddr[1])
                    {
                    }
                    column(ShipToAddr_2_; ShipToAddr[2])
                    {
                    }
                    column(ShipToAddr_3_; ShipToAddr[3])
                    {
                    }
                    column(ShipToAddr_4_; ShipToAddr[4])
                    {
                    }
                    column(CustAddr_5_; CustAddr[5])
                    {
                    }
                    column(CustAddr_4_; CustAddr[4])
                    {
                    }
                    column(CustAddr_3_; CustAddr[3])
                    {
                    }
                    column(CustAddr_2_; CustAddr[2])
                    {
                    }
                    column(CustAddr_1_; CustAddr[1])
                    {
                    }
                    column(ShipToAddr_5_; ShipToAddr[5])
                    {
                    }
                    column(Sales_Header___Your_Reference_; "Sales Header"."Your Reference")
                    {
                    }
                    column(Sales_Header___VAT_Registration_No__; "Sales Header"."VAT Registration No.")
                    {
                    }
                    column(SalesPurchPerson_Name; SalesPurchPerson.Name)
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(ShipmentDate; ShipmentDate)
                    {
                    }
                    column(Sales_Header___Document_Date_; "Sales Header"."Document Date")
                    {
                    }
                    column(PrestaTrans_Description; PrestaTrans.Description)
                    {
                    }
                    column(Sales_Header___Sell_to_Customer_No__; "Sales Header"."Sell-to Customer No.")
                    {
                    }
                    column(Sales_Header___No__; "Sales Header"."No.")
                    {
                    }
                    column(ModeTransport; ModeTransport)
                    {
                    }
                    column(ShipToAddr_6_; ShipToAddr[6])
                    {
                    }
                    column(CustAddr_6_; CustAddr[6])
                    {
                    }
                    column(Sales_Header___Shipping_Advice_; "Sales Header"."Shipping Advice")
                    {
                    }
                    column(ShipmentMethod_Description; ShipmentMethod.Description)
                    {
                    }
                    column(CompanyInfo_Picture; CompanyInfo.Picture)
                    {
                    }
                    column(CompanyInfo_s_Alt_Picture_; CompanyInfo."BC6_Alt Picture")
                    {
                    }
                    column(N_______Sales_Header___No__; 'N° ' + "Sales Header"."No.")
                    {
                    }
                    column("USERID"; USERID)
                    {
                    }
                    column(Sales_Header___External_Document_No__; "Sales Header"."External Document No.")
                    {
                    }
                    column(Sales_Header___Warehouse_Comments_; "Sales Header"."BC6_Warehouse Comments")
                    {
                    }
                    column(STRSUBSTNO_Text006_CompanyInfo__Alt_Phone_No___CompanyInfo__Alt_Fax_No___CompanyInfo__Alt_E_Mail__; STRSUBSTNO(Text006, CompanyInfo."BC6_Alt Phone No.", CompanyInfo."BC6_Alt Fax No.", CompanyInfo."BC6_Alt E-Mail"))
                    {
                    }
                    column(DataItem1000000036; CompanyInfo."BC6_Alt Address" + ' ' + CompanyInfo."BC6_Alt Address 2" + ' ' + STRSUBSTNO('%1 %2', CompanyInfo."BC6_Alt Post Code", CompanyInfo."BC6_Alt City"))
                    {
                    }
                    column(CompanyInfo__Alt_Name_; CompanyInfo."BC6_Alt Name")
                    {
                    }
                    column(STRSUBSTNO_Text006_CompanyInfo__Phone_No___CompanyInfo__Fax_No___CompanyInfo__E_Mail__; STRSUBSTNO(Text006, CompanyInfo."Phone No.", CompanyInfo."Fax No.", CompanyInfo."E-Mail"))
                    {
                    }
                    column(CompanyInfo_Address______CompanyInfo__Address_2______STRSUBSTNO___1__2__CompanyInfo__Post_Code__CompanyInfo_City_; CompanyInfo.Address + ' ' + CompanyInfo."Address 2" + ' ' + STRSUBSTNO('%1 %2', CompanyInfo."Post Code", CompanyInfo.City))
                    {
                    }
                    column(CompanyInfo_Name; CompanyInfo.Name)
                    {
                    }
                    column(DataItem1000000064; STRSUBSTNO(Text032, CompanyInfo."Legal Form", CompanyInfo."Stock Capital", CompanyInfo."Trade Register", CompanyInfo."APE Code", CompanyInfo."VAT Registration No."))
                    {
                    }
                    column(Shipment_departementCaption; Shipment_departementCaptionLbl)
                    {
                    }
                    column(ReferenceCaption; ReferenceCaptionLbl)
                    {
                    }
                    column(VAT_Registration_No__Caption; VAT_Registration_No__CaptionLbl)
                    {
                    }
                    column(ShipmentCaption; ShipmentCaptionLbl)
                    {
                    }
                    column(DateCaption; DateCaptionLbl)
                    {
                    }
                    column(Order_NumberCaption; Order_NumberCaptionLbl)
                    {
                    }
                    column(Customer_NumberCaption; Customer_NumberCaptionLbl)
                    {
                    }
                    column(Shipping_ServiceCaption; Shipping_ServiceCaptionLbl)
                    {
                    }
                    column(bill_DepartementCaption; bill_DepartementCaptionLbl)
                    {
                    }
                    column(Preparation_OrderCaption; Preparation_OrderCaptionLbl)
                    {
                    }
                    column(ShippingCaption; ShippingCaptionLbl)
                    {
                    }
                    column(Sales_Header___Shipping_Advice_Caption; "Sales Header".FIELDCAPTION("Shipping Advice"))
                    {
                    }
                    column(Shipping_conditionCaption; Shipping_conditionCaptionLbl)
                    {
                    }
                    column(UserCaption; UserCaptionLbl)
                    {
                    }
                    column(Sales_Header___External_Document_No__Caption; "Sales Header".FIELDCAPTION("External Document No."))
                    {
                    }
                    column(Sales_Header___Warehouse_Comments_Caption; "Sales Header".FIELDCAPTION("BC6_Warehouse Comments"))
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PageCaption; CstG001)
                    {
                    }
                    dataitem(TraitementTexteClient; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(TraitementTexteClient_Number; Number)
                        {
                        }
                        dataitem(TexteClient; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(StandardSalesLine_Description; StandardSalesLine.Description)
                            {
                            }
                            column(TexteClient_Number; Number)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Edition2 THEN BEGIN
                                    IF Number = 1 THEN
                                        StandardSalesLine.FIND('-')
                                    ELSE BEGIN
                                        StandardSalesLine.NEXT;
                                    END;
                                END;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT Edition THEN CurrReport.BREAK;
                                StandardSalesLine.RESET;
                                StandardSalesLine.SETRANGE(StandardSalesLine."Standard Sales Code", StandardCustomerSalesCode.Code);
                                Edition2 := TRUE;
                                IF StandardSalesLine.COUNT <> 0 THEN
                                    TexteClient.SETRANGE(Number, 1, StandardSalesLine.COUNT)
                                ELSE
                                    Edition2 := FALSE;
                                IF NOT Edition2 THEN CurrReport.BREAK;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF NOT Edition THEN CurrReport.BREAK;
                            IF Number = 1 THEN
                                StandardCustomerSalesCode.FIND('-')
                            ELSE
                                StandardCustomerSalesCode.NEXT;
                        end;

                        trigger OnPreDataItem()
                        begin

                            StandardCustomerSalesCode.RESET;
                            // TODO:  // StandardCustomerSalesCode.SETRANGE(StandardCustomerSalesCode.TextautoReport, TRUE);
                            StandardCustomerSalesCode.SETRANGE(StandardCustomerSalesCode."Customer No.", "Sales Header"."Sell-to Customer No.");
                            Edition := TRUE;
                            IF StandardCustomerSalesCode.COUNT <> 0 THEN
                                TraitementTexteClient.SETRANGE(Number, 1, StandardCustomerSalesCode.COUNT)
                            ELSE
                                Edition := FALSE;
                        end;
                    }
                    dataitem(Instruction; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(Preparation_and_shipping_instructions__Caption; Preparation_and_shipping_instructions__CaptionLbl)
                        {
                        }
                        column(Instruction_Number; Number)
                        {
                        }
                    }
                    dataitem(DataItem8541; "Sales Comment Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.");
                        column(Sales_Comment_Line_Comment; Comment)
                        {
                        }
                        column(Sales_Comment_Line_Document_Type; "Document Type")
                        {
                        }
                        column(Sales_Comment_Line_No_; "No.")
                        {
                        }
                        column(Sales_Comment_Line_Document_Line_No_; "Document Line No.")
                        {
                        }
                        column(Sales_Comment_Line_Line_No_; "Line No.")
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            FlagSaleCommentLine := TRUE;
                        end;
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                        PrintOnlyIfDetail = false;
                        column(Sales_Line__Sales_Line___Outstanding_Quantity_; "Sales Line"."Outstanding Quantity")
                        {
                        }
                        column(Sales_Line__Sales_Line___Quantity_Shipped_; "Sales Line"."Quantity Shipped")
                        {
                        }
                        column(Sales_Line__Sales_Line__Quantity; "Sales Line".Quantity)
                        {
                        }
                        column(Sales_Line__Sales_Line__Description; "Sales Line".Description)
                        {
                        }
                        column(Sales_Line__Sales_Line___No__; "Sales Line"."No.")
                        {
                        }
                        column(ItemInventory; ItemInventory)
                        {
                            DecimalPlaces = 0 : 0;
                        }
                        column(item__Shelf_No__; item."Shelf No.")
                        {
                        }
                        column(Sales_Line__Sales_Line__Description_Control1000000133; "Sales Line".Description)
                        {
                        }
                        column(STRSUBSTNO_FORMAT__Sales_Line___Qty__to_Ship___Gross_Weight___; Gross_WeightCaptionLbl + '                       ' + FORMAT("Sales Line"."Qty. to Ship" * "Gross Weight"))
                        {
                        }
                        column(NetWeight; NetWeight)
                        {
                        }
                        column(GrossWeight; GrossWeight)
                        {
                        }
                        column(To_prepareCaption; To_prepareCaptionLbl)
                        {
                        }
                        column(DeliveredCaption; DeliveredCaptionLbl)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(OrderCaption; OrderCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(ItemCaption; ItemCaptionLbl)
                        {
                        }
                        column(Shelf_No_Caption; Shelf_No_CaptionLbl)
                        {
                        }
                        column(InventoryCaption; InventoryCaptionLbl)
                        {
                        }
                        column(NextCaption; NextCaptionLbl)
                        {
                        }
                        column(ItemCaption_Control1000000067; ItemCaption_Control1000000067Lbl)
                        {
                        }
                        column(To_prepareCaption_Control1000000096; To_prepareCaption_Control1000000096Lbl)
                        {
                        }
                        column(DeliveredCaption_Control1000000110; DeliveredCaption_Control1000000110Lbl)
                        {
                        }
                        column(QuantityCaption_Control1000000118; QuantityCaption_Control1000000118Lbl)
                        {
                        }
                        column(OrderCaption_Control1000000119; OrderCaption_Control1000000119Lbl)
                        {
                        }
                        column(DescriptionCaption_Control1000000121; DescriptionCaption_Control1000000121Lbl)
                        {
                        }
                        column(Shelf_No_Caption_Control1000000123; Shelf_No_Caption_Control1000000123Lbl)
                        {
                        }
                        column(InventoryCaption_Control1000000126; InventoryCaption_Control1000000126Lbl)
                        {
                        }
                        column(Gross_WeightCaption; Gross_WeightCaptionLbl)
                        {
                        }
                        column(To_be_continuedCaption; To_be_continuedCaptionLbl)
                        {
                        }
                        column(Net_WeightCaption; Net_WeightCaptionLbl)
                        {
                        }
                        column(GrossWeightCaption; GrossWeightCaptionLbl)
                        {
                        }
                        column(Sales_Line_Document_Type; "Document Type")
                        {
                        }
                        column(Sales_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Line_Line_No_; "Line No.")
                        {
                        }
                        column(Sales_Line_Type; FORMAT(Type, 0, 9))
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF "Gross Weight" <> 0 THEN BEGIN
                                tempcalc := "Qty. to Ship" * "Gross Weight";
                                GrossWeight := GrossWeight + (tempcalc);
                                tempcalc := "Qty. to Ship" * "Net Weight";
                                NetWeight := NetWeight + (tempcalc);
                            END;
                            ItemInventory := 0;
                            item.RESET;
                            IF item.GET("No.") THEN BEGIN
                                item.SETRANGE("Location Filter", "Location Code");
                                item.CALCFIELDS(Inventory);
                                ItemInventory := item.Inventory;
                            END;
                            IF (BooGRespectLinesPrep) AND NOT ("Sales Line"."BC6_To Prepare") THEN
                                CurrReport.SKIP;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    SalesPost: Codeunit "Sales-Post";
                begin
                    CLEAR(SalesLine);
                    CLEAR(SalesPost);
                    VATAmountLine.DELETEALL;
                    SalesPost.GetSalesLines("Sales Header", SalesLine, 0);
                    SalesLine.SETRANGE("Line No.", 0, SalesLine."Line No.");


                    MoreLines := SalesLine.FIND('+');

                    WHILE MoreLines AND (SalesLine."Outstanding Quantity" = 0)
                    DO
                        MoreLines := SalesLine.NEXT(-1) <> 0;
                    IF NOT MoreLines THEN
                        CurrReport.BREAK;


                    IF Number > 1 THEN
                        CopyText := Text003;
                    CurrReport.PAGENO := 1;
                    GrossWeight := 0;
                    NetWeight := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        SalesCountPrinted.RUN("Sales Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := 0;
                    IF NoOfCopies <> 0 THEN
                        NoOfLoops := NoOfCopies;

                    CopyText := '';
                    IF NoOfLoops > 0 THEN
                        SETRANGE(Number, 1, NoOfLoops)
                    ELSE
                        SETRANGE(Number, 0, 0);


                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.GET;
                IF Country.GET(CompanyInfo."Country/Region Code") THEN
                    Pays := Country.Name;

                //PRM fin

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                    CompanyInfo.GET;
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                END;
                GLSetup.GET;
                PrincipalContact := '';

                ShipmentDate := 0D;
                IF "Promised Delivery Date" <> 0D THEN
                    ShipmentDate := "Promised Delivery Date"
                ELSE
                    IF "Requested Delivery Date" <> 0D THEN
                        ShipmentDate := "Requested Delivery Date";
                ModeDePayment := '';
                IF PaymentMethod.GET("Sales Header"."Payment Method Code") THEN
                    ModeDePayment := PaymentMethod.Description;
                IF "Salesperson Code" = '' THEN BEGIN
                    CLEAR(SalesPurchPerson);
                    SalesPersonText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText := Text000;

                END;
                IF ("Your Reference" = '') AND ("External Document No." = '') THEN
                    VotreRef := ''
                ELSE BEGIN
                    VotreRef := "External Document No." + '  ' + "Your Reference";
                END;

                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    VATNoText := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text002, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text006, "Currency Code");
                END;
                FormatAddr.SalesHeaderSellTo(CustAddr, "Sales Header");
                ModeTransport := '';
                IF ShippingAgent.GET("Sales Header"."Shipping Agent Code") THEN
                    ModeTransport := ShippingAgent.Name;


                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                IF "Sales Header"."Shipping Agent Service Code" = '' THEN
                    PrestaTrans.INIT
                ELSE
                    PrestaTrans.GET("Sales Header"."Shipping Agent Code", "Sales Header"."Shipping Agent Service Code");


                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;
                //                                           PRM
                Customer.GET("Sell-to Customer No.");

                IF NOT CurrReport.PREVIEW THEN BEGIN
                END;

                RecGSalesLine.RESET;
                RecGSalesLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                RecGSalesLine.SETRANGE(RecGSalesLine."Document Type", "Sales Header"."Document Type");
                RecGSalesLine.SETRANGE(RecGSalesLine."Document No.", "Sales Header"."No.");
                RecGSalesLine.SETRANGE(RecGSalesLine."BC6_To Prepare", TRUE);
                IF NOT RecGSalesLine.FIND('-') THEN
                    CurrReport.SKIP;

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies', Comment = 'FRA="Nombre de copies"';
                    }
                    field("Respect Lines To Prepare"; BooGRespectLinesPrep)
                    {
                        Caption = 'Respect Lines To Prepare', Comment = 'FRA="Respecter lignes à préparer"';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information', Comment = 'FRA="Afficher info. internes"';
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        Caption = 'Archive Document', Comment = 'FRA="Archiver document"';

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN
                                LogInteraction := FALSE;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction', Comment = 'FRA="Journal interaction"';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
    end;

    var
        PaymentTerms: Record "Payment Terms";
        Language: Record Language;
        Country: Record "Country/Region";
        ShipmentMethod: Record "Shipment Method";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        Customer: Record Customer;
        item: Record Item;
        RecGSalesLine: Record "Sales Line";
        SalesLine: Record "Sales Line" temporary;
        SalesCommentLine: Record "Sales Comment Line";
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        StandardSalesLine: Record "Standard Sales Line";
        StandardCustomerSalesCode: Record "Standard Customer Sales Code";
        PaymentMethod: Record "Payment Method";
        VATAmountLine: Record "VAT Amount Line" temporary;
        ShippingAgent: Record "Shipping Agent";
        DimensionValue: Record "Dimension Value";
        RespCenter: Record "Responsibility Center";
        ItemReference: Record "Item Reference";
        PrestaTrans: Record "Shipping Agent Services";
        TablesDiverses: Record "BC6_Various Tables";
        SalesCountPrinted: Codeunit "Sales-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        ArchiveDocument: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        BooGRespectLinesPrep: Boolean;
        Continue: Boolean;
        EditerToutesLignes: Boolean;
        Edition: Boolean;
        Edition2: Boolean;
        FlagSaleCommentLine: Boolean;
        FlagText: Boolean;
        LogInteraction: Boolean;
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowInternalInfo: Boolean;
        ShowShippingAddr: Boolean;
        PrincipalContact: Code[10];
        ShipmentDate: Date;
        GrossWeight: Decimal;
        ItemInventory: Decimal;
        NetWeight: Decimal;
        PrixNet: Decimal;
        tempcalc: Decimal;
        TotalAmountInclVAT: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        "--NSC1.01--": Integer;
        "--NSC1.10--": Integer;
        "--NSC1.11--": Integer;
        "-FEP-ACHAT-200706_18_A -": Integer;
        CompteurDeLigne: Integer;
        i: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        bill_DepartementCaptionLbl: Label 'bill Departement', Comment = 'FRA="Adresse de Facturation"';
        CstG001: Label 'Page';
        Customer_NumberCaptionLbl: Label 'Customer Number', Comment = 'FRA="Code Client"';
        DateCaptionLbl: Label 'Date';
        DeliveredCaption_Control1000000110Lbl: Label 'Delivered', Comment = 'FRA="Livrée"';
        DeliveredCaptionLbl: Label 'Delivered', Comment = 'FRA="Livrée"';
        DescriptionCaption_Control1000000121Lbl: Label 'Description';
        DescriptionCaptionLbl: Label 'Description';
        Gross_WeightCaptionLbl: Label 'Gross Weight', Comment = 'FRA="Poids brut"';
        GrossWeightCaptionLbl: Label 'Gross Weight', Comment = 'FRA="Poids brut"';
        InventoryCaption_Control1000000126Lbl: Label 'Inventory', Comment = 'FRA=""';
        InventoryCaptionLbl: Label 'Inventory', Comment = 'FRA=""';
        ItemCaption_Control1000000067Lbl: Label 'Item', Comment = 'FRA="Référence"';
        ItemCaptionLbl: Label 'Item', Comment = 'FRA="Référence"';
        Net_WeightCaptionLbl: Label 'Net Weight', Comment = 'FRA="Poids net"';
        NextCaptionLbl: Label 'Next', Comment = 'FRA="Suite"';
        Order_NumberCaptionLbl: Label 'Order Number', Comment = 'FRA="N° de Commande"';
        OrderCaption_Control1000000119Lbl: Label 'Order', Comment = 'FRA="Cdée"';
        OrderCaptionLbl: Label 'Order', Comment = 'FRA="Cdée"';
        Preparation_and_shipping_instructions__CaptionLbl: Label 'Preparation and shipping instructions :', Comment = 'FRA="Instructions de préparation et livraison"';
        Preparation_OrderCaptionLbl: Label 'Preparation Order', Comment = 'FRA="Bon de préparation"';
        QuantityCaption_Control1000000118Lbl: Label 'Quantity', Comment = 'FRA="Quantité"';
        QuantityCaptionLbl: Label 'Quantity', Comment = 'FRA="Quantité"';
        ReferenceCaptionLbl: Label 'Reference', Comment = 'FRA="Référence"';
        Shelf_No_Caption_Control1000000123Lbl: Label 'Shelf No.', Comment = 'FRA="N° emplacement"';
        Shelf_No_CaptionLbl: Label 'Shelf No.', Comment = 'FRA="N° emplacement"';
        Shipment_departementCaptionLbl: Label 'Shipment departement', Comment = 'FRA="Adresse de livraison"';
        ShipmentCaptionLbl: Label 'Shipment', Comment = 'FRA="Livraison"';
        Shipping_conditionCaptionLbl: Label 'Shipping condition', Comment = 'FRA="Condition de livraison"';
        Shipping_ServiceCaptionLbl: Label 'Shipping Service', Comment = 'FRA="Prestation Transport"';
        ShippingCaptionLbl: Label 'Shipping', Comment = 'FRA="Transporteur"';
        Text000: Label 'Salesperson', Comment = 'FRA="Vendeur"';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT', Comment = 'FRA="Total %1 TTC"';
        Text003: Label 'COPY', Comment = 'FRA="COPIE"';
        Text004: Label 'Order Confirmation %1', Comment = 'FRA="Confirmation de commande %1"';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT', Comment = 'FRA="Total %1 Excl. VAT"';
        Text008: Label 'de commande';
        Text016: Label 'INVOICE DEPARTMENT', Comment = 'FRA="SERVICE FACTURATION"';
        Text030: Label '%1 - %2 - %3 %4';
        Text032: Label '%1 STOCK CAPITAL %2  · %3  · Registration No. %4 ·  EP %5', Comment = 'FRA="%1 au capital de  %2   - %3  -  APE %4 - N°TVA : %5"';
        To_be_continuedCaptionLbl: Label 'To be continued', Comment = 'FRA="A Suivre"';
        To_prepareCaption_Control1000000096Lbl: Label 'To prepare', Comment = 'FRA="A servir"';
        To_prepareCaptionLbl: Label 'To prepare', Comment = 'FRA="A servir"';
        UserCaptionLbl: Label 'User', Comment = 'FRA="Utilisateur"';
        VAT_Registration_No__CaptionLbl: Label '<VAT Registration No.>', Comment = 'FRA="N° TVA :"';
        Langue: Text[10];
        LangueLig01: Text[10];
        LangueLig10: Text[10];
        LangueLig20: Text[10];
        LangueLig30: Text[10];
        LangueLig40: Text[10];
        LangueLig50: Text[10];
        ListeTable: Text[10];
        CrossRefNo: Text[20];
        CopyText: Text[30];
        ModeDePayment: Text[30];
        Pays: Text[30];
        ReferenceText: Text[30];
        TempGencod: Text[30];
        templibelledouanier: Text[30];
        TmpNamereport: Text[30];
        VATNoText: Text[30];
        CompanyAddr: array[8] of Text[50];
        CustAddr: array[8] of Text[50];
        ModeTransport: Text[50];
        PrincContactName: Text[50];
        SalesPersonText: Text[50];
        ShipToAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        OldDimText: Text[75];
        DimText: Text[120];
        Text10: Text[200];
        Text20: Text[200];
        Text30: Text[200];
        Text40: Text[200];
        Text50: Text[200];
        VotreRef: Text[200];
}

