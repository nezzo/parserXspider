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




#TODO данный скрипт идет как черновик и не стоит его пока оптимизировать, но вот что я думаю насчет пагинации. Может сохранять тоже html (возле ссылки) и распарсивать находу и заносить товар и ссылку (в пагинацию на следующую страницу) и html код заносить на следующую страницу и дальше так парсить, возможно нагрузка не будет такой большой
 
/* в списке товара получаем последнюю страницу пагинации(если поставить 5 то только когда не на первой странице)

$html = str_get_html(curl_get("https://bikeland.ru/mototekhnika/motorcycles/"));
$n = count($html->find('.nums  a')); 
$s = $html->find('.nums  a');

switch($n){
 
    case 2:
        $a = $s[1]->plaintext;
        break;
    case 3:
        $a = $s[2]->plaintext;
        break;

    case 4:
        $a = $s[3]->plaintext;
        break;  
}
$html->clear();
        unset($html);
  var_dump($a);
 //var_dump($s[2]->plaintext);
 */



//запуск парсинга
//start();

 

//функция которая будет запускать скрипты в работу
function start(){
//вызываем функцию и передаем url для парсинга
getParentsCategoryBikeland('https://bikeland.ru');

 
//получаем ид родителя и ссылку на дочернюю категорию для парсинга пагинации товара	
getDaughterCategoryBikeland();

//удаляем кэш
//clearCache();


}

//получаем ид родителя и ссылку на дочерние категории
function getDaughterCategoryBikeland(){

	//с базы получаем данные id родительской категории и ссылку на дочерню категорию
	$stmt = 'SELECT parent_id,category_id,url FROM cache_category';

	$stmt = DB::run($stmt);

	//в этот массив заносим category_id,parent_id
	$mas = [];

	foreach($stmt as $data){
	 
		//заносим в переменную инфу о том есть ли дочерние категории в текущей категории
		$dauth = setDaughterCategoryBikeland($data['category_id'], $data['url']);

 		//если в дочерний категории не нашли дочерних категорий то парсим пагинацию
		if($dauth == false){
 			//добавляем ссылки в базу пагинации
			setPaginationUrl($data['parent_id'],$data['category_id'],$data['url']);


 		} 
 	 

 		$mas[] = [
  			'parent_id' 	=> $data['parent_id'],
  			'category_id' 	=> $data['category_id'],
  			 
 		];
 	}
 
 	//передаем сюда category_id
 	getInfoCacheProducts($mas);

 	return true;
 }

//по ссылкам с пагинации заносим html и название товара в базу
function getInfoCacheProducts($mas){
	$home = "https://bikeland.ru";

	//формируем массив с данными для парсинга товара и внесения в базу cache_products
	$dat = [];
	$getInfoPagination = [];

	foreach($mas as $data){
		$getInfoPagination[] = [
			getPaginationUrl($data['category_id']),
			'parent_id' 	=> $data['parent_id'],
  			'category_id' 	=> $data['category_id'],

		]; 
 	}

 	foreach($getInfoPagination as $infoPagination){
			$dat[] = [
				'parent_id' 	=> $infoPagination['parent_id'],
  				'category_id' 	=> $infoPagination['category_id'],
  				'id'			=> $infoPagination['id'],
  				'url'			=> $infoPagination['url'],
			];
		}


	/*	
	//формируем массив данных с ссылками на товар и именем товара
	$cache_productsInfo = []; 

	foreach($dat as $d){
		$html = str_get_html(curl_get($d['url']));
		
		if($html->innertext!='' and count($html->find('.item-title a'))){
		    foreach($html->find('.item-title a') as $a){
		    	$cache_productsInfo[] = [
		    		'name'			=> htmlentities($a->plaintext),
		    		'url'			=> $home.$a->href,
		    		'parent_id' 	=> $d['parent_id'],
  					'category_id' 	=> $d['category_id'],
		    	];
		    }
		}
  	}

 	setCacheProducts($cache_productsInfo);
 	*/

 	var_dump($dat);

}

//заносим в таблицу кэша Товар
function setCacheProducts($data){

	//заносим в таблицу cache_products всю нужную информацию
	foreach($data as $dat){
		$html = curl_get($dat['url']);

		//проверяем что бы нам прилетел html код
		if(!empty($html)){
			$setPagination = DB::prepare("INSERT INTO cache_products 
	                            (parent_id,category_id, name, html) 
	                              VALUES (:parent_id, :category_id, :name, :html)");
		 	$setPagination->bindParam(':parent_id', $dat['parent_id']);
		 	$setPagination->bindParam(':category_id', $dat['category_id']);
		    $setPagination->bindParam(':name', $dat['name']);
		    $setPagination->bindParam(':html', $html);
		    $setPagination->execute();
		}
 	}
} 

//удаляем кэш
function clearCache(){

	$clearCache_category = "DELETE FROM  cache_category";
 	DB::run($clearCache_category);
 		 
   	$clearCache_pagination = "DELETE FROM cache_pagination";
 	DB::run($clearCache_pagination);

 	$clearCache_products = "DELETE FROM cache_products";
 	DB::run($clearCache_products);
 
}

//по категори ид получаем все ссылки с пагинации
function getPaginationUrl($id){

	//с базы получаем данные id строки и url
	$stmt = "SELECT id,url FROM cache_pagination WHERE category_id = $id";

	$stmt = DB::run($stmt);

	return $stmt;

}

//в базу заносим ссылки на список товара категории (ссылки пагинации)
function setPaginationUrl($parent_id,$category_id,$url){

  	//делаем проверку данных, что бы не были пустыми
	if(!empty($url)){
		$html = str_get_html(curl_get($url));
		$home = "https://bikeland.ru";
		$n = $html->find('.flex-nav-next  a');
		$prev = $html->find('.flex-nav-prev  a');
		$next = $home.$n[0]->href;

		
		//начиная с первой страницы заносим ее в базу
		if(empty($prev)){
			/*Заносим введеные данные в базу*/
			$setPagination = DB::prepare("INSERT INTO cache_pagination 
	                            (parent_id,category_id, url) 
	                              VALUES (:parent_id, :category_id, :url)");
		 	$setPagination->bindParam(':parent_id', $parent_id);
		 	$setPagination->bindParam(':category_id', $category_id);
		    $setPagination->bindParam(':url', $url);
		    $setPagination->execute();

		    
		}

		//если находим ссылку в пагинации на слудющую страницу то заносим ее в базу
		if(!empty($n)){

			/*Заносим введеные данные в базу*/
				$setPagination = DB::prepare("INSERT INTO cache_pagination 
		                            (parent_id,category_id, url) 
		                              VALUES (:parent_id, :category_id, :url)");
			 	$setPagination->bindParam(':parent_id', $parent_id);
		 		$setPagination->bindParam(':category_id', $category_id);
			    $setPagination->bindParam(':url', $next);
			    $setPagination->execute();

			//и так делаем в рекурсии пока есть ссылки в пагинации next    
  			setPaginationUrl($parent_id,$category_id,$next);
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
    		 setDaughterCategoryBikeland($parents_id, $url.$a->href);
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
 
 		//делаем проверку, получаем ли ссылку на дочернюю категорию, если все гуд то создаем кэш по дочерним категориям
      	if(!empty($url)){
      		$setCacheCategory = DB::prepare("INSERT INTO cache_category 
                           (parent_id,category_id,url) VALUES
                            (:parent_id, :category_id, :url)");

		    $setCacheCategory->bindParam(':parent_id', $parent_id);
		    $setCacheCategory->bindParam(':category_id', $lastID);
		    $setCacheCategory->bindParam(':url', $url);
  			$setCacheCategory->execute();
      	}
  	}
 
   return (!empty($lastID)) ? $lastID : false;
  }
  
 

//заносим в базу дочерние категории
function setDaughterCategoryBikeland($id, $url){

  $html = str_get_html(curl_get($url));
  $home = 'https://bikeland.ru';

  	//проверяем, что бы родительская категория была создана
 	if(!empty($id)){

 		//проверяем существует ли дочерние категории на странице
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