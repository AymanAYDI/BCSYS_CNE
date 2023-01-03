page 50034 "BC6_Affair Steps Tracking"
{
    Caption = 'Affair Steps Tracking', Comment = 'FRA="Suivi étapes affaire"';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "BC6_Affair Steps";
    UsageCategory = Tasks;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(Control1)
            {
                label(Interlocuteur)
                {
                    CaptionClass = Text19001151;
                    Caption = 'Interlocutor', Comment = 'FRA="Interlocuteur"';
                    ApplicationArea = All;
                }
                label("Date rappel")
                {
                    CaptionClass = Text19017858;
                    Caption = 'Date rappel', Comment = 'FRA="Date rappel"';
                    ApplicationArea = All;
                }
                label(Finished)
                {
                    CaptionClass = Text19022765;
                    Caption = 'Finished', Comment = 'FRA="Teminer"';
                    ApplicationArea = All;
                }
                field(TxtGIntelocutor; TxtGIntelocutor)
                {
                    Lookup = true;
                    TableRelation = "User Setup";
                    ApplicationArea = All;
                }
                field(DatLRminderDate; DatLRminderDate)
                {
                    Caption = 'DatLRminderDate', Comment = 'FRA=""';
                    ApplicationArea = All;
                }
                field(BooGFinichedfilter; BooGFinichedfilter)
                {
                    Caption = 'BooGFinichedfilter';
                    ApplicationArea = All;
                }
            }
            repeater(Control2)
            {
                field("Affair No."; "Affair No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Affair Description"; "Affair Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Interlocutor; Interlocutor)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Reminder Date"; "Reminder Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Result; Result)
                {
                    ApplicationArea = All;
                }
                field(Terminated; Terminated)
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
                Caption = 'Fi&nd', Comment = 'FRA="&Rechercher"';
                Image = Find;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    SearchAffairSteps(BooGFinichedfilter, TxtGIntelocutor, DatLRminderDate);
                end;
            }
            action("Fiche affaire")
            {
                Promoted = true;
                RunObject = Page "Job Card";
                RunPageLink = "No." = FIELD("Affair No.");
                ApplicationArea = All;
            }
        }
    }

    trigger OnOpenPage()
    begin
        TxtGIntelocutor := CopyStr(USERID, 1, MaxStrLen(TxtGIntelocutor)); //à vérifier lors du test
        BooGFinichedfilter := FALSE;
        DatLRminderDate := WORKDATE();

        SearchAffairSteps(FALSE, USERID, WORKDATE());
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


    procedure SearchAffairSteps(finish: Boolean; Interlocuteur: Text[30]; ReminderDate: Date)
    begin
        DiaGWindow.OPEN(Text001);

        RecGStepsAffair.RESET();
        RecGStepsAffair.SETCURRENTKEY(RecGStepsAffair.Interlocutor, RecGStepsAffair."Reminder Date", RecGStepsAffair.Terminated);

        RecGStepsAffair.SETFILTER(RecGStepsAffair.Interlocutor, Interlocuteur);
        RecGStepsAffair.SETFILTER("Reminder Date", '..%1', ReminderDate);
        RecGStepsAffair.SETRANGE(RecGStepsAffair.Terminated, finish);
        COPY(RecGStepsAffair);

        //CurrForm.UPDATE(TRUE);

        DiaGWindow.CLOSE();
    end;
}

