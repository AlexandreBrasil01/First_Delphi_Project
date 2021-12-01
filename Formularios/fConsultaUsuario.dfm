inherited frmConsultaUsuario: TfrmConsultaUsuario
  Caption = 'Consulta de Usu'#225'rios'
  ClientHeight = 524
  ClientWidth = 841
  ExplicitWidth = 859
  ExplicitHeight = 569
  PixelsPerInch = 115
  TextHeight = 18
  inherited pnlPesquisa: TPanel
    Width = 841
    ParentFont = False
    ExplicitWidth = 841
    inherited cbxFiltro: TComboBox
      Height = 26
      Font.Name = 'Arial'
      ItemIndex = 0
      Text = 'Id'
      OnChange = cbxFiltroChange
      Items.Strings = (
        'Id'
        'N'#237'vel de Acesso'
        'Nome'
        'Login'
        'E-mail')
      ExplicitHeight = 26
    end
    inherited edtPesquisar: TEdit
      Left = 189
      Height = 26
      CharCase = ecUpperCase
      Font.Name = 'Arial'
      NumbersOnly = True
      OnChange = edtPesquisarChange
      ExplicitLeft = 189
      ExplicitHeight = 26
    end
  end
  inherited pnlBotoes: TPanel
    Top = 484
    Width = 841
    ExplicitTop = 484
    ExplicitWidth = 841
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
    Width = 841
    Height = 363
    ExplicitWidth = 841
    ExplicitHeight = 363
    inherited grdConsulta: TDBGrid
      Width = 839
      Height = 361
      DataSource = dtmConexao.dtsUsuarios
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
          FieldName = 'LOGIN'
          Title.Caption = 'Login'
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SENHA'
          Title.Caption = 'Senha'
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NIVELACESSO'
          Title.Caption = 'N'#237'vel de Acesso'
          Width = 135
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMAIL'
          Title.Caption = 'E-mail'
          Width = 300
          Visible = True
        end>
    end
  end
  inherited pnlTitulo: TPanel
    Width = 841
    ExplicitWidth = 841
  end
end
