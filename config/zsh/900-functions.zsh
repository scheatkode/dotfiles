
function get-uid () { echo "$(id -u)" ; }

function is-root() {
   if [ x"0" != x"$(get-uid)" ] ; then
      return 1
   fi

   return 0
}

function quit-if-not-root () {
   if ! is-root ; then
      echo 'Must be run as root.'
      kill -INT $$
   fi
}

function drop-caches () {
   if ! is-root ; then
      sudo sh -c 'swapoff -a && swapon -a && echo 3 > /proc/sys/vm/drop_caches'
      return 0
   fi

   swapoff -a && swapon -a && echo 3 > /proc/sys/vm/drop_caches
}

function ascii-art () {
   echo "${@}" | awk '
BEGIN {

   font["0"][0] = ""
   font["1"][0] = ""
   font["2"][0] = ""
   font["3"][0] = ""
   font["4"][0] = ""
   font["5"][0] = ""
   font["6"][0] = ""
   font["7"][0] = ""
   font["8"][0] = ""
   font["9"][0] = ""
   font["a"][0] = ""
   font["b"][0] = ""
   font["c"][0] = ""
   font["d"][0] = ""
   font["e"][0] = ""
   font["f"][0] = ""
   font["g"][0] = ""
   font["h"][0] = ""
   font["i"][0] = ""
   font["j"][0] = ""
   font["k"][0] = ""
   font["l"][0] = ""
   font["m"][0] = ""
   font["n"][0] = ""
   font["o"][0] = ""
   font["p"][0] = ""
   font["q"][0] = ""
   font["r"][0] = ""
   font["s"][0] = ""
   font["t"][0] = ""
   font["u"][0] = ""
   font["v"][0] = ""
   font["w"][0] = ""
   font["x"][0] = ""
   font["y"][0] = ""
   font["z"][0] = ""
   font[" "][0] = ""
   font["-"][0] = ""

split("░▀█░x░░█░x░▀▀▀",   font["1"], "x")
split("░▀▀▄x░▄▀░x░▀▀▀",   font["2"], "x")
split("░▀▀█x░░▀▄x░▀▀░",   font["3"], "x")
split("░█░█x░░▀█x░░░▀",   font["4"], "x")
split("░█▀▀x░▀▀▄x░▀▀░",   font["5"], "x")
split("░▄▀▀x░█▀▄x░░▀░",   font["6"], "x")
split("░▀▀█x░▄▀░x░▀░░",   font["7"], "x")
split("░▄▀▄x░▄▀▄x░░▀░",   font["8"], "x")
split("░▄▀▄x░░▀█x░▀▀░",   font["9"], "x")
split("░▄▀▄x░█/█x░░▀░",   font["0"], "x")
split("░█▀█x░█▀█x░▀░▀",   font["a"], "x")
split("░█▀▄x░█▀▄x░▀▀░",   font["b"], "x")
split("░█▀▀x░█░░x░▀▀▀",   font["c"], "x")
split("░█▀▄x░█░█x░▀▀░",   font["d"], "x")
split("░█▀▀x░█▀▀x░▀▀▀",   font["e"], "x")
split("░█▀▀x░█▀▀x░▀░░",   font["f"], "x")
split("░█▀▀x░█░█x░▀▀▀",   font["g"], "x")
split("░█░█x░█▀█x░▀░▀",   font["h"], "x")
split("░▀█▀x░░█░x░▀▀▀",   font["i"], "x")
split("░▀▀█x░░░█x░▀▀░",   font["j"], "x")
split("░█░█x░█▀▄x░▀░▀",   font["k"], "x")
split("░█░░x░█░░x░▀▀▀",   font["l"], "x")
split("░█▄█x░█░█x░▀░▀",   font["m"], "x")
split("░█▀█x░█░█x░▀░▀",   font["n"], "x")
split("░█▀█x░█░█x░▀▀▀",   font["o"], "x")
split("░█▀█x░█▀▀x░▀░░",   font["p"], "x")
split("░▄▀▄x░█\\█x░░▀\\", font["q"], "x")
split("░█▀▄x░█▀▄x░▀░▀",   font["r"], "x")
split("░█▀▀x░▀▀█x░▀▀▀",   font["s"], "x")
split("░▀█▀x░░█░x░░▀░",   font["t"], "x")
split("░█░█x░█░█x░▀▀▀",   font["u"], "x")
split("░█░█x░▀▄▀x░░▀░",   font["v"], "x")
split("░█░█x░█▄█x░▀░▀",   font["w"], "x")
split("░█░█x░▄▀▄x░▀░▀",   font["x"], "x")
split("░█░█x░░█░x░░▀░",   font["y"], "x")
split("░▀▀█x░▄▀░x░▀▀▀",   font["z"], "x")
split("░░x░░x░░",         font[" "], "x")
split("░░░░x░▀▀▀x░░░░",   font["-"], "x")

}

{
   len = split($0, characters, "")

   for ( i = 1; i <= 3 ; i ++ ) {
      for ( j = 1; j <= len ; j ++ ) {
         printf font[characters[j]][i]
      }

      printf "\n"
   }
}
   '
}

function calc () {
   printf "%s\n" "${@}" | bc -l
}

function stopwatch () {
	local start; start="$(date '+%s')"

	while true;
	do
		time="$(( $(date '+%s') - start))"
		printf '%s\r' "$(date -u -d "@${time}" '+%H:%M:%S')"
		sleep 0.2
	done
}

function compress-pdf () {
	if ! command -v gs > /dev/null 2>&1
	then
		echo 'You need to install ghostscript to proceed'
		return 1
	fi

	if [ -z "${1}" ]
	then
		echo 'I need a file to work on'
		return 1
	fi

	for filename in "${@}"
	do
		__compress-one-pdf "${filename}"
	done
}

function __compress-one-pdf () {
	command gs                                    \
			-q                                      \
			-dNOPAUSE                               \
			-dBATCH                                 \
			-dSAFER                                 \
			-sDEVICE=pdfwrite                       \
			-dCompatibilityLevel=1.4                \
			-dPDFSETTINGS=/screen                   \
			-dEmbedAllFonts=true                    \
			-dSubsetFonts=true                      \
			-dColorImageDownsampleType=/Bicubic     \
			-dColorImageResolution=144              \
			-dGrayImageDownsampleType=/Bicubic      \
			-dGrayImageResolution=144               \
			-dMonoImageDownsampleType=/Bicubic      \
			-dMonoImageResolution=144               \
			-sOutputFile="${1%.pdf}_compressed.pdf" \
		"${1}"
}
