# anachrony

A Flash audio recorder with javascript hooks ... because apparently it's still 2008.

## Quickstart

### Get Volume Level

[Get Volume](https://mhotwagner.github.io/anachrony/examples/get-volume.html)

```html
<html>
    <body>
        <center>
            <div id="flashContainer"></div>
            <h1>ACTIVITY LEVEL: <span id="volume">NO MICROPHONE AVAILABLE</span></h1>
        </center>
    </body>
    <script src="https://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
    <script>
        flashVars = {};
        params = {allowScriptAccess: true};
        attrs = {id: 'flashRecorder'};
        swfobject.embedSWF(
            "assets/anachrony.swf",
            "flashContainer",
            "300",
            "300",
            "10.0.0",
            false,
            flashVars,
            params,
            attrs
        );

        function flashRecorderGetVolume(volume) {
            document.getElementById('volume').innerHTML = volume.toString() + '%';
        }
    </script>
</html>
```
