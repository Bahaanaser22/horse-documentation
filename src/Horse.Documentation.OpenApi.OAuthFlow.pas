unit Horse.Documentation.OpenApi.OAuthFlow;

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
  TOAuthFlow = class(TOpenApiAncestor, IOAuthFlow)
  private
    [Weak]
    FParent: IOAuthFlows;
    FAuthorizationUrl: string;
    FTokenUrl: string;
    FRefreshUrl: string;
    FScopes: TOpenApiMap<string, IOAuthFlow>;

    constructor Create(AParent: IOAuthFlows);
  public
    class function New(AParent: IOAuthFlows): IOAuthFlow; static;
    function ToJson: TJSONObject;

    function AuthorizationUrl: string; overload;
    function AuthorizationUrl(const AValue: string): IOAuthFlow; overload;
    function TokenUrl: string; overload;
    function TokenUrl(const AValue: string): IOAuthFlow; overload;
    function RefreshUrl: string; overload;
    function RefreshUrl(const AValue: string): IOAuthFlow; overload;
    function Scopes: TOpenApiMap<string, IOAuthFlow>;
    function &End: IOAuthFlows;
  end;

implementation

{ TOAuthFlow }

function TOAuthFlow.AuthorizationUrl(const AValue: string): IOAuthFlow;
begin
  Result := Self;
  FAuthorizationUrl := AValue;
end;

function TOAuthFlow.AuthorizationUrl: string;
begin
  Result := FAuthorizationUrl;
end;

constructor TOAuthFlow.Create(AParent: IOAuthFlows);
begin
  inherited Create;
  FParent := AParent;
end;

function TOAuthFlow.&End: IOAuthFlows;
begin
  Result := FParent;
end;

class function TOAuthFlow.New(AParent: IOAuthFlows): IOAuthFlow;
begin
  Result := TOAuthFlow.Create(AParent);
end;

function TOAuthFlow.RefreshUrl: string;
begin
  Result := FRefreshUrl;
end;

function TOAuthFlow.RefreshUrl(const AValue: string): IOAuthFlow;
begin
  Result := Self;
  FRefreshUrl := AValue;
end;

function TOAuthFlow.Scopes: TOpenApiMap<string, IOAuthFlow>;
begin
  if FScopes = nil then
    FScopes := TOpenApiMap<string, IOAuthFlow>.Create(Self);
  Result := FScopes;
end;

function TOAuthFlow.ToJson: TJSONObject;
begin
  Result := inherited ToJson;

  if not FAuthorizationUrl.IsEmpty then
    Result.AddPair('authorizationUrl', FAuthorizationUrl);

  if not FTokenUrl.IsEmpty then
    Result.AddPair('tokenUrl', FTokenUrl);

  if not FRefreshUrl.IsEmpty then
    Result.AddPair('refreshUrl', FRefreshUrl);

  if (FScopes <> nil) and (FScopes.Count > 0) then
    Result.AddPair('scopes', FScopes.ToJson);
end;

function TOAuthFlow.TokenUrl: string;
begin
  Result := FTokenUrl;
end;

function TOAuthFlow.TokenUrl(const AValue: string): IOAuthFlow;
begin
  Result := Self;
  FTokenUrl := AValue;
end;

end.
