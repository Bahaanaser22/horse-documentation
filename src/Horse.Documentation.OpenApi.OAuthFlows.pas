unit Horse.Documentation.OpenApi.OAuthFlows;

interface

uses
  System.JSON,
  System.Classes,
  System.TypInfo,
  System.SysUtils,
  System.Generics.Collections,
  Horse.Documentation.OpenApi.Types,
  Horse.Documentation.OpenApi.Ancestor,
  Horse.Documentation.OpenApi.Interfaces;

type
  TOAuthFlows = class(TOpenApiAncestor, IOAuthFlows)
  private
    [Weak]
    FParent: ISecurityScheme;
    FImplicit: IOAuthFlow;
    FPassword: IOAuthFlow;
    FClientCredentials: IOAuthFlow;
    FAuthorizationCode: IOAuthFlow;

    constructor Create(AParent: ISecurityScheme);
  public
    class function New(AParent: ISecurityScheme): IOAuthFlows; static;
    function ToJson: TJSONObject;

    function Implicit: IOAuthFlow;
    function Password: IOAuthFlow;
    function ClientCredentials: IOAuthFlow;
    function AuthorizationCode: IOAuthFlow;
    function &End: ISecurityScheme;
  end;

implementation

uses
  Horse.Documentation.OpenApi.OAuthFlow;

{ TOAuthFlows }

function TOAuthFlows.AuthorizationCode: IOAuthFlow;
begin
  if FAuthorizationCode = nil then
    FAuthorizationCode := TOAuthFlow.New(Self);
  Result := FAuthorizationCode;
end;

function TOAuthFlows.ClientCredentials: IOAuthFlow;
begin
  if FClientCredentials = nil then
    FClientCredentials := TOAuthFlow.New(Self);
  Result := FClientCredentials;
end;

constructor TOAuthFlows.Create(AParent: ISecurityScheme);
begin
  inherited Create;
  FParent := AParent;
end;

function TOAuthFlows.&End: ISecurityScheme;
begin
  Result := FParent;
end;

function TOAuthFlows.Implicit: IOAuthFlow;
begin
  if FImplicit = nil then
    FImplicit := TOAuthFlow.New(Self);
  Result := FImplicit;
end;

class function TOAuthFlows.New(AParent: ISecurityScheme): IOAuthFlows;
begin
  Result := TOAuthFlows.Create(AParent);
end;

function TOAuthFlows.Password: IOAuthFlow;
begin
  if FPassword = nil then
    FPassword := TOAuthFlow.New(Self);
  Result := FPassword;
end;

function TOAuthFlows.ToJson: TJSONObject;
begin
  Result := inherited ToJson;

  if FImplicit <> nil then
    Result.AddPair('implicit', FImplicit.ToJson);

  if FPassword <> nil then
    Result.AddPair('password', FPassword.ToJson);

  if FClientCredentials <> nil then
    Result.AddPair('clientCredentials', FClientCredentials.ToJson);

  if FAuthorizationCode <> nil then
    Result.AddPair('authorizationCode', FAuthorizationCode.ToJson);
end;

end.
