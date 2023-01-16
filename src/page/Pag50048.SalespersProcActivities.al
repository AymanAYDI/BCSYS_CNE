page 50048 "BC6_Salespers Proc Activities"
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
                    ApplicationArea = All;
                    DrillDownPageID = "Sales Quotes";
                }
                field("Sales Orders Salesperson- Open"; Rec."BC6_Sales Ord Sales/per- Open")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Sales Order List";
                }

                actions
                {
                    action("New Sales Quote")
                    {
                        ApplicationArea = All;
                        Caption = 'New Sales Quote', Comment = 'FRA="Nouveau devis"';
                        Image = TileNew;
                        RunObject = Page "Sales Quote";
                        RunPageMode = Create;
                    }
                    action("New Sales Order")
                    {
                        ApplicationArea = All;
                        Caption = 'New Sales Order', Comment = 'FRA="Nouvelle commande vente"';
                        RunObject = Page "Sales Order";
                        RunPageMode = Create;
                    }
                }
            }
            cuegroup("Sales Orders Released Not Shipped")
            {
                Caption = 'Sales Orders Released Not Shipped', Comment = 'FRA="Commandes vente lancées et non livrées"';
                field("Ready to Ship Salesperson"; Rec."BC6_Ready to Ship Salesperson")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Sales Order List";
                }
                field("Partially Shipped Salesperson"; Rec."BC6_Partially Ship. Sales/per")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Sales Order List";
                }
                field("Delayed Salesperson"; Rec."BC6_Delayed Salesperson")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Sales Order List";
                }

                actions
                {
                    action(Navigate)
                    {
                        ApplicationArea = All;
                        Caption = 'Navigate', Comment = 'FRA="Naviguer"';
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
                    ApplicationArea = All;
                    DrillDownPageID = "Sales Return Order List";
                }

                actions
                {
                    action("New Sales Return Order")
                    {
                        ApplicationArea = All;
                        Caption = 'New Sales Return Order', Comment = 'FRA="Nouveau retour vente"';
                        RunObject = Page "Sales Return Order";
                        RunPageMode = Create;
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
