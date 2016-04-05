if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
  [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
    Break
}

$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($False)

$CHEFDIR='C:\chef\cookbooks'
$env:HOME = $env:USERPROFILE

C:\ProgramData\chocolatey\bin\choco.exe install -y chefdk

# Add ChefDK to the path
$env:Path += ";C:\opscode\chefdk\bin"

[System.IO.File]::WriteAllLines($CHEFDIR + 'Berksfile','source 'https://supermarket.chef.io'', $Utf8NoBomEncoding)
[System.IO.File]::AppendAllText($CHEFDIR + 'Berksfile','cookbook "bootstrap_linux", path:' + '"' + $PSCommandPath + '"' + ([Environment]::NewLine), $Utf8NoBomEncoding)

# Create client.rb
[System.IO.File]::WriteAllLines($CHEFDIR + 'client.rb','cookbook_path File.join(Dir.pwd, 'berks-cookbooks')', $Utf8NoBomEncoding)

cd $CHEFDIR

$env:BERKSHELF_CHEF_CONFIG = "$CHEFDIR\client.rb"

berks vendor

chef-client -z -c "$CHEFDIR\client.rb" -o bootstrap_windows
