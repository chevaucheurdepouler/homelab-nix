if [[ "$1" = "area" ]]; then
  SCREENPATH=$(grimshot save area)
elif [ "$1" = "output" ]; then
  SCREENPATH=$(grimshot save output)
fi

cat $SCREENPATH | wl-copy -t image/png
