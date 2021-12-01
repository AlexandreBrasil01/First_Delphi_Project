inherited frmCadastroFPagamento: TfrmCadastroFPagamento
  Caption = 'Cadastra Forma de Pagamentos'
  ClientHeight = 288
  ClientWidth = 369
  ExplicitWidth = 387
  ExplicitHeight = 333
  PixelsPerInch = 115
  TextHeight = 18
  inherited pnlTitulo: TPanel
    Width = 369
    ExplicitWidth = 369
  end
  inherited pnlCentral: TPanel
    Width = 369
    Height = 207
    ExplicitWidth = 369
    ExplicitHeight = 207
    object lblDescricao: TLabel
      Left = 164
      Top = 88
      Width = 76
      Height = 18
      Caption = 'Descri'#231#227'o:'
    end
    object lblID: TLabel
      Left = 20
      Top = 14
      Width = 19
      Height = 18
      Caption = 'ID:'
    end
    object edtID: TEdit
      Left = 20
      Top = 40
      Width = 60
      Height = 26
      TabStop = False
      Color = clGradientActiveCaption
      ReadOnly = True
      TabOrder = 0
    end
    object edtDescricao: TEdit
      Left = 164
      Top = 112
      Width = 120
      Height = 26
      CharCase = ecUpperCase
      TabOrder = 1
    end
    object rdgTipo: TRadioGroup
      Left = 20
      Top = 91
      Width = 120
      Height = 90
      ItemIndex = 0
      Items.Strings = (
        'A Vista'
        'A Prazo')
      TabOrder = 2
    end
  end
  inherited pnlBotoes: TPanel
    Top = 248
    Width = 369
    ExplicitTop = 248
    ExplicitWidth = 369
    inherited btnSair: TButton
      OnClick = btnSairClick
    end
    inherited btnSalvar: TButton
      OnClick = btnSalvarClick
    end
  end
end
