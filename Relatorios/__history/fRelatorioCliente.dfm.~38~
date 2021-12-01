object frmRelatorioCliente: TfrmRelatorioCliente
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio'
  ClientHeight = 552
  ClientWidth = 795
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 115
  TextHeight = 18
  object rlpRelatorio: TRLReport
    Left = 0
    Top = 0
    Width = 794
    Height = 1123
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    object rlbRegistros: TRLBand
      Left = 38
      Top = 105
      Width = 718
      Height = 304
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      object txtNome: TRLDBText
        Left = 126
        Top = 24
        Width = 51
        Height = 18
        DataField = 'NOME'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object txtBairro: TRLDBText
        Left = 126
        Top = 144
        Width = 63
        Height = 18
        DataField = 'BAIRRO'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object txtcpfcnpj: TRLDBText
        Left = 126
        Top = 48
        Width = 68
        Height = 18
        DataSource = DataSource1
        Text = ''
        BeforePrint = txtcpfcnpjBeforePrint
      end
      object txtEmail: TRLDBText
        Left = 126
        Top = 72
        Width = 51
        Height = 18
        DataField = 'EMAIL'
        DataSource = DataSource1
        Text = ''
      end
      object RLLabel1: TRLLabel
        Left = 16
        Top = 24
        Width = 50
        Height = 18
        Caption = 'Nome:'
      end
      object txtCidade: TRLDBText
        Left = 126
        Top = 120
        Width = 65
        Height = 18
        DataField = 'CIDADE'
        DataSource = DataSource1
        Text = ''
      end
      object txtEndereco: TRLDBText
        Left = 126
        Top = 168
        Width = 95
        Height = 18
        DataField = 'ENDERECO'
        DataSource = DataSource1
        Text = ''
      end
      object txtCEP: TRLDBText
        Left = 126
        Top = 96
        Width = 38
        Height = 18
        DataField = 'CEP'
        DataSource = DataSource1
        Text = ''
      end
      object RLImage1: TRLImage
        Left = 424
        Top = 24
        Width = 130
        Height = 150
        Center = True
        Scaled = True
        BeforePrint = RLImage1BeforePrint
      end
      object RLLabel2: TRLLabel
        Left = 16
        Top = 48
        Width = 72
        Height = 18
        BeforePrint = RLLabel2BeforePrint
      end
      object RLLabel3: TRLLabel
        Left = 16
        Top = 72
        Width = 53
        Height = 18
        Caption = 'E-Mail:'
      end
      object RLLabel4: TRLLabel
        Left = 16
        Top = 96
        Width = 42
        Height = 18
        Caption = 'CEP:'
      end
      object RLLabel5: TRLLabel
        Left = 16
        Top = 120
        Width = 60
        Height = 18
        Caption = 'Cidade:'
      end
      object RLLabel6: TRLLabel
        Left = 16
        Top = 144
        Width = 51
        Height = 18
        Caption = 'Bairro:'
      end
      object RLLabel7: TRLLabel
        Left = 16
        Top = 168
        Width = 76
        Height = 18
        Caption = 'Endere'#231'o:'
      end
    end
    object rlbCabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 67
      BandType = btColumnHeader
      object rllCabecalhoTxt: TRLLabel
        Left = 272
        Top = 16
        Width = 143
        Height = 18
        Caption = 'Relatorio - CLientes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object qryRelatorio: TFDQuery
    Active = True
    Connection = dtmConexao.FDConnection
    SQL.Strings = (
      'SELECT * FROM CLIENTE')
    Left = 48
    Top = 496
    object qryRelatorioID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryRelatorioNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 35
    end
    object qryRelatorioCPF: TStringField
      FieldName = 'CPF'
      Origin = 'CPF'
      Size = 11
    end
    object qryRelatorioCNPJ: TStringField
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      Size = 14
    end
    object qryRelatorioFISICOOUJURIDICO: TStringField
      FieldName = 'FISICOOUJURIDICO'
      Origin = 'FISICOOUJURIDICO'
      FixedChar = True
      Size = 1
    end
    object qryRelatorioEMAIL: TStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 60
    end
    object qryRelatorioENDERECO: TStringField
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Size = 35
    end
    object qryRelatorioBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
    end
    object qryRelatorioCEP: TStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 10
    end
    object qryRelatorioCIDADE: TStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 30
    end
    object qryRelatorioFOTO: TBlobField
      FieldName = 'FOTO'
      Origin = 'FOTO'
    end
  end
  object DataSource1: TDataSource
    DataSet = qryRelatorio
    Left = 48
    Top = 448
  end
end
