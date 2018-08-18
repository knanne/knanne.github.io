if [ $# -eq 0 ]
  then
    echo "Enter post shortcode:"
    read shortcode
else
  shortcode="$1"
fi

path="_includes\integrations\instagram_latest_photo.html"

echo "Fetching embed HTML of given post"
echo "Writing to $path"

curl -s "https://api.instagram.com/oembed/?url=http://instagr.am/p/$shortcode" | jq -r ".html" > "$path"

echo "Successfully wrote embed code to instagram_latest_photo.html"

echo "Type any key to close:"
read dummmy

echo "Closing"
