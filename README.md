# TimeTable of Tokyo Metro Widgets Sample

<img width="500" src="https://github.com/user-attachments/assets/38777734-672c-486e-8221-effde184a67d">

This app is a sample app that calls  
the Tokyo Metro station timetable API and  
displays the data obtained in Widgets.

First, select a station in the iOS app and  
tap a button to save the timetable data in User Defaults.  
The App Groups function is used to make the saved data available to Widgets as well.

The Widgets are updated four times every 15 minutes,  
picking up the three closest time data for each time.

このアプリは東京メトロの駅の時刻表APIをコールして  
得られたデータを Widgets に表示するサンプルアプリです。

まず，iOSアプリ側で駅を選択してボタンをタップして  
時刻表データを User Defaults に保存します。  
App Groups の機能を用いて Widgets 側にも保存したデータを共有できるようにしてます。

15分おきに4回，各3つずつ近い時刻の時刻データをピックアップしてWidgetsを更新します。

## Time Table API for Tokyo Metro

An access token is required to obtain Tokyo Metro timetable data.  
An access token can be obtained by registering as a developer.  
See the link below.  

東京メトロの時刻表データの取得にはアクセストークンが必要です。  
アクセストークンは開発者登録をすることで取得可能です。  
下記のリンクを参照してください。  

[https://developer.odpt.org](https://developer.odpt.org)

## Sample GIF and Images

|Fetch and Save|Widgets|
|:--:|:--:|
|![24_q_mov_002](https://github.com/user-attachments/assets/1deb982c-bb0d-4564-881a-1a117fafebb4)|<img width="494" alt="011" src="https://github.com/user-attachments/assets/0dccab24-8f2c-449b-b58e-bc780db1e5a0" />|

## Environment

* Xcode 16
* iOS 16 and later
* SwiftUI

## Point of implementation

* How to use the App Groups
* Widget Extension

## Article

Qiita Advent Calendar 2024 "iOS" Day 21.  

**【iOS】東京メトロの駅時刻表を Widgets に表示させてみる**  
[https://qiita.com/MilanistaDev/items/0233e14274b2f492d114](https://qiita.com/MilanistaDev/items/0233e14274b2f492d114)


## Contact

Please feel free to contact us if you find a bug or have any feedback.  
Suggestions for adding functions and code corrections are also welcome.

```swift
let name = "Takuya Aso" 
let email = "milanista224" + "@" + "icloud.com"
let profession = "iOS Engineer"
let location = "Tokyo"
```
