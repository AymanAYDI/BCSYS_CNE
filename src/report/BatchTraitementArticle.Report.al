report 50020 "Batch Traitement Article"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // 
    // //>>CNE5.00
    // TDL.76:20131120/CSC - Add C/AL to improve process time
    //                     - Add Dialog Window
    // 
    // ------------------------------------------------------------------------

    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1100267000; Table27)
        {
            DataItemTableView = SORTING(No.);
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                //>>TDL.76
                IntGCounter += 1;
                DlgGWin.UPDATE(1, ROUND(IntGCounter / IntGTotal * 10000, 1));
                //<<TDL.76

                Item.CALCFIELDS(Inventory);

                IF Item.Inventory > 0 THEN BEGIN
                    //Item.Blocked:=false;
                    //Item.MODIFY;
                END ELSE BEGIN
                    EcritureArticle.RESET;
                    //>>TDL.76
                    //EcritureArticle.SETCURRENTKEY("Item No.","Entry Type","Variant Code","Drop Shipment","Location Code","Posting Date") ;
                    EcritureArticle.SETCURRENTKEY("Item No.", "Posting Date");
                    //<<TDL.76
                    EcritureArticle.SETRANGE(EcritureArticle."Item No.", Item."No.");
                    EcritureArticle.SETRANGE(EcritureArticle."Posting Date", Date_Debut, Date_Fin);
                    //>>TDL.76
                    //IF NOT EcritureArticle.FIND('-') THEN BEGIN
                    IF EcritureArticle.ISEMPTY THEN BEGIN
                        //<<TDL.76
                        Item.Blocked := TRUE;
                        Item.MODIFY;
                    END;
                END;
            end;

            trigger OnPostDataItem()
            begin
                //>>TDL.76
                DlgGWin.CLOSE;
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
        Date_Fin: Date;
        Date_Debut: Date;
        EcritureArticle: Record "32";
        "- TDL.76 -": Integer;
        IntGCounter: Integer;
        IntGTotal: Integer;
        DlgGWin: Dialog;
        "-- TDL.76 --": ;
        CstG001: Label 'Traitement des articles @1@@@@@@@@@';
}

