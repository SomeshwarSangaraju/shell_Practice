TO_TEAM=$1
SUBJECT=$2
ALERT=$3
MESSAGE_BODY=$4
TO_ADDRESS=$5
IP_ADDRESS=$6
FORMATTED_BODY=$(printf '%s\n' "$MESSAGE_BODY" | sed -e 's/[]\/$*.^[]/\\&/g')

FINAL_BODY=$(sed -e "s/TO_TEAM/$TO_TEAM/g" -e "s/ALERT_TYPE/$ALERT_TYPE/g" -e "s/IP_ADDRESS/$IP_ADDRESS/g" -e "s/MESSAGE/$FORMATTED_BODY/g" template.html)

{
echo "To: $TO_ADDRESS"
echo "Subject: $SUBJECT"
echo "Content-Type: text/html"
echo ""
echo "$MESSAGE_BODY"
} | msmtp " $TO_ADDRESS "