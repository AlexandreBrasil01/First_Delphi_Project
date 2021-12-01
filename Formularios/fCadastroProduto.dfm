inherited frmCadastroProduto: TfrmCadastroProduto
  Caption = 'Cadastro de Produtos'
  ClientHeight = 603
  ClientWidth = 831
  OnCreate = FormCreate
  ExplicitWidth = 849
  ExplicitHeight = 648
  PixelsPerInch = 115
  TextHeight = 18
  inherited pnlTitulo: TPanel
    Width = 831
    ExplicitWidth = 831
  end
  inherited pnlCentral: TPanel
    Width = 831
    Height = 522
    ExplicitWidth = 831
    ExplicitHeight = 522
    object lblID: TLabel
      Left = 16
      Top = 8
      Width = 19
      Height = 18
      Caption = 'ID:'
    end
    object lblReferencia: TLabel
      Left = 16
      Top = 128
      Width = 80
      Height = 18
      Caption = 'Refer'#234'ncia:'
    end
    object lblDescricao: TLabel
      Left = 16
      Top = 67
      Width = 76
      Height = 18
      Caption = 'Descri'#231#227'o:'
    end
    object lblPreco: TLabel
      Left = 16
      Top = 250
      Width = 46
      Height = 18
      Caption = 'Pre'#231'o:'
    end
    object lblCusto: TLabel
      Left = 16
      Top = 187
      Width = 45
      Height = 18
      Caption = 'Custo:'
    end
    object lblSaldo: TLabel
      Left = 16
      Top = 314
      Width = 45
      Height = 18
      Caption = 'Saldo:'
    end
    object lblPeso: TLabel
      Left = 16
      Top = 437
      Width = 41
      Height = 18
      Caption = 'Peso:'
    end
    object lblkUnidade: TLabel
      Left = 16
      Top = 373
      Width = 82
      Height = 18
      Caption = 'ID Unidade:'
    end
    object edtID: TEdit
      Left = 16
      Top = 32
      Width = 60
      Height = 26
      TabStop = False
      Color = clGradientActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object edtDescricao: TEdit
      Left = 16
      Top = 91
      Width = 200
      Height = 26
      CharCase = ecUpperCase
      MaxLength = 35
      TabOrder = 1
    end
    object edtReferencia: TEdit
      Left = 16
      Top = 152
      Width = 200
      Height = 26
      CharCase = ecUpperCase
      MaxLength = 15
      TabOrder = 2
    end
    object edtPreco: TEdit
      Left = 16
      Top = 274
      Width = 150
      Height = 26
      TabOrder = 4
      OnExit = edtPrecoExit
      OnKeyPress = edtPrecoKeyPress
    end
    object edtCusto: TEdit
      Left = 16
      Top = 211
      Width = 150
      Height = 26
      TabOrder = 3
      OnExit = edtCustoExit
      OnKeyPress = edtCustoKeyPress
    end
    object edtSaldo: TEdit
      Left = 16
      Top = 338
      Width = 150
      Height = 26
      TabOrder = 5
      OnExit = edtSaldoExit
      OnKeyPress = edtSaldoKeyPress
    end
    object edtPeso: TEdit
      Left = 16
      Top = 461
      Width = 120
      Height = 26
      TabOrder = 7
      OnExit = edtPesoExit
      OnKeyPress = edtPesoKeyPress
    end
    object cbxFkUnidade: TComboBox
      Left = 16
      Top = 397
      Width = 120
      Height = 26
      Style = csDropDownList
      CharCase = ecUpperCase
      TabOrder = 6
    end
    object pnlImagem: TPanel
      Left = 256
      Top = 32
      Width = 200
      Height = 230
      Color = clWhite
      ParentBackground = False
      TabOrder = 8
      object imgProduto: TImage
        Left = 1
        Top = 1
        Width = 198
        Height = 228
        Align = alClient
        Center = True
        ExplicitTop = -35
      end
    end
  end
  inherited pnlBotoes: TPanel
    Top = 563
    Width = 831
    ExplicitTop = 563
    ExplicitWidth = 831
    inherited btnSair: TButton
      OnClick = btnSairClick
    end
    inherited btnSalvar: TButton
      OnClick = btnSalvarClick
    end
  end
end
