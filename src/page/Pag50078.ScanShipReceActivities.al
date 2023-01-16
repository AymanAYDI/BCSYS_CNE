page 50078 "BC6_Scan Ship Rece Activities"
{
    Caption = 'Activities', Comment = 'FRA="Activités"';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Warehouse Basic Cue";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            cuegroup("In Progress")
            {
                Caption = 'In Progress', Comment = 'FRA="En cours"';
                field("My Invt. Lines Until Today"; Rec."BC6_My Invt. Lines Until Today")
                {
                    ApplicationArea = All;
                    Caption = 'My Inventory Picks Until Today', Comment = 'FRA="Mes lignes Prélèvements stock à ce jour"';
                    ToolTip = 'Specifies the number of inventory picks that are displayed in the Warehouse Basic Cue on the Role Center. The documents are filtered by today''s date.', Comment = 'FRA="Spécifie le nombre de prélèvements stock qui sont affichés dans la pile Base entrepôt du tableau de bord. Les documents sont filtrés à la date du jour."';

                    trigger OnDrillDown()
                    begin
                        PAGE.RUN(PAGE::"BC6_Invt. Pick Card MiniForm");
                    end;
                }
                field("My Reclass. Lines Until Today"; Rec."BC6_My Rec.Lines Until Today")
                {
                    ApplicationArea = All;
                    Caption = 'My Inventory reclassment Until Today', Comment = 'FRA="Mes lignes reclassement stock à ce jour"';
                    ToolTip = 'Specifies the number of inventory put-always that are displayed in the Warehouse Basic Cue on the Role Center. The documents are filtered by today''s date.', Comment = 'FRA="Spécifie le nombre de rangements stock qui sont affichés dans la pile Base entrepôt du tableau de bord. Les documents sont filtrés à la date du jour."';

                    trigger OnDrillDown()
                    begin
                        PAGE.RUN(PAGE::"BC6_Reclass. Card MiniForm");
                    end;
                }
            }
            cuegroup("Internal Documents")
            {
                Caption = 'Internal Documents', Comment = 'FRA="Documents internes"';
                field("Upcoming Orders"; Rec."BC6_Upcoming Orders")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Purchase Order List";
                    ToolTip = 'Specifies the number of upcoming orders that are displayed in the Purchase Cue on the Role Center. The documents are filtered by today''s date.', Comment = 'FRA="Spécifie le nombre de commandes à venir qui sont affichées dans la pile Achat du tableau de bord. Les documents sont filtrés à la date du jour."';
                }
                field("Invt. Picks Until Today"; Rec."Invt. Picks Until Today")
                {
                    ApplicationArea = All;
                    Caption = 'Inventory Picks Until Today', Comment = 'FRA="Prélèvements stock à ce jour"';
                    DrillDownPageID = "Inventory Picks";
                    ToolTip = 'Specifies the number of inventory picks that are displayed in the Warehouse Basic Cue on the Role Center. The documents are filtered by today''s date.', Comment = 'FRA="Spécifie le nombre de prélèvements stock qui sont affichés dans la pile Base entrepôt du tableau de bord. Les documents sont filtrés à la date du jour."';
                }
                field("Invt. Put-aways Until Today"; Rec."Invt. Put-aways Until Today")
                {
                    ApplicationArea = All;
                    Caption = 'Inventory Put-aways Until Today', Comment = 'FRA="Rangements stock à ce jour"';
                    DrillDownPageID = "Inventory Put-aways";
                    ToolTip = 'Specifies the number of inventory put-always that are displayed in the Warehouse Basic Cue on the Role Center. The documents are filtered by today''s date.', Comment = 'FRA="Spécifie le nombre de rangements stock qui sont affichés dans la pile Base entrepôt du tableau de bord. Les documents sont filtrés à la date du jour."';
                }

                actions
                {
                    action("New Inventory Pick")
                    {
                        ApplicationArea = All;
                        Caption = 'New Inventory Pick', Comment = 'FRA="Nouveau prélèvement stock"';
                        Image = CreateInventoryPick;
                        RunObject = Page "Inventory Pick";
                        RunPageMode = Create;
                    }
                    action("New Inventory Put-away")
                    {
                        ApplicationArea = All;
                        Caption = 'New Inventory Put-away', Comment = 'FRA="Nouveau rangement stock"';
                        Image = Inventory;
                        RunObject = Page "Inventory Put-away";
                        RunPageMode = Create;
                    }
                    action("Edit Item Reclassification Journal")
                    {
                        ApplicationArea = All;
                        Caption = 'Edit Item Reclassification Journal', Comment = 'FRA="Modifier feuille reclassement article"';
                        Image = OpenWorksheet;
                        RunObject = Page "Item Reclass. Journal";
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

        Rec.SETRANGE("Date Filter", 0D, WORKDATE());
        Rec.SETRANGE("Date Filter2", WORKDATE(), WORKDATE());

        LocationCode := WhseWMSCue.GetEmployeeLocation(CopyStr(USERID, 1, 50));
        Rec.SETFILTER("Location Filter", LocationCode);

        OpenWithWhseEmployeeFilter(0);
        OpenWithWhseEmployeeFilter(1);
    end;

    var
        WhseWMSCue: Record "Warehouse WMS Cue";
        LocationCode: Text[1024];

    local procedure OpenWithWhseEmployeeFilter(WhichItemJnlLineList: Option Pick,Reclass): Boolean
    var
        InvSetup: Record "Inventory Setup";
        ItemBatchJnl: Record "Item Journal Batch";
        ItemJnlTemplate: Record "Item Journal Template";
        WhseEmployee: Record "Warehouse Employee";
    begin

        InvSetup.GET();
        CASE WhichItemJnlLineList OF
            WhichItemJnlLineList::Pick:
                BEGIN
                    ItemJnlTemplate.GET(InvSetup."BC6_Item Jnl Template Name 1");
                    Rec.SETFILTER("BC6_Jour. Template Name Fil. I", InvSetup."BC6_Item Jnl Template Name 1");
                END;

            WhichItemJnlLineList::Reclass:
                BEGIN
                    ItemJnlTemplate.GET(InvSetup."BC6_Item Jnl Template Name 2");
                    Rec.SETFILTER("BC6_Jour. Template Name Fil. R", InvSetup."BC6_Item Jnl Template Name 2");
                END;
        END;

        IF USERID <> '' THEN BEGIN
            WhseEmployee.SETRANGE("User ID", USERID);
            IF WhseEmployee.FindFirst() THEN BEGIN
                ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::Transfer);
                ItemBatchJnl.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
                ItemBatchJnl.SETRANGE("BC6_Assigned User ID", USERID);
                IF ItemBatchJnl.FindFirst() THEN;
            END;
        END;
        CASE WhichItemJnlLineList OF
            WhichItemJnlLineList::Pick:
                Rec.SETFILTER("BC6_Journ. Batch Name Fil. Inv", ItemBatchJnl.Name);
            WhichItemJnlLineList::Reclass:
                Rec.SETFILTER("BC6_Journ. Batch Name Fil. Rec", ItemBatchJnl.Name);
        END;
    end;
}
