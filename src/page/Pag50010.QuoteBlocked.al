page 50010 "BC6_Quote Blocked"
{
    Caption = 'Quote Bloced', comment = 'FRA="Devis Bloqué"';
    PageType = ConfirmationDialog;
    SourceTable = "Sales Header";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            field(TxtGMessage; TxtGMessage)
            {
                ApplicationArea = All;
                Caption = 'TxtG Message';
                Editable = false;
                Enabled = true;
                MultiLine = true;
            }
            field("No."; Rec."No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Sell-to Customer No."; Rec."Sell-to Customer No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Sell-to Contact"; Rec."Sell-to Contact")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send Mail")
            {
                ApplicationArea = All;
                Caption = 'Send Mail', comment = 'FRA="Envoyer Mail"';
                Image = SendMail;

                trigger OnAction()
                begin
                    TxtGBody := '';
                    TxtGObject := TexTG003 + ' ' + Rec."Sell-to Customer No." + ', ' + Rec."Sell-to Customer Name" + textg004;

                    TxtGBody := TxtG010 + Rec."No." + ' ' + TxtG011 + ' ' + FORMAT(Rec."Document Date") + ', ' +
                                USERID + ', ' + FORMAT(recgSalesHdr.COUNT) + ' ' + TxtG012;
                    Mail.NewMessage(SalesSetup."BC6_E-Mail Administrateur", '', '', TxtGObject, TxtGBody, '', TRUE);
                end;
            }
            action(OK)
            {
                ApplicationArea = All;
                Caption = 'OK';
                Image = Post;

                trigger OnAction()
                begin

                    CurrPage.CLOSE();

                    EXIT;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        TxtGMessage := '';
        TxtGPeriod := '';
    end;

    trigger OnOpenPage()
    begin
        SalesSetup.GET();
        SalesSetup.TESTFIELD(BC6_Nbr_Devis);
        SalesSetup.TESTFIELD("BC6_Période");
        recgSalesHdr.RESET();
        recgSalesHdr.SETRANGE("Document Type", Rec."Document Type");
        recgSalesHdr.SETFILTER("Sell-to Customer No.", Rec."Sell-to Customer No.");
        recgSalesHdr.SETRANGE("Document Date", CALCDATE('-' + FORMAT(SalesSetup."BC6_Période"), WORKDATE()), WORKDATE());

        TxtGMessage := STRSUBSTNO(TxtG007, recgSalesHdr.COUNT,
                       CALCDATE('-' + FORMAT(SalesSetup."BC6_Période"), WORKDATE()), WORKDATE()) + TxtG008 + TxtG009;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        recgSalesHdr: Record "Sales Header";
        Mail: Codeunit Mail;
        TexTG003: Label 'Customer', comment = 'FRA="Le client "';
        textg004: Label ' asked a new quote', comment = 'FRA="a demandé un nouveau devis"';
        TxtG007: Label 'This Quote will be locked because the customer ask more than %1 quote on the period of %2 to %3.', comment = 'FRA="Ce devis va être bloqué car ce client a demandé plus de %1 devis sur la période du %2 au %3. "';
        TxtG008: Label 'Push Send mail to inform administrator and ask him for unlocking quote.', comment = 'FRA="Cliquez sur Envoyez un mail pour avertir l''administrateur et lui demander un déblocage du devis. "';
        TxtG009: Label 'You can''t input lines on this quote.', comment = 'FRA="Vous ne pourrez pas saisir de lignes sur ce devis."';
        TxtG010: Label 'Quote No.', comment = 'FRA="Devis No."';
        TxtG011: Label 'of', comment = 'FRA="du"';
        TxtG012: Label 'quote existing.', comment = 'FRA="devis existants."';
        TxtGPeriod: Text[30];
        TxtGBody: Text[250];
        TxtGObject: Text[250];
        TxtGMessage: Text[1024];
}
