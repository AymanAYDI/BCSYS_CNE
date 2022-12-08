report 50020 "BC6_Batch Traitement Article"
{

    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                //>>TDL.76
                IntGCounter += 1;
                DlgGWin.UPDATE(1, ROUND(IntGCounter / IntGTotal * 10000, 1));
                //<<TDL.76

                Item.CALCFIELDS(Inventory);

                IF Item.Inventory > 0 THEN
                    EcritureArticle.RESET();
                EcritureArticle.SETCURRENTKEY("Item No.", "Posting Date");
                //<<TDL.76
                EcritureArticle.SETRANGE(EcritureArticle."Item No.", Item."No.");
                EcritureArticle.SETRANGE(EcritureArticle."Posting Date", Date_Debut, Date_Fin);
                IF EcritureArticle.ISEMPTY THEN BEGIN
                    //<<TDL.76
                    Item.Blocked := TRUE;
                    Item.MODIFY();
                END;
            END;

            trigger OnPostDataItem()
            begin
                //>>TDL.76
                DlgGWin.CLOSE();
                //<<TDL.76
            end;

            trigger OnPreDataItem()
            begin
                //>>TDL.76
                IntGTotal := COUNT;
                IntGCounter := 0;
                DlgGWin.OPEN(CstG001);
                //<<TDL.76
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Date_Debut; Date_Debut)
                {
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

