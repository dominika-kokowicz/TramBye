# TramBye
![alt text](https://i.ibb.co/9NCFzGP/Projekt-bez-tytu-u.png "TramBye Logo")


I am currently working on a TramBye application, which purpose is to show the current location of the trams in Warsaw.

## Features:
* User can select tram lines based on their preferences
* Location of the tram lines is being refreshed every 11 s
* To show the location of the trams I have used Annotation Views and Apple Maps
* A map is shown both in satellite and standard mode
* Tram lines to choose are saved in Collection View
* User location is visible if the user agrees
* In the project, I have used Warsaw Public Open Data (https://api.um.warszawa.pl)

## Get your API key

To get your own API key, please go to [https://api.um.warszawa.pl](https://api.um.warszawa.pl) to Logowanie tab and create a account.

After you obtain API key add a file to your project for e.g. APIkeys.swift and create let constant:

```swift
let apiKeyTram = "your_API_key"
```
