codeunit 50090 ScanDeviceHelper
{

    trigger OnRun()
    begin
    end;

    var
        ConvertFrom: Label '&é"''(-è_çà';
        ConvertTo: Label '1234567890';
        ConfChange: Label 'Change default Bin Content for Item %1 ?';

    [Scope('Internal')]
    procedure ConvertScanData(_TextToConvert: Text): Text
    begin
        EXIT(CONVERTSTR(_TextToConvert, ConvertFrom, ConvertTo));
    end;

    [Scope('Internal')]
    procedure ChangeDefaultBinContent(ItemNo: Code[20]; VariantCode: Code[10])
    var
        BinContent: Record "7302";
        BinContent2: Record "7302";
    begin
        IF CONFIRM(ConfChange, FALSE, ItemNo) THEN BEGIN
            BinContent.FILTERGROUP(4);
            BinContent.SETRANGE("Item No.", ItemNo);
            BinContent.SETRANGE("Variant Code", VariantCode);
            BinContent.FILTERGROUP(0);
            IF ACTION::LookupOK = PAGE.RUNMODAL(PAGE::"Item Bin Contents", BinContent) THEN BEGIN
                IF NOT BinContent.Default THEN BEGIN
                    BinContent2.SETRANGE("Item No.", ItemNo);
                    BinContent2.SETRANGE("Variant Code", VariantCode);
                    BinContent2.SETRANGE(Default, TRUE);
                    BinContent2.MODIFYALL(Default, FALSE);
                    BinContent2 := BinContent;
                    BinContent2.VALIDATE(Default, TRUE);
                    BinContent2.MODIFY(TRUE);
                END;
            END;

        END;
    end;

    [Scope('Internal')]
    procedure GetDefaultBinContent(ItemNo: Code[20]; VariantCode: Code[10]): Code[20]
    var
        BinContent: Record "7302";
    begin
        BinContent.SETRANGE("Item No.", ItemNo);
        BinContent.SETRANGE("Variant Code", VariantCode);
        BinContent.SETRANGE(Default, TRUE);
        IF BinContent.FINDFIRST THEN
            EXIT(BinContent."Bin Code");
    end;

    [Scope('Internal')]
    procedure GetValueOfSubmition(ControlID: Integer; _Xml: Text): Text
    var
        dotXmlDocument: DotNet XmlDocument;
        dotXmlElement: DotNet XmlElement;
        dotXmlCDATA: DotNet XmlCDataSection;
    begin
        dotXmlDocument := dotXmlDocument.XmlDocument();
        dotXmlDocument.LoadXml(_Xml);
        dotXmlElement := dotXmlDocument.SelectSingleNode('/root/control[@id=''' + FORMAT(ControlID) + ''']');
        IF ISNULL(dotXmlElement) THEN
            EXIT('');
        EXIT(dotXmlElement.InnerText);
    end;
}

