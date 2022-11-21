page 50034 "BC6_Affair Steps Tracking"
{
    Caption = 'Affair Steps Tracking';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "BC6_Affair Steps";

    layout
    {
        area(content)
        {
            group(Control1)
            {
                label(Control1000000004)
                {
                    CaptionClass = Text19001151;
                    Caption = 'Interlocutor';
                }
                label(Control1000000005)
                {
                    CaptionClass = Text19017858;
                    Caption = 'Reminder Date';
                }
                label(Finished)
                {
                    CaptionClass = Text19022765;
                    Caption = 'Finished';
                }
                field(TxtGIntelocutor; TxtGIntelocutor)
                {
                    Lookup = true;
                    TableRelation = "User Setup";
                }
                field(DatLRminderDate; DatLRminderDate)
                {
                }
                field(BooGFinichedfilter; BooGFinichedfilter)
                {
                }
            }
            repeater(Control2)
            {
                field("Affair No."; "Affair No.")
                {
                    Editable = false;
                }
                field("Affair Description"; "Affair Description")
                {
                    Editable = false;
                }
                field(Interlocutor; Interlocutor)
                {
                    Editable = false;
                }
                field("Reminder Date"; "Reminder Date")
                {
                    Editable = false;
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field(Result; Result)
                {
                }
                field(Terminated; Terminated)
                {
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
                Caption = 'Fi&nd';
                Image = Find;
                Promoted = true;
                PromotedCategory = Process;

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
            }
        }
    }

    trigger OnOpenPage()
    begin
        TxtGIntelocutor := USERID;
        BooGFinichedfilter := FALSE;
        DatLRminderDate := WORKDATE();

        SearchAffairSteps(FALSE, USERID, WORKDATE());
    end;

    var
        BooGFinichedfilter: Boolean;
        TxtGIntelocutor: Text[30];
        DatLRminderDate: Date;
        RecGStepsAffair: Record "BC6_Affair Steps";
        DiaGWindow: Dialog;
        Text001: Label 'Steps search in prgress...';
        Text19001151: Label 'Interlocutor';
        Text19017858: Label 'Reminder Date';
        Text19022765: Label 'Finished';


    procedure SearchAffairSteps(finished: Boolean; Interlocutor: Text[30]; ReminderDate: Date)
    begin
        DiaGWindow.OPEN(Text001);

        RecGStepsAffair.RESET();
        RecGStepsAffair.SETCURRENTKEY(RecGStepsAffair.Interlocutor, RecGStepsAffair."Reminder Date", RecGStepsAffair.Terminated);

        RecGStepsAffair.SETFILTER(RecGStepsAffair.Interlocutor, Interlocutor);
        RecGStepsAffair.SETFILTER("Reminder Date", '..%1', ReminderDate);
        RecGStepsAffair.SETRANGE(RecGStepsAffair.Terminated, finished);
        COPY(RecGStepsAffair);

        //CurrForm.UPDATE(TRUE);

        DiaGWindow.CLOSE();
    end;
}

