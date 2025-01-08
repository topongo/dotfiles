#!/bin/zsh

function player_icon(){
  case "$1" in
    spotify|spotifyd)
      echo -n ""
      ;;
    firefox)
      echo -n ""
      ;;
    vlc)
      echo -n "嗢"
      ;;
    *) 
      echo -n ""
      ;;
  esac
}


function player_data(){
  playerctl metadata -a -f "{{status}}%%{{playerName}}%%{{default(title,url)}}%%{{artist}}%%{{album}}" 2> /dev/null | 
    sed -e 's/%%spotify/%%1/' -e 's/%%vlc/%%2/' -e 's/%%firefox/%%3/' -e 's/^Playing%%/a%%/' -e 's/^Paused%%/b%%/' | sort | 
    sed -e 's/%%1/%%spotify/' -e 's/%%2/%%vlc/' -e 's/%%3/%%firefox/' -e 's/^a%%/Playing%%/' -e 's/^b%%/Paused%%/'
}

function best_playing(){
  if [ -z $1 ]; then
    local data=$(player_data)
  else
    local data=$1
  fi
  
  echo $data | grep Playing | while read p; do
    parts=("${(@s/%%/)p}")
    echo $parts[2]
    break
  done
}

function best(){
  if [ -z $1 ]; then
    local data=$(player_data)
  else
    local data=$1
  fi
  
  echo $data | while read p; do
    parts=("${(@s/%%/)p}")
    echo $parts[2]
    break
  done
}


data=$(player_data)
bp=$(best_playing $data)
b=$(best $data)
case $1 in
  poll)
    if playerctl metadata -a -f "{{status}}" 2> /dev/null | grep Playing > /dev/null; then
      echo $data | while read p; do
        parts=("${(@s/%%/)p}")
        playing=$parts[1]
        player=$parts[2]
        title=$parts[3]
        artist=$parts[4]
        album=$parts[5]
        if [[ -z $title ]]; then
          # try to get title from url
          title=$(playerctl metadata | grep $player | grep xesam:url | awk '{print $3}' | awk -F '/' '{print $NF}' | python -c 'from urllib.parse import unquote; print(unquote(input()))')
        fi

        echo -n $(player_icon $player)
        text=""
        if ! [[ -z $title ]]; then
          text="$title"
        fi
        if ! [[ -z $album ]]; then
          text="$text // $album"
        fi
        if ! [[ -z $artist ]]; then
          text="$text @ $artist"
        fi

        if [[ -z $text ]]; then
          echo "  Unknown Media"
        else
          echo "  $text"
        fi
        break
      done
    else
      echo No media
    fi
    ;;
  l-click)
    if ! [[ -z $bp ]]; then
      playerctl pause --player $bp
    else
      playerctl play --player $b
    fi
    ;;
  r-click)
    if ! [[ -z $bp ]]; then
      playerctl pause -a
    else
      playerctl play -a
    fi
    ;;
  m-click)
    if ! [[ -z $bp ]] && playerctl -a metadata | grep -q spotify && playerctl --player spotify metadata -f "{{status}}" | grep -q Playing; then
      track_id=$(playerctl --player spotify metadata -a -f "{{mpris:trackid}}" | sed 's#/com/spotify/track/##')
      cd ~/documents/python/spotify_utils
      cd ~/documents/python/spotify_utils
      res=$(venv/bin/python toggle_current_song_favourites.py $track_id)
      ~/bin/notify-systemized "Spotify Favourites" "$res"
    fi
    ;;
  r-dclick)
    if ! [[ -z $bp ]]; then
      playerctl previous --player $bp
    else
      playerctl previous --player $b
    fi
    ;;
  l-dclick)
    if ! [[ -z $bp ]]; then
      playerctl next --player $bp
    else
      playerctl next --player $b
    fi
    ;;
  u-scroll)
    if ! [[ -z $bp ]]; then
      playerctl position 5+ --player $bp
    fi
    ;;
  d-scroll)
    if ! [[ -z $bp ]]; then
      playerctl position 5- --player $bp
    fi
    ;;
esac

