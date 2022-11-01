page 50093 "Sales Quote Archive SubformSTD"
{
    Caption = 'Lines';
    Editable = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = Table5108;
    SourceTableView = WHERE (Document Type=CONST(Quote));

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Type; Type)
                {
                }
                field("No."; "No.")
                {
                }
                field("Cross-Reference No."; "Cross-Reference No.")
                {
                    Visible = false;
                }
                field("Variant Code"; "Variant Code")
                {
                    Visible = false;
                }
                field("Substitution Available"; "Substitution Available")
                {
                    Visible = false;
                }
                field(Nonstock; Nonstock)
                {
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                    Visible = false;
                }
                field(Description; Description)
                {
                }
                field("Location Code"; "Location Code")
                {
                }
                field("Bin Code"; "Bin Code")
                {
                }
                field(Quantity; Quantity)
                {
                    BlankZero = true;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    Visible = false;
                }
                field("Item Disc. Group"; "Item Disc. Group")
                {
                    Editable = false;
                }
                field("Dispensation No."; "Dispensation No.")
                {
                    Editable = false;
                }
                field("Additional Discount %"; "Additional Discount %")
                {
                    Editable = false;
                }
                field("Dispensed Purchase Cost"; "Dispensed Purchase Cost")
                {
                    Editable = false;
                }
                field("Standard Net Price"; "Standard Net Price")
                {
                    Editable = false;
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                    Visible = false;
                }
                field("Purchase Cost"; "Purchase Cost")
                {
                }
                field("Public Price"; "Public Price")
                {
                }
                field("Unit Price"; "Unit Price")
                {
                    BlankZero = true;
                }
                field("Line Amount"; "Line Amount")
                {
                    BlankZero = true;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    BlankZero = true;
                }
                field("Discount Unit Price"; "Discount Unit Price")
                {
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    Visible = false;
                }
                field("Profit %"; "Profit %")
                {
                }
                field("Allow Invoice Disc."; "Allow Invoice Disc.")
                {
                    Visible = false;
                }
                field("Allow Item Charge Assignment"; "Allow Item Charge Assignment")
                {
                    Visible = false;
                }
                field("Purchasing Code"; "Purchasing Code")
                {
                }
                field("Work Type Code"; "Work Type Code")
                {
                    Visible = false;
                }
                field("Blanket Order No."; "Blanket Order No.")
                {
                    Visible = false;
                }
                field("Blanket Order Line No."; "Blanket Order Line No.")
                {
                    Visible = false;
                }
                field("Appl.-to Item Entry"; "Appl.-to Item Entry")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field(ShortcutDimCode[3];ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;
                }
                field(ShortcutDimCode[4];ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;
                }
                field(ShortcutDimCode[5];ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;
                }
                field(ShortcutDimCode[6];ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = false;
                }
                field(ShortcutDimCode[7];ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;
                }
                field(ShortcutDimCode[8];ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Visible = false;
                }
                field("DEEE Unit Price";"DEEE Unit Price")
                {
                }
                field("DEEE HT Amount";"DEEE HT Amount")
                {
                }
                field("DEEE Unit Price (LCY)";"DEEE Unit Price (LCY)")
                {
                }
                field("DEEE VAT Amount";"DEEE VAT Amount")
                {
                }
                field("DEEE TTC Amount";"DEEE TTC Amount")
                {
                }
                field("DEEE HT Amount (LCY)";"DEEE HT Amount (LCY)")
                {
                }
                field("Eco partner DEEE";"Eco partner DEEE")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;

                    trigger OnAction()
                    begin
                        ShowLineComments;
                    end;
                }
            }
        }
    }

    var
        ShortcutDimCode: array [8] of Code[20];

    [Scope('Internal')]
    procedure ShowShortcutDimCode(var ShortcutDimCode: array [8] of Code[20])
    var
        DimMgt: Codeunit "408";
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID",ShortcutDimCode);
    end;
}

