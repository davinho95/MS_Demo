#region DGO
/*
Marley Spoon Task 11 - Dávid István, 2023-03-15
*/
#endregion DGO
codeunit 85300 "MS Sales-Post Handler"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDocSub(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean)
    var
        SalesLineChecker: Codeunit "MS Sales Line Checker";
    begin
        SalesLineChecker.CheckLinesBeforePost(SalesHeader);
    end;
}
