###########################
# .SYNOPSIS
# The Get-FilePathIfExists function checks if the given file exists and returns it path.
# .DESCRIPTION
# The Get-FilePathIfExists function returns the given file path if it exists or it returns
# $null if given file cannot be found. The information about the given file must be of 
# System.IO.FileInfo type to be returned. Any other type will be cause the function to return 
# $null.
# .EXAMPLE
# Get-FileIfNotNull $file
# .INPUTS
# System.IO.FileInfo
#  File that you want to check if it exists
# .OUTPUTS
# System.String
#  Given file path if exists or $null if not
###########################
function Get-FilePathIfExists {
    [cmdletbinding()]
    Param(
        # FileInfo object that will be returned if it exists
        [Alias('FileInfo', 'F')]
        [System.IO.FileInfo]$File         
    )
    if($file -ne $null -and $file.GetType().Name -eq 'FileInfo'){
        Return $file.FullName
    }
    else{
        Return $null
    }
}
