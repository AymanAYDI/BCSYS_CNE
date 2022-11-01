page 50048 "Salespers Processor Activities"
{
    // ---------------------------------------------------------------
    //  Prodware - www.prodware.fr
    // ---------------------------------------------------------------
    // 
    // //>>CNE7.01
    // //>>P24233_001 SOBI APA 02/02/17
    //                     Create

    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = Table9053;

    layout
    {
        area(content)
        {
            cuegroup("For Release")
            {
                Caption = 'For Release';
                field("Sales Quotes Salesperson-Open"; "Sales Quotes Salesperson-Open")
                {
                    DrillDownPageID = "Sales Quotes";
                }
                field("Sales Orders Salesperson- Open"; "Sales Orders Salesperson- Open")
                {
                    DrillDownPageID = "Sales Order List";
                }

                actions
                {
                    action("New Sales Quote")
                    {
                        Caption = 'New Sales Quote';
                        Image = Quote;
                        RunObject = Page 41;
                        RunPageMode = Create;
                    }
                    action("New Sales Order")
                    {
                        Caption = 'New Sales Order';
                        RunObject = Page 42;
                        RunPageMode = Create;
                    }
                }
            }
            cuegroup("Sales Orders Released Not Shipped")
            {
                Caption = 'Sales Orders Released Not Shipped';
                field("Ready to Ship Salesperson"; "Ready to Ship Salesperson")
                {
                    DrillDownPageID = "Sales Order List";
                }
                field("Partially Shipped Salesperson"; "Partially Shipped Salesperson")
                {
                    DrillDownPageID = "Sales Order List";
                }
                field("Delayed Salesperson"; "Delayed Salesperson")
                {
                    DrillDownPageID = "Sales Order List";
                }

                actions
                {
                    action(Navigate)
                    {
                        Caption = 'Navigate';
                        Image = Navigate;
                        RunObject = Page 344;
                    }
                }
            }
            cuegroup(Returns)
            {
                Caption = 'Returns';
                field("Sales Return Orders Salesperso"; "Sales Return Orders Salesperso")
                {
                    DrillDownPageID = "Sales Return Order List";
                }

                actions
                {
                    action("New Sales Return Order")
                    {
                        Caption = 'New Sales Return Order';
                        RunObject = Page 6630;
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
        RESET;
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;

        SetRespCenterFilter;
        SETRANGE("Date Filter", 0D, WORKDATE - 1);
        SETFILTER("Date Filter2", '>=%1', WORKDATE);

        IF NOT RecGUserSetup.GET(USERID) THEN
            RecGUserSetup.INIT;
        IF RecGUserSetup."Limited User" THEN
            SETFILTER("Salesperson Filter", '*' + RecGUserSetup."Salespers./Purch. Code" + '*');
    end;

    var
        RecGUserSetup: Record "91";
}

