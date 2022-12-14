page 50048 "Salespers Processor Activities"
{
    Caption = 'Activities', Comment = 'FRA="Activités"';
    PageType = CardPart;
    SourceTable = "Sales Cue";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            cuegroup("For Release")
            {
                Caption = 'For Release', Comment = 'FRA="À lancer"';
                field("Sales Quotes Salesperson-Open"; Rec."BC6_Sales Quot.Sales/per-Open")
                {
                    DrillDownPageID = "Sales Quotes";
                    ApplicationArea = All;
                }
                field("Sales Orders Salesperson- Open"; Rec."BC6_Sales Ord Sales/per- Open")
                {
                    DrillDownPageID = "Sales Order List";
                    ApplicationArea = All;
                }

                actions
                {
                    action("New Sales Quote")
                    {
                        Caption = 'New Sales Quote', Comment = 'FRA="Nouveau devis"';
                        Image = Quote;
                        RunObject = Page "Sales Quote";
                        RunPageMode = Create;
                        ApplicationArea = All;
                    }
                    action("New Sales Order")
                    {
                        Caption = 'New Sales Order', Comment = 'FRA="Nouvelle commande vente"';
                        RunObject = Page "Sales Order";
                        RunPageMode = Create;
                        ApplicationArea = All;
                        Image = order;
                    }
                }
            }
            cuegroup("Sales Orders Released Not Shipped")
            {
                Caption = 'Sales Orders Released Not Shipped', Comment = 'FRA="Commandes vente lancées et non livrées"';
                field("Ready to Ship Salesperson"; Rec."BC6_Ready to Ship Salesperson")
                {
                    DrillDownPageID = "Sales Order List";
                    ApplicationArea = All;
                }
                field("Partially Shipped Salesperson"; Rec."BC6_Partially Ship. Sales/per")
                {
                    DrillDownPageID = "Sales Order List";
                    ApplicationArea = All;
                }
                field("Delayed Salesperson"; Rec."BC6_Delayed Salesperson")
                {
                    DrillDownPageID = "Sales Order List";
                    ApplicationArea = All;
                }

                actions
                {
                    action(Navigate)
                    {
                        Caption = 'Navigate', Comment = 'FRA="Naviguer"';
                        ApplicationArea = All;
                        Image = Navigate;
                        RunObject = Page Navigate;
                    }
                }
            }
            cuegroup(Returns)
            {
                Caption = 'Returns', Comment = 'FRA="Retours"';
                field("Sales Return Orders Salesperso"; Rec."BC6_Sales Ret. Ord. Sales/per")
                {
                    DrillDownPageID = "Sales Return Order List";
                    ApplicationArea = All;
                }

                actions
                {
                    action("New Sales Return Order")
                    {
                        Caption = 'New Sales Return Order', Comment = 'FRA="Nouveau retour vente"';
                        RunObject = Page "Sales Return Order";
                        RunPageMode = Create;
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.RESET();
        IF NOT Rec.GET() THEN BEGIN
            Rec.INIT();
            Rec.INSERT();
        END;

        Rec.SetRespCenterFilter();
        Rec.SETRANGE("Date Filter", 0D, WORKDATE() - 1);
        Rec.SETFILTER("Date Filter2", '>=%1', WORKDATE());

        IF NOT RecGUserSetup.GET(USERID) THEN
            RecGUserSetup.INIT();
        IF RecGUserSetup."BC6_Limited User" THEN
            Rec.SETFILTER("BC6_Salesperson Filter", '*' + RecGUserSetup."Salespers./Purch. Code" + '*');
    end;

    var
        RecGUserSetup: Record "User Setup";
}

