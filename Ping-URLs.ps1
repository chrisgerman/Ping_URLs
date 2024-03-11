# Specify the input file containing the list of URLs
$inputFile = "urls.txt"

# Specify the output CSV file
$outputFile = "ping_results.csv"

# Create an empty array to store the results
$results = @()

# Read URLs from the input file
$urls = Get-Content $inputFile

# Loop through each URL and ping it
foreach ($url in $urls) {
    try {
        # Ping the URL and capture the result
        $pingResult = Test-NetConnection -ComputerName $url

        # Create a custom object with the URL and IP address
        $result = [PSCustomObject]@{
            URL       = $url
            IPAddress = $pingResult.RemoteAddress.IPAddressToString
        }

        # Add the result to the array
        $results += $result
    }
    catch {
        # Handle any errors that occur during the ping
        Write-Warning "Error pinging $url- $($_.Exception.Message)"
    }
}

# Export the results to a CSV file
$results | Export-Csv -Path $outputFile -NoTypeInformation