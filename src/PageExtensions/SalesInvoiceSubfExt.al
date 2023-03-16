#region DOC
/*
Marley Spoon Task 11 - Dávid István, 2023-03-15
*/
#endregion DOC
pageextension 85001 "MS Sales Invoice Subf. Ext." extends "Sales Invoice Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("MS Checked"; Rec."MS Checked")
            {
                ApplicationArea = All;
            }
        }
    }
}
