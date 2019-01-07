# Some linux util functions

function clocksource_linux() {
    avaliable=$(cat "/sys/devices/system/clocksource/clocksource0/available_clocksource")
    current=$(cat "/sys/devices/system/clocksource/clocksource0/current_clocksource")

    echo "avaliable clocksource: ${avaliable}"
    echo "current   clocksource: ${current}"
}
