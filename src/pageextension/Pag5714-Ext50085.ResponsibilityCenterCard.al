pageextension 50085 "BC6_ResponsibilityCenterCard" extends "Responsibility Center Card" //5714
{
    layout
    {
        addafter("Location Code")
        {
            field(BC6_Picture; "BC6_Picture")
            {
            }
        }
        addafter("Communication")
        {
            group("BC6_Alt Centre de Gestion")
            {
                Caption = 'Alt Centre de Gestion';
                field("BC6_Alt Name"; "BC6_Alt Name")
                {
                }
                field("BC6_Alt Name 2"; "BC6_Alt Name 2")
                {
                }
                field("BC6_Alt Address"; "BC6_Alt Address")
                {
                }
                field("BC6_Alt Address 2"; "BC6_Alt Address 2")
                {
                }
                field("BC6_Alt City"; "BC6_Alt City")
                {
                }
                field("BC6_Alt Phone No."; "BC6_Alt Phone No.")
                {
                }
                field("BC6_Alt Phone No. 2"; "BC6_Alt Phone No. 2")
                {
                }
                field("BC6_Alt Telex No."; "BC6_Alt Telex No.")
                {
                }
                field("BC6_Alt Fax No."; "BC6_Alt Fax No.")
                {
                }
                field("BC6_Alt Post Code"; "BC6_Alt Post Code")
                {
                }
                field("BC6_Alt E-Mail"; "BC6_Alt E-Mail")
                {
                }
                field("BC6_Alt Country Code"; "BC6_Alt Country Code")
                {
                }
                field("BC6_Alt Home Page"; "BC6_Alt Home Page")
                {
                }
                field("BC6_Alt Picture"; "BC6_Alt Picture")
                {
                }
            }
        }
    }

    var
        Picture2Exists: Boolean;
        PictureExists: Boolean;
        Text001: Label 'Do you want to replace the existing picture?', comment = 'FRA="Souhaitez-vous remplacer l''image existante ?"';
        Text002: Label 'Do you want to delete the picture?', comment = 'FRA="Souhaitez-vous supprimer l''image"';
}

