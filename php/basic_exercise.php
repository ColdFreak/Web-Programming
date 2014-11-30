<?php
/* exercise 1 */

/* $marks1 = array(360,310,310,330,313,375,456,111,256); */ 
/* $marks2 = array(350,340,356,330,321); */ 
/* $marks3 = array(630,340,570,635,434,255,298); */
/* $max_marks = max(max($marks1), max($marks2), max($marks3)); */
/* $min_marks = min(min($marks1), min($marks2), min($marks3)); */
/* echo "$max_marks"; */
/* echo "$min_marks"; */

/* exercise 2 */

/* echo round( 1.65, 1, PHP_ROUND_HALF_UP).'<br>'; */
/* echo round( 1.65, 1, PHP_ROUND_HALF_DOWN).'<br>'; */
/* echo round( -1.54, 1, PHP_ROUND_HALF_EVEN).'<br>'; */
/* echo round( -1.54, 1, PHP_ROUND_HALF_ODD).'<br>'; */

/* exercise 3 */
/* Write a simple PHP browser detection script. */
/* Sample Output : Your User Agent is :Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36 */

/* echo "Your User Agent is : ". $_SERVER['HTTP_USER_AGENT'] */

/* exercise 4 */
/* Write a PHP script to get the current file name. */
/* $current_file_name = basename($_SERVER['PHP_SELF']); */

/* echo $current_file_name; */

/* exercise 5 */
/* Write a PHP script, which will return the following components of the url */
/* 'http://www.w3resource.com/php-exercises/php-basic-exercises.php'. */ 
/* List of components : Scheme, Host, Path */
/* Expected Output : */ 
/* Scheme : http */
/* Host : www.w3resource.com */
/* Path : /php-exercises/php-basic-exercises.php */

/* $url = 'http://www.w3resource.com/php-exercises/php-basic-exercises.php#sthash.JdgQVjnj.dpuf'; */
/* $url = parse_url($url); */
/* echo 'Scheme : '. $url['scheme']. '<br />'; */
/* echo 'Host : '. $url['host']. '<br />'; */
/* echo 'Path : '. $url['path']. '<br />'; */

/* exercise 6 */
/* Write a PHP script, to check whether the page is called from 'https' or 'http' */

/* if (!empty($_SERVER['HTTPS'])) { */
/*     echo 'HTTPS is enabled'; */
/* }else { */
/*     echo 'http is enabled'; */
/* } */

/* exercise 7 */
/* Write a PHP script to redirect a user to a different page . */
/* Expected output : Redirect the user to http://www.w3resource.com/ */

/* header('Location: http://www.w3resource.com/'); */

/* exercise 8 */
/* Write a simple PHP program to check that emails are valid. */ 
/* Hints : Use FILTER_VALIDATE_EMAIL filter that validates value as an e-mail address. Note : The PHP documentation does not saying that FILTER_VALIDATE_EMAIL should pass the RFC5321. */ 

/* $email = "mail@example.com"; */
/* if (filter_var($email, FILTER_VALIDATE_EMAIL)) { */
/*     echo '"' . $email . '" = Valid'; */
/* } else { */
/*     echo '"' . $email . '" = Invalid'; */
/* } */

/* exercies 9 */
/* Write a e PHP script to display source code of a webpage */ 

/* $all_lines = file('http://www.example.com/'); */
/* foreach( $all_lines as $line_num => $line) { */
/*     echo "Line No.-{$line_num}: " . htmlspecialchars($line). "<br />\n"; */
/* } */

/* exercise 10 */
/* Write a PHP script to get last modified information of a file. */
/* Sample filename : php-basic-exercises.php */
/* Sample Output : Last modified Monday, 09th June, 2014, 06:45am */ 

/* $file_last_modified = filemtime(basename($_SERVER['PHP_SELF'])); */
/* echo "Last modified: " . date("l, dS F, Y, h:id", $file_last_modified); */

/* exercise 11 */
/* Write a PHP script to count lines in a file. */
/* Note : Store a text file name into a variable and count the number of lines of text it has. */

/* $file = basename($_SERVER['PHP_SELF']); */
/* $no_of_lines = count(file($file)); */
/* echo "There are $no_of_lines lines in $file"; */

/* exercise 12 */
/* $x = array(1, 2, 3, 4, 5); */
/* Delete an element from the above PHP array. After deleting the element, integer keys must be normalized. */
/* array_values() returns all the values from the array and indexes the array numerically. */

/* $x = array(1, 2, 3, 4, 5); */
/* var_dump($x); */
/* unset($x[3]); */
/* echo '<br>'; */
/* $x = array_values($x); */
/* var_dump($x); */

/* exercise 13 */
/* $color = array(4 => 'white', 6 => 'green', 11=> 'red'); */
/* Write a PHP script to to get the first element of the above array. */ 
/* reset() rewinds array's internal pointer to the first element and returns the value of the first array element. */

/* $color = array(4 => 'white', 6 => 'green', 11=> 'red'); */
/* echo reset($color); */

/* exercise 14 */
/* Write a PHP script to sort the following associative array */ 
/* value値でソートする */
/* array("Sophia"=>"31","Jacob"=>"41","William"=>"39","Ramesh"=>"40") in 
 * ascending order sort by value */ 

/* $array = array("Sophia"=>"31","Jacob"=>"41","William"=>"39","Ramesh"=>"40"); */
/* asort($array); */
/* foreach ($array as $key => $value) { */
/*     echo "Age of ". $key. " is : " . $value . "<br />"; */
/* } */

/* exercise 15 */
/* Write a PHP script to generate unique random numbers within a range. */ 

/* $n = range(11, 20); */
/* shuffle($n); */
/* foreach($n as $item){ */
/*     echo $item . "<br />"; */
/* } */

/* exercise 16 */
/* Write a PHP script to get the shortest/longest string length from an array. */ 

/* $my_array = array("abcd","abc","de","hjjj","g","wer"); */
/* $new_array = array_map('strlen', $my_array); */
/* echo "The shortest array length is ". min($new_array) . "<br />"; */
/* echo "The longest array length is ". max($new_array) . "<br />"; */

/* exercise 17 */
/* Write a PHP script to split the following string. */
/* Sample string: '082307' */
/* Expected Output: 08:23:07 */
/* 最後の':'欲しくないからsubstrに-1を指定する */

/* $str = '082307'; */
/* echo substr(chunk_split($str, 2, ':'), 0, -1); */

/* exercise 18 */
/* Write a PHP script to convert the value of a PHP variable to string */

/* $x = 20; */
/* $str = (string)$x; */
/* if ($x === $str) { */
/*     echo "They are the same"; */
/* } else { */
/*     echo "They are not the same"; */
/* } */
?>
