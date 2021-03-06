<?php

header("Content-type: text/html; charset=utf-8");
header("Access-Control-Allow-Origin: *");

error_reporting(-1);
require_once 'connect.php';
require_once 'funcs.php';
require_once "Mobile_Detect.php";
$detect = new Mobile_Detect;

global $dbhost, $dbuser, $dbpassword, $dbname, $link;
ini_set('display_errors', 1);

//$link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);
//mysqli_set_charset($link,"utf8");

$is_auth = false;

// send all users from db
$users = get_all_users();  //возвращается массив

// send data from form

if(isset($_POST["phone"]) && isset($_POST["email"])) {


    clear();
    extract($_POST);

//ищем пользователя по в базе по email
    foreach ($users as $user) {
//        print('user='); //[0] id, [1] userId, [2] phone, [3] email
        $current_user_email = array_values($user)[3];
        //$current_user_id = array_values($user)[1];

//        var_dump($user);
//        var_dump(array_values($user)[3]);
        if ($current_user_email !== $email) {
            // if ($current_user_id !== $userId) {
//            print("такого ящика нет");

            continue;
        } else {
//            print("ящик найден в базе");
            $is_auth = true;
            break;
        }
    }

//    print('is_auth');
//    print($is_auth);

    // Выборка по полю работает
//    mysqli_stmt_prepare($stmt,"SELECT phone FROM users WHERE email = ?");
//    mysqli_stmt_bind_param($stmt,'s', $email);
//    mysqli_stmt_execute($stmt);
//    $mysqli_result = mysqli_stmt_get_result($stmt);
//
//    foreach($mysqli_result as $row) {
//        print($row);
//    }
    if( $is_auth == false) {

        $stmt = mysqli_stmt_init($link);
        //если пользвателя такого нет, то вставляем его втаблицу и считываем обратно его данные
        add_user();


        $newUser = get_user_by_email();
        
        $newUser["id"] = strval($newUser["id"]);
        $userId = $newUser["userId"];

        setcookie('uuid', $userId, time() + (3600 * 24 * 30), '/');
        
        //var_dump($newUser);
print(json_encode($newUser, JSON_UNESCAPED_SLASHES));
// print('after add new user create.php');
//  print($userId);


if ( $detect->isMobile() ) { 
    // Здесь пишем код header'a который будет выводиться для мобильных устройств
} else {
    // Здесь код, который выводится, если устройство не мобильное
    // if(isset($_COOKIE["uuid"])) {
    //     return;
    // } else {
    //     setcookie('uuid', $userId, time() + (3600 * 24 * 30), '/');
    // }
}


        
        return $newUser;

    } else {
        $stmt = mysqli_stmt_init($link);

        $existUser =  get_user_old(); //возвращает массив
//        print('after get_user_old');
//        print($existUser["userId"]);
        $userId = $existUser["userId"];
//
//        var_dump($existUser);

        setcookie('uuid', $userId, time() + (3600 * 24 * 30), '/');

//        $idExistUser = get_user($userId);

//        print('такой пользователь уже есть в таблице');

//        var_dump($idExistUser);
        $existUser["id"] = strval($existUser["id"]);
//        var_dump($existUser);
        print(json_encode($existUser, JSON_UNESCAPED_SLASHES));

        return $existUser;


    }



}

mysqli_close($link);

//INSERT INTO users (userId, phone, email) VALUES(uuid(), '111', '111')
