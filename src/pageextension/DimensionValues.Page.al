page 537 "Dimension Values"
{
    // //JX-AUD du 18/10/2012
    // //Ajout du champ Masqué

    Caption = 'Dimension Values';
    DataCaptionFields = "Dimension Code";
    DelayedInsert = true;
    PageType = List;
    SaveValues = true;
    SourceTable = Table349;

    layout
    {
        area(content)
        {
            repeater()
            {
                IndentationColumn = NameIndent;
                IndentationControls = Name;
                field("Dimension Code"; "Dimension Code")
                {
                    Visible = true;
                }
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
                field(Masked; Masked)
                {
                }
                field("Dimension Value Type"; "Dimension Value Type")
                {
                }
                field(Totaling; Totaling)
                {

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DimVal: Record "349";
                        DimValList: Page "560";
                    begin
                        DimVal := Rec;
                        DimVal.SETRANGE("Dimension Code", "Dimension Code");
                        DimValList.SETTABLEVIEW(DimVal);
                        DimValList.LOOKUPMODE := TRUE;
                        IF DimValList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            DimValList.GETRECORD(DimVal);
                            Text := DimVal.Code;
                            EXIT(TRUE);
                        END;
                        EXIT(FALSE);
                    end;
                }
                field(Blocked; Blocked)
                {
                }
                field("Map-to IC Dimension Value Code"; "Map-to IC Dimension Value Code")
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
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Indent Dimension Values")
                {
                    Caption = 'Indent Dimension Values';
                    Image = Indent;
                    RunObject = Codeunit 409;
                    RunPageOnRec = true;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        NameIndent := 0;
        FormatLine;
    end;

    var
        [InDataSet]
        Emphasize: Boolean;
        [InDataSet]
        NameIndent: Integer;

    local procedure FormatLine()
    begin
        Emphasize := "Dimension Value Type" <> "Dimension Value Type"::Standard;
        NameIndent := Indentation;
    end;
}

