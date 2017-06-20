###########################
# .SYNOPSIS
# The Save-YoutubeTextPlaylist function downloads youtube playlist saved in a text file
# .DESCRIPTION
# The Save-YoutubeTextPlaylist function uses youtube-dl.exe program to download youtube videos from 
# given text file. Downloaded video file has the same name as the video on youtube. Remember, the
# function downloads all the links put in the given text files. To download just a single video from
# given URI use Save-YoutubeVideo function.
# It is a good idea to update youtube-dl.exe from time to time when it will throw unexpected errors.
# .EXAMPLE
# Save-YoutubeTextPlaylist music\myPlaylist.txt -O music\songs
# .INPUTS
# System.String
#   Path to a file that contains list of youtube video URI's (text playlist)
# .OUTPUTS
# System.Int32
#   Number of downloaded files
# .LINKS
# https://github.com/rg3/youtube-dl
###########################
function Save-YoutubeTextPlaylist {
    [cmdletbinding(DefaultParameterSetName='FilePath')]
    Param(
        # Youtube video URL 
        [Parameter(mandatory = $true, ValueFromPipeline = $true, position = 0)]
        [Alias('F')]
        [string] $File,
        # Output directory where to put downloaded video, ex. 'D:\videos', 'my\secret\vids'
        [Parameter(position = 1)]
        [Alias('Out', 'O')]
        [string] $OutputDir = "\Output",
        # Directory where youtube-dl.exe is put, it is recommended to leave this default
        [Alias('YTDir')]
        [string] $YoutubeDownloaderDir = "."
    )
    [string]$Dir = Get-YoutubeDlDir -YTDir $YoutubeDownloaderDir
    if(Test-Path $File){
        Write-Verbose "Downloading the video..."
        & "$Dir\youtube-dl.exe" --batch-file $File -o "$OutputDir\%(title)s.%(ext)s"
    }
    else {
        Write-Error "Given file doesn't exist."
        Return
    }
    Return (Get-ChildItem $OutputDir).Length
}
