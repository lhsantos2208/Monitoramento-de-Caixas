program PrjMonCai;

uses
  Vcl.Forms,
  UMonCai in 'UMonCai.pas' {FrmMonCai},
  ULogin in 'ULogin.pas' {FrmLogin},
  UVarUni in 'UVarUni.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  FrmLogin:= TFrmLogin.Create(nil);
  FrmLogin.ShowModal;
  Application.CreateForm(TFrmMonCai, FrmMonCai);
  FrmLogin.Hide;
  FrmLogin.Free;
  Application.Run;
end.
