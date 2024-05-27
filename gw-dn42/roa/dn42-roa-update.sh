#!/bin/bash
roa4URL="https://dn42.burble.com/roa/dn42_roa_bird2_4.conf"
roa6URL="https://dn42.burble.com/roa/dn42_roa_bird2_6.conf"

roa4FILE="/etc/bird/roa/roa_dn42.conf"
roa6FILE="/etc/bird/roa/roa_dn42_v6.conf"

cp "${roa4FILE}" "${roa4FILE}.old"
cp "${roa6FILE}" "${roa6FILE}.old"

if curl -f -o "${roa4FILE}.new" "${roa4URL}" ;then
    diff "${roa4FILE}.new" "${roa4FILE}"
    mv "${roa4FILE}.new" "${roa4FILE}"
fi

if curl -f -o "${roa6FILE}.new" "${roa6URL}" ;then
    diff "${roa6FILE}.new" "${roa6FILE}"
    mv "${roa6FILE}.new" "${roa6FILE}"
fi

if birdc configure ; then
    rm "${roa4FILE}.old"
    rm "${roa6FILE}.old"
else
    mv "${roa4FILE}.old" "${roa4FILE}"
    mv "${roa6FILE}.old" "${roa6FILE}"
fi
