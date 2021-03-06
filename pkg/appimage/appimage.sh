#!/bin/sh

PKGNAME='ocsstore'
PKGVER='2.2.1'
PKGREL='1'

curl -L -o appimagetool "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage"
chmod 755 appimagetool
./appimagetool --appimage-extract

make ocsmanager_build="appimage"
make DESTDIR="${PKGNAME}.AppDir" prefix="/usr" install

install -D -m 755 /usr/lib/x86_64-linux-gnu/libgconf-2.so.4 ${PKGNAME}.AppDir/usr/lib/ocsstore-linux-x64/libgconf-2.so.4
install -D -m 755 /usr/lib/x86_64-linux-gnu/libXss.so.1 ${PKGNAME}.AppDir/usr/lib/ocsstore-linux-x64/libXss.so.1

cp ${PKGNAME}.AppDir/usr/bin/${PKGNAME} ${PKGNAME}.AppDir/AppRun
cp ${PKGNAME}.AppDir/usr/share/applications/${PKGNAME}.desktop ${PKGNAME}.AppDir/${PKGNAME}.desktop
cp ${PKGNAME}.AppDir/usr/share/icons/hicolor/scalable/apps/${PKGNAME}.svg ${PKGNAME}.AppDir/${PKGNAME}.svg

./squashfs-root/AppRun ${PKGNAME}.AppDir

mv *.AppImage ${PKGNAME}-${PKGVER}-${PKGREL}-x86_64.AppImage
