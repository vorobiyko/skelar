page 50100 "PTE Headcount"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "PTE Headcount";
    Caption = 'Headcount';
    
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                }
                field(Office; Rec.Office)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Count; Rec.Count)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}