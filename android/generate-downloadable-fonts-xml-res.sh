#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Please specify 1 or more font family name found on Google Fonts"
  echo
  echo "Usage: ./`basename "$0"` \"Jetbrains Mono\" Inconsolata"
  exit 1
fi

# Create fonts/ and values folders
mkdir fonts values

# Create fonts/font_name_in_lowercase.xml files
for i in "$@"
do
  filename=`echo "${i// /_}.xml" | tr "[:upper:]" "[:lower:]"`
  cat > fonts/$filename<< EOF
<?xml version="1.0" encoding="utf-8"?>
<font-family
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:fontProviderAuthority="com.google.android.gms.fonts"
    android:fontProviderCerts="@array/com_google_android_gms_fonts_certs"
    android:fontProviderPackage="com.google.android.gms"
    android:fontProviderQuery="$i"
    app:fontProviderAuthority="com.google.android.gms.fonts"
    app:fontProviderCerts="@array/com_google_android_gms_fonts_certs"
    app:fontProviderPackage="com.google.android.gms"
    app:fontProviderQuery="$i"
    />
EOF
done

# Create values/preloaded_fonts.xml file
preloaded_fonts_file_name="preloaded_fonts.xml"
cat > values/$preloaded_fonts_file_name<< EOF
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <array name="preloaded_fonts" translatable="false">
EOF

for i in "$@"
do
  font_name_in_lowercase=`echo "${i// /_}" | tr "[:upper:]" "[:lower:]"`
  cat >> values/$preloaded_fonts_file_name<<EOF
        <item>@font/$font_name_in_lowercase</item>
EOF
done

cat >> values/$preloaded_fonts_file_name<< EOF
    </array>
</resources>
EOF
