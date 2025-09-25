unit Horse.Documentation.OpenApi.Contact;

interface

uses
  System.JSON,
  System.Classes,
  System.SysUtils,
  Horse.Documentation.OpenApi.Ancestor,
  Horse.Documentation.OpenApi.Interfaces;

type
  TContact = class(TOpenApiAncestor, IContact)
  private
    [Weak]
    FParent: IInfo;
    FName: string;
    FUrl: string;
    FEmail: string;

    constructor Create(AParent: IInfo);
  public
    class function New(AParent: IInfo): IContact; static;
    function ToJson: TJSONObject;

    function Name: string; overload;
    function Name(const AValue: string): IContact; overload;
    function Url: string; overload;
    function Url(const AValue: string): IContact; overload;
    function Email: string; overload;
    function Email(const AValue: string): IContact; overload;
    function &End: IInfo;
  end;

implementation

{ TContact }

function TContact.Email: string;
begin
  Result := FEmail;
end;

function TContact.Email(const AValue: string): IContact;
begin
  Result := Self;
  FEmail := AValue;
end;

function TContact.&End: IInfo;
begin
  Result := FParent;
end;

constructor TContact.Create(AParent: IInfo);
begin
  inherited Create;
  FParent := AParent;
end;

function TContact.Name(const AValue: string): IContact;
begin
  Result := Self;
  FName := AValue;
end;

function TContact.Name: string;
begin
  Result := FName;
end;

class function TContact.New(AParent: IInfo): IContact;
begin
  Result := TContact.Create(AParent);
end;

function TContact.ToJson: TJSONObject;
begin
  Result := inherited ToJson;

  if not FName.IsEmpty then
    Result.AddPair('name', FName);

  if not FUrl.IsEmpty then
    Result.AddPair('url', FUrl);

  if not FEmail.IsEmpty then
    Result.AddPair('email', FEmail);
end;

function TContact.Url: string;
begin
  Result := FUrl;
end;

function TContact.Url(const AValue: string): IContact;
begin
  Result := Self;
  FUrl := AValue;
end;

end.

