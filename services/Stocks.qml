pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

import qs.modules.common

Singleton {
    id: root

    readonly property int fetchInterval: 5 * 60 * 1000
    readonly property string symbol: Config.options.waffles.widgets.stocks.symbol
    property var data: ({
            loaded: false,
            symbol: "",
            name: "",
            price: 0,
            previousClose: 0,
            currency: "",
            closes: []
        })
    readonly property real change: data.price - data.previousClose
    readonly property real changePercent: data.previousClose !== 0 ? change / data.previousClose * 100 : 0

    onSymbolChanged: root.getData()

    function refineData(parsed) {
        const result = parsed?.chart?.result?.[0];
        if (!result?.meta)
            return;
        const meta = result.meta;
        const closes = (result.indicators?.quote?.[0]?.close ?? []).filter(value => value !== null);
        root.data = {
            loaded: true,
            symbol: meta.symbol ?? root.symbol,
            name: meta.shortName ?? meta.symbol ?? root.symbol,
            price: meta.regularMarketPrice ?? 0,
            previousClose: meta.chartPreviousClose ?? meta.previousClose ?? 0,
            currency: meta.currency ?? "",
            closes: closes
        };
    }

    function getData() {
        if (root.symbol.length === 0)
            return;
        const url = `https://query1.finance.yahoo.com/v8/finance/chart/${encodeURIComponent(root.symbol)}?interval=5m&range=1d`;
        fetcher.command = ["curl", "-s", "-A", "Mozilla/5.0", url];
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
