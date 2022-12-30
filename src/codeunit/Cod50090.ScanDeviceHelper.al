codeunit 50090 "BC6_ScanDeviceHelper"
{
    var
        ConfChange: label 'Change default Bin Content for Item %1 ?', comment = 'FRA="Changer l''emplacement par défaut pour l''article %1 ?"';
        ConvertFrom: label '&é"''(-è_çà';
        ConvertTo: label '1234567890';


    procedure ConvertScanData(_TextToConvert: Text): Text
    begin
        exit(CONVERTSTR(_TextToConvert, ConvertFrom, ConvertTo));
    end;


    procedure ChangeDefaultBinContent(ItemNo: Code[20]; VariantCode: Code[10])
    var
        BinContent: Record "Bin Content";
        BinContent2: Record "Bin Content";
    begin
        if CONFIRM(ConfChange, false, ItemNo) then begin
            BinContent.FILTERGROUP(4);
            BinContent.SETRANGE("Item No.", ItemNo);
            BinContent.SETRANGE("Variant Code", VariantCode);
            BinContent.FILTERGROUP(0);
            if ACTION::LookupOK = PAGE.RUNMODAL(PAGE::"Item Bin Contents", BinContent) then
                if not BinContent.Default then begin
                    BinContent2.SETRANGE("Item No.", ItemNo);
                    BinContent2.SETRANGE("Variant Code", VariantCode);
                    BinContent2.SETRANGE(Default, true);
                    BinContent2.MODIFYALL(Default, false);
                    BinContent2 := BinContent;
                    BinContent2.VALIDATE(Default, true);
                    BinContent2.MODIFY(true);
                end;


        end;
    end;


    procedure GetDefaultBinContent(ItemNo: Code[20]; VariantCode: Code[10]): Code[20]
    var
        BinContent: Record "Bin Content";
    begin
        BinContent.SETRANGE("Item No.", ItemNo);
        BinContent.SETRANGE("Variant Code", VariantCode);
        BinContent.SETRANGE(Default, true);
        if BinContent.FINDFIRST() then
            exit(BinContent."Bin Code");
    end;


    procedure GetValueOfSubmition(ControlID: Integer; _Xml: Text): Text
    var
    //TODO: DotNet 
    // dotXmlDocument: DotNet XmlDocument;
    // dotXmlElement: DotNet XmlElement;
    // dotXmlCDATA: DotNet XmlCDataSection;
    begin
        // dotXmlDocument := dotXmlDocument.XmlDocument();
        // dotXmlDocument.LoadXml(_Xml);
        // dotXmlElement := dotXmlDocument.SelectSingleNode('/root/control[@id=''' + FORMAT(ControlID) + ''']');
        // IF ISNULL(dotXmlElement) THEN
        //     EXIT('');
        // EXIT(dotXmlElement.InnerText);
    end;
}

