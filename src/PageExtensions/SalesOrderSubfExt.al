#region DOC
/*
Marley Spoon Task 11 - Dávid István, 2023-03-15
*/
#endregion DOC
pageextension 85000 "MS Sales Order Subf. Ext." extends "Sales Order Subform"
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
