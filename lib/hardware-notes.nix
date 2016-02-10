{ config, lib, pkgs, ... }:

with lib;

{

  options = {
    hardwareNotes = mkOption {
      internal = true;
      type = types.listOf types.optionSet;
      options = {
        title = mkOption {
          type = types.str;
          example = "Thunkpad-2000: increase self-destruct timeout";
        };
        text = mkOption {
	  type = types.str;
          example =
            ''
              Increase security timeout at boot using platform managment
              tool to prevent premature data loss.
            '';
        };
      };
    };
  };

  config = {
    environment.etc."hardware-notes" = {
      text = toString (map
        (x:
        ''

          # ${x.title}
          ${x.text}
        '')
        config.hardwareNotes);
    };
  };

}
