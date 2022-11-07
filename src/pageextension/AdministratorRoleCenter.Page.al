page 9018 "Administrator Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group()
            {
                part(; 9072)
                {
                }
                part("Company Picture"; 50099)
                {
                    Caption = 'Company Picture';
                }
            }
            group()
            {
                part(; 681)
                {
                }
                part(; 675)
                {
                    Visible = false;
                }
                part(; 9175)
                {
                }
                systempart(; MyNotes)
                {
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Check on Ne&gative Inventory")
            {
                Caption = 'Check on Ne&gative Inventory';
                Image = "Report";
                RunObject = Report 5757;
            }
        }
        area(embedding)
        {
            action("Job Queue Entries")
            {
                Caption = 'Job Queue Entries';
                RunObject = Page 672;
            }
            action("User Setup")
            {
                Caption = 'User Setup';
                Image = UserSetup;
                RunObject = Page 119;
            }
            action("No. Series")
            {
                Caption = 'No. Series';
                RunObject = Page 456;
            }
            action("Approval User Setup")
            {
                Caption = 'Approval User Setup';
                RunObject = Page 663;
            }
            action("Approval Templates")
            {
                Caption = 'Approval Templates';
                RunObject = Page 668;
            }
            action("Data Templates List")
            {
                Caption = 'Data Templates List';
                RunObject = Page 8620;
            }
            action("Base Calendar List")
            {
                Caption = 'Base Calendar List';
                RunObject = Page 7601;
            }
            action("Post Codes")
            {
                Caption = 'Post Codes';
                RunObject = Page 367;
            }
            action("Reason Codes")
            {
                Caption = 'Reason Codes';
                RunObject = Page 259;
            }
            action("Extended Text")
            {
                Caption = 'Extended Text';
                RunObject = Page 391;
            }
        }
        area(sections)
        {
            group("Job Queue")
            {
                Caption = 'Job Queue';
                Image = CheckList;
                action("Job Queue Entries")
                {
                    Caption = 'Job Queue Entries';
                    RunObject = Page 672;
                }
                action("Job Queue Category List")
                {
                    Caption = 'Job Queue Category List';
                    RunObject = Page 671;
                }
                action("Job Queue Log Entries")
                {
                    Caption = 'Job Queue Log Entries';
                    RunObject = Page 674;
                }
            }
            group(Intrastat)
            {
                Caption = 'Intrastat';
                Image = Intrastat;
                action("Tariff Numbers")
                {
                    Caption = 'Tariff Numbers';
                    RunObject = Page 310;
                }
                action("Transaction Types")
                {
                    Caption = 'Transaction Types';
                    RunObject = Page 308;
                }
                action("Transaction Specifications")
                {
                    Caption = 'Transaction Specifications';
                    RunObject = Page 406;
                }
                action("Transport Methods")
                {
                    Caption = 'Transport Methods';
                    RunObject = Page 309;
                }
                action("Entry/Exit Points")
                {
                    Caption = 'Entry/Exit Points';
                    RunObject = Page 394;
                }
                action(Areas)
                {
                    Caption = 'Areas';
                    RunObject = Page 405;
                }
            }
            group(Finance)
            {
                Caption = 'Finance';
                Image = Bank;
                action("VAT Registration No. Formats")
                {
                    Caption = 'VAT Registration No. Formats';
                    RunObject = Page 575;
                }
            }
            group("Analysis View")
            {
                Caption = 'Analysis View';
                Image = AnalysisView;
                action("Sales Analysis View List")
                {
                    Caption = 'Sales Analysis View List';
                    RunObject = Page 9371;
                }
                action("Purchase Analysis View List")
                {
                    Caption = 'Purchase Analysis View List';
                    RunObject = Page 9370;
                }
                action("Inventory Analysis View List")
                {
                    Caption = 'Inventory Analysis View List';
                    RunObject = Page 9372;
                }
            }
        }
        area(creation)
        {
            action("Purchase &Order")
            {
                Caption = 'Purchase &Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 50;
                RunPageMode = Create;
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("Com&pany Information")
            {
                Caption = 'Com&pany Information';
                Image = CompanyInformation;
                RunObject = Page 1;
            }
            action("&Manage Style Sheets")
            {
                Caption = '&Manage Style Sheets';
                Image = StyleSheet;
                RunObject = Page 697;
            }
            action("Migration O&verview")
            {
                Caption = 'Migration O&verview';
                Image = Migration;
                RunObject = Page 8614;
            }
            action("Relocate &Attachments")
            {
                Caption = 'Relocate &Attachments';
                Image = ChangeTo;
                RunObject = Report 5181;
            }
            action("Create Warehouse &Location")
            {
                Caption = 'Create Warehouse &Location';
                Image = NewWarehouse;
                RunObject = Report 5756;
            }
            action("C&hange Log Setup")
            {
                Caption = 'C&hange Log Setup';
                Image = LogSetup;
                RunObject = Page 592;
            }
            separator()
            {
            }
            group("&Change Setup")
            {
                Caption = '&Change Setup';
                Image = Setup;
                action("Setup &Questionnaire")
                {
                    Caption = 'Setup &Questionnaire';
                    Image = QuestionaireSetup;
                    RunObject = Page 8610;
                }
                action("&General Ledger Setup")
                {
                    Caption = '&General Ledger Setup';
                    Image = Setup;
                    RunObject = Page 118;
                }
                action("Sales && Re&ceivables Setup")
                {
                    Caption = 'Sales && Re&ceivables Setup';
                    Image = Setup;
                    RunObject = Page 459;
                }
                action("Purchase && &Payables Setup")
                {
                    Caption = 'Purchase && &Payables Setup';
                    Image = ReceivablesPayablesSetup;
                    RunObject = Page 460;
                }
                action("Fixed &Asset Setup")
                {
                    Caption = 'Fixed &Asset Setup';
                    Image = Setup;
                    RunObject = Page 5607;
                }
                action("Mar&keting Setup")
                {
                    Caption = 'Mar&keting Setup';
                    Image = MarketingSetup;
                    RunObject = Page 5094;
                }
                action("Or&der Promising Setup")
                {
                    Caption = 'Or&der Promising Setup';
                    Image = OrderPromisingSetup;
                    RunObject = Page 99000958;
                }
                action("Nonstock &Item Setup")
                {
                    Caption = 'Nonstock &Item Setup';
                    Image = NonStockItemSetup;
                    RunObject = Page 5732;
                }
                action("Interaction &Template Setup")
                {
                    Caption = 'Interaction &Template Setup';
                    Image = InteractionTemplateSetup;
                    RunObject = Page 5186;
                }
                action("Inve&ntory Setup")
                {
                    Caption = 'Inve&ntory Setup';
                    Image = InventorySetup;
                    RunObject = Page 461;
                }
                action("&Warehouse Setup")
                {
                    Caption = '&Warehouse Setup';
                    Image = WarehouseSetup;
                    RunObject = Page 5775;
                }
                action("Mini&forms")
                {
                    Caption = 'Mini&forms';
                    Image = MiniForm;
                    RunObject = Page 7703;
                }
                action("Man&ufacturing Setup")
                {
                    Caption = 'Man&ufacturing Setup';
                    Image = ProductionSetup;
                    RunObject = Page 99000768;
                }
                action("Res&ources Setup")
                {
                    Caption = 'Res&ources Setup';
                    Image = ResourceSetup;
                    RunObject = Page 462;
                }
                action("&Service Setup")
                {
                    Caption = '&Service Setup';
                    Image = ServiceSetup;
                    RunObject = Page 5919;
                }
                action("&Human Resource Setup")
                {
                    Caption = '&Human Resource Setup';
                    Image = HRSetup;
                    RunObject = Page 5233;
                }
                action("&Service Order Status Setup")
                {
                    Caption = '&Service Order Status Setup';
                    Image = ServiceOrderSetup;
                    RunObject = Page 5943;
                }
                action("&Repair Status Setup")
                {
                    Caption = '&Repair Status Setup';
                    Image = ServiceSetup;
                    RunObject = Page 5941;
                }
                action("C&hange Log Setup")
                {
                    Caption = 'C&hange Log Setup';
                    Image = LogSetup;
                    RunObject = Page 592;
                }
                action("&MapPoint Setup")
                {
                    Caption = '&MapPoint Setup';
                    Image = MapSetup;
                    RunObject = Page 800;
                }
                action("SMTP Mai&l Setup")
                {
                    Caption = 'SMTP Mai&l Setup';
                    Image = MailSetup;
                    RunObject = Page 409;
                }
                action("Job Qu&eue Setup")
                {
                    Caption = 'Job Qu&eue Setup';
                    Image = JobListSetup;
                    RunObject = Page 670;
                }
                action("Appro&val Setup")
                {
                    Caption = 'Appro&val Setup';
                    Image = ApprovalSetup;
                    RunObject = Page 656;
                }
                action("Profile Quest&ionnaire Setup")
                {
                    Caption = 'Profile Quest&ionnaire Setup';
                    Image = QuestionaireSetup;
                    RunObject = Page 5110;
                }
            }
            group("&Report Selection")
            {
                Caption = '&Report Selection';
                Image = SelectReport;
                action("Report Selection - &Bank Account")
                {
                    Caption = 'Report Selection - &Bank Account';
                    Image = SelectReport;
                    RunObject = Page 385;
                }
                action("Report Selection - &Reminder && Finance Charge")
                {
                    Caption = 'Report Selection - &Reminder && Finance Charge';
                    Image = SelectReport;
                    RunObject = Page 524;
                }
                action("Report Selection - &Sales")
                {
                    Caption = 'Report Selection - &Sales';
                    Image = SelectReport;
                    RunObject = Page 306;
                }
                action("Report Selection - &Purchase")
                {
                    Caption = 'Report Selection - &Purchase';
                    Image = SelectReport;
                    RunObject = Page 347;
                }
                action("Report Selection - &Inventory")
                {
                    Caption = 'Report Selection - &Inventory';
                    Image = SelectReport;
                    RunObject = Page 5754;
                }
                action("Report Selection - Prod. &Order")
                {
                    Caption = 'Report Selection - Prod. &Order';
                    Image = SelectReport;
                    RunObject = Page 99000917;
                }
                action("Report Selection - S&ervice")
                {
                    Caption = 'Report Selection - S&ervice';
                    Image = SelectReport;
                    RunObject = Page 5932;
                }
                action("Report Selection - Cash Flow")
                {
                    Caption = 'Report Selection - Cash Flow';
                    Image = SelectReport;
                    RunObject = Page 865;
                }
            }
            group("&Date Compression")
            {
                Caption = '&Date Compression';
                Image = Compress;
                action("Date Compress &G/L Entries")
                {
                    Caption = 'Date Compress &G/L Entries';
                    Image = GeneralLedger;
                    RunObject = Report 98;
                }
                action("Date Compress &VAT Entries")
                {
                    Caption = 'Date Compress &VAT Entries';
                    Image = VATStatement;
                    RunObject = Report 95;
                }
                action("Date Compress Bank &Account Ledger Entries")
                {
                    Caption = 'Date Compress Bank &Account Ledger Entries';
                    Image = BankAccount;
                    RunObject = Report 1498;
                }
                action("Date Compress G/L &Budget Entries")
                {
                    Caption = 'Date Compress G/L &Budget Entries';
                    Image = LedgerBudget;
                    RunObject = Report 97;
                }
                action("Date Compress &Customer Ledger Entries")
                {
                    Caption = 'Date Compress &Customer Ledger Entries';
                    Image = Customer;
                    RunObject = Report 198;
                }
                action("Date Compress V&endor Ledger Entries")
                {
                    Caption = 'Date Compress V&endor Ledger Entries';
                    Image = Vendor;
                    RunObject = Report 398;
                }
                action("Date Compress &Resource Ledger Entries")
                {
                    Caption = 'Date Compress &Resource Ledger Entries';
                    Image = Resource;
                    RunObject = Report 1198;
                }
                action("Date Compress &FA Ledger Entries")
                {
                    Caption = 'Date Compress &FA Ledger Entries';
                    Image = FixedAssets;
                    RunObject = Report 5696;
                }
                action("Date Compress &Maintenance Ledger Entries")
                {
                    Caption = 'Date Compress &Maintenance Ledger Entries';
                    Image = Tools;
                    RunObject = Report 5698;
                }
                action("Date Compress &Insurance Ledger Entries")
                {
                    Caption = 'Date Compress &Insurance Ledger Entries';
                    Image = Insurance;
                    RunObject = Report 5697;
                }
                action("Date Compress &Warehouse Entries")
                {
                    Caption = 'Date Compress &Warehouse Entries';
                    Image = Bin;
                    RunObject = Report 7398;
                }
            }
            separator()
            {
            }
            group("Con&tacts")
            {
                Caption = 'Con&tacts';
                Image = CustomerContact;
                action("Create Contacts from &Customer")
                {
                    Caption = 'Create Contacts from &Customer';
                    Image = CustomerContact;
                    RunObject = Report 5195;
                }
                action("Create Contacts from &Vendor")
                {
                    Caption = 'Create Contacts from &Vendor';
                    Image = VendorContact;
                    RunObject = Report 5194;
                }
                action("Create Contacts from &Bank Account")
                {
                    Caption = 'Create Contacts from &Bank Account';
                    Image = BankContact;
                    RunObject = Report 5193;
                }
                action("To-do &Activities")
                {
                    Caption = 'To-do &Activities';
                    Image = TaskList;
                    RunObject = Page 5101;
                }
            }
            separator()
            {
            }
            action("Service Trou&bleshooting")
            {
                Caption = 'Service Trou&bleshooting';
                Image = Troubleshoot;
                RunObject = Page 5990;
            }
            group("&Import")
            {
                Caption = '&Import';
                Image = Import;
                action("Import IRIS to &Area/Symptom Code")
                {
                    Caption = 'Import IRIS to &Area/Symptom Code';
                    Image = Import;
                    RunObject = XMLport 5900;
                }
                action("Import IRIS to &Fault Codes")
                {
                    Caption = 'Import IRIS to &Fault Codes';
                    Image = Import;
                    RunObject = XMLport 5901;
                }
                action("Import IRIS to &Resolution Codes")
                {
                    Caption = 'Import IRIS to &Resolution Codes';
                    Image = Import;
                    RunObject = XMLport 5902;
                }
            }
            separator()
            {
            }
            group("&Sales Analysis")
            {
                Caption = '&Sales Analysis';
                Image = Segment;
                action("Sales Analysis &Line Templates")
                {
                    Caption = 'Sales Analysis &Line Templates';
                    Image = SetupLines;
                    RunObject = Page 7112;
                    RunPageView = SORTING (Analysis Area, Name) WHERE (Analysis Area=CONST(Sales));
                }
                action("Sales Analysis &Column Templates")
                {
                    Caption = 'Sales Analysis &Column Templates';
                    Image = SetupColumns;
                    RunObject = Page 7113;
                    RunPageView = SORTING (Analysis Area, Name) WHERE (Analysis Area=CONST(Sales));
                }
            }
            group("P&urchase Analysis")
            {
                Caption = 'P&urchase Analysis';
                Image = Purchasing;
                action("Purchase &Analysis Line Templates")
                {
                    Caption = 'Purchase &Analysis Line Templates';
                    Image = SetupLines;
                    RunObject = Page 7112;
                    RunPageView = SORTING (Analysis Area, Name) WHERE (Analysis Area=CONST(Purchase));
                }
                action("Purchase Analysis &Column Templates")
                {
                    Caption = 'Purchase Analysis &Column Templates';
                    Image = SetupColumns;
                    RunObject = Page 7113;
                    RunPageView = SORTING (Analysis Area, Name) WHERE (Analysis Area=CONST(Purchase));
                }
            }
        }
    }
}

