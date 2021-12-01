inherited frmRelatorioVenda: TfrmRelatorioVenda
  Caption = 'frmRelatorioVenda'
  ClientHeight = 697
  ClientWidth = 792
  ExplicitWidth = 810
  ExplicitHeight = 742
  PixelsPerInch = 115
  TextHeight = 16
  inherited rlpRelatorio: TRLReport
    inherited rlbCabecalho: TRLBand
      Height = 43
      ExplicitHeight = 43
      inherited rllCabecalhoTxt: TRLLabel
        Top = 3
        Width = 134
        Caption = 'Relatorio - Vendas'
        ExplicitTop = 3
        ExplicitWidth = 134
      end
    end
    inherited rlbRegistros: TRLBand
      Top = 81
      BandType = btColumnHeader
      ExplicitTop = 81
      object RLLabel1: TRLLabel
        Left = 24
        Top = 24
        Width = 77
        Height = 18
        Caption = 'Vendedor:'
      end
      object RLDBText1: TRLDBText
        Left = 128
        Top = 24
        Width = 106
        Height = 18
        DataField = 'NVENDEDOR'
        DataSource = DataSource1
        Text = ''
      end
      object RLLabel2: TRLLabel
        Left = 24
        Top = 48
        Width = 57
        Height = 18
        Caption = 'Cliente:'
      end
      object RLLabel3: TRLLabel
        Left = 24
        Top = 72
        Width = 89
        Height = 18
        Caption = 'Pagamento:'
      end
      object RLLabel4: TRLLabel
        Left = 24
        Top = 96
        Width = 37
        Height = 18
        Caption = 'Obs:'
      end
      object RLLabel5: TRLLabel
        Left = 24
        Top = 120
        Width = 90
        Height = 18
        Caption = 'Acres/Desc:'
      end
      object RLLabel6: TRLLabel
        Left = 24
        Top = 144
        Width = 42
        Height = 18
        Caption = 'Total:'
      end
      object RLLabel7: TRLLabel
        Left = 24
        Top = 168
        Width = 70
        Height = 18
        Caption = 'Emiss'#227'o:'
      end
      object RLLabel8: TRLLabel
        Left = 24
        Top = 192
        Width = 91
        Height = 18
        Caption = 'Vencimento:'
      end
      object RLDBText2: TRLDBText
        Left = 128
        Top = 48
        Width = 81
        Height = 18
        DataField = 'NCLIENTE'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 128
        Top = 72
        Width = 99
        Height = 18
        DataField = 'DESCRICAO'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 128
        Top = 96
        Width = 38
        Height = 18
        DataField = 'OBS'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText5: TRLDBText
        Left = 128
        Top = 120
        Width = 94
        Height = 18
        DataField = 'DESCONTO'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText6: TRLDBText
        Left = 128
        Top = 144
        Width = 54
        Height = 18
        DataField = 'TOTAL'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText7: TRLDBText
        Left = 128
        Top = 168
        Width = 76
        Height = 18
        DataField = 'EMISSAO'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText8: TRLDBText
        Left = 128
        Top = 192
        Width = 160
        Height = 18
        DataField = 'DATA_VENCIMENTO'
        DataSource = DataSource1
        Text = ''
      end
      object RLLabel9: TRLLabel
        Left = 3
        Top = 272
        Width = 54
        Height = 18
        Caption = 'Venda:'
      end
      object RLLabel10: TRLLabel
        Left = 82
        Top = 272
        Width = 183
        Height = 18
        Caption = 'Produto:'
      end
      object RLLabel11: TRLLabel
        Left = 304
        Top = 272
        Width = 89
        Height = 18
        Caption = 'Quantidade:'
      end
      object RLLabel12: TRLLabel
        Left = 412
        Top = 272
        Width = 45
        Height = 18
        Caption = 'Valor:'
      end
      object RLLabel13: TRLLabel
        Left = 516
        Top = 272
        Width = 61
        Height = 18
        Caption = 'Desconto:'
      end
    end
    object RLBand1: TRLBand
      Left = 38
      Top = 385
      Width = 718
      Height = 192
      object RLDBText9: TRLDBText
        Left = 3
        Top = 40
        Width = 58
        Height = 18
        DataField = 'FK_VENDA'
        DataSource = DataSource2
        Text = ''
      end
      object RLDBText10: TRLDBText
        Left = 82
        Top = 40
        Width = 183
        Height = 18
        DataField = 'DESCRICAO'
        DataSource = DataSource2
        Text = ''
      end
      object RLDBText11: TRLDBText
        Left = 304
        Top = 40
        Width = 89
        Height = 18
        DataField = 'QUANTIDADE'
        DataSource = DataSource2
        Text = ''
      end
      object RLDBText12: TRLDBText
        Left = 420
        Top = 40
        Width = 61
        Height = 18
        DataField = 'VALOR'
        DataSource = DataSource2
        Text = ''
      end
      object RLDBText13: TRLDBText
        Left = 516
        Top = 40
        Width = 61
        Height = 18
        DataField = 'DESCONTO'
        DataSource = DataSource2
        Text = ''
      end
      object RLImage1: TRLImage
        Left = 272
        Top = 72
        Width = 105
        Height = 105
        Center = True
        Scaled = True
        BeforePrint = RLImage1BeforePrint
      end
    end
  end
  inherited DataSource1: TDataSource
    DataSet = qryRelatorio
    Left = 49
    Top = 594
  end
  inherited qryRelatorio: TFDQuery
    Connection = dtmConexao.FDConnection
    SQL.Strings = (
      'select '
      '  V.ID'
      ', V.FK_CLIENTE'
      ', C.NOME NCliente'
      ''
      ', V.FK_VENDEDOR'
      ', VN.NOME NVendedor'
      ''
      ', V.FK_FORMAPAGAMENTO'
      ', FP.DESCRICAO'
      ''
      ', V.OBS'
      ', V.DESCONTO'
      ', V.TOTAL'
      ', V.EMISSAO'
      ', V.DATA_VENCIMENTO'
      ''
      'from VENDA V'
      ' inner join CLIENTE C'
      ' on V.FK_CLIENTE = C.ID'
      ''
      'inner join VENDEDOR VN'
      ' on V.FK_VENDEDOR = VN.ID'
      ' '
      'inner join FORMAPAGAMENTO FP'
      ' on V.FK_FORMAPAGAMENTO = FP.ID')
    Left = 129
    Top = 594
    object qryRelatorioID2: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryRelatorioFK_CLIENTE: TIntegerField
      FieldName = 'FK_CLIENTE'
      Origin = 'FK_CLIENTE'
    end
    object qryRelatorioNCLIENTE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NCLIENTE'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 35
    end
    object qryRelatorioFK_VENDEDOR: TIntegerField
      FieldName = 'FK_VENDEDOR'
      Origin = 'FK_VENDEDOR'
    end
    object qryRelatorioNVENDEDOR: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NVENDEDOR'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 35
    end
    object qryRelatorioFK_FORMAPAGAMENTO: TIntegerField
      FieldName = 'FK_FORMAPAGAMENTO'
      Origin = 'FK_FORMAPAGAMENTO'
    end
    object qryRelatorioDESCRICAO2: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 25
    end
    object qryRelatorioOBS: TStringField
      FieldName = 'OBS'
      Origin = 'OBS'
      Size = 256
    end
    object qryRelatorioDESCONTO: TCurrencyField
      FieldName = 'DESCONTO'
      Origin = 'DESCONTO'
    end
    object qryRelatorioTOTAL: TBCDField
      FieldName = 'TOTAL'
      Origin = 'TOTAL'
      Precision = 18
    end
    object qryRelatorioEMISSAO: TSQLTimeStampField
      FieldName = 'EMISSAO'
      Origin = 'EMISSAO'
    end
    object qryRelatorioDATA_VENCIMENTO: TSQLTimeStampField
      FieldName = 'DATA_VENCIMENTO'
      Origin = 'DATA_VENCIMENTO'
    end
  end
  object DataSource2: TDataSource
    DataSet = qryDetalhe
    Left = 217
    Top = 594
  end
  object qryDetalhe: TFDQuery
    Connection = dtmConexao.FDConnection
    SQL.Strings = (
      'select'
      '  IT.ID'
      ', IT.FK_VENDA'
      ''
      ', IT.FK_PRODUTO'
      ', P.DESCRICAO'
      ', P.FOTO'
      ''
      ', IT.EMISSAO'
      ', IT.QUANTIDADE'
      ', IT.VALOR'
      ', IT.DESCONTO'
      'from VENDA_ITEM IT'
      ''
      ' inner join PRODUTO P'
      ' on IT.FK_PRODUTO = P.ID')
    Left = 294
    Top = 594
    object qryDetalheID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryDetalheFK_VENDA: TIntegerField
      FieldName = 'FK_VENDA'
      Origin = 'FK_VENDA'
    end
    object qryDetalheFK_PRODUTO: TIntegerField
      FieldName = 'FK_PRODUTO'
      Origin = 'FK_PRODUTO'
    end
    object qryDetalheDESCRICAO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 35
    end
    object qryDetalheFOTO: TBlobField
      AutoGenerateValue = arDefault
      FieldName = 'FOTO'
      Origin = 'FOTO'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryDetalheEMISSAO: TSQLTimeStampField
      FieldName = 'EMISSAO'
      Origin = 'EMISSAO'
    end
    object qryDetalheQUANTIDADE: TBCDField
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
      Precision = 18
    end
    object qryDetalheVALOR: TBCDField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      Precision = 18
    end
    object qryDetalheDESCONTO: TCurrencyField
      FieldName = 'DESCONTO'
      Origin = 'DESCONTO'
    end
  end
end
