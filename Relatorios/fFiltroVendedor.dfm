inherited frmFiltroVendedor: TfrmFiltroVendedor
  Caption = 'Filtro de Vendedores'
  PixelsPerInch = 115
  TextHeight = 18
  inherited Panel2: TPanel
    inherited cbxListaTodos: TCheckBox
      Width = 186
      Caption = 'Lista todos Vendedores'
      OnClick = cbxListaTodosClick
      OnEnter = cbxListaTodosEnter
      ExplicitWidth = 186
    end
    object rdgFiltro: TRadioGroup
      Left = 16
      Top = 38
      Width = 186
      Height = 105
      Caption = 'Ordenar por:'
      Items.Strings = (
        'Nome'
        'E-Mail'
        'Cidade')
      TabOrder = 1
    end
    object rdgBusca: TRadioGroup
      Left = 216
      Top = 38
      Width = 161
      Height = 105
      Caption = 'Buscar por:'
      Enabled = False
      Items.Strings = (
        'Nome'
        'E-Mail'
        'Cidade')
      TabOrder = 3
    end
    object edtBusca: TEdit
      Left = 216
      Top = 6
      Width = 161
      Height = 26
      Enabled = False
      TabOrder = 2
    end
  end
  inherited pnlBotoes: TPanel
    inherited btnVisualizar: TButton
      OnClick = btnVisualizarClick
    end
    inherited btnLimpar: TButton
      OnClick = btnLimparClick
    end
  end
end
