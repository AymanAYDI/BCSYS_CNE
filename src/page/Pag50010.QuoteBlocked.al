page 50010 "BC6_Quote Blocked"
{
    Caption = 'Quote Bloced';
    PageType = ConfirmationDialog;
    SourceTable = "Sales Header";

    layout
    {
        area(content)
        {
            field(TxtGMessage; TxtGMessage)
            {
                Editable = false;
                Enabled = true;
                MultiLine = true;
            }
            field("No."; "No.")
            {
                Editable = false;
            }
            field("Sell-to Customer No."; "Sell-to Customer No.")
            {
                Editable = false;
            }
            field("Sell-to Customer Name"; "Sell-to Customer Name")
            {
                Editable = false;
            }
            field("Sell-to Contact"; "Sell-to Contact")
            {
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
                Caption = 'Send Mail';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    TxtGBody := '';
                    TxtGObject := TexTG003 + ' ' + "Sell-to Customer No." + ', ' + "Sell-to Customer Name" + textg004;

                    TxtGBody := TxtG010 + "No." + ' ' + TxtG011 + ' ' + FORMAT("Document Date") + ', ' +
                                USERID + ', ' + FORMAT(recgSalesHdr.COUNT) + ' ' + TxtG012;
                    Mail.NewMessage(SalesSetup."BC6_E-Mail Administrateur", '', '', TxtGObject, TxtGBody, '', TRUE);
                end;
            }
            action(OK)
            {
                Caption = 'OK';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    CurrPage.CLOSE;

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
        SalesSetup.GET;
        SalesSetup.TESTFIELD(BC6_Nbr_Devis);
        SalesSetup.TESTFIELD(Période);
        recgSalesHdr.RESET;
        recgSalesHdr.SETRANGE("Document Type", "Document Type");
        recgSalesHdr.SETFILTER("Sell-to Customer No.", "Sell-to Customer No.");
        recgSalesHdr.SETRANGE("Document Date", CALCDATE('-' + FORMAT(SalesSetup.Période), WORKDATE), WORKDATE);

        TxtGMessage := STRSUBSTNO(TxtG007, recgSalesHdr.COUNT,
                       CALCDATE('-' + FORMAT(SalesSetup.Période), WORKDATE), WORKDATE) + TxtG008 + TxtG009;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        Mail: Codeunit Mail;
        TextG001: Label 'Quote Locked : %1 quote without order';
        TextG002: Label ' quote without order';
        recgSalesHdr: Record "Sales Header";
        TexTG003: Label 'Customer ';
        textg004: Label ' asked a new quote';
        TxtGObject: Text[250];
        textg005: Label 'Mail sent to %1';
        textg006: Label 'An error accored while sending mail to %1';
        TxtG007: Label 'This Quote will be locked because the customer ask more than %1 quote on the period of %2 to %3.';
        TxtG008: Label 'Push Send mail to inform administrator and ask him for unlocking quote.';
        TxtG009: Label 'You can''t input lines on this quote.';
        TxtGMessage: Text[1024];
        TxtGPeriod: Text[30];
        TxtGBody: Text[250];
        TxtG010: Label 'Quote No. ';
        TxtG011: Label 'of';
        TxtG012: Label 'quote existing.';
}

