inherited frmCadastroVendedor: TfrmCadastroVendedor
  Caption = 'Cadastro do Vendedor'
  ClientHeight = 597
  ExplicitHeight = 642
  PixelsPerInch = 115
  TextHeight = 18
  inherited pnlCentral: TPanel
    Height = 516
    ExplicitHeight = 516
    object lblId: TLabel
      Left = 16
      Top = 16
      Width = 19
      Height = 18
      Caption = 'ID:'
    end
    object lblNome: TLabel
      Left = 16
      Top = 80
      Width = 46
      Height = 18
      Caption = 'Nome:'
    end
    object lblEmail: TLabel
      Left = 16
      Top = 144
      Width = 49
      Height = 18
      Caption = 'E-mail:'
    end
    object lblEndereco: TLabel
      Left = 16
      Top = 400
      Width = 72
      Height = 18
      Caption = 'Endere'#231'o:'
    end
    object lblBairro: TLabel
      Left = 16
      Top = 336
      Width = 47
      Height = 18
      Caption = 'Bairro:'
    end
    object lblCep: TLabel
      Left = 16
      Top = 208
      Width = 38
      Height = 18
      Caption = 'CEP:'
    end
    object lblCidade: TLabel
      Left = 16
      Top = 272
      Width = 56
      Height = 18
      Caption = 'Cidade:'
    end
    object edtBairro: TEdit
      Left = 16
      Top = 360
      Width = 200
      Height = 26
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 5
    end
    object edtCidade: TEdit
      Left = 16
      Top = 296
      Width = 180
      Height = 26
      CharCase = ecUpperCase
      MaxLength = 30
      TabOrder = 4
    end
    object edtCep: TEdit
      Left = 16
      Top = 232
      Width = 120
      Height = 26
      CharCase = ecUpperCase
      MaxLength = 8
      NumbersOnly = True
      TabOrder = 3
    end
    object edtEndereco: TEdit
      Left = 16
      Top = 424
      Width = 230
      Height = 26
      CharCase = ecUpperCase
      MaxLength = 35
      TabOrder = 6
    end
    object edtEmail: TEdit
      Left = 16
      Top = 168
      Width = 300
      Height = 26
      CharCase = ecUpperCase
      MaxLength = 60
      TabOrder = 2
    end
    object edtNome: TEdit
      Left = 16
      Top = 104
      Width = 300
      Height = 26
      CharCase = ecUpperCase
      MaxLength = 35
      TabOrder = 1
    end
    object edtId: TEdit
      Left = 16
      Top = 40
      Width = 60
      Height = 26
      CharCase = ecUpperCase
      Color = clGradientActiveCaption
      ReadOnly = True
      TabOrder = 0
    end
    object pnlImagem: TPanel
      Left = 342
      Top = 40
      Width = 200
      Height = 230
      Color = clWhite
      ParentBackground = False
      TabOrder = 7
      object imgVendedor: TImage
        Left = 1
        Top = 1
        Width = 198
        Height = 228
        Align = alClient
        ExplicitLeft = 32
        ExplicitTop = 72
        ExplicitWidth = 105
        ExplicitHeight = 105
      end
    end
  end
  inherited pnlBotoes: TPanel
    Top = 557
    ExplicitTop = 557
    inherited btnSair: TButton
      OnClick = btnSairClick
    end
    inherited btnSalvar: TButton
      OnClick = btnSalvarClick
    end
  end
end
