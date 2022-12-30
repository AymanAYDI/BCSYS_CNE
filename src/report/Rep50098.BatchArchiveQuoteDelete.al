report 50098 "BC6_Batch Archive Quote Delete"
{
    Caption = 'Batch Archive Quote Delete', Comment = 'FRA="Archivage et Suppression Devis"';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = WHERE("Document Type" = CONST(Quote),
                                      "BC6_Affair No." = FILTER(''));
            RequestFilterFields = "Document Date", "No.";

            trigger OnAfterGetRecord()
            var
                FunctionMgt: Codeunit "BC6_Functions Mgt";
            begin
                z := z + 1;
                ok := TRUE;

                window.UPDATE(1, "Sales Header"."No.");

                ok := Fct_Check("Sales Header"."Document Type".AsInteger(), "Sales Header"."No.");


                IF ok THEN BEGIN
                    FunctionMgt.ArchiveSalesDocumentWithoutMessage("Sales Header");

                    //Purge devis
                    SalesHeader2.GET("Sales Header"."Document Type", "Sales Header"."No.");
                    SalesHeader2.DELETE(TRUE);
                    i := i + 1;
                END;

            end;
        }
    }


    trigger OnPostReport()
    begin
        MESSAGE('%1 sur %2 à %3', i, z, TIME);
        window.CLOSE();
    end;

    trigger OnPreReport()
    begin
        i := 0;
        z := 0;
        window.OPEN('#1########');
    end;

    var
        SalesHeader2: Record "Sales Header";
        ok: Boolean;
        window: Dialog;
        i: Integer;
        z: Integer;


    procedure Fct_Check(DocType: Integer; DocNo: Code[20]): Boolean
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.RESET();
        SalesLine.SETRANGE(SalesLine."Document Type", DocType);
        SalesLine.SETRANGE(SalesLine."Document No.", DocNo);

        SalesLine.SETFILTER(SalesLine."Purchase Order No.", '<>%1', '');

        IF NOT SalesLine.ISEMPTY THEN EXIT(FALSE);

        SalesLine.SETRANGE(SalesLine."Purchase Order No."); //on défiltre
        SalesLine.SETFILTER(SalesLine."BC6_Purch. Line No.", '<>%1', 0);
        IF NOT SalesLine.ISEMPTY THEN EXIT(FALSE);

        EXIT(TRUE);


    end;
}

