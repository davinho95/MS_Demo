#region DOC
/*
Marley Spoon Task 11 - Dávid István, 2023-03-15
*/
#endregion DOC
tableextension 85000 "MS Sales Line Ext." extends "Sales Line"
{
    fields
    {
        field(85000; "MS Checked"; Boolean)
        {
            Caption = 'Checked';
            DataClassification = CustomerContent;
        }
    }
}
