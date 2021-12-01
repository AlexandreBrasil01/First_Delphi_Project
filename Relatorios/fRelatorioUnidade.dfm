inherited frmRelatorioUnidade: TfrmRelatorioUnidade
  Caption = 'Relatorio da Unidade de Medida'
  PixelsPerInch = 115
  TextHeight = 16
  inherited rlpRelatorio: TRLReport
    inherited rlbCabecalho: TRLBand
      inherited rllCabecalhoTxt: TRLLabel
        Left = 228
        Width = 226
        Caption = 'Relatorio - Unidades de Medida'
        ExplicitLeft = 228
        ExplicitWidth = 226
      end
    end
    inherited rlbRegistros: TRLBand
      object RLLabel1: TRLLabel
        Left = 16
        Top = 24
        Width = 60
        Height = 18
        Caption = 'C'#243'digo:'
      end
      object RLDBText1: TRLDBText
        Left = 128
        Top = 24
        Width = 19
        Height = 18
        DataField = 'ID'
        DataSource = DataSource1
        Text = ''
      end
      object RLLabel2: TRLLabel
        Left = 16
        Top = 48
        Width = 80
        Height = 18
        Caption = 'Descri'#231#227'o:'
      end
      object RLLabel3: TRLLabel
        Left = 16
        Top = 72
        Width = 67
        Height = 18
        Caption = 'Unidade:'
      end
      object RLDBText2: TRLDBText
        Left = 128
        Top = 48
        Width = 99
        Height = 18
        DataField = 'DESCRICAO'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 128
        Top = 72
        Width = 75
        Height = 18
        DataField = 'UNIDADE'
        DataSource = DataSource1
        Text = ''
      end
    end
  end
  inherited DataSource1: TDataSource
    DataSet = qryRelatorio
  end
  inherited qryRelatorio: TFDQuery
    Active = True
    Connection = dtmConexao.FDConnection
    SQL.Strings = (
      'SELECT * FROM UNIDADE')
    object qryRelatorioID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryRelatorioDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 35
    end
    object qryRelatorioUNIDADE: TStringField
      FieldName = 'UNIDADE'
      Origin = 'UNIDADE'
      Size = 3
    end
  end
end
