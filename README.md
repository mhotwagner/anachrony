# anachrony

A Flash audio recorder with javascript hooks ... because apparently it's still 2008.

## Quickstart

```
git clone git@github.com:mhotwagner/anachrony.git
open examples/get-volume.html
```

## API

### Update Status

[Update Status](https://mhotwagner.github.io/anachrony/examples/update-status.html)

```html
    <body>
        <center>
            <div id="flashContainer"></div>
            <h1>VOLUME: <span id="volume">MICROPHONE NOT ENABLED</span></h1>
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

        function flashRecorderUpdateStatus(data) {
            if (!data.muted) {
                document.getElementById('volume').innerHTML = data.volume.toString() + '%';
            }
        }
    </script>
```

### Record

[Record](https://mhotwagner.github.io/anachrony/examples/record.html)

```html
    <body>
        <center>
            <h1>STATUS: <span id="status">MICROPHONE NOT ENABLED</span></h1><br/>
            <audio id="audioPlayer" controls></audio><br/>
            <div id="flashContainer"></div>
        </center>
    </body>
    <script src="https://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
    <script>
        var flashRecorder;

        // Flash Callback Handlers
        function flashRecorderEnable() {
            flashRecorder.startRecording();
            setTimeout(flashRecorder.stopRecording, 5000);
        }
        function flashRecorderDisable() {
            alert('WARNING: Microphone access not granted');
            document.getElementById('status').innerHTML = 'MICROPHONE ACCESS DENIED';
        }
        function flashRecorderRecording(data) {
            document.getElementById('status').innerHTML = 'RECORDING [TIME: ' + data.time / 1000 + ' SECONDS, VOLUME: ' + data.volume + '%]'
        }
        function flashRecorderStopRecording(data) {
            document.getElementById('status').innerHTML = 'RECORDING COMPLETE';
            document.getElementById('audioPlayer').src = data.dataURL;
        }

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
            attrs,
            function (data) {
                flashRecorder = data.ref;
            }
        );
    </script>
```
