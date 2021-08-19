<?php
ini_set('max_execution_time', 0);
ini_set('memory_limit', -1);

$megen  = "\e[95m";
$cln    = "\e[0m";
$red    = "\e[91m";
$green  = "\e[92m";
echo "[>] Input the HOST/IP: ";
$host = trim(fgets(STDIN, 1024));
$ports = array(21, 22, 23, 51, 52, 53, 80, 443,);
echo "\n";
echo "Started scan on $host\n";
foreach ($ports as $port)
{
    $connection = @fsockopen($host, $port, $errno, $errstr, 2);

    if (is_resource($connection))
    {
        echo "      $port ";
        echo "$green\t\t [OPEN]$cln service --> ";
        echo "$megen";
        echo getservbyport($port, 'tcp');
        echo "$cln \n";
        
        fclose($connection);
    }
    else
    {
        echo "      $port $red\t\t [CLOSE]$cln\n";
    }
}

echo "Scan completed successfully!\n";
