inherited frmRelatorioProduto: TfrmRelatorioProduto
  Caption = 'frmRelatorioProduto'
  ClientWidth = 793
  ExplicitWidth = 811
  PixelsPerInch = 115
  TextHeight = 16
  inherited rlpRelatorio: TRLReport
    Left = -3
    ExplicitLeft = -3
    inherited rlbCabecalho: TRLBand
      inherited rllCabecalhoTxt: TRLLabel
        Left = 224
        Width = 135
        Caption = 'Relatorio - Produto'
        ExplicitLeft = 224
        ExplicitWidth = 135
      end
    end
    inherited rlbRegistros: TRLBand
      object RLDBText1: TRLDBText
        Left = 128
        Top = 24
        Width = 99
        Height = 18
        DataField = 'DESCRICAO'
        DataSource = DataSource1
        Text = ''
      end
      object RLLabel1: TRLLabel
        Left = 16
        Top = 24
        Width = 80
        Height = 18
        Caption = 'Descri'#231#227'o:'
      end
      object RLLabel2: TRLLabel
        Left = 16
        Top = 48
        Width = 84
        Height = 18
        Caption = 'Refer'#234'ncia:'
      end
      object RLLabel3: TRLLabel
        Left = 16
        Top = 72
        Width = 49
        Height = 18
        Caption = 'Custo:'
      end
      object RLDBText2: TRLDBText
        Left = 128
        Top = 48
        Width = 106
        Height = 18
        DataField = 'REFERENCIA'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 128
        Top = 72
        Width = 59
        Height = 18
        DataField = 'CUSTO'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 128
        Top = 96
        Width = 61
        Height = 18
        DataField = 'PRECO'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText5: TRLDBText
        Left = 128
        Top = 120
        Width = 59
        Height = 18
        DataField = 'SALDO'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText6: TRLDBText
        Left = 128
        Top = 144
        Width = 49
        Height = 18
        DataField = 'PESO'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText7: TRLDBText
        Left = 128
        Top = 168
        Width = 117
        Height = 18
        DataField = 'DESCRICAO_1'
        DataSource = DataSource1
        Text = ''
      end
      object RLLabel4: TRLLabel
        Left = 16
        Top = 96
        Width = 50
        Height = 18
        Caption = 'Pre'#231'o:'
      end
      object RLLabel5: TRLLabel
        Left = 16
        Top = 120
        Width = 49
        Height = 18
        Caption = 'Saldo:'
      end
      object RLLabel6: TRLLabel
        Left = 16
        Top = 144
        Width = 45
        Height = 18
        Caption = 'Peso:'
      end
      object RLLabel7: TRLLabel
        Left = 16
        Top = 168
        Width = 61
        Height = 18
        Caption = 'Medida:'
      end
      object RLImage1: TRLImage
        Left = 408
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
    Top = 472
  end
  inherited qryRelatorio: TFDQuery
    Connection = dtmConexao.FDConnection
    SQL.Strings = (
      ' select'
      '   P.id'
      ' , P.descricao '
      ' , P.REFERENCIA'
      ' , P.CUSTO'
      ' , P.PRECO'
      ' , P.SALDO'
      ' , P.FK_UNIDADE'
      ' , U.descricao '
      ' , P.PESO'
      ' , P.FOTO'
      ' from PRODUTO P'
      ' inner join unidade U'
      ' on P.fk_unidade = U.ID')
    Left = 45
    Top = 520
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
    object qryRelatorioREFERENCIA: TStringField
      FieldName = 'REFERENCIA'
      Origin = 'REFERENCIA'
      Size = 15
    end
    object qryRelatorioCUSTO: TBCDField
      FieldName = 'CUSTO'
      Origin = 'CUSTO'
      Precision = 18
    end
    object qryRelatorioPRECO: TBCDField
      FieldName = 'PRECO'
      Origin = 'PRECO'
      Precision = 18
    end
    object qryRelatorioSALDO: TBCDField
      FieldName = 'SALDO'
      Origin = 'SALDO'
      Precision = 18
    end
    object qryRelatorioFK_UNIDADE: TIntegerField
      FieldName = 'FK_UNIDADE'
      Origin = 'FK_UNIDADE'
      Required = True
    end
    object qryRelatorioDESCRICAO_1: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESCRICAO_1'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 35
    end
    object qryRelatorioPESO: TBCDField
      FieldName = 'PESO'
      Origin = 'PESO'
      Precision = 18
    end
    object qryRelatorioFOTO: TBlobField
      FieldName = 'FOTO'
      Origin = 'FOTO'
    end
  end
end
