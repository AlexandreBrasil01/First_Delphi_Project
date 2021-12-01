inherited frmCadastroVenda: TfrmCadastroVenda
  Caption = 'Cadastro de Vendas'
  ClientHeight = 775
  ClientWidth = 1025
  ExplicitWidth = 1043
  ExplicitHeight = 820
  PixelsPerInch = 115
  TextHeight = 18
  inherited Panel1: TPanel
    Width = 1025
  end
  inherited Panel2: TPanel
    Width = 1025
    Height = 694
    ExplicitLeft = 1
    ExplicitTop = 25
    ExplicitWidth = 1025
    ExplicitHeight = 694
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
    object lblCliente: TLabel
      Left = 16
      Top = 144
      Width = 53
      Height = 18
      Caption = 'Cliente:'
    end
    object lblVendedor: TLabel
      Left = 16
      Top = 208
      Width = 72
      Height = 18
      Caption = 'Vendedor:'
    end
    object lblMemo: TLabel
      Left = 16
      Top = 400
      Width = 89
      Height = 18
      Caption = 'Observa'#231#227'o:'
    end
    object lblDesconto: TLabel
      Left = 16
      Top = 536
      Width = 71
      Height = 18
      Caption = 'Desconto:'
    end
    object lblTotal: TLabel
      Left = 16
      Top = 336
      Width = 36
      Height = 18
      Caption = 'Total:'
    end
    object lblFormaPagamento: TLabel
      Left = 16
      Top = 272
      Width = 157
      Height = 18
      Caption = 'Forma de Pagamento:'
    end
    object Label1: TLabel
      Left = 197
      Top = 563
      Width = 116
      Height = 18
      Caption = 'edt % + edt valor'
    end
    object edtDesconto: TEdit
      Left = 15
      Top = 560
      Width = 150
      Height = 26
      CharCase = ecUpperCase
      TabOrder = 0
    end
    object edtTotal: TEdit
      Left = 16
      Top = 360
      Width = 150
      Height = 26
      CharCase = ecUpperCase
      ReadOnly = True
      TabOrder = 1
    end
    object memoObs: TMemo
      Left = 16
      Top = 424
      Width = 200
      Height = 100
      CharCase = ecUpperCase
      TabOrder = 2
    end
    object edtFormaPagamento: TEdit
      Left = 16
      Top = 296
      Width = 120
      Height = 26
      CharCase = ecUpperCase
      TabOrder = 3
    end
    object edtVendedor: TEdit
      Left = 16
      Top = 232
      Width = 200
      Height = 26
      CharCase = ecUpperCase
      TabOrder = 4
    end
    object edtCliente: TEdit
      Left = 16
      Top = 168
      Width = 200
      Height = 26
      CharCase = ecUpperCase
      TabOrder = 5
    end
    object dtpEmissao: TDateTimePicker
      Left = 16
      Top = 104
      Width = 125
      Height = 26
      Date = 44501.000000000000000000
      Time = 0.600032592592469900
      TabOrder = 6
    end
    object edtId: TEdit
      Left = 16
      Top = 40
      Width = 60
      Height = 26
      Color = clGradientActiveCaption
      ReadOnly = True
      TabOrder = 7
    end
    object Button1: TButton
      Left = 264
      Top = 222
      Width = 49
      Height = 36
      Caption = 'Button1'
      TabOrder = 8
    end
    object Button2: TButton
      Left = 256
      Top = 286
      Width = 49
      Height = 36
      Caption = 'Button1'
      TabOrder = 9
    end
    object Button3: TButton
      Left = 272
      Top = 163
      Width = 49
      Height = 36
      Caption = 'Button1'
      TabOrder = 10
    end
  end
  inherited Panel3: TPanel
    Top = 735
    Width = 1025
  end
end
