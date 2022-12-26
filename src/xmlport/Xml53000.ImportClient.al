xmlport 53000 "BC6_Import Client"
{
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;
    Caption = 'Import Client';

    schema
    {
        textelement(Root)
        {
            tableelement(Table18; Customer)
            {
                AutoSave = false;
                XmlName = 'Customer';
                textelement(Num)
                {
                }
                textelement(DateCreat)
                {
                }
                textelement(Collectif)
                {
                }
                textelement(CliFact)
                {
                }
                textelement(Nom)
                {
                }
                textelement(Nom2)
                {
                }
                textelement(Adr1)
                {
                }
                textelement(Adr2)
                {
                }
                textelement(Adr3)
                {
                }
                textelement(CP)
                {
                }
                textelement(Ville)
                {
                }
                textelement(Pays)
                {
                }
                textelement(Secteur)
                {
                }
                textelement(Tel)
                {
                }
                textelement(Fax)
                {
                }
                textelement(Telex)
                {
                }
                textelement(Intracom)
                {
                }
                textelement(Siren)
                {
                }
                textelement(Rglt)
                {
                }
                textelement(Liv)
                {
                }
                textelement(Devise)
                {
                }
                textelement(Credit)
                {
                }
                textelement(CodeVendeur)
                {
                }
                textelement(TVA)
                {
                }
                textelement(Langue)
                {
                }
                textelement(Tarif)
                {
                }
                textelement(NomContact)
                {
                }
                textelement(Commentaire)
                {
                }
                textelement(NbFacture)
                {
                }
                textelement(EditionRel)
                {
                }
                textelement(BLChiffre)
                {
                }

                trigger OnAfterInitRecord()
                begin

                    RecGCust.INIT;

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
                var
                    CPLength: Integer;
                    i: Integer;
                    PostCodeExist: Boolean;
                begin

                    RecGCust.VALIDATE("No.", Num);

                    RecGCust.INSERT(TRUE);

                    IF Collectif <> '' THEN
                        RecGCust.VALIDATE("Customer Posting Group", Collectif);

                    //IF CliFact <> '' THEN
                    //  RecGCust.VALIDATE("Bill-to Customer No.",CliFact);

                    RecGCust.VALIDATE(Name, Nom);
                    RecGCust.VALIDATE("Name 2", Nom2);
                    RecGCust.VALIDATE(Address, Adr1);
                    RecGCust.VALIDATE("Address 2", Adr2);
                    RecGCust.VALIDATE(County, Adr3);

                    IF (CP <> '') OR (Ville <> '') THEN BEGIN
                        //Code postal et Ville
                        IF STRLEN(CP) < 5 THEN BEGIN
                            CPLength := STRLEN(CP);
                            FOR i := 1 TO 5 - CPLength DO BEGIN
                                CP := '0' + CP;
                            END;
                        END;


                        PostCode.RESET;
                        PostCode.SETCURRENTKEY("Search City");
                        PostCode.SETRANGE("Search City", UPPERCASE(Ville));
                        PostCode.SETRANGE(Code, CP);
                        IF NOT (PostCode.FIND('-')) THEN BEGIN
                            PostCode.INIT;

                            PostCode.Code := CP;
                            PostCode.City := Ville;
                            PostCode."Search City" := Ville;

                            PostCode.VALIDATE(Code, CP);
                            PostCode.VALIDATE(City, Ville);
                            PostCode.INSERT(TRUE);
                        END;

                        RecGCust."Post Code" := CP;
                        RecGCust.City := Ville;
                    END;

                    //Pays
                    IF Pays <> '' THEN
                        RecGCust.VALIDATE("Country/Region Code", Pays);

                    //Secteur
                    IF NOT Territory.GET(Secteur) THEN BEGIN
                        Territory.INIT;
                        Territory.VALIDATE(Code, Secteur);
                        Territory.VALIDATE(Name, 'A completer');
                        Territory.INSERT(TRUE);
                    END;

                    IF Secteur <> '' THEN
                        RecGCust.VALIDATE("Territory Code", Secteur);

                    IF Tel <> '' THEN
                        RecGCust.VALIDATE("Phone No.", Tel);
                    IF Fax <> '' THEN
                        RecGCust.VALIDATE("Fax No.", Fax);
                    IF Telex <> '' THEN
                        RecGCust.VALIDATE("Telex No.", Telex);
                    IF Intracom <> '' THEN
                        RecGCust.VALIDATE("VAT Registration No.", Intracom);
                    IF Siren <> '' THEN
                        RecGCust.VALIDATE("BC6_Code SIREN", Siren);

                    //Mode règlement
                    IF Rglt <> '' THEN BEGIN
                        RecGCust.VALIDATE("Payment Terms Code", Rglt);
                        CASE UPPERCASE(COPYSTR(Rglt, 1, 1)) OF
                            'V':
                                RecGCust.VALIDATE("Payment Method Code", 'VIREMENT');
                            'D':
                                RecGCust.VALIDATE("Payment Method Code", 'TRAITE DIR');
                            'T':
                                RecGCust.VALIDATE("Payment Method Code", 'TRAITE');
                            'B':
                                RecGCust.VALIDATE("Payment Method Code", 'BOR');
                            ELSE
                                RecGCust.VALIDATE("Payment Method Code", 'CHEQUE');
                        END;
                    END;

                    //Condition Règlement
                    IF Liv <> '' THEN BEGIN
                        IF NOT ShipMethode.GET(Liv) THEN BEGIN
                            ShipMethode.INIT;
                            ShipMethode.VALIDATE(Code, Liv);
                            ShipMethode.VALIDATE(Description, 'A completer');
                            ShipMethode.INSERT(TRUE);
                        END;
                        RecGCust.VALIDATE("Shipment Method Code", Liv);
                    END;

                    //Devise
                    IF Devise = 'EUR' THEN
                        RecGCust.VALIDATE("Currency Code", '')
                    ELSE BEGIN
                        IF Devise <> '' THEN
                            RecGCust."Currency Code" := Devise;
                    END;

                    EVALUATE(RecGCust."Credit Limit (LCY)", Credit);
                    RecGCust.VALIDATE("Credit Limit (LCY)");

                    //Vendeur
                    IF CodeVendeur <> '' THEN BEGIN
                        CASE CodeVendeur OF
                        //--------------Alimenter table de correspondance Vendeur

                        END;
                        RecGCust.VALIDATE("Salesperson Code", CodeVendeur);
                    END;


                    //Groupe TVA
                    IF TVA = 'O' THEN BEGIN
                        RecGCust.VALIDATE("Gen. Bus. Posting Group", 'NATIONAL');
                    END
                    ELSE BEGIN
                        RecGCust.VALIDATE("Gen. Bus. Posting Group", 'EXPORT');
                    END;

                    //Langue
                    IF Langue <> '' THEN BEGIN
                        IF NOT Language.GET(Langue) THEN BEGIN
                            Language.INIT;
                            Language.VALIDATE(Code, Langue);
                            Language.VALIDATE(Name, 'A completer');
                            Language.INSERT(TRUE);
                        END;
                        RecGCust.VALIDATE("Language Code", Langue);
                    END;

                    //Groupe Remise
                    IF Tarif <> '' THEN BEGIN
                        IF NOT GpRemise.GET(Tarif) THEN BEGIN
                            GpRemise.VALIDATE(Code, Tarif);
                            GpRemise.VALIDATE(Description, 'A completer');
                            GpRemise.INSERT(TRUE);
                        END;
                        RecGCust.VALIDATE("Customer Disc. Group", Tarif);
                    END;


                    /*
                    RecGCust."Allow Line Disc." := Defaut."Allow Line Disc.";
                    RecGCust."Application Method" := Defaut."Application Method Customer";
                    RecGCust."Print Statements" := Defaut."Print Statements";
                    RecGCust."Combine Shipments" := Defaut."Combine Shipments";
                    RecGCust.Reserve := Defaut."Reserve Customer";
                    RecGCust."Shipping Advice" := Defaut."Shipping Advice";
                    RecGCust."Invoice Copies" := Defaut."Invoice Copies";
                    RecGCust."Shipping Time" := Defaut."Shipping Time";
                    
                    RecGCust.INSERT;
                    */

                    //Contact
                    RecGCust.VALIDATE(Contact, COPYSTR(NomContact, 1, 30));

                    // Commentaires
                    IF Commentaire <> '' THEN BEGIN
                        Commentaires.INIT;
                        Commentaires.VALIDATE("Table Name", Commentaires."Table Name"::Customer);
                        Commentaires.VALIDATE("No.", Num);
                        Commentaires.VALIDATE("Line No.", 10000);
                        Commentaires.VALIDATE(Date, WORKDATE);
                        Commentaires.VALIDATE(Comment, Commentaire);
                        Commentaires.INSERT(TRUE);
                    END;

                    EVALUATE(RecGCust."BC6_Creation Date", DateCreat);

                    IF NbFacture <> '' THEN BEGIN
                        EVALUATE(RecGCust."Invoice Copies", NbFacture);
                        RecGCust.VALIDATE("Invoice Copies", RecGCust."Invoice Copies" - 1);
                    END;

                    EVALUATE(RecGCust."Print Statements", EditionRel);
                    RecGCust.VALIDATE("Print Statements");

                    EVALUATE(RecGCust."BC6_Valued Shipment", EditionRel);
                    RecGCust.VALIDATE("Print Statements");
                    RecGCust.VALIDATE("Location Code", 'CNE');

                    RecGCust.MODIFY(TRUE);

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
        RecGCust: Record Customer;
        PostCode: Record "Post Code";
        Territory: Record Territory;
        ShipMethode: Record "Shipment Method";
        Contact: Record Contact;
        Language: Record Language;
        Currency: Record Currency;
        GpCptaMarche: Record "Gen. Business Posting Group";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        Vendeur: Record "Salesperson/Purchaser";
        Commentaires: Record "Comment Line";
        Defaut: Record "BC6_Navi+ Setup";
        GpRemise: Record "Customer Discount Group";
}

