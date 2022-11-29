pageextension 50052 "BC6_VendorCard" extends "Vendor Card" //26
{
    layout
    {
        addafter(Name)
        {
            field("BC6_Name 2"; "Name 2")
            {
                ApplicationArea = All;
            }
        }

        addafter("Last Date Modified")
        {
            field("BC6_Creation Date"; "BC6_Creation Date")
            {
                ApplicationArea = All;
            }
        }

        addafter("Responsibility Center")
        {
            field("BC6_Blocked Prices"; "BC6_Blocked Prices")
            {
                ApplicationArea = All;
            }
            field("BC6_% Mini Margin"; "BC6_% Mini Margin")
            {
                Visible = ShowMiniMargin;
                ApplicationArea = All;
            }
        }

        addafter(Invoicing)
        {
            field("BC6_Mini Amount"; "BC6_Mini Amount")
            {
                ApplicationArea = All;
            }
            field("BC6_Freight Amount"; "BC6_Freight Amount")
            {
                ApplicationArea = All;
            }
            field("BC6_Posting DEEE"; "BC6_Posting DEEE")
            {
                ApplicationArea = All;
            }
        }

        addafter("""Balance (LCY)"" - ""Payment in progress (LCY)""")
        {
            field("BC6_Lead Time Calculation"; "Lead Time Calculation")
            {
                Importance = Promoted;
                ToolTip = 'Specifies a date formula for the time that it takes to replenish the item.', Comment = 'FRA="Sp‚cifie une formule date pour le d‚lai n‚cessaire au r‚approvisionnement de l''article."';
                Visible = false;
                ApplicationArea = All;
            }
        }

        addafter("Customized Calendar")
        {
            group(BC6_TransGroupe)
            {
                field("BC6_Transaction Type"; "BC6_Transaction Type")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Incoterm;
                    end;
                }
                field(BC6_TxtGTransType; TxtGTransType)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(BC6_TransSpecGroupe)
            {
                field("BC6_Transaction Specification"; "BC6_Transaction Specification")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Incoterm;
                    end;
                }
                field(BC6_TxtGTransSpe; TxtGTransSpe)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(BC6_TransMethGroupe)
            {
                field("BC6_Transport Method"; "BC6_Transport Method")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Incoterm;
                    end;
                }
                field(BC6_TxtGTransMeth; TxtGTransMeth)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(BC6_EntryPointGroupe)
            {
                field("BC6_Entry Point"; "BC6_Entry Point")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Incoterm;
                    end;
                }
                field(BC6_TxtGESPoint; TxtGESPoint)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(BC6_AreaGroupe)
            {
                field(BC6_Area; BC6_Area)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Incoterm;
                    end;
                }
                field(BC6_TxtGArea; TxtGArea)
                {
                    Editable = false;
                    ApplicationArea = All;
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
                Caption = 'Associated Document', Comment = 'FRA="Document Associ‚"';
                Image = Document;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Doc: Record "BC6_Navi+ Documents";
                    TableInformation: Record "Table Information";
                begin
                    Doc.SETRANGE(Doc."Table No.", 23);
                    Doc.SETRANGE(Doc."Reference No. 1", "No.");
                    TableInformation.SETRANGE(TableInformation."Table No.", 23);
                    IF TableInformation.FIND('-') THEN
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
                Caption = 'Achats Groupés', Comment = 'FRA="Achats Group‚s"';
                RunObject = Page "BC6_Sales Order Lines Test";
                RunPageLink = "BC6_Buy-from Vendor No." = FIELD("No.");
                ShortCutKey = 'Ctrl+K';
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Incoterm();
    end;

    var

        "-NSC1.00-": Integer;
        TxtGTransType: Text[100];
        TxtGTransSpe: Text[100];
        TxtGTransMeth: Text[100];
        TxtGESPoint: Text[100];
        TxtGArea: Text[100];
        RecGTransType: Record "Transaction Type";
        RecGTransSpe: Record "Transaction Specification";
        RecGTransMeth: Record "Transport Method";
        RecGTransESPoint: Record "Entry/Exit Point";
        RecGArea: Record "Area";
        ShowMiniMargin: Boolean;
        UserSetup: Record "User Setup";

    procedure SetShowMiniMargin(_ShowMiniMargin: Boolean)
    begin
        ShowMiniMargin := _ShowMiniMargin;
    end;

    procedure Incoterm()
    begin
        IF RecGTransSpe.GET("BC6_Transaction Specification") THEN
            TxtGTransSpe := RecGTransSpe.Text
        ELSE
            TxtGTransSpe := '';

        IF RecGTransType.GET("BC6_Transaction Type") THEN
            TxtGTransType := RecGTransType.Description
        ELSE
            TxtGTransType := '';

        IF RecGTransMeth.GET("BC6_Transport Method") THEN
            TxtGTransMeth := RecGTransMeth.Description
        ELSE
            TxtGTransMeth := '';

        IF RecGTransESPoint.GET("BC6_Entry Point") THEN
            TxtGESPoint := RecGTransESPoint.Description
        ELSE
            TxtGESPoint := '';

        IF RecGArea.GET(BC6_Area) THEN
            TxtGArea := RecGArea.Text
        ELSE
            TxtGArea := '';
    end;
}
