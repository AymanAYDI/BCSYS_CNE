report 50019 "BC6_Affair List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './AffairList.rdlc';

    Caption = 'Affair List';
    Permissions = TableData "BC6_Affair Steps" = rimd;

    dataset
    {
        dataitem(Job; Job)
        {

            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "BC6_Affair Responsible";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column("USERID"; USERID)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Job__No__; "No.")
            {
            }
            column(Job_Description; Description)
            {
            }
            column(Job__Affair_Responsible_; "BC6_Affair Responsible")
            {
            }
            column(Job_Statut; "BC6_Statut")
            {
            }
            column(TxtGContact; TxtGContact)
            {
            }
            column(TxtGContactType; TxtGContactType)
            {
            }
            column(TxtGContactPhone; TxtGContactPhone)
            {
            }
            column(TxtGContactTiers; TxtGContactTiers)
            {
            }
            column(BooGAwarder; FORMAT(BooGAwarder))
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Business_ListCaption; Business_ListCaptionLbl)
            {
            }
            column(Customer_Or_VendorCaption; Customer_Or_VendorCaptionLbl)
            {
            }
            column(Phone_No_Caption; Phone_No_CaptionLbl)
            {
            }
            column(Contact_TypeCaption; Contact_TypeCaptionLbl)
            {
            }
            column(ContactCaption; ContactCaptionLbl)
            {
            }
            column(Job_StatutCaption; FIELDCAPTION("BC6_Statut"))
            {
            }
            column(Affair_responsible_CNECaption; Affair_responsible_CNECaptionLbl)
            {
            }
            column(BooGShowQuote_; BooGShowQuote)
            {
            }
            column(BooGShowSteps_; BooGShowSteps)
            {
            }
            column(Affair_NameCaption; Affair_NameCaptionLbl)
            {
            }
            column(Affair_No_Caption; Affair_No_CaptionLbl)
            {
            }
            column(Awa_Caption; Awa_CaptionLbl)
            {
            }
            column(QuoteCaption; QuoteCaptionLbl)
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(InterocutorCaption; InterocutorCaptionLbl)
            {
            }
            column(Awa_Caption_Control1000000109; Awa_Caption_Control1000000109Lbl)
            {
            }
            column(Quote_AmountCaption; Quote_AmountCaptionLbl)
            {
            }
            column(Quote_ProfitCaption; Quote_ProfitCaptionLbl)
            {
            }
            column(ContactCaption_Control1000000021; ContactCaption_Control1000000021Lbl)
            {
            }
            column(StepCaption; StepCaptionLbl)
            {
            }
            column(Attached_ContactCaption; Attached_ContactCaptionLbl)
            {
            }
            column(InterlocutorCaption; InterlocutorCaptionLbl)
            {
            }
            column(Affair_Steps__Contact_Name_Caption; BC6_AffairSteps.FIELDCAPTION("Contact Name"))
            {
            }
            column(Reminder_DateCaption; Reminder_DateCaptionLbl)
            {
            }
            dataitem(ContactProjectRel; "BC6_Contact Project Relation")
            {
                DataItemLink = "Affair No." = FIELD("No.");
                DataItemTableView = SORTING("Contact No.", "Affair No.")
                                    ORDER(Ascending);
                RequestFilterFields = "Contact No.";
                column(TxtGContact_Control1000000039; TxtGContact)
                {
                }
                column(TxtGContactType_Control1000000040; TxtGContactType)
                {
                }
                column(TxtGContactPhone_Control1000000041; TxtGContactPhone)
                {
                }
                column(TxtGContactTiers_Control1000000042; TxtGContactTiers)
                {
                }
                column(Contact_Project_Relation__Awarder; FORMAT(ContactProjectRel.Awarder))
                {
                }
                column(Contact_Project_Relation_Contact_No_; "Contact No.")
                {
                }
                column(Contact_Project_Relation_Affair_No_; "Affair No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF TxtGContact = "Contact No." + ' ' + ContactProjectRel."Contact Name" THEN
                        CurrReport.SKIP;

                    TxtGContactTiers := '';
                    TxtGContact := '';
                    TxtGContactType := '';
                    TxtGContactPhone := '';
                    TxtGContactTiers := '';

                    IF RecGContact.GET("Contact No.") THEN BEGIN
                        TxtGContact := RecGContact."No." + ' ' + RecGContact.Name;
                        TxtGContactType := FORMAT(RecGContact.Type);
                        TxtGContactPhone := FORMAT(RecGContact."Phone No.");


                        RecGCntBusiness.RESET;
                        RecGCntBusiness.SETFILTER("Contact No.", RecGContact."Company No.");

                        RecGCntBusiness.SETRANGE(RecGCntBusiness."Link to Table", RecGCntBusiness."Link to Table"::Customer);
                        IF NOT RecGCntBusiness.FINDFIRST THEN
                            RecGCntBusiness.SETRANGE(RecGCntBusiness."Link to Table", RecGCntBusiness."Link to Table"::Vendor);

                        IF RecGCntBusiness.FINDFIRST THEN
                            TxtGContactTiers := RecGCntBusiness."No.";
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    IF TxtGcontactfilter <> '' THEN
                        SETFILTER("Contact No.", TxtGcontactfilter);
                    IF CodGCustomer <> '' THEN
                        SETFILTER("No.", CodGCustomer);
                    IF CodGVendor <> '' THEN
                        SETFILTER("No.", CodGVendor);
                end;
            }
            dataitem(SalesHeader; "Sales Header")
            {
                DataItemLink = "BC6_Affair No." = FIELD("No.");
                DataItemTableView = SORTING("BC6_Affair No.")
                                    ORDER(Ascending)
                                    WHERE("Document Type" = CONST(Quote),
                                          "BC6_Affair No." = FILTER(<> ''));
                column(Sales_Header__Amount_Including_VAT_; "Amount Including VAT")
                {
                }
                column(DecGProfitLCY; DecGProfitLCY)
                {
                }
                column(Sales_Header__Bill_to_Contact_; "Bill-to Contact")
                {
                }
                column(Sales_Header__Sell_to_Customer_No__; "Sell-to Customer No.")
                {
                }
                column(Sales_Header__No__; "No.")
                {
                }
                column(TxtHInterlocutor; TxtHInterlocutor)
                {
                }
                column(BooGAwarder_Control1000000111; FORMAT(BooGAwarder))
                {
                }
                column(Sales_Header_Document_Type; "Document Type")
                {
                }
                column(Sales_Header_Affair_No_; "BC6_Affair No.")
                {
                }

                trigger OnAfterGetRecord()
                var
                    RecLSalesLine: Record "Sales Line";
                begin
                    CLEAR(DecGProfitLCY);
                    CLEAR(DecGAmount);
                    CLEAR(DecGCost);


                    RecLSalesLine.RESET;
                    RecLSalesLine.SETFILTER("Document Type", '%1', SalesHeader."Document Type");
                    RecLSalesLine.SETFILTER("Document No.", SalesHeader."No.");

                    IF RecLSalesLine.FindSet() THEN
                        REPEAT
                            DecGAmount += RecLSalesLine.Amount;
                            DecGCost += RecLSalesLine."BC6_Purchase cost" * RecLSalesLine.Quantity;
                        UNTIL RecLSalesLine.NEXT = 0;


                    DecGProfitLCY := DecGAmount - DecGCost;


                    BooGAwarder := FALSE;
                    IF RecGContactProjectRelation.GET(SalesHeader."Bill-to Contact No.", SalesHeader."BC6_Affair No.") THEN
                        IF RecGContactProjectRelation.Awarder = TRUE THEN
                            BooGAwarder := TRUE;

                end;
            }
            dataitem(BC6_AffairSteps; "BC6_Affair Steps")
            {
                DataItemLink = "Affair No." = FIELD("No.");
                DataItemTableView = SORTING("No.", "Affair No.")
                                    ORDER(Ascending);
                RequestFilterFields = Interlocutor;
                column(Affair_Steps_Description; Description)
                {
                }
                column(Affair_Steps_Contact; Contact)
                {
                }
                column(Affair_Steps__Reminder_Date_; "Reminder Date")
                {
                }
                column(Affair_Steps_Interlocutor; Interlocutor)
                {
                }
                column(Affair_Steps__Contact_Name_; "Contact Name")
                {
                }
                column(Affair_Steps_No_; "No.")
                {
                }
                column(Affair_Steps_Affair_No_; "Affair No.")
                {
                }

                trigger OnPreDataItem()
                begin
                    IF FORMAT(TxtGTerminatedFilter) <> '' THEN
                        SETRANGE(BC6_AffairSteps.Terminated, TxtGTerminatedFilter);

                    //>FEP6-ACHAT-200706_18_A.001
                    IF TxtGRemindDateFilter <> '' THEN
                        BC6_AffairSteps.SETFILTER("Reminder Date", TxtGRemindDateFilter);
                    IF TxtGInterlocutor <> '' THEN
                        BC6_AffairSteps.SETFILTER(Interlocutor, TxtGInterlocutor);
                    //<FEP6-ACHAT-200706_18_A.001
                end;
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(Integer_Number; Number)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                BooGAwarder := FALSE;
                IF TxtGcontactfilter <> '' THEN BEGIN
                    RecGCntAffair.SETFILTER(RecGCntAffair."Contact No.", TxtGcontactfilter);
                    RecGCntAffair.SETFILTER(RecGCntAffair."Affair No.", Job."No.");
                    IF NOT RecGCntAffair.FIND('-') THEN CurrReport.SKIP;
                END;

                IF CodGCustomer <> '' THEN BEGIN
                    RecGCntAffair.RESET;
                    RecGCntAffair.SETFILTER(RecGCntAffair."Affair No.", Job."No.");
                    RecGCntAffair.SETFILTER(RecGCntAffair."No.", CodGCustomer);
                    IF NOT RecGCntAffair.FIND('-') THEN CurrReport.SKIP;
                END;

                IF CodGVendor <> '' THEN BEGIN
                    RecGCntAffair.RESET;
                    RecGCntAffair.SETFILTER(RecGCntAffair."Affair No.", Job."No.");
                    RecGCntAffair.SETFILTER(RecGCntAffair."No.", CodGVendor);
                    IF NOT RecGCntAffair.FIND('-') THEN CurrReport.SKIP;
                END;

                IF TxtGInterlocutor <> '' THEN BEGIN
                    RecGAffairSteps.RESET;
                    RecGAffairSteps.SETFILTER(RecGAffairSteps."Affair No.", Job."No.");
                    RecGAffairSteps.SETFILTER(RecGAffairSteps.Interlocutor, TxtGInterlocutor);
                    IF NOT RecGAffairSteps.FIND('-') THEN CurrReport.SKIP;
                END;

                IF TxtGRemindDateFilter <> '' THEN BEGIN
                    RecGAffairSteps.RESET;
                    RecGAffairSteps.SETFILTER(RecGAffairSteps."Affair No.", Job."No.");
                    RecGAffairSteps.SETFILTER(RecGAffairSteps."Reminder Date", TxtGRemindDateFilter);
                END;

                RecGCntAffair.RESET;
                RecGCntAffair.SETFILTER(RecGCntAffair."Affair No.", Job."No.");

                IF RecGCntAffair.FINDFIRST THEN BEGIN
                    IF RecGContact.GET(RecGCntAffair."Contact No.") THEN BEGIN
                        TxtGContact := RecGContact."No." + ' ' + RecGContact.Name;
                        TxtGContactType := FORMAT(RecGContact.Type);
                        TxtGContactPhone := FORMAT(RecGContact."Phone No.");
                        BooGAwarder := RecGCntAffair.Awarder;
                        RecGCntBusiness.RESET;
                        RecGCntBusiness.SETFILTER(RecGCntBusiness."Contact No.", RecGCntAffair."Contact No.");
                        RecGCntBusiness.SETRANGE(RecGCntBusiness."Link to Table", RecGCntBusiness."Link to Table"::Customer);
                        IF NOT RecGCntBusiness.FindSet() THEN
                            RecGCntBusiness.SETRANGE(RecGCntBusiness."Link to Table", RecGCntBusiness."Link to Table"::Vendor);

                        IF RecGCntBusiness.FindSet() THEN
                            TxtGContactTiers := RecGCntBusiness."No."
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                IF FORMAT(TxtGStatutFilter) <> '' THEN
                    SETRANGE(Job."BC6_Statut", TxtGStatutFilter);
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
                    field(TxtGStatutFilter; TxtGStatutFilter)
                    {
                        Caption = 'Status';
                        OptionCaption = ' ,Outstanding,Lost,Won';
                    }
                    field(TxtGRemindDateFilter; TxtGRemindDateFilter)
                    {
                        Caption = 'Reminder Date';

                        trigger OnValidate()
                        begin

                            IF TxtGRemindDateFilter <> '' THEN BEGIN
                                RecGJob.SETFILTER("Posting Date Filter", TxtGRemindDateFilter);
                                EVALUATE(TxtGRemindDateFilter, RecGJob.GETFILTER("Posting Date Filter"));
                            END;
                        end;
                    }
                    field(TxtGTerminatedFilter; TxtGTerminatedFilter)
                    {
                        Caption = 'Terminer';
                    }
                    field(BooGShowQuote; BooGShowQuote)
                    {
                        Caption = 'Show Quote Details';
                    }
                    field(BooGShowSteps; BooGShowSteps)
                    {
                        Caption = 'Show Steps';
                    }
                    field(CodGCustomer; CodGCustomer)
                    {
                        Caption = 'Customer Code';
                        TableRelation = Customer;
                    }
                    field(CodGVendor; CodGVendor)
                    {
                        Caption = 'Vendor Code';
                        TableRelation = Vendor;
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

    trigger OnInitReport()
    var
        TextGDate: Text[30];
    begin
        TextGDate := '..' + FORMAT(CALCDATE('<CM>'));
        EVALUATE(TxtGRemindDateFilter, TextGDate);
    end;

    trigger OnPreReport()
    begin
        TxtGcontactfilter := ContactProjectRel.GETFILTER(ContactProjectRel."Contact No.");
        TxtGInterlocutor := BC6_AffairSteps.GETFILTER(BC6_AffairSteps.Interlocutor);
    end;

    var
        RecGAffairSteps: Record "BC6_Affair Steps";
        RecGCntAffair: Record "BC6_Contact Project Relation";
        RecGContactProjectRelation: Record "BC6_Contact Project Relation";
        RecGContact: Record Contact;
        RecGCntBusiness: Record "Contact Business Relation";
        RecGJob: Record Job;
        BooGAwarder: Boolean;
        BooGShowQuote: Boolean;
        BooGShowSteps: Boolean;
        TxtGTerminatedFilter: Boolean;
        CodGCustomer: Code[20];
        CodGVendor: Code[20];
        DecGAmount: Decimal;
        DecGCost: Decimal;
        DecGProfitLCY: Decimal;
        Affair_NameCaptionLbl: Label 'Affair Name', comment = 'FRA="Nom de l''affaire"';
        Affair_No_CaptionLbl: Label 'Affair No.', comment = 'FRA="N° Affaire"';
        Affair_responsible_CNECaptionLbl: Label 'Affair responsible CNE', comment = 'FRA="Chargé d''affaire CNE"';
        Attached_ContactCaptionLbl: Label 'Attached Contact', comment = 'FRA="Contact lié"';
        Awa_Caption_Control1000000109Lbl: Label 'Awa.', comment = 'FRA="Adj."';
        Awa_CaptionLbl: Label 'Awa.', comment = 'FRA="Adj."';
        Business_ListCaptionLbl: Label 'Business List', comment = 'FRA="Liste des affaires"';
        Contact_TypeCaptionLbl: Label 'Contact Type', comment = 'FRA=""';
        ContactCaption_Control1000000021Lbl: Label 'Contact', comment = 'FRA=""';
        ContactCaptionLbl: Label 'Contact';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Customer_Or_VendorCaptionLbl: Label 'Customer Or Vendor', comment = 'FRA="Client ou fournisseur"';
        CustomerCaptionLbl: Label 'Customer', comment = 'FRA="Client"';
        InterlocutorCaptionLbl: Label 'Interlocutor', comment = 'FRA="Interlocuteur"';
        InterocutorCaptionLbl: Label 'Interocutor', comment = 'FRA="Interlocuteur"';
        Phone_No_CaptionLbl: Label 'Phone No.', comment = 'FRA="N° tel"';
        Quote_AmountCaptionLbl: Label 'Quote Amount', comment = 'FRA="Montant devis"';
        Quote_ProfitCaptionLbl: Label 'Quote Profit', comment = 'FRA="Marge devis"';
        QuoteCaptionLbl: Label 'Quote', comment = 'FRA="Devis"';
        Reminder_DateCaptionLbl: Label 'Reminder Date', comment = 'FRA="Date relance"';
        StepCaptionLbl: Label 'Step', comment = 'FRA="Etape"';
        TxtGStatutFilter: Option;
        TxtGcontactfilter: Text[30];
        TxtGContactPhone: Text[30];
        TxtGContactTiers: Text[30];
        TxtGContactType: Text[30];
        TxtGDateReminder: Text[30];
        TxtGInterlocutor: Text[30];
        TxtGRemindDateFilter: Text[30];
        TxtHInterlocutor: Text[30];
        TxtGContact: Text[100];

    procedure getContactInfo("contactNo.": Code[20])
    begin
    end;
}

