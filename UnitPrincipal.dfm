object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 277
  ClientWidth = 597
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 208
    Top = 14
    Width = 121
    Height = 25
    Caption = 'Gerar Arquivo'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object ComboBox1: TComboBox
    Left = 32
    Top = 16
    Width = 145
    Height = 21
    ItemIndex = 0
    TabOrder = 1
    Text = 'Vers'#227'o 01.01'
    Items.Strings = (
      'Vers'#227'o 01.01'
      'Vers'#227'o 01.02'
      'Vers'#227'o 01.03'
      'Vers'#227'o 01.04'
      'Vers'#227'o 01.05')
  end
  object Memo1: TMemo
    Left = 32
    Top = 64
    Width = 537
    Height = 193
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
end
