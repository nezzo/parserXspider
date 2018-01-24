<?php
require 'simple_html_dom.php';
require 'sql.php';

#TODO что бы найти  новый товар которого нету в базе, то нужно сделать так как сейчас пройдемся по всем ссылкам на сайте но  не добавляя категории а переходим в карточки товара и делаем поиск по артиклу и если его нет то выводим ссылку на товар

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
    	$parents_id = setCategoryInfoBikeland($a->plaintext);

    	//делаем проверку создалась ли категория, если да то присваиваем ее ид дочерним
    	if(!empty($parents_id)){
    		 getDaughterCategoryBikeland($parents_id, $url.$a->href);
    	}else{
    		break;
    	}
        
        
    }
  }

  //подчищаем за собой
  $html->clear();
  unset($html);
}

//создаем категории в базе, если передан параметр(parent_id то это дочерняя и заносим тогда ее в кэш)
function setCategoryInfoBikeland($name,$parent_id = false, $url = false){
  #TODO тут сделать 2 инсерта. Первый создает категорию и возвращает ее ид, а второй инсерт берет этот ид и заносит в кэш кетегори все делать по условию главное получить id категории. Еще тут надо будет разобраться с задвоением категорий, что бы при клике загрузить или обновить не задваивало категории а юзало теже самые только ид тянуло. Или же можно так  сделать на каждую сохраненную ссылку (кэш категории) сохранять .html а имя использовать ид строки кэша (защита от дублей) и тогда делаем с помощью форича пробег и вытягиваем ид строки а дальше по этому ид тянем файл по которому будем парсить, когда с файлом разобрались удаляем файл по имени и запись в базе по id но тут восстает другая проблема это пагинация в товаре + сам товар (карточка товара)

  //делаем проверку, что бы категория была с именем
  if(!empty($name)){

    $category_group_id = 1;
    $parent_id = (!empty($parent_id)) ? $parent_id : 1;
    $name = htmlentities($name);
    $nonDataStr = "";
    $nonDataInt = 0;
    $date_time = date("Y-m-d H:i:s");
    $slug = generate_chpu($name);
    $active = 1;
 
    /*Заносим введеные данные в базу*/
    $setCategory = DB::prepare("INSERT INTO category 
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
 	  $setCategory->execute();
      
      //возвращаем id добавленной категории
      $lastID = DB::lastInsertId();

      //проверяем, если ид передан значит это дочерняя категория и ее заносим в базу
      if(!empty($parent_id)){

      	//делаем проверку, получаем ли ссылку на дочернюю категорию, если все гуд то создаем кэш по дочерним категориям
      	if(!empty($url)){
      		$setCacheCategory = DB::prepare("INSERT INTO cache_category 
                            (parent_id,url) VALUES (:parent_id, :url)");

		    $setCacheCategory->bindParam(':parent_id', $lastID);
		    $setCacheCategory->bindParam(':url', $url);
  			$setCacheCategory->execute();
      	}

	  } 


  }
 
   return (!empty($lastID)) ? $lastID : false;
  }
  
 

//получаем id родителя и ссылку для перехода в родителя, что бы спарсить дочерние категории
function getDaughterCategoryBikeland($id, $url){

#TODO  в родительской категории идут дочерние и товары. Эти товары относяться к дочерним, то есть в родительской парсим дочерние категории, а после переходим в категорию и если там нету категорий то парсим товар и этот товар заносим в базу под категорию дочернюю и под родительскую. Делаем проверку если нету категорий и есть  список товара то сохраняем файл и парсим его (переходим по ссылкам в карточку товара и парсим все данные с карточки товара) и так доходим до конца списка по товарам, а дальше проверяем есть ли пагинация если есть то берем ссылку и переходим (старую страницу удаляем, а новую создаем). И так далее все парсим.

  $html = str_get_html(curl_get($url));
  $home = 'https://bikeland.ru';

  	//проверяем, что бы родительская категория была создана
 	if(!empty($id)){

        if($html->innertext!='' and count($html->find('.catalog_section_list .section_info li.name a'))){
	    foreach($html->find('.catalog_section_list .section_info li.name a') as $a){
	        setCategoryInfoBikeland($a->plaintext, $id, $home.$a->href);
	    }
	  }

	  //подчищаем за собой
	  $html->clear();
	  unset($html);
   	}
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