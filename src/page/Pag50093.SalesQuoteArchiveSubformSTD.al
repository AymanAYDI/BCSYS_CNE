page 50093 "Sales Quote Archive SubformSTD"
{
    Caption = 'Lines', Comment = 'FRA="Lignes"';
    Editable = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Sales Line Archive";
    SourceTableView = WHERE("Document Type" = CONST(Quote));
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Substitution Available"; Rec."Substitution Available")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Item Disc. Group"; Rec."BC6_Item Disc. Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Dispensation No."; Rec."BC6_Dispensation No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Additional Discount %"; Rec."BC6_Additional Discount %")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Dispensed Purchase Cost"; Rec."BC6_Dispensed Purchase Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Standard Net Price"; Rec."BC6_Standard Net Price")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Purchase Cost"; Rec."BC6_Purchase Cost")
                {
                    ApplicationArea = All;
                }
                field("Public Price"; Rec."BC6_Public Price")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Discount Unit Price"; Rec."BC6_Discount Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Profit %"; Rec."Profit %")
                {
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                    ApplicationArea = All;
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
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
                field("DEEE Unit Price"; Rec."BC6_DEEE Unit Price")
                {
                    ApplicationArea = All;
                }
                field("DEEE HT Amount"; Rec."BC6_DEEE HT Amount")
                {
                    ApplicationArea = All;
                }
                field("DEEE Unit Price (LCY)"; Rec."BC6_DEEE Unit Price (LCY)")
                {
                    ApplicationArea = All;
                }
                field("DEEE VAT Amount"; Rec."BC6_DEEE VAT Amount")
                {
                    ApplicationArea = All;
                }
                field("DEEE TTC Amount"; Rec."BC6_DEEE TTC Amount")
                {
                    ApplicationArea = All;
                }
                field("DEEE HT Amount (LCY)"; Rec."BC6_DEEE HT Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Eco partner DEEE"; Rec."BC6_Eco partner DEEE")
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
                        Rec.ShowDimensions();
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments', Comment = 'FRA="Co&mmentaires"';
                    Image = ViewComments;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowLineComments();
                    end;
                }
            }
        }
    }

    var
        ShortcutDimCode: array[8] of Code[20];

    procedure ShowShortcutDimCode(var ShortcuttDimCode: array[8] of Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcuttDimCode);
    end;
}

