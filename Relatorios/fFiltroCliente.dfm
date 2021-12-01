object frmFiltroCliente: TfrmFiltroCliente
  Left = 0
  Top = 0
  Caption = 'Filtragem do Relat'#243'rio'
  ClientHeight = 307
  ClientWidth = 398
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
  object Panel1: TPanel
    Left = 0
    Top = 40
    Width = 398
    Height = 227
    Align = alClient
    TabOrder = 0
    object cbxListaTodos: TCheckBox
      Left = 16
      Top = 6
      Width = 161
      Height = 17
      Caption = 'Listar todos Clientes'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = cbxListaTodosClick
      OnEnter = cbxListaTodosEnter
    end
    object rdgFiltro: TRadioGroup
      Left = 16
      Top = 38
      Width = 161
      Height = 129
      Caption = 'Ordenar por:'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      Items.Strings = (
        'C'#243'digo'
        'Nome'
        'Tipo de Cadastro')
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 2
    end
    object edtBusca: TEdit
      Left = 202
      Top = 6
      Width = 153
      Height = 26
      CharCase = ecUpperCase
      Enabled = False
      TabOrder = 1
    end
    object rdgBusca: TRadioGroup
      Left = 202
      Top = 38
      Width = 153
      Height = 129
      Caption = 'Buscar por:'
      Color = clBtnFace
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      Items.Strings = (
        'C'#243'digo'
        'Nome'
        'Tipo de Cadastro'
        'E-Mail'
        'Cidade')
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 3
      OnClick = rdgBuscaClick
    end
    object RadioGroup1: TRadioGroup
      Left = 16
      Top = 190
      Width = 161
      Height = 129
      Caption = 'Buscar por:'
      Color = clBtnFace
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      Items.Strings = (
        'TODOS'
        'Pessoa F'#237'sica '#11
        'Pessoa Jur'#237'dica')
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 4
      Visible = False
      OnClick = rdgBuscaClick
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 267
    Width = 398
    Height = 40
    Align = alBottom
    Color = clTeal
    ParentBackground = False
    TabOrder = 1
    object btnVisualizar: TButton
      Left = 1
      Top = 1
      Width = 81
      Height = 38
      Align = alLeft
      Caption = 'Visualizar'
      TabOrder = 0
      OnClick = btnVisualizarClick
    end
    object btnLimpar: TButton
      Left = 297
      Top = 1
      Width = 100
      Height = 38
      Align = alRight
      Caption = 'Limpar Filtro'
      TabOrder = 1
      OnClick = btnLimparClick
    end
  end
  object pnlTitulo: TPanel
    Left = 0
    Top = 0
    Width = 398
    Height = 40
    Align = alTop
    Color = clTeal
    ParentBackground = False
    TabOrder = 2
  end
end
