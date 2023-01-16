//TODO:Replaced by 670 // pageextension 50141 pageextension50141 extends "Session List"
// {
//     actions
//     {
//         addafter("Debug Next Session")
//         {
//             action("Kill ")
//             {
//                 Caption = 'Fermer la session'

//                 trigger OnAction()
//                 begin
//                     IF CONFIRM('Fermer la session') THEN STOPSESSION("Session ID")
//                 end;
//             }
//         }
//     }

//Unsupported feature: Code Insertion on "OnDeleteRecord".

//trigger OnDeleteRecord(): Boolean
//begin
/*
STOPSESSION("Session ID")
*/
//end;
//}
