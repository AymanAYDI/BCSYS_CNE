page 50023 "BC6_Intégration article"
{
    ApplicationArea = All;
    Caption = 'Intégration article';
    InsertAllowed = false;
    PageType = List;
    SourceTable = "BC6_Temporary import catalogue";
    UsageCategory = Tasks;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Ref_externe; Rec.Ref_externe)
                {
                    ApplicationArea = All;
                }
                field(Ref_Interne; Rec.Ref_Interne)
                {
                    ApplicationArea = All;
                }
                field(designation; Rec.designation)
                {
                    ApplicationArea = All;
                }
                field(Prix_public; Rec.Prix_public)
                {
                    ApplicationArea = All;
                }
                field(famille; Rec.famille)
                {
                    ApplicationArea = All;
                }
                field(remise; Rec.remise)
                {
                    ApplicationArea = All;
                }
                field(prix_net; Rec.prix_net)
                {
                    ApplicationArea = All;
                }
                field("date debut"; Rec."date debut")
                {
                    ApplicationArea = All;
                }
                field("date fin"; Rec."date fin")
                {
                    ApplicationArea = All;
                }
                field(Vendor; Rec.Vendor)
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                field("Item BarCode"; Rec."Item BarCode")
                {
                    ApplicationArea = All;
                }
                field(BarCode; Rec.BarCode)
                {
                    ApplicationArea = All;
                }
                field("Replace Item BarCode"; Rec."Replace Item BarCode")
                {
                    ApplicationArea = All;
                }
                field("DEEE Category Code"; Rec."DEEE Category Code")
                {
                    ApplicationArea = All;
                }
                field("Number of Units DEEE"; Rec."Number of Units DEEE")
                {
                    ApplicationArea = All;
                }
                field("DEEE Unit Amount"; Rec."DEEE Unit Amount")
                {
                    ApplicationArea = All;
                }
                field("Emplacement par défaut"; Rec."Emplacement par défaut")
                {
                    ApplicationArea = All;
                }
                field(Stocks; Rec.Stocks)
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
                ApplicationArea = All;
                Caption = 'Import', Comment = 'FRA="Import"';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF Rec.FIND('-') THEN
                        IF CONFIRM(textg002, FALSE) THEN BEGIN
                            Rec.RESET();
                            Rec.DELETEALL();
                        END;

                    COMMIT();

                    XMLPORT.RUN(XmlPort::"BC6_Intégration catalogue", TRUE, TRUE);
                    Rec.RESET();
                    CurrPage.UPDATE(TRUE);
                    IF NOT Rec.FIND('-') THEN;
                end;
            }
            action("Update")
            {
                ApplicationArea = All;
                Caption = 'Update', Comment = 'FRA="Mise à Jour"';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.RESET();
                    IF Rec.FIND('-') THEN
                        IF CONFIRM(textg001, FALSE) THEN BEGIN
                            Rec.importdata();
                            Rec.DELETEALL();
                        END;
                end;
            }
            action("Update Item Std Cost")
            {
                ApplicationArea = All;
                Caption = 'Update Item Std Cost', Comment = 'FRA="Maj Coût standard article"';
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    REPORT.RUNMODAL(Report::"BC6_Maj Cout standard article");
                    MESSAGE(textG005);
                end;
            }
        }
    }

    var
        textg001: Label 'do you want integrate this data ?', Comment = 'FRA="Voulez vous intégrer ces données ?"';
        textg002: Label 'Empty Integration form ?', Comment = 'FRA="Remettre à zéro le formulaire d''intégration ? "';
        textG005: Label 'Mise à jour terminée.', Comment = 'FRA="Mise à jour terminée."';
}
