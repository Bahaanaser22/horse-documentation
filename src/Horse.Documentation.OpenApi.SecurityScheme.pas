unit Horse.Documentation.OpenApi.SecurityScheme;

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
  TSecurityScheme = class(TOpenApiAncestor, ISecurityScheme)
  private
    [Weak]
    FParent: IComponents;
    FType: TSecuritySchemeType;
    FDescription: string;
    FName: string;
    FIn: TApiKeyLocation;
    FScheme: string;
    FBearerFormat: string;
    FFlows: IOAuthFlows;
    FOpenIdConnectUrl: string;

    constructor Create(AParent: IComponents);
  public
    class function New(AParent: IComponents): ISecurityScheme; static;
    function ToJson: TJSONObject;

    function &Type: TSecuritySchemeType; overload;
    function &Type(const AValue: TSecuritySchemeType): ISecurityScheme; overload;
    function Description: string; overload;
    function Description(const AValue: string): ISecurityScheme; overload;
    function Name: string; overload;
    function Name(const AValue: string): ISecurityScheme; overload;
    function &In: TApiKeyLocation; overload;
    function &In(const AValue: TApiKeyLocation): ISecurityScheme; overload;
    function Scheme: string; overload;
    function Scheme(const AValue: string): ISecurityScheme; overload;
    function BearerFormat: string; overload;
    function BearerFormat(const AValue: string): ISecurityScheme; overload;
    function Flows: IOAuthFlows;
    function OpenIdConnectUrl: string; overload;
    function OpenIdConnectUrl(const AValue: string): ISecurityScheme; overload;
    function &End: IComponents;
  end;

implementation

uses
  Horse.Documentation.OpenApi.OAuthFlows;

{ TSecurityScheme }

function TSecurityScheme.BearerFormat(const AValue: string): ISecurityScheme;
begin
  Result := Self;
  FBearerFormat := AValue;
end;

function TSecurityScheme.BearerFormat: string;
begin
  Result := FBearerFormat
end;

function TSecurityScheme.&In: TApiKeyLocation;
begin
  Result := FIn;
end;

function TSecurityScheme.&In(const AValue: TApiKeyLocation): ISecurityScheme;
begin
  Result := Self;
  FIn := AValue;
end;

function TSecurityScheme.&Type: TSecuritySchemeType;
begin
  Result := FType;
end;

function TSecurityScheme.&Type(const AValue: TSecuritySchemeType): ISecurityScheme;
begin
  Result := Self;
  FType := AValue;
end;

constructor TSecurityScheme.Create(AParent: IComponents);
begin
  inherited Create;
  FParent := AParent;
end;

function TSecurityScheme.Description: string;
begin
  Result := FDescription;
end;

function TSecurityScheme.Description(const AValue: string): ISecurityScheme;
begin
  Result := Self;
  FDescription := AValue;
end;

function TSecurityScheme.&End: IComponents;
begin
  Result := FParent;
end;

function TSecurityScheme.Flows: IOAuthFlows;
begin
  if FFlows = nil then
    FFlows := TOAuthFlows.New(Self);
  Result := FFlows;
end;

function TSecurityScheme.Name(const AValue: string): ISecurityScheme;
begin
  Result := Self;
  FName := AValue;
end;

function TSecurityScheme.Name: string;
begin
  Result := FName;
end;

class function TSecurityScheme.New(AParent: IComponents): ISecurityScheme;
begin
  Result := TSecurityScheme.Create(AParent);
end;

function TSecurityScheme.OpenIdConnectUrl(const AValue: string): ISecurityScheme;
begin
  Result := Self;
  FOpenIdConnectUrl := AValue;
end;

function TSecurityScheme.OpenIdConnectUrl: string;
begin
  Result := FOpenIdConnectUrl;
end;

function TSecurityScheme.Scheme: string;
begin
  Result := FScheme;
end;

function TSecurityScheme.Scheme(const AValue: string): ISecurityScheme;
begin
   Result := Self;
   FScheme := AValue;
end;

function TSecurityScheme.ToJson: TJSONObject;
begin
  Result := inherited ToJson;

  Result.AddPair('type', FType.ToString);
  if not FDescription.IsEmpty then
    Result.AddPair('description', FDescription);

  case FType of
    sstApiKey:
      Result.AddPair('name', FName)
        .AddPair('in', FIn.ToString);
    sstHttp:
      begin
        Result.AddPair('scheme', FScheme);
        if not FBearerFormat.IsEmpty then
          Result.AddPair('bearerFormat', FBearerFormat);
      end;
    sstOAuth2:
      begin
        if FFlows <> nil then
          Result.AddPair('flows', FFlows.ToJson);
      end;
    sstOpenIdConnect:
      Result.AddPair('openIdConnectUrl', FOpenIdConnectUrl);
  end;
end;

end.
