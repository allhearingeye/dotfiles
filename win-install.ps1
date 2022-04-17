$VimPlug = $HOME + '/vimfiles/autoload/plug.vim'
$UndoDir = $HOME + '/vimfiles/undodir'
$XLaunch = $HOME + '/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/config.xlaunch'


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

try {
    if (-not(winget list | grep VcXsrv)) {
        Write-Host 'Install VcXsrv: winget install marha.VcXsrv'
    }
} catch {
    $_.Exception
    Write-Host 'Install VcXsrv if not installed'
}

if (Test-Path -Path $XLaunch) {
    Remove-Item $XLaunch
    New-Item -Path $XLaunch -ItemType HardLink -Value config.xlaunch | Out-Null
}
else {
    New-Item -Path $XLaunch -ItemType HardLink -Value config.xlaunch | Out-Null
}

New-Item -Path $HOME/.vimrc -ItemType HardLink -Value .vimrc | Out-Null
vim +'PlugInstall --sync' +qa
Write-Host 'Installation complete!'
