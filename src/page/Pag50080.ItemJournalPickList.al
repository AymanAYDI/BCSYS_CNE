page 50080 "BC6_Item Journal Pick List"
{
    Caption = 'Picking Liste', Comment = 'FRA="Prélèvements"';
    CardPageID = "BC6_Invt. Pick Card MiniForm";
    Editable = false;
    PageType = List;
    SourceTable = "Item Journal Line";

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
                var
                    page50059: Page "BC6_Invt. Pick Card MiniForm";
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
        txt003: Label 'You cannot delete the entry', Comment = 'FRA="Vous ne pouvez pas supprimer la saisie."';
        Text001: Label 'User %1 does not exist on warehouse salary list', Comment = 'FRA="L''utilisateur %1 n''est pas un salarié magasin."';
        Text002: Label 'Location %1 incorrect', Comment = 'FRA="Emplacement (%1) erroné"';
        Text006: Label 'Palette nr (%1) incorrect', Comment = 'FRA="Quantité (%1) erronée"';
        Text016: Label 'Item %1 not exit on Invt. Pick', Comment = 'FRA="Article (%1)  n''est pas sur le prélevement."';
        Text013: Label 'Item No. %1 Incorrect', Comment = 'FRA="%1 n° article erroné"';
        Text014: Label 'Item %1 blocked', Comment = 'FRA="%1 article bloqué"';
        Text012: Label 'Item %1 with tracking', Comment = 'FRA="%1 article avec traçabilité"';
        Text015: Label 'User %1 model sheet does not exist', Comment = 'FRA="Pas de nom de feuille article utilisateur %1"';
        PickNoCaption: Label 'Pick No.', Comment = 'FRA="N° prélèvement"';

    procedure OpenWithWhseEmployee(): Boolean
    var
        WhseEmployee: Record "Warehouse Employee";
        InvSetup: Record "Inventory Setup";
        WmsManagement: Codeunit "WMS Management";
        CurrentLocationCode: Code[10];
        ItemJnlTemplate: Record "Item Journal Template";
        ItemBatchJnl: Record "Item Journal Batch";
    begin

        InvSetup.GET();
        InvSetup.TESTFIELD("BC6_Item Jnl Template Name 1");

        IF USERID <> '' THEN BEGIN
            ItemJnlTemplate.GET(InvSetup."BC6_Item Jnl Template Name 1");
            ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::Transfer);
            ItemBatchJnl.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
            ItemBatchJnl.SETRANGE("BC6_Assigned User ID", USERID);
            IF ItemBatchJnl.FIND('-') THEN BEGIN
                FILTERGROUP := 2;
                SETFILTER("Journal Template Name", ItemBatchJnl."Journal Template Name");
                SETFILTER("Journal Batch Name", ItemBatchJnl.Name);
                FILTERGROUP := 0;
            END ELSE BEGIN
                ERROR(Text015, USERID);
                EXIT(FALSE);
            END;
        END ELSE BEGIN
            ERROR('');
            EXIT(FALSE);
        END;
    end;

    procedure PostBatch()
    var
        JnlPostBatch: Codeunit "Item Jnl.-Post Batch";
    begin
        JnlPostBatch.RUN(Rec);
    end;
}

