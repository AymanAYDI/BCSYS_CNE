page 50020 "BC6_Customer Profit"
{
    Caption = 'Customer Profit', Comment = 'FRA="Marge Client"';
    PageType = List;
    SourceTable = "Customer Sales Profit Group";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
