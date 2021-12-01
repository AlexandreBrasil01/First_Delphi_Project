inherited frmRelatorioFPagamento: TfrmRelatorioFPagamento
  Caption = 'Relatorio da Forma de Pagamento'
  PixelsPerInch = 115
  TextHeight = 16
  inherited rlpRelatorio: TRLReport
    inherited rlbCabecalho: TRLBand
      inherited rllCabecalhoTxt: TRLLabel
        Left = 240
        Width = 236
        Caption = 'Relatorio - Forma De Pagamento'
        ExplicitLeft = 240
        ExplicitWidth = 236
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
        Left = 136
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
        Width = 39
        Height = 18
        Caption = 'Tipo:'
      end
      object RLDBText2: TRLDBText
        Left = 136
        Top = 48
        Width = 99
        Height = 18
        DataField = 'DESCRICAO'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 136
        Top = 72
        Width = 39
        Height = 18
        DataField = 'TIPO'
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
      'SELECT * FROM FORMAPAGAMENTO')
    object qryRelatorioID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryRelatorioDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 25
    end
    object qryRelatorioTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      FixedChar = True
      Size = 1
    end
  end
end
