<?php
require 'simple_html_dom.php';
require 'sql.php';

#TODO что бы найти  новый товар которого нету в базе, то нужно сделать так как сейчас пройдемся по всем ссылкам на сайте но  не добавляя категории а переходим в карточки товара и делаем поиск по артиклу и если его нет то выводим ссылку на товар (способ не очень из-за того что артикул в разных местах с разными тегами, лучше делать поиск по  имени товара)

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

 
//запуск парсинга
//start();
 

//функция которая будет запускать скрипты в работу
function start(){
//вызываем функцию и передаем url для парсинга
//getParentsCategoryBikeland('https://bikeland.ru');



#TODO эту функцию надо перенести в getParentsCategoryBikeland в самый конец или в условие если удачно занеслись дочерние категории то в конце вызвать эту функцию по работе с дочерними категориями	

//получаем ид родителя и ссылку на дочернюю категорию для парсинга пагинации товара	
getDaughterCategoryBikeland();
}

//получаем ид родителя и ссылку на дочерние категории
function getDaughterCategoryBikeland(){

	//с базы получаем данные id родительской категории и ссылку на дочерню категорию
	$stmt = 'SELECT parent_id,url FROM cache_category';

	$stmt = DB::run($stmt);

	foreach($stmt as $data){
		//заносим в переменную инфу о том есть ли дочерние категории в текущей категории
		$dauth = setDaughterCategoryBikeland($data['parent_id'], $data['url']);

 		//если в дочерний категории не нашли дочерних категорий то парсим пагинацию
		if($dauth == false){
 			//добавляем ссылки в базу пагинации
			setPaginationUrl($data['parent_id'],$data['url']);
 		} 
    }

    #TODO тут надо будет заюзать еще один цикл почти такой же как сверху только ид родительской категории должен вытягивать с базы все ссылки на пагинации (по ид) и дальше делать переход по ссылки на товар (парсер) сохранять html код и заносить этот код в базу в таблицу cache_product ну и ид родиельской категории, когда дойдем конца списка пагинации по ид то удаляем с базы по ид категории все ссылки на пагинацию данной категории


    #TODO надо както придумать что бы ид категории родителя и ид категории дочерний был в 1 товар и это надо занести в базу, что бы товар отображался в двух категориях
 
 }

//в базу заносим ссылки на список товара категории (ссылки пагинации)
function setPaginationUrl($id,$url){

  	//делаем проверку данных, что бы не были пустыми
	if(!empty($id) && !empty($url)){
		$html = str_get_html(curl_get($url));
		$home = "https://bikeland.ru";
		$n = $html->find('.flex-nav-next  a');
		$prev = $html->find('.flex-nav-prev  a');
		$next = $home.$n[0]->href;

		
		//начиная с первой страницы заносим ее в базу
		if(empty($prev)){
			/*Заносим введеные данные в базу*/
			$setPagination = DB::prepare("INSERT INTO cache_pagination 
	                            (category_id, url) 
	                              VALUES (:category_id, :url)");
		 	$setPagination->bindParam(':category_id', $id);
		    $setPagination->bindParam(':url', $url);
		    $setPagination->execute();

		    
		}

		//если находим ссылку в пагинации на слудющую страницу то заносим ее в базу
		if(!empty($n)){

			/*Заносим введеные данные в базу*/
				$setPagination = DB::prepare("INSERT INTO cache_pagination 
		                            (category_id, url) 
		                              VALUES (:category_id, :url)");
			 	$setPagination->bindParam(':category_id', $id);
			    $setPagination->bindParam(':url', $next);
			    $setPagination->execute();

			//и так делаем в рекурсии пока есть ссылки в пагинации next    
  			setPaginationUrl($id,$next);
 		}else{

			return true;
		}
    }
}



 
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
      $setCategory->bindParam(':breadcrumbs_label', $name);
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
  
 

//заносим в базу дочерние категории
function setDaughterCategoryBikeland($id, $url){

#TODO  в родительской категории идут дочерние и товары. Тогда берем ид дочерний категории и начинаем парсить товар по этому id дочерней категории. При переходе на страницу с товаром то сохраняем html код в таблице cache_product где будет стоять рядом ид родителя категории и ид дочерней категории. Все действия делаем по ид дочерней категории. То есть делаем выборку по ид дочерней категории (товар) и парсим по html c таблице и так до конца списка выборки. Дальше делаем удаление по ид дочерней категории (товар, пагинацию и саму ссылку с cache_category).   
  
 
  $html = str_get_html(curl_get($url));
  $home = 'https://bikeland.ru';

  	//проверяем, что бы родительская категория была создана
 	if(!empty($id)){

 		//проверяем существует ли дочерние категории на странице, если нет то сохраняем html файл для парса
        if($html->innertext!='' and count($html->find('.catalog_section_list .section_info li.name a'))){
		    foreach($html->find('.catalog_section_list .section_info li.name a') as $a){
		        setCategoryInfoBikeland($a->plaintext, $id, $home.$a->href);
		    }

	      	//подчищаем за собой
		  	$html->clear();
		  	unset($html);
 		}else{
 			return false;
 		}

	  
   	}else{
 		return false;
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