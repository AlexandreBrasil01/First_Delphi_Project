unit uVendedor;

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
  uHelpersRLImagensBase64;

type
  TVendedor = class
  private
    FID: integer;
    FNOME: string;
    FEMAIL: string;
    FENDERECO: string;
    FBAIRRO: string;
    FCEP: string;
    FCIDADE: string;
    FFOTO: string;

    class var FObjetoBusca: TVendedor;
  public
    destructor Destroy; override;
    procedure Inicializar;
    procedure Carrega;
    procedure Incluir(pEfetuarCommit: boolean);
    procedure Alterar(pEfetuarCommit: boolean);
    procedure Excluir(pEfetuarCommit: boolean);
    procedure CarregaImagem(pImagem: TImage);
    procedure CarregaRLImagem(pImagem: TRLImage);

    constructor Create;
    class property ObjetoBusca: TVendedor read FObjetoBusca write FObjetoBusca;
    class function GeraProximoID: integer;
    class function Existe(pId: integer): boolean;

    property ID: integer read FID write FID;
    property NOME: string read FNOME write FNOME;
    property EMAIL: string read FEMAIL write FEMAIL;
    property ENDERECO: string read FENDERECO write FENDERECO;
    property BAIRRO: string read FBAIRRO write FBAIRRO;
    property CEP: string read FCEP write FCEP;
    property CIDADE: string read FCIDADE write FCIDADE;
    property FOTO: string read FFOTO write FFOTO;

  end;

implementation

{ TClassDefault }

procedure TVendedor.Carrega;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' SELECT * FROM VENDEDOR ');
    lQuery.SQL.Add(' WHERE ID = :ID         ');
    lQuery.ParamByName('ID').AsInteger := FID;
    lQuery.Open;

    if lQuery.RecordCount > 0 then
    begin
      FID := lQuery.FieldByName('ID').AsInteger;
      FNOME := lQuery.FieldByName('NOME').AsString;
      FEMAIL := lQuery.FieldByName('EMAIL').AsString;
      FENDERECO := lQuery.FieldByName('ENDERECO').AsString;
      FBAIRRO := lQuery.FieldByName('BAIRRO').AsString;
      FCEP := lQuery.FieldByName('CEP').AsString;
      FCIDADE := lQuery.FieldByName('CIDADE').AsString;
      FFOTO := lQuery.FieldByName('FOTO').AsString;
    end;
  finally
    lQuery.Free;
  end;
end;

class function TVendedor.Existe(pId: integer): boolean;
var
  lQuery: TFDQuery;
begin
  result := false;
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.SQL.Add('SELECT * FROM VENDEDOR WHERE ID = :ID');
    lQuery.ParamByName('ID').AsInteger := pId;
    lQuery.Open;

    if (lQuery.RecordCount > 0) then
    begin
      result := true;

      if not Assigned(FObjetoBusca) then
      begin
        FObjetoBusca := TVendedor.Create;
      end;

      FObjetoBusca.FID := pId;
      FObjetoBusca.Carrega;
    end;
  finally
    lQuery.Free;
  end;
end;

procedure TVendedor.CarregaImagem(pImagem: TImage);
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

procedure TVendedor.CarregaRLImagem(pImagem: TRLImage);
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

class function TVendedor.GeraProximoID: integer;
var
  lQuery: TFDQuery;
begin
  // Criei Class Function para não precisar estanciar a classe.
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' select gen_id(gen_vendedor_id, 0) codigo from vendedor ');
    lQuery.Open;

    result := lQuery.FieldByName('codigo').AsInteger + 1;

  finally
    lQuery.Free;
  end;
end;

procedure TVendedor.Incluir(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' INSERT INTO VENDEDOR ( ');
    lQuery.SQL.Add('  NOME                  ');
    lQuery.SQL.Add(' ,EMAIL                 ');
    lQuery.SQL.Add(' ,ENDERECO              ');
    lQuery.SQL.Add(' ,BAIRRO                ');
    lQuery.SQL.Add(' ,CEP                   ');
    lQuery.SQL.Add(' ,FOTO                  ');
    lQuery.SQL.Add(' ,CIDADE                ');
    lQuery.SQL.Add(' )                      ');
    lQuery.SQL.Add(' VALUES (               ');
    lQuery.SQL.Add('  :NOME                 ');
    lQuery.SQL.Add(' ,:EMAIL                ');
    lQuery.SQL.Add(' ,:ENDERECO             ');
    lQuery.SQL.Add(' ,:BAIRRO               ');
    lQuery.SQL.Add(' ,:CEP                  ');
    lQuery.SQL.Add(' ,:FOTO                 ');
    lQuery.SQL.Add(' ,:CIDADE               ');
    lQuery.SQL.Add(' )                      ');

    lQuery.ParamByName('NOME').AsString := FNOME;
    lQuery.ParamByName('EMAIL').AsString := FEMAIL;
    lQuery.ParamByName('ENDERECO').AsString := FENDERECO;
    lQuery.ParamByName('BAIRRO').AsString := FBAIRRO;
    lQuery.ParamByName('CEP').AsString := FCEP;
    lQuery.ParamByName('CIDADE').AsString := FCIDADE;
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

procedure TVendedor.Alterar(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' UPDATE VENDEDOR SET                       ');
    lQuery.SQL.Add('  NOME = :NOME                            ');
    lQuery.SQL.Add(' ,EMAIL = :EMAIL                          ');
    lQuery.SQL.Add(' ,CEP = :CEP                              ');
    lQuery.SQL.Add(' ,CIDADE = :CIDADE                        ');
    lQuery.SQL.Add(' ,BAIRRO = :BAIRRO                        ');
    lQuery.SQL.Add(' ,ENDERECO = :ENDERECO                    ');
    lQuery.SQL.Add(' ,FOTO = :FOTO                            ');
    lQuery.SQL.Add(' WHERE ID = :ID                           ');

    lQuery.ParamByName('ID').AsInteger := FID;
    lQuery.ParamByName('NOME').AsString := FNOME;
    lQuery.ParamByName('EMAIL').AsString := FEMAIL;
    lQuery.ParamByName('CEP').AsString := FCEP;
    lQuery.ParamByName('CIDADE').AsString := FCIDADE;
    lQuery.ParamByName('BAIRRO').AsString := FBAIRRO;
    lQuery.ParamByName('ENDERECO').AsString := FENDERECO;
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

procedure TVendedor.Excluir(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try

    if (MessageDlg('Confirma a Exclusão do Vendedor: ' + FID.ToString + '-' +
      FNOME + ' ?', mtInformation, [mbyes, mbno], 0) = mryes) then
    begin
      lQuery.Connection := dtmConexao.FDConnection;
      lQuery.Close;
      lQuery.SQL.Clear;
      lQuery.SQL.Add(' DELETE FROM VENDEDOR ');
      lQuery.SQL.Add(' WHERE ID = :ID ');
      lQuery.ParamByName('ID').AsInteger := FID;
      lQuery.ExecSQL;

      if pEfetuarCommit = true then
      begin
        dtmConexao.FDConnection.Commit;
      end;
    end;
  except
    begin
      MessageDlg('Problema na Exclusão do Vendedor da O.S. ' +
        'Favor tentar mais tarde e conferir rotina !!!', mtError, [mbOK], 0);
    end;
    Screen.Cursor := crDefault;
  end;
end;

procedure TVendedor.Inicializar;
begin
  FID := 0;
  FNOME := emptystr;
  FEMAIL := emptystr;
  FENDERECO := emptystr;
  FBAIRRO := emptystr;
  FCEP := emptystr;
  FCIDADE := emptystr;
  FFOTO := emptystr;
end;

constructor TVendedor.Create;
begin
  Inicializar;
end;

destructor TVendedor.Destroy;
begin
  inherited;
end;

end.
