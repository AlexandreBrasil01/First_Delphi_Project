unit uUsuario;

interface

uses
  FireDAC.Comp.Client,
  dconexao,
  Vcl.Dialogs,
  System.SysUtils,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.ExtCtrls,
  RLReport,
  uHelpersImagensBase64,
  uHelpersrlImagensBase64;

type
  TUsuario = class
  private
    FID: integer;
    FNIVELACESSO: integer;
    FNOME: String;
    FLOGIN: String;
    FSENHA: String;
    FEMAIL: String;
    FFOTO: String;

    class var FObjetoBusca: TUsuario;
  public
    NAcessoLogin: integer;

    destructor Destroy; override;
    procedure Inicializar;
    procedure Carrega;
    procedure Incluir(pEfetuarCommit: boolean);
    procedure Alterar(pEfetuarCommit: boolean);
    procedure Excluir(pEfetuarCommit: boolean);
    procedure CarregaImagem(pImagem: TImage);
    procedure CarregaRLImagem(pImagem: TRLImage);

    function VerificaUnique(pColuna, pDado: String): boolean;

    constructor Create;
    class property ObjetoBusca: TUsuario read FObjetoBusca write FObjetoBusca;
    class function GeraProximoID: integer;

    property ID: integer read FID write FID;
    property NIVELACESSO: integer read FNIVELACESSO write FNIVELACESSO;
    property NOME: string read FNOME write FNOME;
    property LOGIN: string read FLOGIN write FLOGIN;
    property SENHA: string read FSENHA write FSENHA;
    property EMAIL: string read FEMAIL write FEMAIL;
    property FOTO: string read FFOTO write FFOTO;

  end;

implementation

{ TClassDefault }

procedure TUsuario.Carrega;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.close;
    lQuery.SQL.clear;
    lQuery.SQL.Add(' SELECT * FROM USUARIO ');
    lQuery.SQL.Add(' WHERE ID = :ID        ');
    lQuery.ParamByName('ID').AsInteger := FID;
    lQuery.Open;

    if lQuery.RecordCount > 0 then
    begin
      FID := lQuery.FieldByName('ID').AsInteger;
      FNOME := lQuery.FieldByName('NOME').AsString;
      FLOGIN := lQuery.FieldByName('LOGIN').AsString;
      FSENHA := lQuery.FieldByName('SENHA').AsString;
      FEMAIL := lQuery.FieldByName('EMAIL').AsString;
      FNIVELACESSO := lQuery.FieldByName('NIVELACESSO').AsInteger;
      FFOTO := lQuery.FieldByName('FOTO').AsString;
    end;
  finally
    lQuery.Free;
  end;
end;

procedure TUsuario.CarregaImagem(pImagem: TImage);
begin
  // Chamar sempre APÓS CARREGAR A CLASSE.
  pImagem.Picture := nil;

  if trim(FFOTO) <> emptystr then
  begin
    pImagem.Base64(FFOTO);
  End
  Else
  Begin
    // tratar aqui como nao encontrado
  End;
end;

procedure TUsuario.CarregaRLImagem(pImagem: TRLImage);
begin
  // Chamar sempre APÓS CARREGAR A CLASSE.
  pImagem.Picture := nil;

  if trim(FFOTO) <> emptystr then
  begin
    pImagem.Base64(FFOTO);
  end
  else
  begin
    // Tratar aqui como nao encontrado
  end;

end;

class function TUsuario.GeraProximoID: integer;
var
  lQuery: TFDQuery;
begin
  // Criei Class Function para não precisar estanciar a classe usuario.
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.close;
    lQuery.SQL.clear;
    lQuery.SQL.Add(' select gen_id(gen_usuario_id, 0) codigo from USUARIO ');
    lQuery.Open;

    result := lQuery.FieldByName('codigo').AsInteger + 1;

  finally
    lQuery.Free;
  end;
end;

function TUsuario.VerificaUnique(pColuna, pDado: string): boolean;
// if recordCount > 1 nao deixar registar usuario novo baseado no login e email
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.close;
    lQuery.SQL.clear;
    lQuery.SQL.Add(' SELECT * FROM USUARIO ');
    lQuery.SQL.Add(' WHERE ' + pColuna + '= ' + QuotedStr(pDado));
    lQuery.Open;

    VerificaUnique := lQuery.RecordCount > 0;

  finally
    lQuery.Free;
  end;
end;

procedure TUsuario.Incluir(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.close;
    lQuery.SQL.clear;
    lQuery.SQL.Add(' INSERT INTO USUARIO ( ');
    lQuery.SQL.Add('  NOME                 ');
    lQuery.SQL.Add(' ,LOGIN                ');
    lQuery.SQL.Add(' ,SENHA                ');
    lQuery.SQL.Add(' ,NIVELACESSO          ');
    lQuery.SQL.Add(' ,EMAIL                ');
    lQuery.SQL.Add(' ,FOTO                 ');
    lQuery.SQL.Add(' ,CORPERFIL            ');
    lQuery.SQL.Add(' )                     ');
    lQuery.SQL.Add('  VALUES (             ');
    lQuery.SQL.Add('  :NOME                ');
    lQuery.SQL.Add(' ,:LOGIN               ');
    lQuery.SQL.Add(' ,:SENHA               ');
    lQuery.SQL.Add(' ,:NIVELACESSO         ');
    lQuery.SQL.Add(' ,:EMAIL               ');
    lQuery.SQL.Add(' ,:FOTO                ');
    lQuery.SQL.Add(' ,:CORPERFIL           ');
    lQuery.SQL.Add(' )                     ');

    lQuery.ParamByName('NOME').AsString := FNOME;
    lQuery.ParamByName('LOGIN').AsString := FLOGIN;
    lQuery.ParamByName('SENHA').AsString := FSENHA;
    lQuery.ParamByName('NIVELACESSO').AsInteger := FNIVELACESSO;
    lQuery.ParamByName('EMAIL').AsString := FEMAIL;
    lQuery.ParamByName('FOTO').AsString := FFOTO;
    lQuery.ParamByName('CORPERFIL').AsString := 'clTeal';

    // execute sql é quando ha alteração na tabela
    lQuery.ExecSQL;

    if pEfetuarCommit = true then
    begin
      dtmConexao.FDConnection.Commit;
    end;
  finally
    lQuery.Free;
  end;
end;

procedure TUsuario.Alterar(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.close;
    lQuery.SQL.clear;
    lQuery.SQL.Add(' UPDATE USUARIO SET           ');
    lQuery.SQL.Add('  NOME = :NOME                ');
    lQuery.SQL.Add(' ,LOGIN = :LOGIN              ');
    lQuery.SQL.Add(' ,SENHA = :SENHA              ');
    lQuery.SQL.Add(' ,NIVELACESSO = :NIVELACESSO  ');
    lQuery.SQL.Add(' ,EMAIL = :EMAIL              ');
    lQuery.SQL.Add(' ,FOTO = :FOTO                ');
    lQuery.SQL.Add(' WHERE ID = :ID               ');

    lQuery.ParamByName('ID').AsInteger := FID;
    lQuery.ParamByName('NOME').AsString := FNOME;
    lQuery.ParamByName('LOGIN').AsString := FLOGIN;
    lQuery.ParamByName('SENHA').AsString := FSENHA;
    lQuery.ParamByName('NIVELACESSO').AsInteger := FNIVELACESSO;
    lQuery.ParamByName('EMAIL').AsString := FEMAIL;
    lQuery.ParamByName('FOTO').AsString := FFOTO;
    lQuery.ExecSQL;

    if pEfetuarCommit = true then
    begin
      dtmConexao.FDConnection.Commit;
    end;
  finally
    lQuery.Free;
  end;
end;

procedure TUsuario.Excluir(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    if (MessageDlg('Confirma a Exclusão do Usuario: ' + FID.ToString + '-' +
      FNOME + ' ?', mtInformation, [mbyes, mbno], 0) = mryes) then
    begin
      lQuery.Connection := dtmConexao.FDConnection;
      lQuery.close;
      lQuery.SQL.clear;
      lQuery.SQL.Add(' DELETE FROM USUARIO ');
      lQuery.SQL.Add(' WHERE ID = :ID      ');
      lQuery.ParamByName('ID').AsInteger := FID;
      lQuery.ExecSQL;

      if pEfetuarCommit = true then
      begin
        dtmConexao.FDConnection.Commit;
      end;
    end;
  except
    begin
      MessageDlg('Problema na Exclusão do Usuario da O.S. ' +
        'Favor tentar mais tarde e conferir rotina !!!', mtError, [mbOK], 0);
    end;
    Screen.Cursor := crDefault;
  end;
end;

procedure TUsuario.Inicializar;
begin
  FID := 0;
  FNIVELACESSO := 0;
  FNOME := emptystr;
  FLOGIN := emptystr;
  FSENHA := emptystr;
  FEMAIL := emptystr;
  FFOTO := emptystr;
end;

constructor TUsuario.Create;
begin
  Inicializar;
end;

destructor TUsuario.Destroy;
begin
  inherited;
end;

end.
