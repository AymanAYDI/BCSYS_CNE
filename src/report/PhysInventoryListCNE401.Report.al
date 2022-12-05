report 50088 "Phys. Inventory List CNE401"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // //REPORT CREATION SEDU 06/02/2008
    //         - Duplication report 722 : déplacement colonnes et ajout sous-total
    // 
    // //>> CNE4.01
    // A:FE14 01.09.2011 : Inventory Control : Refresh Phys. Quantity
    // ------------------------------------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = './PhysInventoryListCNE401.rdlc';

    Caption = 'Phys. Inventory List';

    dataset
    {
        dataitem(DataItem8780; Table233)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Journal Template Name", Name, "Phys. Inv. Survey", "Phys. Inv. Check Batch Name", "Assigned User ID";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(Item_Journal_Batch__TABLECAPTION_______Item_Journal_Batch__GETFILTERS; "Item Journal Batch".TABLECAPTION + ': ' + "Item Journal Batch".GETFILTERS)
            {
            }
            column(Item_Journal_Line__TABLECAPTION__________ItemJnlLineFilter; "Item Journal Line".TABLECAPTION + ': ' + ItemJnlLineFilter)
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
            dataitem(DataItem8280; Table83)
            {
                DataItemLink = Journal Template Name=FIELD(Journal Template Name),
                               Journal Batch Name=FIELD(Name);
                DataItemTableView = SORTING(Item No.,Variant Code,Location Code,Bin Code,Posting Date)
                                    ORDER(Ascending);
                RequestFilterFields = "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code","Location Code","Bin Code";
                column(Item_Journal_Batch___Phys__Inv__Check_Batch_Name_;"Item Journal Batch"."Phys. Inv. Check Batch Name")
                {
                }
                column(Item_Journal_Batch___Phys__Inv__Survey_;FORMAT("Item Journal Batch"."Phys. Inv. Survey"))
                {
                }
                column(Item_Journal_Batch__Description;"Item Journal Batch".Description)
                {
                }
                column(Item_Journal_Batch___Assigned_User_ID_;"Item Journal Batch"."Assigned User ID")
                {
                }
                column(Item_Journal_Batch__Name;"Item Journal Batch".Name)
                {
                }
                column(Item_Journal_Line__Posting_Date_;"Posting Date")
                {
                }
                column(Item_Journal_Line__Document_No__;"Document No.")
                {
                }
                column(Item_Journal_Line__Item_No__;"Item No.")
                {
                }
                column(Item_Journal_Line_Description;Description)
                {
                }
                column(EmptyString;'')
                {
                }
                column(CalcQty;CalcQty)
                {
                    DecimalPlaces = 0:0;
                }
                column(BinCode;BinCode)
                {
                }
                column(Qty;Qty)
                {
                    DecimalPlaces = 0:0;
                }
                column(GDecAmt;GDecAmt)
                {
                }
                column(PhysQty;PhysQty)
                {
                    DecimalPlaces = 0:0;
                }
                column(RefreshQtyOkTxt;RefreshQtyOkTxt)
                {
                }
                column(GDecAmt_Control1000000002;GDecAmt)
                {
                }
                column(Item_Journal_Batch___Phys__Inv__Check_Batch_Name_Caption;"Item Journal Batch".FIELDCAPTION("Phys. Inv. Check Batch Name"))
                {
                }
                column(Item_Journal_Batch___Phys__Inv__Survey_Caption;"Item Journal Batch".FIELDCAPTION("Phys. Inv. Survey"))
                {
                }
                column(Item_Journal_Batch___Assigned_User_ID_Caption;"Item Journal Batch".FIELDCAPTION("Assigned User ID"))
                {
                }
                column(QuantityCaption;QuantityCaptionLbl)
                {
                }
                column(AmountCaption;AmountCaptionLbl)
                {
                }
                column(CalcQtyCaption;CalcQtyCaptionLbl)
                {
                }
                column(Qty___Phys__Inventory_Caption;Qty___Phys__Inventory_CaptionLbl)
                {
                }
                column(Code_empl_Caption;Code_empl_CaptionLbl)
                {
                }
                column(Item_Journal_Line_DescriptionCaption;FIELDCAPTION(Description))
                {
                }
                column(Item_Journal_Line__Item_No__Caption;FIELDCAPTION("Item No."))
                {
                }
                column(Item_Journal_Line__Document_No__Caption;FIELDCAPTION("Document No."))
                {
                }
                column(Item_Journal_Line__Posting_Date_Caption;FIELDCAPTION("Posting Date"))
                {
                }
                column(Item_Journal_Line_Journal_Template_Name;"Journal Template Name")
                {
                }
                column(Item_Journal_Line_Journal_Batch_Name;"Journal Batch Name")
                {
                }
                column(Item_Journal_Line_Line_No_;"Line No.")
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

                    IF Location.GET("Location Code") THEN
                      BEGIN
                        LocationCode := "Location Code";
                        IF Location."Bin Mandatory" THEN
                          BinCode := "Bin Code";
                    END;

                    IF ShowQtyCalculated THEN
                      CalcQty := "Qty. (Calculated)";
                    IF ShowPhysQty THEN
                      PhysQty := "Qty. (Phys. Inventory)";

                    IF "Entry Type" IN ["Entry Type"::"Negative Adjmt.","Entry Type"::Sale,"Entry Type"::Consumption] THEN
                      Qty := -Quantity
                    ELSE
                      Qty := Quantity;

                    IF Qty < 0 THEN
                      GDecAmt := - Amount
                    ELSE
                      GDecAmt := Amount;

                    //>>
                    RefreshQtyOkTxt := '';
                    IF NOT "Item Journal Batch"."Phys. Inv. Survey" AND
                       "Qty. Refreshed (Phys. Inv.)" THEN
                          RefreshQtyOkTxt := ' *'; // FORMAT("Qty. Refreshed (Phys. Inv.)"); ;
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS(GDecAmt);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF ItemJournalTemplate.GET("Item Journal Batch"."Journal Template Name") THEN
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
                    field(ShowQtyCalculated;ShowQtyCalculated)
                    {
                        Caption = 'Show Qty. (Calculated)';
                    }
                    field(ShowPhysQty;ShowPhysQty)
                    {
                        Caption = 'Show Phys. Qty.';
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
        ItemJnlLineFilter := "Item Journal Line".GETFILTERS;
    end;

    var
        ItemJournalTemplate: Record "82";
        ItemJnlLineFilter: Text[250];
        ShowQtyCalculated: Boolean;
        ShowPhysQty: Boolean;
        Item: Record "27";
        GDecTotalAmt: Decimal;
        GDecAmt: Decimal;
        BinCode: Code[20];
        LocationCode: Code[20];
        Location: Record "14";
        PhysQty: Decimal;
        CalcQty: Decimal;
        Qty: Decimal;
        RefreshQtyOkTxt: Text[10];
        Phys__Inventory_ListCaptionLbl: Label 'Phys. Inventory List';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        QuantityCaptionLbl: Label 'Quantity';
        AmountCaptionLbl: Label 'Amount';
        CalcQtyCaptionLbl: Label 'Qty. (Calculated)';
        Qty___Phys__Inventory_CaptionLbl: Label 'Qty. (Phys. Inventory)';
        Code_empl_CaptionLbl: Label 'Code empl.';

    [Scope('Internal')]
    procedure Initialize(ShowQtyCalculated2: Boolean)
    begin
        ShowQtyCalculated := ShowQtyCalculated2;
    end;
}

