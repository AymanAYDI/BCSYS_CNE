page 50001 "BC6_Various Tables"
{
    Caption = 'Various Tables', comment = 'FRA="Tables Diverses"';
    PageType = List;
    SourceTable = "BC6_Various Tables";
    UsageCategory = Tasks;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Radical; Radical)
                {
                }
                field("Code"; Code)
                {
                    CaptionClass = CodeCaptionClass;
                }
                field(Description; Description)
                {
                }
                field(Text1; Text1)
                {
                    CaptionClass = Text1CaptionClass;
                    Visible = Text1Visible;
                }
                field(Text2; Text2)
                {
                    CaptionClass = Text2CaptionClass;
                    Visible = Text2Visible;
                }
                field(Text3; Text3)
                {
                    CaptionClass = Text3CaptionClass;
                    Visible = Text3Visible;
                }
                field(Number1; Number1)
                {
                    CaptionClass = Nombre1CaptionClass;
                    Visible = Number1Visible;
                }
                field(Number2; Number2)
                {
                    CaptionClass = Nombre2CaptionClass;
                    Visible = Number2Visible;
                }
                field(Number3; Number3)
                {
                    CaptionClass = Nombre3CaptionClass;
                    Visible = Number3Visible;
                }
                field(Date1; Date1)
                {
                    CaptionClass = Date1CaptionClass;
                    Visible = Date1Visible;
                }
                field(Date2; Date2)
                {
                    CaptionClass = Date2CaptionClass;
                    Visible = Date2Visible;
                }
                field(Date3; Date3)
                {
                    CaptionClass = Date3CaptionClass;
                    Visible = Date3Visible;
                }
                field("Top Logical1"; "Top Logical1")
                {
                    CaptionClass = Bool1CaptionClass;
                    Visible = "Top Logical1Visible";
                }
                field("Top Logical2"; "Top Logical2")
                {
                    CaptionClass = Bool2CaptionClass;
                    Visible = "Top Logical2Visible";
                }
                field("Top Logical3"; "Top Logical3")
                {
                    CaptionClass = Bool3CaptionClass;
                    Visible = "Top Logical3Visible";
                }
                field("Radical Code1"; "Radical Code1")
                {
                    CaptionClass = Rad1CaptionClass;
                    Visible = "Radical Code1Visible";

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Param.GET(Radical);
                        TableDiv.SETRANGE(Radical, Param."Radical Code1");
                        IF PAGE.RUNMODAL(PAGE::"BC6_Various Tables", TableDiv) = ACTION::LookupOK THEN "Radical Code1" := TableDiv.Code;
                    end;
                }
                field("Radical Code2"; "Radical Code2")
                {
                    CaptionClass = Rad2CaptionClass;
                    Visible = "Radical Code2Visible";

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Param.GET(Radical);
                        TableDiv.SETRANGE(Radical, Param."Radical Code2");
                        IF PAGE.RUNMODAL(PAGE::"BC6_Various Tables", TableDiv) = ACTION::LookupOK THEN "Radical Code2" := TableDiv.Code;
                    end;
                }
                field("Radical Code3"; "Radical Code3")
                {
                    CaptionClass = Rad3CaptionClass;
                    Visible = "Radical Code3Visible";

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Param.GET(Radical);
                        TableDiv.SETRANGE(Radical, Param."Radical Code3");
                        IF PAGE.RUNMODAL(PAGE::"BC6_Various Tables", TableDiv) = ACTION::LookupOK THEN "Radical Code3" := TableDiv.Code;
                    end;
                }
                field(Comment; Comment)
                {
                    AssistEdit = true;
                    Visible = CommentVisible;

                    trigger OnAssistEdit()
                    begin
                        CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::"IC Partner");
                        CommentLine.SETRANGE("No.", Radical + Code);
                        IF PAGE.RUNMODAL(PAGE::"Comment Sheet", CommentLine) = ACTION::LookupOK THEN BEGIN
                            CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::"IC Partner");
                            CommentLine.SETRANGE("No.", Radical + Code);
                            Comment := CommentLine.FIND('-');
                        END;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CommentVisible := TRUE;
        "Radical Code3Visible" := TRUE;
        "Radical Code2Visible" := TRUE;
        "Radical Code1Visible" := TRUE;
        "Top Logical3Visible" := TRUE;
        "Top Logical2Visible" := TRUE;
        "Top Logical1Visible" := TRUE;
        Date3Visible := TRUE;
        Date2Visible := TRUE;
        Date1Visible := TRUE;
        Number3Visible := TRUE;
        Number2Visible := TRUE;
        Number1Visible := TRUE;
        Text3Visible := TRUE;
        Text2Visible := TRUE;
        Text1Visible := TRUE;
        CodeCaptionClass := '50000,Code';
        Text1CaptionClass := '50000,Texte 1';
        Text2CaptionClass := '50000,Texte 2';
        Text3CaptionClass := '50000,Texte 3';
        Nombre1CaptionClass := '50000,Nombre 1';
        Nombre2CaptionClass := '50000,Nombre 2';
        Nombre3CaptionClass := '50000,Nombre 3';
        Date1CaptionClass := '50000,Date 1';
        Date2CaptionClass := '50000,Date 2';
        Date3CaptionClass := '50000,Date 3';
        Bool1CaptionClass := '50000,Top logique 1';
        Bool2CaptionClass := '50000,Top logique 2';
        Bool3CaptionClass := '50000,Top logique 3';
        Rad1CaptionClass := '50000,Code radical 1';
        Rad2CaptionClass := '50000,Code radical 2';
        Rad3CaptionClass := '50000,Code radical 3';
    end;

    trigger OnOpenPage()
    begin
        OnActivateForm;
    end;

    var
        Param: Record "BC6_Setup Various Tables";
        TableDiv: Record "BC6_Various Tables";
        DivTableParam_G: Record "BC6_Setup Various Tables";
        CommentLine: Record "Comment Line";
        Text001: Label 'This field cannot be empty.', comment = 'FRA="Ce champ ne doit pas être vide."';
        Descriptif: Text[50];
        TitreTexte1: Text[30];
        CodeCaptionClass: Text[80];
        Text1CaptionClass: Text[80];
        Text2CaptionClass: Text[80];
        Text3CaptionClass: Text[80];
        Nombre1CaptionClass: Text[80];
        Nombre2CaptionClass: Text[80];
        Nombre3CaptionClass: Text[80];
        Date1CaptionClass: Text[80];
        Date2CaptionClass: Text[80];
        Date3CaptionClass: Text[80];
        Bool1CaptionClass: Text[80];
        Bool2CaptionClass: Text[80];
        Bool3CaptionClass: Text[80];
        Rad1CaptionClass: Text[80];
        Rad2CaptionClass: Text[80];
        Rad3CaptionClass: Text[80];
        [InDataSet]
        Text1Visible: Boolean;
        [InDataSet]
        Text2Visible: Boolean;
        [InDataSet]
        Text3Visible: Boolean;
        [InDataSet]
        Number1Visible: Boolean;
        [InDataSet]
        Number2Visible: Boolean;
        [InDataSet]
        Number3Visible: Boolean;
        [InDataSet]
        Date1Visible: Boolean;
        [InDataSet]
        Date2Visible: Boolean;
        [InDataSet]
        Date3Visible: Boolean;
        [InDataSet]
        "Top Logical1Visible": Boolean;
        [InDataSet]
        "Top Logical2Visible": Boolean;
        [InDataSet]
        "Top Logical3Visible": Boolean;
        [InDataSet]
        "Radical Code1Visible": Boolean;
        [InDataSet]
        "Radical Code2Visible": Boolean;
        [InDataSet]
        "Radical Code3Visible": Boolean;
        [InDataSet]
        CommentVisible: Boolean;

    local procedure TopLogical1OnActivate()
    begin
        Descriptif := Param."Top Logical1 Description";
        CurrPage.UPDATE;
    end;

    local procedure TopLogical2OnActivate()
    begin
        Descriptif := Param."Top Logical2 Description";
        CurrPage.UPDATE;
    end;

    local procedure TopLogical3OnActivate()
    begin
        Descriptif := Param."Top Logical3 Description";
        CurrPage.UPDATE;
    end;

    local procedure OnActivateForm()
    begin

        IF GETFILTER(Radical) <> '' THEN
            IF GETRANGEMIN(Radical) = GETRANGEMAX(Radical) THEN
                IF Param.GET(Radical) THEN BEGIN

                    IF DivTableParam_G.GET(GETRANGEMAX(Radical)) THEN BEGIN

                        IF DivTableParam_G.Description <> '' THEN
                            CodeCaptionClass := STRSUBSTNO('50000,%1', DivTableParam_G.Description);

                        IF (DivTableParam_G."Text1 Use") AND (DivTableParam_G."Text1 Description" <> '') THEN
                            Text1CaptionClass := STRSUBSTNO('50000,%1', DivTableParam_G."Text1 Description");
                        IF (DivTableParam_G."Text2 Use") AND (DivTableParam_G."Text2 Description" <> '') THEN
                            Text2CaptionClass := STRSUBSTNO('50000,%1', DivTableParam_G."Text2 Description");
                        IF (DivTableParam_G."Text3 Use") AND (DivTableParam_G."Text3 Description" <> '') THEN
                            Text3CaptionClass := STRSUBSTNO('50000,%1', DivTableParam_G."Text3 Description");

                        IF (DivTableParam_G."Number1 Use") AND (DivTableParam_G."Number1 Description" <> '') THEN
                            Nombre1CaptionClass := STRSUBSTNO('50000,%1', DivTableParam_G."Number1 Description");
                        IF (DivTableParam_G."Number2 Use") AND (DivTableParam_G."Number2 Description" <> '') THEN
                            Nombre2CaptionClass := STRSUBSTNO('50000,%1', DivTableParam_G."Number2 Description");
                        IF (DivTableParam_G."Number3 Use") AND (DivTableParam_G."Number3 Description" <> '') THEN
                            Nombre3CaptionClass := STRSUBSTNO('50000,%1', DivTableParam_G."Number3 Description");

                        IF (DivTableParam_G."Date1 Use") AND (DivTableParam_G."Date1 Description" <> '') THEN
                            Date1CaptionClass := STRSUBSTNO('50000,%1', DivTableParam_G."Date1 Description");
                        IF (DivTableParam_G."Date2 Use") AND (DivTableParam_G."Date2 Description" <> '') THEN
                            Date2CaptionClass := STRSUBSTNO('50000,%1', DivTableParam_G."Date2 Description");
                        IF (DivTableParam_G."Date3 Use") AND (DivTableParam_G."Date3 Description" <> '') THEN
                            Date3CaptionClass := STRSUBSTNO('50000,%1', DivTableParam_G."Date3 Description");

                        IF (DivTableParam_G."Top Logical1 Use") AND (DivTableParam_G."Top Logical1 Description" <> '') THEN
                            Bool1CaptionClass := STRSUBSTNO('50000,%1', DivTableParam_G."Top Logical1 Description");
                        IF (DivTableParam_G."Top Logical2 Use") AND (DivTableParam_G."Top Logical2 Description" <> '') THEN
                            Bool2CaptionClass := STRSUBSTNO('50000,%1', DivTableParam_G."Top Logical2 Description");
                        IF (DivTableParam_G."Top Logical3 Use") AND (DivTableParam_G."Top Logical3 Description" <> '') THEN
                            Bool3CaptionClass := STRSUBSTNO('50000,%1', DivTableParam_G."Top Logical3 Description");

                        IF (DivTableParam_G."Radical Code1 Use") THEN BEGIN
                            DivTableParam_G.CALCFIELDS("Radical Code1 Description");
                            IF DivTableParam_G."Radical Code1 Description" <> '' THEN
                                Rad1CaptionClass := STRSUBSTNO('50000,%1', DivTableParam_G."Radical Code1 Description");
                        END;
                        IF (DivTableParam_G."Radical Code2 Use") THEN BEGIN
                            DivTableParam_G.CALCFIELDS("Radical Code2 Description");
                            IF DivTableParam_G."Radical Code2 Description" <> '' THEN
                                Rad2CaptionClass := STRSUBSTNO('50000,%1', DivTableParam_G."Radical Code2 Description");
                        END;
                        IF (DivTableParam_G."Radical Code3 Use") THEN BEGIN
                            DivTableParam_G.CALCFIELDS("Radical Code3 Description");
                            IF DivTableParam_G."Radical Code3 Description" <> '' THEN
                                Rad3CaptionClass := STRSUBSTNO('50000,%1', DivTableParam_G."Radical Code3 Description");
                        END;
                    END;

                    // Libelle du formulaire
                    CurrPage.CAPTION := Param.Description;

                    // Test pour savoir quelles sont les zones qui doivent être affichées
                    Text1Visible := Param."Text1 Use";
                    Text2Visible := Param."Text2 Use";
                    Text3Visible := Param."Text3 Use";

                    Number1Visible := Param."Number1 Use";
                    Number2Visible := Param."Number2 Use";
                    Number3Visible := Param."Number3 Use";

                    Date1Visible := Param."Date1 Use";
                    Date2Visible := Param."Date2 Use";
                    Date3Visible := Param."Date3 Use";

                    "Top Logical1Visible" := Param."Top Logical1 Use";
                    "Top Logical2Visible" := Param."Top Logical2 Use";
                    "Top Logical3Visible" := Param."Top Logical3 Use";

                    "Radical Code1Visible" := Param."Radical Code1 Use";
                    "Radical Code2Visible" := Param."Radical Code2 Use";
                    "Radical Code3Visible" := Param."Radical Code3 Use";

                    CommentVisible := Param."Comment Use";
                END;
    end;
}
