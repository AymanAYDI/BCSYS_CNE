xmlport 50002 "Import/Export Qty to order"
{
    // ------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // ------------------------------------------------------------------------
    // //>>MIGRATION NAV 2013
    // 
    // //>>CNE1.03
    //    SOBI:correction des anomalies 24/04/08 : - export qty to order for change from integer to decimal
    // 
    // ------------------------------------------------------------------------

    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(salesline; Table37)
            {
                XmlName = 'SalesLine';
                fieldelement(DocumentType; SalesLine."Document Type")
                {
                }
                fieldelement(DocumentNo; SalesLine."Document No.")
                {
                }
                fieldelement(LineNo; SalesLine."Line No.")
                {
                }
                fieldelement(QtyToOrder; SalesLine."Qty. To Order")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SalesLine."Qty. To Order" := 0;
                    SalesLine.MODIFY;
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
}

