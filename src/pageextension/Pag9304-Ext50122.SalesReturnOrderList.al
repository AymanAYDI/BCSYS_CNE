pageextension 50122 "BC6_SalesReturnOrderList" extends "Sales Return Order List" //9304
{
    //Unsupported feature: Property Insertion (InsertAllowed) on ""Sales Return Order List"(Page 9304)". TODO:
    //Unsupported feature: Property Insertion (DelayedInsert) on ""Sales Return Order List"(Page 9304)". TODO:

    layout
    {

        addafter("Job Queue Status")
        {
            field(BC6_ID; Rec.ID)
            {
                ApplicationArea = All;
            }
            field("BC6_Your Reference"; "Your Reference")
            {
                ApplicationArea = All;
            }
            field("BC6_Affair No."; "BC6_Affair No.")
            {
                ApplicationArea = All;
            }
            field(BC6_Amount; Amount)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("Create Inventor&y Put-away/Pick")
        {
            Visible = false;

        }
        addfirst(Action8)
        {
            action("BC6_Create Inventor&y Put-away/Pick2")
            {
                AccessByPermission = TableData "Posted Invt. Pick Header" = R;
                ApplicationArea = Warehouse;
                Caption = 'Create Inventor&y Put-away/Pick', Comment = 'FRA="Créer prélèv./rangement stoc&k"';
                Ellipsis = true;
                Image = CreateInventoryPickup;
                ToolTip = 'Create an inventory put-away or inventory pick to handle items on the document according to a basic warehouse configuration that does not require warehouse receipt or shipment documents.';
                trigger OnAction()
                var
                    FunctionMgt: Codeunit "BC6_Functions Mgt";

                begin
                    FunctionMgt.BC6_CreateInvtPutAwayPick_Sales(rec);
                end;
            }
        }

    }

    var
        RecGUserSeup: Record "User Setup";

    trigger OnOpenPage()
    begin

        IF NOT RecGUserSeup.GET(USERID) THEN
            RecGUserSeup.INIT();
        IF RecGUserSeup."BC6_Limited User" THEN BEGIN
            FILTERGROUP(2);
            SETFILTER("BC6_Salesperson Filter", '*' + RecGUserSeup."Salespers./Purch. Code" + '*');
            FILTERGROUP(0);
        END;
    end;
}

