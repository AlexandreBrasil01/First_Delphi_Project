object frmFiltroDefault: TfrmFiltroDefault
  Left = 0
  Top = 0
  Caption = 'frmFiltroDefault'
  ClientHeight = 286
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyPress = FormKeyPress
  PixelsPerInch = 115
  TextHeight = 18
  object pnlTitulo: TPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 40
    Align = alTop
    Color = clTeal
    ParentBackground = False
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 40
    Width = 400
    Height = 206
    Align = alClient
    ParentBackground = False
    TabOrder = 1
    object cbxListaTodos: TCheckBox
      Left = 16
      Top = 6
      Width = 97
      Height = 17
      Caption = 'Lista todos'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 246
    Width = 400
    Height = 40
    Align = alBottom
    Color = clTeal
    ParentBackground = False
    TabOrder = 2
    object btnVisualizar: TButton
      Left = 1
      Top = 1
      Width = 81
      Height = 38
      Align = alLeft
      Caption = 'Visualizar'
      TabOrder = 0
    end
    object btnLimpar: TButton
      Left = 299
      Top = 1
      Width = 100
      Height = 38
      Align = alRight
      Caption = 'Limpar Filtro'
      TabOrder = 1
    end
  end
end
