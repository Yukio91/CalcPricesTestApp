unit MainUnit;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    LabelPrice: TLabel;
    EditPrice: TEdit;
    LabelVat: TLabel;
    EditNDS: TEdit;
    ButtonCalc: TButton;
    LabelWith: TLabel;
    EditWithNDS: TEdit;
    LabelWithout: TLabel;
    EditWithoutNDS: TEdit;
    LabelInfo: TLabel;
    procedure ButtonCalcClick(Sender: TObject);
    procedure EditPriceKeyPress(Sender: TObject; var Key: Char);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  PriceCalc;

procedure TMainForm.ButtonCalcClick(Sender: TObject);
var
  FormatSettings: TFormatSettings;
  InputPrice: Double;
  CorrectedPriceWithNds: Double;
  CorrectedPriceWithoutNds: Double;
  NdsPercentage: Integer;

  InputPriceText: string;
  SeparatorPos: Integer;
begin
  FormatSettings := TFormatSettings.Create;
  FormatSettings.DecimalSeparator := '.';

  EditWithNDS.Clear;
  EditWithoutNDS.Clear;
  LabelInfo.Caption := '';

  InputPriceText := StringReplace(Trim(EditPrice.Text), ',', '.', [rfReplaceAll]);

  SeparatorPos := Pos('.', InputPriceText);
  if (SeparatorPos > 0) and ((Length(InputPriceText) - SeparatorPos) > 20) then
  begin
    LabelInfo.Caption := 'Цена: допускается не более 20 знаков после запятой';
    EditPrice.SetFocus;
    Exit;
  end;

  if not TryStrToFloat(InputPriceText, InputPrice, FormatSettings) then
  begin
    LabelInfo.Caption := 'Цена: введите число, например 100.55';
    EditPrice.SetFocus;
    Exit;
  end;

  if not TryStrToInt(Trim(EditNDS.Text), NdsPercentage) or (NdsPercentage < 0) or (NdsPercentage > 99) then
  begin
    LabelInfo.Caption := 'Процент НДС: введите целое число от 0 до 99';
    EditNDS.SetFocus;
    Exit;
  end;

  try
    CalcPrices(InputPrice, NdsPercentage, CorrectedPriceWithNds, CorrectedPriceWithoutNds);
  except
    on E: Exception do
    begin
      LabelInfo.Caption := 'Ошибка: ' + E.Message;
      Exit;
    end;
  end;

  EditWithNDS.Text := FloatToStrF(CorrectedPriceWithNds, ffFixed, 18, 2, FormatSettings);
  EditWithoutNDS.Text := FloatToStrF(CorrectedPriceWithoutNds, ffFixed, 18, 2, FormatSettings);

  LabelInfo.Caption :=
    'Проверка: ' + EditWithoutNDS.Text + ' * (1 + ' + IntToStr(NdsPercentage) + '/100) = ' +
    FloatToStrF(CorrectedPriceWithoutNds * (1 + NdsPercentage / 100), ffFixed, 18, 4, FormatSettings) + sLineBreak +
    'Отклонение от входной цены: ' + FloatToStrF(CorrectedPriceWithNds - InputPrice, ffFixed, 18, 6, FormatSettings);
end;

procedure TMainForm.EditPriceKeyPress(Sender: TObject; var Key: Char);
var
  CurrentText: string;
begin
  if Key < #32 then
    Exit;

  CurrentText := TEdit(Sender).Text;

  if not CharInSet(Key, ['0'..'9', '.', ',']) then
  begin
    Key := #0;
    Exit;
  end;

  if (Key = '.') or (Key = ',') then
  begin
    if (Pos('.', CurrentText) > 0) or (Pos(',', CurrentText) > 0) then
    begin
      Key := #0;
      Exit;
    end;
  end;
end;

end.
