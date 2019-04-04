# aliases for url part encoding/decoding
alias urldecode='python -c "import sys, urllib as ul; \
    print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; \
    print ul.quote_plus(sys.argv[1])"'

alias printcolors='for C in {0..255}; do tput setab $C; echo -n "$C "; done; tput sgr0; echo;'


filterTrain(){
  grep -v "\[valid\]" | grep Cost | sed "s/^.*Up\. \([0-9]\+\) .* Cost \([0-9]\+\(\.[0-9]\+\)\?\) .*/\1\t\2/"
}
filterValidEnt(){
  grep "\[valid\]" | grep entropy | sed "s/^.*Up\. \([0-9]\+\) .* cross-entropy : \([0-9]\+\(\.[0-9]\+\)\?\) .*/\1\t\2/"
}
filterValidTrans(){
  grep "\[valid\]" | grep translation | sed "s/^.*Up\. \([0-9]\+\) .* translation : \([0-9]\+\(\.[0-9]\+\)\?\) .*/\1\t\2/"
}

getResults (){
  if [ ! -z "$1" ]; then
    host="$1"
    echo "$host" > .exp-home
  elif [ -f .exp-home ]; then
    host=`cat .exp-home`
  else
    echo "No experiment location given"
    exit 1
  fi
  mkdir -p logs
  rsync -av "$host"/*.log ./logs/
  if [ -f ./logs/train.log ]; then
    filterTrain < ./logs/train.log > train.loss.scores
    filterValidEnt < ./logs/train.log > valid.loss.scores
    filterValidTrans < ./logs/train.log > valid.bleu.scores
  else
    echo "train.log not found at $host"
    exit 1
  fi
}

alias el=exa
alias ela="exa -a"
alias ell="exa -l"
alias ella="exa -al"
alias elt="exa -T"
alias elg="exa --git -l --header"
alias elga="exa --git -al --header"

alias hs=homesick
