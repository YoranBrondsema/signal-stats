# From https://unix.stackexchange.com/a/505009/413853
sigBase="${HOME}/.config/Signal/";
key=$( /usr/bin/jq -r '."key"' ${sigBase}config.json );
db="${HOME}/.config/Signal/sql/db.sqlite";
clearTextMsgs="${sigBase}clearTextMsgs.csv";

/usr/bin/sqlcipher -list -noheader "$db" "PRAGMA key = \"x'"$key"'\";select json from messages;" > "$clearTextMsgs";
