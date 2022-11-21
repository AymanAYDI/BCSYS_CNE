page 55020 "BC6_Code Coverage 2"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Code Coverage";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Line; Line)
                {
                }
                field(HitRatio; HitRatio)
                {
                    Caption = 'Hit Ratio %';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Start Code Coverage")
            {
                Caption = 'Start Code Coverage';
                Enabled = NOT CodeCoverageActive;
                Image = Start;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CodeCoverageActive := CODECOVERAGELOG(TRUE, FALSE);
                end;
            }
            action("Stop Code Coverage")
            {
                Caption = 'Stop Code Coverage';
                Enabled = CodeCoverageActive;
                Image = Stop;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CodeCoverageActive := CODECOVERAGELOG(FALSE, FALSE);
                    Process();
                end;
            }
            action("Code")
            {
                Caption = 'Code';
                Image = DesignCodeBehind;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CodeCoverage: Record "Code Coverage";
                begin
                    CodeCoverage := Rec;
                    CodeCoverage.SETRECFILTER();
                    CodeCoverage.SETRANGE("Line No.");
                    PAGE.RUN(PAGE::"BC6_Code Coverage Code 2", CodeCoverage);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        HitRatio := "No. of Hits" / 100;
    end;

    trigger OnOpenPage()
    begin
        CodeCoverageActive := CODECOVERAGELOG();
        Process();
    end;

    var
        TempCodeCoverage: Record "Code Coverage" temporary;
        [InDataSet]
        CodeCoverageActive: Boolean;
        HitRatio: Decimal;

    procedure Process()
    var
        CodeCoverage: Record "Code Coverage";
        AllHits: Integer;
    begin
        AllHits := 0;
        TempCodeCoverage.RESET();
        TempCodeCoverage.DELETEALL();

        IF CodeCoverage.FINDSET() THEN
            REPEAT

                IF NOT TempCodeCoverage.GET(CodeCoverage."Object Type", CodeCoverage."Object ID", 0) THEN BEGIN
                    TempCodeCoverage.TRANSFERFIELDS(CodeCoverage);
                    TempCodeCoverage.INSERT();
                END;

                TempCodeCoverage."No. of Hits" := TempCodeCoverage."No. of Hits" + CodeCoverage."No. of Hits";
                TempCodeCoverage.MODIFY();

                AllHits := AllHits + CodeCoverage."No. of Hits";
            UNTIL CodeCoverage.NEXT() = 0;

        RESET();
        DELETEALL();

        IF TempCodeCoverage.FINDSET() THEN
            REPEAT
                TempCodeCoverage."No. of Hits" := (ROUND(TempCodeCoverage."No. of Hits" / AllHits * 100, 0.01) * 100);
                TempCodeCoverage.MODIFY();
                Rec := TempCodeCoverage;
                INSERT();
            UNTIL TempCodeCoverage.NEXT() = 0;
    end;
}

