###########################
# .SYNOPSIS
# The Get-YoutubeDlDir function returns path to youtube-dl.exe
# .DESCRIPTION
# The Get-YoutubeDlDir function returns given path if youtube-dl.exe can be found there.
# If not it tries to find it module's main directory. If youtube-dl.exe is not found the
# function throws error.
# .EXAMPLE
# Get-YoutubeDlDir soft\video
# .INPUTS
# System.String
#   Directory where youtube-dl.exe is put
# .OUTPUTS
# System.String
#   Directory where youtube-dl.exe was found (two locations are tested, 
#   the given one and module's main directory)
###########################
function Get-YoutubeDlDir {
    [cmdletbinding()]
    Param(
        # Directory where youtube-dl.exe is put
        [Parameter(mandatory = $true, position = 0)]
        [Alias('YTDir')]
        [string] $YoutubeDownloaderDir 
    )
    [string]$ModulePath = Split-Path $PSCmdlet.MyInvocation.MyCommand.Module.Path -Parent
    [string]$Dir = ''
    Write-Verbose "Checking if youtube-dl.exe exists..."
    if(Test-Path "$YoutubeDownloaderDir\youtube-dl.exe"){
        $Dir = $YoutubeDownloaderDir
    }
    elseif(Test-Path "$ModulePath\youtube-dl.exe"){
        $Dir = $ModulePath
    }
    else{
        Write-Error "Youtube-dl.exe not found."
        Return 
    }
    Return $Dir
}
