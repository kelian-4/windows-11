pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

import qs.modules.common

Singleton {
    id: root

    readonly property int fetchInterval: 2 * 60 * 1000
    readonly property string league: Config.options.waffles.widgets.sports.league
    property var data: ({
            loaded: false,
            league: "",
            state: "",
            detail: "",
            date: "",
            home: {},
            away: {}
        })

    onLeagueChanged: root.getData()

    function teamInfo(competitor) {
        return {
            abbreviation: competitor?.team?.abbreviation ?? "",
            name: competitor?.team?.displayName ?? "",
            logo: competitor?.team?.logo ?? "",
            score: competitor?.score ?? ""
        };
    }

    function refineData(parsed) {
        const events = parsed?.events ?? [];
        if (events.length === 0)
            return;
        const stateOf = event => (event.status ?? event.competitions?.[0]?.status)?.type?.state;
        const event = events.find(e => stateOf(e) === "in") ?? events.find(e => stateOf(e) === "pre") ?? events[events.length - 1];
        const competitors = event.competitions?.[0]?.competitors ?? [];
        const status = (event.status ?? event.competitions?.[0]?.status)?.type;
        root.data = {
            loaded: true,
            league: parsed.leagues?.[0]?.abbreviation ?? "",
            state: status?.state ?? "",
            detail: status?.shortDetail ?? "",
            date: event.date ?? "",
            home: root.teamInfo(competitors.find(c => c.homeAway === "home")),
            away: root.teamInfo(competitors.find(c => c.homeAway === "away"))
        };
    }

    function getData() {
        if (root.league.length === 0)
            return;
        fetcher.command = ["curl", "-s", `https://site.api.espn.com/apis/site/v2/sports/${root.league}/scoreboard`];
        fetcher.running = true;
    }

    Process {
        id: fetcher
        command: ["curl", "--version"]
        stdout: StdioCollector {
            onStreamFinished: {
                if (text.length === 0)
                    return;
                try {
                    root.refineData(JSON.parse(text));
                } catch (e) {
                }
            }
        }
    }

    Timer {
        running: true
        repeat: true
        interval: root.fetchInterval
        triggeredOnStart: true
        onTriggered: root.getData()
    }
}
