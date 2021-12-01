inherited frrCadastroItem: TfrrCadastroItem
  Caption = 'Cadastro de Itens'
  PixelsPerInch = 115
  TextHeight = 18
  inherited Panel2: TPanel
    ExplicitLeft = -16
    ExplicitTop = 97
    object lblId: TLabel
      Left = 16
      Top = 16
      Width = 19
      Height = 18
      Caption = 'ID:'
    end
    object lblEmissao: TLabel
      Left = 16
      Top = 80
      Width = 126
      Height = 18
      Caption = 'Data de Emiss'#227'o:'
    end
    object lblProduto: TLabel
      Left = 16
      Top = 144
      Width = 59
      Height = 18
      Caption = 'Produto:'
    end
    object lblDescricao: TLabel
      Left = 16
      Top = 208
      Width = 76
      Height = 18
      Caption = 'Descri'#231#227'o:'
    end
    object dtpEmissao: TDateTimePicker
      Left = 16
      Top = 104
      Width = 125
      Height = 26
      Date = 44501.000000000000000000
      Time = 0.600032592592469900
      TabOrder = 0
    end
    object edtId: TEdit
      Left = 16
      Top = 40
      Width = 60
      Height = 26
      Color = clGradientActiveCaption
      ReadOnly = True
      TabOrder = 1
    end
    object edtProduto: TEdit
      Left = 16
      Top = 168
      Width = 150
      Height = 26
      CharCase = ecUpperCase
      TabOrder = 2
    end
    object Button2: TButton
      Left = 192
      Top = 163
      Width = 49
      Height = 36
      Caption = 'Button1'
      TabOrder = 3
    end
    object edtDescricao: TEdit
      Left = 16
      Top = 232
      Width = 145
      Height = 26
      CharCase = ecUpperCase
      TabOrder = 4
    end
    object Edit2: TEdit
      Left = 16
      Top = 296
      Width = 145
      Height = 26
      CharCase = ecUpperCase
      TabOrder = 5
    end
  end
  inherited Panel3: TPanel
    ExplicitTop = 514
  end
end
