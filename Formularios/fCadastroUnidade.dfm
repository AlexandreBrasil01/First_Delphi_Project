inherited frmCadastroUnidade: TfrmCadastroUnidade
  Caption = 'Cadastro de Unidades'
  ClientHeight = 365
  ClientWidth = 491
  ExplicitWidth = 509
  ExplicitHeight = 410
  PixelsPerInch = 115
  TextHeight = 18
  inherited pnlTitulo: TPanel
    Width = 491
    ExplicitWidth = 491
  end
  inherited pnlCentral: TPanel
    Width = 491
    Height = 284
    ExplicitWidth = 491
    ExplicitHeight = 284
    object lblID: TLabel
      Left = 16
      Top = 21
      Width = 19
      Height = 18
      Caption = 'ID:'
    end
    object lblDescricao: TLabel
      Left = 16
      Top = 83
      Width = 76
      Height = 18
      Caption = 'Descri'#231#227'o:'
    end
    object lblUnidade: TLabel
      Left = 16
      Top = 147
      Width = 63
      Height = 18
      Caption = 'Unidade:'
    end
    object edtID: TEdit
      Left = 16
      Top = 48
      Width = 60
      Height = 26
      TabStop = False
      Color = clGradientActiveCaption
      ReadOnly = True
      TabOrder = 0
    end
    object edtDescricao: TEdit
      Left = 16
      Top = 107
      Width = 200
      Height = 26
      CharCase = ecUpperCase
      MaxLength = 35
      TabOrder = 1
    end
    object edtUnidade: TEdit
      Left = 16
      Top = 171
      Width = 60
      Height = 26
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 2
    end
  end
  inherited pnlBotoes: TPanel
    Top = 325
    Width = 491
    ExplicitTop = 325
    ExplicitWidth = 491
    inherited btnSair: TButton
      OnClick = btnSairClick
    end
    inherited btnSalvar: TButton
      OnClick = btnSalvarClick
    end
  end
end
