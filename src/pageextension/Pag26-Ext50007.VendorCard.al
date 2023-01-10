pageextension 50007 "BC6_VendorCard" extends "Vendor Card" //26
{
    layout
    {
        addafter(Name)
        {
            field("BC6_Name 2"; Rec."Name 2")
            {
                ApplicationArea = All;
                Caption = 'Name 2';
            }
        }

        addafter("Last Date Modified")
        {
            field("BC6_Creation Date"; Rec."BC6_Creation Date")
            {
                ApplicationArea = All;
                Caption = 'Creation Date', Comment = 'FRA="Date de création"';
            }
        }

        addafter("Responsibility Center")
        {
            field("BC6_Blocked Prices"; Rec."BC6_Blocked Prices")
            {
                ApplicationArea = All;
                Caption = 'Blocked Prices', Comment = 'FRA="Prix bloqués"';
            }
            field("BC6_% Mini Margin"; Rec."BC6_% Mini Margin")
            {
                Visible = ShowMiniMargin;
                ApplicationArea = All;
                Caption = '% Mini Margin', Comment = 'FRA="% marge mini"';
            }
        }

        addafter(Invoicing)
        {
            field("BC6_Mini Amount"; Rec."BC6_Mini Amount")
            {
                ApplicationArea = All;
                Caption = 'Montant mini franco ', Comment = 'FRA="Montant mini franco "';
            }
            field("BC6_Freight Amount"; Rec."BC6_Freight Amount")
            {
                ApplicationArea = All;
                Caption = 'Freight Amount', Comment = 'FRA="montant port si franco non atteint"';
            }
            field("BC6_Posting DEEE"; Rec."BC6_Posting DEEE")
            {
                ApplicationArea = All;
                Caption = 'Posting DEEE', Comment = 'FRA="Comptabilisation DEEE"';
            }
        }

        addafter("""Balance (LCY)"" - ""Payment in progress (LCY)""")
        {
            field("BC6_Lead Time Calculation"; Rec."Lead Time Calculation")
            {
                Importance = Promoted;
                ToolTip = 'Specifies a date formula for the time that it takes to replenish the item.', Comment = 'FRA="Spécifie une formule date pour le délai nécessaire au réapprovisionnement de l''article."';
                Visible = false;
                ApplicationArea = All;
                Caption = 'Lead Time Calculation';
            }
        }

        addafter("Customized Calendar")
        {
            group(BC6_TransGroupe)
            {
                showcaption = false;
                field("BC6_Transaction Type"; Rec."BC6_Transaction Type")
                {
                    ApplicationArea = All;
                    Caption = 'Transaction Type', Comment = 'FRA="Nature Transaction"';
                    trigger OnValidate()
                    begin
                        Incoterm();
                    end;
                }
                field(BC6_TxtGTransType; TxtGTransType)
                {
                    Editable = false;
                    ApplicationArea = All;
                    showcaption = false;
                }
            }
            group(BC6_TransSpecGroupe)
            {
                showcaption = false;
                field("BC6_Transaction Specification"; Rec."BC6_Transaction Specification")
                {
                    ApplicationArea = All;
                    Caption = 'Transaction Specification', Comment = 'FRA="Régime"';
                    trigger OnValidate()
                    begin
                        Incoterm();
                    end;
                }
                field(BC6_TxtGTransSpe; TxtGTransSpe)
                {
                    Editable = false;
                    ApplicationArea = All;
                    showcaption = false;
                }
            }
            group(BC6_TransMethGroupe)
            {
                showcaption = false;
                field("BC6_Transport Method"; Rec."BC6_Transport Method")
                {
                    ApplicationArea = All;
                    Caption = 'Transport Method', Comment = 'FRA="Mode transport"';
                    trigger OnValidate()
                    begin
                        Incoterm();
                    end;
                }
                field(BC6_TxtGTransMeth; TxtGTransMeth)
                {
                    Editable = false;
                    ApplicationArea = All;
                    showcaption = false;
                }
            }
            group(BC6_EntryPointGroupe)
            {
                showcaption = false;
                field("BC6_Entry Point"; Rec."BC6_Entry Point")
                {
                    ApplicationArea = All;
                    Caption = 'Entry  Point', Comment = 'FRA="Pays Provenance"';
                    trigger OnValidate()
                    begin
                        Incoterm();
                    end;
                }
                field(BC6_TxtGESPoint; TxtGESPoint)
                {
                    Editable = false;
                    ApplicationArea = All;
                    showcaption = false;
                }
            }
            group(BC6_AreaGroupe)
            {
                showcaption = false;
                field(BC6_Area; Rec.BC6_Area)
                {
                    ApplicationArea = All;
                    Caption = 'Area', Comment = 'FRA="Departement Destination"';
                    trigger OnValidate()
                    begin
                        Incoterm();
                    end;
                }
                field(BC6_TxtGArea; TxtGArea)
                {
                    Editable = false;
                    ApplicationArea = All;
                    showcaption = false;

                }
            }
        }
    }

    actions
    {
        addafter("Blanket Orders")
        {
            separator(sep1)
            {
            }
            action("BC6_Associated Document")
            {
                Caption = 'Associated Document', Comment = 'FRA="Document Associé"';
                Image = Document;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Doc: Record "BC6_Navi+ Documents";
                    TableInformation: Record "Table Information";
                begin
                    Doc.SETRANGE(Doc."Table No.", 23);
                    Doc.SETRANGE(Doc."Reference No. 1", Rec."No.");
                    TableInformation.SETRANGE(TableInformation."Table No.", 23);
                    IF TableInformation.FindFirst() THEN
                        Doc.SETRANGE(Doc."Table Name", TableInformation."Table Name");
                    PAGE.RUNMODAL(Page::"BC6_Documents Managment", Doc);
                end;
            }
        }
        addafter("Vendor - Balance to Date")
        {
            action("BC6_Pay-to Vend. No.")
            {
                Caption = 'Pay-to Vend. No.', Comment = 'FRA="Tiers payeur"';
                Image = Vendor;
                RunObject = Page "Vendor List";
                RunPageLink = "BC6_Pay-to Vend. No." = FIELD("No.");
                ApplicationArea = All;
            }
            action("Achats Groupés")
            {
                Caption = 'Achats Groupés', Comment = 'FRA="Achats Groupés"';
                RunObject = Page "BC6_Sales Order Lines Test";
                RunPageLink = "BC6_Buy-from Vendor No." = FIELD("No.");
                ShortCutKey = 'Ctrl+K';
                Image = ItemGroup;
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Incoterm();
    end;

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.GET(USERID) and UserSetup."BC6_Aut. Real Sales Profit %" then begin
            ShowMiniMargin := true;
            CurrPage.Update();
        end else
            ShowMiniMargin := false;
    end;




    var

        RecGArea: Record "Area";
        RecGTransESPoint: Record "Entry/Exit Point";
        RecGTransSpe: Record "Transaction Specification";
        RecGTransType: Record "Transaction Type";
        RecGTransMeth: Record "Transport Method";
        ShowMiniMargin: Boolean;
        TxtGArea: Text[100];
        TxtGESPoint: Text[100];
        TxtGTransMeth: Text[100];
        TxtGTransSpe: Text[100];
        TxtGTransType: Text[100];

  

    procedure Incoterm()
    begin
        IF RecGTransSpe.GET(Rec."BC6_Transaction Specification") THEN
            TxtGTransSpe := RecGTransSpe.Text
        ELSE
            TxtGTransSpe := '';

        IF RecGTransType.GET(Rec."BC6_Transaction Type") THEN
            TxtGTransType := RecGTransType.Description
        ELSE
            TxtGTransType := '';

        IF RecGTransMeth.GET(Rec."BC6_Transport Method") THEN
            TxtGTransMeth := RecGTransMeth.Description
        ELSE
            TxtGTransMeth := '';

        IF RecGTransESPoint.GET(Rec."BC6_Entry Point") THEN
            TxtGESPoint := RecGTransESPoint.Description
        ELSE
            TxtGESPoint := '';

        IF RecGArea.GET(Rec.BC6_Area) THEN
            TxtGArea := RecGArea.Text
        ELSE
            TxtGArea := '';
    end;
}
