report 50055 "BC6_Whse. Get Inventory"
{
    Caption = 'Whse. Get Loc. Content', comment = 'FRA="Afficher contenu mag."';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Item; Item)
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
                    CurrReport.SKIP();

                InsertItemJournalLine();
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
                    field(PostingDate; PostingDateF)
                    {
                        Caption = 'Posting Date', comment = 'FRA="Date comptabilisation"';
                    }
                    field(DocNo; DocNoF)
                    {
                        Caption = 'Document No.', comment = 'FRA="N° document"';
                    }
                    field(NewLocationCode; NewLocationCodeF)
                    {
                        Caption = 'New Location Code', comment = 'FRA="Nouveau code magasin"';
                    }
                    field(NewBinCode; NewBinCodeF)
                    {
                        Caption = 'New Bin Code', comment = 'FRA="Nouveau code emplacement"';
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

        NewLocation.GET(NewLocationCodeF);
        NewLocation.TESTFIELD("Bin Mandatory", TRUE);
        NewBin.GET(NewLocation.Code, NewBinCodeF);
    end;

    var
        NewBin: Record Bin;
        ItemJournalLine: Record "Item Journal Line";
        Location: Record Location;
        NewLocation: Record Location;
        ReportInitialized: Boolean;
        DocNoF: Code[20];
        LocationCode: Code[20];
        NewBinCodeF: Code[20];
        NewLocationCodeF: Code[20];
        PostingDateF: Date;
        QtyToEmpty: Decimal;
        Window: Dialog;
        Counter: Integer;
        TotalCounter: Integer;
        Text001: Label 'Report must be initialized', comment = 'FRA="L''état doit être initialisé."';
        Text002: Label 'Extract Inventory Location %1...', comment = 'FRA="Extraire stock magasin %1..."';
        Text003: Label 'Item No. #1#############', comment = 'FRA="article n° #1#############"';
        Text004: Label '           #2#####|#3#####';

    procedure InitializeItemJournalLine(ItemJournalLine2: Record "Item Journal Line")
    begin
        ItemJournalLine := ItemJournalLine2;
        ItemJournalLine.SETRANGE("Journal Template Name", ItemJournalLine2."Journal Template Name");
        ItemJournalLine.SETRANGE("Journal Batch Name", ItemJournalLine2."Journal Batch Name");
        IF ItemJournalLine.FIND('+') THEN;

        PostingDateF := ItemJournalLine2."Posting Date";
        DocNoF := ItemJournalLine2."Document No.";
        LocationCode := ItemJournalLine2."Location Code";
        NewLocationCodeF := ItemJournalLine2."New Location Code";
        NewBinCodeF := ItemJournalLine2."New Bin Code";
        ReportInitialized := TRUE;
    end;

    procedure InsertItemJournalLine()
    var
        ItemJournalTempl: Record "Item Journal Template";
    begin
        WITH ItemJournalLine DO BEGIN
            INIT();
            "Line No." := "Line No." + 10000;
            VALIDATE("Entry Type", "Entry Type"::Transfer);
            VALIDATE("Item No.", Item."No.");
            VALIDATE("Posting Date", PostingDateF);
            VALIDATE("Document No.", DocNoF);
            VALIDATE("Location Code", LocationCode);
            VALIDATE("New Location Code", NewLocationCodeF);
            VALIDATE("Variant Code", '');
            VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
            VALIDATE("Bin Code", '');
            VALIDATE("New Bin Code", NewBinCodeF);
            VALIDATE(Quantity, QtyToEmpty);
            ItemJournalTempl.GET("Journal Template Name");
            "Source Code" := ItemJournalTempl."Source Code";
            INSERT();
        END;
    end;
}

