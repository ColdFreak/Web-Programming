<?php
/* Exercise 1 */
/* Write a simple PHP class which displays the following string. */ 
/* 'MyClass class has initialized!' */
/* 実行: $ php class_exercise.php */
/* class MyClass { */
/*     public function __construct() { */
/*         echo 'MyClass class has initialized!'; */
/*     } */
/* } */
/* $userclass = new MyClass; */

/* Exercise 2 */
/* Write a simple PHP class which display an introductory message like "Hello All, I am Scott" */
/* class user_message { */
/*     public $message = 'Hello All, I am '; */
/*     public function introduce($name) { */
/*         return $this->message.$name; */
/*     } */
/* } */
/* $mymessage = new user_message(); */
/* echo $mymessage->introduce('Scott'); */

/* Exercise 3 */
/* Write a PHP class that calculates the factorial of an integer */
/* class factorial_of_a_number { */
     /* protected scope when you want to make your variable/function visible in all classes that extend current class including the parent class.*/ 
/*     protected $_n; */
/*     public function __construct($n) { */
/*         if(!is_int($n)) { */
             /*Exception thrown if an argument is not of the expected type.*/ 
/*             throw new InvalidArgumentException('Not a number'); */
/*         } */
/*         $this->_n = $n; */
/*     } */
/*     public function result() { */
/*         $factorial = 1; */
/*         for ($i = 1; $i <= $this->_n; $i++) { */
/*             $factorial *= $i; */
/*         } */
/*         return $factorial; */
/*     } */
/* } */

/* $newfactorial = New factorial_of_a_number(5); */
/* echo $newfactorial->result(); */

/* Exercise 4 */
/* class array_sort { */
/*     protected $_asort; */
/*     public function __construct(array $asort) { */
/*         $this->_asort = $asort; */
/*     } */
/*     public function alhsort() { */
/*         $sorted = $this->_asort; */
/*         sort($sorted); */
/*         return $sorted; */
/*     } */
/* } */

/* $sortarray = new array_sort(array(11,-2, 4,35,0,8,-9)); */
/* print_r($sortarray->alhsort()); */

/* Exercise 5 */
/* Calculate the difference between two dates using PHP OOP approach */
/* $sdate = new DateTime("1981-11-03"); */
/* $edate = new DateTime("2013-09-04"); */

/* $interval = $sdate->diff($edate); */
/* echo "Difference : " . $interval->y . " years, " . $interval->m . " months, " . $interval->d . " days "; */

/* Exercise 6 */
/* convert '12-08-2004' to '2004-12-08' */
$dt = DateTime::createFromFormat('m-d-Y', '12-08-2004')->format('Y-m-d');
echo $dt;
?>
