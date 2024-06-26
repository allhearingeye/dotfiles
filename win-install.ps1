$VimPlug = $HOME + '/vimfiles/autoload/plug.vim'
$UndoDir = $HOME + '/vimfiles/undodir'
$XLaunch = $HOME + '/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/config.xlaunch'


if (-not(Test-Path -Path $VimPlug -PathType Leaf))
{
    try
    {
        Write-Host 'Downloading vim-plug...'
        Invoke-WebRequest -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | New-Item $VimPlug -Force | Out-Null
        Write-Host 'Download complete!'
    } catch
    {
        $_.Exception
        Exit
    }
} else
{
    Write-Host 'Vim-plug exists'
}

if (-not(Test-Path -Path $UndoDir))
{
    New-Item -ItemType 'directory' -Path $UndoDir | Out-Null
}

Write-Host 'Installing...'

try {
    if (-not(winget list | grep VcXsrv)) {
        Write-Host 'Install VcXsrv: winget install marha.VcXsrv'
    }
} catch {
    $_.Exception
    Write-Host 'Install VcXsrv if not installed'
}

Copy-Item -Force config.xlaunch $XLaunch
Copy-Item -Force .wezterm.lua $HOME/.wezterm.lua
Copy-Item -Force .vimrc $HOME/.vimrc
Copy-Item -Force -Recurse .config/nvim $env:LOCALAPPDATA
vim +'PlugInstall --sync' +qa
Write-Host 'Installation complete!'

