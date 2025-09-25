unit Horse.Documentation.OpenApi.License;

interface

uses
  System.JSON,
  System.Classes,
  System.SysUtils,
  Horse.Documentation.OpenApi.Ancestor,
  Horse.Documentation.OpenApi.Interfaces;

type
  TLicense = class(TOpenApiAncestor, ILicense)
  private
    [Weak]
    FParent: IInfo;
    FName: string;
    FIdentifier: string;
    FUrl: string;

    constructor Create(AParent: IInfo);
  public
    class function New(AParent: IInfo): ILicense; static;
    function ToJson: TJSONObject;

    function Name: string; overload;
    function Name(const AValue: string): ILicense; overload;
    function Identifier: string; overload;
    function Identifier(const AValue: string): ILicense; overload;
    function Url: string; overload;
    function Url(const AValue: string): ILicense; overload;
    function &End: IInfo;
  end;

implementation

{ TLicense }

function TLicense.&End: IInfo;
begin
  Result := FParent;
end;

function TLicense.Identifier: string;
begin
  Result := FIdentifier;
end;

function TLicense.Identifier(const AValue: string): ILicense;
begin
  Result := Self;
  FIdentifier := AValue;
end;

constructor TLicense.Create(AParent: IInfo);
begin
  inherited Create;
  FParent := AParent;
end;

function TLicense.Name(const AValue: string): ILicense;
begin
  Result := Self;
  FName := AValue;
end;

function TLicense.Name: string;
begin
  Result := FName;
end;

class function TLicense.New(AParent: IInfo): ILicense;
begin
  Result := TLicense.Create(AParent);
end;

function TLicense.ToJson: TJSONObject;
begin
  Result := inherited ToJson;

  if not FName.IsEmpty then
    Result.AddPair('name', FName);

  if not FIdentifier.IsEmpty then
    Result.AddPair('identifier', FIdentifier);

  if not FUrl.IsEmpty then
    Result.AddPair('url', FUrl);
end;

function TLicense.Url: string;
begin
  Result := FUrl;
end;

function TLicense.Url(const AValue: string): ILicense;
begin
  Result := Self;
  FUrl := AValue;
end;

end.

