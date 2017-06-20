###########################
# .SYNOPSIS
# The Save-YoutubeTextPlaylistAsMP3 function downloads youtube videos from given list and 
# converts them to MP3 music files.
# .DESCRIPTION
# The Save-YoutubeTextPlaylistAsMP3 function reads a text file and uses youtube-dl to download 
# each video URI that is put inside the file. Downloaded files are converted to MP3 format. It
# uses Save-YoutubeTextPlaylist and Convert-VideoToMP3 functions to  achive this goal. You can 
# pass a file path or a file info object to the function.
# .EXAMPLE
# Save-YoutubeTextPlaylistAsMP3 -Playlist songs\playlist.txt
# Save-YoutubeTextPlaylistAsMP3 -Playlist (ls songs\playlist.txt)
# .INPUTS
# System.String
#   A path of a file that contains a list of youtube video URI's
# System.IO.FileInfo
#   A file that contains a list of youtube video URI's
# .OUTPUTS
# System.IO.FileInfo[]
#   A list of music files that was downloaded and saved 
###########################
function Save-YoutubeTextPlaylistAsMP3 {
    [cmdletbinding(DefaultParameterSetName='FilePath')]
    Param(
        # File path that contains URI to youtube videos
        [Parameter(ParameterSetName='FilePath', position = 0, mandatory = $true)]
        [Alias('Path', 'PlaylistPath', 'P')]
        [string]$PlaylistFilePath,
        # File that contains URI to youtube videos
        [Parameter(ParameterSetName='FileInfo', position = 0, mandatory = $true)]
        [Alias('File', 'F')]
        [System.IO.FileInfo]$PlaylistFile,
        # Output directory where to put mp3 files, ex. 'D:\music', 'my\secret\songs'
        [Parameter(position = 1)]
        [Alias('Out', 'O')]
        [string] $OutputDir = "\Output",
        # Temporary output directory where youtube video files will be saved
        [Parameter(position = 2)]
        [Alias('TmpOut')]
        [string] $TmpOutputDir = "\TmpOutput"
    )
    [string]$file = ''
    switch($PSCmdlet.ParameterSetName){
        'FilePath'{
            $file = Get-FilePathIfExists (Get-ChildItem $PlaylistFilePath)
        }
        'FileInfo' {
            $file = Get-FileIfExists $PlaylistFile
        }
    }

    $musicFiles = @()
    if(-not [String]::IsNullOrEmpty($file)){
        Save-YoutubeTextPlaylist -File $file -OutputDir $TmpOutputDir
        Get-ChildItem $TmpOutputDir | ForEach-Object {
            $musicFile = Convert-VideoToMP3 -File $_ -OutputDir $OutputDir
            $musicFiles.Add($musicFile)
        }
        Return $musicFiles
    }
}
