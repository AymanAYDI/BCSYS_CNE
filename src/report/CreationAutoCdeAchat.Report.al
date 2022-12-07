report 50022 "Creation Auto Cde Achat"
{
    // //>>CNEIC : 06/2015 : Report Exécute CU 50022: Création des commandes d'achats suivant Commandes ventes

    Caption = 'Creation Auto Cde Achat';
    ProcessingOnly = true;

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
        // CTRL que la sté est une filiale
        RecGInfoSoc.FINDFIRST;
        IF RecGInfoSoc."Branch Company" = FALSE THEN BEGIN
            ERROR(Text001);
        END;
    end;

    trigger OnPreReport()
    begin
        CODEUNIT.RUN(Codeunit::"BC6_Creat Auto Cde Achat");
    end;

    var
        RecGInfoSoc: Record "79";
        Text001: Label 'You are not in a branch company';
}

