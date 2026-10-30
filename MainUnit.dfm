object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #1056#1072#1089#1095#1105#1090' '#1094#1077#1085' '#1089' '#1053#1044#1057' '#1080' '#1073#1077#1079' '#1053#1044#1057
  ClientHeight = 321
  ClientWidth = 489
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object LabelPrice: TLabel
    Left = 16
    Top = 16
    Width = 195
    Height = 15
    Caption = #1062#1077#1085#1072' '#1089' '#1053#1044#1057' ('#1086#1090' '#1074#1085#1077#1096#1085#1077#1081' '#1089#1080#1089#1090#1077#1084#1099'):'
  end
  object LabelVat: TLabel
    Left = 16
    Top = 72
    Width = 114
    Height = 15
    Caption = #1055#1088#1086#1094#1077#1085#1090' '#1053#1044#1057' (0..99):'
  end
  object LabelWith: TLabel
    Left = 16
    Top = 176
    Width = 180
    Height = 15
    Caption = #1057#1082#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1072#1085#1085#1072#1103' '#1094#1077#1085#1072' '#1089' '#1053#1044#1057':'
  end
  object LabelWithout: TLabel
    Left = 16
    Top = 232
    Width = 192
    Height = 15
    Caption = #1057#1082#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1072#1085#1085#1072#1103' '#1094#1077#1085#1072' '#1073#1077#1079' '#1053#1044#1057':'
  end
  object LabelInfo: TLabel
    Left = 16
    Top = 288
    Width = 456
    Height = 36
    AutoSize = False
    WordWrap = True
  end
  object EditPrice: TEdit
    Left = 8
    Top = 37
    Width = 448
    Height = 23
    TabOrder = 0
    Text = '100'
    OnKeyPress = EditPriceKeyPress
  end
  object EditNDS: TEdit
    Left = 16
    Top = 92
    Width = 120
    Height = 23
    TabOrder = 1
    Text = '20'
  end
  object ButtonCalc: TButton
    Left = 16
    Top = 132
    Width = 132
    Height = 30
    Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100
    Default = True
    TabOrder = 2
    OnClick = ButtonCalcClick
  end
  object EditWithNDS: TEdit
    Left = 16
    Top = 197
    Width = 456
    Height = 23
    ReadOnly = True
    TabOrder = 3
  end
  object EditWithoutNDS: TEdit
    Left = 16
    Top = 252
    Width = 456
    Height = 23
    ReadOnly = True
    TabOrder = 4
  end
end
