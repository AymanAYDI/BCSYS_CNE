tableextension 50081 tableextension50081 extends "Report Selections"
{
    fields
    {
        modify(Usage)
        {
            OptionCaption = 'S.Quote,S.Order,S.Invoice,S.Cr.Memo,S.Test,P.Quote,P.Order,P.Invoice,P.Cr.Memo,P.Receipt,P.Ret.Shpt.,P.Test,B.Stmt,B.Recon.Test,B.Check,Reminder,Fin.Charge,Rem.Test,F.C.Test,Prod. Order,S.Blanket,P.Blanket,M1,M2,M3,M4,Inv1,Inv2,Inv3,SM.Quote,SM.Order,SM.Invoice,SM.Credit Memo,SM.Contract Quote,SM.Contract,SM.Test,S.Return,P.Return,S.Shipment,S.Ret.Rcpt.,S.Work Order,Invt. Period Test,SM.Shipment,S.Test Prepmt.,P.Test Prepmt.,S.Arch. Quote,S.Arch. Order,P.Arch. Quote,P.Arch. Order,S. Arch. Return Order,P. Arch. Return Order,Asm. Order,P.Assembly Order,S.Order Pick Instruction,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,C.Statement,V.Remittance,JQ,S.Invoice Draft';

            //Unsupported feature: Property Modification (OptionString) on "Usage(Field 1)".

        }
        modify("Report ID")
        {
            TableRelation = AllObjWithCaption."Object ID" WHERE (Object Type=CONST(Report));
        }

        //Unsupported feature: Property Modification (CalcFormula) on ""Report Caption"(Field 4)".


        //Unsupported feature: Code Modification on ""Report ID"(Field 3).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CALCFIELDS("Report Caption");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CALCFIELDS("Report Caption");
        VALIDATE("Use for Email Body",FALSE);
        */
        //end;
        field(7; "Custom Report Layout Code"; Code[20])
        {
            Caption = 'Custom Report Layout Code';
            Editable = false;
            TableRelation = "Custom Report Layout".Code WHERE (Code = FIELD (Custom Report Layout Code));
        }
        field(19;"Use for Email Attachment";Boolean)
        {
            Caption = 'Use for Email Attachment';
            InitValue = true;

            trigger OnValidate()
            begin
                IF NOT "Use for Email Body" THEN
                  VALIDATE("Email Body Layout Code",'');
            end;
        }
        field(20;"Use for Email Body";Boolean)
        {
            Caption = 'Use for Email Body';

            trigger OnValidate()
            begin
                IF NOT "Use for Email Body" THEN
                  VALIDATE("Email Body Layout Code",'');
            end;
        }
        field(21;"Email Body Layout Code";Code[20])
        {
            Caption = 'Email Body Layout Code';
            TableRelation = "Custom Report Layout".Code WHERE (Code=FIELD(Email Body Layout Code),
                                                               Report ID=FIELD(Report ID));

            trigger OnValidate()
            begin
                IF "Email Body Layout Code" <> '' THEN
                  TESTFIELD("Use for Email Body",TRUE);
                CALCFIELDS("Email Body Layout Description");
            end;
        }
        field(22;"Email Body Layout Description";Text[250])
        {
            CalcFormula = Lookup("Custom Report Layout".Description WHERE (Code=FIELD(Email Body Layout Code)));
            Caption = 'Email Body Layout Description';
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup()
            var
                CustomReportLayout: Record "9650";
            begin
                IF CustomReportLayout.LookupLayoutOK("Report ID") THEN
                  VALIDATE("Email Body Layout Code",CustomReportLayout.Code);
            end;
        }
    }


    //Unsupported feature: Code Insertion on "OnInsert".

    //trigger OnInsert()
    //begin
        /*
        CheckEmailBodyUsage;
        */
    //end;


    //Unsupported feature: Code Insertion on "OnModify".

    //trigger OnModify()
    //begin
        /*
        TESTFIELD("Report ID");
        CheckEmailBodyUsage;
        */
    //end;

    local procedure CheckEmailBodyUsage()
    var
        ReportSelections: Record "77";
        ReportLayoutSelection: Record "9651";
    begin
        IF "Use for Email Body" THEN BEGIN
          ReportSelections.FilterEmailBodyUsage(Usage);
          ReportSelections.SETFILTER(Sequence,'<>%1',Sequence);
          IF NOT ReportSelections.ISEMPTY THEN
            ERROR(EmailBodyIsAlreadyDefinedErr,Usage);

          IF "Email Body Layout Code" = '' THEN
            IF ReportLayoutSelection.GetDefaultType("Report ID") =
               ReportLayoutSelection.Type::"RDLC (built-in)"
            THEN
              ERROR(CannotBeUsedAsAnEmailBodyErr,"Report ID",ReportLayoutSelection.Type);
        END;
    end;

    procedure FilterPrintUsage(ReportUsage: Integer)
    begin
        RESET;
        SETRANGE(Usage,ReportUsage);
    end;

    procedure FilterEmailUsage(ReportUsage: Integer)
    begin
        RESET;
        SETRANGE(Usage,ReportUsage);
        SETRANGE("Use for Email Body",TRUE);
    end;

    procedure FilterEmailBodyUsage(ReportUsage: Integer)
    begin
        RESET;
        SETRANGE(Usage,ReportUsage);
        SETRANGE("Use for Email Body",TRUE);
    end;

    procedure FilterEmailAttachmentUsage(ReportUsage: Integer)
    begin
        RESET;
        SETRANGE(Usage,ReportUsage);
        SETRANGE("Use for Email Attachment",TRUE);
    end;

    procedure FindPrintUsage(ReportUsage: Integer;CustNo: Code[20];var ReportSelections: Record "77")
    begin
        FilterPrintUsage(ReportUsage);
        SETFILTER("Report ID",'<>0');

        FindReportSelections(ReportSelections,CustNo);
        ReportSelections.FINDSET;
    end;

    procedure FindPrintUsageVendor(ReportUsage: Integer;VendorNo: Code[20];var ReportSelections: Record "77")
    begin
        FilterPrintUsage(ReportUsage);
        SETFILTER("Report ID",'<>0');

        FindReportSelectionsVendor(ReportSelections,VendorNo);
        ReportSelections.FINDSET;
    end;

    procedure FindEmailAttachmentUsage(ReportUsage: Integer;CustNo: Code[20];var ReportSelections: Record "77"): Boolean
    begin
        FilterEmailAttachmentUsage(ReportUsage);
        SETFILTER("Report ID",'<>0');
        SETRANGE("Use for Email Attachment",TRUE);

        FindReportSelections(ReportSelections,CustNo);
        EXIT(ReportSelections.FINDSET);
    end;

    procedure FindEmailAttachmentUsageVendor(ReportUsage: Integer;VendorNo: Code[20];var ReportSelections: Record "77"): Boolean
    begin
        FilterEmailAttachmentUsage(ReportUsage);
        SETFILTER("Report ID",'<>0');
        SETRANGE("Use for Email Attachment",TRUE);

        FindReportSelectionsVendor(ReportSelections,VendorNo);
        EXIT(ReportSelections.FINDSET);
    end;

    procedure FindEmailBodyUsage(ReportUsage: Integer;CustNo: Code[20];var ReportSelections: Record "77"): Boolean
    begin
        FilterEmailBodyUsage(ReportUsage);
        SETFILTER("Report ID",'<>0');

        FindReportSelections(ReportSelections,CustNo);
        EXIT(ReportSelections.FINDSET);
    end;

    procedure FindEmailBodyUsageVendor(ReportUsage: Integer;VendorNo: Code[20];var ReportSelections: Record "77"): Boolean
    begin
        FilterEmailBodyUsage(ReportUsage);
        SETFILTER("Report ID",'<>0');

        FindReportSelectionsVendor(ReportSelections,VendorNo);
        EXIT(ReportSelections.FINDSET);
    end;

    procedure PrintWithCheck(ReportUsage: Integer;RecordVariant: Variant;CustNo: Code[20])
    begin
        PrintWithGUIYesNoWithCheck(ReportUsage,RecordVariant,TRUE,CustNo);
    end;

    procedure PrintWithGUIYesNoWithCheck(ReportUsage: Integer;RecordVariant: Variant;IsGUI: Boolean;CustNo: Code[20])
    var
        TempReportSelections: Record "77" temporary;
    begin
        FilterPrintUsage(ReportUsage);

        FindReportSelections(TempReportSelections,CustNo);
        IF NOT TempReportSelections.FINDSET THEN
          FINDSET;
        WITH TempReportSelections DO
          REPEAT
            ReportLayoutSelection.SetTempLayoutSelected("Custom Report Layout Code");
            TESTFIELD("Report ID");
            REPORT.RUNMODAL("Report ID",IsGUI,FALSE,RecordVariant)
          UNTIL NEXT = 0;
        ReportLayoutSelection.SetTempLayoutSelected('');
    end;

    procedure Print(ReportUsage: Integer;RecordVariant: Variant;CustNo: Code[20])
    begin
        PrintWithGUIYesNo(ReportUsage,RecordVariant,TRUE,CustNo);
    end;

    procedure PrintWithGUIYesNo(ReportUsage: Integer;RecordVariant: Variant;IsGUI: Boolean;CustNo: Code[20])
    var
        TempReportSelections: Record "77" temporary;
    begin
        FindPrintUsage(ReportUsage,CustNo,TempReportSelections);
        WITH TempReportSelections DO
          REPEAT
            ReportLayoutSelection.SetTempLayoutSelected("Custom Report Layout Code");
            REPORT.RUNMODAL("Report ID",IsGUI,FALSE,RecordVariant)
          UNTIL NEXT = 0;
        ReportLayoutSelection.SetTempLayoutSelected('');
    end;

    procedure PrintWithGUIYesNoVendor(ReportUsage: Integer;RecordVariant: Variant;IsGUI: Boolean;VendorNo: Code[20])
    var
        TempReportSelections: Record "77" temporary;
    begin
        FindPrintUsageVendor(ReportUsage,VendorNo,TempReportSelections);
        WITH TempReportSelections DO
          REPEAT
            ReportLayoutSelection.SetTempLayoutSelected("Custom Report Layout Code");
            REPORT.RUNMODAL("Report ID",IsGUI,FALSE,RecordVariant)
          UNTIL NEXT = 0;
        ReportLayoutSelection.SetTempLayoutSelected('');
    end;

    procedure GetHtmlReport(var ServerEmailBodyFilePath: Text[250];ReportUsage: Integer;RecordVariant: Variant;CustNo: Code[20])
    var
        TempBodyReportSelections: Record "77" temporary;
    begin
        ServerEmailBodyFilePath := '';

        FindPrintUsage(ReportUsage,CustNo,TempBodyReportSelections);

        ServerEmailBodyFilePath :=
          SaveReportAsHTML(TempBodyReportSelections."Report ID",RecordVariant,TempBodyReportSelections."Custom Report Layout Code");
    end;

    procedure GetEmailBody(var ServerEmailBodyFilePath: Text[250];ReportUsage: Integer;RecordVariant: Variant;CustNo: Code[20];var CustEmailAddress: Text[250]): Boolean
    var
        TempBodyReportSelections: Record "77" temporary;
    begin
        ServerEmailBodyFilePath := '';

        CustEmailAddress := GetCustEmailAddress(CustNo);

        IF NOT FindEmailBodyUsage(ReportUsage,CustNo,TempBodyReportSelections) THEN
          EXIT(FALSE);

        ServerEmailBodyFilePath :=
          SaveReportAsHTML(TempBodyReportSelections."Report ID",RecordVariant,TempBodyReportSelections."Email Body Layout Code");

        CustEmailAddress := FindEmailAddressForEmailLayout(TempBodyReportSelections."Email Body Layout Code",CustNo,ReportUsage);
        IF CustEmailAddress = '' THEN
          CustEmailAddress := GetCustEmailAddress(CustNo);

        EXIT(TRUE);
    end;

    procedure GetEmailBodyVendor(var ServerEmailBodyFilePath: Text[250];ReportUsage: Integer;RecordVariant: Variant;VendorNo: Code[20];var VendorEmailAddress: Text[250]): Boolean
    var
        TempBodyReportSelections: Record "77" temporary;
    begin
        ServerEmailBodyFilePath := '';

        VendorEmailAddress := GetVendorEmailAddress(VendorNo);

        IF NOT FindEmailBodyUsageVendor(ReportUsage,VendorNo,TempBodyReportSelections) THEN
          EXIT(FALSE);

        ServerEmailBodyFilePath :=
          SaveReportAsHTML(TempBodyReportSelections."Report ID",RecordVariant,TempBodyReportSelections."Email Body Layout Code");

        VendorEmailAddress :=
          FindEmailAddressForEmailLayoutVendor(TempBodyReportSelections."Email Body Layout Code",VendorNo,ReportUsage);
        IF VendorEmailAddress = '' THEN
          VendorEmailAddress := GetVendorEmailAddress(VendorNo);

        EXIT(TRUE);
    end;

    procedure SendEmailInBackground(JobQueueEntry: Record "472")
    var
        RecRef: RecordRef;
        ReportUsage: Integer;
        DocNo: Code[20];
        DocName: Text[150];
        No: Code[20];
        ParamString: Text;
    begin
        // Called from codeunit 260 OnRun trigger - in a background process.
        RecRef.GET(JobQueueEntry."Record ID to Process");
        RecRef.LOCKTABLE;
        RecRef.FIND;
        RecRef.SETRECFILTER;
        ParamString := JobQueueEntry."Parameter String";  // Are set in function SendEmailToCust
        EVALUATE(ReportUsage,GetNextParam(ParamString));
        EVALUATE(DocNo,GetNextParam(ParamString));
        EVALUATE(DocName,GetNextParam(ParamString));
        EVALUATE(No,GetNextParam(ParamString));
        // EVALUATE(Type,GetNextParam(ParamString));
        IF ParamString = 'Vendor' THEN
          SendEmailToVendorDirectly(ReportUsage,RecRef,DocNo,DocName,FALSE,No)
        ELSE
          SendEmailToCustDirectly(ReportUsage,RecRef,DocNo,DocName,FALSE,No);
    end;

    local procedure GetNextParam(var Parameter: Text): Text
    var
        i: Integer;
        Result: Text;
    begin
        i := STRPOS(Parameter,'|');
        IF i > 0 THEN
          Result := COPYSTR(Parameter,1,i - 1);
        IF (i + 1) < STRLEN(Parameter) THEN
          Parameter := COPYSTR(Parameter,i + 1);
        EXIT(Result);
    end;

    procedure SendEmailToCust(ReportUsage: Integer;RecordVariant: Variant;DocNo: Code[20];DocName: Text[150];ShowDialog: Boolean;CustNo: Code[20])
    var
        JobQueueEntry: Record "472";
        SMTPMail: Codeunit "400";
        OfficeMgt: Codeunit "1630";
        RecRef: RecordRef;
    begin
        IF ShowDialog OR NOT SMTPMail.IsEnabled OR (GetCustEmailAddress(CustNo) = '') OR OfficeMgt.IsAvailable THEN BEGIN
          SendEmailToCustDirectly(ReportUsage,RecordVariant,DocNo,DocName,TRUE,CustNo);
          EXIT;
        END;

        RecRef.GETTABLE(RecordVariant);
        JobQueueEntry.INIT;
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run" := CODEUNIT::"Document-Mailing";
        JobQueueEntry."Maximum No. of Attempts to Run" := 3;
        JobQueueEntry."Record ID to Process" := RecRef.RECORDID;
        JobQueueEntry."Parameter String" := STRSUBSTNO('%1|%2|%3|%4|',ReportUsage,DocNo,DocName,CustNo);
        JobQueueEntry.Description := COPYSTR(DocName,1,MAXSTRLEN(JobQueueEntry.Description));
        CODEUNIT.RUN(CODEUNIT::"Job Queue - Enqueue",JobQueueEntry);
    end;

    procedure SendEmailToVendor(ReportUsage: Integer;RecordVariant: Variant;DocNo: Code[20];DocName: Text[150];ShowDialog: Boolean;VendorNo: Code[20])
    var
        JobQueueEntry: Record "472";
        SMTPMail: Codeunit "400";
        OfficeMgt: Codeunit "1630";
        RecRef: RecordRef;
    begin
        IF ShowDialog OR NOT SMTPMail.IsEnabled OR (GetVendorEmailAddress(VendorNo) = '') OR OfficeMgt.IsAvailable THEN BEGIN
          SendEmailToVendorDirectly(ReportUsage,RecordVariant,DocNo,DocName,TRUE,VendorNo);
          EXIT;
        END;

        RecRef.GETTABLE(RecordVariant);
        JobQueueEntry.INIT;
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run" := CODEUNIT::"Document-Mailing";
        JobQueueEntry."Maximum No. of Attempts to Run" := 3;
        JobQueueEntry."Record ID to Process" := RecRef.RECORDID;
        JobQueueEntry."Parameter String" := STRSUBSTNO('%1|%2|%3|%4|%5',ReportUsage,DocNo,DocName,VendorNo,'Vendor');
        JobQueueEntry.Description := COPYSTR(DocName,1,MAXSTRLEN(JobQueueEntry.Description));
        CODEUNIT.RUN(CODEUNIT::"Job Queue - Enqueue",JobQueueEntry);
    end;

    local procedure SendEmailToCustDirectly(ReportUsage: Integer;RecordVariant: Variant;DocNo: Code[20];DocName: Text[150];ShowDialog: Boolean;CustNo: Code[20])
    var
        TempAttachReportSelections: Record "77" temporary;
        CustomReportSelection: Record "9657";
        ReportDistributionManagement: Codeunit "452";
        FoundBody: Boolean;
        FoundAttachment: Boolean;
        ServerEmailBodyFilePath: Text[250];
        EmailAddress: Text[250];
    begin
        BINDSUBSCRIPTION(ReportDistributionManagement);
        FoundBody := GetEmailBody(ServerEmailBodyFilePath,ReportUsage,RecordVariant,CustNo,EmailAddress);
        UNBINDSUBSCRIPTION(ReportDistributionManagement);
        FoundAttachment := FindEmailAttachmentUsage(ReportUsage,CustNo,TempAttachReportSelections);

        CustomReportSelection.SETRANGE("Source Type",DATABASE::Customer);
        CustomReportSelection.SETFILTER("Source No.",CustNo);
        SendEmailDirectly(
          ReportUsage,RecordVariant,DocNo,DocName,FoundBody,FoundAttachment,ServerEmailBodyFilePath,EmailAddress,ShowDialog,
          TempAttachReportSelections,CustomReportSelection);
    end;

    local procedure SendEmailToVendorDirectly(ReportUsage: Integer;RecordVariant: Variant;DocNo: Code[20];DocName: Text[150];ShowDialog: Boolean;VendorNo: Code[20])
    var
        TempAttachReportSelections: Record "77" temporary;
        CustomReportSelection: Record "9657";
        FoundBody: Boolean;
        FoundAttachment: Boolean;
        ServerEmailBodyFilePath: Text[250];
        EmailAddress: Text[250];
    begin
        FoundBody := GetEmailBodyVendor(ServerEmailBodyFilePath,ReportUsage,RecordVariant,VendorNo,EmailAddress);
        FoundAttachment := FindEmailAttachmentUsageVendor(ReportUsage,VendorNo,TempAttachReportSelections);

        CustomReportSelection.SETRANGE("Source Type",DATABASE::Vendor);
        CustomReportSelection.SETFILTER("Source No.",VendorNo);
        SendEmailDirectly(
          ReportUsage,RecordVariant,DocNo,DocName,FoundBody,FoundAttachment,ServerEmailBodyFilePath,EmailAddress,ShowDialog,
          TempAttachReportSelections,CustomReportSelection);
    end;

    local procedure SendEmailDirectly(ReportUsage: Integer;RecordVariant: Variant;DocNo: Code[20];DocName: Text[150];FoundBody: Boolean;FoundAttachment: Boolean;ServerEmailBodyFilePath: Text[250];var DefaultEmailAddress: Text[250];ShowDialog: Boolean;var TempAttachReportSelections: Record "77" temporary;var CustomReportSelection: Record "9657")
    var
        DocumentMailing: Codeunit "260";
        OfficeAttachmentManager: Codeunit "1629";
        ServerAttachmentFilePath: Text[250];
        EmailAddress: Text[250];
        SalesHeader: Record "36";
        PurchHeader: Record "38";
    begin
        ShowNoBodyNoAttachmentError(ReportUsage,FoundBody,FoundAttachment);

        IF FoundBody AND NOT FoundAttachment THEN
          DocumentMailing.EmailFile('','',ServerEmailBodyFilePath,DocNo,EmailAddress,DocName,NOT ShowDialog,ReportUsage);

        //BC6>>
        CASE ReportUsage OF
          Usage::"S.Order", Usage::"S.Quote":
          BEGIN
            SalesHeader := RecordVariant;
            DocumentMailing.SetYourReference(SalesHeader."Your Reference");
          END;
        //  Usage::"P.Order":
        //  BEGIN
        //    PurchHeader := RecordVariant;
        //    DocumentMailing.SetYourReference(PurchHeader."Your Reference");
        //  END;
        END;
        //BC6<<

        IF FoundAttachment THEN BEGIN
          IF ReportUsage = Usage::JQ THEN BEGIN
            Usage := ReportUsage;
            CustomReportSelection.SETFILTER(Usage,GETFILTER(Usage));
            IF CustomReportSelection.FINDFIRST THEN
              IF CustomReportSelection."Send To Email" <> '' THEN
                DefaultEmailAddress := CustomReportSelection."Send To Email";
          END;

          WITH TempAttachReportSelections DO BEGIN
            OfficeAttachmentManager.IncrementCount(COUNT - 1);
            REPEAT
              EmailAddress := COPYSTR(
                  GetNextEmailAddressFromCustomReportSelection(CustomReportSelection,DefaultEmailAddress,Usage,Sequence),
                  1,MAXSTRLEN(EmailAddress));

              //BC6>>
              IF ReportUsage IN [Usage::"S.Order", Usage::"S.Quote"] THEN BEGIN
                SalesHeader := RecordVariant;
                IF SalesHeader."Sell-to E-Mail Address" <> '' THEN
                  EmailAddress := SalesHeader."Sell-to E-Mail Address";
              END;
              //BC6<<
              ServerAttachmentFilePath := SaveReportAsPDF("Report ID",RecordVariant,"Custom Report Layout Code");
              DocumentMailing.EmailFile(
                ServerAttachmentFilePath,
                '',
                ServerEmailBodyFilePath,
                DocNo,
                EmailAddress,
                DocName,
                NOT ShowDialog,
                ReportUsage);
            UNTIL NEXT = 0;
          END;
        END;
    end;

    procedure SendToDisk(ReportUsage: Integer;RecordVariant: Variant;DocNo: Code[20];DocName: Text;CustNo: Code[20])
    var
        TempReportSelections: Record "77" temporary;
        ElectronicDocumentFormat: Record "61";
        FileManagement: Codeunit "419";
        ServerAttachmentFilePath: Text[250];
        ClientAttachmentFileName: Text;
    begin
        FindPrintUsage(ReportUsage,CustNo,TempReportSelections);
        WITH TempReportSelections DO
          REPEAT
            ServerAttachmentFilePath := SaveReportAsPDF("Report ID",RecordVariant,"Custom Report Layout Code");
            ClientAttachmentFileName := ElectronicDocumentFormat.GetAttachmentFileName(DocNo,DocName,'pdf');
            FileManagement.DownloadHandler(
              ServerAttachmentFilePath,
              '',
              '',
              FileManagement.GetToFilterText('',ClientAttachmentFileName),
              ClientAttachmentFileName);
          UNTIL NEXT = 0;
    end;

    procedure SendToDiskVendor(ReportUsage: Integer;RecordVariant: Variant;DocNo: Code[20];DocName: Text;VendorNo: Code[20])
    var
        TempReportSelections: Record "77" temporary;
        ElectronicDocumentFormat: Record "61";
        FileManagement: Codeunit "419";
        ServerAttachmentFilePath: Text[250];
        ClientAttachmentFileName: Text;
    begin
        FindPrintUsageVendor(ReportUsage,VendorNo,TempReportSelections);
        WITH TempReportSelections DO
          REPEAT
            ServerAttachmentFilePath := SaveReportAsPDF("Report ID",RecordVariant,"Custom Report Layout Code");
            ClientAttachmentFileName := ElectronicDocumentFormat.GetAttachmentFileName(DocNo,DocName,'pdf');
            FileManagement.DownloadHandler(
              ServerAttachmentFilePath,
              '',
              '',
              FileManagement.GetToFilterText('',ClientAttachmentFileName),
              ClientAttachmentFileName);
          UNTIL NEXT = 0;
    end;

    procedure SendToZip(ReportUsage: Integer;RecordVariant: Variant;DocNo: Code[20];CustNo: Code[20];var FileManagement: Codeunit "419")
    var
        TempReportSelections: Record "77" temporary;
        ElectronicDocumentFormat: Record "61";
        ServerAttachmentFilePath: Text;
    begin
        FindPrintUsage(ReportUsage,CustNo,TempReportSelections);
        WITH TempReportSelections DO
          REPEAT
            ServerAttachmentFilePath := SaveReportAsPDF("Report ID",RecordVariant,"Custom Report Layout Code");
            FileManagement.AddFileToZipArchive(
              ServerAttachmentFilePath,
              ElectronicDocumentFormat.GetAttachmentFileName(DocNo,'Invoice','pdf'));
          UNTIL NEXT = 0;
    end;

    procedure SendToZipVendor(ReportUsage: Integer;RecordVariant: Variant;DocNo: Code[20];VendorNo: Code[20];var FileManagement: Codeunit "419")
    var
        TempReportSelections: Record "77" temporary;
        ElectronicDocumentFormat: Record "61";
        ServerAttachmentFilePath: Text;
    begin
        FindPrintUsageVendor(ReportUsage,VendorNo,TempReportSelections);
        WITH TempReportSelections DO
          REPEAT
            ServerAttachmentFilePath := SaveReportAsPDF("Report ID",RecordVariant,"Custom Report Layout Code");
            FileManagement.AddFileToZipArchive(
              ServerAttachmentFilePath,
              ElectronicDocumentFormat.GetAttachmentFileName(DocNo,'Purchase Order','pdf'));
          UNTIL NEXT = 0;
    end;

    procedure GetCustEmailAddress(BillToCustomerNo: Code[20]): Text[250]
    var
        Customer: Record "18";
        ToAddress: Text;
    begin
        IF Customer.GET(BillToCustomerNo) THEN
          ToAddress := Customer."E-Mail";

        EXIT(ToAddress);
    end;

    procedure GetVendorEmailAddress(BuyFromVendorNo: Code[20]): Text[250]
    var
        Vendor: Record "23";
        ToAddress: Text;
    begin
        IF Vendor.GET(BuyFromVendorNo) THEN
          ToAddress := Vendor."E-Mail";

        EXIT(ToAddress);
    end;

    local procedure SaveReportAsPDF(ReportID: Integer;RecordVariant: Variant;LayoutCode: Code[20]) FilePath: Text[250]
    var
        ReportLayoutSelection: Record "9651";
        FileMgt: Codeunit "419";
    begin
        FilePath := COPYSTR(FileMgt.ServerTempFileName('pdf'),1,250);

        ReportLayoutSelection.SetTempLayoutSelected(LayoutCode);
        REPORT.SAVEASPDF(ReportID,FilePath,RecordVariant);
        ReportLayoutSelection.SetTempLayoutSelected('');

        COMMIT;
    end;

    local procedure SaveReportAsHTML(ReportID: Integer;RecordVariant: Variant;LayoutCode: Code[20]) FilePath: Text[250]
    var
        ReportLayoutSelection: Record "9651";
        FileMgt: Codeunit "419";
    begin
        FilePath := COPYSTR(FileMgt.ServerTempFileName('html'),1,250);

        ReportLayoutSelection.SetTempLayoutSelected(LayoutCode);
        REPORT.SAVEASHTML(ReportID,FilePath,RecordVariant);
        ReportLayoutSelection.SetTempLayoutSelected('');

        COMMIT;
    end;

    local procedure FindReportSelections(var ReportSelections: Record "77";CustNo: Code[20]): Boolean
    begin
        IF CopyCustomReportSectionToReportSelection(CustNo,ReportSelections) THEN
          EXIT(TRUE);
        EXIT(CopyReportSelectionToReportSelection(ReportSelections));
    end;

    local procedure FindReportSelectionsVendor(var ReportSelections: Record "77";VendorNo: Code[20]): Boolean
    begin
        IF CopyCustomReportSectionToReportSelectionVendor(VendorNo,ReportSelections) THEN
          EXIT(TRUE);
        EXIT(CopyReportSelectionToReportSelection(ReportSelections));
    end;

    local procedure CopyCustomReportSectionToReportSelection(CustNo: Code[20];var ToReportSelections: Record "77"): Boolean
    var
        CustomReportSelection: Record "9657";
    begin
        GetCustomReportSelectionByUsageFilter(CustomReportSelection,CustNo,GETFILTER(Usage));
        CopyToReportSelection(ToReportSelections,CustomReportSelection);

        IF NOT ToReportSelections.FINDSET THEN
          EXIT(FALSE);
        EXIT(TRUE);
    end;

    local procedure CopyCustomReportSectionToReportSelectionVendor(VendorNo: Code[20];var ToReportSelections: Record "77"): Boolean
    var
        CustomReportSelection: Record "9657";
    begin
        GetCustomReportSelectionByUsageFilterVendor(CustomReportSelection,VendorNo,GETFILTER(Usage));
        CopyToReportSelection(ToReportSelections,CustomReportSelection);

        IF NOT ToReportSelections.FINDSET THEN
          EXIT(FALSE);
        EXIT(TRUE);
    end;

    local procedure CopyToReportSelection(var ToReportSelections: Record "77";var CustomReportSelection: Record "9657")
    begin
        ToReportSelections.RESET;
        ToReportSelections.DELETEALL;
        IF CustomReportSelection.FINDSET THEN
          REPEAT
            ToReportSelections.Usage := CustomReportSelection.Usage;
            ToReportSelections.Sequence := FORMAT(CustomReportSelection.Sequence);
            ToReportSelections."Report ID" := CustomReportSelection."Report ID";
            ToReportSelections."Custom Report Layout Code" := CustomReportSelection."Custom Report Layout Code";
            ToReportSelections."Email Body Layout Code" := CustomReportSelection."Email Body Layout Code";
            ToReportSelections."Use for Email Attachment" := CustomReportSelection."Use for Email Attachment";
            ToReportSelections."Use for Email Body" := CustomReportSelection."Use for Email Body";
            ToReportSelections.INSERT;
          UNTIL CustomReportSelection.NEXT = 0;
    end;

    local procedure CopyReportSelectionToReportSelection(var ToReportSelections: Record "77"): Boolean
    begin
        ToReportSelections.RESET;
        ToReportSelections.DELETEALL;
        IF FINDSET THEN
          REPEAT
            ToReportSelections := Rec;
            ToReportSelections.INSERT;
          UNTIL NEXT = 0;

        EXIT(ToReportSelections.FINDSET);
    end;

    local procedure GetCustomReportSelection(var CustomReportSelection: Record "9657";CustNo: Code[20]): Boolean
    begin
        CustomReportSelection.SETRANGE("Source Type",DATABASE::Customer);
        CustomReportSelection.SETFILTER("Source No.",CustNo);
        IF CustomReportSelection.ISEMPTY THEN
          EXIT(FALSE);

        CustomReportSelection.SETFILTER("Use for Email Attachment",GETFILTER("Use for Email Attachment"));
        CustomReportSelection.SETFILTER("Use for Email Body",GETFILTER("Use for Email Body"));
    end;

    local procedure GetCustomReportSelectionVendor(var CustomReportSelection: Record "9657";VendorNo: Code[20]): Boolean
    begin
        CustomReportSelection.SETRANGE("Source Type",DATABASE::Vendor);
        CustomReportSelection.SETFILTER("Source No.",VendorNo);
        IF CustomReportSelection.ISEMPTY THEN
          EXIT(FALSE);

        CustomReportSelection.SETFILTER("Use for Email Attachment",GETFILTER("Use for Email Attachment"));
        CustomReportSelection.SETFILTER("Use for Email Body",GETFILTER("Use for Email Body"));
    end;

    local procedure GetCustomReportSelectionByUsageFilter(var CustomReportSelection: Record "9657";CustNo: Code[20];ReportUsageFilter: Text): Boolean
    begin
        CustomReportSelection.SETFILTER(Usage,ReportUsageFilter);
        EXIT(GetCustomReportSelection(CustomReportSelection,CustNo));
    end;

    local procedure GetCustomReportSelectionByUsageFilterVendor(var CustomReportSelection: Record "9657";VendorNo: Code[20];ReportUsageFilter: Text): Boolean
    begin
        CustomReportSelection.SETFILTER(Usage,ReportUsageFilter);
        EXIT(GetCustomReportSelectionVendor(CustomReportSelection,VendorNo));
    end;

    local procedure GetCustomReportSelectionByUsageOption(var CustomReportSelection: Record "9657";CustNo: Code[20];ReportUsage: Integer): Boolean
    begin
        CustomReportSelection.SETRANGE(Usage,ReportUsage);
        EXIT(GetCustomReportSelection(CustomReportSelection,CustNo));
    end;

    local procedure GetCustomReportSelectionByUsageOptionVendor(var CustomReportSelection: Record "9657";VendorNo: Code[20];ReportUsage: Integer): Boolean
    begin
        CustomReportSelection.SETRANGE(Usage,ReportUsage);
        EXIT(GetCustomReportSelectionVendor(CustomReportSelection,VendorNo));
    end;

    local procedure GetNextEmailAddressFromCustomReportSelection(var CustomReportSelection: Record "9657";DefaultEmailAddress: Text;UsageValue: Option;SequenceText: Text): Text
    var
        SequenceInteger: Integer;
    begin
        IF EVALUATE(SequenceInteger,SequenceText) THEN BEGIN
          CustomReportSelection.SETRANGE(Usage,UsageValue);
          CustomReportSelection.SETRANGE(Sequence,SequenceInteger);
          IF CustomReportSelection.FINDFIRST THEN
            IF CustomReportSelection."Send To Email" <> '' THEN
              EXIT(CustomReportSelection."Send To Email");
        END;
        EXIT(DefaultEmailAddress);
    end;

    procedure PrintForUsage(ReportUsage: Integer)
    begin
        FilterPrintUsage(ReportUsage);
        IF FINDSET THEN
          REPEAT
            REPORT.RUNMODAL("Report ID",TRUE);
          UNTIL NEXT = 0;
    end;

    local procedure FindEmailAddressForEmailLayout(LayoutCode: Code[20];CustNo: Code[20];ReportUsage: Integer): Text[200]
    var
        CustomReportSelection: Record "9657";
    begin
        // Search for a potential email address from Custom Report Selections
        GetCustomReportSelectionByUsageOption(CustomReportSelection,CustNo,ReportUsage);
        CustomReportSelection.SETFILTER("Send To Email",'<>%1','');
        CustomReportSelection.SETRANGE("Email Body Layout Code",LayoutCode);
        IF CustomReportSelection.FINDFIRST THEN
          EXIT(CustomReportSelection."Send To Email");

        // Relax the filter and search for an email address
        CustomReportSelection.SETFILTER("Use for Email Body",'');
        CustomReportSelection.SETRANGE("Email Body Layout Code",'');
        IF CustomReportSelection.FINDFIRST THEN
          EXIT(CustomReportSelection."Send To Email");
        EXIT('');
    end;

    local procedure FindEmailAddressForEmailLayoutVendor(LayoutCode: Code[20];VendorNo: Code[20];ReportUsage: Integer): Text[200]
    var
        CustomReportSelection: Record "9657";
    begin
        // Search for a potential email address from Custom Report Selections
        GetCustomReportSelectionByUsageOptionVendor(CustomReportSelection,VendorNo,ReportUsage);
        CustomReportSelection.SETFILTER("Send To Email",'<>%1','');
        CustomReportSelection.SETRANGE("Email Body Layout Code",LayoutCode);
        IF CustomReportSelection.FINDFIRST THEN
          EXIT(CustomReportSelection."Send To Email");

        // Relax the filter and search for an email address
        CustomReportSelection.SETFILTER("Use for Email Body",'');
        CustomReportSelection.SETRANGE("Email Body Layout Code",'');
        IF CustomReportSelection.FINDFIRST THEN
          EXIT(CustomReportSelection."Send To Email");
        EXIT('');
    end;

    local procedure ShowNoBodyNoAttachmentError(ReportUsage: Integer;FoundBody: Boolean;FoundAttachment: Boolean)
    begin
        IF NOT (FoundBody OR FoundAttachment) THEN BEGIN
          Usage := ReportUsage;
          ERROR(MustSelectAndEmailBodyOrAttahmentErr,Usage);
        END;
    end;

    var
        MustSelectAndEmailBodyOrAttahmentErr: Label 'You must select an email body or attachment in report selection for %1.', Comment='%1 = Usage, for example Sales Invoice';
        EmailBodyIsAlreadyDefinedErr: Label 'An email body is already defined for %1.', Comment='%1 = Usage, for example Sales Invoice';
        CannotBeUsedAsAnEmailBodyErr: Label 'Report %1 uses the %2 which cannot be used as an email body.', Comment='%1 = Report ID,%2 = Type';
        ReportLayoutSelection: Record "9651";
}

