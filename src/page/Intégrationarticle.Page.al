page 50023 "Intégration article"
{
    // //Bug Compilation CASC 18/01/2007
    // //Change report Number CASC 18/01/2007 NSC1.01 : Change number Of Report 50101 to Report 50016
    //                                                  Add field 'Net Weight'
    // //Item import CASC 19/01/2007 FE06.V2 NSC1.01 : Block insertion
    //                                                 Delete table after update
    // 
    // //TODOLIST point 68 MICO 07/03/07 : affichage d'un message de fin de mise à jour du coût standard
    // 
    // //>>CNE5.00
    // TDL.76:20131120/CSC - Add fields "Bin Code" and "Stock"

    InsertAllowed = false;
    PageType = List;
    SourceTable = Table50005;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Ref_externe; Ref_externe)
                {
                }
                field(Ref_Interne; Ref_Interne)
                {
                }
                field(designation; designation)
                {
                }
                field(Prix_public; Prix_public)
                {
                }
                field(famille; famille)
                {
                }
                field(remise; remise)
                {
                }
                field(prix_net; prix_net)
                {
                }
                field("date debut"; "date debut")
                {
                }
                field("date fin"; "date fin")
                {
                }
                field(Vendor; Vendor)
                {
                }
                field("Item Category Code"; "Item Category Code")
                {
                }
                field("Product Group Code"; "Product Group Code")
                {
                }
                field("Net Weight"; "Net Weight")
                {
                }
                field("Item BarCode"; "Item BarCode")
                {
                }
                field(BarCode; BarCode)
                {
                }
                field("Replace Item BarCode"; "Replace Item BarCode")
                {
                }
                field("DEEE Category Code"; "DEEE Category Code")
                {
                }
                field("Number of Units DEEE"; "Number of Units DEEE")
                {
                }
                field("DEEE Unit Amount"; "DEEE Unit Amount")
                {
                }
                field("Emplacement par défaut"; "Emplacement par défaut")
                {
                }
                field(Stocks; Stocks)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Import)
            {
                Caption = 'Import';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF FIND('-') THEN
                        IF CONFIRM(textg002, FALSE) THEN BEGIN
                            RESET;
                            DELETEALL;
                        END;

                    COMMIT;

                    XMLPORT.RUN(50023, TRUE, TRUE);
                    RESET;
                    CurrPage.UPDATE(TRUE);
                    IF NOT FIND('-') THEN;
                end;
            }
            action(Update)
            {
                Caption = 'Update';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    RESET;
                    IF FIND('-') THEN
                        IF CONFIRM(textg001, FALSE) THEN BEGIN
                            importdata;
                            //>>Item import CASC 19/01/2007 FE06.V2 NSC1.01 : delete table after update
                            DELETEALL;
                            //<<Item import CASC 19/01/2007 FE06.V2 NSC1.01 : delete table after update
                        END;
                end;
            }
            action("Update Item Std Cost")
            {
                Caption = 'Update Item Std Cost';
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //REPORT.RUNMODAL(50101);
                    //>>Change report Number CASC 18/01/2007 NSC1.01
                    REPORT.RUNMODAL(50016);
                    //>>MICO point 68
                    MESSAGE(textG005);
                    //<<MICO point 68
                    //<<Change report Number CASC 18/01/2007 NSC1.01
                end;
            }
        }
    }

    var
        textg001: Label 'do you want integrate this data ?';
        textg002: Label 'Empty Integration form ?';
        textg003: Label 'Integration finished';
        TestG004: Label 'You can not insert line';
        textG005: Label 'Mise à jour terminée.';
}

