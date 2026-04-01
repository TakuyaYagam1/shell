import qs.utils
import Caelestia
import QtQuick

Item {
    id: root

    property string path

    readonly property int status: loader.item?.status ?? Image.Null

    function reload(): void {
        _format = CUtils.imageFormat(path);
        loader.active = false;
        loader.active = true;
    }

    property string _format: CUtils.imageFormat(path)

    Loader {
        id: loader

        anchors.fill: parent
        sourceComponent: root._format === "gif" ? animatedComponent : cachingComponent
    }

    Component {
        id: animatedComponent

        AnimatedImage {
            fillMode: AnimatedImage.PreserveAspectCrop
            asynchronous: true
            playing: true
            source: `file://${root.path}`
        }
    }

    Component {
        id: cachingComponent

        CachingImage {
            path: root.path
        }
    }
}
