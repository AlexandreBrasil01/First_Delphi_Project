inherited frmFiltroUsuario: TfrmFiltroUsuario
  Caption = 'Filtro de Usuario'
  ClientHeight = 290
  ClientWidth = 434
  ExplicitWidth = 452
  ExplicitHeight = 335
  PixelsPerInch = 115
  TextHeight = 18
  inherited pnlTitulo: TPanel
    Width = 434
    ExplicitWidth = 434
  end
  inherited Panel2: TPanel
    Width = 434
    Height = 210
    ExplicitWidth = 434
    ExplicitHeight = 210
    inherited cbxListaTodos: TCheckBox
      Width = 169
      Caption = 'Listar todos Usuarios'
      OnClick = cbxListaTodosClick
      OnEnter = cbxListaTodosEnter
      ExplicitWidth = 169
    end
    object rdgFiltro: TRadioGroup
      Left = 16
      Top = 45
      Width = 169
      Height = 105
      Caption = 'Ordenar por:'
      Items.Strings = (
        'C'#243'digo'
        'Nome'
        'Login'
        'N'#237'vel de Acesso')
      TabOrder = 1
    end
    object rdgBusca: TRadioGroup
      Left = 208
      Top = 45
      Width = 153
      Height = 105
      Caption = 'Buscar por:'
      Enabled = False
      Items.Strings = (
        'Nome'
        'Login'
        'N'#237'vel de Acesso')
      TabOrder = 2
      OnClick = rdgBuscaClick
    end
    object edtBusca: TEdit
      Left = 208
      Top = 6
      Width = 153
      Height = 26
      Enabled = False
      TabOrder = 3
    end
  end
  inherited pnlBotoes: TPanel
    Top = 250
    Width = 434
    ExplicitTop = 250
    ExplicitWidth = 434
    inherited btnVisualizar: TButton
      OnClick = btnVisualizarClick
    end
    inherited btnLimpar: TButton
      Left = 333
      OnClick = btnLimparClick
      ExplicitLeft = 333
    end
  end
end
