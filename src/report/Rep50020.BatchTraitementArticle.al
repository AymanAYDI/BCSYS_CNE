report 50020 "BC6_Batch Traitement Article"
{
    ApplicationArea = All;
    Caption = 'Batch Traitement Article';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                IntGCounter += 1;
                DlgGWin.UPDATE(1, ROUND(IntGCounter / IntGTotal * 10000, 1));

                Item.CALCFIELDS(Inventory);

                IF Item.Inventory > 0 THEN
                    EcritureArticle.RESET();
                EcritureArticle.SETCURRENTKEY("Item No.", "Posting Date");
                EcritureArticle.SETRANGE(EcritureArticle."Item No.", Item."No.");
                EcritureArticle.SETRANGE(EcritureArticle."Posting Date", Date_Debut, Date_Fin);
                IF EcritureArticle.ISEMPTY THEN BEGIN
                    Item.Blocked := TRUE;
                    Item.MODIFY();
                END;
            END;

            trigger OnPostDataItem()
            begin
                DlgGWin.CLOSE();
            end;

            trigger OnPreDataItem()
            begin
                IntGTotal := COUNT;
                IntGCounter := 0;
                DlgGWin.OPEN(CstG001);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(Date_DebutF; Date_Debut)
                {
                    ApplicationArea = All;
                    Caption = 'Date dernier mouvement';
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

    var
        EcritureArticle: Record "Item Ledger Entry";
        Date_Debut: Date;
        Date_Fin: Date;
        DlgGWin: Dialog;
        IntGCounter: Integer;
        IntGTotal: Integer;
        CstG001: Label 'Traitement des articles @1@@@@@@@@@';
}
