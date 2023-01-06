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
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("New Bin Code"; Rec."New Bin Code")
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
            action("Post1000000007")
            {
                Caption = '&Post', Comment = 'FRA="&Valider"';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'F8';
                PromotedOnly = true;
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
                    Rec.DELETEALL(TRUE);
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
            IF ItemBatchJnl.FindFirst() THEN BEGIN
                Rec.FILTERGROUP := 2;
                Rec.SETFILTER("Journal Template Name", ItemBatchJnl."Journal Template Name");
                Rec.SETFILTER("Journal Batch Name", ItemBatchJnl.Name);
                Rec.FILTERGROUP := 0;
            END ELSE BEGIN
                ERROR(Text015, USERID);
                exit(false);
            END;
        END ELSE BEGIN
            ERROR('');
            exit(false);
        END;
    end;

    procedure PostBatch()
    var
        JnlPostBatch: Codeunit "Item Jnl.-Post Batch";
    begin
        JnlPostBatch.RUN(Rec);
    end;
}

