![GitHubリリース](https://img.shields.io/github/release/evilc/autohotinterception.svg)
![GitHub全リリースのダウンロード数](https://img.shields.io/github/downloads/evilc/autohotinterception/total.svg)
[![Discord](https://img.shields.io/discord/330423308103319562.svg)](https://discord.gg/9d3DNN4)
![最新リリース以降のコミット数](https://img.shields.io/github/commits-since/evilc/autohotinterception/latest.svg)

# AutoHotInterception

AutoHotInterception（AHI）は、**特定のキーボードやマウスからの入力イベント**に応じて AutoHotkey のコードを実行できるライブラリです。必要に応じて、Windows がその入力イベントを受け取らないようにブロックすることもできます。

つまり、2台目、3台目、4台目などのキーボードのキーを使って AutoHotkey のコードを実行し、そのキー入力をアプリケーションに伝えないようにできます。同じキーでも、キーボードごとに異なる動作を割り当てられます。

たとえば、キーボードを3台接続している場合、1台目（メインキーボード）は通常どおり動作させ、2台目の `F1` は `a` に、3台目の `F1` は `b` に置き換える、といった設定が可能です。

キーボードのキー、マウスボタン、マウス移動（相対モード・絶対モード）に対応しています。

AutoHotkey v1 と AutoHotkey v2 の両方に対応しています。

AHI は Francisco Lopez 氏の Interception ドライバーを使用します。

# ヘルプを得る

- [AutoHotkey フォーラムの AHI ディスカッション](https://autohotkey.com/boards/viewtopic.php?f=6&t=45307)
- [Discord チャンネル](https://discord.gg/sFPMv86)

---

# 警告

**このコードの使用には十分注意してください。** Interception はドライバーとして Windows の低いレイヤーで動作します。そのため、入力をブロックすると、`Ctrl` + `Alt` + `Delete` などの操作までブロックされる可能性があります。すべての入力が使えなくなったり、復旧が難しくなったりするおそれがあります。

最悪の場合、PC のリセットが必要になることがあります。

たとえば、Subscription Mode で `block` を有効にすると、そのキーボード上の対象キーは完全にブロックされます。唯一のキーボードで `Ctrl` をブロックしてしまうと、`Ctrl` + `Alt` + `Delete` も使えなくなります。

**ブロック対象にしていない予備のキーボードやマウスを用意しておくことを強くおすすめします。**

スクリプトを Windows 起動時に自動実行する設定にも注意してください。Windows のセーフモードに入る方法や、起動時にスクリプトが実行されないようにする方法を把握しておきましょう。キーボード操作ができなくなった場合に備え、マウスを使ってタスクマネージャーを起動する方法なども確認してください。

大きな力には大きな責任が伴います。仕組みを十分理解できていない場合は、比較的安全な **Context Mode** の利用を検討してください。

---

# デバイス ID、VID、PID など

Interception は、各デバイスを **1～20 の番号**で識別します。

- デバイス ID 1～10：キーボード
- デバイス ID 11～20：マウス

この番号体系は Interception 独自のものです。デバイスを抜き差しするなどの操作によって、ID が変わる場合があります。

PC では、デバイスを Vendor ID（VID）と Product ID（PID）で識別できることがよくあります。これらは製造時にハードウェアに割り当てられ、同じメーカー・モデルのデバイス間では共通です。

AHI の多くの関数（キーの購読など）は Interception ID を使います。そのため、VID/PID から現在の Interception ID を調べるための便利な関数が用意されています。

デバイスの VID/PID が分からない場合や、Interception から認識されているか分からない場合は、付属の Monitor スクリプトで確認できます。

AHI を使うには、少なくとも1台のデバイスの VID/PID を把握しておく必要があります。

## Monitor アプリ

Monitor アプリでは、AHI が動作しているかを確認したり、デバイスの VID/PID や DeviceHandle を調べたりできます。

「Copy」ボタンを使うと、VID/PID や DeviceHandle をクリップボードにコピーできます。

**すべてのデバイスを一度に選択しないでください。** Monitor アプリがクラッシュすると、すべてのデバイスが操作不能になるおそれがあります。デバイスは一度に1台ずつ選択し、対象のデバイスかどうか確認してください。

![](Monitor.png)

---

# 既知の問題

デバイスを抜き差ししたり、休止状態から復帰したりすると、そのデバイスの Interception ID が1増える場合があります。

キーボードの ID が10を超えたり、マウスの ID が20を超えたりすると、次に再起動するまで、そのデバイスは完全に動作しなくなることがあります。これは AutoHotInterception 内だけでなく、Windows 上でも発生します。

これは Interception ドライバーの制限であり、AHI 側では修正できません。

---

# セットアップ

## Interception ドライバーをインストールする

[Interception Driver のリリースページ](https://github.com/oblitum/Interception/releases)からドライバーをダウンロードしてインストールします。

`install-interception.exe` は、**管理者権限のコマンドプロンプトから実行してください（ファイルをダブルクリックしないでください）**。実行すると、実際にインストールするために `install-interception.exe /install` を実行するよう案内されます。

インストール手順の GIF：
![](InterceptionInstall.gif)

## AutoHotInterception のフォルダーを構成する

1. [リリースページ](https://github.com/evilC/AutoHotInterception/releases)から AHI のリリース ZIP をダウンロードし、フォルダーに展開します。メインページの「Clone or Download」は使用しないでください。
2. AHI のリリース ZIP から、`AHK v1` または `AHK v2` のどちらか一方のフォルダーを取り出し、PC 上の任意の場所に配置します。ここが作業フォルダーになります。最初は、このフォルダーからスクリプトを実行します。フォルダーにはサンプルの `.ahk` スクリプトと `lib` フォルダーが含まれています。
3. AHI のリリース ZIP 内の `Common\lib` フォルダーから `AutoHotInterception.dll` を取り出し、作業フォルダー内の `lib` に配置します。
4. Interception インストーラーの ZIP にある `library` フォルダーには `x86` と `x64` フォルダーが含まれています。この2つのフォルダーを作業フォルダー内の `lib` にコピーします。

AHK v1 の例：左側が作業フォルダー、右上が AutoHotInterception の ZIP、右下が Interception の ZIP です。

![](FolderSetup.gif)

最終的なフォルダー構成は次のようになります。

```text
AHI Root Folder
    Monitor.ahk
    etc...
    Lib
        AutoHotInterception.ahk
        AutoHotInterception.dll
        CLR.ahk
        Unblocker.ps1
        etc...
        x86
            interception.dll
        x64
            interception.dll
```

5. `lib` フォルダー内の `Unblocker.ps1` を右クリックし、「管理者として実行」を選びます。ダウンロードした DLL は Windows によってブロックされており、そのままでは動作しないことがあるためです。

   手動で解除する場合は、次のどちらかの方法を使えます。
   - DLL を右クリックして「プロパティ」を開き、「ブロック」のチェック項目があれば解除する。
   - ZIP を展開する前に、AutoHotInterception の ZIP と Interception の ZIP の両方を右クリックして「ブロックの解除」を選ぶ。

6. 作業フォルダーから `Monitor.ahk` を実行し、正常に動作するか確認します。
7. （任意）`lib` フォルダーの内容を AutoHotkey のライブラリフォルダー（例：`ドキュメント\AutoHotkey\lib`。存在しなければ作成）に配置することもできます。その場合、サンプルスクリプトの `#include` 行を `#include <AutoHotInterception>` に変更すると、各スクリプトのフォルダーにライブラリファイルを複製しなくても、任意の場所から AHI スクリプトを実行できます。

---

# 使い方

## ライブラリを初期化する

### AHK v1

ライブラリを読み込みます。

```ahk
#Persistent ; (Interception hotkey だけでは AHK が終了することがあるため必要)
#include Lib\AutoHotInterception.ahk
```

ライブラリを初期化します。

```ahk
global AHI := new AutoHotInterception()
```

### AHK v2

ライブラリを読み込みます。

```ahk
Persistent ; (Interception hotkey だけでは AHK が終了することがあるため必要)
#include Lib\AutoHotInterception.ahk
```

ライブラリを初期化します。

```ahk
global AHI := AutoHotInterception()
```

`AHI` 変数は、AutoHotInterception DLL（さらに Interception DLL と連携します）を簡単に操作するための AutoHotkey クラスです。たとえば `GetDeviceList()` の戻り値を通常の AHK 配列に変換するなどの処理を行います。多くの場合、内部の仕組みを意識する必要はありません。

より高度な用途で、できるだけ高い性能を求めて AHI DLL を直接操作したい場合は、多くの関数で `AHI` の代わりに `AHI.Instance` を使用できます。たとえば、合成入力を送信する `SendMouseMove` などです。

```ahk
AHI := new AutoHotInterception()
AHI.Instance.SendMouseMove(...)
```

## その他のコマンド

### SetState

`SetState(true|false)`

すべての購読（subscription）を有効または無効にします。初期状態は有効です。

- `true`：有効
- `false`：無効

例：

```ahk
AHI.SetState(false)
```

## デバイス ID を調べる

### USB デバイス

多くの場合、特定の VID/PID を指定してスクリプトを対象デバイスに紐付けます。以下のいずれかの方法を使ってください。

同じ VID/PID のデバイスが複数ある場合は、`instance` を指定できます。番号は1から始まります。

#### GetDeviceId

`AHI.GetDeviceId(<isMouse>, <VID>, <PID> [,<instance = 1>] )`

マウスなら `true`、キーボードなら `false` を指定します。

例：VID が `0x04F2`、PID が `0x0112` のキーボードを取得します。

```ahk
AHI.GetDeviceId(false, 0x04F2, 0x0112)
```

#### GetKeyboardId

`AHI.GetKeyboardId(<VID>, <PID> [,<instance = 1>] )`

#### GetMouseId

`AHI.GetMouseId(<VID>, <PID> [,<instance = 1>] )`

### PS/2 などの旧式デバイス（ノート PC を含む場合があります）

古い PC の PS/2 接続デバイスや一部のノート PC などでは VID/PID を利用できないことがあります。その場合は Monitor アプリ（または `GetDeviceList()`）でデバイスの「Handle」を調べ、そこから ID を取得します。

#### GetDeviceIdFromHandle

`AHI.GetDeviceIdFromHandle(<isMouse>, <handle> [,<instance = 1>] )`

`GetDeviceId` と同様ですが、ハンドルを文字列で指定します。

例：

```ahk
AHI.GetDeviceIdFromHandle(false, "ACPI\PNP0303")
```

#### GetKeyboardIdFromHandle

`AHI.GetKeyboardIdFromHandle(<handle> [,<instance = 1>] )`

#### GetMouseIdFromHandle

`AHI.GetMouseIdFromHandle(<handle> [,<instance = 1>] )`

### デバイス一覧を取得する

使用可能なデバイス一覧を取得するには `AHI.GetDeviceList()` を呼び出します。戻り値は `DeviceInfo` オブジェクトの配列で、各オブジェクトは次のプロパティを持ちます。

```text
Id
isMouse
Vid
Pid
Handle
```

## 入力を検出する

AHI には **Context Mode** と **Subscription Mode** の2種類の入力検出モードがあり、同時に使用することもできます。

### Context Mode

Context Mode は AutoHotkey の[コンテキスト依存ホットキー](https://autohotkey.com/docs/Hotkeys.htm#Context)を利用する方式です。

このモードで対応しているのはキーボードのキーとマウスボタンのみです。マウス移動には対応していません。

Context Manager オブジェクトを作成すると、そのオブジェクトが AHK ホットキーの有効・無効を管理します。ホットキーを `#if`（AHK v2 では `#HotIf`）ブロックで囲み、Context Manager の `.IsActive` プロパティに応じて有効化します。

キーボードまたはマウスの Interception ID を渡して Context Manager を作成します。その後、`.IsActive` を確認する `#if` ブロック内にホットキーを定義します。

以下は動作するスクリプトの例です。

#### AHK v1

```ahk
#include Lib\AutoHotInterception.ahk

AHI := new AutoHotInterception()
keyboard1Id := AHI.GetKeyboardId(0x04F2, 0x0112)
cm1 := AHI.CreateContextManager(keyboard1Id)

#if cm1.IsActive
::aaa::JACKPOT
1::
    ToolTip % "KEY DOWN EVENT @ " A_TickCount
    return

1 up::
    ToolTip % "KEY UP EVENT @ " A_TickCount
    return
#if
```

#### AHK v2

```ahk
#include Lib\AutoHotInterception.ahk

AHI := AutoHotInterception()
keyboard1Id := AHI.GetKeyboardId(0x04F2, 0x0112)
cm1 := AHI.CreateContextManager(keyboard1Id)

#HotIf cm1.IsActive
::aaa::JACKPOT
1::
{
    ToolTip("KEY DOWN EVENT @ " A_TickCount)
    return
}

1 up::
{
    ToolTip("KEY UP EVENT @ " A_TickCount)
    return
}
#HotIf
```

Context Manager は、次のように削除できます。

```ahk
AHI.RemoveContextManager(keyboard1Id)
```

### Subscription Mode

Subscription Mode では AHK のホットキーシステムを介さず、Interception がキーイベントをコールバック経由で通知します。

このモードでは、すべての種類の入力に対応しています。

Subscription Mode は Context Mode より優先されます。あるキーボードのキーを Subscription Mode で購読している場合、そのキーについて Context Mode のホットキーは実行されません。

`SubscribeKey` は `SubscribeKeyboard` より優先されます。キーボード全体と特定キーの両方を購読している場合、特定キーを押したときはそのキー用のコールバックだけが実行され、キーボード全体用のコールバックは実行されません。

各 `Subscribe` 関数には対応する `Unsubscribe` 関数があり、購読とそれに関連するブロック設定を解除できます。

キーボードとマウスの購読関数には、任意の `concurrent` パラメーターがあります。これはコールバックを順番に実行するかどうかを指定します。

- `false`（既定値）：前のコールバックが完了するまで、次のコールバックは実行されません。特にマウス移動の購読で便利です。
- `true`：コールバックごとに新しいスレッドを使用します。コールバック内で時間のかかるループを実行すると、前のコールバックに割り込んで処理が積み上がり、メモリリークにつながるおそれがあります。自己責任で使用してください。

#### キーボードのキーを購読する

特定のキーボードの特定キーを購読します。

`SubscribeKey(<deviceId>, <scanCode>, <block>, <callback>, <concurrent>)`

購読解除：

`UnsubscribeKey(<deviceId>, <scanCode>)`

AHK v1 の例：

```ahk
AHI.SubscribeKey(keyboardId, GetKeySC("1"), true, Func("KeyEvent"))

KeyEvent(state){
    ToolTip % "State: " state
}
```

AHK v2 の例：

```ahk
AHI.SubscribeKey(keyboardId, GetKeySC("1"), true, KeyEvent)

KeyEvent(state){
    ToolTip("State: " state)
}
```

コールバックには、キーが離されたときは `0`、押されたときは `1` が渡されます。

#### 特定キーボードのすべてのキーを購読する

`SubscribeKeyboard(<deviceId>, <block>, <callback>, <concurrent>)`

AHK v1 の例：

```ahk
AHI.SubscribeKeyboard(keyboardId, true, Func("KeyEvent"))

KeyEvent(code, state){
    ToolTip % "Keyboard Key - Code: " code ", State: " state
}
```

AHK v2 の例：

```ahk
AHI.SubscribeKeyboard(keyboardId, true, KeyEvent)

KeyEvent(code, state){
    ToolTip("Keyboard Key - Code: " code ", State: " state)
}
```

コールバックには、押されたキーのスキャンコードと状態が渡されます。

#### マウスボタンを購読する

特定のマウスの特定ボタンを購読します。

`SubscribeMouseButton(<deviceId>, <button>, <block>, <callback>, <concurrent>)`

購読解除：

`UnsubscribeMouseButton(<deviceId>, <button>)`

`button` の値は次のとおりです。

```text
0: 左ボタン
1: 右ボタン
2: 中央ボタン
3: サイドボタン1
4: サイドボタン2
5: 垂直ホイール
6: 水平ホイール
```

マウスホイールの場合、`state` は上／右方向が `1`、下／左方向が `-1` です。それ以外の使い方は `SubscribeKey` と同様です。

#### 特定マウスのすべてのボタンを購読する

`SubscribeMouseButtons(<deviceId>, <block>, <callback>, <concurrent>)`

AHK v1 の例：

```ahk
AHI.SubscribeMouseButtons(mouseId, true, Func("MouseButtonEvent"))

MouseButtonEvent(code, state){
    ToolTip % "Mouse Button - Code: " code ", State: " state
}
```

AHK v2 の例：

```ahk
AHI.SubscribeMouseButtons(mouseId, true, MouseButtonEvent)

MouseButtonEvent(code, state){
    ToolTip("Mouse Button - Code: " code ", State: " state)
}
```

コールバックには、押されたボタンの ID と状態が渡されます。

#### マウス移動を購読する

**警告：** マウス移動を購読すると、大量のコールバックが発生します。Monitor アプリの CPU 使用率にも注意してください。

AutoHotkey は、GUI の更新など重い処理をコールバック内で大量に実行する用途には向いていません。CPU 使用率の増大を避けるため、コールバックは短く効率的にしてください。

##### 相対モード

通常のマウスや多くのタッチパッドでは相対モードを使用します。座標は現在位置ではなく、移動量（変化量）を表します。以下の2つの関数名は同じ動作です。

`SubscribeMouseMove(<deviceId>, <block>, <callback>, <concurrent>)`

`SubscribeMouseMoveRelative(<deviceId>, <block>, <callback>, <concurrent>)`

購読解除：

`UnsubscribeMouseMove(<deviceId>)`

`UnsubscribeMouseMoveRelative(<deviceId>)`

コールバックには整数の `x` と `y` が渡されます。

AHK v1 の例：

```ahk
AHI.SubscribeMouseMove(mouseId, false, Func("MouseEvent"))

MouseEvent(x, y){
    [...]
}
```

AHK v2 の例：

```ahk
AHI.SubscribeMouseMove(mouseId, false, MouseEvent)

MouseEvent(x, y){
    [...]
}
```

##### 絶対モード

絶対モードは、グラフィックタブレットやライトガンなどで使われます。座標の範囲は `0～65535` です。

`SubscribeMouseMoveAbsolute(<deviceId>, <block>, <callback>, <concurrent>)`

購読解除：

`UnsubscribeMouseMoveAbsolute(<deviceId>)`

このモードでも、コールバックには整数の `x` と `y` が渡されます。

AHK v1 の例：

```ahk
AHI.SubscribeMouseMoveAbsolute(mouseId, false, Func("MouseEvent"))

MouseEvent(x, y){
    [...]
}
```

AHK v2 の例：

```ahk
AHI.SubscribeMouseMoveAbsolute(mouseId, false, MouseEvent)

MouseEvent(x, y){
    [...]
}
```

---

## 入力イベントを送信する

以下のコマンドは Context Mode と Subscription Mode のどちらでも使用できます。また、何らかの購読を設定していないデバイスからでも入力を送信できます。

### キー入力を送信する

特定のキーボードとしてキーを送信するには `SendKeyEvent` を使います。

`AHI.SendKeyEvent(<keyboardId>, <scanCode>, <state>)`

- `scanCode`：キーのスキャンコード
- `state`：押下は `1`、解放は `0`
- `keyboardId`：キーボードの Interception ID

例：

```ahk
AHI.SendKeyEvent(keyboardId, GetKeySC("a"), 1)
```

Subscription Mode でキーを購読し、`block` を `true` に設定したうえで `SendKeyEvent` により別のキーを送ると、Windows や実行中のアプリケーションからは、入力が置き換えられたことを判別できない形でキーを変換できます。たとえば、`$` を付けた AHK ホットキーでも、この合成入力に反応します。

### マウスボタンを送信する

クリックなどのマウスボタン入力には、次を使います。

`AHI.SendMouseButtonEvent(<mouseId>, <button>, <state>)`

`button` は「マウスボタンを購読する」の項で説明した番号です。

マウスホイールの場合、`state` は上／右方向が `1`、下／左方向が `-1` です。

絶対モードを使用している場合は、指定座標でマウスボタンイベントを送信できます。

`AHI.SendMouseButtonEventAbsolute(<mouseId>, <button>, <state>, <x>, <y>)`

### マウスを移動する

#### 相対移動

通常の相対マウス移動を送信するには、次を使います。

`AHI.SendMouseMove(<mouseId>, <x>, <y>)`

`x` と `y` はカーソルの絶対位置ではなく、現在位置からの移動量です。単位はピクセルではなく「Mickey」です。

#### 絶対移動

絶対座標でマウスを移動するには、次を使います。

`AHI.SendMouseMoveAbsolute(<mouseId>, <x>, <y>)`

絶対移動は、FPS のようなマウス照準を使うゲームでは動作しない可能性があります。

絶対マウス移動の座標範囲は `0～65535` で、画面上のピクセル座標とは異なります。たとえば、モニターが1台で解像度が 1920×1080 の場合、65535 を 1920 で割ることで、横方向の座標換算の目安を求められます。ただし、この座標空間は複数モニター全体に対応するため、複数モニターでは追加の計算が必要です。

#### カーソルを指定位置へ移動する

画面またはウィンドウの座標を指定してカーソルを移動するには、次を使います。

`AHI.MoveCursor(<x>, <y> [, <coordMode>, <mouseId>])`

- `coordMode`：省略可能。使用する [CoordMode](https://www.autohotkey.com/docs/commands/CoordMode.htm)。呼び出し後は元の CoordMode に戻ります。既定値は `"Screen"` です。
- `mouseId`：省略可能。使用するマウスの ID。既定値は `11`（最初のマウス）です。

例：

```ahk
AHI.MoveCursor(100, 200)              ; マウス ID 11 で画面座標 100, 200 へ移動
AHI.MoveCursor(100, 200, "Window")    ; マウス ID 11 でウィンドウ座標 100, 200 へ移動
AHI.MoveCursor(100, 200, , 12)        ; マウス ID 12 で画面座標 100, 200 へ移動
```

## スクリプトをコンパイルする

AHI スクリプトは、スクリプトを右クリックして「Compile」を選ぶことでコンパイルできます。

必要な DLL はすべて EXE に格納されるため、配布するのは EXE だけでかまいません。EXE を実行すると、必要な DLL を含む `Lib` フォルダーが作成されます。
