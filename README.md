# log4factorio:
Slim mod for logging inspired by log4j (but with much less functionality 😉).

**This is intended as facility to be used in other mods - it doesn't add any feature to the played game.**

## Features
Offers the ability to add log statements which can be enabled/disabled by configuration at _run time_. 
It supports the following log levels (AKA severities)
*     FATAL 
    use for logging severe errors
*     ERROR 
    use for logging major errors
*     WARN  
    use for logging minor errors
*     INFO  
    use for logging informational messages
*     CONFIG
    use for logging informational messages concerning configuration
*     FINE  
    use for logging debug messages
*     FINER 
    use for logging more verbose debug messages
*     FINEST
    use for logging very verbose debug messages

**FATAL** is the highest, **FINEST** the lowest log level. Let's say log level is configured to INFO, then only all 
loggging calls with a level of INFO or higher (i.e. **FATAL**, **ERROR**, **WARN** and **INFO**) will be logged, all 
others will produce no log entries.


## Integration into other mods
1. include it with require

    `local Log = require("__log4factorio__.Log")`
1. set the desired log level, either 
   * from configuration
        
   `Log.setSeverityFromSettings("testmod1-logLevel")`
   * or hard coded
        
   `Log.setSeverity(Log.WARN)`
1. if using configuration add the appropiate entries to the locale files resp. to settings.lua

    ```
    [mod-setting-name]
    testmod1-logLevel=choose log level
    
    [mod-setting-description]
    testmod1-logLevel=all calls with this log level or higher will be logged (FATAL is the highest, FINEST the lowest level)
    ```

    resp.

    ```
    data:extend({
      {
        type = "string-setting",
        name = "testmod1-logLevel",
        order = "zz",
        setting_type = "runtime-global",
        default_value = "CONFIG",
        allowed_values = {
          "FATAL",
          "ERROR",
          "WARN",
          "INFO",
          "CONFIG",
          "FINE",
          "FINER",
          "FINEST",
        }
      },
    })
    ```
    ![settings](https://github.com/xyzzycgn/log4factorio/blob/main/settings.jpg?raw=true)

    For more details please have a look at https://wiki.factorio.com/Tutorial:Mod_settings#Locale

1. Log something

    `Log.log("sth happened", function(m)log(m)end, Log.INFO)`

    `Log.logLine( { ndx = ndx, wcid = wcid }, function(m)log(m)end, Log.FINE)`
    
    `Log.logBlock(data, function(m)log(m)end, Log.FINEST)`

That produces entries in factorio-current.log like

` 137.987 Script @__testMod1__/control.lua:16: [FINE] sth happened`

**Hint**: If you want to log to the factorio-current.log, use `function(m)log(m)end` instead of simply `log`. That offers 
the advantage that the logged line number is that from the call in the mod using log4factorio and not the line number 
from inside log4factorio, where log() is executed 😉.



