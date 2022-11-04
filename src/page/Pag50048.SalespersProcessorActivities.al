page 50048 "Salespers Processor Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Sales Cue";

    layout
    {
        area(content)
        {
            cuegroup("For Release")
            {
                Caption = 'For Release';
                field("Sales Quotes Salesperson-Open"; "BC6_Sales Quotes Salesperson-Open")
                {
                    DrillDownPageID = "Sales Quotes";
                }
                field("Sales Orders Salesperson- Open"; "BC6_Sales Orders Salesperson- Open")
                {
                    DrillDownPageID = "Sales Order List";
                }

                actions
                {
                    action("New Sales Quote")
                    {
                        Caption = 'New Sales Quote';
                        Image = Quote;
                        RunObject = Page "Sales Quote";
                        RunPageMode = Create;
                    }
                    action("New Sales Order")
                    {
                        Caption = 'New Sales Order';
                        RunObject = Page "Sales Order";
                        RunPageMode = Create;
                    }
                }
            }
            cuegroup("Sales Orders Released Not Shipped")
            {
                Caption = 'Sales Orders Released Not Shipped';
                field("Ready to Ship Salesperson"; "BC6_Ready to Ship Salesperson")
                {
                    DrillDownPageID = "Sales Order List";
                }
                field("Partially Shipped Salesperson"; "BC6_Partially Shipped Salesperson")
                {
                    DrillDownPageID = "Sales Order List";
                }
                field("Delayed Salesperson"; "BC6_Delayed Salesperson")
                {
                    DrillDownPageID = "Sales Order List";
                }

                actions
                {
                    action(Navigate)
                    {
                        Caption = 'Navigate';
                        Image = Navigate;
                        RunObject = Page Navigate;
                    }
                }
            }
            cuegroup(Returns)
            {
                Caption = 'Returns';
                field("Sales Return Orders Salesperso"; "BC6_Sales Return Orders Salesperso")
                {
                    DrillDownPageID = "Sales Return Order List";
                }

                actions
                {
                    action("New Sales Return Order")
                    {
                        Caption = 'New Sales Return Order';
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
        RESET();
        IF NOT GET() THEN BEGIN
            INIT();
            INSERT();
        END;

        SetRespCenterFilter();
        SETRANGE("Date Filter", 0D, WORKDATE() - 1);
        SETFILTER("Date Filter2", '>=%1', WORKDATE());

        IF NOT RecGUserSetup.GET(USERID) THEN
            RecGUserSetup.INIT();
        IF RecGUserSetup."BC6_Limited User" THEN
            SETFILTER("BC6_Salesperson Filter", '*' + RecGUserSetup."Salespers./Purch. Code" + '*');
    end;

    var
        RecGUserSetup: Record "User Setup";
}

