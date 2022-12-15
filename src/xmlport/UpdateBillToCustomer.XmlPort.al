xmlport 53004 "Update Bill-To-Customer"
{
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table18; Table18)
            {
                AutoSave = false;
                XmlName = 'Customer';
                textelement(num)
                {
                    XmlName = 'Num';
                }
                textelement(datecreat)
                {
                    XmlName = 'DateCreat';
                }
                textelement(collectif)
                {
                    XmlName = 'Collectif';
                }
                textelement(clifact)
                {
                    XmlName = 'CliFact';
                }
                textelement(nom)
                {
                    XmlName = 'Nom';
                }
                textelement(nom2)
                {
                    XmlName = 'Nom2';
                }
                textelement(adr1)
                {
                    XmlName = 'Adr1';
                }
                textelement(adr2)
                {
                    XmlName = 'Adr2';
                }
                textelement(adr3)
                {
                    XmlName = 'Adr3';
                }
                textelement(cp)
                {
                    XmlName = 'CP';
                }
                textelement(ville)
                {
                    XmlName = 'Ville';
                }
                textelement(pays)
                {
                    XmlName = 'Pays';
                }
                textelement(secteur)
                {
                    XmlName = 'Secteur';
                }
                textelement(tel)
                {
                    XmlName = 'Tel';
                }
                textelement(fax)
                {
                    XmlName = 'Fax';
                }
                textelement(telex)
                {
                    XmlName = 'Telex';
                }
                textelement(intracom)
                {
                    XmlName = 'Intracom';
                }
                textelement(siren)
                {
                    XmlName = 'Siren';
                }
                textelement(rglt)
                {
                    XmlName = 'Rglt';
                }
                textelement(liv)
                {
                    XmlName = 'Liv';
                }
                textelement(devise)
                {
                    XmlName = 'Devise';
                }
                textelement(credit)
                {
                    XmlName = 'Credit';
                }
                textelement(codevendeur)
                {
                    XmlName = 'CodeVendeur';
                }
                textelement(tva)
                {
                    XmlName = 'TVA';
                }
                textelement(langue)
                {
                    XmlName = 'Langue';
                }
                textelement(tarif)
                {
                    XmlName = 'Tarif';
                }
                textelement(nomcontact)
                {
                    XmlName = 'NomContact';
                }
                textelement(commentaire)
                {
                    XmlName = 'Commentaire';
                }
                textelement(nbfacture)
                {
                    XmlName = 'NbFacture';
                }
                textelement(editionrel)
                {
                    XmlName = 'EditionRel';
                }
                textelement(blchiffre)
                {
                    XmlName = 'BLChiffre';
                }

                trigger OnAfterInitRecord()
                begin

                    Num := '';
                    DateCreat := '';
                    Collectif := '';
                    CliFact := '';
                    Nom := '';
                    Nom2 := '';
                    Adr1 := '';
                    Adr2 := '';
                    Adr3 := '';
                    CP := '';
                    Ville := '';
                    Pays := '';
                    Secteur := '';
                    Tel := '';
                    Fax := '';
                    Telex := '';
                    Intracom := '';
                    Siren := '';
                    Rglt := '';
                    Liv := '';
                    Devise := '';
                    Credit := '';
                    CodeVendeur := '';
                    TVA := '';
                    Langue := '';
                    Tarif := '';
                    NomContact := '';
                    Commentaire := '';
                    NbFacture := '';
                    EditionRel := '';
                    BLChiffre := '';
                end;

                trigger OnBeforeInsertRecord()
                begin

                    IF (CliFact <> '') AND (CliFact <> Num) THEN BEGIN
                        IF RecGCust.GET(Num) THEN BEGIN
                            RecGCust.VALIDATE("Bill-to Customer No.", CliFact);
                            RecGCust.MODIFY(TRUE);
                        END;
                    END;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    var
        "------------- Tables ---------": Integer;
        RecGCust: Record "18";
        PostCode: Record "225";
        Territory: Record "286";
        ShipMethode: Record "10";
        Contact: Record "5050";
        Language: Record "8";
        Currency: Record "4";
        GpCptaMarche: Record "250";
        PaymentTerms: Record "3";
        PaymentMethod: Record "289";
        Vendeur: Record "13";
        Commentaires: Record "97";
        Defaut: Record "50004";
        GpRemise: Record "340";
}

