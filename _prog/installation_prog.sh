
_setup_prog() {
    _mustGetSudo

    sudo -n env DEBIAN_FRONTEND=noninteractive apt-get -y update
    
    sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y dh-dkms

    sudo -n env DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y dkms devscripts debhelper dh-dkms build-essential
}


_build_prog-gasket-driver_sequence() {
    _start
    
    cp -a "$scriptLib"/gasket-driver "$safeTmp"/
    cd "$safeTmp"/gasket-driver
    debuild -us -uc -tc -b
    
    local currentDate
    currentDate=$(date +"%Y-%m-%d" | tr -dc '0-9\-')
    _safeRMR "$scriptLib"/install/gasket-driver-"$currentDate"
    mkdir -p "$scriptLib"/install/gasket-driver-"$currentDate"
    mv -f "$safeTmp"/*.deb "$scriptLib"/install/gasket-driver-"$currentDate"/

    _stop
}
_build_prog() {
    "$scriptAbsoluteLocation" _build_prog-gasket-driver_sequence "$@"
}

