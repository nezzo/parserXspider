 
<?php
//подключаем паттерн Builder
require_once("parser.php");
$start = new Chooser();
$bikeland = new BuilderBikeland();
//$drivebike = new BuilderDrivebike();
$start->setBuilderParser($bikeland);
$start->constructParser();
$realPhone = $start->getParserData();