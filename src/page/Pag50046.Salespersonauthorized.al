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
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Salesperson code"; Rec."Salesperson code")
                {
                    ApplicationArea = All;
                }
                field(authorized; Rec.authorized)
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

        IF Rec.GETFILTER("Customer No.") <> '' THEN
            IF RecGCustomer.GET(FORMAT(Rec.GETFILTER("Customer No."))) THEN BEGIN
                CLEAR(TxtGSalespersonFilter);
                IF Rec.FINDFIRST() THEN
                    REPEAT
                        IF Rec.authorized THEN
                            TxtGSalespersonFilter += Rec."Salesperson code" + '|';
                    UNTIL Rec.NEXT() = 0;

                IF TxtGSalespersonFilter <> '' THEN BEGIN
                    TxtGSalespersonFilter := CopyStr(COPYSTR(TxtGSalespersonFilter, 1, STRLEN(TxtGSalespersonFilter) - 1), 1, MaxStrLen(TxtGSalespersonFilter)); //TODO à Vérifier
                    RecGCustomer.VALIDATE("BC6_Salesperson Filter", TxtGSalespersonFilter);
                    RecGCustomer.MODIFY();
                END;
            END;
    end;

    trigger OnOpenPage()
    begin

        IF Rec.GETFILTER("Customer No.") <> '' THEN
            IF RecGCustomer.GET(FORMAT(Rec.GETFILTER("Customer No."))) THEN BEGIN
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
                Rec.FILTERGROUP(2);
                Rec.SETRANGE("Customer No.", RecGCustomer."No.");
                Rec.FILTERGROUP(0);
            END;
    end;

    var
        RecGAuthorizdeSalesperson: Record "BC6_Salesperson authorized";
        RecGCustomer: Record Customer;
        RecGSalesperson: Record "Salesperson/Purchaser";
        TxtGSalespersonFilter: Text[250];
}
