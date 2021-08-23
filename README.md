# Dotfiles

### Usage

To run the install script, log in, open Terminal.app, and run this command:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/colematthew4/dotfiles/main/install.zsh)"
```

This should do as much setup as possible. Once this is complete, execute a full restart for all the changes
to go into effect.

### Notes

Some applications cannot be setup via automation since AppleScript is not well supported and many apps
store settings in their own way. In these instances a dot directory with the name of the app will exist
with a settings.json file inside, which will contain keys and values equivalent to those within the app
UI.
