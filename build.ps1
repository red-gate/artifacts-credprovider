while(Test-Path $PSScriptRoot/.output) {
    Write-Verbose "Attempting to delete $PSScriptRoot/.output" -verbose
    Remove-Item $PSScriptRoot/.output -Force -Recurse -ErrorAction 0
}
New-Item $PSScriptRoot/.output -ItemType Directory

# Build Microsoft.NuGet.CredentialProvider.zip
dotnet build CredentialProvider.Microsoft/CredentialProvider.Microsoft.csproj --configuration Release --output .output/Microsoft.NuGet.CredentialProvider/plugins/netfx/CredentialProvider.Microsoft
dotnet publish CredentialProvider.Microsoft/CredentialProvider.Microsoft.csproj --framework netcoreapp2.1 --configuration Release --output .output/Microsoft.NuGet.CredentialProvider/plugins/netcore/CredentialProvider.Microsoft
Compress-Archive -Path .output/Microsoft.NuGet.CredentialProvider/*  -DestinationPath .output/Microsoft.NuGet.CredentialProvider.zip

# Build Microsoft.NetCore2.NuGet.CredentialProvider.zip
dotnet publish CredentialProvider.Microsoft/CredentialProvider.Microsoft.csproj --framework netcoreapp2.1 --configuration Release --output .output/Microsoft.NetCore2.NuGet.CredentialProvider/plugins/netcore/CredentialProvider.Microsoft
Compress-Archive -Path .output/Microsoft.NetCore2.NuGet.CredentialProvider/*  -DestinationPath .output/Microsoft.NetCore2.NuGet.CredentialProvider.zip
