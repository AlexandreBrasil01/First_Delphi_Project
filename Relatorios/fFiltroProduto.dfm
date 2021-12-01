inherited frmFiltroProduto: TfrmFiltroProduto
  Caption = 'frmFiltroProduto'
  ClientHeight = 262
  ClientWidth = 541
  ExplicitWidth = 559
  ExplicitHeight = 307
  PixelsPerInch = 115
  TextHeight = 18
  inherited pnlTitulo: TPanel
    Width = 541
    ExplicitWidth = 541
  end
  inherited Panel2: TPanel
    Width = 541
    Height = 182
    ExplicitWidth = 541
    ExplicitHeight = 182
    inherited cbxListaTodos: TCheckBox
      Width = 169
      Caption = 'Lista todos Produtos'
      OnClick = cbxListaTodosClick
      OnEnter = cbxListaTodosEnter
      ExplicitWidth = 169
    end
    object rdgFiltro: TRadioGroup
      Left = 16
      Top = 44
      Width = 169
      Height = 105
      Caption = 'Ordenar por:'
      Items.Strings = (
        'C'#243'digo'
        'Nome'
        'Unidade de Medida')
      TabOrder = 1
    end
    object Panel4: TPanel
      Left = 216
      Top = 31
      Width = 305
      Height = 130
      Color = clTeal
      ParentBackground = False
      TabOrder = 2
      object lblMenValor: TLabel
        Left = 166
        Top = 13
        Width = 88
        Height = 18
        Caption = 'Menor Valor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblMaiValor: TLabel
        Left = 166
        Top = 69
        Width = 84
        Height = 18
        Caption = 'Maior Valor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rdgBusca: TRadioGroup
        Left = 21
        Top = 13
        Width = 124
        Height = 105
        Caption = 'Buscar por:'
        Color = clBtnFace
        Enabled = False
        Items.Strings = (
          'Custo'
          'Pre'#231'o'
          'Peso')
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
      end
      object edtMenValor: TEdit
        Left = 166
        Top = 35
        Width = 123
        Height = 26
        CharCase = ecUpperCase
        Enabled = False
        TabOrder = 1
      end
      object edtMaiValor: TEdit
        Left = 166
        Top = 93
        Width = 123
        Height = 26
        CharCase = ecUpperCase
        Enabled = False
        TabOrder = 2
      end
    end
  end
  inherited pnlBotoes: TPanel
    Top = 222
    Width = 541
    ExplicitTop = 222
    ExplicitWidth = 541
    inherited btnVisualizar: TButton
      OnClick = btnVisualizarClick
    end
    inherited btnLimpar: TButton
      Left = 440
      OnClick = btnLimparClick
      ExplicitLeft = 440
    end
  end
end
