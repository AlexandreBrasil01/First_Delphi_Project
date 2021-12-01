object frmConsultaDefault: TfrmConsultaDefault
  Left = 0
  Top = 0
  Caption = 'frmConsultaDefault'
  ClientHeight = 582
  ClientWidth = 1006
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 115
  TextHeight = 18
  object pnlPesquisa: TPanel
    Left = 0
    Top = 41
    Width = 1006
    Height = 80
    Align = alTop
    TabOrder = 0
    object cbxFiltro: TComboBox
      Left = 14
      Top = 6
      Width = 145
      Height = 27
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Items.Strings = (
        '')
    end
    object edtPesquisar: TEdit
      Left = 181
      Top = 6
      Width = 145
      Height = 27
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 542
    Width = 1006
    Height = 40
    Align = alBottom
    Color = clTeal
    ParentBackground = False
    TabOrder = 1
    object btnAtualizar: TButton
      Left = 361
      Top = 1
      Width = 90
      Height = 38
      Align = alLeft
      Caption = 'Atualizar'
      TabOrder = 4
    end
    object btnIncluir: TButton
      Left = 1
      Top = 1
      Width = 90
      Height = 38
      Align = alLeft
      Caption = 'Incluir'
      TabOrder = 0
    end
    object btnAlterar: TButton
      Left = 91
      Top = 1
      Width = 90
      Height = 38
      Align = alLeft
      Caption = 'Alterar'
      TabOrder = 1
    end
    object btnSair: TButton
      Left = 541
      Top = 1
      Width = 90
      Height = 38
      Align = alLeft
      Caption = 'Sair'
      TabOrder = 6
    end
    object btnExcluir: TButton
      Left = 181
      Top = 1
      Width = 90
      Height = 38
      Align = alLeft
      Caption = 'Excluir'
      TabOrder = 2
    end
    object btnRelat: TButton
      Left = 451
      Top = 1
      Width = 90
      Height = 38
      Align = alLeft
      Caption = 'Relat'#243'rio'
      TabOrder = 5
      Visible = False
    end
    object btnVisualizar: TButton
      Left = 271
      Top = 1
      Width = 90
      Height = 38
      Align = alLeft
      Caption = 'Visualizar'
      TabOrder = 3
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 121
    Width = 1006
    Height = 421
    Align = alClient
    Caption = 'pnlGrid'
    TabOrder = 2
    object grdConsulta: TDBGrid
      Left = 1
      Top = 1
      Width = 1004
      Height = 419
      Align = alClient
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Arial'
      TitleFont.Style = []
      OnDrawColumnCell = grdConsultaDrawColumnCell
    end
  end
  object pnlTitulo: TPanel
    Left = 0
    Top = 0
    Width = 1006
    Height = 41
    Align = alTop
    Color = clTeal
    ParentBackground = False
    TabOrder = 3
  end
end
