report 50055 "Whse. Get Inventory"
{
    Caption = 'Whse. Get Loc. Content';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem8129; Table27)
        {
            RequestFilterFields = "No.", "Location Filter";

            trigger OnAfterGetRecord()
            begin

                Counter += 1;
                Window.UPDATE(1, "No.");
                Window.UPDATE(2, Counter);

                CALCFIELDS(Inventory);
                QtyToEmpty := Inventory;
                IF (QtyToEmpty <= 0) THEN
                    CurrReport.SKIP;

                InsertItemJournalLine;
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN(STRSUBSTNO(Text002, LocationCode) + '\' +
                            Text003 + '\' +
                            Text004);

                TotalCounter := COUNT;
                Window.UPDATE(3, TotalCounter);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PostingDate; PostingDate)
                    {
                        Caption = 'Posting Date';
                    }
                    field(DocNo; DocNo)
                    {
                        Caption = 'Document No.';
                    }
                    field(NewLocationCode; NewLocationCode)
                    {
                        Caption = 'New Location Code';
                    }
                    field(NewBinCode; NewBinCode)
                    {
                        Caption = 'New Bin Code';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF NOT ReportInitialized THEN
            ERROR(Text001);

        IF Item.GETFILTER("Location Filter") = '' THEN
            Item.TESTFIELD("Location Filter");

        LocationCode := Item.GETFILTER("Location Filter");
        Location.GET(LocationCode);
        Location.TESTFIELD("Bin Mandatory", FALSE);

        NewLocation.GET(NewLocationCode);
        NewLocation.TESTFIELD("Bin Mandatory", TRUE);
        NewBin.GET(NewLocation.Code, NewBinCode);
    end;

    var
        ItemJournalLine: Record "83";
        QtyToEmpty: Decimal;
        ReportInitialized: Boolean;
        Text001: Label 'Report must be initialized';
        PostingDate: Date;
        DocNo: Code[20];
        Location: Record "14";
        NewLocation: Record "14";
        LocationCode: Code[20];
        NewLocationCode: Code[20];
        NewBinCode: Code[20];
        NewBin: Record "7354";
        Window: Dialog;
        Text002: Label 'Extract Inventory Location %1...';
        Text003: Label 'Item No. #1#############';
        Text004: Label '           #2#####|#3#####';
        Counter: Integer;
        TotalCounter: Integer;

    [Scope('Internal')]
    procedure InitializeItemJournalLine(ItemJournalLine2: Record "83")
    begin
        ItemJournalLine := ItemJournalLine2;
        ItemJournalLine.SETRANGE("Journal Template Name", ItemJournalLine2."Journal Template Name");
        ItemJournalLine.SETRANGE("Journal Batch Name", ItemJournalLine2."Journal Batch Name");
        IF ItemJournalLine.FIND('+') THEN;

        PostingDate := ItemJournalLine2."Posting Date";
        DocNo := ItemJournalLine2."Document No.";
        LocationCode := ItemJournalLine2."Location Code";
        NewLocationCode := ItemJournalLine2."New Location Code";
        NewBinCode := ItemJournalLine2."New Bin Code";
        ReportInitialized := TRUE;
    end;

    [Scope('Internal')]
    procedure InsertItemJournalLine()
    var
        ItemJournalTempl: Record "82";
    begin
        WITH ItemJournalLine DO BEGIN
            INIT;
            "Line No." := "Line No." + 10000;
            VALIDATE("Entry Type", "Entry Type"::Transfer);
            VALIDATE("Item No.", Item."No.");
            VALIDATE("Posting Date", PostingDate);
            VALIDATE("Document No.", DocNo);
            VALIDATE("Location Code", LocationCode);
            VALIDATE("New Location Code", NewLocationCode);
            VALIDATE("Variant Code", '');
            VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
            VALIDATE("Bin Code", '');
            VALIDATE("New Bin Code", NewBinCode);
            VALIDATE(Quantity, QtyToEmpty);
            ItemJournalTempl.GET("Journal Template Name");
            "Source Code" := ItemJournalTempl."Source Code";
            INSERT;
        END;
    end;
}

