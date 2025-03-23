if [[ "$1" = "area" ]]; then
  SCREENPATH=$(grimshot save area)
elif [ "$1" = "output" ]; then
  SCREENPATH=$(grimshot save output)
fi

if [[ -f "$SCREENPATH" ]]; then
  cat "$SCREENPATH" | wl-copy -t image/png
  echo "Screenshot copied to clipboard :3"
else
  echo "oh noes it failed... no file at $SCREENPATH"
  exit 1
fi
