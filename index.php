<?php
require 'simple_html_dom.php';
require 'sql.php';


//по курлу получаем  страницу нужную для парса 
function curl_get($url = "", $referer = 'http://www.google.com') {
  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, $url);
  curl_setopt($ch, CURLOPT_HEADER, 0);
  curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 6.1; WOW64; ry: 38.0) Gecko/20100101 Firefox/38.0");
  curl_setopt($ch, CURLOPT_REFERER, $referer);
  curl_setopt ($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
  curl_setopt ($ch, CURLOPT_RETURNTRANSFER, TRUE);
  $data = curl_exec($ch);
  curl_close($ch);
  return $data;
}

#TODO htmlentities надо заюзать в именах категорий и товара, что бы не было ошибок sql


//вызываем функцию и передаем url для парсинга
getParentsCategoryBikeland('https://bikeland.ru');

//получаем родительские категории
function getParentsCategoryBikeland($url){
  $html = str_get_html(curl_get($url));
 
  if($html->innertext!='' and count($html->find('.catalogfirst a.icons_fa'))){
    foreach($html->find('.catalogfirst a.icons_fa') as $a){
        //getDaughterCategoryBikeland($a->plaintext, $url.$a->href);
        setParentsCategoryBikeland($a->plaintext, $url.$a->href);
    }
  }

  //подчищаем за собой
  $html->clear();
  unset($html);
}

//добавляем родительские категории в базу и вносим инфу в кэш о дочерних категориях
function setParentsCategoryBikeland($name, $url){
  #TODO тут сделать 2 инсерта. Первый создает категорию и возвращает ее ид, а второй инсерт берет этот ид и заносит в кэш кетегори все делать по условию главное получить id категории. Еще тут надо будет разобраться с задвоением категорий, что бы при клике загрузить или обновить не задваивало категории а юзало теже самые только ид тянуло. Или же можно так  сделать на каждую сохраненную ссылку (кэш категории) сохранять .html а имя использовать ид строки кэша (защита от дублей) и тогда делаем с помощью форича пробег и вытягиваем ид строки а дальше по этому ид тянем файл по которому будем парсить, когда с файлом разобрались удаляем файл по имени и запись в базе по id но тут восстает другая проблема это пагинация в товаре + сам товар (карточка товара)

  //делаем проверку, что бы категория была с именем
  if(!empty($name)){

    $category_group_id = 1;
    $parent_id = 1;
    $name = htmlentities($name);
    $nonDataStr = "";
    $nonDataInt = 0;
    $date_time = date("Y-m-d H:i:s");
    $slug = generate_chpu($name);
    $active = 1;

    /*Заносим введеные данные в базу*/
    $model = new Model();
    $setCategory = $model->connect()->prepare("INSERT INTO category 
                            (category_group_id, parent_id,name,title,h1,meta_description,breadcrumbs_label,slug,slug_compiled,slug_absolute,content,announce,sort_order,title_append,active,date_added,date_modified) 
                              VALUES (:category_group_id, :parent_id, :name, :title, :h1, :meta_description, :breadcrumbs_label, :slug, :slug_compiled, :slug_absolute, :content, :announce, :sort_order, :title_append, :active, :date_added, :date_modified)");
      $setCategory->bindParam(':category_group_id', $category_group_id);
      $setCategory->bindParam(':parent_id', $parent_id);
      $setCategory->bindParam(':name',$name);
      $setCategory->bindParam(':title', $name);
      $setCategory->bindParam(':h1', $name);
      $setCategory->bindParam(':meta_description', $nonDataStr);
      $setCategory->bindParam(':breadcrumbs_label', $nonDataStr);
      $setCategory->bindParam(':slug', $slug);
      $setCategory->bindParam(':slug_compiled', $nonDataStr);
      $setCategory->bindParam(':slug_absolute', $nonDataInt);
      $setCategory->bindParam(':content', $nonDataStr);
      $setCategory->bindParam(':announce', $nonDataStr);
      $setCategory->bindParam(':sort_order', $nonDataInt);
      $setCategory->bindParam(':title_append', $nonDataStr);
      $setCategory->bindParam(':active', $active);
      $setCategory->bindParam(':date_added', $date_time);
      $setCategory->bindParam(':date_modified', $date_time);

      #TODO тут надо будет разобраться почему не выводит последний добавленный ид
      $s = $model->connect()->lastInsertId();
      $setCategory->execute();

   
   var_dump($s);
  }

}

//получаем дочерние категории и заносим в базу категории (все)
function getDaughterCategoryBikeland($name, $url){

  $html = str_get_html(curl_get($url));


 
  if($html->innertext!='' and count($html->find('.catalogfirst a.icons_fa'))){
    foreach($html->find('.catalogfirst a.icons_fa') as $a){
        getDaughterCategoryBikeland($a->plaintext, $url.$a->href);
    }
  }

  //подчищаем за собой
  $html->clear();
  unset($html);
   
}

//заносим всю инфу для создания категории
function setCategoryInfoBikeland(){

}

//генерирует ЧПУ
function generate_chpu ($str)
    {
    $converter = array(
          'а' => 'a',   'б' => 'b',   'в' => 'v',
          'г' => 'g',   'д' => 'd',   'е' => 'e',
          'ё' => 'e',   'ж' => 'zh',  'з' => 'z',
          'и' => 'i',   'й' => 'y',   'к' => 'k',
          'л' => 'l',   'м' => 'm',   'н' => 'n',
          'о' => 'o',   'п' => 'p',   'р' => 'r',
          'с' => 's',   'т' => 't',   'у' => 'u',
          'ф' => 'f',   'х' => 'h',   'ц' => 'c',
          'ч' => 'ch',  'ш' => 'sh',  'щ' => 'sch',
          'ь' => '',    'ы' => 'y',   'ъ' => '',
          'э' => 'e',   'ю' => 'yu',  'я' => 'ya',
 
          'А' => 'A',   'Б' => 'B',   'В' => 'V',
          'Г' => 'G',   'Д' => 'D',   'Е' => 'E',
          'Ё' => 'E',   'Ж' => 'Zh',  'З' => 'Z',
          'И' => 'I',   'Й' => 'Y',   'К' => 'K',
          'Л' => 'L',   'М' => 'M',   'Н' => 'N',
          'О' => 'O',   'П' => 'P',   'Р' => 'R',
          'С' => 'S',   'Т' => 'T',   'У' => 'U',
          'Ф' => 'F',   'Х' => 'H',   'Ц' => 'C',
          'Ч' => 'Ch',  'Ш' => 'Sh',  'Щ' => 'Sch',
          'Ь' => '',    'Ы' => 'Y',   'Ъ' => '',
          'Э' => 'E',   'Ю' => 'Yu',  'Я' => 'Ya',
    );
    $str = strtr($str, $converter);
    $str = strtolower($str);
    $str = preg_replace('~[^-a-z0-9_]+~u', '-', $str);
    $str = trim($str, "-");
    return $str;
    }

?> 