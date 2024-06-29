### Installation per project:
- Add a `.nvim.lua` file in project for project-specific customizations.
- Add launch configuration in `.vscode/launch.json` file for debugging application
- Set below global variable for python projects:
    ```
    # Flake8 setup.cfg file path
    _G.flake8_setup_config_path = ''

    # Virtualenv path
    vim.g.python3_host_prog = ''
    ```

