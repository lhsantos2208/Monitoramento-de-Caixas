unit ULogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Data.FMTBcd, Data.DB, Data.SqlExpr,
  Data.DBXOracle, UVarUni;

type
  TFrmLogin = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    ECodOpe: TEdit;
    MESenha: TMaskEdit;
    BBLogin: TBitBtn;
    BBCancelar: TBitBtn;
    Label7: TLabel;
    Panel1: TPanel;
    Label3: TLabel;
    ILogo: TImage;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    SQLCLogin: TSQLConnection;
    SQLQLogin: TSQLQuery;
    procedure FormShow(Sender: TObject);
    procedure BBCancelarClick(Sender: TObject);
    procedure BBLoginClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

procedure TFrmLogin.FormShow(Sender: TObject);
begin
  SQLCLogin.Connected:= True;
end;

procedure TFrmLogin.BBLoginClick(Sender: TObject);
begin
  if ((ECodOpe.Text <> '') and (MESenha.Text <> '')) then
  begin
    SQLQLogin.Active:= False;
    SQLQLogin.SQL.Text:= 'SELECT NUMCAD, ' +
                         '       NOMOPE, ' +
                         '       USU_PODSAI, ' +
                         '       USU_PODENT ' +
                         '  FROM E906OPE ' +
                         ' WHERE NUMCAD     = :pNumCad' +
                         '   AND USU_SENOPE = :pSenOpe' +
                         '   AND SITOPE     = :pSitOpe';
    SQLQLogin.ParamByName('pNumCad').AsInteger:= StrToInt(ECodOpe.Text);
    SQLQLogin.ParamByName('pSenOpe').AsString:= MESenha.Text;
    SQLQLogin.ParamByName('pSitOpe').AsString:= 'A';
    SQLQLogin.ExecSQL();
    SQLQLogin.Active:= True;
    UVarUni.TClass.vnNumCad:= SQLQLogin.FieldByName('NUMCAD').AsInteger;
    UVarUni.TClass.vaNomOpe:= SQLQLogin.FieldByName('NOMOPE').AsString;
    UVarUni.TClass.vaPodSai:= SQLQLogin.FieldByName('USU_PODSAI').AsString;
    UVarUni.TClass.vaPodEnt:= SQLQLogin.FieldByName('USU_PODENT').AsString;
    if (UVarUni.TClass.vnNumCad <> 0) then
    begin
      FrmLogin.Close;
    end
    else
      ShowMessage('Operador não encontrado!');
  end
  else
    ShowMessage('Informe o Código do Operador e a Senha!');

end;

procedure TFrmLogin.BBCancelarClick(Sender: TObject);
begin
  SQLCLogin.Connected:= False;
  Application.Terminate;
end;

procedure TFrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SQLCLogin.Connected:= False;
end;

end.
