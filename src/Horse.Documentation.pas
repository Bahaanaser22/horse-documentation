unit Horse.Documentation;

interface

uses
  Horse,
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  Horse.Documentation.Controller,
  Horse.Documentation.OpenApi.Root,
  Horse.Documentation.OpenApi.Types,
  Horse.Documentation.OpenApi.Interfaces;

const
  PATH_HTML = '/horse/doc/html';
  PATH_JSON = '/horse/doc/json';

type
  THorseDocumentationController = Horse.Documentation.Controller.THorseDocumentationController;
  TParameterLocation = Horse.Documentation.OpenApi.Types.TParameterLocation;
  TParameterStyle = Horse.Documentation.OpenApi.Types.TParameterStyle;
  TSecuritySchemeType = Horse.Documentation.OpenApi.Types.TSecuritySchemeType;
  TApiKeyLocation = Horse.Documentation.OpenApi.Types.TApiKeyLocation;

function HorseDocumentation: THorseCallback; overload;
function HorseDocumentation(APathHtml: String; APathJSON: string = ''): THorseCallback; overload;

var
  HorseDoc: IOpenApi;

implementation

function HorseDocumentation(APathHtml: String; APathJSON: string = ''): THorseCallback;
begin
  THorseDocumentationController.Registry(APathHtml, APathJSON);

  Result :=
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      try
        Next();
      finally
      end;
    end;
end;

function HorseDocumentation: THorseCallback;
begin
  Result := HorseDocumentation(PATH_HTML, PATH_JSON);
end;

initialization
  HorseDoc := TOpenApi.New;

end.
