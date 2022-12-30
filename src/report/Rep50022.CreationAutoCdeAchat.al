report 50022 "BC6_Creation Auto Cde Achat"
{

    Caption = 'Creation Auto Cde Achat', Comment = 'FRA="Creation Auto Cde Achat"';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        RecGInfoSoc.FINDFIRST();
        IF RecGInfoSoc."BC6_Branch Company" = FALSE THEN
            ERROR(Text001);
    end;

    trigger OnPreReport()
    begin
        CODEUNIT.RUN(Codeunit::"BC6_Creat Auto Cde Achat");
    end;

    var
        RecGInfoSoc: Record "Company Information";
        Text001: Label 'You are not in a branch company', comment = 'FRA="Vous n''êtes pas dans une société filiale"';
}

