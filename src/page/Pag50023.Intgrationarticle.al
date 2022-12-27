page 50023 "BC6_Intégration article"
{
    InsertAllowed = false;
    PageType = List;
    SourceTable = "BC6_Temporary import catalogue";
    UsageCategory = Tasks;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Ref_externe; Ref_externe)
                {
                    ApplicationArea = All;
                }
                field(Ref_Interne; Ref_Interne)
                {
                    ApplicationArea = All;
                }
                field(designation; designation)
                {
                    ApplicationArea = All;
                }
                field(Prix_public; Prix_public)
                {
                    ApplicationArea = All;
                }
                field(famille; famille)
                {
                    ApplicationArea = All;
                }
                field(remise; remise)
                {
                    ApplicationArea = All;
                }
                field(prix_net; prix_net)
                {
                    ApplicationArea = All;
                }
                field("date debut"; "date debut")
                {
                    ApplicationArea = All;
                }
                field("date fin"; "date fin")
                {
                    ApplicationArea = All;
                }
                field(Vendor; Vendor)
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; "Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Product Group Code"; "Product Group Code")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; "Net Weight")
                {
                    ApplicationArea = All;
                }
                field("Item BarCode"; "Item BarCode")
                {
                    ApplicationArea = All;
                }
                field(BarCode; BarCode)
                {
                    ApplicationArea = All;
                }
                field("Replace Item BarCode"; "Replace Item BarCode")
                {
                    ApplicationArea = All;
                }
                field("DEEE Category Code"; "DEEE Category Code")
                {
                    ApplicationArea = All;
                }
                field("Number of Units DEEE"; "Number of Units DEEE")
                {
                    ApplicationArea = All;
                }
                field("DEEE Unit Amount"; "DEEE Unit Amount")
                {
                    ApplicationArea = All;
                }
                field("Emplacement par défaut"; "Emplacement par défaut")
                {
                    ApplicationArea = All;
                }
                field(Stocks; Stocks)
                {
                    ApplicationArea = All;
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
                Caption = 'Import', Comment = 'FRA="Import"';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF FIND('-') THEN
                        IF CONFIRM(textg002, FALSE) THEN BEGIN
                            RESET();
                            DELETEALL();
                        END;

                    COMMIT();

                    XMLPORT.RUN(XmlPort::"BC6_Intégration catalogue", TRUE, TRUE);
                    RESET();
                    CurrPage.UPDATE(TRUE);
                    IF NOT FIND('-') THEN;
                end;
            }
            action("Update")
            {
                Caption = 'Update', Comment = 'FRA="Mise à Jour"';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    RESET();
                    IF FIND('-') THEN
                        IF CONFIRM(textg001, FALSE) THEN BEGIN
                            importdata();
                            DELETEALL();
                        END;
                end;
            }
            action("Update Item Std Cost")
            {
                Caption = 'Update Item Std Cost', Comment = 'FRA="Maj Coût standard article"';
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    REPORT.RUNMODAL(Report::"BC6_Maj Cout standard article");
                    MESSAGE(textG005);
                end;
            }
        }
    }

    var
        TestG004: Label 'You can not insert line', Comment = 'FRA="vous ne pouvez pas insérer de ligne"';
        textg001: Label 'do you want integrate this data ?', Comment = 'FRA="Voulez vous intégrer ces données ?"';
        textg002: Label 'Empty Integration form ?', Comment = 'FRA="Remettre à zéro le formulaire d''intégration ? "';
        textg003: Label 'Integration finished', Comment = 'FRA="Intégration terminée"';
        textG005: Label 'Mise à jour terminée.', Comment = 'FRA="Mise à jour terminée."';
}

