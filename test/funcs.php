<?php
//функция очистки входных данных
function clear(){
	global $link;
	foreach ($_POST as $key => $value) {
		$_POST[$key] = mysqli_real_escape_string($link, $value);
	}
}

//функция втавки userId, phone, email
function add_user() {
    global $stmt;
    clear();
    extract($_POST);
//var_dump($_POST);

    mysqli_stmt_prepare($stmt, "INSERT INTO users (userId, phone, email) VALUES(uuid(), ?, ?)");
//    mysqli_stmt_prepare($stmt, "INSERT INTO users (userId, phone, email) VALUES(?, ?, ?)");
    mysqli_stmt_bind_param($stmt, 'ss',  $phone, $email);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_get_result($stmt);
    //print(mysqli_stmt_errno($stmt));
}

//функция  обновления username и birthday по login ?????
function edit_user() {
    //эта функция ничего не возвращает, обновляет данные в таблицу
    global $stmt;
    clear();
    extract($_POST);

    //mysqli_stmt_prepare($stmt, "INSERT INTO users (username, birthday) VALUES(?, ?)");

    mysqli_stmt_prepare($stmt, "UPDATE users SET username = ?, birthday = ? WHERE login = ?");
    mysqli_stmt_bind_param($stmt, 'sss',  $username, $birthday, $login);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_get_result($stmt);
    //print(mysqli_stmt_errno($stmt));
}

//функция обновления username и birthday по login
function get_user_by_login() {
    //эта функция ничего не возвращает

    extract($_POST);

    global $link;
    global $stmt;


    $stmt = mysqli_stmt_init($link);
    mysqli_stmt_prepare($stmt,"UPDATE users SET username = ?, birthday = ?, login = ? WHERE email = ?");
    mysqli_stmt_bind_param($stmt,'ssss', $username, $birthday, $login, $login);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_get_result($stmt);

//    print(mysqli_stmt_errno($stmt));

//    setcookie('TestCookie', $userId, time() + 3600, '/');
//    echo $_COOKIE["userId"];
}

function get_user_by_email() {

    extract($_POST);
//    var_dump($_POST);

    global $link;
    global $stmt;
    mysqli_stmt_prepare($stmt, "SELECT * FROM users WHERE email = ?");
    mysqli_stmt_bind_param($stmt, 's', $email);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);

//    print(mysqli_stmt_errno($stmt));

    $newUser = mysqli_fetch_all($mysqli_result);

//    var_dump($newUser);

    $userInfoArray = [];

    if ($mysqli_result) {
        $rowsCount = mysqli_num_rows($mysqli_result); // количество полученных строк
//        echo "<p>Получено объектов: $rowsCount</p>";

        foreach ($mysqli_result as $row) {
            $userInfoArray[] = $row;
//            echo "<td>" . $userid = $row["userId"];
//            echo "<td>" . $phone = $row["phone"];
//            echo "<td>" . $email = $row["email"];

        }
        echo(json_encode($userInfoArray[0]));
//        unset($userInfoArray[0]['id']);

        return $userInfoArray[0];
//

        } else {
            echo "Ошибка: " . mysqli_error($link);
        }
//    print(mysqli_stmt_errno($stmt));
}

//Выбор всех полей по  email
function get_user_all() {

    extract($_POST);

    global $link;
    global $stmt;
    mysqli_stmt_prepare($stmt,"SELECT * FROM users WHERE email = ?");
    mysqli_stmt_bind_param($stmt,'s', $login);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);

//    print(mysqli_stmt_errno($stmt));
//    $newUser = mysqli_fetch_all($mysqli_result);

//    var_dump($newUser);

    $userInfoArray =[];

    if($mysqli_result){
        $rowsCount = mysqli_num_rows($mysqli_result); // количество полученных строк
//        echo "<p>Получено объектов: $rowsCount</p>";

        foreach($mysqli_result as $row){
            $userInfoArray[] = $row;
//          echo $_COOKIE["TestCookie"];
        }


//        unset($userInfoArray[0]['id']);
//        echo(json_encode($userInfoArray[0]));

        return $userInfoArray[0];
//        print('новый пользователь');
//        print($new_user);
//
//        mysqli_free_result($mysqli_result); // освободить память
//
//        if($new_user) {
//            return $new_user;
//        }
    } else{
        echo "Ошибка: " . mysqli_error($link);
    }
}

function get_user($userId) {

    global $link;
    global $stmt;
    mysqli_stmt_prepare($stmt,"SELECT * FROM users WHERE userId = ?");
    mysqli_stmt_bind_param($stmt,'s', $userId);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);

//    $newUser = mysqli_fetch_all($mysqli_result);

//    var_dump($newUser);
    //print(mysqli_stmt_errno($stmt)); show code error

    $userInfoArray =[];

    if($mysqli_result){
        $rowsCount = mysqli_num_rows($mysqli_result); // количество полученных строк
//         echo "<p>Получено объектов: $rowsCount</p>";

        foreach($mysqli_result as $row){
            $userInfoArray[] = $row;
//            echo "<td>" . $userid = $row["userId"];
//            echo "<td>" . $phone = $row["phone"];
//            echo "<td>" . $email = $row["email"];

//            setcookie('TestCookie', $row["userId"], time() + 3600, '/');
//            print($userInfoArray["userId"]);
//            echo $_COOKIE["TestCookie"];
        }



//        var_dump($userInfoArray[0]);
        print(json_encode($userInfoArray[0]));
        return $userInfoArray[0];
//        print('новый пользователь');
//        print($new_user);
//
//        mysqli_free_result($mysqli_result); // освободить память
//
//        if($new_user) {
//            return $new_user;
//        }
    } else{
        echo "Ошибка: " . mysqli_error($link);
    }
}

function get_user_old() {
    extract($_POST);
//    print('get_usr_old');
//    print($email);
    global $link;
    global $stmt;
    mysqli_stmt_prepare($stmt,"SELECT * FROM users WHERE email = ?");
    mysqli_stmt_bind_param($stmt,'s', $email);
    mysqli_stmt_execute($stmt);
    $mysqli_result = mysqli_stmt_get_result($stmt);

//    $newUser = mysqli_fetch_all($mysqli_result);
//    print('user fetch all');
//    var_dump($newUser);

    $userInfoArray =[];

    if($mysqli_result){
        $rowsCount = mysqli_num_rows($mysqli_result); // количество полученных строк
//        echo "<p>Получено объектов: $rowsCount</p>";

        foreach($mysqli_result as $row){
            $userInfoArray[] = $row;
//            echo "<td>" . $userid = $row["userId"];
//            echo "<td>" . $phone = $row["phone"];
//            echo "<td>" . $email = $row["email"];
        }

        $userId = $userInfoArray[0];
//        print($userId);
//setcookie('TestCookie', $userId, time() + 3600, '/');



                return $userInfoArray[0];
//        print('новый пользователь');
//        print($new_user);
//
//        mysqli_free_result($mysqli_result); // освободить память
//
//        if($new_user) {
//            return $new_user;
//        }
    } else{
        echo "Ошибка: " . mysqli_error($link);
    }


}



function save_mess(){
	global $link;
	clear();
	extract($_POST);
	// $name = mysqli_real_escape_string($db, $_POST['name']);
	// $text = mysqli_real_escape_string($db, $_POST['text']);
	$query = "INSERT INTO users (name, text) VALUES ('$name', '$text')";
	mysqli_query($link, $query);
}

// Функция получения всех пользователей из таблицы, возвращает массив
function get_all_users(){

	global $link;
	$query = "SELECT * FROM users";
	$result = mysqli_query($link, $query);
    //$users = mysqli_fetch_all($result);
    $users = array();
//    while($r = mysqli_fetch_array($result)) {
//        $users[] = $r;
//    }
    if($result){
        $rowsCount = mysqli_num_rows($result); // количество полученных строк
//        echo "<p>Получено объектов: $rowsCount</p>";

        foreach($result as $row){
            $users[] = $row;
//            echo "<td>" . $userid = $row["userId"];
//            echo "<td>" . $phone = $row["phone"];
//            echo "<td>" . $email = $row["email"];
        }



//          print($users);
        $file = "../assets/assets/users.json";
        $users_obj = '{"users" : ' . json_encode($users) . '}';
        $data_file = file_put_contents($file, $users_obj);

//        var_dump($users);
        return ($users);


    } else{
        echo "Ошибка: " . mysqli_error($link);
    }
    //echo json_encode($users);
//    print('users\n');
//    var_dump(json_encode($users));
//    $users = json_encode($users);
//    echo($users);
//    return $users;
	//return json_encode($users);

}

function users_to_obj () {
    $users_obj = get_all_users();
    $users_obj = json_encode( $users_obj);
    $users_obj = '{"users" : ' . $users_obj . '}';

    echo($users_obj);
    return $users_obj;
}

function print_arr($arr){
	echo '<pre>' . print_r($arr, true) . '</pre>';
}