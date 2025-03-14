phpIPAM Contab in Proxmox

I found them here:

/opt/phpipam/functions/scripts/pingCheck.php
/opt/phpipam/functions/scripts/discoveryCheck.php

so the crontab -e would be this for the ping and discovery not sure about SNMP.

*/15 * * * * /usr/bin/php /opt/phpipam/functions/scripts/pingCheck.php
*/15 * * * * /usr/bin/php /opt/phpipam/functions/scripts/discoveryCheck.php
