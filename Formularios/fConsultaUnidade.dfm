inherited frmConsultaUnidade: TfrmConsultaUnidade
  Caption = 'Consulta de Unidades'
  PixelsPerInch = 115
  TextHeight = 18
  inherited pnlPesquisa: TPanel
    inherited cbxFiltro: TComboBox
      ItemIndex = 0
      Text = 'Id'
      OnChange = cbxFiltroChange
      Items.Strings = (
        'Id'
        'Unidade')
    end
    inherited edtPesquisar: TEdit
      Left = 185
      CharCase = ecUpperCase
      NumbersOnly = True
      OnChange = edtPesquisarChange
      ExplicitLeft = 185
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
      DataSource = dtmConexao.dtsUnidade
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
          FieldName = 'DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UNIDADE'
          Title.Caption = 'Unidade'
          Width = 70
          Visible = True
        end>
    end
  end
end
