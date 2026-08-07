# Astoria-Blips

A simple and lightweight shop status blip system for FiveM.

✅ QBCore (Supported & Tested)
✅ Qbox (Supported & Tested)
⚠️ ESX Legacy (Support included, but not tested)

---

# Author

**Masiro**

---

# Features

* Supports QBCore
* Supports Qbox
* Supports ESX Legacy
* Auto Detect Framework
* Auto Detect Notify
* Multi-language Support
* Configurable Shop Blips
* Open / Close Shop Commands
* On Duty-based Shop Management
* Automatic Shop Status Reset When No Employees Are On Duty
* Automatic Shop Reset After Server Restart
* Shop Status Synchronization for All Players

---

# Installation

1. Place the resource inside your `resources` folder.
2. Ensure the resource in your `server.cfg`.

```cfg
ensure Astoria-Blips
```

3. Configure `config.lua`.

---

# Configuration

## Framework

```lua
Config.Framework = 'auto_detect'
```

Available values:

```text
auto_detect
qbcore
qbox
esx
```

---

## Notify

```lua
Config.Notify = 'auto_detect'
```

Available values:

```text
auto_detect
qbcore
ox_lib
esx
okokNotify
```

---

## Locale

```lua
Config.Locale = 'en'
```

Available Locales:

```text
en
ja
```

---

## Debug

```lua
Config.Debug = false
```

---

# Shop Configuration

Example:

```lua
Config.Shops = {

    ['uwu'] = {

        label = 'UwU Cafe',

        openBlip = {

            sprite = 489,
            color = 61,
            scale = 1.0,
            coords = vector3(...)
        },

        closedBlip = {

            sprite = 489,
            color = 72,
            scale = 1.0,
            coords = vector3(...)
        }
    }

}
```

| Setting | Description    |
| ------- | -------------- |
| label   | Shop Name      |
| sprite  | Blip Sprite ID |
| color   | Blip Color ID  |
| scale   | Blip Scale     |
| coords  | Shop Location  |

The shop name is automatically displayed with its current status.

```text
UwU Cafe（営業中）
UwU Cafe（準備中）
```

---

# Shop Status

Each shop has two states:

* **Open**
* **Preparing**

When a player uses `/openshop`, the shop is set to **Open**.

When a player uses `/closeshop`, the shop is set to **Preparing**.

If the number of On Duty employees for an open shop reaches zero, the shop is automatically changed to **Preparing**.

For example:

```text
UwU Cafe

Employee A - On Duty
Employee B - On Duty

Status: Open
```

If Employee A leaves Duty:

```text
Employee B - On Duty

Status: Open
```

If Employee B also leaves Duty:

```text
No employees on Duty

Status: Preparing
```

Changing jobs, going off duty, or leaving the server will therefore prevent a shop from remaining open when nobody is available.

Simply going On Duty does not automatically open the shop. A player must use `/openshop` to start the shop.

---

# Commands

| Command      | Description           |
| ------------ | --------------------- |
| `/openshop`  | Set shop to Open      |
| `/closeshop` | Set shop to Preparing |

Only players currently **On Duty** can use these commands.

Players can only change the shop associated with their current job.

For example, a player with the `uwu` job can control the `uwu` shop, but cannot change another job's shop.

### ESX

ESX Legacy does not have a native Duty system, therefore all jobs are treated as On Duty.

---

# Shop Synchronization

Shop statuses are synchronized between all players.

When a shop is opened or changed to Preparing, the corresponding blip is updated for all players.

All shops start in the **Preparing** state after a server restart.

---

# Links

## FiveM Blip IDs

See the official FiveM Blip documentation for available Blip Sprite IDs.

## Blip Colors

See the RageMP Blip color reference for available Blip Color IDs.

---

# License

Free to use and modify.

Redistribution is not permitted.

Selling, reselling, sublicensing, or commercially distributing this resource is not permitted.

You may modify this resource for use on your own server.

Do not redistribute this resource, modified or unmodified, while claiming it as your own work.

Credit is appreciated but not required.

Copyright:

**Masiro Ozaki (尾崎ましろ)**
**Secondary Copyright Holder: AstoriaCity**

For the full license terms, please refer to the included `LICENSE` file.

---

# Astoria-Blips

FiveM向けのシンプルで軽量な店舗ステータスBlipシステムです。

✅ QBCore（対応・動作確認済み）
✅ Qbox（対応・動作確認済み）
⚠️ ESX Legacy（対応していますが、動作確認は行っていません）

---

# 作者

**尾崎ましろ（Masiro Ozaki）**

---

# 機能

* QBCore対応
* Qbox対応
* ESX Legacy対応
* Framework自動検出
* Notify自動検出
* 多言語対応
* Blip設定可能
* 営業開始・準備中切替
* Dutyに基づいた店舗管理
* OnDuty人数が0人になった場合の自動準備中切替
* サーバー再起動時に全店舗を準備中へリセット
* 全プレイヤーへの店舗ステータス同期

---

# 導入方法

1. `resources` フォルダへ配置
2. `server.cfg` へ追加

```cfg
ensure Astoria-Blips
```

3. `config.lua` を設定

---

# 設定

## Framework

```lua
Config.Framework = 'auto_detect'
```

設定可能:

```text
auto_detect
qbcore
qbox
esx
```

---

## Notify

```lua
Config.Notify = 'auto_detect'
```

設定可能:

```text
auto_detect
qbcore
ox_lib
esx
okokNotify
```

---

## Locale

```lua
Config.Locale = 'ja'
```

対応言語:

```text
ja
en
```

---

## Debug

```lua
Config.Debug = false
```

---

# 店舗設定

例:

```lua
Config.Shops = {

    ['uwu'] = {

        label = '猫カフェ',

        openBlip = {

            sprite = 489,
            color = 61,
            scale = 1.0,
            coords = vector3(...)
        },

        closedBlip = {

            sprite = 489,
            color = 72,
            scale = 1.0,
            coords = vector3(...)
        }
    }

}
```

| 項目     | 説明      |
| ------ | ------- |
| label  | 店舗名     |
| sprite | Blip番号  |
| color  | Blip色番号 |
| scale  | Blipサイズ |
| coords | 座標      |

店舗名には現在の状態が自動的に表示されます。

```text
猫カフェ（営業中）
猫カフェ（準備中）
```

---

# 店舗ステータス

店舗には以下の2つの状態があります。

* **営業中**
* **準備中**

`/openshop` を使用すると、店舗が**営業中**になります。

`/closeshop` を使用すると、店舗が**準備中**になります。

また、営業中の店舗に所属するOnDuty中のプレイヤーが0人になると、自動的に**準備中**へ切り替わります。

例えば、

```text
猫カフェ

Aさん - OnDuty
Bさん - OnDuty

状態：営業中
```

AさんがDutyを抜けると、

```text
Bさん - OnDuty

状態：営業中
```

となります。

その後、BさんもDutyを抜けると、

```text
OnDuty中の従業員なし

状態：準備中
```

となります。

別ジョブへの変更、Dutyを抜ける、サーバーから退出するなどによってOnDuty人数が0人になった場合も、自動的に準備中へ切り替わります。

なお、**Dutyに入っただけでは自動的に営業開始にはなりません。**

営業開始する場合は、`/openshop` を使用してください。

---

# コマンド

| コマンド         | 説明     |
| ------------ | ------ |
| `/openshop`  | 営業中に変更 |
| `/closeshop` | 準備中に変更 |

※Duty（出勤）中のみ利用可能です。

また、自分が現在所属しているジョブの店舗のみ変更できます。

例えば、

```text
uwu
```

ジョブのプレイヤーは `uwu` の店舗を変更できますが、他のジョブの店舗を変更することはできません。

### ESX

ESX Legacyには標準のDutyシステムが存在しないため、すべてのジョブを出勤扱いとして処理します。

---

# 店舗状態の同期

店舗の状態は全プレイヤー間で同期されます。

店舗が営業中または準備中へ変更されると、全プレイヤーの対応するBlipが更新されます。

また、サーバー再起動時はすべての店舗が**準備中**の状態から開始します。

---

# 参考URL

## FiveM Blip一覧

利用可能なBlip Sprite IDについては、FiveM公式のBlip一覧を参照してください。

## Blip色一覧

利用可能なBlip Color IDについては、Blip Colorの一覧を参照してください。

---

# ライセンス

利用・改造自由です。

再配布は禁止されています。

本リソースの販売、再販売、サブライセンス、商用目的での配布は禁止されています。

自身のサーバーで使用する目的での改造は自由に行えます。

改造版・無改造版を問わず、本リソースを自作物として主張して再配布することは禁止されています。

クレジット表記は必須ではありません。

著作権：

**主権利者：尾崎ましろ（Masiro Ozaki）**
**副権利者：AstoriaCity**

詳細なライセンス条項については、同梱されている `LICENSE` ファイルを参照してください。
