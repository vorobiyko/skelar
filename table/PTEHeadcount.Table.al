table 50100 "PTE Headcount"
{
    DataClassification = CustomerContent;
    Caption = 'Headcount';
    
    fields
    {
        field(1; Period; Date)
        {
            Caption = 'Period';
            ToolTip = 'The period for which the headcount is calculated.';
            NotBlank = true;
            trigger OnValidate()
            begin
                Rec.Period := DMY2Date(1, Date2DMY(Rec.Period, 2), Date2DMY(Rec.Period, 3));
            end;
        }
        field(2; Office; Code[10])
        {
            Caption = 'Office';
            ToolTip = 'The office for which the headcount is calculated.';
            TableRelation = "Location".Code;
            NotBlank = true;
        }
        field(4; Type; Enum "PTE Headcount Type")
        {
            Caption = 'Type';
            ToolTip = 'The type of headcount.';
        }
        field(5; Count; Integer)
        {
            Caption = 'Count';
            ToolTip = 'The number of employees in the headcount.';
            MinValue = 0;
        }
    }
    
    keys
    {
        key(Key1; Period, Office, Type)
        {
            Clustered = true;
        }
    }
}