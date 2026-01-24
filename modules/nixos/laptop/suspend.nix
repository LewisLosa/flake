{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.batteryNotifier;
in {
  options.services.batteryNotifier = {
    enable = mkOption {
      default = false;
      description = "Whether to enable battery notifier.";
    };

    device = mkOption {
      default = null;
      description = "Battery device to monitor (e.g. BAT0, BAT1). If null, auto-detect.";
      type = types.nullOr types.str;
    };

    notifyCapacity = mkOption {
      default = 10;
      description = "Battery level at which a notification shall be sent.";
    };

    suspendCapacity = mkOption {
      default = 5;
      description = "Battery level at which suspend is triggered.";
    };
  };

  config = mkIf cfg.enable {
    systemd.user.timers.lowbatt = {
      description = "check battery level";
      timerConfig = {
        OnBootSec = "1m";
        OnUnitInactiveSec = "1m";
        Unit = "lowbatt.service";
      };
      wantedBy = ["timers.target"];
    };

    systemd.user.services.lowbatt = {
      description = "battery level notifier";
      serviceConfig.PassEnvironment = "DISPLAY";

      script = ''
        set -euo pipefail

        POWER_SUPPLY=/sys/class/power_supply

        ${
          if cfg.device != null
          then ''
            if [ -d "${"/sys/class/power_supply/" + cfg.device}" ]; then
              BAT="${cfg.device}"
            else
              exit 0
            fi
          ''
          else ''
            BAT=$(ls "$POWER_SUPPLY" | grep -E '^BAT' | head -n1 || true)
            [ -z "$BAT" ] && exit 0
          ''
        }

        CAPACITY=$(${pkgs.coreutils}/bin/cat "$POWER_SUPPLY/$BAT/capacity")
        STATUS=$(${pkgs.coreutils}/bin/cat "$POWER_SUPPLY/$BAT/status")

        [ "$STATUS" != "Discharging" ] && exit 0

        if [ "$CAPACITY" -le ${toString cfg.notifyCapacity} ]; then
          ${pkgs.libnotify}/bin/notify-send \
            --urgency=critical \
            --hint=int:transient:1 \
            --icon=battery_empty \
            "Battery Low" \
            "Battery at $CAPACITY%. Plug in the charger."
        fi

        if [ "$CAPACITY" -le ${toString cfg.suspendCapacity} ]; then
          ${pkgs.libnotify}/bin/notify-send \
            --urgency=critical \
            --hint=int:transient:1 \
            --icon=battery_empty \
            "Battery Critical" \
            "System will suspend in 60 seconds."

          sleep 60

          STATUS=$(${pkgs.coreutils}/bin/cat "$POWER_SUPPLY/$BAT/status")
          [ "$STATUS" = "Discharging" ] && systemctl suspend
        fi
      '';
    };
  };
}
