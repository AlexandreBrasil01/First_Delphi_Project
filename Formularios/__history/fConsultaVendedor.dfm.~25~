inherited frmConsultaVendedor: TfrmConsultaVendedor
  Caption = 'Consulta de Vendedores'
  PixelsPerInch = 115
  TextHeight = 18
  inherited pnlPesquisa: TPanel
    inherited cbxFiltro: TComboBox
      ItemIndex = 0
      Text = 'Id'
      OnChange = cbxFiltroChange
      Items.Strings = (
        'Id'
        'Nome'
        'E-mail'
        'Cidade')
    end
    inherited edtPesquisar: TEdit
      CharCase = ecUpperCase
      OnChange = edtPesquisarChange
    end
  end
  inherited pnlBotoes: TPanel
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
    inherited grdConsulta: TDBGrid
      DataSource = dtmConexao.dtsVendedor
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
          FieldName = 'NOME'
          Title.Caption = 'Nome'
          Width = 280
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMAIL'
          Title.Caption = 'E-mail'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CEP'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CIDADE'
          Title.Caption = 'Cidade'
          Width = 230
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BAIRRO'
          Title.Caption = 'Bairro'
          Width = 230
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ENDERECO'
          Title.Caption = 'Endere'#231'o'
          Width = 300
          Visible = True
        end>
    end
  end
end
