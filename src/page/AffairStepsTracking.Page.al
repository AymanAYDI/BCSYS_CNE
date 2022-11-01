page 50034 "Affair Steps Tracking"
{
    // ------------------------------------------------------------------------
    // PRODWARE - C2A  - www.prodware.fr
    // ------------------------------------------------------------------------
    // 
    // //>>CNE2.05
    // FEP-ADVE-200706_18_A.001:LY  21/01/2008 : - Change Glue
    // FEP-ACHAT-200706_18_A.001:LY 23/01/2008 : - Change SearchAffair Fct :
    //                                             Replace Filter Date by Filter ..Date
    // FEP-ACHAT-200706_18_A.001:LY 19/02/2008 : - Change Property : ModifyAllowed
    //                                             Old : No
    //                                             New : <Yes>
    // 
    // //>>CNE5.00
    // TDL.74/CSC 02/12/2013 : Change Property ShowFilter to No
    // 
    // ------------------------------------------------------------------------

    Caption = 'Affair Steps Tracking';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = Table50010;

    layout
    {
        area(content)
        {
            group()
            {
                label(Interlocutor)
                {
                    CaptionClass = Text19001151;
                    Caption = 'Interlocutor';
                }
                label("Reminder Date")
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
            repeater()
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
                RunObject = Page 88;
                RunPageLink = No.=FIELD(Affair No.);
            }
        }
    }

    trigger OnOpenPage()
    begin
        TxtGIntelocutor := USERID;
        BooGFinichedfilter := FALSE;
        DatLRminderDate := WORKDATE;

        SearchAffairSteps(FALSE,USERID,WORKDATE);
    end;

    var
        BooGFinichedfilter: Boolean;
        TxtGIntelocutor: Text[30];
        DatLRminderDate: Date;
        RecGStepsAffair: Record "50010";
        DiaGWindow: Dialog;
        Text001: Label 'Steps search in prgress...';
        Text19001151: Label 'Interlocutor';
        Text19017858: Label 'Reminder Date';
        Text19022765: Label 'Finished';

    [Scope('Internal')]
    procedure SearchAffairSteps(finished: Boolean;Interlocutor: Text[30];ReminderDate: Date)
    begin
        DiaGWindow.OPEN(Text001);

        RecGStepsAffair.RESET;
        RecGStepsAffair.SETCURRENTKEY(RecGStepsAffair.Interlocutor,RecGStepsAffair."Reminder Date",RecGStepsAffair.Terminated);

        RecGStepsAffair.SETFILTER(RecGStepsAffair.Interlocutor,Interlocutor);
        RecGStepsAffair.SETFILTER("Reminder Date",'..%1',ReminderDate);
        RecGStepsAffair.SETRANGE(RecGStepsAffair.Terminated,finished);
        COPY(RecGStepsAffair);

        //CurrForm.UPDATE(TRUE);

        DiaGWindow.CLOSE;
    end;
}

