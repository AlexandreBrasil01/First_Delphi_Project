inherited frmConsultaProduto: TfrmConsultaProduto
  Caption = 'Consulta de Produtos'
  ClientHeight = 606
  ExplicitHeight = 651
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
    Top = 566
    ExplicitTop = 566
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
    Height = 445
    ExplicitHeight = 445
    inherited grdConsulta: TDBGrid
      Height = 443
      Color = clWhite
      DataSource = dtmConexao.dtsProdutos
      DefaultDrawing = False
      GradientEndColor = clWhite
      ParentFont = False
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
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'REFERENCIA'
          Title.Caption = 'Refer'#234'ncia'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CUSTO'
          Title.Alignment = taRightJustify
          Title.Caption = 'Custo'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRECO'
          Title.Alignment = taRightJustify
          Title.Caption = 'Pre'#231'o'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALDO'
          Title.Alignment = taRightJustify
          Title.Caption = 'Saldo'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PESO'
          Title.Alignment = taRightJustify
          Title.Caption = 'Peso'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UNIDADE'
          Title.Alignment = taCenter
          Title.Caption = 'UN'
          Width = 40
          Visible = True
        end>
    end
  end
end
