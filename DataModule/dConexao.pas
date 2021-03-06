unit dConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Forms,
  Vcl.Dialogs;

type
  TdtmConexao = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    qryConsultaClientes: TFDQuery;
    dtsClientes: TDataSource;
    qryConsultaClientesID: TIntegerField;
    qryConsultaClientesNOME: TStringField;
    qryConsultaClientesCPF: TStringField;
    qryConsultaClientesEMAIL: TStringField;
    qryConsultaClientesCNPJ: TStringField;
    qryConsultaClientesFISICOOUJURIDICO: TStringField;
    qryConsultaClientesENDERECO: TStringField;
    qryConsultaClientesBAIRRO: TStringField;
    qryConsultaClientesCEP: TStringField;
    qryConsultaClientesCIDADE: TStringField;
    qryConsultaUsuarios: TFDQuery;
    qryConsultaUsuariosID: TIntegerField;
    qryConsultaUsuariosNOME: TStringField;
    qryConsultaUsuariosLOGIN: TStringField;
    qryConsultaUsuariosSENHA: TStringField;
    qryConsultaUsuariosNIVELACESSO: TIntegerField;
    qryConsultaUsuariosEMAIL: TStringField;
    dtsProdutos: TDataSource;
    qryConsultaProdutos: TFDQuery;
    qryConsultaUnidade: TFDQuery;
    dtsUnidade: TDataSource;
    qryConsultaUnidadeID: TIntegerField;
    qryConsultaUnidadeDESCRICAO: TStringField;
    qryConsultaUnidadeUNIDADE: TStringField;
    qryConsultaFPagamento: TFDQuery;
    dtsFPagamento: TDataSource;
    qryConsultaFPagamentoID: TIntegerField;
    qryConsultaFPagamentoDESCRICAO: TStringField;
    qryConsultaFPagamentoTIPO: TStringField;
    qryConsultaProdutosID: TIntegerField;
    qryConsultaProdutosFK_UNIDADE: TIntegerField;
    qryConsultaProdutosDESCRICAO: TStringField;
    qryConsultaProdutosREFERENCIA: TStringField;
    qryConsultaProdutosPRECO: TBCDField;
    qryConsultaProdutosCUSTO: TBCDField;
    qryConsultaProdutosSALDO: TBCDField;
    qryConsultaProdutosPESO: TBCDField;
    qryConsultaProdutosFOTO: TBlobField;
    qryConsultaProdutosUNIDADE: TStringField;
    qryConsultaVendedor: TFDQuery;
    dtsVendedor: TDataSource;
    qryConsultaVendedorID: TIntegerField;
    qryConsultaVendedorNOME: TStringField;
    qryConsultaVendedorEMAIL: TStringField;
    qryConsultaVendedorENDERECO: TStringField;
    qryConsultaVendedorBAIRRO: TStringField;
    qryConsultaVendedorCEP: TStringField;
    qryConsultaVendedorCIDADE: TStringField;
    qryConsultaVendedorFOTO: TBlobField;
    qryVenda: TFDQuery;
    dtsItens: TDataSource;
    tblConsultaItens: TFDMemTable;
    dtsVenda: TDataSource;
    tblConsultaItensFK_PRODUTO: TIntegerField;
    tblConsultaItensFK_VENDA: TIntegerField;
    tblConsultaItensEMISSAO: TDateField;
    tblConsultaItensVALOR: TFloatField;
    tblConsultaItensDESCONTO: TFloatField;
    tblConsultaItensQUANTIDADE: TFloatField;
    tblConsultaItensDESCRICAO: TStringField;
    tblConsultaItensTOTAL: TFloatField;
    qryVendaID: TIntegerField;
    qryVendaFK_CLIENTE: TIntegerField;
    qryVendaNOME: TStringField;
    qryVendaFK_VENDEDOR: TIntegerField;
    qryVendaNOME_1: TStringField;
    qryVendaFK_FORMAPAGAMENTO: TIntegerField;
    qryVendaDESCRICAO: TStringField;
    qryVendaOBS: TStringField;
    qryVendaDESCONTO: TCurrencyField;
    qryVendaTOTAL: TBCDField;
    qryVendaEMISSAO: TSQLTimeStampField;
    qryVendaDATA_VENCIMENTO: TSQLTimeStampField;
  private
    { Private declarations }
    function DevolveCaminhoBanco: String;
    function RetornaDiretorio: string;

  public
    { Public declarations }
    function ConectaBanco: boolean;

  end;

var
  dtmConexao: TdtmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TdtmConexao }

function TdtmConexao.ConectaBanco: boolean;
begin

  try
    FDConnection.Params.DriverID := 'FB';
    FDConnection.Params.Database := DevolveCaminhoBanco;
    FDConnection.Params.UserName := 'SYSDBA';
    FDConnection.Params.Password := 'masterkey';
    FDConnection.Connected := true;
    result := true;
  except
    on E: Exception do
    begin
      ShowMessage
        ('Problema ao conectar no banco de dados, favor chamar o alexandre.');
      result := false;
    end;
  end;

end;

function TdtmConexao.DevolveCaminhoBanco: String;
var
  lArquivoTxT: TextFile;
  lHost: string;
  lLocal: string;
  lCaminho, lTipo: string;
  ConfiguracaoINI: string;

begin
  ConfiguracaoINI := RetornaDiretorio + 'configuracao.ini';

  if FileExists(ConfiguracaoINI) then
  begin
    AssignFile(lArquivoTxT, ConfiguracaoINI);
    Reset(lArquivoTxT);
    Readln(lArquivoTxT, lHost);
    Readln(lArquivoTxT, lLocal);
    Readln(lArquivoTxT, lTipo);
    lHost := trim(Copy(lHost, 6, 100));
    lLocal := trim(Copy(lLocal, 7, 150));
    lTipo := trim(Copy(lTipo, 6, 15));

    CloseFile(lArquivoTxT);
    lCaminho := lHost + ':' + lLocal;

    result := lCaminho;
  end;

end;

function TdtmConexao.RetornaDiretorio: string;
var
  lDiretorio: string;

begin
  lDiretorio := ExtractFilePath(Application.exeName);
  if Copy(lDiretorio, Length(lDiretorio), 1) <> '\' then
  begin
    lDiretorio := lDiretorio + '\';
  end;

  result := lDiretorio;

end;

end.
