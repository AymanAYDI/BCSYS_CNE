pageextension 50005 "BC6_CustomerList" extends "Customer List" //22
{
    layout
    {
        modify(Control1)
        {
            Caption = 'visibleList';
            Visible = TRUE;
            Editable = TRUE;
        }
        modify("No.")
        {
            Editable = false;
            ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.', comment = 'FRA="Spécifie le numéro du client. Le champ est renseigné automatiquement … partir d''une souche de numéros définie, ou vous saisissez manuellement le numéro, car vous avez activé la saisie manuelle de numéro dans le paramétrage de la souche de numéros."';
        }

        addafter("No.")
        {
            field(BC6_Blocked; Blocked)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }

        modify(Name)
        {
            Editable = false;
        }

        addafter(Name)
        {
            field(BC6_Address; Address)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Address 2"; "Address 2")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(BC6_City; City)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BC6_Submitted to DEEE"; "BC6_Submitted to DEEE")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }

        modify("Responsibility Center")
        {
            Editable = false;
        }

        modify("Location Code")
        {
            Editable = false;
        }

        modify("Post Code")
        {
            Editable = false;
        }

        modify("Country/Region Code")
        {
            Editable = false;
        }

        modify("Phone No.")
        {
            Editable = false;
        }

        modify("IC Partner Code")
        {
            Editable = false;
        }

        modify(Contact)
        {
            Editable = false;
        }

        modify("Salesperson Code")
        {
            Editable = false;
        }

        modify("Customer Posting Group")
        {
            Editable = false;
        }

        modify("Gen. Bus. Posting Group")
        {
            Editable = false;
        }

        modify("VAT Bus. Posting Group")
        {
            Editable = false;
        }
        modify("Customer Price Group")
        {
            Editable = false;
        }

        modify("Customer Disc. Group")
        {
            Editable = false;
        }

        modify("Payment Terms Code")
        {
            Editable = false;
        }

        modify("Reminder Terms Code")
        {
            Editable = false;
        }

        modify("Fin. Charge Terms Code")
        {
            Editable = false;
        }

        modify("Currency Code")
        {
            Editable = false;
        }

        modify("Language Code")
        {
            Editable = false;
        }
        modify("Search Name")
        {
            Editable = false;
        }

        modify("Application Method")
        {
            Editable = false;
        }

        modify("Combine Shipments")
        {
            Editable = false;
        }

        modify(Reserve)
        {
            Editable = false;
        }

        modify("Shipping Advice")
        {
            Editable = false;
        }

        modify("Shipping Agent Code")
        {
            Editable = false;
        }

        modify("Base Calendar Code")
        {
            Editable = false;
        }

        modify("Balance (LCY)")
        {
            Visible = false;
        }
        modify("Balance Due (LCY)")
        {
            Visible = false;
        }
        modify("Sales (LCY)")
        {
            Visible = false;
        }
        modify("Payments (LCY)")
        {
            Visible = false;
        }
        addafter("Balance (LCY)")
        {
            field("BC6_Outstanding Orders (LCY)"; "Outstanding Orders (LCY)")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_Shipped Not Invoiced (LCY)"; "Shipped Not Invoiced (LCY)")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("BC6_VAT Registration No."; "VAT Registration No.")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                ToolTip = 'Specifies the customer''s VAT registration number for customers in EU countries/regions.', Comment = 'FRA="Spécifie le numéro d''identification intra-communautaire du client dans des pays/régions de l''Union européenne"';

                trigger OnDrillDown()
                var
                    VATRegistrationLogMgt: Codeunit "VAT Registration Log Mgt.";
                begin
                    VATRegistrationLogMgt.AssistEditCustomerVATReg(Rec);
                end;
            }
        }
        //TODO //Invisible 
        // addafter(Control1)
        // {
        //     repeater(invisibleList)
        //     {
        //         Editable = true;
        //         Visible = false;
        //         field("BC6_No.2"; "No.")
        //         {
        //             ApplicationArea = All;
        //         }
        //         field(BC6_Name2; Name)
        //         {
        //             ApplicationArea = All;
        //         }
        //         field(BC6_Adress2; Address)
        //         {
        //             ApplicationArea = All;
        //         }
        //         field(BC6_Address22; "Address 2")
        //         {
        //             ApplicationArea = All;
        //         }
        //         field(BC6_City2; City)
        //         {
        //             ApplicationArea = All;
        //         }
        //         field("BC6_Responsibility Center 2"; "Responsibility Center")
        //         {
        //             ApplicationArea = All;
        //         }
        //         field("BC6_Location Code 2"; "Location Code")
        //         {
        //             ApplicationArea = All;
        //         }
        //         field("BC6_Post Code 2"; "Post Code")
        //         {
        //             ApplicationArea = All;
        //         }
        //         field("BC6_Country/Region Code2"; "Country/Region Code")
        //         {
        //             ApplicationArea = All;
        //         }
        //         field("BC6_Phone No.2"; "Phone No.")
        //         {
        //             ApplicationArea = All;
        //         }
        //         field("BC6_Fax No.2"; "Fax No.")
        //         {
        //             Visible = false;
        //             ApplicationArea = All;
        //         }
        //         field("BC6_IC Partner Code2"; "IC Partner Code")
        //         {
        //             Visible = false;
        //             ApplicationArea = All;
        //         }
        //         field(BC6_Contact2; Contact)
        //         {
        //             ApplicationArea = All;
        //         }
        //         field("BC6_Salesperson Code2"; "Salesperson Code")
        //         {
        //             Visible = false;
        //             ApplicationArea = All;
        //         }
        //         field("BC6_Customer Posting Group2"; "Customer Posting Group")
        //         {
        //             Visible = false;
        //             ApplicationArea = All;
        //         }
        //         field("BC6_Gen. Bus. Posting Group2"; "Gen. Bus. Posting Group")
        //         {
        //             Visible = false;
        //             ApplicationArea = All;
        //         }
        //         field("BC6_VAT Bus. Posting Group2"; "VAT Bus. Posting Group")
        //         {
        //             Visible = false;
        //             ApplicationArea = All;
        //         }
        //         field("BC6_Customer Price Group2"; "Customer Price Group")
        //         {
        //             Visible = false;
        //             ApplicationArea = All;
        //         }
        //         field("BC6_Customer Disc. Group2"; "Customer Disc. Group")
        //         {
        //             Visible = false;
        //             ApplicationArea = All;
        //         }
        //         field("BC6_Payment Terms Code2"; "Payment Terms Code")
        //         {
        //             Visible = false;
        //             ApplicationArea = All;
        //         }
        //         field("BC6_Reminder Terms Code2"; "Reminder Terms Code")
        //         {
        //             Visible = false;
        //             ApplicationArea = All;
        //         }
        //         field("BC6_Fin. Charge Terms Code2"; "Fin. Charge Terms Code")
        //         {
        //             Visible = false;
        //             ApplicationArea = All;
        //         }
        //         field("BC6_Currency Code2"; "Currency Code")
        //         {
        //             Visible = false;
        //             ApplicationArea = All;
        //         }
        //         field("BC6_Language Code2"; "Language Code")
        //         {
        //             Visible = false;
        //             ApplicationArea = All;
        //         }
        //         field("BC6_Search Name2"; "Search Name")
        //         {
        //             ApplicationArea = All;
        //         }
        //         field("BC6_E-Mail2"; "E-Mail")
        //         {
        //             ApplicationArea = All;
        //         }
        //     }
        // }
    }

    actions
    {
        addafter("C&ontact")
        {
            action("BC6_Salesperson authorized")
            {
                Caption = 'Salesperson authorized', Comment = 'FRA="Vendeurs Autorisés"';
                Image = SalesPerson;
                RunObject = Page "BC6_Salesperson authorized";
                RunPageLink = "Customer No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
        addafter("Recurring Sales Lines")
        {
            action("BC6_Customer Profit")
            {
                Caption = 'Customer Profit', Comment = 'FRA="Marge Vente"';
                Image = SalesPrices;
                RunObject = Page "BC6_Customer Profit";
                RunPageLink = Code = FIELD("BC6_Custom. Sales Profit Group");
                RunPageView = SORTING(Code);
                ApplicationArea = All;
            }
        }
    }

    trigger OnOpenPage()
    var
        RecLAccessControl: Record "Access Control";
    begin

        RecLAccessControl.RESET();
        RecLAccessControl.SETRANGE("User Security ID", USERSECURITYID());
        RecLAccessControl.SETRANGE("Role ID", 'SUPER');
        IF RecLAccessControl.FINDFIRST() THEN BEGIN
            BooGinvisibleList := FALSE;
            BooGvisibleList := TRUE;
        END ELSE BEGIN
            BooGinvisibleList := TRUE;
            BooGvisibleList := FALSE;
        END;

        IF NOT RecGUserSeup.GET(USERID) THEN
            RecGUserSeup.INIT();
        IF RecGUserSeup."BC6_Limited User" THEN BEGIN
            FILTERGROUP(2);
            SETFILTER("BC6_Salesperson Filter", '*' + RecGUserSeup."Salespers./Purch. Code" + '*');
            FILTERGROUP(0);
        END;
    end;

    var
        [InDataSet]
        BooGinvisibleList: Boolean;
        [InDataSet]
        BooGvisibleList: Boolean;
        RecGUserSeup: Record "User Setup";
}
