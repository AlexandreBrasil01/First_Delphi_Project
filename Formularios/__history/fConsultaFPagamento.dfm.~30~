inherited frmConsultaFPagamento: TfrmConsultaFPagamento
  Caption = 'Consulta Forma de Pagamentos'
  PixelsPerInch = 115
  TextHeight = 18
  inherited pnlPesquisa: TPanel
    inherited cbxFiltro: TComboBox
      ItemIndex = 0
      Text = 'Id'
      OnChange = cbxFiltroChange
      Items.Strings = (
        'Id'
        'Descri'#231#227'o')
    end
    inherited edtPesquisar: TEdit
      CharCase = ecUpperCase
      NumbersOnly = True
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
      DataSource = dtmConexao.dtsFPagamento
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
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TIPO'
          Title.Caption = 'Tipo'
          Width = 45
          Visible = True
        end>
    end
  end
end
