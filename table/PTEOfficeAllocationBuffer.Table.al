table 50101 "PTE Office Allocation Buffer"
{
    TableType = Temporary;
    Caption = 'Office Allocation';
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; Office; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Location".Code;
            Caption = 'Office';
            ToolTip = 'The office for which the allocation is calculated.';
        }
        field(3; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
            ToolTip = 'The amount allocated to the office.';
        }
    }
    
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
}