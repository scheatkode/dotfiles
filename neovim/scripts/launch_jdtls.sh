#!/bin/sh

# NOTE: This doesn't work as is on Windows. You'll need to create an
#       equivalent `.bat` file instead
#
# NOTE: If you're not using Linux you'll need to adjust the `-configuration`
#       option to point to the `config_mac' or `config_win` folders depending on
#       your system.

cache_dir="${XDG_CACHE_HOME:-${HOME}/.cache}"

mkdir --parent ${cache_dir}/java/workspace 2> /dev/null
cp -Rf /usr/share/java/jdtls/config_linux ${cache_dir}/java/

JAR="/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
JAVA_HOME="$(readlink -f /usr/bin/java | sed "s:/bin/java::")"
GRADLE_HOME="${cache_dir}/gradle"                   \
   /usr/lib/jvm/default/bin/java                    \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4                \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true                               \
  -Dlog.level=ALL                                   \
  -Xms1g                                            \
  -Xmx2G                                            \
  -jar $(echo "${JAR}")                             \
  -configuration "${cache_dir}/java/config_linux"   \
  -data "${1:-${cache_dir}/java/workspace}"         \
  --add-modules=ALL-SYSTEM                          \
  --add-opens java.base/java.util=ALL-UNNAMED       \
  --add-opens java.base/java.lang=ALL-UNNAMED

