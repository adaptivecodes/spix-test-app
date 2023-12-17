import QtQuick 2.15


Column{

SwipeView {
    id: view
    currentIndex: 1
    anchors.fill: parent

    Item {
        id: firstPage
    }
    Item {
        id: secondPage
    }
    Item {
        id: thirdPage
    }

}

PageIndicator {
    id: indicator

    count: view.count
    currentIndex: view.currentIndex

    anchors.bottom: view.bottom
    anchors.horizontalCenter: parent.horizontalCenter
}
}
