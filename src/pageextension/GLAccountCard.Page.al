page 17 "G/L Account Card"
{
    // MODIF JX-XAD du 25/08/2008
    // Ajout de 5 champs liés à IRIS Finance. Ces champs sont utilisés dans le dataport de génération des écritures compta pour IRIS ainsi
    // que dans le report de synthèse de TVA fournisseurs.
    // 
    // //Ajout JX-XAD le 03/04/2009
    // //Ajout de la fonction "Dupliquer" dans le menu Compte
    // 
    // ---------------------------- V1.2 ----------------------------
    // 
    // //MODIF JX-XAD 15/06/2010 (fait le 15/10/2010 dans Nav 2009)
    // //Modification suite à l'ajout de la duplication de la fiche bancaire
    // 
    // //MODIF JX-AUD 08/04/2011
    // //Limitation du champ No. dur formulaire à 8 caractères
    // 
    // MODIF JX-PBD du 04/03/15 Migration 2015 => Suppression des champs iris et rubrique

    Caption = 'G/L Account Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Table15;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Importance = Promoted;
                }
                field(Name; Name)
                {
                    Importance = Promoted;
                }
                field("Income/Balance"; "Income/Balance")
                {
                    Importance = Promoted;
                }
                field("Debit/Credit"; "Debit/Credit")
                {
                }
                field("Account Type"; "Account Type")
                {
                }
                field(Totaling; Totaling)
                {

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        GLAccountList: Page "18";
                        OldText: Text;
                    begin
                        OldText := Text;
                        GLAccountList.LOOKUPMODE(TRUE);
                        IF NOT (GLAccountList.RUNMODAL = ACTION::LookupOK) THEN
                            EXIT(FALSE);

                        Text := OldText + GLAccountList.GetSelectionFilter;
                        EXIT(TRUE);
                    end;
                }
                field("No. of Blank Lines"; "No. of Blank Lines")
                {
                }
                field("New Page"; "New Page")
                {
                }
                field("Search Name"; "Search Name")
                {
                }
                field(Balance; Balance)
                {
                    Importance = Promoted;
                }
                field("Reconciliation Account"; "Reconciliation Account")
                {
                }
                field("Automatic Ext. Texts"; "Automatic Ext. Texts")
                {
                }
                field("Direct Posting"; "Direct Posting")
                {
                }
                field(Blocked; Blocked)
                {
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                }
                field("Omit Default Descr. in Jnl."; "Omit Default Descr. in Jnl.")
                {
                }
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Gen. Posting Type"; "Gen. Posting Type")
                {
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    Importance = Promoted;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    Importance = Promoted;
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    Importance = Promoted;
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                    Importance = Promoted;
                }
                field("Default IC Partner G/L Acc. No"; "Default IC Partner G/L Acc. No")
                {
                }
            }
            group(Consolidation)
            {
                Caption = 'Consolidation';
                field("Consol. Debit Acc."; "Consol. Debit Acc.")
                {
                    Importance = Promoted;
                }
                field("Consol. Credit Acc."; "Consol. Credit Acc.")
                {
                    Importance = Promoted;
                }
                field("Consol. Translation Method"; "Consol. Translation Method")
                {
                    Importance = Promoted;
                }
            }
            group(Reporting)
            {
                Caption = 'Reporting';
                field("Exchange Rate Adjustment"; "Exchange Rate Adjustment")
                {
                    Importance = Promoted;
                }
            }
            group("Cost Accounting")
            {
                Caption = 'Cost Accounting';
                field("Cost Type No."; "Cost Type No.")
                {
                    Importance = Promoted;
                }
            }
        }
        area(factboxes)
        {
            part(; 9083)
            {
                SubPageLink = Table ID=CONST(15),No.=FIELD(No.);
                    Visible = false;
            }
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
            group("A&ccount")
            {
                Caption = 'A&ccount';
                Image = ChartOfAccounts;
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    Image = GLRegisters;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page 20;
                    RunPageLink = G/L Account No.=FIELD(No.);
                    RunPageView = SORTING(G/L Account No.);
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 124;
                                    RunPageLink = Table Name=CONST(G/L Account),No.=FIELD(No.);
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page 540;
                                    RunPageLink = Table ID=CONST(15),No.=FIELD(No.);
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                action("E&xtended Texts")
                {
                    Caption = 'E&xtended Texts';
                    Image = Text;
                    RunObject = Page 391;
                                    RunPageLink = Table Name=CONST(G/L Account),No.=FIELD(No.);
                    RunPageView = SORTING(Table Name,No.,Language Code,All Language Codes,Starting Date,Ending Date);
                }
                action("Receivables-Payables")
                {
                    Caption = 'Receivables-Payables';
                    Image = ReceivablesPayables;
                    RunObject = Page 159;
                }
                action("Where-Used List")
                {
                    Caption = 'Where-Used List';
                    Image = Track;

                    trigger OnAction()
                    var
                        CalcGLAccWhereUsed: Codeunit "100";
                    begin
                        CalcGLAccWhereUsed.CheckGLAcc("No.");
                    end;
                }
                action("Apply Entries")
                {
                    Caption = 'Apply Entries';
                    Image = ApplyEntries;
                    RunObject = Page 10842;
                                    RunPageLink = G/L Account No.=FIELD(No.);
                    ShortCutKey = 'Shift+F11';
                }
                separator()
                {
                }
                action("Duplicate to another company")
                {
                    Caption = 'Duplicate to another company';
                    Image = CopyFromChartOfAccounts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //DEBUT MODIF JX-XAD 03/04/2009

                        //DEBUT MODIF JX-XAD le 15/06/2010
                        //GForm_Dupliquer.initialiser(Gopt_TypeFiche::"G/L Account","No.");
                        GForm_Dupliquer.initialiser(Gopt_TypeFiche::"G/L Account","No.",'');

                        //FIN MODIF JX-XAD le 15/06/2010

                        GForm_Dupliquer.RUNMODAL;
                        CLEAR(GForm_Dupliquer);
                        //FIN MODIF JX-XAD 03/04/2009
                    end;
                }
            }
            group("&Balance")
            {
                Caption = '&Balance';
                Image = Balance;
                action("G/L &Account Balance")
                {
                    Caption = 'G/L &Account Balance';
                    Image = GLAccountBalance;
                    RunObject = Page 415;
                                    RunPageLink = No.=FIELD(No.),Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),Business Unit Filter=FIELD(Business Unit Filter);
                }
                action("G/L &Balance")
                {
                    Caption = 'G/L &Balance';
                    Image = GLBalance;
                    RunObject = Page 414;
                                    RunPageOnRec = true;
                }
                action("G/L Balance by &Dimension")
                {
                    Caption = 'G/L Balance by &Dimension';
                    Image = GLBalanceDimension;
                    RunObject = Page 408;
                }
            }
            action("General Posting Setup")
            {
                Caption = 'General Posting Setup';
                Image = GeneralPostingSetup;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 314;
            }
            action("VAT Posting Setup")
            {
                Caption = 'VAT Posting Setup';
                Image = VATPostingSetup;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 472;
            }
            action("G/L Register")
            {
                Caption = 'G/L Register';
                Image = GLRegisters;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 116;
            }
        }
        area(reporting)
        {
            action("Detail Trial Balance")
            {
                Caption = 'Detail Trial Balance';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 4;
            }
            action("Trial Balance")
            {
                Caption = 'Trial Balance';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 6;
            }
            action("Trial Balance by Period")
            {
                Caption = 'Trial Balance by Period';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 38;
            }
            action("G/L Register")
            {
                Caption = 'G/L Register';
                Image = GLRegisters;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 3;
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Apply Template")
                {
                    Caption = 'Apply Template';
                    Ellipsis = true;
                    Image = ApplyTemplate;

                    trigger OnAction()
                    var
                        ConfigTemplateMgt: Codeunit "8612";
                        RecRef: RecordRef;
                    begin
                        RecRef.GETTABLE(Rec);
                        ConfigTemplateMgt.UpdateFromTemplateSelection(RecRef);
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetupNewGLAcc(xRec,BelowxRec);
    end;

    var
        GForm_Dupliquer: Page "50013";
                             Gopt_TypeFiche: Option ,Vendor,"G/L Account",Item,VendorBankAccount;
}

