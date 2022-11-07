codeunit 50004 "Post Code Rebuild"
{
    // // TODOLIST DARI 06/03/2007 point 52
    //  Errors in the Post Code Table => Rebuilding by importing data from Tables Customer, Vendor, Contact and Ship-To Adress


    trigger OnRun()
    begin
        //>>TODOLIST DARI 06/03/2007 point 52
        // Table Post Code : Default Compound  Key = Code + City
        RecGPostCode.DELETEALL(TRUE);

        RecGCustomer.RESET;
        IF RecGCustomer.FIND('-') THEN BEGIN
            IntGNb := RecGCustomer.COUNT;
            IntGI := 0;
            DiaGWindow.OPEN('Table Customer     @1@@@@@@@@@@\' +
                            'N° article #2##########');
            REPEAT
                IntGI := IntGI + 1;
                DiaGWindow.UPDATE(1, ROUND(IntGI / IntGNb * 10000, 1));
                DiaGWindow.UPDATE(2, RecGCustomer."No.");

                RecGPostCode.RESET;
                RecGPostCode.SETRANGE(RecGPostCode.Code, RecGCustomer."Post Code");
                //RecGPostCode.SETRANGE(RecGPostCode.City,RecGCustomer.City);
                RecGPostCode.SETRANGE(RecGPostCode."Search City", RecGCustomer.City);

                IF NOT RecGPostCode.FIND('-')
                  THEN BEGIN
                    IF (RecGCustomer."Post Code" <> '') AND (RecGCustomer.City <> '') THEN BEGIN
                        RecGPostCode.INIT;
                        RecGPostCode.VALIDATE(Code, RecGCustomer."Post Code");
                        RecGPostCode.VALIDATE(City, RecGCustomer.City);

                        //Affectation de Search City à supprimer car réalisée dans le trigger OnValidate du champ City de la table Post Code.
                        //RecGPostCode.City:=RecGCustomer.City =>RecGPostCode.VALIDATE(City,RecGCustomer.City);

                        // pour appleler le Trigger sur le On Insert -- Valeur par defaut = FALSE
                        RecGPostCode.INSERT(TRUE);
                    END;
                END;
            UNTIL RecGCustomer.NEXT = 0;
            DiaGWindow.CLOSE;
        END;

        RecGVendor.RESET;
        IF RecGVendor.FIND('-') THEN BEGIN
            IntGNb := RecGVendor.COUNT;
            IntGI := 0;
            DiaGWindow.OPEN('Table Vendor     @1@@@@@@@@@@\' +
                            'N° article #2##########');
            REPEAT
                IntGI := IntGI + 1;
                DiaGWindow.UPDATE(1, ROUND(IntGI / IntGNb * 10000, 1));
                DiaGWindow.UPDATE(2, RecGVendor."No.");

                RecGPostCode.RESET;
                RecGPostCode.SETRANGE(RecGPostCode.Code, RecGVendor."Post Code");
                RecGPostCode.SETRANGE(RecGPostCode.City, RecGVendor.City);

                IF NOT RecGPostCode.FIND('-')
                  THEN BEGIN
                    RecGPostCode.INIT;
                    RecGPostCode.VALIDATE(Code, RecGVendor."Post Code");
                    RecGPostCode.VALIDATE(City, RecGVendor.City);
                    RecGPostCode.INSERT(TRUE);
                END;
            UNTIL RecGVendor.NEXT = 0;
            DiaGWindow.CLOSE;
        END;

        RecGShiptoAddress.RESET;
        IF RecGShiptoAddress.FIND('-') THEN BEGIN
            IntGNb := RecGShiptoAddress.COUNT;
            IntGI := 0;
            DiaGWindow.OPEN('Table "Ship-to Address"     @1@@@@@@@@@@\' +
                            'N° article #2##########');
            REPEAT
                IntGI := IntGI + 1;
                DiaGWindow.UPDATE(1, ROUND(IntGI / IntGNb * 10000, 1));
                DiaGWindow.UPDATE(2, RecGShiptoAddress."Customer No.");

                RecGPostCode.RESET;
                RecGPostCode.SETRANGE(RecGPostCode.Code, RecGShiptoAddress."Post Code");
                RecGPostCode.SETRANGE(RecGPostCode.City, RecGShiptoAddress.City);

                IF NOT RecGPostCode.FIND('-')
                  THEN BEGIN
                    RecGPostCode.INIT;
                    RecGPostCode.VALIDATE(Code, RecGShiptoAddress."Post Code");
                    RecGPostCode.VALIDATE(City, RecGShiptoAddress.City);
                    RecGPostCode.INSERT(TRUE);
                END;
            UNTIL RecGShiptoAddress.NEXT = 0;
            DiaGWindow.CLOSE;
        END;

        RecGContact.RESET;
        IF RecGContact.FIND('-') THEN BEGIN
            IntGNb := RecGContact.COUNT;
            IntGI := 0;
            DiaGWindow.OPEN('Table Contact     @1@@@@@@@@@@\' +
                            'N° article #2##########');
            REPEAT
                IntGI := IntGI + 1;
                DiaGWindow.UPDATE(1, ROUND(IntGI / IntGNb * 10000, 1));
                DiaGWindow.UPDATE(2, RecGContact."No.");

                RecGPostCode.RESET;
                RecGPostCode.SETRANGE(RecGPostCode.Code, RecGContact."Post Code");
                RecGPostCode.SETRANGE(RecGPostCode.City, RecGContact.City);

                IF NOT RecGPostCode.FIND('-')
                  THEN BEGIN
                    RecGPostCode.INIT;
                    RecGPostCode.VALIDATE(Code, RecGContact."Post Code");
                    RecGPostCode.VALIDATE(City, RecGContact.City);
                    RecGPostCode.INSERT(TRUE);
                END;
            UNTIL RecGContact.NEXT = 0;
            DiaGWindow.CLOSE;
        END;

        //>>TODOLIST DARI 06/03/2007 point 52
    end;

    var
        RecGPostCode: Record "225";
        IntGI: Integer;
        RecGCustomer: Record "18";
        RecGVendor: Record "23";
        RecGShiptoAddress: Record "222";
        IntGNb: Integer;
        DiaGWindow: Dialog;
        RecGContact: Record "5050";
}

