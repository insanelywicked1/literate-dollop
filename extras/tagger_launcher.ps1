$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$log = "C:\TaggerLogs\tagger_$timestamp.txt"
python C:\Scripts\nature_tagger.py *>&1 | Tee-Object -FilePath $log
