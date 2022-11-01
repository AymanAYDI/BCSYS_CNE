page 50105 "Log Purch. Comment Lines"
{
    AutoSplitKey = true;
    Caption = 'Receipt related information';
    DataCaptionFields = "Document Type", "No.", "Is Log";
    DelayedInsert = true;
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    PopulateAllFields = true;
    ShowFilter = false;
    SourceTable = Table43;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Comment; Comment)
                {
                }
                field("User ID"; "User ID")
                {
                }
                field("Log Date"; "Log Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

