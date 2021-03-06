object dtmConexao: TdtmConexao
  OldCreateOrder = False
  Height = 490
  Width = 268
  object FDConnection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Alexandre\Documents\TreinoDelphi\BancoIBE\TEST' +
        'E.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    Left = 30
    Top = 11
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    VendorLib = 
      'C:\Users\Alexandre\Documents\TreinoDelphi\Programa\ProjetoTreina' +
      'mento\fbclient.dll'
    Left = 139
    Top = 10
  end
  object qryConsultaClientes: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from cliente')
    Left = 136
    Top = 58
    object qryConsultaClientesID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryConsultaClientesNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 35
    end
    object qryConsultaClientesCPF: TStringField
      FieldName = 'CPF'
      Origin = 'CPF'
      Size = 11
    end
    object qryConsultaClientesEMAIL: TStringField
      DisplayLabel = 'Email'
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 60
    end
    object qryConsultaClientesCNPJ: TStringField
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      Size = 14
    end
    object qryConsultaClientesFISICOOUJURIDICO: TStringField
      FieldName = 'FISICOOUJURIDICO'
      Origin = 'FISICOOUJURIDICO'
      FixedChar = True
      Size = 1
    end
    object qryConsultaClientesENDERECO: TStringField
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Size = 35
    end
    object qryConsultaClientesBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
    end
    object qryConsultaClientesCEP: TStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 10
    end
    object qryConsultaClientesCIDADE: TStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 30
    end
  end
  object dtsClientes: TDataSource
    DataSet = qryConsultaClientes
    Left = 33
    Top = 59
  end
  object dtsUsuarios: TDataSource
    DataSet = qryConsultaUsuarios
    Left = 32
    Top = 104
  end
  object qryConsultaUsuarios: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from usuario')
    Left = 135
    Top = 104
    object qryConsultaUsuariosID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryConsultaUsuariosNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 50
    end
    object qryConsultaUsuariosLOGIN: TStringField
      FieldName = 'LOGIN'
      Origin = 'LOGIN'
      Required = True
      Size = 5
    end
    object qryConsultaUsuariosSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Size = 5
    end
    object qryConsultaUsuariosNIVELACESSO: TIntegerField
      FieldName = 'NIVELACESSO'
      Origin = 'NIVELACESSO'
    end
    object qryConsultaUsuariosEMAIL: TStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Required = True
      Size = 60
    end
  end
  object dtsProdutos: TDataSource
    DataSet = qryConsultaProdutos
    Left = 32
    Top = 152
  end
  object qryConsultaProdutos: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select'
      '  P.ID'
      ', P.FK_UNIDADE'
      ', P.DESCRICAO'
      ', P.REFERENCIA'
      ', P.PRECO'
      ', P.CUSTO'
      ', P.SALDO'
      ', P.PESO'
      ', P.FOTO'
      ', U.unidade'
      'from PRODUTO  P'
      'INNER JOIN UNIDADE U'
      'ON P.fk_unidade = U.id')
    Left = 136
    Top = 149
    object qryConsultaProdutosID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryConsultaProdutosFK_UNIDADE: TIntegerField
      FieldName = 'FK_UNIDADE'
      Origin = 'FK_UNIDADE'
      Required = True
    end
    object qryConsultaProdutosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 35
    end
    object qryConsultaProdutosREFERENCIA: TStringField
      FieldName = 'REFERENCIA'
      Origin = 'REFERENCIA'
      Size = 15
    end
    object qryConsultaProdutosPRECO: TBCDField
      FieldName = 'PRECO'
      Origin = 'PRECO'
      DisplayFormat = '#,#0.00'
      Precision = 18
    end
    object qryConsultaProdutosCUSTO: TBCDField
      FieldName = 'CUSTO'
      Origin = 'CUSTO'
      DisplayFormat = '#,#0.00'
      Precision = 18
    end
    object qryConsultaProdutosSALDO: TBCDField
      FieldName = 'SALDO'
      Origin = 'SALDO'
      DisplayFormat = '#,#0.00'
      Precision = 18
    end
    object qryConsultaProdutosPESO: TBCDField
      FieldName = 'PESO'
      Origin = 'PESO'
      DisplayFormat = '#,#0.00'
      Precision = 18
    end
    object qryConsultaProdutosFOTO: TBlobField
      FieldName = 'FOTO'
      Origin = 'FOTO'
    end
    object qryConsultaProdutosUNIDADE: TStringField
      Alignment = taCenter
      AutoGenerateValue = arDefault
      FieldName = 'UNIDADE'
      Origin = 'UNIDADE'
      ProviderFlags = []
      ReadOnly = True
      Size = 3
    end
  end
  object qryConsultaUnidade: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM UNIDADE')
    Left = 136
    Top = 198
    object qryConsultaUnidadeID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryConsultaUnidadeDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 35
    end
    object qryConsultaUnidadeUNIDADE: TStringField
      FieldName = 'UNIDADE'
      Origin = 'UNIDADE'
      Size = 3
    end
  end
  object dtsUnidade: TDataSource
    DataSet = qryConsultaUnidade
    Left = 32
    Top = 200
  end
  object qryConsultaFPagamento: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM FORMAPAGAMENTO')
    Left = 152
    Top = 246
    object qryConsultaFPagamentoID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      Required = True
    end
    object qryConsultaFPagamentoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 25
    end
    object qryConsultaFPagamentoTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      FixedChar = True
      Size = 1
    end
  end
  object dtsFPagamento: TDataSource
    DataSet = qryConsultaFPagamento
    Left = 32
    Top = 248
  end
  object qryConsultaVendedor: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM VENDEDOR')
    Left = 136
    Top = 296
    object qryConsultaVendedorID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryConsultaVendedorNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 35
    end
    object qryConsultaVendedorEMAIL: TStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 60
    end
    object qryConsultaVendedorENDERECO: TStringField
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Size = 35
    end
    object qryConsultaVendedorBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
    end
    object qryConsultaVendedorCEP: TStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 10
    end
    object qryConsultaVendedorCIDADE: TStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 30
    end
    object qryConsultaVendedorFOTO: TBlobField
      FieldName = 'FOTO'
      Origin = 'FOTO'
    end
  end
  object dtsVendedor: TDataSource
    DataSet = qryConsultaVendedor
    Left = 32
    Top = 296
  end
  object qryVenda: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT'
      '  V.ID'
      ', V.FK_CLIENTE'
      ', C.NOME'
      ''
      ', V.FK_VENDEDOR'
      ', VN.NOME'
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
    Left = 136
    Top = 344
    object qryVendaID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryVendaFK_CLIENTE: TIntegerField
      FieldName = 'FK_CLIENTE'
      Origin = 'FK_CLIENTE'
    end
    object qryVendaNOME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 35
    end
    object qryVendaFK_VENDEDOR: TIntegerField
      FieldName = 'FK_VENDEDOR'
      Origin = 'FK_VENDEDOR'
    end
    object qryVendaNOME_1: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME_1'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 35
    end
    object qryVendaFK_FORMAPAGAMENTO: TIntegerField
      FieldName = 'FK_FORMAPAGAMENTO'
      Origin = 'FK_FORMAPAGAMENTO'
    end
    object qryVendaDESCRICAO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 25
    end
    object qryVendaOBS: TStringField
      FieldName = 'OBS'
      Origin = 'OBS'
      Size = 256
    end
    object qryVendaDESCONTO: TCurrencyField
      FieldName = 'DESCONTO'
      Origin = 'DESCONTO'
    end
    object qryVendaTOTAL: TBCDField
      FieldName = 'TOTAL'
      Origin = 'TOTAL'
      Precision = 18
    end
    object qryVendaEMISSAO: TSQLTimeStampField
      FieldName = 'EMISSAO'
      Origin = 'EMISSAO'
    end
    object qryVendaDATA_VENCIMENTO: TSQLTimeStampField
      FieldName = 'DATA_VENCIMENTO'
      Origin = 'DATA_VENCIMENTO'
    end
  end
  object dtsItens: TDataSource
    DataSet = tblConsultaItens
    Left = 32
    Top = 392
  end
  object tblConsultaItens: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'FK_VENDA'
        DataType = ftInteger
      end
      item
        Name = 'FK_PRODUTO'
        DataType = ftInteger
      end
      item
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 35
      end
      item
        Name = 'EMISSAO'
        DataType = ftDate
      end
      item
        Name = 'QUANTIDADE'
        DataType = ftFloat
      end
      item
        Name = 'VALOR'
        DataType = ftFloat
      end
      item
        Name = 'DESCONTO'
        DataType = ftFloat
      end
      item
        Name = 'TOTAL'
        DataType = ftFloat
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 136
    Top = 392
    object tblConsultaItensFK_VENDA: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'FK_VENDA'
    end
    object tblConsultaItensFK_PRODUTO: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'FK_PRODUTO'
    end
    object tblConsultaItensDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 35
    end
    object tblConsultaItensEMISSAO: TDateField
      FieldName = 'EMISSAO'
    end
    object tblConsultaItensQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
      DisplayFormat = '#,#0.00'
    end
    object tblConsultaItensVALOR: TFloatField
      FieldName = 'VALOR'
      DisplayFormat = '#,#0.00'
    end
    object tblConsultaItensDESCONTO: TFloatField
      FieldName = 'DESCONTO'
      DisplayFormat = '#,#0.00'
    end
    object tblConsultaItensTOTAL: TFloatField
      FieldName = 'TOTAL'
      DisplayFormat = '#,#0.00'
    end
  end
  object dtsVenda: TDataSource
    DataSet = qryVenda
    Left = 32
    Top = 344
  end
end
