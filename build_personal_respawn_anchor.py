from __future__ import annotations

import json
import shutil
import zipfile
from pathlib import Path


ROOT = Path(__file__).resolve().parent
MOD_NAME = "personal-respawn-anchor"
MOD_DIR = ROOT
INCLUDED_PATHS = [
    "changelog.txt",
    "control.lua",
    "CREDITS.md",
    "data.lua",
    "graphics/personal-respawn-anchor.png",
    "graphics/personal-respawn-anchor-shadow.png",
    "info.json",
    "LICENSE",
    "locale/en/locale.cfg",
    "MOD_PORTAL_DESCRIPTION.md",
    "settings.lua",
    "thumbnail.png",
]


def main() -> None:
    info = json.loads((MOD_DIR / "info.json").read_text(encoding="utf-8"))
    version = info["version"]
    zip_name = f"{MOD_NAME}_{version}.zip"
    top = f"{MOD_NAME}_{version}"

    target_dir = ROOT / "target"
    target_dir.mkdir(exist_ok=True)
    out_zip = target_dir / zip_name
    if out_zip.exists():
        out_zip.unlink()

    with zipfile.ZipFile(out_zip, "w", compression=zipfile.ZIP_DEFLATED) as archive:
        for rel in INCLUDED_PATHS:
            path = MOD_DIR / rel
            if path.is_file():
                archive.write(path, f"{top}/{rel}")
            else:
                raise FileNotFoundError(path)

    print(f"Built {out_zip}")

    runtime_mod_dir = Path.home() / ".factorio-server-maintainer" / "Server" / "mods"
    if "--install-local" in __import__("sys").argv:
        runtime_mod_dir.mkdir(parents=True, exist_ok=True)
        for old_zip in runtime_mod_dir.glob(f"{MOD_NAME}_*.zip"):
            old_zip.unlink()
        shutil.copy2(out_zip, runtime_mod_dir / zip_name)
        print(f"Installed {zip_name} to {runtime_mod_dir}")


if __name__ == "__main__":
    main()
