page 51111 "BC6_Setup Various Tables2"
{
    Caption = 'Setup Various Tables', Comment = 'FRA="Parametrage Tables Diverses"';
    PageType = Card;
    SourceTable = "BC6_Setup Various Tables";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
            group(Control1100267000)
            {
                grid(Control1100267001)
                {
                    group(Control1100267005)
                    {
                        field("Text1 Use"; Rec."Text1 Use")
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                Text1UseOnAfterValidate();
                            end;
                        }
                        field("Text2 Use"; Rec."Text2 Use")
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                Text2UseOnAfterValidate();
                            end;
                        }
                        field("Text3 Use"; Rec."Text3 Use")
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                Text3UseOnAfterValidate();
                            end;
                        }
                        field("Number1 Use"; Rec."Number1 Use")
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                Number1UseOnAfterValidate();
                            end;
                        }
                        field("Number2 Use"; Rec."Number2 Use")
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                Number2UseOnAfterValidate();
                            end;
                        }
                        field("Number3 Use"; Rec."Number3 Use")
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                Number3UseOnAfterValidate();
                            end;
                        }
                        field("Date1 Use"; Rec."Date1 Use")
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                Date1UseOnAfterValidate();
                            end;
                        }
                        field("Date2 Use"; Rec."Date2 Use")
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                Date2UseOnAfterValidate();
                            end;
                        }
                        field("Date3 Use"; Rec."Date3 Use")
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                Date3UseOnAfterValidate();
                            end;
                        }
                        field("Top Logical1 Use"; Rec."Top Logical1 Use")
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                TopLogical1UseOnAfterValidate();
                            end;
                        }
                        field("Top Logical2 Use"; Rec."Top Logical2 Use")
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                TopLogical2UseOnAfterValidate();
                            end;
                        }
                        field("Top Logical3 Use"; Rec."Top Logical3 Use")
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                TopLogical3UseOnAfterValidate();
                            end;
                        }
                        field("Radical Code1 Use"; Rec."Radical Code1 Use")
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                RadicalCode1UseOnAfterValidate();
                            end;
                        }
                        field("Radical Code2 Use"; Rec."Radical Code2 Use")
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                RadicalCode2UseOnAfterValidate();
                            end;
                        }
                        field("Radical Code3 Use"; Rec."Radical Code3 Use")
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                RadicalCode3UseOnAfterValidate();
                            end;
                        }
                        field("Comment Use"; Rec."Comment Use")
                        {
                            ApplicationArea = All;
                        }
                    }
                    group(Control1100267003)
                    {
                        label("Text 1 Description")
                        {
                            Caption = 'Text1 Description', Comment = 'FRA="Libellé Texte1"';
                            Enabled = "Text1 DescriptionEnable";
                            ShowCaption = false;
                            Style = Standard;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                        label("Text 2 Description")
                        {
                            Caption = 'Text2 Description', Comment = 'FRA="Libellé Texte2"';
                            Enabled = "Text2 DescriptionEnable";
                            ShowCaption = false;
                            ApplicationArea = All;
                        }
                        label("Text 3 Description")
                        {
                            Caption = 'Text3 Description', Comment = 'FRA="Libellé Texte3"';
                            Enabled = "Text3 DescriptionEnable";
                            ShowCaption = false;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1100267002)
                    {
                        field("Text1 Description"; Rec."Text1 Description")
                        {
                            ApplicationArea = All;
                        }
                        field("Text2 Description"; Rec."Text2 Description")
                        {
                            ApplicationArea = All;
                        }
                        field("Text3 Description"; Rec."Text3 Description")
                        {
                            ApplicationArea = All;
                        }
                    }
                    group(Control1100267009)
                    {
                        field("Number1 Description"; Rec."Number1 Description")
                        {
                            Enabled = "Number1 DescriptionEnable";
                            ApplicationArea = All;
                        }
                        field("Number2 Description"; Rec."Number2 Description")
                        {
                            Enabled = "Number2 DescriptionEnable";
                            ApplicationArea = All;
                        }
                        field("Number3 Description"; Rec."Number3 Description")
                        {
                            Enabled = "Number3 DescriptionEnable";
                            ApplicationArea = All;
                        }
                        field("Date1 Description"; Rec."Date1 Description")
                        {
                            Enabled = "Date1 DescriptionEnable";
                            ApplicationArea = All;
                        }
                        field("Date2 Description"; Rec."Date2 Description")
                        {
                            Enabled = "Date2 DescriptionEnable";
                            ApplicationArea = All;
                        }
                        field("Date3 Description"; Rec."Date3 Description")
                        {
                            Enabled = "Date3 DescriptionEnable";
                            ApplicationArea = All;
                        }
                        field("Top Logical1 Description"; Rec."Top Logical1 Description")
                        {
                            Enabled = "Top Logical1 DescriptionEnable";
                            ApplicationArea = All;
                        }
                        field("Top Logical2 Description"; Rec."Top Logical2 Description")
                        {
                            Enabled = "Top Logical2 DescriptionEnable";
                            ApplicationArea = All;
                        }
                        field("Top Logical3 Description"; Rec."Top Logical3 Description")
                        {
                            Enabled = "Top Logical3 DescriptionEnable";
                            ApplicationArea = All;
                        }
                        field("Radical Code1"; Rec."Radical Code1")
                        {
                            Enabled = "Radical Code1Enable";
                            ApplicationArea = All;
                        }
                        field("Obligatory Radical Code1"; Rec."Obligatory Radical Code1")
                        {
                            Enabled = "Obligatory Radical Code1Enable";
                            ApplicationArea = All;
                        }
                        field("Radical Code2"; Rec."Radical Code2")
                        {
                            Enabled = "Radical Code2Enable";
                            ApplicationArea = All;
                        }
                        field("Obligatory Radical Code2"; Rec."Obligatory Radical Code2")
                        {
                            Enabled = "Obligatory Radical Code2Enable";
                            ApplicationArea = All;
                        }
                        field("Radical Code3"; Rec."Radical Code3")
                        {
                            Enabled = "Radical Code3Enable";
                            ApplicationArea = All;
                        }
                        field("Obligatory Radical Code3"; Rec."Obligatory Radical Code3")
                        {
                            Enabled = "Obligatory Radical Code3Enable";
                            ApplicationArea = All;
                        }
                    }
                    group(Control1100267004)
                    {
                        field("Obligatory Text1"; Rec."Obligatory Text1")
                        {
                            Enabled = "Obligatory Text1Enable";
                            ApplicationArea = All;
                        }
                        field("Obligatory Text2"; Rec."Obligatory Text2")
                        {
                            Enabled = "Obligatory Text2Enable";
                            ApplicationArea = All;
                        }
                        field("Obligatory Text3"; Rec."Obligatory Text3")
                        {
                            Enabled = "Obligatory Text3Enable";
                            ApplicationArea = All;
                        }
                        field("Obligatory Number1"; Rec."Obligatory Number1")
                        {
                            Enabled = "Obligatory Number1Enable";
                            ApplicationArea = All;
                        }
                        field("Obligatory Number2"; Rec."Obligatory Number2")
                        {
                            Enabled = "Obligatory Number2Enable";
                            ApplicationArea = All;
                        }
                        field("Obligatory Number3"; Rec."Obligatory Number3")
                        {
                            Enabled = "Obligatory Number3Enable";
                            ApplicationArea = All;
                        }
                        field("Obligatory Date1"; Rec."Obligatory Date1")
                        {
                            Enabled = "Obligatory Date1Enable";
                            ApplicationArea = All;
                        }
                        field("Obligatory Date2"; Rec."Obligatory Date2")
                        {
                            Enabled = "Obligatory Date2Enable";
                            ApplicationArea = All;
                        }
                        field("Obligatory Date3"; Rec."Obligatory Date3")
                        {
                            Enabled = "Obligatory Date3Enable";
                            ApplicationArea = All;
                        }
                        field("Radical Code1 Description"; Rec."Radical Code1 Description")
                        {
                            Enabled = RadicalCode1DescriptionEnable;
                            ApplicationArea = All;
                        }
                        field("Radical Code2 Description"; Rec."Radical Code2 Description")
                        {
                            Enabled = RadicalCode2DescriptionEnable;
                            ApplicationArea = All;
                        }
                        field("Radical Code3 Description"; Rec."Radical Code3 Description")
                        {
                            Enabled = RadicalCode3DescriptionEnable;
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Gestion Tables Diverses")
            {
                Caption = 'Gestion Tables Diverses', Comment = 'FRA="Gestion Tables Diverses"';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    TableDiv.SETRANGE(Radical, Rec.Code);
                    PAGE.RUNMODAL(PAGE::"BC6_Various Tables", TableDiv);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EnableFields();
    end;

    var
        TableDiv: Record "BC6_Various Tables";
        "Object": Record Object;
        [InDataSet]
        "Date1 DescriptionEnable": Boolean;
        [InDataSet]
        "Date2 DescriptionEnable": Boolean;
        [InDataSet]
        "Date3 DescriptionEnable": Boolean;
        [InDataSet]
        "Number1 DescriptionEnable": Boolean;
        [InDataSet]
        "Number2 DescriptionEnable": Boolean;
        [InDataSet]
        "Number3 DescriptionEnable": Boolean;
        [InDataSet]
        "Obligatory Date1Enable": Boolean;
        [InDataSet]
        "Obligatory Date2Enable": Boolean;
        [InDataSet]
        "Obligatory Date3Enable": Boolean;
        [InDataSet]
        "Obligatory Number1Enable": Boolean;
        [InDataSet]
        "Obligatory Number2Enable": Boolean;
        [InDataSet]
        "Obligatory Number3Enable": Boolean;
        [InDataSet]
        "Obligatory Radical Code1Enable": Boolean;
        [InDataSet]
        "Obligatory Radical Code2Enable": Boolean;
        [InDataSet]
        "Obligatory Radical Code3Enable": Boolean;
        [InDataSet]
        "Obligatory Text1Enable": Boolean;
        [InDataSet]
        "Obligatory Text2Enable": Boolean;
        [InDataSet]
        "Obligatory Text3Enable": Boolean;
        [InDataSet]
        RadicalCode1DescriptionEnable: Boolean;
        [InDataSet]
        "Radical Code1Enable": Boolean;
        [InDataSet]
        RadicalCode2DescriptionEnable: Boolean;
        [InDataSet]
        "Radical Code2Enable": Boolean;
        [InDataSet]
        RadicalCode3DescriptionEnable: Boolean;
        [InDataSet]
        "Radical Code3Enable": Boolean;
        [InDataSet]
        "Text1 DescriptionEnable": Boolean;
        [InDataSet]
        "Text2 DescriptionEnable": Boolean;
        [InDataSet]
        "Text3 DescriptionEnable": Boolean;
        [InDataSet]
        "Top Logical1 DescriptionEnable": Boolean;
        [InDataSet]
        "Top Logical2 DescriptionEnable": Boolean;
        [InDataSet]
        "Top Logical3 DescriptionEnable": Boolean;

    procedure EnableFields()
    begin
        // Texte
        "Text1 DescriptionEnable" := Rec."Text1 Use" = TRUE;
        "Text2 DescriptionEnable" := Rec."Text2 Use" = TRUE;
        "Text3 DescriptionEnable" := Rec."Text3 Use" = TRUE;
        "Obligatory Text1Enable" := Rec."Text1 Use" = TRUE;
        "Obligatory Text2Enable" := Rec."Text2 Use" = TRUE;
        "Obligatory Text3Enable" := Rec."Text3 Use" = TRUE;

        // Nombre
        "Number1 DescriptionEnable" := Rec."Number1 Use" = TRUE;
        "Number2 DescriptionEnable" := Rec."Number2 Use" = TRUE;
        "Number3 DescriptionEnable" := Rec."Number3 Use" = TRUE;
        "Obligatory Number1Enable" := Rec."Number1 Use" = TRUE;
        "Obligatory Number2Enable" := Rec."Number2 Use" = TRUE;
        "Obligatory Number3Enable" := Rec."Number3 Use" = TRUE;

        // Date
        "Date1 DescriptionEnable" := Rec."Date1 Use" = TRUE;
        "Date2 DescriptionEnable" := Rec."Date2 Use" = TRUE;
        "Date3 DescriptionEnable" := Rec."Date3 Use" = TRUE;
        "Obligatory Date1Enable" := Rec."Date1 Use" = TRUE;
        "Obligatory Date2Enable" := Rec."Date2 Use" = TRUE;
        "Obligatory Date3Enable" := Rec."Date3 Use" = TRUE;

        // Top Logique
        "Top Logical1 DescriptionEnable" := Rec."Top Logical1 Use" = TRUE;
        "Top Logical2 DescriptionEnable" := Rec."Top Logical2 Use" = TRUE;
        "Top Logical3 DescriptionEnable" := Rec."Top Logical3 Use" = TRUE;

        // Code Radical
        RadicalCode1DescriptionEnable := Rec."Radical Code1 Use" = TRUE;
        RadicalCode2DescriptionEnable := Rec."Radical Code2 Use" = TRUE;
        RadicalCode3DescriptionEnable := Rec."Radical Code3 Use" = TRUE;
        "Radical Code1Enable" := Rec."Radical Code1 Use" = TRUE;
        "Radical Code2Enable" := Rec."Radical Code2 Use" = TRUE;
        "Radical Code3Enable" := Rec."Radical Code3 Use" = TRUE;
        "Obligatory Radical Code1Enable" := Rec."Radical Code1 Use" = TRUE;
        "Obligatory Radical Code2Enable" := Rec."Radical Code2 Use" = TRUE;
        "Obligatory Radical Code3Enable" := Rec."Radical Code3 Use" = TRUE;
    end;

    local procedure Text1UseOnAfterValidate()
    begin
        EnableFields();
    end;

    local procedure Text2UseOnAfterValidate()
    begin
        EnableFields();
    end;

    local procedure Text3UseOnAfterValidate()
    begin
        EnableFields();
    end;

    local procedure Number1UseOnAfterValidate()
    begin
        EnableFields();
    end;

    local procedure Number2UseOnAfterValidate()
    begin
        EnableFields();
    end;

    local procedure Number3UseOnAfterValidate()
    begin
        EnableFields();
    end;

    local procedure Date1UseOnAfterValidate()
    begin
        EnableFields();
    end;

    local procedure Date2UseOnAfterValidate()
    begin
        EnableFields();
    end;

    local procedure Date3UseOnAfterValidate()
    begin
        EnableFields();
    end;

    local procedure TopLogical1UseOnAfterValidate()
    begin
        EnableFields();
    end;

    local procedure TopLogical2UseOnAfterValidate()
    begin
        EnableFields();
    end;

    local procedure TopLogical3UseOnAfterValidate()
    begin
        EnableFields();
    end;

    local procedure RadicalCode1UseOnAfterValidate()
    begin
        EnableFields();
    end;

    local procedure RadicalCode2UseOnAfterValidate()
    begin
        EnableFields();
    end;

    local procedure RadicalCode3UseOnAfterValidate()
    begin
        EnableFields();
    end;
}

