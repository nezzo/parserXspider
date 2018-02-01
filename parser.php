<?php
require 'simple_html_dom.php';
require 'sql.php';

#TODO возможно эту прогу запускать только из консоли, что бы не создавала такой большой нагрузки


//подключаем Builder
class Parser{
	private $_category;
	private $_pagination;
	private $_product;

	public function setCategory($data){
		$this->_category = $data;
	}

	public function setPagination($data){
		$this->_pagination = $data;
	}

	public function setProduct($data){
		$this->_product = $data;
	}

	public function curl_get($url = "", $referer = 'http://www.google.com') {
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

	//создаем категории в базе, если передан параметр(parent_id то это дочерняя и заносим тогда ее в кэш. Параметры: $name,$parent_id = false, $url = false
	public function setCategoryInfo($mas){

		$dat = [];
	 	foreach ($mas as $data){

	 	  //делаем проверку, что бы категория была с именем
		  if(!empty($data['name'])){

		    $category_group_id = 1;
		    $parent_id = (!empty($data['id'])) ? $data['id'] : 1;
		    $name = htmlentities($data['name']);
		    $nonDataStr = "";
		    $nonDataInt = 0;
		    $date_time = date("Y-m-d H:i:s");
		    $slug = $this->generate_chpu($data['name']);
		    $active = 1;
		    $url = (!empty($data['url'])) ? $data['url'] : false;
		    $parent_url = (!empty($data['parent_url'])) ? $data['parent_url'] : false;
 			
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

		      	$dat [] = [
		      		'id' 	=> $lastID,
		      		'parent_url'	=> $parent_url,			
		      	];
		  	}

	 	}

 		return $dat;
 	}

 	//заносим в базу ссылки на пагинацию
 	public function setPaginationUrl($parent_id,$category_id,$url){

 		if(!empty($parent_id) && !empty($category_id) && !empty($url)){
	 		/*Заносим введеные данные в базу*/
			$setPagination = DB::prepare("INSERT INTO cache_pagination 
			                            (parent_id,category_id, url) 
			                              VALUES (:parent_id, :category_id, :url)");
			$setPagination->bindParam(':parent_id', $parent_id);
			$setPagination->bindParam(':category_id', $category_id);
			$setPagination->bindParam(':url', $url);
			$setPagination->execute();
		}
 	}

 	//подготовленные данные заносим в кэш продутка
 	public function setCacheHtmlProducts($data){

 		if(!empty($data)){
 			foreach($data as $dat){
 				$setCacheHtml = DB::prepare("INSERT INTO cache_products 
	                            (parent_id,category_id, name, html) 
	                              VALUES (:parent_id, :category_id, :name, :html)");
			 	$setCacheHtml->bindParam(':parent_id', $dat['parent_id']);
			 	$setCacheHtml->bindParam(':category_id', $dat['category_id']);
			    $setCacheHtml->bindParam(':name', $dat['name']);
			    $setCacheHtml->bindParam(':html', $dat['html']);
			    $setCacheHtml->execute();
 			}
 		}

 		return true;
 			
 	}

 	//функция по созданию продукта в базе
 	public function createProduct($mas){

 		if(!empty($mas)){
 			$parent_id = 0;
 			$zero = 0;
 			$empt = "";
 			$active = 1;
 			$one = 1;
 			$option_generate = "";

 			foreach($mas as $data){
 				$category_id = (!empty($data['category_id'])) ? $data['category_id'] : 1;
 				$parent_category_id = (!empty($data['parent_category_id'])) ? $data['parent_category_id'] : "";
 				$name = (!empty($data['name'])) ? htmlentities($data['name']) : "";
 				$desc = (!empty($data['desc'])) ? $data['desc'] : "";
 				$charact = (!empty($data['charact'])) ? $data['charact'] : "";
 				$price = (!empty($data['price'])) ? $data['price'] : 0;
 				$date_time = date("Y-m-d H:i:s");
 				$sku = (!empty($data['sku'])) ? $data['sku'] : "";
 				$images = (!empty($data['image'])) ? $data['image'] : "";
 				$slug = $this->generate_chpu($name);
 
 				//заносим данные в таблицу product
 				$setCreateProduct = DB::prepare("INSERT INTO product 
 					(main_category_id,parent_id,option_generate,name,title,h1,meta_description,breadcrumbs_label,slug,slug_compiled,slug_absolute,content,announce,sort_order,active,price,old_price,sku,unlimited_count,currency_id,measure_id,date_added,date_modified) 

			                              VALUES (:main_category_id,:parent_id,:option_generate, :name,:title, :h1,:meta_description,:breadcrumbs_label,:slug, :slug_compiled, :slug_absolute,:content,:announce,:sort_order, :active,:price,:old_price,:sku,:unlimited_count,:currency_id,:measure_id,:date_added,:date_modified)");
				$setCreateProduct->bindParam(':main_category_id', $category_id);
				$setCreateProduct->bindParam(':parent_id', $parent_id);
				$setCreateProduct->bindParam(':option_generate', $option_generate);
				$setCreateProduct->bindParam(':name', $name);
				$setCreateProduct->bindParam(':h1', $name);
 				$setCreateProduct->bindParam(':title', $name);
				$setCreateProduct->bindParam(':meta_description', $name);
				$setCreateProduct->bindParam(':breadcrumbs_label', $name);
				$setCreateProduct->bindParam(':slug', $slug);
				$setCreateProduct->bindParam(':slug_compiled', $empt);
				$setCreateProduct->bindParam(':slug_absolute', $zero);
				$setCreateProduct->bindParam(':content', $charact);
				$setCreateProduct->bindParam(':announce', $desc);
				$setCreateProduct->bindParam(':sort_order', $zero);
				$setCreateProduct->bindParam(':active', $active);
				$setCreateProduct->bindParam(':price', $price);
				$setCreateProduct->bindParam(':old_price', $zero);
				$setCreateProduct->bindParam(':sku', $sku);
				$setCreateProduct->bindParam(':unlimited_count', $one);
				$setCreateProduct->bindParam(':currency_id', $one);
				$setCreateProduct->bindParam(':measure_id', $one);
				$setCreateProduct->bindParam(':date_added', $date_time);
				$setCreateProduct->bindParam(':date_modified', $date_time);
 				$setCreateProduct->execute();

				//возвращаем id добавленого товара
		      	$lastID = DB::lastInsertId();


		      	//если товар на сайте добавлен в родительскую категорию то и значит добавляем так же
		      	if(!empty($parent_category_id)){
		      		$setParentCategory = DB::prepare("INSERT INTO product_category 
	                            (category_id,object_model_id,sort_order) 
	                              VALUES (:category_id, :object_model_id, :sort_order)");
				 	$setParentCategory->bindParam(':category_id', $parent_category_id);
				 	$setParentCategory->bindParam(':object_model_id', $lastID);
				    $setParentCategory->bindParam(':sort_order', $zero);
 				    $setParentCategory->execute();
		      	}

		      		$setParentCategory1 = DB::prepare("INSERT INTO product_category 
	                            (category_id,object_model_id,sort_order) 
	                              VALUES (:category_id, :object_model_id, :sort_order)");
				 	$setParentCategory1->bindParam(':category_id', $category_id);
				 	$setParentCategory1->bindParam(':object_model_id', $lastID);
				    $setParentCategory1->bindParam(':sort_order', $zero);
 				    $setParentCategory1->execute();

 
 				    //если есть данные о картинках в товаре то заносим эту инфу в базу
 				    if(!empty($images)){
			 			$object_id = 1; #TODO надо будет узнать, что это поле означает
			 			foreach($images as $image){
 			 				$filename = $this->setImageName("https://bikeland.ru",$image->href);
 							
 							$setImage = DB::prepare("INSERT INTO image 
				                            (object_id,object_model_id,filename,image_title,sort_order,image_alt) 
				                              VALUES (:object_id, :object_model_id,:filename,:image_title, :sort_order,:image_alt)");
							$setImage->bindParam(':object_id', $object_id);
							$setImage->bindParam(':object_model_id', $lastID);
							$setImage->bindParam(':filename', $filename);
							$setImage->bindParam(':image_title', $filename);
							$setImage->bindParam(':sort_order', $zero);
							$setImage->bindParam(':image_alt', $filename);
			 				$setImage->execute();	
		 				}
 					}
 				}
 			}
 		}

				

	//генерирует ЧПУ
	public function generate_chpu($str){
		if(!empty($str)){
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

    }

    //передаем ссылки и получаем взамен имя картинки и ее расширение
    public function setImageName($home="",$url){

    	if(!empty($url)){
    		$path_parts = pathinfo($home.$url);
  	  		return htmlentities($path_parts['filename']).".".$path_parts['extension'];
    	}else{
    		return false;
    	}
    }

    //удаляем кэш
	public function clearCache(){
 		$clearCache_category = "DELETE FROM  cache_category";
	 	DB::run($clearCache_category);
	 		 
	   	$clearCache_pagination = "DELETE FROM cache_pagination";
	 	DB::run($clearCache_pagination);

	 	$clearCache_products = "DELETE FROM cache_products";
	 	DB::run($clearCache_products);
  	}
 
}


abstract class BuilderParser{
	protected $_parser;

	public function getParserData(){
		return $this->_parser;
	}

	public function createParser(){
		  $this->_parser = new Parser;
	}

 	abstract public function buildCategory();
	abstract public function buildPagination();
	abstract public function buildProduct();
}

class BuilderBikeland extends BuilderParser{
	//временное хранилище
	public $cache = [];

	//главная страница
	public $home = "https://bikeland.ru";

	//Наследуем абстрактный  метод по созданию категорий
	public function buildCategory(){

		/*

		//получаем родиельские категории на главной странице
		$this->getParentsCategoryBikeland();

		//добавляем дочерние категории в базу
		$this->setDaughterCategoryBikeland();

		//получаем дочерние категории для создания пагинации
		$this->getDaughterCategoryBikeland();

		*/
		return true;
 	}

 	//Наследуем абстрактный  метод по созданию ссылок пагинации
 	public function buildPagination(){

 		/*
 		//создаем ссылки на пагинации в дочерних категориях
 		$this->setPaginationInfo();
 		*/

 		return true;
 	}

 	//Наследуем абстрактный  метод по созданию товара
 	public function buildProduct(){
 		//по ссылкам с пагинации заносим html и название товара в базу
		//$this->getInfoCacheProducts();
 	
 		//получаем данные с базы, парсим и заносим всю инфу для создания товара
 		$this->setProductInfo();
 		
 		return true;
 	}
 
	//добавляем родительские категории в базу
	public function getParentsCategoryBikeland(){
 	  $html = str_get_html($this->_parser->curl_get($this->home));
	  $data = [];
	 
	  if($html->innertext!='' and !empty($html->find('.catalogfirst a.icons_fa'))){
	    foreach($html->find('.catalogfirst a.icons_fa') as $a){
	    	$data[] = [
	    		'name'			=>	$a->plaintext,
	    		'parent_url'	=>	$this->home.$a->href,
 	    	];
 		}
	  }
 	  
 	  //подчищаем за собой
	  $html->clear();
	  unset($html);

	  //заносим в базу название родительской категории
	  $parents_id = $this->_parser->setCategoryInfo($data);

 	  return $this->cache = $parents_id;
 	}


	//заносим в базу дочерние категории $parents_id, $parent_url
	public function setDaughterCategoryBikeland(){
 	  
 	  $mas = $this->cache;
 	  unset($this->cache);

 	  $dat = [];
 	  foreach($mas as $data){
 	  	if(!empty($data['id'])){
 				$html = str_get_html($this->_parser->curl_get($data['parent_url']));
 				//проверяем существует ли дочерние категории на странице
		        if($html->innertext!='' and !empty($html->find('.catalog_section_list .section_info li.name a'))){
				    foreach($html->find('.catalog_section_list .section_info li.name a') as $a){
				         $dat[] = [
				         	'id'		=>	$data['id'],
				         	'name'		=>	$a->plaintext,
				         	'url'		=>	$this->home.$a->href,

				         ];
 					}

			      	//подчищаем за собой
				  	$html->clear();
				  	unset($html);
		 		}else{
		 			break;
		 		}
 			}
	  	}

	  	if(!empty($dat)){
	  		$this->_parser->setCategoryInfo($dat);
	  	}else{
	  		return false;
	  	}
		
 
 	}

 	//проверяем существуют ли категории в дочерних категориях
	public function getDaughterCategoryBikeland(){

		//с базы получаем данные id родительской категории и ссылку на дочерню категорию
		$stmt = 'SELECT category_id,url FROM cache_category';

		$stmt = DB::run($stmt);

		//в этот массив заносим category_id,url
 		$dauth = [];

		foreach($stmt as $data){
		 
			//заносим в переменную инфу о том есть ли дочерние категории в текущей категории
			$dauth[] = [
 				'id'			=>	$data['category_id'],
				'parent_url'	=>	$data['url'],
			];
 		}

 		//данные которые получили с базы отправляем повторно для того что бы опеределить если ли еще дочерние категории
 		$this->cache = $dauth;
 		$this->setDaughterCategoryBikeland();

  		return true;
	}

	//в базу заносим ссылки на список товара категории (ссылки пагинации) 
	public function setPaginationInfo(){

		//с базы получаем данные id родительской категории и ссылку на дочерню категорию
		$stmt = 'SELECT parent_id,category_id,url FROM cache_category';

		$stmt = DB::run($stmt);
 
 		foreach($stmt as $data){
 
	 		$this->recur($data['parent_id'],$data['category_id'],$data['url']);
 		}
 
 		return true;
	}

	//рекурсия (заносим ссылки на каждую страницу пагинации категории)
	public function recur($parent_id,$category_id,$url){
		//делаем проверку данных, что бы не были пустыми
		if(!empty($url)){
			$html = str_get_html($this->_parser->curl_get($url));
	 		$n = $html->find('.flex-nav-next  a');
			$prev = $html->find('.flex-nav-prev  a');
			$next = $this->home.$n[0]->href;

			$html->clear();
	  		unset($html);

			//начиная с первой страницы заносим ее в базу
			if(empty($prev)){
				/*Заносим введеные данные в базу*/
				$this->_parser->setPaginationUrl($parent_id,$category_id,$url);
	 		}

			//если находим ссылку в пагинации на слудющую страницу то заносим ее в базу
			if(!empty($n)){

				/*Заносим введеные данные в базу*/
				$this->_parser->setPaginationUrl($parent_id,$category_id,$next);

				//и так делаем в рекурсии пока есть ссылки в пагинации next    
	  			$this->recur($parent_id,$category_id,$next);
	 		}else{

				return true;
			}
	    }
	}

	//получаем с базы всю нужную информацию для создания кэша продутка
	public function getInfoCacheProducts(){

		//с базы получаем данные id родительской категории, id дочерний категори, url
		$stmt = 'SELECT parent_id,category_id,url FROM cache_pagination';

		$stmt = DB::run($stmt);
		$cache_productsInfo = [];
		$mas = [];


		//формируем массив для получения ссылки на каждый товар
		foreach($stmt as $d){
		$html = str_get_html($this->_parser->curl_get($d['url']));
			if($html->innertext!='' and !empty($html->find('.item-title a'))){
			    foreach($html->find('.item-title a') as $a){
			    	$cache_productsInfo[] = [
			    		'name'			=> htmlentities($a->plaintext),
			    		'html'			=> $this->_parser->curl_get($this->home.$a->href),
			    		'parent_id' 	=> $d['parent_id'],
	  					'category_id' 	=> $d['category_id'],
			    	];
			    }
			}
	  	}
	   

	  	$html->clear();
	  	unset($html);
 
	  	//проверяем создался ли массив
	  	if(!empty($cache_productsInfo)){
	  		 $this->_parser->setCacheHtmlProducts($cache_productsInfo);
	  	}else{
	  		return false;
	  	}
	  	 
 		return true;

    }

    //функция которая получает с базы кэш продукта парсит его и отправляет на добавление в базу товара
    public function setProductInfo(){
    			
    			
    			#TODO и еще нужно разобраться со всяким бредом типа размер, цвет и все подобное +  после один массив передать на добавление в базу, а второй массив передать в цыкл на скачивание картинок в папку
 

 		//с базы получаем данные для парсинга и добавление товара в базу
		$stmt = 'SELECT parent_id,category_id,name,html FROM cache_products';
 		$stmt = DB::run($stmt);	
 		
 		//формируем массив данных с базы
 		$mas = [];
 		foreach($stmt as $data){
 			$mas[] = [
 				"parent_category_id"	=>	$data['parent_id'],
 				"category_id"			=>	$data['category_id'],
 				"name"					=>	$data['name'],
 				"html"					=>	$data['html'],

 			];
 		}

 		//формируем массив для создания товара
 		$products = [];
 		$images = [];
  		foreach($mas as $data){
 			$html = str_get_html($data['html']);
 			$price = (!empty($html->find('.price span.price_value'))) ? 
 						trim($html->find('.price span.price_value')[0]->plaintext) : 0;
 			$article = (!empty($html->find('.article span.value'))) ? 
 						trim($html->find('.article span.value',0)->plaintext) : "";

 			$desc = (!empty($html->find('.tabs-body .detail_text'))) ? 
 						trim($html->find('.tabs-body .detail_text')[0]->plaintext) : "";

 			$characts = (!empty($html->find('.tabs_content .props_list',0))) ? 
 						trim($html->find('.tabs_content .props_list',0)->innertext) : "";

 			$charact = "<table><tbody>".$characts."</table></tbody>";
 			$filename = (!empty($html->find('.item_slider ul.slides a'))) ? $html->find('.item_slider ul.slides a') : "";												

 			$products[] = [
 			"parent_category_id"	=>	$data['parent_category_id'],
 			"category_id"			=>	$data['category_id'],
 			"name"					=>	trim($data['name']),
 			"price"					=>  str_replace(" ","",$price),
 			"sku"					=>	$article,
 			"desc"					=>	$desc,
 			"charact"				=>	(!empty($characts)) ? $charact : "",
 			"image"					=>	$filename,
 			];

 			//получаем ссылку на картинку(для загрузки) и имя картинки
 			foreach ($filename as $a){
 				$images[] = [
 				"name" 	=> $this->_parser->setImageName($this->home,$a->href),
 				"url" 	=> $this->home.$a->href,
 				];
 			}
 		}

 		//создаем товар
 		$this->_parser->createProduct($products);

 		/*
 
 
		#TODO создать функцию по скачиванию картинок + надо разобраться что такое object_id

		$path_parts = pathinfo('https://bikeland.ru/upload/iblock/cbe/cbe0e7514a62f79033a13e80889fc272.jpg');
 
		echo $path_parts['extension'], "\n";
		echo $path_parts['filename'], "\n"; // начиная с PHP 5.2.0
		*/


 		

 		 //var_dump($products);	


    }

    


 
 










/*END CLASS*/
}

/*
class BuilderDrivebike extends BuilderParser{

	
}
*/

class Chooser{
  	private $_builderParser;
 
    public function setBuilderParser(BuilderParser $mp){
         $this->_builderParser = $mp;
    }
 
    public function getParserData(){
         return $this->_builderParser->getParserData();
    }
 
    public function constructParser(){
         $this->_builderParser->createParser();
         $this->_builderParser->buildCategory();
         $this->_builderParser->buildPagination();
         $this->_builderParser->buildProduct();
  	}
}
