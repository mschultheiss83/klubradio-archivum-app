## Install AndroidStudio + Flutter + CommandLineTools

### Step 1
- `winget install Google.AndroidStudio`

### Step 2
- dl: https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.35.4-stable.zip

### Step 3
- `winget install Microsoft.VisualStudio.2022.BuildTools --silent --override "--add Microsoft.VisualStudio.Workload.VCTools --includeRecommended"`

### Step 4
- `Expand-Archive -Path $env:USERPROFILE\Downloads\flutter_windows_3.35.4-stable.zip -Destination $env:USERPROFILE\dev\`

### Step 5
- Pfade anpassen
`ANDROID_HOME`	`%USERPROFILE%\AppData\Local\Android\Sdk`
`Path`	`%USERPROFILE%\dev\flutter\bin`

### Step 6
- CommandLineTools in AndroidStudio nach installieren 

### Step 7 (optional)
- Neustart
- 