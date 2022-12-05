report 50019 "Affair List"
{
    // --------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // --------------------------------------------------------------------------
    // //>>CNE1.00
    // FEP-ADVE-200706_18_A:MA 21/11/2007 : gestion des appeles d'offres client
    //        - Report created
    // 
    // //>>CNE1.01
    // FEP-ADVE-200706_18_A:MA 03/12/2007 : gestion des appeles d'offres client
    //        - Initialise filters
    // 
    // //>>CNE2.05
    // FEP6-ACHAT-200706_18_A.001:LY : - Change Report CaptionML
    //                                 - Check Request Form error
    //                                 - correct bugs
    // --------------------------------------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = './AffairList.rdlc';

    Caption = 'Affair List';
    Permissions = TableData 50010 = rimd;

    dataset
    {
        dataitem(DataItem8019; Table167)
        {
            DataItemTableView = SORTING (No.)
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Affair Responsible";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
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
            column(Job__Affair_Responsible_; "Affair Responsible")
            {
            }
            column(Job_Statut; Statut)
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
            column(Job_StatutCaption; FIELDCAPTION(Statut))
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
            column(Affair_Steps__Contact_Name_Caption; "Affair Steps".FIELDCAPTION("Contact Name"))
            {
            }
            column(Reminder_DateCaption; Reminder_DateCaptionLbl)
            {
            }
            dataitem(DataItem7420; Table50009)
            {
                DataItemLink = Affair No.=FIELD(No.);
                DataItemTableView = SORTING (Contact No., Affair No.)
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
                column(Contact_Project_Relation__Awarder; FORMAT("Contact Project Relation".Awarder))
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
                    IF TxtGContact = "Contact No." + ' ' + "Contact Project Relation"."Contact Name" THEN
                        CurrReport.SKIP;

                    TxtGContactTiers := '';
                    TxtGContact := '';
                    TxtGContactType := '';
                    TxtGContactPhone := '';
                    TxtGContactTiers := '';

                    //>FEP6-ACHAT-200706_18_A.001
                    //RecGContact.RESET;
                    //RecGContact.SETFILTER(RecGContact."No.","Contact No.");
                    //IF  RecGContact.FINDFIRST THEN BEGIN
                    IF RecGContact.GET("Contact No.") THEN BEGIN
                        //<FEP6-ACHAT-200706_18_A.001
                        TxtGContact := RecGContact."No." + ' ' + RecGContact.Name;
                        TxtGContactType := FORMAT(RecGContact.Type);
                        TxtGContactPhone := FORMAT(RecGContact."Phone No.");


                        RecGCntBusiness.RESET;
                        //>FEP6-ACHAT-200706_18_A.001
                        //RecGCntBusiness.SETFILTER(RecGCntBusiness."Contact No.","Contact No.");
                        RecGCntBusiness.SETFILTER("Contact No.", RecGContact."Company No.");
                        //<FEP6-ACHAT-200706_18_A.001

                        RecGCntBusiness.SETRANGE(RecGCntBusiness."Link to Table", RecGCntBusiness."Link to Table"::Customer);
                        IF NOT RecGCntBusiness.FINDFIRST THEN
                            RecGCntBusiness.SETRANGE(RecGCntBusiness."Link to Table", RecGCntBusiness."Link to Table"::Vendor);

                        IF RecGCntBusiness.FINDFIRST THEN
                            TxtGContactTiers := RecGCntBusiness."No.";
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    //>FEP6-ACHAT-200706_18_A
                    IF TxtGcontactfilter <> '' THEN
                        SETFILTER("Contact No.", TxtGcontactfilter);
                    IF CodGCustomer <> '' THEN
                        SETFILTER("No.", CodGCustomer);
                    IF CodGVendor <> '' THEN
                        SETFILTER("No.", CodGVendor);
                    //<FEP6-ACHAT-200706_18_A
                end;
            }
            dataitem(DataItem6640; Table36)
            {
                DataItemLink = Affair No.=FIELD(No.);
                DataItemTableView = SORTING (Affair No.)
                                    ORDER(Ascending)
                                    WHERE (Document Type=CONST(Quote),
                                          Affair No.=FILTER(<>''));
                column(Sales_Header__Amount_Including_VAT_;"Amount Including VAT")
                {
                }
                column(DecGProfitLCY;DecGProfitLCY)
                {
                }
                column(Sales_Header__Bill_to_Contact_;"Bill-to Contact")
                {
                }
                column(Sales_Header__Sell_to_Customer_No__;"Sell-to Customer No.")
                {
                }
                column(Sales_Header__No__;"No.")
                {
                }
                column(TxtHInterlocutor;TxtHInterlocutor)
                {
                }
                column(BooGAwarder_Control1000000111;FORMAT(BooGAwarder))
                {
                }
                column(Sales_Header_Document_Type;"Document Type")
                {
                }
                column(Sales_Header_Affair_No_;"Affair No.")
                {
                }

                trigger OnAfterGetRecord()
                var
                    RecLSalesLine: Record "37";
                begin
                    CLEAR(DecGProfitLCY);
                    CLEAR(DecGAmount);
                    CLEAR(DecGCost);
                    
                    
                    RecLSalesLine.RESET;
                    RecLSalesLine.SETFILTER("Document Type",'%1',"Sales Header"."Document Type");
                    RecLSalesLine.SETFILTER("Document No.","Sales Header"."No.");
                    
                    IF RecLSalesLine.FIND('-') THEN REPEAT
                       DecGAmount += RecLSalesLine.Amount;
                       DecGCost += RecLSalesLine."Purchase cost" * RecLSalesLine.Quantity;
                    UNTIL RecLSalesLine.NEXT = 0;
                    
                    
                    DecGProfitLCY :=  DecGAmount - DecGCost ;
                    //Pour affichage en % de la marge, enlevée les {}
                    /*IF DecGAmount = 0 THEN
                       DecGProfitLCY := 0
                    ELSE
                       DecGProfitLCY := ROUND(100 * DecGProfitLCY/DecGAmount,0.01);*/
                    
                    
                    BooGAwarder := FALSE;
                    IF RecGContactProjectRelation.GET("Sales Header"."Bill-to Contact No.","Sales Header"."Affair No.") THEN
                       IF RecGContactProjectRelation.Awarder = TRUE THEN
                          BooGAwarder := TRUE;

                end;
            }
            dataitem(DataItem6366;Table50010)
            {
                DataItemLink = Affair No.=FIELD(No.);
                DataItemTableView = SORTING(No.,Affair No.)
                                    ORDER(Ascending);
                RequestFilterFields = Interlocutor;
                column(Affair_Steps_Description;Description)
                {
                }
                column(Affair_Steps_Contact;Contact)
                {
                }
                column(Affair_Steps__Reminder_Date_;"Reminder Date")
                {
                }
                column(Affair_Steps_Interlocutor;Interlocutor)
                {
                }
                column(Affair_Steps__Contact_Name_;"Contact Name")
                {
                }
                column(Affair_Steps_No_;"No.")
                {
                }
                column(Affair_Steps_Affair_No_;"Affair No.")
                {
                }

                trigger OnPreDataItem()
                begin
                    IF FORMAT(TxtGTerminatedFilter) <> '' THEN
                      SETRANGE("Affair Steps".Terminated,TxtGTerminatedFilter);

                    //>FEP6-ACHAT-200706_18_A.001
                    IF TxtGRemindDateFilter <> '' THEN
                      "Affair Steps".SETFILTER("Reminder Date",TxtGRemindDateFilter);
                    IF TxtGInterlocutor <> '' THEN
                      "Affair Steps".SETFILTER(Interlocutor,TxtGInterlocutor);
                    //<FEP6-ACHAT-200706_18_A.001
                end;
            }
            dataitem(DataItem5444;Table2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number=CONST(1));
                column(Integer_Number;Number)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                BooGAwarder := FALSE;
                //>FEP6-ACHAT-200706_18_A
                //<< MODIF_HL_I009784_2008-12-22_SU_ALCA
                IF TxtGcontactfilter <> '' THEN BEGIN
                  RecGCntAffair.SETFILTER(RecGCntAffair."Contact No.",TxtGcontactfilter);
                  RecGCntAffair.SETFILTER(RecGCntAffair."Affair No.",Job."No.");
                  IF NOT RecGCntAffair.FIND('-') THEN CurrReport.SKIP;
                END;

                IF CodGCustomer <> '' THEN BEGIN
                  RecGCntAffair.RESET;
                  RecGCntAffair.SETFILTER(RecGCntAffair."Affair No.",Job."No.");
                  RecGCntAffair.SETFILTER(RecGCntAffair."No.",CodGCustomer);
                  IF NOT RecGCntAffair.FIND('-') THEN CurrReport.SKIP;
                END;

                IF CodGVendor <> '' THEN BEGIN
                  RecGCntAffair.RESET;
                  RecGCntAffair.SETFILTER(RecGCntAffair."Affair No.",Job."No.");
                  RecGCntAffair.SETFILTER(RecGCntAffair."No.", CodGVendor);
                  IF NOT RecGCntAffair.FIND('-') THEN CurrReport.SKIP;
                END;

                IF TxtGInterlocutor <> '' THEN BEGIN
                  RecGAffairSteps.RESET;
                  RecGAffairSteps.SETFILTER(RecGAffairSteps."Affair No.",Job."No.");
                  RecGAffairSteps.SETFILTER(RecGAffairSteps.Interlocutor,TxtGInterlocutor);
                  IF NOT RecGAffairSteps.FIND('-') THEN CurrReport.SKIP;
                END;

                IF TxtGRemindDateFilter <> '' THEN BEGIN
                  RecGAffairSteps.RESET;
                  RecGAffairSteps.SETFILTER(RecGAffairSteps."Affair No.",Job."No.");
                  RecGAffairSteps.SETFILTER(RecGAffairSteps."Reminder Date",TxtGRemindDateFilter);
                //  IF NOT RecGAffairSteps.FIND('-') THEN CurrReport.SKIP;
                END;
                //>> MODIF_HL_I009784_2008-12-22_SU_ALCA

                //"Affair Steps".SETFILTER("Reminder Date",TxtGRemindDateFilter);
                //<FEP6-ACHAT-200706_18_A.001

                RecGCntAffair.RESET;
                RecGCntAffair.SETFILTER(RecGCntAffair."Affair No.",Job."No.");

                //>FEP6-ACHAT-200706_18_A.001
                //IF RecGCntAffair.FIND('-') THEN BEGIN
                IF RecGCntAffair.FINDFIRST THEN BEGIN
                  //RecGContact.RESET;
                  //RecGContact.SETFILTER(RecGContact."No.",RecGCntAffair."Contact No.");
                  //IF  RecGContact.FIND('-') THEN BEGIN
                  IF RecGContact.GET(RecGCntAffair."Contact No.") THEN BEGIN
                  //<FEP6-ACHAT-200706_18_A.001
                    TxtGContact := RecGContact."No." + ' '+ RecGContact.Name;
                    TxtGContactType :=FORMAT(RecGContact.Type);
                    TxtGContactPhone := FORMAT(RecGContact."Phone No.");
                    BooGAwarder := RecGCntAffair.Awarder;
                    RecGCntBusiness.RESET;
                    RecGCntBusiness.SETFILTER(RecGCntBusiness."Contact No.",RecGCntAffair."Contact No.");
                    RecGCntBusiness.SETRANGE(RecGCntBusiness."Link to Table",RecGCntBusiness."Link to Table"::Customer);
                    IF NOT RecGCntBusiness.FIND('-') THEN
                      RecGCntBusiness.SETRANGE(RecGCntBusiness."Link to Table",RecGCntBusiness."Link to Table"::Vendor);

                    IF RecGCntBusiness.FIND('-') THEN
                      TxtGContactTiers := RecGCntBusiness."No."
                  END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                IF FORMAT(TxtGStatutFilter) <> '' THEN
                  SETRANGE(Job.Statut,TxtGStatutFilter);
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
                    field(TxtGStatutFilter;TxtGStatutFilter)
                    {
                        Caption = 'Status';
                        OptionCaption = ' ,Outstanding,Lost,Won';
                    }
                    field(TxtGRemindDateFilter;TxtGRemindDateFilter)
                    {
                        Caption = 'Reminder Date';

                        trigger OnValidate()
                        begin

                            IF TxtGRemindDateFilter <> '' THEN
                            BEGIN
                              RecGJob.SETFILTER("Posting Date Filter",TxtGRemindDateFilter);
                              EVALUATE(TxtGRemindDateFilter,RecGJob.GETFILTER("Posting Date Filter"));
                            END;
                        end;
                    }
                    field(TxtGTerminatedFilter;TxtGTerminatedFilter)
                    {
                        Caption = 'Terminer';
                    }
                    field(BooGShowQuote;BooGShowQuote)
                    {
                        Caption = 'Show Quote Details';
                    }
                    field(BooGShowSteps;BooGShowSteps)
                    {
                        Caption = 'Show Steps';
                    }
                    field(CodGCustomer;CodGCustomer)
                    {
                        Caption = 'Customer Code';
                        TableRelation = Customer;
                    }
                    field(CodGVendor;CodGVendor)
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
        TextGDate := '..'+FORMAT(CALCDATE('<CM>'));
        EVALUATE(TxtGRemindDateFilter,TextGDate);
    end;

    trigger OnPreReport()
    begin
        TxtGcontactfilter := "Contact Project Relation".GETFILTER("Contact Project Relation"."Contact No.");
        TxtGInterlocutor := "Affair Steps".GETFILTER("Affair Steps".Interlocutor);
    end;

    var
        TxtGContact: Text[100];
        TxtGContactType: Text[30];
        TxtGContactPhone: Text[30];
        TxtGContactTiers: Text[30];
        TxtHInterlocutor: Text[30];
        RecGCntAffair: Record "50009";
        RecGContact: Record "5050";
        RecGCntBusiness: Record "5054";
        CodGCustomer: Code[20];
        CodGVendor: Code[20];
        BooGShowQuote: Boolean;
        BooGShowSteps: Boolean;
        TxtGcontactfilter: Text[30];
        TxtGInterlocutor: Text[30];
        TxtGDateReminder: Text[30];
        RecGAffairSteps: Record "50010";
        TxtGStatutFilter: Option;
        TxtGRemindDateFilter: Text[30];
        TxtGTerminatedFilter: Boolean;
        RecGJob: Record "167";
        DecGProfitLCY: Decimal;
        DecGAmount: Decimal;
        DecGCost: Decimal;
        BooGAwarder: Boolean;
        RecGContactProjectRelation: Record "50009";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Business_ListCaptionLbl: Label 'Business List';
        Customer_Or_VendorCaptionLbl: Label 'Customer Or Vendor';
        Phone_No_CaptionLbl: Label 'Phone No.';
        Contact_TypeCaptionLbl: Label 'Contact Type';
        ContactCaptionLbl: Label 'Contact';
        Affair_responsible_CNECaptionLbl: Label 'Affair responsible CNE';
        Affair_NameCaptionLbl: Label 'Affair Name';
        Affair_No_CaptionLbl: Label 'Affair No.';
        Awa_CaptionLbl: Label 'Awa.';
        QuoteCaptionLbl: Label 'Quote';
        Quote_AmountCaptionLbl: Label 'Quote Amount';
        Quote_ProfitCaptionLbl: Label 'Quote Profit';
        ContactCaption_Control1000000021Lbl: Label 'Contact';
        CustomerCaptionLbl: Label 'Customer';
        InterocutorCaptionLbl: Label 'Interocutor';
        Awa_Caption_Control1000000109Lbl: Label 'Awa.';
        StepCaptionLbl: Label 'Step';
        Reminder_DateCaptionLbl: Label 'Reminder Date';
        Attached_ContactCaptionLbl: Label 'Attached Contact';
        InterlocutorCaptionLbl: Label 'Interlocutor';

    [Scope('Internal')]
    procedure getContactInfo("contactNo.": Code[20])
    begin
    end;
}

