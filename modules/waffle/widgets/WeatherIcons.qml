pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: root

    readonly property var iconByCode: ({
            "113": "weather-sunny",
            "116": "weather-partly-cloudy-day",
            "119": "weather-cloudy",
            "122": "weather-cloudy",
            "143": "weather-fog",
            "248": "weather-fog",
            "260": "weather-fog",
            "200": "weather-thunderstorm",
            "386": "weather-thunderstorm",
            "389": "weather-thunderstorm",
            "392": "weather-thunderstorm",
            "395": "weather-snow",
            "263": "weather-drizzle",
            "266": "weather-drizzle",
            "281": "weather-drizzle",
            "284": "weather-drizzle",
            "176": "weather-rain-showers-day",
            "293": "weather-rain-showers-day",
            "296": "weather-rain-showers-day",
            "353": "weather-rain-showers-day",
            "299": "weather-rain",
            "302": "weather-rain",
            "305": "weather-rain",
            "308": "weather-rain",
            "311": "weather-rain",
            "314": "weather-rain",
            "356": "weather-rain",
            "359": "weather-rain",
            "182": "weather-hail-day",
            "185": "weather-hail-day",
            "317": "weather-hail-day",
            "320": "weather-hail-day",
            "350": "weather-hail-day",
            "362": "weather-hail-day",
            "365": "weather-hail-day",
            "374": "weather-hail-day",
            "377": "weather-hail-day",
            "179": "weather-snow",
            "227": "weather-snow",
            "230": "weather-snow",
            "323": "weather-snow",
            "326": "weather-snow",
            "329": "weather-snow",
            "332": "weather-snow",
            "335": "weather-snow",
            "338": "weather-snow",
            "368": "weather-snow-shower-day",
            "371": "weather-snow-shower-day"
        })

    function isNight(hour) {
        return hour < 6 || hour >= 19;
    }

    function iconFor(code, hour) {
        const icon = root.iconByCode[String(code)] ?? "weather-cloudy";
        if (!root.isNight(hour))
            return icon;
        if (icon === "weather-sunny")
            return "weather-moon";
        if (icon === "weather-partly-cloudy-day")
            return "weather-partly-cloudy-night";
        return icon;
    }
}
