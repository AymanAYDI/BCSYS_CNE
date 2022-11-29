page 50093 "Sales Quote Archive SubformSTD"
{
    Caption = 'Lines', Comment = 'FRA="Lignes"';
    Editable = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Sales Line Archive";
    SourceTableView = WHERE("Document Type" = CONST(Quote));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Cross-Reference No."; "Cross-Reference No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Variant Code"; "Variant Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Substitution Available"; "Substitution Available")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Nonstock; Nonstock)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; "Bin Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Item Disc. Group"; "BC6_Item Disc. Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Dispensation No."; "BC6_Dispensation No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Additional Discount %"; "BC6_Additional Discount %")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Dispensed Purchase Cost"; "BC6_Dispensed Purchase Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Standard Net Price"; "BC6_Standard Net Price")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Purchase Cost"; "BC6_Purchase Cost")
                {
                    ApplicationArea = All;
                }
                field("Public Price"; "BC6_Public Price")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; "Unit Price")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Line Amount"; "Line Amount")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Discount Unit Price"; "BC6_Discount Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Profit %"; "Profit %")
                {
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; "Allow Invoice Disc.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Allow Item Charge Assignment"; "Allow Item Charge Assignment")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Purchasing Code"; "Purchasing Code")
                {
                    ApplicationArea = All;
                }
                field("Work Type Code"; "Work Type Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Blanket Order No."; "Blanket Order No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Blanket Order Line No."; "Blanket Order Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; "Appl.-to Item Entry")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;
                    ApplicationArea = All;
                }

                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;
                    ApplicationArea = All;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;
                    ApplicationArea = All;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = false;
                    ApplicationArea = All;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;
                    ApplicationArea = All;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("DEEE Unit Price"; "BC6_DEEE Unit Price")
                {
                    ApplicationArea = All;
                }
                field("DEEE HT Amount"; "BC6_DEEE HT Amount")
                {
                    ApplicationArea = All;
                }
                field("DEEE Unit Price (LCY)"; "BC6_DEEE Unit Price (LCY)")
                {
                    ApplicationArea = All;
                }
                field("DEEE VAT Amount"; "BC6_DEEE VAT Amount")
                {
                    ApplicationArea = All;
                }
                field("DEEE TTC Amount"; "BC6_DEEE TTC Amount")
                {
                    ApplicationArea = All;
                }
                field("DEEE HT Amount (LCY)"; "BC6_DEEE HT Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Eco partner DEEE"; "BC6_Eco partner DEEE")
                {
                    ApplicationArea = All;
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
                Caption = '&Line', Comment = 'FRA="&Ligne"';
                Image = Line;
                action(Dimensions)
                {
                    Caption = 'Dimensions', Comment = 'FRA="Axes analytiques"';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ShowDimensions();
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments', Comment = 'FRA="Co&mmentaires"';
                    Image = ViewComments;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ShowLineComments();
                    end;
                }
            }
        }
    }

    var
        ShortcutDimCode: array[8] of Code[20];

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;
}

