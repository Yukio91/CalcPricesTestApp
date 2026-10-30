unit PriceCalc;

interface

type
  TProcNDS = 0..99;

procedure CalcPrices(InputPriceWithNDS: double; ProcNDS: TProcNDS;
  out CorrectedPriceWithNDS, CorrectedPriceWithoutNDS: double);

implementation

uses
  System.SysUtils, System.Math;

function FindGreatestCommonDivisor(FirstValue, SecondValue: Int64): Int64;
var
  Remainder: Int64;
begin
  while SecondValue <> 0 do
  begin
    Remainder := FirstValue mod SecondValue;
    FirstValue := SecondValue;
    SecondValue := Remainder;
  end;
  Result := FirstValue;
end;

procedure CalcPrices(InputPriceWithNDS: double; ProcNDS: TProcNDS;
  out CorrectedPriceWithNDS, CorrectedPriceWithoutNDS: double);
var
  NdsCommonDivisor: Int64;
  StepWithNdsInCents: Int64;
  StepWithoutNdsInCents: Int64;
  StepIndex: Int64;
  InputPriceInCents: Extended;
  ExactStepCount: Extended;
  DistanceToFloorStep: Extended;
  DistanceToCeilStep: Extended;
begin
  if IsNaN(InputPriceWithNDS) or IsInfinite(InputPriceWithNDS) or
     (Abs(InputPriceWithNDS) > 1e13) then
    raise ERangeError.Create('Input price is out of supported range');

  NdsCommonDivisor := FindGreatestCommonDivisor(100, ProcNDS);
  StepWithNdsInCents := (100 + ProcNDS) div NdsCommonDivisor;
  StepWithoutNdsInCents := 100 div NdsCommonDivisor;

  InputPriceInCents := InputPriceWithNDS * 100;
  ExactStepCount := InputPriceInCents / StepWithNdsInCents;
  StepIndex := Trunc(ExactStepCount);

  if ExactStepCount < StepIndex then
    Dec(StepIndex);

  DistanceToFloorStep := InputPriceInCents - StepIndex * StepWithNdsInCents;
  DistanceToCeilStep := (StepIndex + 1) * StepWithNdsInCents - InputPriceInCents;

  if DistanceToCeilStep <= DistanceToFloorStep then
    Inc(StepIndex);

  CorrectedPriceWithNDS := (StepIndex * StepWithNdsInCents) / 100;
  CorrectedPriceWithoutNDS := (StepIndex * StepWithoutNdsInCents) / 100;
end;

end.
