# Wedding photo setup

Bride and groom portraits and gallery images are now linked from the saved live website HTML. If the Base44 photo database is empty, the page uses these photos.

## Download images into the project (Windows)
1. Extract the ZIP. Open `complete_project` in VS Code.
2. In the VS Code terminal, run `powershell -ExecutionPolicy Bypass -File .\DOWNLOAD_ALL_PHOTOS.ps1`.
3. Successful downloads are saved in `public/images/`. The script automatically updates `src/components/invitation/photo-local.json` to use local files. Failed downloads retain the original online links.
4. Run `npm install` and `npm run dev` in the `complete_project` folder.

All original image links are listed in `photo-sources.json`. The gallery is sourced from the provided saved website HTML, not guessed. A photo cannot be bundled locally unless its download succeeds.
