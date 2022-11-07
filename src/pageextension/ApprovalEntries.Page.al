page 658 "Approval Entries"
{
    Caption = 'Approval Entries';
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
                field("Limit Type"; "Limit Type")
                {
                }
                field("Approval Type"; "Approval Type")
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
                field(Status; Status)
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
                field("Currency Code"; "Currency Code")
                {
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                }
                field("Available Credit Limit (LCY)"; "Available Credit Limit (LCY)")
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
            action(Approve)
            {
                Caption = '&Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ApproveVisible;

                trigger OnAction()
                var
                    ApprovalEntry: Record "454";
                begin
                    CurrPage.SETSELECTIONFILTER(ApprovalEntry);
                    IF ApprovalEntry.FIND('-') THEN
                      REPEAT
                        ApprovalMgt.ApproveApprovalRequest(ApprovalEntry);
                      UNTIL ApprovalEntry.NEXT = 0;
                end;
            }
            action(Reject)
            {
                Caption = '&Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = RejectVisible;

                trigger OnAction()
                var
                    ApprovalEntry: Record "454";
                    ApprovalSetup: Record "452";
                    ApprovalCommentLine: Record "455";
                    ApprovalComment: Page "660";
                begin
                    CurrPage.SETSELECTIONFILTER(ApprovalEntry);
                    IF ApprovalEntry.FIND('-') THEN
                      REPEAT
                        IF NOT ApprovalSetup.GET THEN
                          ERROR(Text004);
                        IF ApprovalSetup."Request Rejection Comment" = TRUE THEN BEGIN
                          ApprovalCommentLine.SETRANGE("Table ID",ApprovalEntry."Table ID");
                          ApprovalCommentLine.SETRANGE("Document Type",ApprovalEntry."Document Type");
                          ApprovalCommentLine.SETRANGE("Document No.",ApprovalEntry."Document No.");
                          ApprovalComment.SETTABLEVIEW(ApprovalCommentLine);
                          IF ApprovalComment.RUNMODAL = ACTION::OK THEN
                            ApprovalMgt.RejectApprovalRequest(ApprovalEntry);
                        END ELSE
                          ApprovalMgt.RejectApprovalRequest(ApprovalEntry);

                      UNTIL ApprovalEntry.NEXT = 0;
                end;
            }
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

    trigger OnInit()
    begin
        RejectVisible := TRUE;
        ApproveVisible := TRUE;
    end;

    trigger OnOpenPage()
    var
        Filterstring: Text;
    begin
        IF Usersetup.GET(USERID) THEN BEGIN
          FILTERGROUP(2);
          Filterstring := GETFILTERS;
          FILTERGROUP(0);
          IF STRLEN(Filterstring) = 0 THEN BEGIN
            FILTERGROUP(2);
            SETCURRENTKEY("Approver ID");
            IF Overdue = Overdue::Yes THEN
              SETRANGE("Approver ID",Usersetup."User ID");
            SETRANGE(Status,Status::Open);
            FILTERGROUP(0);
          END ELSE
            SETCURRENTKEY("Table ID","Document Type","Document No.");
        END;
    end;

    var
        Usersetup: Record "91";
        ApprovalMgt: Codeunit "439";
        Text001: Label 'You can only delegate open approval entries.';
        Text002: Label 'The selected approvals have been delegated. ';
        Overdue: Option Yes," ";
        Text004: Label 'Approval Setup was not found.';
        [InDataSet]
        ApproveVisible: Boolean;
        [InDataSet]
        RejectVisible: Boolean;

    [Scope('Internal')]
    procedure Setfilters(TableId: Integer;DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";DocumentNo: Code[20])
    begin
        IF TableId <> 0 THEN BEGIN
          FILTERGROUP(2);
          SETCURRENTKEY("Table ID","Document Type","Document No.");
          SETRANGE("Table ID",TableId);
          SETRANGE("Document Type",DocumentType);
          IF DocumentNo <> '' THEN
            SETRANGE("Document No.",DocumentNo);
          FILTERGROUP(0);
        END;

        ApproveVisible := FALSE;
        RejectVisible := FALSE;
    end;

    [Scope('Internal')]
    procedure FormatField(Rec: Record "454") OK: Boolean
    begin
        IF Status IN [Status::Created,Status::Open] THEN BEGIN
          IF Rec."Due Date" < TODAY THEN
            EXIT(TRUE);

          EXIT(FALSE);
        END;
    end;

    [Scope('Internal')]
    procedure CalledFrom()
    begin
        Overdue := Overdue::" ";
    end;
}

