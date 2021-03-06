TARGET = Battery

CONFIG += sailfishapp_qml

OTHER_FILES += qml/Battery.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/Battery.changes.in \
    rpm/Battery.spec \
    translations/*.ts \
    Battery.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256


CONFIG += sailfishapp_i18n


TRANSLATIONS += translations/Battery.ts

DISTFILES += \
    qml/pages/button.py
