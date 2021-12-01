inherited frmRelatorioUsuario: TfrmRelatorioUsuario
  Caption = 'Relatorio de Usuarios'
  ClientHeight = 552
  ClientWidth = 797
  ExplicitWidth = 815
  ExplicitHeight = 597
  PixelsPerInch = 115
  TextHeight = 16
  inherited rlpRelatorio: TRLReport
    inherited rlbCabecalho: TRLBand
      inherited rllCabecalhoTxt: TRLLabel
        Width = 142
        Caption = 'Relatorio - Usuarios'
        ExplicitWidth = 142
      end
    end
    inherited rlbRegistros: TRLBand
      object RLDBText1: TRLDBText
        Left = 128
        Top = 24
        Width = 51
        Height = 18
        DataField = 'NOME'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 128
        Top = 48
        Width = 51
        Height = 18
        DataField = 'EMAIL'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 128
        Top = 72
        Width = 51
        Height = 18
        DataField = 'LOGIN'
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
        Width = 47
        Height = 18
        Caption = 'Login:'
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
      object RLDBText4: TRLDBText
        Left = 128
        Top = 96
        Width = 117
        Height = 18
        DataField = 'NIVELACESSO'
        DataSource = DataSource1
        Text = ''
      end
      object RLLabel4: TRLLabel
        Left = 16
        Top = 96
        Width = 102
        Height = 18
        Caption = 'N. de Acesso:'
      end
    end
  end
  inherited DataSource1: TDataSource
    DataSet = qryRelatorio
    Left = 48
    Top = 448
  end
  inherited qryRelatorio: TFDQuery
    Connection = dtmConexao.FDConnection
    SQL.Strings = (
      'SELECT * FROM USUARIO')
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
      Size = 50
    end
    object qryRelatorioLOGIN: TStringField
      FieldName = 'LOGIN'
      Origin = 'LOGIN'
      Required = True
      Size = 5
    end
    object qryRelatorioSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Size = 5
    end
    object qryRelatorioNIVELACESSO: TIntegerField
      FieldName = 'NIVELACESSO'
      Origin = 'NIVELACESSO'
    end
    object qryRelatorioEMAIL: TStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Required = True
      Size = 60
    end
    object qryRelatorioFOTO: TBlobField
      FieldName = 'FOTO'
      Origin = 'FOTO'
    end
  end
end
