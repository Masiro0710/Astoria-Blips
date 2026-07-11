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

- Supports QBCore
- Supports Qbox
- Supports ESX Legacy
- Auto Detect Framework
- Auto Detect Notify
- Multi-language Support
- Configurable Shop Blips
- Open / Close Shop Commands
- Automatic Shop Reset After Server Restart

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

Available values

```
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

Available values

```
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

Available Locales

```
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

Example

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

| Setting | Description |
|---------|-------------|
| label | Shop Name |
| sprite | Blip Sprite ID |
| color | Blip Color ID |
| scale | Blip Scale |
| coords | Shop Location |

---

# Commands

| Command | Description |
|---------|-------------|
| /openshop | Set shop to Open |
| /closeshop | Set shop to Closed |

Only players currently **On Duty** can use these commands.

(ESX does not have a native Duty system, therefore all jobs are treated as On Duty.)

---

# Links

FiveM Blip IDs

https://docs.fivem.net/docs/game-references/blips/

Blip Colors

https://wiki.rage.mp/wiki/Blip::color

---

# License

Free to modify and use.

Please do not redistribute claiming it as your own work.

---

# Astoria-Blips

シンプルで軽量な店舗営業状態Blipシステムです。

**QBCore・Qbox・ESX Legacy** に対応しています。

---

# 作者

**尾崎ましろ**

---

# 機能

- QBCore対応
- Qbox対応
- ESX Legacy対応
- Framework自動検出
- Notify自動検出
- 多言語対応
- Blip設定可能
- 営業開始・準備中切替
- サーバー再起動時に全店舗を準備中へ

---

# 導入方法

1. resourcesフォルダへ配置
2. server.cfgへ追加

```cfg
ensure Astoria-Blips
```

3. config.luaを設定

---

# 設定

## Framework

```lua
Config.Framework = 'auto_detect'
```

設定可能

```
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

設定可能

```
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

対応言語

```
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

例

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

| 項目 | 説明 |
|------|------|
| label | 店舗名 |
| sprite | Blip番号 |
| color | Blip色番号 |
| scale | Blipサイズ |
| coords | 座標 |

---

# コマンド

| コマンド | 説明 |
|---------|------|
| /openshop | 営業中に変更 |
| /closeshop | 準備中に変更 |

※Duty（出勤）中のみ利用可能です。

ESXには標準Duty機能が存在しないため、常に出勤扱いになります。

---

# 参考URL

FiveM Blip一覧

https://docs.fivem.net/docs/game-references/blips/

Blip色一覧

https://wiki.rage.mp/wiki/Blip::color

---

# ライセンス

改造・利用自由です。

転載は禁止ですが、自作発言は禁止します。
