page 50078 "Scan Ship & Receive Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = Table9050;

    layout
    {
        area(content)
        {
            cuegroup("In Progress")
            {
                Caption = 'In Progress';
                field("My Invt. Lines Until Today"; "My Invt. Lines Until Today")
                {
                    Caption = 'My Inventory Picks Until Today';
                    ToolTip = 'Specifies the number of inventory picks that are displayed in the Warehouse Basic Cue on the Role Center. The documents are filtered by today''s date.';

                    trigger OnDrillDown()
                    begin
                        PAGE.RUN(PAGE::"Invt. Pick Card MiniForm");
                    end;
                }
                field("My Reclass. Lines Until Today"; "My Reclass. Lines Until Today")
                {
                    Caption = 'My Inventory reclassment Until Today';
                    ToolTip = 'Specifies the number of inventory put-always that are displayed in the Warehouse Basic Cue on the Role Center. The documents are filtered by today''s date.';

                    trigger OnDrillDown()
                    begin
                        PAGE.RUN(PAGE::"Reclass. Card MiniForm");
                    end;
                }
            }
            cuegroup("Internal Documents")
            {
                Caption = 'Internal Documents';
                field("Upcoming Orders"; "Upcoming Orders")
                {
                    DrillDownPageID = "Purchase Order List";
                    ToolTip = 'Specifies the number of upcoming orders that are displayed in the Purchase Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Invt. Picks Until Today"; "Invt. Picks Until Today")
                {
                    Caption = 'Inventory Picks Until Today';
                    DrillDownPageID = "Inventory Picks";
                    ToolTip = 'Specifies the number of inventory picks that are displayed in the Warehouse Basic Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Invt. Put-aways Until Today"; "Invt. Put-aways Until Today")
                {
                    Caption = 'Inventory Put-aways Until Today';
                    DrillDownPageID = "Inventory Put-aways";
                    ToolTip = 'Specifies the number of inventory put-always that are displayed in the Warehouse Basic Cue on the Role Center. The documents are filtered by today''s date.';
                }

                actions
                {
                    action("New Inventory Pick")
                    {
                        Caption = 'New Inventory Pick';
                        RunObject = Page 7377;
                        RunPageMode = Create;
                    }
                    action("New Inventory Put-away")
                    {
                        Caption = 'New Inventory Put-away';
                        RunObject = Page 7375;
                        RunPageMode = Create;
                    }
                    action("Edit Item Reclassification Journal")
                    {
                        Caption = 'Edit Item Reclassification Journal';
                        Image = OpenWorksheet;
                        RunObject = Page 393;
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

        SETRANGE("Date Filter", 0D, WORKDATE);
        SETRANGE("Date Filter2", WORKDATE, WORKDATE);

        LocationCode := WhseWMSCue.GetEmployeeLocation(USERID);
        SETFILTER("Location Filter", LocationCode);

        OpenWithWhseEmployeeFilter(0);
        OpenWithWhseEmployeeFilter(1);
    end;

    var
        WhseWMSCue: Record "9051";
        LocationCode: Text[1024];

    local procedure OpenWithWhseEmployeeFilter(WhichItemJnlLineList: Option Pick,Reclass): Boolean
    var
        WhseEmployee: Record "7301";
        WmsManagement: Codeunit "7302";
        CurrentLocationCode: Code[10];
        InvSetup: Record "313";
        DefaultLocationCode: Code[20];
        ItemJnlTemplate: Record "82";
        ItemBatchJnl: Record "233";
        BatchName: Code[20];
    begin

        InvSetup.GET;
        CASE WhichItemJnlLineList OF
            WhichItemJnlLineList::Pick:
                BEGIN
                    ItemJnlTemplate.GET(InvSetup."Item Jnl Template Name 1");
                    SETFILTER("Journal Template Name Filter I", InvSetup."Item Jnl Template Name 1");
                END;

            WhichItemJnlLineList::Reclass:
                BEGIN
                    ItemJnlTemplate.GET(InvSetup."Item Jnl Template Name 2");
                    SETFILTER("Journal Template Name Filter R", InvSetup."Item Jnl Template Name 2");
                END;
        END;

        IF USERID <> '' THEN BEGIN
            WhseEmployee.SETRANGE("User ID", USERID);
            IF WhseEmployee.FIND('-') THEN BEGIN
                ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::Transfer);
                ItemBatchJnl.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
                ItemBatchJnl.SETRANGE("Assigned User ID", USERID);
                IF ItemBatchJnl.FIND('-') THEN;
            END;
        END;
        CASE WhichItemJnlLineList OF
            WhichItemJnlLineList::Pick:
                SETFILTER("Journal Batch Name Filter Inv", ItemBatchJnl.Name);
            WhichItemJnlLineList::Reclass:
                SETFILTER("Journal Batch Name Filter Rec", ItemBatchJnl.Name);
        END;
    end;
}

