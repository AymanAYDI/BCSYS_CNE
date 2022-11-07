page 662 "Approval Request Entries"
{
    Caption = 'Approval Request Entries';
    Editable = false;
    PageType = List;
    SourceTable = Table454;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Overdue; Overdue)
                {
                    Caption = 'Overdue';
                    Editable = false;
                    ToolTip = 'Overdue Entry';
                }
                field("Table ID"; "Table ID")
                {
                }
                field("Document Type"; "Document Type")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field("Vendor Name"; "Vendor Name")
                {
                }
                field("Sequence No."; "Sequence No.")
                {
                }
                field("Approval Code"; "Approval Code")
                {
                }
                field("Sender ID"; "Sender ID")
                {
                }
                field("Salespers./Purch. Code"; "Salespers./Purch. Code")
                {
                }
                field("Approver ID"; "Approver ID")
                {
                }
                field(Status; Status)
                {
                }
                field("Date-Time Sent for Approval"; "Date-Time Sent for Approval")
                {
                }
                field("Last Date-Time Modified"; "Last Date-Time Modified")
                {
                }
                field("Last Modified By ID"; "Last Modified By ID")
                {
                }
                field(Comment; Comment)
                {
                }
                field("Due Date"; "Due Date")
                {
                }
                field("Available Credit Limit (LCY)"; "Available Credit Limit (LCY)")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(; Links)
            {
                Visible = false;
            }
            systempart(; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Show")
            {
                Caption = '&Show';
                Image = View;
                action(Document)
                {
                    Caption = 'Document';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        ShowDocument;
                    end;
                }
                action(Comments)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 660;
                    RunPageLink = Table ID=FIELD(Table ID),Document Type=FIELD(Document Type),Document No.=FIELD(Document No.);
                    RunPageView = SORTING(Table ID,Document Type,Document No.);
                }
                action("O&verdue Entries")
                {
                    Caption = 'O&verdue Entries';
                    Image = OverdueEntries;

                    trigger OnAction()
                    begin
                        SETFILTER(Status,'%1|%2',Status::Created,Status::Open);
                        SETFILTER("Due Date",'<%1',TODAY);
                    end;
                }
                action("All Entries")
                {
                    Caption = 'All Entries';
                    Image = Entries;

                    trigger OnAction()
                    begin
                        SETRANGE(Status);
                        SETRANGE("Due Date");
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Delegate")
            {
                Caption = '&Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntry: Record "454";
                    TempApprovalEntry: Record "454";
                    ApprovalSetup: Record "452";
                begin
                    CurrPage.SETSELECTIONFILTER(ApprovalEntry);

                    CurrPage.SETSELECTIONFILTER(TempApprovalEntry);
                    IF TempApprovalEntry.FINDFIRST THEN BEGIN
                      TempApprovalEntry.SETFILTER(Status,'<>%1',TempApprovalEntry.Status::Open);
                      IF NOT TempApprovalEntry.ISEMPTY THEN
                        ERROR(Text001);
                    END;

                    IF ApprovalEntry.FIND('-') THEN BEGIN
                      IF ApprovalSetup.GET THEN;
                      IF Usersetup.GET(USERID) THEN;
                      IF (ApprovalEntry."Sender ID" = Usersetup."User ID") OR
                         (ApprovalSetup."Approval Administrator" = Usersetup."User ID") OR
                         (ApprovalEntry."Approver ID" = Usersetup."User ID")
                      THEN
                        REPEAT
                          ApprovalMgt.DelegateApprovalRequest(ApprovalEntry);
                        UNTIL ApprovalEntry.NEXT = 0;
                    END;

                    MESSAGE(Text002);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Overdue := Overdue::" ";
        IF FormatField(Rec) THEN
          Overdue := Overdue::Yes;
    end;

    trigger OnOpenPage()
    begin
        IF Usersetup.GET(USERID) THEN BEGIN
          IF ApprovalSetup.GET THEN;
          IF NOT (Usersetup."User ID" = ApprovalSetup."Approval Administrator") THEN BEGIN
            FILTERGROUP(2);
            SETCURRENTKEY("Sender ID");
            SETFILTER("Sender ID",'=%1',Usersetup."User ID");
            FILTERGROUP(0);
          END;
        END;

        SETRANGE(Status);
        SETRANGE("Due Date");
    end;

    var
        Usersetup: Record "91";
        ApprovalSetup: Record "452";
        ApprovalMgt: Codeunit "439";
        Text001: Label 'You can only delegate open approvals entries.';
        Text002: Label 'The selected approvals have been delegated. ';
        Overdue: Option Yes," ";

    [Scope('Internal')]
    procedure FormatField(Rec: Record "454"): Boolean
    begin
        IF Status IN [Status::Created,Status::Open] THEN BEGIN
          IF Rec."Due Date" < TODAY THEN
            EXIT(TRUE);

          EXIT(FALSE);
        END;
    end;
}

