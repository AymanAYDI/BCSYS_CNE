report 50088 "BC6_Phys. Inv. List CNE401"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/RDL/PhysInventoryListCNE401.rdl';

    Caption = 'Phys. Inventory List', comment = 'FRA="Liste d''inventaire"';

    dataset
    {
        dataitem(ItemJournalBatch; "Item Journal Batch")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Journal Template Name", Name, "BC6_Phys. Inv. Survey", "BC6_Phys. Inv. Check Bat. Name", "BC6_Assigned User ID";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column("USERID"; USERID)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(Item_Journal_Batch__TABLECAPTION_______Item_Journal_Batch__GETFILTERS; ItemJournalBatch.TABLECAPTION + ': ' + ItemJournalBatch.GETFILTERS)
            {
            }
            column(Item_Journal_Line__TABLECAPTION__________ItemJnlLineFilter; ItemJournalLine.TABLECAPTION + ': ' + ItemJnlLineFilter)
            {
            }
            column(Phys__Inventory_ListCaption; Phys__Inventory_ListCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item_Journal_Batch_Journal_Template_Name; "Journal Template Name")
            {
            }
            column(Item_Journal_Batch_Name; Name)
            {
            }
            column(ItemJnlLineFilter; ItemJnlLineFilter)
            {
            }
            dataitem(ItemJournalLine; "Item Journal Line")
            {
                DataItemLink = "Journal Template Name" = FIELD("Journal Template Name"),
                               "Journal Batch Name" = FIELD(Name);
                DataItemTableView = SORTING("Item No.", "Variant Code", "Location Code", "Bin Code", "Posting Date")
                                    ORDER(Ascending);
                RequestFilterFields = "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Location Code", "Bin Code";
                column(Item_Journal_Batch___Phys__Inv__Check_Batch_Name_; ItemJournalBatch."BC6_Phys. Inv. Check Bat. Name")
                {
                }
                column(Item_Journal_Batch___Phys__Inv__Survey_; FORMAT(ItemJournalBatch."BC6_Phys. Inv. Survey"))
                {
                }
                column(Item_Journal_Batch__Description; ItemJournalBatch.Description)
                {
                }
                column(Item_Journal_Batch___Assigned_User_ID_; ItemJournalBatch."BC6_Assigned User ID")
                {
                }
                column(Item_Journal_Batch__Name; ItemJournalBatch.Name)
                {
                }
                column(Item_Journal_Line__Posting_Date_; "Posting Date")
                {
                }
                column(Item_Journal_Line__Document_No__; "Document No.")
                {
                }
                column(Item_Journal_Line__Item_No__; "Item No.")
                {
                }
                column(Item_Journal_Line_Description; Description)
                {
                }
                column(EmptyString; '')
                {
                }
                column(CalcQty; CalcQty)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(BinCode; BinCode)
                {
                }
                column(Qty; Qty)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(GDecAmt; GDecAmt)
                {
                }
                column(PhysQty; PhysQty)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(RefreshQtyOkTxt; RefreshQtyOkTxt)
                {
                }
                column(GDecAmt_Control1000000002; GDecAmt)
                {
                }
                column(Item_Journal_Batch___Phys__Inv__Check_Batch_Name_Caption; ItemJournalBatch.FIELDCAPTION("BC6_Phys. Inv. Check Bat. Name"))
                {
                }
                column(Item_Journal_Batch___Phys__Inv__Survey_Caption; ItemJournalBatch.FIELDCAPTION("BC6_Phys. Inv. Survey"))
                {
                }
                column(Item_Journal_Batch___Assigned_User_ID_Caption; ItemJournalBatch.FIELDCAPTION("BC6_Assigned User ID"))
                {
                }
                column(QuantityCaption; QuantityCaptionLbl)
                {
                }
                column(AmountCaption; AmountCaptionLbl)
                {
                }
                column(CalcQtyCaption; CalcQtyCaptionLbl)
                {
                }
                column(Qty___Phys__Inventory_Caption; Qty___Phys__Inventory_CaptionLbl)
                {
                }
                column(Code_empl_Caption; Code_empl_CaptionLbl)
                {
                }
                column(Item_Journal_Line_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Item_Journal_Line__Item_No__Caption; FIELDCAPTION("Item No."))
                {
                }
                column(Item_Journal_Line__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(Item_Journal_Line__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
                {
                }
                column(Item_Journal_Line_Journal_Template_Name; "Journal Template Name")
                {
                }
                column(Item_Journal_Line_Journal_Batch_Name; "Journal Batch Name")
                {
                }
                column(Item_Journal_Line_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(LocationCode);
                    CLEAR(BinCode);
                    CLEAR(Item);
                    CLEAR(PhysQty);
                    CLEAR(CalcQty);

                    IF Item.GET("Item No.") THEN
                        BinCode := Item."Shelf No.";

                    IF Location.GET("Location Code") THEN BEGIN
                        LocationCode := "Location Code";
                        IF Location."Bin Mandatory" THEN
                            BinCode := "Bin Code";
                    END;

                    IF ShowQtyCalculated THEN
                        CalcQty := "Qty. (Calculated)";
                    IF ShowPhysQty THEN
                        PhysQty := "Qty. (Phys. Inventory)";

                    IF "Entry Type" IN ["Entry Type"::"Negative Adjmt.", "Entry Type"::Sale, "Entry Type"::Consumption] THEN
                        Qty := -Quantity
                    ELSE
                        Qty := Quantity;

                    IF Qty < 0 THEN
                        GDecAmt := -Amount
                    ELSE
                        GDecAmt := Amount;

                    RefreshQtyOkTxt := '';
                    IF NOT ItemJournalBatch."BC6_Phys. Inv. Survey" AND
                       "BC6_Qty.(Phys. Inv.)" THEN
                        RefreshQtyOkTxt := ' *';
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS(GDecAmt);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF ItemJournalTemplate.GET(ItemJournalBatch."Journal Template Name") THEN
                    IF ItemJournalTemplate.Type <> ItemJournalTemplate.Type::"Phys. Inventory" THEN
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
                    field(ShowQtyCalculated; ShowQtyCalculated)
                    {
                        Caption = 'Show Qty. (Calculated)', comment = 'FRA="Afficher quantité calculée"';
                    }
                    field(ShowPhysQty; ShowPhysQty)
                    {
                        Caption = 'Show Phys. Qty.', comment = 'FRA="Afficher quantité constatée"';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            ShowQtyCalculated := TRUE;
            ShowPhysQty := TRUE;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        ItemJnlLineFilter := ItemJournalLine.GETFILTERS;
    end;

    var
        Item: Record Item;
        ItemJournalTemplate: Record "Item Journal Template";
        Location: Record Location;
        ShowPhysQty: Boolean;
        ShowQtyCalculated: Boolean;
        BinCode: Code[20];
        LocationCode: Code[20];
        CalcQty: Decimal;
        GDecAmt: Decimal;
        PhysQty: Decimal;
        Qty: Decimal;
        AmountCaptionLbl: Label 'Amount', comment = 'FRA="Montant"';
        CalcQtyCaptionLbl: Label 'Qty. (Calculated)', comment = 'FRA="Qté calculée"';
        Code_empl_CaptionLbl: Label 'Code empl.';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Phys__Inventory_ListCaptionLbl: Label 'Phys. Inventory List', comment = 'FRA="Liste d''inventaire"';
        Qty___Phys__Inventory_CaptionLbl: Label 'Qty. (Phys. Inventory)', comment = 'FRA="Qté constatée"';
        QuantityCaptionLbl: Label 'Quantity', comment = 'FRA="Quantité"';
        RefreshQtyOkTxt: Text[10];
        ItemJnlLineFilter: Text[250];

    procedure Initialize(ShowQtyCalculated2: Boolean)
    begin
        ShowQtyCalculated := ShowQtyCalculated2;
    end;
}

