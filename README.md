# Enhanced HaishinKit (formerly lf)
[![Platform](https://img.shields.io/cocoapods/p/lf.svg?style=flat)](http://cocoapods.org/pods/lf)
![Language](https://img.shields.io/badge/language-Swift%203.1-orange.svg)
[![CocoaPods](https://img.shields.io/cocoapods/v/lf.svg?style=flat)](http://cocoapods.org/pods/lf)
[![GitHub license](https://img.shields.io/badge/license-New%20BSD-blue.svg)](https://raw.githubusercontent.com/shogo4405/lf.swift/master/LICENSE.txt)

Camera and Microphone streaming library via external HLS server for iOS, macOS, tvOS.

## Features

### HLS
- [x] HTTPService
- [x] HLS Publish
- [x] via external HLS server

### Others
- [ ] _Support tvOS 10.2+  (Technical Preview)_
  - tvOS can't publish Camera and Microphone. Available playback feature.
- [x] Hardware acceleration for H264 video encoding, AAC audio encoding
- [x] Support "Allow app extension API only" option
- [x] Support GPUImage framework (~> 0.5.12)
  - https://github.com/shogo4405/GPUHaishinKit.swift/blob/master/README.md
- [ ] ~~Objectiv-C Bridging~~

## Requirements
|-|iOS|OSX|tvOS|XCode|Swift|CocoaPods|Carthage|
|:----:|:----:|:----:|:----:|:----:|:----:|:----:|:----:|
|0.7.0|8.0+|10.11+|10.2+|8.3+|3.1|1.2.0|0.20.0+|
|0.6.0|8.0+|10.11+|-|8.3+|3.1|1.2.0|0.20.0+|
|0.5.0|8.0+|10.11+|-|8.0+|3.0|1.1.0|0.17.2(0.5.5+)|
|0.4.0|8.0+|10.11+|-|7.3+|2.3|1.0.0|0.17.2(0.4.4+)|

## Cocoa Keys
iOS10.0+
* NSMicrophoneUsageDescription
* NSCameraUsageDescription
* NSPhotoLibraryUsageDescription

## Installation
TBD

## License
New BSD

## HTTP Usage
HTTP Live Streaming (HLS). Your iPhone/Mac become a IP Camera. Basic snipet. You can see http://ip.address:8080/hello/playlist.m3u8 
```swift
var httpStream:HTTPStream = HTTPStream()
httpStream.attachCamera(DeviceUtil.device(withPosition: .back))
httpStream.attachAudio(AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio))
httpStream.publish("hello")

var lfView:LFView = LFView(frame: view.bounds)
lfView.attachStream(httpStream)

var httpService:HLSService = HLSService(domain: "", type: "_http._tcp", name: "lf", port: 8080)
httpService.startRunning()
httpService.addHTTPStream(httpStream)

// add ViewController#view
view.addSubview(lfView)
```

## Reference
* Haishin kit(original) thx for shogo4405
  * https://github.com/shogo4405/lf.swift
  * please Donate him (Bitcoin : 1HtWpaYkRGZMnq253QsJP6xSKZRPoJ8Hrs)
* Adobe’s Real Time Messaging Protocol
  * http://www.adobe.com/content/dam/Adobe/en/devnet/rtmp/pdf/rtmp_specification_1.0.pdf
* Action Message Format -- AMF 0
  * http://wwwimages.adobe.com/content/dam/Adobe/en/devnet/amf/pdf/amf0-file-format-specification.pdf
* Action Message Format -- AMF 3 
  * http://wwwimages.adobe.com/www.adobe.com/content/dam/Adobe/en/devnet/amf/pdf/amf-file-format-spec.pdf
* Video File Format Specification Version 10
  * https://www.adobe.com/content/dam/Adobe/en/devnet/flv/pdfs/video_file_format_spec_v10.pdf
* Adobe Flash Video File Format Specification Version 10.1
  * http://download.macromedia.com/f4v/video_file_format_spec_v10_1.pdf

