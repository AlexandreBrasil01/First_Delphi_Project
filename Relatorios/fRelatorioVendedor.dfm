inherited frmRelatorioVendedor: TfrmRelatorioVendedor
  Caption = 'Relatorio de Vendedores'
  PixelsPerInch = 115
  TextHeight = 16
  inherited rlpRelatorio: TRLReport
    inherited rlbCabecalho: TRLBand
      inherited rllCabecalhoTxt: TRLLabel
        Left = 256
        Width = 166
        Caption = 'Relatorio - Vendedores'
        ExplicitLeft = 256
        ExplicitWidth = 166
      end
    end
    inherited rlbRegistros: TRLBand
      object RLDBText1: TRLDBText
        Left = 136
        Top = 24
        Width = 51
        Height = 18
        DataField = 'NOME'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 136
        Top = 48
        Width = 51
        Height = 18
        DataField = 'EMAIL'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 136
        Top = 72
        Width = 38
        Height = 18
        DataField = 'CEP'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 136
        Top = 96
        Width = 65
        Height = 18
        DataField = 'CIDADE'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText5: TRLDBText
        Left = 136
        Top = 120
        Width = 63
        Height = 18
        DataField = 'BAIRRO'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText6: TRLDBText
        Left = 136
        Top = 144
        Width = 95
        Height = 18
        DataField = 'ENDERECO'
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
      object RLLabel2: TRLLabel
        Left = 16
        Top = 48
        Width = 53
        Height = 18
        Caption = 'E-Mail:'
      end
      object RLLabel3: TRLLabel
        Left = 16
        Top = 72
        Width = 42
        Height = 18
        Caption = 'CEP:'
      end
      object RLLabel4: TRLLabel
        Left = 16
        Top = 96
        Width = 60
        Height = 18
        Caption = 'Cidade:'
      end
      object RLLabel5: TRLLabel
        Left = 16
        Top = 120
        Width = 51
        Height = 18
        Caption = 'Bairro:'
      end
      object RLLabel6: TRLLabel
        Left = 16
        Top = 144
        Width = 76
        Height = 18
        Caption = 'Endere'#231'o:'
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
    end
  end
  inherited DataSource1: TDataSource
    DataSet = qryRelatorio
  end
  inherited qryRelatorio: TFDQuery
    Connection = dtmConexao.FDConnection
    SQL.Strings = (
      'SELECT * FROM VENDEDOR')
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
end
