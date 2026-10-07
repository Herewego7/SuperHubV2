#!/bin/sh
set -eu
root=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
src="$root/vendor/bot-life/ios/App/BotLifeApp.swift"
out_dir="$root/ios/SuperHub/Generated"
out="$out_dir/BotLifeHosted.swift"
python3 - "$src" "$out" <<'PY'
import pathlib, sys
src, out = sys.argv[1:]
text = pathlib.Path(src).read_text()
marker = "struct BotLifeApp"
start = text.find(marker)
if start < 0:
    raise SystemExit("struct BotLifeApp not found")
main = text.rfind("@main", 0, start)
if main < 0:
    raise SystemExit("@main not found before struct BotLifeApp")
brace = text.find("{", start)
if brace < 0:
    raise SystemExit("struct BotLifeApp has no body")
depth = 0
end = None
for index, char in enumerate(text[brace:], brace):
    if char == "{":
        depth += 1
    elif char == "}":
        depth -= 1
        if depth == 0:
            end = index + 1
            break
if end is None:
    raise SystemExit("struct BotLifeApp brace match failed")
hosted = text[:main] + text[end:]
if hosted.count("struct BotLifeApp") != 0:
    raise SystemExit("struct BotLifeApp was not removed")
if "struct RootView" not in hosted or "struct AppTabView" not in hosted:
    raise SystemExit("hosted file lost RootView or AppTabView")
path = pathlib.Path(out)
path.parent.mkdir(parents=True, exist_ok=True)
path.write_text(hosted)
print(path)
PY
