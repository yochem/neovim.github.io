# Neovim.io website

This repository contains the source for the neovim.io website.

*To report a bug Neovim,* go here: https://github.com/neovim/neovim

## Contributing

Just fork this repository and send us a pull request! :-)

## Setup

This site is statically generated using Hugo. It takes one minute to get setup,
just do the following:

1. Install Hugo
   ```bash
   brew install hugo
   ```
2. (Optional) To include the documentation pages locally:
   ```bash
   ./gendoc.lua <path>/<to>/<nvim>
   ```
3. Build and view the website locally:
   ```bash
   hugo serve -D
   ```
4. Open http://localhost:1313/ to view the website.


## Maintenance

Notes:

- Create new blog posts (news items) using the command:
  ```bash
  hugo new content content/news/<filename>.md
  ```
  The filename won't show up on the site -- the page url will be in the form of
  `/news/2026/12/` where 2026 is the year and 12 the month, as defined in the
  front matter.
- Site search (for `:help` docs) is served by [Algolia Docsearch](https://docsearch.algolia.com/).
    - The javascript and UI container were setup in [this commit](https://github.com/neovim/neovim.github.io/commit/ce9aef12eb1c98135965e3a9c5c792bf9e506a76).
    - The docs pages don't use the layout so they also need to [manually include](https://github.com/neovim/neovim/pull/23839) the javascript and define a UI container.
    - Admin: https://www.algolia.com/apps/X185E15FPG/dashboard
    - Config: [algolia-docsearch-config.js](./algolia-docsearch-config.js)
- Codeblock highlighting
    - The highlighting for the generated help docs (`/doc/user/`) is done by:
        - `static/css/neovim-hi.css`
        - `static/highlight/styles/neovim.min.css`
    - Hugo can provide highlighting for markdown codeblocks, see the `[markup]` section in `hugo.toml`.
        - To list/generate Hugo syntax themes:
          ```
          hugo gen chromastyles --style nord > static/css/syntax.css
          ```
        - To use the them, commit `static/css/syntax.css` and enable it by uncommenting this line: https://github.com/neovim/neovim.github.io/blob/eb266d7929eff8693cc05ca96732a2daf431e834/layouts/_default/baseof.html#L27
          - And fiddle with the `[markup]` section in `hugo.toml`.
