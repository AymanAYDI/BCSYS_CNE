page 560 "Dimension Value List"
{
    // //JX-VSC2.0-AUD
    // //Traitement pour Liste déroulante des axes analytiques afin que les opérationnels ne renseignent pas des analytiques

    Caption = 'Dimension Value List';
    DataCaptionExpression = GetFormCaption;
    Editable = false;
    PageType = List;
    SourceTable = Table349;

    layout
    {
        area(content)
        {
            repeater()
            {
                IndentationColumn = NameIndent;
                IndentationControls = Name;
                field(Code; Code)
                {
                    Style = Strong;
                    StyleExpr = Emphasize;
                }
                field(Name; Name)
                {
                    Style = Strong;
                    StyleExpr = Emphasize;
                }
                field("Dimension Value Type"; "Dimension Value Type")
                {
                    Visible = false;
                }
                field(Totaling; Totaling)
                {
                    Visible = false;
                }
                field(Blocked; Blocked)
                {
                    Visible = false;
                }
                field("Consolidation Code"; "Consolidation Code")
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(; Links)
            {
                Visible = false;
            }
            systempart(; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        NameIndent := 0;
        FormatLines;
    end;

    trigger OnOpenPage()
    begin
        GLSetup.GET;
    end;

    var
        GLSetup: Record "98";
        Text000: Label 'Shortcut Dimension %1';
        [InDataSet]
        Emphasize: Boolean;
        [InDataSet]
        NameIndent: Integer;

    [Scope('Internal')]
    procedure GetSelectionFilter(): Text
    var
        DimVal: Record "349";
        SelectionFilterManagement: Codeunit "46";
    begin
        CurrPage.SETSELECTIONFILTER(DimVal);
        EXIT(SelectionFilterManagement.GetSelectionFilterForDimensionValue(DimVal));
    end;

    [Scope('Internal')]
    procedure SetSelection(var DimVal: Record "349")
    begin
        CurrPage.SETSELECTIONFILTER(DimVal);
    end;

    local procedure GetFormCaption(): Text[250]
    begin
        IF GETFILTER("Dimension Code") <> '' THEN
            EXIT(GETFILTER("Dimension Code"));

        IF GETFILTER("Global Dimension No.") = '1' THEN
            EXIT(GLSetup."Global Dimension 1 Code");

        IF GETFILTER("Global Dimension No.") = '2' THEN
            EXIT(GLSetup."Global Dimension 2 Code");

        EXIT(STRSUBSTNO(Text000, "Global Dimension No."));
    end;

    local procedure FormatLines()
    begin
        Emphasize := "Dimension Value Type" <> "Dimension Value Type"::Standard;
        NameIndent := Indentation;
    end;
}

