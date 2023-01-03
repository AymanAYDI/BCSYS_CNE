page 50080 "BC6_Item Journal Pick List"
{
    Caption = 'Picking Liste', Comment = 'FRA="Prélèvements"';
    CardPageID = "BC6_Invt. Pick Card MiniForm";
    Editable = false;
    PageType = List;
    SourceTable = "Item Journal Line";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; "Bin Code")
                {
                    ApplicationArea = All;
                }
                field("New Bin Code"; "New Bin Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Action1000000007>")
            {
                Caption = '&Post', Comment = 'FRA="&Valider"';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'F8';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PostBatch();
                    CurrPage.CLOSE();
                end;
            }
            action(ClearAll)
            {
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    DELETEALL(TRUE);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        OpenWithWhseEmployee()
    end;

    var
        Text015: Label 'User %1 model sheet does not exist', Comment = 'FRA="Pas de nom de feuille article utilisateur %1"';

    procedure OpenWithWhseEmployee(): Boolean
    var
        InvSetup: Record "Inventory Setup";
        ItemBatchJnl: Record "Item Journal Batch";
        ItemJnlTemplate: Record "Item Journal Template";
    begin

        InvSetup.GET();
        InvSetup.TESTFIELD("BC6_Item Jnl Template Name 1");

        IF USERID <> '' THEN BEGIN
            ItemJnlTemplate.GET(InvSetup."BC6_Item Jnl Template Name 1");
            ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::Transfer);
            ItemBatchJnl.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
            ItemBatchJnl.SETRANGE("BC6_Assigned User ID", USERID);
#pragma warning disable AA0181
            IF ItemBatchJnl.FIND('-') THEN BEGIN
#pragma warning restore AA0181
                FILTERGROUP := 2;
                SETFILTER("Journal Template Name", ItemBatchJnl."Journal Template Name");
                SETFILTER("Journal Batch Name", ItemBatchJnl.Name);
                FILTERGROUP := 0;
            END ELSE BEGIN
                ERROR(Text015, USERID);
#pragma warning disable AA0136
                exit(false);
#pragma warning restore AA0136
            END;
        END ELSE BEGIN
            ERROR('');
#pragma warning disable AA0136
            exit(false);
#pragma warning restore AA0136
        END;
    end;

    procedure PostBatch()
    var
        JnlPostBatch: Codeunit "Item Jnl.-Post Batch";
    begin
        JnlPostBatch.RUN(Rec);
    end;
}

