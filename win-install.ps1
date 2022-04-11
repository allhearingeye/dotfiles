$VimPlug = $HOME + '/vimfiles/autoload/plug.vim'
$UndoDir = $HOME + '/vimfiles/undodir'


if (-not(Test-Path -Path $VimPlug -PathType Leaf)) {
    try {
        Write-Host 'Downloading vim-plug...'
        iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni $VimPlug -Force | Out-Null
        Write-Host 'Download complete!'
    } catch {
        $_.Exception
        Exit
    }
}
else {
    Write-Host 'Vim-plug exists'
}

if (-not(Test-Path -Path $UndoDir)) {
    New-Item -ItemType 'directory' -Path $UndoDir | Out-Null
}

Write-Host 'Installing...'

if (Test-Path -Path $HOME/*vimrc) {
    Remove-Item $HOME/*vimrc
}

New-Item -Path $HOME/.vimrc -ItemType HardLink -Value .vimrc | Out-Null
vim +'PlugInstall --sync' +qa
Write-Host 'Installation complete!'
