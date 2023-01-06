pageextension 50026 "BC6_JobCard" extends "Job Card" //88
{
    Caption = 'Job Card', comment = 'FRA="Fiche affaire"';
    layout
    {


        modify("Bill-to Address")
        {
            Visible = FALSE;
        }
        modify("Bill-to Address 2")
        {
            Visible = FALSE;
        }
        modify("Bill-to Post Code")
        {
            Visible = FALSE;
        }
        modify("Bill-to City")
        {
            Visible = FALSE;
        }
        modify("Bill-to Contact")
        {
            Visible = FALSE;
        }
        modify(Status)
        {
            Caption = 'Status_';
        }

        addafter("Bill-to Name")
        {
            field(BC6_Address; Rec."BC6_Address")
            {
                ApplicationArea = Jobs;
                Importance = Additional;
                ToolTip = 'Specifies the address of the Bill-to Customer, which you assigned to the current job, in the Bill-to Customer No. field. field.', Comment = 'FRA="Spécifie l''adresse du Client facturé que vous avez affecté au projet actif dans le champ N° client facturé."';
            }
            field("BC6_Address 2"; Rec."BC6_Address 2")
            {
                ApplicationArea = Jobs;
                Importance = Additional;
                ToolTip = 'Specifies the additional address of the Bill-to Customer, which you assigned to the current job, in the Bill-to Customer No. field. field.', Comment = 'FRA="Spécifie le complément d''adresse du Client facturé que vous avez affecté au projet actif dans le champ N° client facturé."';
            }
            field("BC6_Post Code"; Rec."BC6_Post Code")
            {
                ApplicationArea = Jobs;
                Importance = Additional;
                ToolTip = 'Specifies the post code of the Bill-to Customer, which you assigned to the current job, in the Bill-to Customer No. field. field.', Comment = 'FRA="Spécifie le code postal du Client facturé que vous avez affecté au projet actif dans le champ N° client facturé."';
            }
            field(BC6_City; Rec."BC6_City")
            {
                ApplicationArea = Jobs;
                Importance = Additional;
                ToolTip = 'Specifies the City of the Bill-to Customer, which you assigned to the current job, in the Bill-to Customer No. field. field.', Comment = 'FRA="Spécifie la ville du Client facturé que vous avez affecté au projet actif dans le champ N° client facturé."';
            }
            field(BC6_Country; Rec."BC6_Country")
            {
                ApplicationArea = All;
            }

        }

        addafter("Description")
        {
            field("BC6_Description 2"; Rec."Description 2")
            {
                Importance = Promoted;
                ApplicationArea = All;
            }
        }
        addafter("Last Date Modified")
        {
            field("BC6_Affair Responsible"; Rec."BC6_Affair Responsible")
            {
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                var
                    UserSetup: Record "User Setup";
                begin
                    IF PAGE.RUNMODAL(PAGE::"User Setup", UserSetup) = ACTION::LookupOK THEN
                        Rec.VALIDATE("BC6_Affair Responsible", PADSTR(UserSetup."User ID", 20));
                end;
            }
            field(BC6_Statut; Rec."BC6_Statut")
            {
                ApplicationArea = All;
            }
            field(BC6_Status; Rec.Status)
            {
                ApplicationArea = Jobs;
                Importance = Promoted;
                ToolTip = 'Specifies a status for the current job. You can change the status for the job as it progresses. Final calculations can be made on completed jobs.', Comment = 'FRA="Spécifie un statut pour le projet en cours. Vous pouvez changer le statut du projet en cours d''avancement. Les calculs finaux peuvent être effectués sur des projets terminés."';

                trigger OnValidate()
                begin
                    IF (Rec.Status = Rec.Status::Completed) AND Rec.Complete THEN BEGIN
                        Rec.RecalculateJobWIP();
                        CurrPage.UPDATE(FALSE);
                    END;
                end;
            }

        }
        addafter("Creation Date")
        {
            field("BC6_Bill-to Contact_BA"; Rec."Bill-to Contact")
            {
                Caption = 'Budget Amount', comment = 'FRA="Montant projet"';
                ApplicationArea = All;
            }

        }
        addafter("Calc. Recog. Costs G/L Amount")
        {
            group(BC6_Contact)
            {
                Caption = 'Contact';
                part(ContactAffairSub; "BC6_Contact Affair Subform")
                {
                    SubPageLink = "Affair No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }

            group(BC6_Comment)
            {
                Caption = 'Comment';
                part(AffairCommentSub; "BC6_Affair Comment Sub-form")
                {
                    SubPageLink = "Table Name" = FILTER(Job),
                                  "No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }

        }
    }
    actions
    {
        modify("&Job")
        {
            Caption = '&Job', comment = 'FRA="Affaire"';
        }

        addafter("&Online Map")
        {
            action("BC6_Sales document list")
            {
                Caption = 'Sales document list', Comment = 'FRA="Documents ventes"';
                Image = Sales;
                RunObject = Page "Sales List";
                RunPageLink = "BC6_Affair No." = FIELD("No.");
                ApplicationArea = All;
            }
            action("BC6_Purchase Doc. List")
            {
                Caption = 'Purchase Doc. List', Comment = 'FRA="Document achats"';
                Image = Purchase;
                RunObject = Page "Purchase List";
                RunPageLink = "BC6_Affair No." = FIELD("No.");
                ApplicationArea = All;
            }

        }
        modify("&Prices")
        {
            Visible = FALSE;
        }
        modify("Plan&ning")
        {
            Visible = FALSE;
        }
        modify("Resource &Allocated per Job")
        {
            Visible = FALSE;
        }
        addafter("<Action83>")
        {
            group("BC6_Associated Document")
            {
                Caption = 'Associated Document', Comment = 'FRA="Document Associé"';
                action(BC6_AssociatedDocument)
                {
                    Caption = 'Associated Document', Comment = 'FRA="Document Associé"';
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        Doc: Record "BC6_Navi+ Documents";
                        TableInformation: Record "Table Information";
                    begin
                        Doc.SETRANGE(Doc."Table No.", 167);
                        Doc.SETRANGE(Doc."Reference No. 1", Rec."No.");
                        TableInformation.SETRANGE(TableInformation."Table No.", 167);
                        IF TableInformation.FindFirst() THEN
                            Doc.SETRANGE(Doc."Table Name", TableInformation."Table Name");
                        PAGE.RUNMODAL(Page::"BC6_Documents Managment", Doc);
                    end;
                }
            }
        }

    }
}
