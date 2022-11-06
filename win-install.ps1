$VimPlug = $HOME + '/vimfiles/autoload/plug.vim'
$UndoDir = $HOME + '/vimfiles/undodir'


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

Copy-Item -Force .vimrc $HOME/.vimrc
Copy-Item -Force ./utils/libxkbswitch*.dll $HOME/scoop/apps/vim/current
vim +'PlugInstall --sync' +qa
Write-Host 'Installation complete!'

