set -x prefix "[BackRoom]"
set -x codename Litchi
set -x ver 1
set -x target
set -x root $argv[1]
set -x logcat $argv[2]
if test -z $root
    set root .
end
if test -z $logcat
    set logcat info
end
checkdependence jq curl sponge nano systemd-nspawn zstd tar xz
switch $argv[3]
    case enter
        level_index_db
        switch $argv[4]
            case nspawn
                br_nspawn $argv[5..-1]
            case chroot
                br_chroot $argv[5..-1]
            case kvm
                br_kvm $argv[5..-1]
            case '*'
                logger 5 "Option $argv[1] not found at backroom.enter"
        end
    case manage
        level_index_db
        switch $argv[4]
            case service
                service $argv[5..-1]
            case level
                level $argv[5..-1]
            case '*'
                logger 5 "Option $argv[1] not found at backroom.manage"
        end
    case v version
        logger 1 "$codename@build$ver"
    case h help '*'
        help_echo
end
