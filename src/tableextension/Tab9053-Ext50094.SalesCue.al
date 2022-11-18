tableextension 50094 "BC6_SalesCue" extends "Sales Cue" //9053
{
    fields
    {
        field(50000; "BC6_Salesperson Filter"; Text[250])
        {
            Caption = 'Responsibility Center Filter', Comment = 'FRA="Responsibility Center Filter"';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(50001; "BC6_Sales Quotes Salesperson-Open"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Quote),
                                                      Status = FILTER(Open),
                                                      "Responsibility Center" = FIELD("Responsibility Center Filter"),
                                                      "BC6_Salesperson Filter" = FIELD("BC6_Salesperson Filter")));
            Caption = 'Sales Quotes - Open', Comment = 'FRA="Devis - Ouverts"';
            Editable = false;
        }
        field(50002; "BC6_Sales Orders Salesperson- Open"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Order),
                                                      Status = FILTER(Open),
                                                      "Responsibility Center" = FIELD("Responsibility Center Filter"),
                                                      "BC6_Salesperson Filter" = FIELD("BC6_Salesperson Filter")));
            Caption = 'Sales Orders - Open', Comment = 'FRA="Commandes vente - Ouvertes"';
            Editable = false;
        }
        field(50003; "BC6_Ready to Ship Salesperson"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Order),
                                                      Status = FILTER(Released),
                                                      Ship = FILTER(false),
                                                      "Shipment Date" = FIELD("Date Filter2"),
                                                      "Responsibility Center" = FIELD("Responsibility Center Filter"),
                                                      "BC6_Salesperson Filter" = FIELD("BC6_Salesperson Filter")));
            Caption = 'Ready to Ship', Comment = 'FRA="Prêt pour expédition"';
            Editable = false;
        }
        field(50004; "BC6_Delayed Salesperson"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Order),
                                                      Status = FILTER(Released),
                                                      "Shipment Date" = FIELD("Date Filter"),
                                                      "Responsibility Center" = FIELD("Responsibility Center Filter"),
                                                      "BC6_Salesperson Filter" = FIELD("BC6_Salesperson Filter")));
            Caption = 'Delayed', Comment = 'FRA="En retard"';
            Editable = false;
        }
        field(50005; "BC6_Sales Return Orders Salesperso"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER("Return Order"),
                                                      Status = FILTER(Open),
                                                      "Responsibility Center" = FIELD("Responsibility Center Filter"),
                                                      "BC6_Salesperson Filter" = FIELD("BC6_Salesperson Filter")));
            Caption = 'Sales Return Orders - All', Comment = 'FRA="Retours vente - Tous"';
            Editable = false;
        }
        field(50007; "BC6_Partially Shipped Salesperson"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Order),
                                                      Status = FILTER(Released),
                                                      Ship = FILTER(true),
                                                      "Completely Shipped" = FILTER(false),
                                                      "Shipment Date" = FIELD("Date Filter2"),
                                                      "Responsibility Center" = FIELD("Responsibility Center Filter"),
                                                      "BC6_Salesperson Filter" = FIELD("BC6_Salesperson Filter")));
            Caption = 'Partially Shipped', Comment = 'FRA="Partiellement livré"';
            Editable = false;
        }
        field(50008; "BC6_Sales Return - Location"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER("Return Order"),
                                                      "BC6_Return Order Type" = FILTER(Location),
                                                      Status = FILTER(Open),
                                                      "Responsibility Center" = FIELD("Responsibility Center Filter")));
            Caption = 'Retours vente - Magasin', Comment = 'FRA="Retours vente - Magasin"';
            Editable = false;
        }
        field(50009; "BC6_Sales Return - SAV"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER("Return Order"),
                                                      "BC6_Return Order Type" = FILTER(SAV),
                                                      Status = FILTER(Open),
                                                      "Responsibility Center" = FIELD("Responsibility Center Filter")));
            Caption = 'Retours vente - SAV', Comment = 'FRA="Retours vente - SAV"';
            Editable = false;
        }
    }
}
