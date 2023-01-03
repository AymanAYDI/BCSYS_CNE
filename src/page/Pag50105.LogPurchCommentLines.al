page 50105 "BC6_Log Purch. Comment Lines"
{
    AutoSplitKey = true;
    Caption = 'Receipt related information', comment = 'FRA=" Informations connexes de réception"';
    DataCaptionFields = "Document Type", "No.", "BC6_Is Log";
    DelayedInsert = true;
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    PopulateAllFields = true;
    ShowFilter = false;
    SourceTable = "Purch. Comment Line";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Comment; Comment)
                {
                }
                field("User ID"; "BC6_User ID")
                {
                }
                field("Log Date"; "BC6_Log Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

