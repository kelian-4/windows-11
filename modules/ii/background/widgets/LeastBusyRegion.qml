import QtQuick

Item {
    id: root

    property string source: ""
    property int screenWidth: 1920
    property int screenHeight: 1080
    property int regionWidth: 300
    property int regionHeight: 300
    property int horizontalPadding: 200
    property int verticalPadding: 200
    property bool busiest: false

    signal found(real centerX, real centerY, string dominantColor)

    readonly property int analysisWidth: 192
    readonly property int analysisHeight: Math.max(1, Math.round(analysisWidth * screenHeight / Math.max(1, screenWidth)))

    visible: false

    function run() {
        probe.active = false;
        probe.active = source.length > 0 && screenWidth > 0 && screenHeight > 0;
    }

    function analyze(image) {
        const W = root.analysisWidth;
        const H = root.analysisHeight;
        const iw = image.implicitWidth;
        const ih = image.implicitHeight;
        if (iw <= 0 || ih <= 0) return;
        const fill = Math.max(root.screenWidth / iw, root.screenHeight / ih);
        const sw = root.screenWidth / fill;
        const sh = root.screenHeight / fill;
        const ctx = canvas.getContext("2d");
        ctx.clearRect(0, 0, W, H);
        ctx.drawImage(image, (iw - sw) / 2, (ih - sh) / 2, sw, sh, 0, 0, W, H);
        const px = ctx.getImageData(0, 0, W, H).data;

        const stride = W + 1;
        const sum = new Float64Array(stride * (H + 1));
        const sumSq = new Float64Array(stride * (H + 1));
        for (let y = 0; y < H; y++) {
            let rowSum = 0;
            let rowSumSq = 0;
            for (let x = 0; x < W; x++) {
                const i = (y * W + x) * 4;
                const g = 0.299 * px[i] + 0.587 * px[i + 1] + 0.114 * px[i + 2];
                rowSum += g;
                rowSumSq += g * g;
                sum[(y + 1) * stride + x + 1] = sum[y * stride + x + 1] + rowSum;
                sumSq[(y + 1) * stride + x + 1] = sumSq[y * stride + x + 1] + rowSumSq;
            }
        }
        const area = (x1, y1, x2, y2, table) => table[y2 * stride + x2] - table[y1 * stride + x2] - table[y2 * stride + x1] + table[y1 * stride + x1];

        const ratio = W / root.screenWidth;
        let rw = Math.max(1, Math.round(root.regionWidth * ratio));
        let rh = Math.max(1, Math.round(root.regionHeight * ratio));
        let hp = Math.round(root.horizontalPadding * ratio);
        let vp = Math.round(root.verticalPadding * ratio);
        if (hp * 2 >= W || vp * 2 >= H) {
            hp = Math.max(0, Math.min(hp, Math.floor((W - 1) / 2)));
            vp = Math.max(0, Math.min(vp, Math.floor((H - 1) / 2)));
        }
        rw = Math.min(rw, W - 2 * hp);
        rh = Math.min(rh, H - 2 * vp);
        if (rw <= 0 || rh <= 0) return;

        const regionArea = rw * rh;
        let best = null;
        let bestX = hp;
        let bestY = vp;
        for (let y = vp; y <= H - rh - vp; y++) {
            for (let x = hp; x <= W - rw - hp; x++) {
                const s = area(x, y, x + rw, y + rh, sum);
                const s2 = area(x, y, x + rw, y + rh, sumSq);
                const mean = s / regionArea;
                const variance = s2 / regionArea - mean * mean;
                if (best === null || (root.busiest ? variance > best : variance < best)) {
                    best = variance;
                    bestX = x;
                    bestY = y;
                }
            }
        }

        let r = 0, g = 0, b = 0, n = 0;
        for (let y = bestY; y < bestY + rh; y++) {
            for (let x = bestX; x < bestX + rw; x++) {
                const i = (y * W + x) * 4;
                if (px[i] <= 10 && px[i + 1] <= 10 && px[i + 2] <= 10) continue;
                r += px[i];
                g += px[i + 1];
                b += px[i + 2];
                n++;
            }
        }
        const hex = v => ("0" + Math.round(n > 0 ? v / n : 0).toString(16)).slice(-2);
        root.found((bestX + rw / 2) / ratio, (bestY + rh / 2) / ratio, `#${hex(r)}${hex(g)}${hex(b)}`);
    }

    Canvas {
        id: canvas
        width: root.analysisWidth
        height: root.analysisHeight
        opacity: 0.001
        renderTarget: Canvas.Image
        onPaint: {
            if (probe.item && probe.item.status === Image.Ready)
                root.analyze(probe.item);
        }
    }

    Loader {
        id: probe
        active: false
        sourceComponent: Image {
            source: root.source
            cache: false
            asynchronous: true
            visible: false
            sourceSize.width: 640
            onStatusChanged: {
                if (status === Image.Ready) canvas.requestPaint();
            }
        }
    }
}
