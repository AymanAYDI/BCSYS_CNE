page 50034 "BC6_Affair Steps Tracking"
{
    ApplicationArea = All;
    Caption = 'Affair Steps Tracking', Comment = 'FRA="Suivi étapes affaire"';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "BC6_Affair Steps";
    UsageCategory = Tasks;
    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                label(Interlocuteur)
                {
                    ApplicationArea = All;
                    Caption = 'Interlocutor', Comment = 'FRA="Interlocuteur"';
                    CaptionClass = Text19001151;
                }
                label("Date rappel")
                {
                    ApplicationArea = All;
                    Caption = 'Date rappel', Comment = 'FRA="Date rappel"';
                    CaptionClass = Text19017858;
                }
                label(Finished)
                {
                    ApplicationArea = All;
                    Caption = 'Finished', Comment = 'FRA="Teminer"';
                    CaptionClass = Text19022765;
                }
                field(TxtGIntelocutor; TxtGIntelocutor)
                {
                    ApplicationArea = All;
                    Lookup = true;
                    ShowCaption = false;
                    TableRelation = "User Setup";
                }
                field(DatLRminderDate; DatLRminderDate)
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field(BooGFinichedfilter; BooGFinichedfilter)
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
            }
            repeater(Control2)
            {
                field("Affair No."; Rec."Affair No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Affair Description"; Rec."Affair Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Interlocutor; Rec.Interlocutor)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Reminder Date"; Rec."Reminder Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Result; Rec.Result)
                {
                    ApplicationArea = All;
                }
                field(Terminated; Rec.Terminated)
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
            action("Fi&nd")
            {
                ApplicationArea = All;
                Caption = 'Fi&nd', Comment = 'FRA="&Rechercher"';
                Image = Find;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    SearchAffairSteps(BooGFinichedfilter, TxtGIntelocutor, DatLRminderDate);
                end;
            }
            action("Fiche affaire")
            {
                ApplicationArea = All;
                Image = CheckList;
                Promoted = true;
                RunObject = Page "Job Card";
                RunPageLink = "No." = FIELD("Affair No.");
            }
        }
    }

    trigger OnOpenPage()
    begin
        TxtGIntelocutor := CopyStr(USERID, 1, MaxStrLen(TxtGIntelocutor)); //à vérifier lors du test
        BooGFinichedfilter := FALSE;
        DatLRminderDate := WORKDATE();

        SearchAffairSteps(FALSE, CopyStr(USERID, 0, 50), WORKDATE());
    end;

    var
        RecGStepsAffair: Record "BC6_Affair Steps";
        BooGFinichedfilter: Boolean;
        DatLRminderDate: Date;
        DiaGWindow: Dialog;
        Text001: Label 'Steps search in prgress...', Comment = 'FRA="Recherche des étapes en cours..."';
        Text19001151: Label 'Interlocutor', Comment = 'FRA="Interlocuteur"';
        Text19017858: Label 'Reminder Date', Comment = 'FRA="Date rappel"';
        Text19022765: Label 'Finished', Comment = 'FRA="Terminer"';
        TxtGIntelocutor: Text[30];

    procedure SearchAffairSteps(finish: Boolean; pInterlocuteur: Text[50]; ReminderDate: Date)
    begin
        DiaGWindow.OPEN(Text001);

        RecGStepsAffair.RESET();
        RecGStepsAffair.SETCURRENTKEY(RecGStepsAffair.Interlocutor, RecGStepsAffair."Reminder Date", RecGStepsAffair.Terminated);

        RecGStepsAffair.SETFILTER(RecGStepsAffair.Interlocutor, pInterlocuteur);
        RecGStepsAffair.SETFILTER("Reminder Date", '..%1', ReminderDate);
        RecGStepsAffair.SETRANGE(RecGStepsAffair.Terminated, finish);
        Rec.COPY(RecGStepsAffair);
        DiaGWindow.CLOSE();
    end;
}
