pageextension 50087 pageextension50087 extends "Responsibility Center Card"
{
    layout
    {
        addafter("Control 16")
        {
            field(Picture; Picture)
            {
            }
        }
        addafter("Control 1902768601")
        {
            group("Alt Centre de Gestion")
            {
                Caption = 'Alt Centre de Gestion';
                field("Alt Name"; "Alt Name")
                {
                }
                field("Alt Name 2"; "Alt Name 2")
                {
                }
                field("Alt Address"; "Alt Address")
                {
                }
                field("Alt Address 2"; "Alt Address 2")
                {
                }
                field("Alt City"; "Alt City")
                {
                }
                field("Alt Phone No."; "Alt Phone No.")
                {
                }
                field("Alt Phone No. 2"; "Alt Phone No. 2")
                {
                }
                field("Alt Telex No."; "Alt Telex No.")
                {
                }
                field("Alt Fax No."; "Alt Fax No.")
                {
                }
                field("Alt Post Code"; "Alt Post Code")
                {
                }
                field("Alt E-Mail"; "Alt E-Mail")
                {
                }
                field("Alt Country Code"; "Alt Country Code")
                {
                }
                field("Alt Home Page"; "Alt Home Page")
                {
                }
                field("Alt Picture"; "Alt Picture")
                {
                }
            }
        }
    }

    var
        PictureExists: Boolean;
        Picture2Exists: Boolean;
        Text001: Label 'Do you want to replace the existing picture?';
        Text002: Label 'Do you want to delete the picture?';
}

