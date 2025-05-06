# Flutter-Batoo-Maps-Demo

This is a public demo of the Baato App for Flutter. This app shows the way to integrate [Baato](http://baato.io/) map style in Flutter, using Baato API and features like location service, routing, markers, and camera.


### Running locally

#### 1. Setting the Baato access token
This demo app requires a Baato account and a Baato access token. Obtain your access token on the [Baato account page](http://baato.io/). Paste your access token in the line below in `main.dart` file .

```
await Baato.configure(apiKey: "your_api_keys");
```
Details `Flutter Baato Map` API Documentation on [Flutter Baato Maps](https://github.com/baato/flutter_baato_maps)