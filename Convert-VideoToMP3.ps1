###########################
# .SYNOPSIS
# The Convert-VideoToMP3 function converts video file to MP3
# .DESCRIPTION
# The Convert-VideoToMP3 function uses ffmpeg.exe to convert given video file to MP3 file. 
# .EXAMPLE
# $songs | Save-YoutubeVideo -Out '.\songs' | Convert-VideoToMP3 -Out '.\songs'
# .INPUTS
# System.IO.FileInfo
#   You can put FileInfo object of a video that is going to be converted to MP3 
# System.String
#   You can put String containing name or full path of a of a video that is going to be converted to MP3
# .OUTPUTS
# System.String
#   Path to MP3 file convered from given video file
# .LINKS
# https://ffmpeg.org/
###########################
function Convert-VideoToMP3 {
    [cmdletbinding(DefaultParameterSetName='FileInfo')]
    Param(
        # Video file that is going to be converted
        [Parameter(ParameterSetName='FileInfo', mandatory = $true, ValueFromPipeline = $true, position = 0)]
        [Alias('F')]
        [System.IO.FileInfo] $File,
        # Video file that is going to be converted
        [Parameter(ParameterSetName='FilePath', mandatory = $true, ValueFromPipeline = $true, position = 0)]
        [Alias('Path', 'FP')]
        [string] $FilePath,
        # Output directory where to put mp3 files, ex. 'D:\music', 'my\secret\songs'
        [Parameter(position = 1)]
        [Alias('Out', 'O')]
        [string] $OutputDir = "\Output",
        # Directory where ffmpeg.exe is put, it is recommended to leave this default
        [Alias('FFDir')]
        [string] $ffmpegDir 
    )
    Begin {
        [string]$ModulePath = Split-Path $PSCmdlet.MyInvocation.MyCommand.Module.Path -Parent
        [string]$Dir = ''

        Write-Verbose "Checking if ffmpeg.exe exists..."
        if(Test-Path "$ffmpegDir\ffmpeg.exe"){
            $Dir = $ffmpegDir
        }
        elseif(Test-Path "$ModulePath\ffmpeg.exe"){
            $Dir = $ModulePath
        }
        else{
            Write-Error "ffmpeg.exe not found."
            Return 
        }
    }
    Process {
        Write-Verbose "Checking if the given video file exists..."
        [string]$VideoFullName = ''
        [string]$VideoName = ''
        switch($PSCmdlet.ParameterSetName){
            'FileInfo' {
                if(-not(Test-Path $File.FullName)){
                    Write-Error "Given file doesn't exist."
                    Return 
                }
                else {
                    $VideoFullName = $File.FullName
                    $VideoName = $File.BaseName
                }
            }
            'FilePath' {
                if(-not(Test-Path $FilePath)){
                    Write-Error "Given file doesn't exist."
                    Return 
                } 
                else {
                    $VideoFullName = $FilePath
                    $VideoName = [System.IO.Path]::GetFileNameWithoutExtension($FilePath)
                }
            }
        }

        Write-Verbose "Converting the file..."
        & "$Dir\ffmpeg.exe" -i $VideoFullName -acodec libmp3lame "$OutputDir\$VideoName.mp3"

        $mp3 = Get-ChildItem "$OutputDir\$VideoName.mp3" 
        Return (Get-FilePathIfExists  $mp3)
    }
}
