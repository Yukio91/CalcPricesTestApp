program CalcPricesApp;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  PriceCalc in 'PriceCalc.pas';

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
