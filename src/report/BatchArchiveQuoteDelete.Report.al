report 50098 "Batch Archive Quote Delete"
{
    Caption = 'Batch Archive Quote Delete';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1100267000; Table36)
        {
            DataItemTableView = WHERE(Document Type=CONST(Quote),
                                      Affair No.=FILTER(''));
            RequestFilterFields = "Document Date","No.";

            trigger OnAfterGetRecord()
            begin
                z:=z+1 ;
                ok:=TRUE ;

                window.UPDATE(1,"Sales Header"."No.") ;

                ok:=Fct_Check("Sales Header"."Document Type","Sales Header"."No.") ;


                IF ok THEN BEGIN
                  ArchiveManagement.ArchiveSalesDocumentWithoutMessage("Sales Header");

                  //Purge devis
                  SalesHeader2.GET("Sales Header"."Document Type","Sales Header"."No.") ;
                  SalesHeader2.DELETE(TRUE) ;
                  i:=i+1 ;
                END ;

                //MESSAGE('%1 - %2',"Sales Header"."No.",ok) ;
            end;
        }
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

    trigger OnPostReport()
    begin
        MESSAGE('%1 sur %2 à %3',i,z,TIME) ;
        window.CLOSE ;
        //ERROR('stop') ;
    end;

    trigger OnPreReport()
    begin
        i:=0 ;
        z:=0 ;
        window.OPEN('#1########') ;
    end;

    var
        i: Integer;
        ArchiveManagement: Codeunit "5063";
        ok: Boolean;
        SalesHeader2: Record "36";
        z: Integer;
        window: Dialog;

    [Scope('Internal')]
    procedure Fct_Check(DocType: Integer;DocNo: Code[20]): Boolean
    var
        SalesLine: Record "37";
    begin
        SalesLine.RESET ;
        SalesLine.SETRANGE(SalesLine."Document Type",DocType) ;
        SalesLine.SETRANGE(SalesLine."Document No.",DocNo) ;



        //On recherche au niveau 1
        SalesLine.SETFILTER(SalesLine."Purchase Order No.",'<>%1','') ;
        //IF DocNo='DV10008' THEN MESSAGE('%1',SalesLine.ISEMPTY) ;
        //IF DocNo='DV10008' THEN MESSAGE('%1',SalesLine.GETFILTERS) ;

        IF NOT SalesLine.ISEMPTY THEN EXIT(FALSE) ;

        //On recherche au niveau 2
        SalesLine.SETRANGE(SalesLine."Purchase Order No.") ; //on défiltre
        SalesLine.SETFILTER(SalesLine."Purch. Line No.",'<>%1',0) ;
        IF NOT SalesLine.ISEMPTY THEN EXIT(FALSE) ;

        EXIT(TRUE) ;


        //IF ("Purch. Order No." <> '') OR ("Purch. Line No." <> 0) THEN
    end;
}

