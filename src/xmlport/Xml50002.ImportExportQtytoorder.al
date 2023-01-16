xmlport 50002 "BC6_Import/Export Qty to order"
{
    Caption = 'Import/Export Qty to order';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(salesline; "Sales Line")
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
                fieldelement(QtyToOrder; SalesLine."BC6_Qty. To Order")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SalesLine."BC6_Qty. To Order" := 0;
                    SalesLine.MODIFY();
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
