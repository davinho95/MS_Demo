#region DOC
/*
Marley Spoon Task 11 - Dávid István, 2023-03-15
*/
#endregion DOC
codeunit 85000 "MS Sales Line Checker"
{
    procedure CheckLinesBeforePost(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        if not (SalesHeader."Document Type" in [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice]) then begin
            exit;
        end;

        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet() then begin
            repeat
                SalesLine.TestField("MS Checked", true);
            until SalesLine.Next() = 0;
        end;
    end;
}
