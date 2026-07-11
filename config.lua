Config = {}

Config.Framework = 'auto_detect' -- auto_detect / qbcore / qbox / esx

Config.Notify = 'auto_detect' -- auto_detect / qbcore / ox_lib / esx / okokNotify

Config.Locale = 'ja'

Config.Shops = {
    ['uwu'] = {
        label = '猫カフェ',

        openBlip = {
            sprite = 489,
            color = 61,
            scale = 1.0,
            coords = vector3(-581.05, -1070.06, 22.33)
        },

        closedBlip = {
            sprite = 489,
            color = 72,
            scale = 1.0,
            coords = vector3(-581.05, -1070.06, 22.33)
        }
    },
    ['donmonoya'] = {
        label = '丼なもん屋',

        openBlip = {
            sprite = 355,
            color = 47,
            scale = 0.7,
            coords = vector3(-1040.19, -1475.58, 5.57)
        },

        closedBlip = {
            sprite = 355,
            color = 72,
            scale = 0.7,
            coords = vector3(-1040.19, -1475.58, 5.57)
        }
    },
    ['realestate'] = {
        label = 'Dynasty8',

        openBlip = {
            sprite = 475,
            color = 5,
            scale = 0.7,
            coords = vector3(-709.9565, 267.6189, 83.1473)
        },

        closedBlip = {
            sprite = 475,
            color = 72,
            scale = 0.7,
            coords = vector3(-709.9565, 267.6189, 83.1473)
        }
    },
    ['mechanic'] = {
        label = 'Dreams Auto Base',

        openBlip = {
            sprite = 446,
            color = 81,
            scale = 0.7,
            coords = vector3(-211.55, -1324.55, 30.9)
        },

        closedBlip = {
            sprite = 446,
            color = 72,
            scale = 0.7,
            coords = vector3(-211.55, -1324.55, 30.9)
        }
    },
    ['burgershot'] = {
        label = 'Burgershot',

        openBlip = {
            sprite = 438,
            color = 64,
            scale = 0.8,
            coords = vector3(-1184.79, -885.14, 14.03)
        },

        closedBlip = {
            sprite = 438,
            color = 72,
            scale = 0.8,
            coords = vector3(-1184.79, -885.14, 14.03)
        }
    },
    /*['Lapinacapsule'] = {
        label = 'Lapina Capsule',

        openBlip = {
            sprite = 478,
            color = 81,
            scale = 0.7,
            coords = vector3()
        },

        closedBlip = {
            sprite = 478,
            color = 72,
            scale = 0.7,
            coords = vector3()
        }
    },*/
}