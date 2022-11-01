page 50080 "Item Journal Pick List"
{
    Caption = 'Picking Liste';
    CardPageID = "Invt. Pick Card MiniForm";
    Editable = false;
    PageType = List;
    SourceTable = Table83;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; "Document No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Item No."; "Item No.")
                {
                }
                field("Bin Code"; "Bin Code")
                {
                }
                field("New Bin Code"; "New Bin Code")
                {
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
                Caption = '&Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'F8';

                trigger OnAction()
                var
                    page50059: Page "50059";
                begin
                    /*IF ISCLEAR(WshShell) THEN
                      CREATE(WshShell,FALSE ,TRUE);
                    
                    BoolWait := FALSE;
                    WshShell.SendKeys('{TAB}', BoolWait);
                    */
                    //QtyOnAfterValidate;

                    PostBatch();

                    CurrPage.CLOSE;

                end;
            }
            action(ClearAll)
            {
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    DELETEALL(TRUE);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        OpenWithWhseEmployee
    end;

    var
        txt003: Label 'You cannot delete the entry';
        Text001: Label 'User %1 does not exist on warehouse salary list';
        Text002: Label 'Location %1 incorrect';
        Text006: Label 'Palette nr (%1) incorrect';
        Text016: Label 'Item %1 not exit on Invt. Pick';
        Text013: Label 'Item No. %1 Incorrect';
        Text014: Label 'Item %1 blocked';
        Text012: Label 'Item %1 with tracking';
        Text015: Label 'User %1 model sheet does not exist';
        PickNoCaption: Label 'Pick No.';

    [Scope('Internal')]
    procedure OpenWithWhseEmployee(): Boolean
    var
        WhseEmployee: Record "7301";
        WmsManagement: Codeunit "7302";
        CurrentLocationCode: Code[10];
        InvSetup: Record "313";
        ItemJnlTemplate: Record "82";
        ItemBatchJnl: Record "233";
    begin

        InvSetup.GET;
        InvSetup.TESTFIELD("Item Jnl Template Name 1");

        IF USERID <> '' THEN BEGIN
            ItemJnlTemplate.GET(InvSetup."Item Jnl Template Name 1");
            ItemJnlTemplate.TESTFIELD(Type, ItemJnlTemplate.Type::Transfer);
            ItemBatchJnl.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
            ItemBatchJnl.SETRANGE("Assigned User ID", USERID);
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

    [Scope('Internal')]
    procedure PostBatch()
    var
        JnlPostBatch: Codeunit "23";
    begin
        //CLEAR(JnlPostBatch);
        JnlPostBatch.RUN(Rec);
    end;
}

