page 9021 "RapidStart Services RC"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group()
            {
                part(Activities; 9075)
                {
                    Caption = 'Activities';
                }
                part("Configuration Areas"; 8631)
                {
                    Caption = 'Configuration Areas';
                    SubPageView = SORTING (Vertical Sorting);
                }
                part("Company Picture"; 50099)
                {
                    Caption = 'Company Picture';
                }
            }
            group()
            {
                systempart(; MyNotes)
                {
                }
                systempart(; Links)
                {
                }
            }
        }
    }

    actions
    {
        area(embedding)
        {
            group("RapidStart Services")
            {
                Caption = 'RapidStart Services';
                action(Worksheet)
                {
                    Caption = 'Worksheet';
                    RunObject = Page 8632;
                }
                action(Packages)
                {
                    Caption = 'Packages';
                    RunObject = Page 8615;
                }
                action(Tables)
                {
                    Caption = 'Tables';
                    RunObject = Page 8630;
                }
                action(Questionnaires)
                {
                    Caption = 'Questionnaires';
                    RunObject = Page 8610;
                }
                action(Templates)
                {
                    Caption = 'Templates';
                    RunObject = Page 8620;
                }
            }
        }
        area(processing)
        {
            group("Actions")
            {
                Caption = 'Actions';
                action("RapidStart Services Wizard")
                {
                    Caption = 'RapidStart Services Wizard';
                    Image = Questionaire;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 8629;
                }
                action("Configuration Worksheet")
                {
                    Caption = 'Configuration Worksheet';
                    Ellipsis = true;
                    Image = SetupLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 8632;
                }
                action("Complete Setup")
                {
                    Caption = 'Complete Setup';
                    Image = Completed;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 8638;
                }
            }
        }
    }
}

