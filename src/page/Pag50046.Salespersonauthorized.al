page 50046 "BC6_Salesperson authorized"
{
    Caption = 'Salespersons authorizeds', Comment = 'FRA="Vendeurs Autorisés"';
    DeleteAllowed = false;
    InsertAllowed = false;
    MultipleNewLines = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "BC6_Salesperson authorized";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; "Customer No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Salesperson code"; "Salesperson code")
                {
                    ApplicationArea = All;
                }
                field(authorized; authorized)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnClosePage()
    begin

        IF GETFILTER("Customer No.") <> '' THEN
            IF RecGCustomer.GET(FORMAT(GETFILTER("Customer No."))) THEN BEGIN
                CLEAR(TxtGSalespersonFilter);
                IF FINDFIRST() THEN
                    REPEAT
                        IF authorized THEN
                            TxtGSalespersonFilter += "Salesperson code" + '|';
                    UNTIL NEXT() = 0;

                IF TxtGSalespersonFilter <> '' THEN BEGIN
                    TxtGSalespersonFilter := CopyStr(COPYSTR(TxtGSalespersonFilter, 1, STRLEN(TxtGSalespersonFilter) - 1), 1, MaxStrLen(TxtGSalespersonFilter)); //TODO à Vérifier 
                    RecGCustomer.VALIDATE("BC6_Salesperson Filter", TxtGSalespersonFilter);
                    RecGCustomer.MODIFY();
                END;
            END;
    end;

    trigger OnOpenPage()
    begin

        IF GETFILTER("Customer No.") <> '' THEN
            IF RecGCustomer.GET(FORMAT(GETFILTER("Customer No."))) THEN BEGIN
                IF RecGSalesperson.FINDFIRST() THEN
                    REPEAT
                        IF NOT RecGAuthorizdeSalesperson.GET(RecGCustomer."No.", RecGSalesperson.Code) THEN BEGIN
                            RecGAuthorizdeSalesperson.INIT();
                            RecGAuthorizdeSalesperson."Customer No." := RecGCustomer."No.";
                            RecGAuthorizdeSalesperson."Salesperson code" := RecGSalesperson.Code;
                            RecGAuthorizdeSalesperson.authorized := (RecGCustomer."Salesperson Code" = RecGSalesperson.Code);
                            RecGAuthorizdeSalesperson.INSERT();
                        END;
                    UNTIL RecGSalesperson.NEXT() = 0;
                FILTERGROUP(2);
                SETRANGE("Customer No.", RecGCustomer."No.");
                FILTERGROUP(0);
            END;
    end;

    var
        RecGAuthorizdeSalesperson: Record "BC6_Salesperson authorized";
        RecGCustomer: Record Customer;
        RecGSalesperson: Record "Salesperson/Purchaser";
        TxtGSalespersonFilter: Text[250];
}

