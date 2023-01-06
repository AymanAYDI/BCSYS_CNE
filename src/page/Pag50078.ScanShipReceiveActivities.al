page 50078 "Scan Ship & Receive Activities"
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
                    Caption = 'My Inventory Picks Until Today', Comment = 'FRA="Mes lignes Prélèvements stock à ce jour"';
                    ToolTip = 'Specifies the number of inventory picks that are displayed in the Warehouse Basic Cue on the Role Center. The documents are filtered by today''s date.', Comment = 'FRA="Spécifie le nombre de prélèvements stock qui sont affichés dans la pile Base entrepôt du tableau de bord. Les documents sont filtrés à la date du jour."';
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        PAGE.RUN(PAGE::"BC6_Invt. Pick Card MiniForm");
                    end;
                }
                field("My Reclass. Lines Until Today"; Rec."BC6_My Rec.Lines Until Today")
                {
                    Caption = 'My Inventory reclassment Until Today', Comment = 'FRA="Mes lignes reclassement stock à ce jour"';
                    ToolTip = 'Specifies the number of inventory put-always that are displayed in the Warehouse Basic Cue on the Role Center. The documents are filtered by today''s date.', Comment = 'FRA="Spécifie le nombre de rangements stock qui sont affichés dans la pile Base entrepôt du tableau de bord. Les documents sont filtrés à la date du jour."';
                    ApplicationArea = All;

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
                    DrillDownPageID = "Purchase Order List";
                    ToolTip = 'Specifies the number of upcoming orders that are displayed in the Purchase Cue on the Role Center. The documents are filtered by today''s date.', Comment = 'FRA="Spécifie le nombre de commandes à venir qui sont affichées dans la pile Achat du tableau de bord. Les documents sont filtrés à la date du jour."';
                    ApplicationArea = All;
                }
                field("Invt. Picks Until Today"; Rec."Invt. Picks Until Today")
                {
                    Caption = 'Inventory Picks Until Today', Comment = 'FRA="Prélèvements stock à ce jour"';
                    DrillDownPageID = "Inventory Picks";
                    ToolTip = 'Specifies the number of inventory picks that are displayed in the Warehouse Basic Cue on the Role Center. The documents are filtered by today''s date.', Comment = 'FRA="Spécifie le nombre de prélèvements stock qui sont affichés dans la pile Base entrepôt du tableau de bord. Les documents sont filtrés à la date du jour."';
                    ApplicationArea = All;
                }
                field("Invt. Put-aways Until Today"; Rec."Invt. Put-aways Until Today")
                {
                    Caption = 'Inventory Put-aways Until Today', Comment = 'FRA="Rangements stock à ce jour"';
                    DrillDownPageID = "Inventory Put-aways";
                    ToolTip = 'Specifies the number of inventory put-always that are displayed in the Warehouse Basic Cue on the Role Center. The documents are filtered by today''s date.', Comment = 'FRA="Spécifie le nombre de rangements stock qui sont affichés dans la pile Base entrepôt du tableau de bord. Les documents sont filtrés à la date du jour."';
                    ApplicationArea = All;
                }

                actions
                {
                    action("New Inventory Pick")
                    {
                        Caption = 'New Inventory Pick', Comment = 'FRA="Nouveau prélèvement stock"';
                        RunObject = Page "Inventory Pick";
                        Image = CreateInventoryPick;
                        RunPageMode = Create;
                        ApplicationArea = All;
                    }
                    action("New Inventory Put-away")
                    {
                        Caption = 'New Inventory Put-away', Comment = 'FRA="Nouveau rangement stock"';
                        RunObject = Page "Inventory Put-away";
                        Image = Inventory;
                        RunPageMode = Create;
                        ApplicationArea = All;
                    }
                    action("Edit Item Reclassification Journal")
                    {
                        Caption = 'Edit Item Reclassification Journal', Comment = 'FRA="Modifier feuille reclassement article"';
                        Image = OpenWorksheet;
                        RunObject = Page "Item Reclass. Journal";
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

