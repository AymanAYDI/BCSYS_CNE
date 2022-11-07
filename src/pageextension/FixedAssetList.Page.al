page 5601 "Fixed Asset List"
{
    // 
    // //Modif JX-ABE du 04/05/2016//
    // // Rendre le N° de série modifiable

    Caption = 'Fixed Asset List';
    CardPageID = "Fixed Asset Card";
    Editable = true;
    PageType = List;
    SourceTable = Table5600;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("No."; "No.")
                {
                    Editable = false;
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Serial No."; "Serial No.")
                {
                }
                field("Vendor No."; "Vendor No.")
                {
                    Editable = false;
                }
                field("Maintenance Vendor No."; "Maintenance Vendor No.")
                {
                    Editable = false;
                    Visible = true;
                }
                field("Responsible Employee"; "Responsible Employee")
                {
                    Editable = false;
                    Visible = true;
                }
                field("FA Class Code"; "FA Class Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("FA Subclass Code"; "FA Subclass Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("FA Location Code"; "FA Location Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Budgeted Asset"; "Budgeted Asset")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Search Description"; "Search Description")
                {
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(; Links)
            {
                Visible = false;
            }
            systempart(; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Fixed &Asset")
            {
                Caption = 'Fixed &Asset';
                Image = FixedAssets;
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page 5601;
                    RunPageLink = No.=FIELD(No.);
                    ShortCutKey = 'Shift+F5';
                }
                action("Depreciation &Books")
                {
                    Caption = 'Depreciation &Books';
                    Image = DepreciationBooks;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 5619;
                                    RunPageLink = FA No.=FIELD(No.);
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 5602;
                                    RunPageLink = FA No.=FIELD(No.);
                    ShortCutKey = 'F7';
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    action("Dimensions-Single")
                    {
                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        RunObject = Page 540;
                                        RunPageLink = Table ID=CONST(5600),No.=FIELD(No.);
                        ShortCutKey = 'Shift+Ctrl+D';
                    }
                    action("Dimensions-&Multiple")
                    {
                        AccessByPermission = TableData 348=R;
                        Caption = 'Dimensions-&Multiple';
                        Image = DimensionSets;

                        trigger OnAction()
                        var
                            FA: Record "5600";
                            DefaultDimMultiple: Page "542";
                        begin
                            CurrPage.SETSELECTIONFILTER(FA);
                            DefaultDimMultiple.SetMultiFA(FA);
                            DefaultDimMultiple.RUNMODAL;
                        end;
                    }
                }
                action("Main&tenance Ledger Entries")
                {
                    Caption = 'Main&tenance Ledger Entries';
                    Image = MaintenanceLedgerEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 5641;
                                    RunPageLink = FA No.=FIELD(No.);
                    RunPageView = SORTING(FA No.);
                }
                action(Picture)
                {
                    Caption = 'Picture';
                    Image = Picture;
                    RunObject = Page 5620;
                                    RunPageLink = No.=FIELD(No.);
                }
                action("C&opy Fixed Asset")
                {
                    Caption = 'C&opy Fixed Asset';
                    Ellipsis = true;
                    Image = CopyFixedAssets;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        CopyFA: Report "5685";
                    begin
                        CopyFA.SetFANo("No.");
                        CopyFA.RUNMODAL;
                    end;
                }
                action("FA Posting Types Overview")
                {
                    Caption = 'FA Posting Types Overview';
                    Image = ShowMatrix;
                    RunObject = Page 5662;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 124;
                                    RunPageLink = Table Name=CONST(Fixed Asset),No.=FIELD(No.);
                }
            }
            group("Main Asset")
            {
                Caption = 'Main Asset';
                Image = Components;
                action("M&ain Asset Components")
                {
                    Caption = 'M&ain Asset Components';
                    Image = Components;
                    RunObject = Page 5658;
                                    RunPageLink = Main Asset No.=FIELD(No.);
                }
                action("Ma&in Asset Statistics")
                {
                    Caption = 'Ma&in Asset Statistics';
                    Image = StatisticsDocument;
                    RunObject = Page 5603;
                                    RunPageLink = FA No.=FIELD(No.);
                }
                separator()
                {
                    Caption = '';
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    Image = FixedAssetLedger;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page 5604;
                                    RunPageLink = FA No.=FIELD(No.);
                    RunPageView = SORTING(FA No.);
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Error Ledger Entries")
                {
                    Caption = 'Error Ledger Entries';
                    Image = ErrorFALedgerEntries;
                    RunObject = Page 5605;
                                    RunPageLink = Canceled from FA No.=FIELD(No.);
                    RunPageView = SORTING(Canceled from FA No.);
                }
                action("Maintenance &Registration")
                {
                    Caption = 'Maintenance &Registration';
                    Image = MaintenanceRegistrations;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 5625;
                                    RunPageLink = FA No.=FIELD(No.);
                }
            }
        }
        area(processing)
        {
            action("Fixed Asset Journal")
            {
                Caption = 'Fixed Asset Journal';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 5629;
            }
            action("Fixed Asset G/L Journal")
            {
                Caption = 'Fixed Asset G/L Journal';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 5628;
            }
            action("Fixed Asset Reclassification Journal")
            {
                Caption = 'Fixed Asset Reclassification Journal';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 5636;
            }
            action("Recurring Fixed Asset Journal")
            {
                Caption = 'Recurring Fixed Asset Journal';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 5634;
            }
            action("Calculate Depreciation")
            {
                Caption = 'Calculate Depreciation';
                Ellipsis = true;
                Image = CalculateDepreciation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report 5692;
            }
        }
        area(reporting)
        {
            action("Fixed Assets List")
            {
                Caption = 'Fixed Assets List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 5601;
            }
            action("Acquisition List")
            {
                Caption = 'Acquisition List';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 5608;
            }
            action(Details)
            {
                Caption = 'Details';
                Image = View;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 5604;
            }
            action("Book Value 01")
            {
                Caption = 'Book Value 01';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 5605;
            }
            action("Book Value 02")
            {
                Caption = 'Book Value 02';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 5606;
            }
            action(Analysis)
            {
                Caption = 'Analysis';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 5600;
            }
            action("Projected Value")
            {
                Caption = 'Projected Value';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 5607;
            }
            action("G/L Analysis")
            {
                Caption = 'G/L Analysis';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 5610;
            }
            action(Register)
            {
                Caption = 'Register';
                Image = Confirm;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 5603;
            }
        }
    }
}

