inherited frmConsultaVenda: TfrmConsultaVenda
  Caption = 'Consulta Venda'
  ClientHeight = 759
  ClientWidth = 1092
  ExplicitWidth = 1110
  ExplicitHeight = 804
  PixelsPerInch = 115
  TextHeight = 18
  inherited pnlPesquisa: TPanel
    Width = 1092
    Height = 88
    ExplicitWidth = 1092
    ExplicitHeight = 88
    inherited cbxFiltro: TComboBox
      ItemIndex = 0
      Text = 'Id'
      OnChange = cbxFiltroChange
      Items.Strings = (
        'Id'
        'Cliente'
        'Vendedor'
        'F.Pagamento')
    end
    inherited edtPesquisar: TEdit
      Left = 14
      Top = 39
      CharCase = ecUpperCase
      NumbersOnly = True
      OnChange = edtPesquisarChange
      ExplicitLeft = 14
      ExplicitTop = 39
    end
    object pnlData: TPanel
      Left = 181
      Top = 6
      Width = 161
      Height = 75
      Color = clTeal
      ParentBackground = False
      TabOrder = 2
      Visible = False
      object lblFiltroData: TLabel
        Left = 39
        Top = 10
        Width = 102
        Height = 18
        Caption = 'Filtrar por data'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object cbxFiltraData: TCheckBox
        Left = 16
        Top = 11
        Width = 129
        Height = 17
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object dtpEmissao: TDateTimePicker
        Left = 16
        Top = 34
        Width = 129
        Height = 26
        Date = 44505.000000000000000000
        Time = 0.461487210646737400
        TabOrder = 0
      end
    end
  end
  inherited pnlBotoes: TPanel
    Top = 719
    Width = 1092
    ExplicitTop = 719
    ExplicitWidth = 1092
    inherited btnAtualizar: TButton
      OnClick = btnAtualizarClick
    end
    inherited btnIncluir: TButton
      OnClick = btnIncluirClick
    end
    inherited btnAlterar: TButton
      OnClick = btnAlterarClick
    end
    inherited btnSair: TButton
      OnClick = btnSairClick
    end
    inherited btnExcluir: TButton
      OnClick = btnExcluirClick
    end
    inherited btnRelat: TButton
      Visible = True
      OnClick = btnRelatClick
    end
    inherited btnVisualizar: TButton
      OnClick = btnVisualizarClick
    end
  end
  inherited pnlGrid: TPanel
    Top = 129
    Width = 1092
    Height = 590
    ExplicitTop = 129
    ExplicitWidth = 1092
    ExplicitHeight = 590
    inherited grdConsulta: TDBGrid
      Width = 1090
      Height = 588
      DataSource = dtmConexao.dtsVenda
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Title.Caption = 'Id'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FK_CLIENTE'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'NOME'
          Title.Caption = 'Nome Cliente'
          Width = 280
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FK_VENDEDOR'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'NOME_1'
          Title.Caption = 'Nome Vendedor'
          Width = 280
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FK_FORMAPAGAMENTO'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Caption = 'Forma de Pagamento'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OBS'
          Width = 300
          Visible = True
        end
        item
          Alignment = taLeftJustify
          Expanded = False
          FieldName = 'DESCONTO'
          Title.Caption = 'Desconto'
          Width = 100
          Visible = True
        end
        item
          Alignment = taLeftJustify
          Expanded = False
          FieldName = 'TOTAL'
          Title.Caption = 'Total'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMISSAO'
          Title.Caption = 'Emiss'#227'o'
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA_VENCIMENTO'
          Title.Caption = 'Vencimento'
          Width = 130
          Visible = True
        end>
    end
  end
  inherited pnlTitulo: TPanel
    Width = 1092
    ExplicitWidth = 1092
  end
end
