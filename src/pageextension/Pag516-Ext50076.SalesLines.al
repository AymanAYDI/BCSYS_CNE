pageextension 50076 "BC6_SalesLines" extends "Sales Lines" //516
{
    layout
    {
        modify(Reserve)
        {
            Visible = false;
        }
        modify("Reserved Qty. (Base)")
        {
            Visible = false;
        }
    }

    views
    {
        addfirst
        {
            view(AddFromVSC)
            {
                Caption = 'AddFrom Visual Studio Code';
                OrderBy = descending("Shipment Date", "Document Type", "Sell-to Customer No.", "Document No.", "Line No.");
            }
        }
    }

}

