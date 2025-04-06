page 50101 "PTE Office Allocation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "PTE Office Allocation Buffer";
    Caption = 'Office Allocation';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            group(Filter)
            {
                Caption = 'Filter of Office Allocation';
                field(Period; PeriodFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Period';
                    ToolTip = 'The period for which the office allocation is calculated.';
                    NotBlank = true;
                    trigger OnValidate()
                    begin
                        PeriodFilter := DMY2Date(1, Date2DMY(PeriodFilter, 2), Date2DMY(PeriodFilter, 3));
                    end;
                }
                field(Expense; Expense)
                {
                    ApplicationArea = All;
                    Caption = 'Expense';
                    ToolTip = 'The total expense for the office allocation.';
                    MinValue = 0;
                    AutoFormatType = 10;
                    AutoFormatExpression = '1,USD';
                }
            }
            repeater(Group)
            {
                Caption = 'Office Allocation';
                Editable = false;
                field(Office; Rec.Office)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    AutoFormatType = 10;
                    AutoFormatExpression = '1,USD';
                }
            }
        }
    }
    actions
    {
        area(Promoted)
        {
            actionref(Calucalte_Promoted; Calculate)
            {
            }
        }
        area(Processing)
        {
            action(Calculate)
            {
                ApplicationArea = All;
                Caption = 'Calculate';
                Image = Calculate;
                ToolTip = 'Calculate the office allocation.';
                trigger OnAction()
                var
                    OfficeAllocationMng: Codeunit "PTE Office Allocation Mng";
                begin
                    OfficeAllocationMng.AllocateOffices(Rec, PeriodFilter, Expense);
                    CurrPage.Update();
                end;
            }
        }
    }
    var
        PeriodFilter: Date;
        Expense: Decimal;
}