page 50081 "BC6_OneShot"
{
    Caption = 'Tools One Shot', Comment = 'FRA="Outils One-Shot"';
    ApplicationArea = All;
    PageType = NavigatePage;
    UsageCategory = Administration;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    LinksAllowed = false;
    layout
    {
        area(content)
        {
            grid(General)
            {
                ShowCaption = false;
                fixed(FixedPart)
                {
                    group("Group Caption")
                    {
                        ShowCaption = false;
                        field("Export Purchase Price"; 'Export Purchase Price')
                        {
                            Caption = 'Export Purchase Price', Comment = 'FRA="Export Tarifs fournisseurs"';
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Export Purchase Price");
                            end;
                        }
                        field("Import Purchase Price"; 'Import Purchase Price')
                        {
                            Caption = 'Import Purchase Price', Comment = 'FRA="Import Tarifs fournisseurs"';
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import Purchase Price");
                            end;
                        }
                        field("Import/Export Qty to order"; 'Import/Export Qty to order')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import/Export Qty to order");
                            end;
                        }
                        field("Import Plan Comptable"; 'Import Plan Comptable')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import Plan Comptable");
                            end;
                        }
                        field("Import Fiches Clients"; 'Import Fiches Clients')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import Fiches Clients");
                            end;
                        }
                        field("Import Adresses Livraison Clts"; 'Import Adresses Livraison Clts')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import Adr. Livraison Clts");
                            end;
                        }
                        field("Import R.I.B Clients"; 'Import R.I.B Clients')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import R.I.B Clients");
                            end;
                        }
                        field("Import Fiches Fourisseurs"; 'Import Fiches Fourisseurs')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import Fiches Fourisseurs");
                            end;
                        }
                        field("Import R.I.B Fournisseurs"; 'Import R.I.B Fournisseurs')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import R.I.B Fournisseurs");
                            end;
                        }
                        field("Import RIB Vendeur"; 'Import RIB Vendeur')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import RIB Vendeur");
                            end;
                        }
                        field("Reprise des articles et Prix"; 'Reprise des articles et Prix')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Reprise articles et Prix");
                            end;
                        }
                        field("Catalog Integration"; 'Catalog Integration')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Catalog Integration");
                            end;
                        }
                        field("Intégration catalogue2"; 'Intégration catalogue2')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Intégration catalogue2");
                            end;
                        }
                        field("Intégration catalogue"; 'Intégration catalogue')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Intégration catalogue");
                            end;
                        }
                        field("Import Bins"; 'Import Bins')
                        {
                            Caption = 'Import Bins', Comment = 'FRA="Import emplacements"';
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import Bins");
                            end;
                        }
                        field("Import Bin Contents"; 'Import Bin Contents')
                        {
                            Caption = 'Import Bin Contents', Comment = 'FRA="Import contenus emplacements"';
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import Bins");
                            end;
                        }
                        field("Import Av. Orders"; 'Import Av. Orders')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import Av. Orders");
                            end;
                        }
                        field("Import AdressesLivrasonClt T"; 'Import AdressesLivrasonClt T')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import AdresLivraisonCltT");
                            end;
                        }
                        field("Import R.I.BClients"; 'Import R.I.BClients')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import R.I.BClients");
                            end;
                        }
                        field("Import Fiches Fourisseurs Test"; 'Import Fiches Fourisseurs Test')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import Fiches Fouris Test");
                            end;
                        }
                        field("Import Client"; 'Import Client')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import Client");
                            end;
                        }
                        field("Import vendor"; 'Import vendor')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_import vendor");
                            end;
                        }
                        field("Import article"; 'Import article')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import article");
                            end;
                        }
                        field("Update Bill-To-Customer"; 'Update Bill-To-Customer')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Update Bill-To-Customer");
                            end;
                        }
                        field("Import Compta"; 'Import Compta')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import Compta");
                            end;
                        }
                        field("Import Stock"; 'Import Stock')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import Stock");
                            end;
                        }
                        field("Import Tiers"; 'Import Tiers')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import Tiers");
                            end;
                        }
                        field("Maj Noms Clients"; 'Maj Noms Clients')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Maj Noms Clients");
                            end;
                        }
                        field("Import/Export Source Code"; 'Import/Export Source Code')
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = true;
                            trigger OnDrillDown()
                            begin
                                Xmlport.Run(xmlport::"BC6_Import/Export Source Code");
                            end;
                        }




                    }
                }
            }
        }

    }
}