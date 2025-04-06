codeunit 50100 "PTE Office Allocation Mng"
{
    internal procedure AllocateOffices(var OfficeAllocationBuffer: Record "PTE Office Allocation Buffer"; PeriodFilter: Date; Amount: Decimal)
    var
        Headcount: Record "PTE Headcount";
        OfficeFilter: Text;
        TotalCount: Integer;
    begin
        OfficeAllocationBuffer.DeleteAll();// buufer is temporary, so no need to delete (but point from TDD)
        ValidateBeforeCalculate(PeriodFilter, Amount);
        Headcount.SetRange(Period, PeriodFilter);
        Headcount.SetRange(Type, Headcount.Type::Core);
        Headcount.CalcSums(Count);
        TotalCount := Headcount.Count;
        if Headcount.FindSet() then
            repeat
                OfficeAllocationBuffer.Init();
                OfficeAllocationBuffer.Amount := Headcount.Count / TotalCount * Amount;
                OfficeAllocationBuffer.Office := Headcount.Office;
                OfficeAllocationBuffer."Entry No." += 1;
                OfficeAllocationBuffer.Insert();
                OfficeFilter := Headcount.GetFilter(Office);
                if OfficeFilter = '' then
                    OfficeFilter := '<>' + Headcount.Office
                else
                    OfficeFilter := OfficeFilter + '|<>' + Headcount.Office;
                Headcount.SetFilter(Office, OfficeFilter);
            until Headcount.Next() = 0;
    end;

    local procedure ValidateBeforeCalculate(PeriodFilter: Date; Amount: Decimal)
    var
        Headcount: Record "PTE Headcount";
    begin
        if Amount <= 0 then
            Error('');
        Headcount.SetRange(Period, PeriodFilter);
        Headcount.SetRange(Type, Headcount.Type::Core);
        if Headcount.IsEmpty then
            Error(HeadcountEmptyErr, PeriodFilter);
    end;

    var
        HeadcountEmptyErr: Label 'No headcount records found for the specified period %1.', Comment = '#1 - PTE Headcount.Period';
}  