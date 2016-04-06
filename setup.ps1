if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
  [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
    Break
}

# Install Chocolatey
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

# Setup no BOM encoded UTF8
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($False)

# Set Chef Home for this script
$CHEFDIR='C:\chef\cookbooks'
$env:HOME = $env:USERPROFILE

# Install ChefDK
C:\ProgramData\chocolatey\bin\choco.exe install -y chefdk

# Add ChefDK to the path
$env:Path += ";C:\opscode\chefdk\bin"

# Write Out the Berksfile
[System.IO.File]::WriteAllLines($CHEFDIR + 'Berksfile','source 'https://supermarket.chef.io'', $Utf8NoBomEncoding)
[System.IO.File]::AppendAllText($CHEFDIR + 'Berksfile','cookbook "bootstrap_windows", git: 'https://github.com/TheFynx/bootstrap-windows.git'' + ([Environment]::NewLine), $Utf8NoBomEncoding)

# Create client.rb
[System.IO.File]::WriteAllLines($CHEFDIR + 'client.rb','cookbook_path File.join(Dir.pwd, 'berks-cookbooks')', $Utf8NoBomEncoding)

# Switch to Chef Home to vendor cookbooks
cd $CHEFDIR

$env:BERKSHELF_CHEF_CONFIG = "$CHEFDIR\client.rb"

# Vendor cookbook deps locally
berks vendor

# Run Chef!
chef-client -z -c "$CHEFDIR\client.rb" -o bootstrap_windows
