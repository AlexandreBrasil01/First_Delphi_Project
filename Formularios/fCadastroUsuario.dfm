inherited frmCadastroUsuario: TfrmCadastroUsuario
  Caption = 'Cadastro de Usu'#225'rios'
  ClientHeight = 602
  ClientWidth = 680
  ExplicitWidth = 698
  ExplicitHeight = 647
  PixelsPerInch = 115
  TextHeight = 18
  inherited pnlTitulo: TPanel
    Width = 680
    ExplicitWidth = 680
  end
  inherited pnlCentral: TPanel
    Width = 680
    Height = 521
    ExplicitWidth = 680
    ExplicitHeight = 521
    object lblID: TLabel
      Left = 19
      Top = 8
      Width = 19
      Height = 18
      Caption = 'ID:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblNome: TLabel
      Left = 19
      Top = 72
      Width = 46
      Height = 18
      Caption = 'Nome:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblLogIn: TLabel
      Left = 19
      Top = 264
      Width = 43
      Height = 18
      Caption = 'Login:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblSenha: TLabel
      Left = 19
      Top = 328
      Width = 49
      Height = 18
      Caption = 'Senha:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblEmail: TLabel
      Left = 19
      Top = 136
      Width = 49
      Height = 18
      Caption = 'E-mail:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblNivelAceso: TLabel
      Left = 19
      Top = 200
      Width = 115
      Height = 18
      Caption = 'N'#237'vel de Acesso:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object edtID: TEdit
      Left = 19
      Top = 32
      Width = 60
      Height = 26
      TabStop = False
      Color = clGradientActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object edtNome: TEdit
      Left = 19
      Top = 96
      Width = 300
      Height = 26
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 1
    end
    object edtLogin: TEdit
      Left = 19
      Top = 288
      Width = 121
      Height = 26
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 4
    end
    object edtSenha: TEdit
      Left = 19
      Top = 352
      Width = 121
      Height = 26
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 5
    end
    object edtEmail: TEdit
      Left = 19
      Top = 160
      Width = 300
      Height = 26
      CharCase = ecUpperCase
      MaxLength = 60
      TabOrder = 2
    end
    object edtNivelAcesso: TEdit
      Left = 19
      Top = 224
      Width = 60
      Height = 26
      MaxLength = 1
      NumbersOnly = True
      TabOrder = 3
    end
    object pnlImagem: TPanel
      Left = 352
      Top = 32
      Width = 200
      Height = 230
      Color = clWhite
      ParentBackground = False
      TabOrder = 6
      object imgUsuario: TImage
        Left = 1
        Top = 1
        Width = 198
        Height = 228
        Align = alClient
        Center = True
        ExplicitLeft = 48
        ExplicitTop = 49
        ExplicitWidth = 105
        ExplicitHeight = 105
      end
    end
  end
  inherited pnlBotoes: TPanel
    Top = 562
    Width = 680
    ExplicitTop = 562
    ExplicitWidth = 680
    inherited btnSair: TButton
      OnClick = btnSairClick
    end
    inherited btnSalvar: TButton
      OnClick = btnSalvarClick
    end
  end
end
